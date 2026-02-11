package unluac.semantic;

import java.io.File;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CodingErrorAction;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import unluac.chunk.Lua50ChunkParser;
import unluac.chunk.LuaChunk;

/**
 * Phase2 的统一抽取入口：将原始 Luc/Lua 脚本转换为可入库的语义 JSON。
 *
 * <p>所属链路：链路 A（luc -> 读取 -> semantic -> 写入 MySQL）。</p>
 * <p>输入：quest.luc、npc-lua-generated 目录。</p>
 * <p>输出：phase2_quest_data.json、phase2_npc_reference_index.json、phase2_scan_summary.json。</p>
 * <p>数据库副作用：无（仅扫描与落盘报告）。</p>
 * <p>文件副作用：会创建/覆盖 reports 下的 phase2 报告文件。</p>
 * <p>阶段依赖：作为 Phase2.5/3 的前置数据源。</p>
 */
public class Phase2LucDataExtractionSystem {

  private static final Charset UTF8 = Charset.forName("UTF-8");

  /**
   * CLI 入口。
   *
   * @param args 参数顺序：questLuc、npcDir、questOut、npcOut、summaryOut
   * @throws Exception 任一步骤（读取、解析、写文件）失败时抛出
   * @implNote 副作用：读取脚本文件并写出 3 份 phase2 报告
   */
  public static void main(String[] args) throws Exception {
    Path questLuc = args.length >= 1
        ? Paths.get(args[0])
        : Paths.get("D:/TitanGames/GhostOnline/zChina/Script/quest.luc");
    Path npcDir = args.length >= 2
        ? Paths.get(args[1])
        : Paths.get("D:/TitanGames/GhostOnline/zChina/Script/npc-lua-generated");

    Path questOut = args.length >= 3
        ? Paths.get(args[2])
        : Paths.get("reports", "phase2_quest_data.json");
    Path npcOut = args.length >= 4
        ? Paths.get(args[3])
        : Paths.get("reports", "phase2_npc_reference_index.json");
    Path summaryOut = args.length >= 5
        ? Paths.get(args[4])
        : Paths.get("reports", "phase2_scan_summary.json");

    Phase2LucDataExtractionSystem runner = new Phase2LucDataExtractionSystem();
    Phase2Result result = runner.run(questLuc, npcDir, questOut, npcOut, summaryOut);

    System.out.println("questLuc=" + questLuc.toAbsolutePath());
    System.out.println("npcDir=" + npcDir.toAbsolutePath());
    System.out.println("questReport=" + questOut.toAbsolutePath());
    System.out.println("npcReport=" + npcOut.toAbsolutePath());
    System.out.println("summaryReport=" + summaryOut.toAbsolutePath());
    System.out.println("totalFilesScanned=" + result.summary.totalFilesScanned);
    System.out.println("npcFileCount=" + result.summary.totalNpcFilesScanned);
    System.out.println("questFileDetected=" + result.summary.questFileDetected);
    System.out.println("totalQuestCount=" + result.questData.totalQuestCount);
    System.out.println("totalQuestReferences=" + result.npcIndex.totalQuestReferences);
    System.out.println("totalGoalIndexedAccess=" + result.summary.totalGoalIndexedAccessDetected);
  }

  /**
   * 执行完整 Phase2 流程并返回内存结果。
   *
   * @param questLuc quest.luc 路径
   * @param npcDir npc-lua-generated 目录
   * @param questOut quest 抽取报告输出路径
   * @param npcOut npc 引用索引报告输出路径
   * @param summaryOut 扫描汇总报告输出路径
   * @return Phase2 运行结果（包含 quest 报告、npc 索引、汇总）
   * @throws Exception 输入缺失、解析失败或写文件失败时抛出
   * @implNote 副作用：创建/覆盖输出 JSON 文件；不写数据库
   */
  public Phase2Result run(Path questLuc,
                          Path npcDir,
                          Path questOut,
                          Path npcOut,
                          Path summaryOut) throws Exception {
    if(questLuc == null || !Files.exists(questLuc) || !Files.isRegularFile(questLuc)) {
      throw new IllegalStateException("quest.luc not found: " + questLuc);
    }
    if(npcDir == null || !Files.exists(npcDir) || !Files.isDirectory(npcDir)) {
      throw new IllegalStateException("npc dir not found: " + npcDir);
    }

    Phase2Result out = new Phase2Result();
    // 先抽 quest，再扫 npc：保证后续统计口径按“任务主数据 -> NPC 依赖”顺序对齐。
    out.questData = extractQuestData(questLuc);
    out.npcIndex = scanNpcReferences(npcDir, out.summary);

    out.summary.totalFilesScanned = out.summary.totalNpcFilesScanned + (out.summary.questFileDetected ? 1 : 0);
    out.summary.totalQuestReferencesDetected = out.npcIndex.totalQuestReferences;
    out.summary.totalGoalIndexedAccessDetected = out.npcIndex.totalGoalIndexedAccess;

    ensureParent(questOut);
    ensureParent(npcOut);
    ensureParent(summaryOut);

    // 统一汇总写出，避免只写部分报告导致 Phase2.5/Phase3 消费不一致。
    writeQuestReport(questOut, out.questData);
    writeNpcReport(npcOut, out.npcIndex);
    writeSummaryReport(summaryOut, out.summary);
    return out;
  }

  private QuestDataReport extractQuestData(Path questLuc) throws Exception {
    QuestDataReport report = new QuestDataReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    report.sourceQuestLuc = questLuc.toAbsolutePath().toString();

    byte[] data = Files.readAllBytes(questLuc);
    LuaChunk chunk = new Lua50ChunkParser().parse(data);
    QuestSemanticExtractor extractor = new QuestSemanticExtractor();
    QuestSemanticExtractor.ExtractionResult extraction = extractor.extract(chunk);

    Map<Integer, DialogArrays> dialogByQuest = collectDialogArrays(extraction.fieldBindings);
    Map<Integer, Integer> bQLoopByQuest = collectIntField(extraction.fieldBindings, "condition_json.bQLoop");

    for(QuestSemanticModel model : extraction.quests) {
      if(model == null || model.questId <= 0) {
        continue;
      }

      QuestRecord record = new QuestRecord();
      record.questId = model.questId;
      record.name = safe(model.title);

      DialogArrays arrays = dialogByQuest.get(Integer.valueOf(model.questId));
      if(arrays != null) {
        record.contents.addAll(arrays.contents);
        record.answer.addAll(arrays.answer);
        record.info.addAll(arrays.info);
      }

      if(record.contents.isEmpty() && model.description != null && !model.description.trim().isEmpty()) {
        record.contents.add(model.description);
      }

      record.needLevel = model.goal == null ? 0 : model.goal.needLevel;
      Integer bq = bQLoopByQuest.get(Integer.valueOf(model.questId));
      record.bQLoop = bq == null ? 0 : bq.intValue();

      fillGoal(record, model);
      fillReward(record, model);
      report.quests.add(record);
    }

    Collections.sort(report.quests, Comparator.comparingInt(q -> q.questId));
    report.totalQuestCount = report.quests.size();
    return report;
  }

  private Map<Integer, DialogArrays> collectDialogArrays(List<QuestSemanticExtractor.FieldBinding> bindings) {
    Map<Integer, DialogArrays> out = new LinkedHashMap<Integer, DialogArrays>();
    if(bindings == null) {
      return out;
    }

    for(QuestSemanticExtractor.FieldBinding binding : bindings) {
      if(binding == null || !"string".equals(binding.valueType)) {
        continue;
      }
      if(binding.fieldKey == null || !binding.fieldKey.startsWith("dialog_lines_json[")) {
        continue;
      }

      int close = binding.fieldKey.indexOf(']');
      if(close < 0 || close + 2 > binding.fieldKey.length()) {
        continue;
      }
      if(binding.fieldKey.charAt(close + 1) != '.') {
        continue;
      }
      String field = binding.fieldKey.substring(close + 2);
      if(!"contents".equals(field) && !"answer".equals(field) && !"info".equals(field)) {
        continue;
      }

      DialogArrays arrays = out.get(Integer.valueOf(binding.questId));
      if(arrays == null) {
        arrays = new DialogArrays();
        out.put(Integer.valueOf(binding.questId), arrays);
      }
      if("contents".equals(field)) {
        arrays.contents.add(safe(binding.stringValue));
      } else if("answer".equals(field)) {
        arrays.answer.add(safe(binding.stringValue));
      } else if("info".equals(field)) {
        arrays.info.add(safe(binding.stringValue));
      }
    }
    return out;
  }

  private Map<Integer, Integer> collectIntField(List<QuestSemanticExtractor.FieldBinding> bindings,
                                                String fieldKey) {
    Map<Integer, Integer> out = new LinkedHashMap<Integer, Integer>();
    if(bindings == null) {
      return out;
    }
    for(QuestSemanticExtractor.FieldBinding binding : bindings) {
      if(binding == null || binding.fieldKey == null) {
        continue;
      }
      if(!fieldKey.equals(binding.fieldKey)) {
        continue;
      }
      if(!"number".equals(binding.valueType) || binding.numberValue == null) {
        continue;
      }
      out.put(Integer.valueOf(binding.questId), Integer.valueOf(binding.numberValue.intValue()));
    }
    return out;
  }

  private void fillGoal(QuestRecord record, QuestSemanticModel model) {
    if(record == null || model == null) {
      return;
    }
    if(model.goal != null) {
      for(ItemRequirement item : model.goal.items) {
        if(item == null) {
          continue;
        }
        GoalItem gi = new GoalItem();
        gi.id = item.itemId;
        gi.count = item.itemCount;
        record.goal.getItem.add(gi);
      }
      for(KillRequirement kill : model.goal.monsters) {
        if(kill == null) {
          continue;
        }
        GoalKill gk = new GoalKill();
        gk.id = kill.monsterId;
        gk.count = kill.killCount;
        record.goal.killMonster.add(gk);
      }
    }

    Object goalObj = model.completionConditions.get("goal");
    if(goalObj instanceof Map<?, ?>) {
      @SuppressWarnings("unchecked")
      Map<String, Object> goalMap = (Map<String, Object>) goalObj;
      Object meetNpc = goalMap.get("meetNpc");
      appendMeetNpc(record.goal.meetNpc, meetNpc);
    }
  }

  private void appendMeetNpc(List<Integer> out, Object value) {
    if(value == null || out == null) {
      return;
    }
    if(value instanceof Number) {
      int n = ((Number) value).intValue();
      if(n > 0) {
        out.add(Integer.valueOf(n));
      }
      return;
    }
    if(value instanceof List<?>) {
      @SuppressWarnings("unchecked")
      List<Object> list = (List<Object>) value;
      for(Object item : list) {
        appendMeetNpc(out, item);
      }
      return;
    }
    if(value instanceof Map<?, ?>) {
      @SuppressWarnings("unchecked")
      Map<String, Object> map = (Map<String, Object>) value;
      for(Map.Entry<String, Object> entry : map.entrySet()) {
        appendMeetNpc(out, entry.getValue());
      }
    }
  }

  private void fillReward(QuestRecord record, QuestSemanticModel model) {
    if(record == null || model == null || model.rewards == null) {
      return;
    }
    for(QuestSemanticModel.Reward reward : model.rewards) {
      if(reward == null) {
        continue;
      }
      record.reward.exp += reward.exp;
      record.reward.gold += reward.money;
      if(reward.id > 0 && reward.count > 0) {
        RewardItem item = new RewardItem();
        item.id = reward.id;
        item.count = reward.count;
        record.reward.items.add(item);
      }
    }
  }

  private NpcReferenceReport scanNpcReferences(Path npcDir,
                                               ScanSummary summary) throws Exception {
    NpcReferenceReport report = new NpcReferenceReport();
    report.generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    report.sourceNpcDir = npcDir.toAbsolutePath().toString();

    List<Path> files = new ArrayList<Path>();
    Files.walk(npcDir)
        .filter(Files::isRegularFile)
        .filter(path -> {
          String lower = path.getFileName().toString().toLowerCase(Locale.ROOT);
          return lower.startsWith("npc_") && lower.endsWith(".lua");
        })
        .forEach(files::add);
    Collections.sort(files);

    int expectedFileCount = files.size();
    summary.totalNpcFilesScanned = expectedFileCount;
    report.totalNpcFiles = expectedFileCount;
    if(expectedFileCount <= 0) {
      throw new IllegalStateException("npc file count is 0 in dir: " + npcDir);
    }

    for(Path file : files) {
      String rel = normalizePath(npcDir.relativize(file).toString());
      try {
        scanOneNpcFile(file, rel, report);
      } catch(Exception ex) {
        summary.parsingErrors.add(rel + " => " + ex.getMessage());
      }
    }

    if(report.byNpcFile.size() < expectedFileCount) {
      Set<String> seen = report.byNpcFile.keySet();
      for(Path file : files) {
        String rel = normalizePath(npcDir.relativize(file).toString());
        if(!seen.contains(rel)) {
          summary.missingFiles.add(rel);
        }
      }
      throw new IllegalStateException("npc scan incomplete: scanned=" + report.byNpcFile.size()
          + " expected=" + expectedFileCount);
    }

    report.totalQuestReferences = report.nodeLocations.size();
    report.totalGoalIndexedAccess = 0;
    for(NodeLocation node : report.nodeLocations) {
      if(node != null && node.goalAccess) {
        report.totalGoalIndexedAccess++;
      }
    }
    summary.totalQuestReferencesDetected = report.totalQuestReferences;
    summary.totalGoalIndexedAccessDetected = report.totalGoalIndexedAccess;
    return report;
  }

  private void scanOneNpcFile(Path file,
                              String relativeFile,
                              NpcReferenceReport report) throws Exception {
    byte[] raw = Files.readAllBytes(file);
    DecodedText decoded = decode(raw);
    String text = decoded.text;

    List<Token> tokens = tokenize(text);
    NpcFileRef npcRef = ensureNpcRef(report, relativeFile);

    for(int i = 0; i < tokens.size(); i++) {
      Token token = tokens.get(i);
      if(token.kind != TokenKind.IDENT && token.kind != TokenKind.KEYWORD) {
        continue;
      }

      String ident = token.text;
      if("qt".equals(ident) || "qData".equals(ident)) {
        ParseResult parsed = parsePostfixChain(tokens, i);
        if(parsed == null || parsed.node == null) {
          continue;
        }

        List<IndexAccessNode> indexNodes = new ArrayList<IndexAccessNode>();
        collectIndexNodes(parsed.node, indexNodes);
        for(IndexAccessNode idx : indexNodes) {
          QuestRefMatch qr = matchQuestReference(idx, ident);
          if(qr == null) {
            continue;
          }
          addNodeLocation(report, npcRef, relativeFile, text, idx, qr.questId, qr.accessType, qr.index, qr.goalAccess);
        }
        continue;
      }

      if("SET_QUEST_STATE".equals(ident) || "CHECK_QUEST_STATE".equals(ident)) {
        ParseResult parsed = parsePostfixChain(tokens, i);
        if(parsed == null || !(parsed.node instanceof CallNode)) {
          continue;
        }
        CallNode call = (CallNode) parsed.node;
        if(call.arguments.isEmpty()) {
          continue;
        }
        ExprNode arg0 = unwrapParen(call.arguments.get(0));
        if(!(arg0 instanceof NumberNode)) {
          continue;
        }
        int questId = parseIntSafe(((NumberNode) arg0).text);
        if(questId <= 0) {
          continue;
        }
        addNodeLocation(report, npcRef, relativeFile, text, call, questId,
            "CALL_" + ident, -1, false);
      }
    }
  }

  private QuestRefMatch matchQuestReference(IndexAccessNode idx,
                                            String rootName) {
    if(idx == null || !(unwrapParen(idx.indexExpr) instanceof NumberNode)) {
      return null;
    }

    QuestRefMatch goalIndexed = matchGoalIndexedAccess(idx);
    if(goalIndexed != null) {
      return goalIndexed;
    }

    ExprNode base = unwrapParen(idx.base);
    if(!(base instanceof NameNode)) {
      return null;
    }
    NameNode name = (NameNode) base;
    if(!rootName.equals(name.name)) {
      return null;
    }
    int questId = parseIntSafe(((NumberNode) unwrapParen(idx.indexExpr)).text);
    if(questId <= 0) {
      return null;
    }

    QuestRefMatch out = new QuestRefMatch();
    out.questId = questId;
    out.index = -1;
    out.goalAccess = false;
    out.accessType = rootName;
    return out;
  }

  private QuestRefMatch matchGoalIndexedAccess(IndexAccessNode idx) {
    ExprNode indexExpr = unwrapParen(idx.indexExpr);
    if(!(indexExpr instanceof NumberNode)) {
      return null;
    }

    ExprNode tableExpr = unwrapParen(idx.base);
    if(!(tableExpr instanceof FieldAccessNode)) {
      return null;
    }

    FieldAccessNode targetField = (FieldAccessNode) tableExpr;
    String accessType = targetField.field;
    if(!"getItem".equals(accessType) && !"killMonster".equals(accessType) && !"meetNpc".equals(accessType)) {
      return null;
    }

    ExprNode goalExpr = unwrapParen(targetField.base);
    if(!(goalExpr instanceof FieldAccessNode)) {
      return null;
    }

    FieldAccessNode goalField = (FieldAccessNode) goalExpr;
    if(!"goal".equals(goalField.field)) {
      return null;
    }

    ExprNode qtIndexExpr = unwrapParen(goalField.base);
    if(!(qtIndexExpr instanceof IndexAccessNode)) {
      return null;
    }

    IndexAccessNode qtIndex = (IndexAccessNode) qtIndexExpr;
    ExprNode qtBase = unwrapParen(qtIndex.base);
    ExprNode questExpr = unwrapParen(qtIndex.indexExpr);
    if(!(qtBase instanceof NameNode) || !(questExpr instanceof NumberNode)) {
      return null;
    }
    if(!"qt".equals(((NameNode) qtBase).name)) {
      return null;
    }

    int questId = parseIntSafe(((NumberNode) questExpr).text);
    int index = parseIntSafe(((NumberNode) indexExpr).text);
    if(questId <= 0 || index <= 0) {
      return null;
    }

    QuestRefMatch out = new QuestRefMatch();
    out.questId = questId;
    out.index = index;
    out.goalAccess = true;
    out.accessType = "goal." + accessType;
    return out;
  }

  private void addNodeLocation(NpcReferenceReport report,
                               NpcFileRef npcRef,
                               String relativeFile,
                               String text,
                               ExprNode node,
                               int questId,
                               String accessType,
                               int index,
                               boolean goalAccess) {
    if(questId <= 0 || node == null) {
      return;
    }

    npcRef.referenceCount++;
    if(goalAccess) {
      npcRef.goalAccessCount++;
    }
    npcRef.referencedQuestIds.add(Integer.valueOf(questId));

    QuestRef questRef = ensureQuestRef(report, questId);
    questRef.referenceCount++;
    if(goalAccess) {
      questRef.goalAccessCount++;
    }
    questRef.npcFiles.add(relativeFile);

    NodeLocation location = new NodeLocation();
    location.questId = questId;
    location.npcFile = relativeFile;
    location.accessType = accessType;
    location.index = index;
    location.line = node.line;
    location.column = node.column;
    location.goalAccess = goalAccess;
    location.fullExpressionText = safeSlice(text, node.startOffset, node.endOffset);
    report.nodeLocations.add(location);
  }

  private NpcFileRef ensureNpcRef(NpcReferenceReport report,
                                  String relativeFile) {
    NpcFileRef ref = report.byNpcFile.get(relativeFile);
    if(ref == null) {
      ref = new NpcFileRef();
      report.byNpcFile.put(relativeFile, ref);
    }
    return ref;
  }

  private QuestRef ensureQuestRef(NpcReferenceReport report,
                                  int questId) {
    String key = Integer.toString(questId);
    QuestRef ref = report.byQuestId.get(key);
    if(ref == null) {
      ref = new QuestRef();
      report.byQuestId.put(key, ref);
    }
    return ref;
  }

  private String safeSlice(String text, int startOffset, int endOffset) {
    if(text == null || text.isEmpty()) {
      return "";
    }
    int start = Math.max(0, Math.min(startOffset, text.length()));
    int end = Math.max(start, Math.min(endOffset, text.length()));
    return text.substring(start, end);
  }

  private ParseResult parsePostfixChain(List<Token> tokens, int startIndex) {
    if(startIndex < 0 || startIndex >= tokens.size()) {
      return null;
    }
    Token first = tokens.get(startIndex);
    if(first.kind != TokenKind.IDENT && first.kind != TokenKind.KEYWORD) {
      return null;
    }

    ExprNode current = new NameNode(first.text, first.startOffset, first.endOffset, first.line, first.column);
    int index = startIndex + 1;
    while(index < tokens.size()) {
      Token token = tokens.get(index);
      if(token.isSymbol(".")) {
        if(index + 1 >= tokens.size()) {
          break;
        }
        Token name = tokens.get(index + 1);
        if(name.kind != TokenKind.IDENT && name.kind != TokenKind.KEYWORD) {
          break;
        }
        current = new FieldAccessNode(current, name.text, current.startOffset, name.endOffset, current.line, current.column);
        index += 2;
        continue;
      }

      if(token.isSymbol("[")) {
        int close = findMatching(tokens, index, "[", "]");
        if(close < 0) {
          break;
        }
        ExprNode indexExpr = parseExpressionSlice(tokens, index + 1, close);
        Token closeToken = tokens.get(close);
        current = new IndexAccessNode(current, indexExpr, current.startOffset, closeToken.endOffset, current.line, current.column);
        index = close + 1;
        continue;
      }

      if(token.isSymbol("(")) {
        int close = findMatching(tokens, index, "(", ")");
        if(close < 0) {
          break;
        }
        List<ExprNode> args = parseArgs(tokens, index + 1, close);
        Token closeToken = tokens.get(close);
        current = new CallNode(current, args, current.startOffset, closeToken.endOffset, current.line, current.column);
        index = close + 1;
        continue;
      }

      break;
    }

    ParseResult out = new ParseResult();
    out.node = current;
    out.nextIndex = index;
    return out;
  }

  private List<ExprNode> parseArgs(List<Token> tokens, int start, int endExclusive) {
    List<ExprNode> args = new ArrayList<ExprNode>();
    int cursor = start;
    int depthParen = 0;
    int depthBracket = 0;
    int depthBrace = 0;
    int argStart = start;
    while(cursor < endExclusive) {
      Token t = tokens.get(cursor);
      if(t.isSymbol("(")) depthParen++;
      else if(t.isSymbol(")")) depthParen--;
      else if(t.isSymbol("[")) depthBracket++;
      else if(t.isSymbol("]")) depthBracket--;
      else if(t.isSymbol("{")) depthBrace++;
      else if(t.isSymbol("}")) depthBrace--;

      if(depthParen == 0 && depthBracket == 0 && depthBrace == 0 && t.isSymbol(",")) {
        args.add(parseExpressionSlice(tokens, argStart, cursor));
        argStart = cursor + 1;
      }
      cursor++;
    }
    if(argStart < endExclusive) {
      args.add(parseExpressionSlice(tokens, argStart, endExclusive));
    }
    return args;
  }

  private ExprNode parseExpressionSlice(List<Token> tokens, int start, int endExclusive) {
    if(start >= endExclusive) {
      return new RawNode("", 0, 0, 1, 1);
    }
    ExpressionParser parser = new ExpressionParser(tokens, start, endExclusive);
    ExprNode parsed = parser.parseExpression();
    if(parsed == null || !parser.isAtEnd()) {
      Token s = tokens.get(start);
      Token e = tokens.get(endExclusive - 1);
      return new RawNode(joinTokenText(tokens, start, endExclusive), s.startOffset, e.endOffset, s.line, s.column);
    }
    return parsed;
  }

  private int findMatching(List<Token> tokens, int openIndex, String open, String close) {
    int depth = 0;
    for(int i = openIndex; i < tokens.size(); i++) {
      Token t = tokens.get(i);
      if(t.isSymbol(open)) {
        depth++;
      } else if(t.isSymbol(close)) {
        depth--;
        if(depth == 0) {
          return i;
        }
      }
    }
    return -1;
  }

  private String joinTokenText(List<Token> tokens, int start, int endExclusive) {
    StringBuilder sb = new StringBuilder();
    for(int i = start; i < endExclusive; i++) {
      if(i > start) {
        sb.append(' ');
      }
      sb.append(tokens.get(i).text);
    }
    return sb.toString();
  }

  private void collectIndexNodes(ExprNode node, List<IndexAccessNode> out) {
    if(node == null) {
      return;
    }
    if(node instanceof IndexAccessNode) {
      out.add((IndexAccessNode) node);
      IndexAccessNode idx = (IndexAccessNode) node;
      collectIndexNodes(idx.base, out);
      collectIndexNodes(idx.indexExpr, out);
      return;
    }
    if(node instanceof FieldAccessNode) {
      collectIndexNodes(((FieldAccessNode) node).base, out);
      return;
    }
    if(node instanceof CallNode) {
      CallNode call = (CallNode) node;
      collectIndexNodes(call.callee, out);
      for(ExprNode arg : call.arguments) {
        collectIndexNodes(arg, out);
      }
      return;
    }
    if(node instanceof BinaryNode) {
      collectIndexNodes(((BinaryNode) node).left, out);
      collectIndexNodes(((BinaryNode) node).right, out);
      return;
    }
    if(node instanceof UnaryNode) {
      collectIndexNodes(((UnaryNode) node).expr, out);
      return;
    }
    if(node instanceof ParenNode) {
      collectIndexNodes(((ParenNode) node).inner, out);
    }
  }

  private ExprNode unwrapParen(ExprNode node) {
    ExprNode current = node;
    while(current instanceof ParenNode) {
      current = ((ParenNode) current).inner;
    }
    return current;
  }

  private List<Token> tokenize(String text) {
    List<Token> tokens = new ArrayList<Token>();
    int index = 0;
    int line = 1;
    int column = 1;

    while(index < text.length()) {
      char ch = text.charAt(index);
      if(ch == ' ' || ch == '\t' || ch == '\f') {
        index++;
        column++;
        continue;
      }
      if(ch == '\r' || ch == '\n') {
        int[] moved = moveLine(text, index, line, column);
        index = moved[0];
        line = moved[1];
        column = moved[2];
        continue;
      }

      if(ch == '-' && index + 1 < text.length() && text.charAt(index + 1) == '-') {
        int longEq = longBracketEquals(text, index + 2);
        if(longEq >= 0) {
          int[] moved = skipLongBracket(text, index + 2, line, column, longEq);
          index = moved[0];
          line = moved[1];
          column = moved[2];
        } else {
          while(index < text.length() && text.charAt(index) != '\r' && text.charAt(index) != '\n') {
            index++;
            column++;
          }
        }
        continue;
      }

      int tokenLine = line;
      int tokenColumn = column;
      int startOffset = index;

      if(ch == '\'' || ch == '"') {
        int[] moved = consumeQuotedString(text, index, line, column, ch);
        index = moved[0];
        line = moved[1];
        column = moved[2];
        tokens.add(new Token(TokenKind.STRING, text.substring(startOffset, index), startOffset, index, tokenLine, tokenColumn));
        continue;
      }

      int longEq = longBracketEquals(text, index);
      if(longEq >= 0) {
        int[] moved = skipLongBracket(text, index, line, column, longEq);
        index = moved[0];
        line = moved[1];
        column = moved[2];
        tokens.add(new Token(TokenKind.STRING, text.substring(startOffset, index), startOffset, index, tokenLine, tokenColumn));
        continue;
      }

      if(isIdentifierStart(ch)) {
        index++;
        column++;
        while(index < text.length() && isIdentifierPart(text.charAt(index))) {
          index++;
          column++;
        }
        String ident = text.substring(startOffset, index);
        TokenKind kind = isKeyword(ident) ? TokenKind.KEYWORD : TokenKind.IDENT;
        tokens.add(new Token(kind, ident, startOffset, index, tokenLine, tokenColumn));
        continue;
      }

      if(Character.isDigit(ch)) {
        while(index < text.length() && Character.isDigit(text.charAt(index))) {
          index++;
          column++;
        }
        if(index + 1 < text.length() && text.charAt(index) == '.' && Character.isDigit(text.charAt(index + 1))) {
          index += 2;
          column += 2;
          while(index < text.length() && Character.isDigit(text.charAt(index))) {
            index++;
            column++;
          }
        }
        tokens.add(new Token(TokenKind.NUMBER, text.substring(startOffset, index), startOffset, index, tokenLine, tokenColumn));
        continue;
      }

      String two = index + 1 < text.length() ? text.substring(index, index + 2) : "";
      if(">=".equals(two) || "<=".equals(two) || "==".equals(two) || "~=".equals(two) || "..".equals(two)) {
        tokens.add(new Token(TokenKind.SYMBOL, two, startOffset, startOffset + 2, tokenLine, tokenColumn));
        index += 2;
        column += 2;
        continue;
      }

      tokens.add(new Token(TokenKind.SYMBOL, String.valueOf(ch), startOffset, startOffset + 1, tokenLine, tokenColumn));
      index++;
      column++;
    }

    return tokens;
  }

  private boolean isIdentifierStart(char ch) {
    return ch == '_' || Character.isLetter(ch);
  }

  private boolean isIdentifierPart(char ch) {
    return ch == '_' || Character.isLetterOrDigit(ch);
  }

  private boolean isKeyword(String ident) {
    if(ident == null) {
      return false;
    }
    return "if".equals(ident)
        || "then".equals(ident)
        || "elseif".equals(ident)
        || "else".equals(ident)
        || "end".equals(ident)
        || "and".equals(ident)
        || "or".equals(ident)
        || "not".equals(ident)
        || "true".equals(ident)
        || "false".equals(ident)
        || "nil".equals(ident)
        || "function".equals(ident)
        || "local".equals(ident)
        || "return".equals(ident);
  }

  private int[] moveLine(String text, int index, int line, int column) {
    if(text.charAt(index) == '\r') {
      if(index + 1 < text.length() && text.charAt(index + 1) == '\n') {
        return new int[] {index + 2, line + 1, 1};
      }
      return new int[] {index + 1, line + 1, 1};
    }
    return new int[] {index + 1, line + 1, 1};
  }

  private int[] consumeQuotedString(String text, int index, int line, int column, char quote) {
    index++;
    column++;
    while(index < text.length()) {
      char ch = text.charAt(index);
      if(ch == '\\') {
        if(index + 1 < text.length()) {
          if(text.charAt(index + 1) == '\r' || text.charAt(index + 1) == '\n') {
            int[] moved = moveLine(text, index + 1, line, column + 1);
            index = moved[0];
            line = moved[1];
            column = moved[2];
          } else {
            index += 2;
            column += 2;
          }
          continue;
        }
        index++;
        column++;
        continue;
      }
      if(ch == quote) {
        index++;
        column++;
        break;
      }
      if(ch == '\r' || ch == '\n') {
        int[] moved = moveLine(text, index, line, column);
        index = moved[0];
        line = moved[1];
        column = moved[2];
      } else {
        index++;
        column++;
      }
    }
    return new int[] {index, line, column};
  }

  private int longBracketEquals(String text, int start) {
    if(start < 0 || start >= text.length() || text.charAt(start) != '[') {
      return -1;
    }
    int index = start + 1;
    int equals = 0;
    while(index < text.length() && text.charAt(index) == '=') {
      equals++;
      index++;
    }
    if(index < text.length() && text.charAt(index) == '[') {
      return equals;
    }
    return -1;
  }

  private int[] skipLongBracket(String text, int start, int line, int column, int equals) {
    int index = start + 2 + equals;
    column += 2 + equals;
    while(index < text.length()) {
      char ch = text.charAt(index);
      if(ch == ']') {
        int cursor = index + 1;
        int matched = 0;
        while(matched < equals && cursor < text.length() && text.charAt(cursor) == '=') {
          matched++;
          cursor++;
        }
        if(matched == equals && cursor < text.length() && text.charAt(cursor) == ']') {
          int consumed = (cursor + 1) - index;
          index = cursor + 1;
          column += consumed;
          return new int[] {index, line, column};
        }
      }

      if(ch == '\r' || ch == '\n') {
        int[] moved = moveLine(text, index, line, column);
        index = moved[0];
        line = moved[1];
        column = moved[2];
      } else {
        index++;
        column++;
      }
    }
    return new int[] {index, line, column};
  }

  private DecodedText decode(byte[] raw) throws Exception {
    byte[] bom = new byte[0];
    byte[] content = raw;
    if(raw.length >= 3 && (raw[0] & 0xFF) == 0xEF && (raw[1] & 0xFF) == 0xBB && (raw[2] & 0xFF) == 0xBF) {
      bom = new byte[] {(byte) 0xEF, (byte) 0xBB, (byte) 0xBF};
      content = new byte[raw.length - 3];
      System.arraycopy(raw, 3, content, 0, content.length);
    }

    Charset[] charsets = new Charset[] {
        Charset.forName("UTF-8"),
        Charset.forName("GB18030"),
        Charset.forName("GBK"),
        Charset.forName("Big5")
    };
    for(Charset charset : charsets) {
      try {
        CharsetDecoder decoder = charset.newDecoder();
        decoder.onMalformedInput(CodingErrorAction.REPORT);
        decoder.onUnmappableCharacter(CodingErrorAction.REPORT);
        CharBuffer chars = decoder.decode(ByteBuffer.wrap(content));
        DecodedText decoded = new DecodedText();
        decoded.charset = charset;
        decoded.bom = bom;
        decoded.text = chars.toString();
        return decoded;
      } catch(CharacterCodingException ignored) {
      }
    }

    DecodedText decoded = new DecodedText();
    decoded.charset = UTF8;
    decoded.bom = bom;
    decoded.text = new String(content, UTF8);
    return decoded;
  }

  private String normalizePath(String path) {
    if(path == null) {
      return "";
    }
    return path.replace('\\', '/').trim();
  }

  private int parseIntSafe(String text) {
    if(text == null) {
      return -1;
    }
    String value = text.trim();
    if(value.isEmpty()) {
      return -1;
    }
    try {
      return Integer.parseInt(value);
    } catch(Exception ex) {
      return -1;
    }
  }

  private void writeQuestReport(Path output, QuestDataReport report) throws Exception {
    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(report.generatedAt)).append(",\n");
    sb.append("  \"sourceQuestLuc\": ").append(QuestSemanticJson.jsonString(report.sourceQuestLuc)).append(",\n");
    sb.append("  \"totalQuestCount\": ").append(report.totalQuestCount).append(",\n");
    sb.append("  \"quests\": [");
    if(!report.quests.isEmpty()) {
      sb.append("\n");
      for(int i = 0; i < report.quests.size(); i++) {
        if(i > 0) sb.append(",\n");
        QuestRecord q = report.quests.get(i);
        sb.append("    {")
            .append("\"questId\": ").append(q.questId).append(", ")
            .append("\"name\": ").append(QuestSemanticJson.jsonString(q.name)).append(", ")
            .append("\"contents\": ").append(QuestSemanticJson.toJsonArrayString(q.contents)).append(", ")
            .append("\"answer\": ").append(QuestSemanticJson.toJsonArrayString(q.answer)).append(", ")
            .append("\"info\": ").append(QuestSemanticJson.toJsonArrayString(q.info)).append(", ")
            .append("\"goal\": ").append(q.goal.toJson()).append(", ")
            .append("\"reward\": ").append(q.reward.toJson()).append(", ")
            .append("\"needLevel\": ").append(q.needLevel).append(", ")
            .append("\"bQLoop\": ").append(q.bQLoop)
            .append("}");
      }
      sb.append("\n  ");
    }
    sb.append("]\n");
    sb.append("}\n");
    Files.write(output, sb.toString().getBytes(UTF8));
  }

  private void writeNpcReport(Path output, NpcReferenceReport report) throws Exception {
    List<Map.Entry<String, QuestRef>> byQuest = new ArrayList<Map.Entry<String, QuestRef>>(report.byQuestId.entrySet());
    Collections.sort(byQuest, Comparator.comparingInt(e -> parseIntSafe(e.getKey())));
    List<Map.Entry<String, NpcFileRef>> byNpc = new ArrayList<Map.Entry<String, NpcFileRef>>(report.byNpcFile.entrySet());
    Collections.sort(byNpc, Comparator.comparing(Map.Entry::getKey, String.CASE_INSENSITIVE_ORDER));

    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(report.generatedAt)).append(",\n");
    sb.append("  \"sourceNpcDir\": ").append(QuestSemanticJson.jsonString(report.sourceNpcDir)).append(",\n");
    sb.append("  \"totalNpcFiles\": ").append(report.totalNpcFiles).append(",\n");
    sb.append("  \"totalQuestReferences\": ").append(report.totalQuestReferences).append(",\n");

    sb.append("  \"byQuestId\": {");
    if(!byQuest.isEmpty()) {
      sb.append("\n");
      for(int i = 0; i < byQuest.size(); i++) {
        if(i > 0) sb.append(",\n");
        Map.Entry<String, QuestRef> e = byQuest.get(i);
        sb.append("    ").append(QuestSemanticJson.jsonString(e.getKey())).append(": ")
            .append(e.getValue().toJson());
      }
      sb.append("\n  ");
    }
    sb.append("},\n");

    sb.append("  \"byNpcFile\": {");
    if(!byNpc.isEmpty()) {
      sb.append("\n");
      for(int i = 0; i < byNpc.size(); i++) {
        if(i > 0) sb.append(",\n");
        Map.Entry<String, NpcFileRef> e = byNpc.get(i);
        sb.append("    ").append(QuestSemanticJson.jsonString(e.getKey())).append(": ")
            .append(e.getValue().toJson());
      }
      sb.append("\n  ");
    }
    sb.append("},\n");

    sb.append("  \"nodeLocations\": [");
    if(!report.nodeLocations.isEmpty()) {
      sb.append("\n");
      for(int i = 0; i < report.nodeLocations.size(); i++) {
        if(i > 0) sb.append(",\n");
        NodeLocation n = report.nodeLocations.get(i);
        sb.append("    {")
            .append("\"questId\": ").append(n.questId).append(", ")
            .append("\"npcFile\": ").append(QuestSemanticJson.jsonString(n.npcFile)).append(", ")
            .append("\"accessType\": ").append(QuestSemanticJson.jsonString(n.accessType)).append(", ")
            .append("\"index\": ").append(n.index).append(", ")
            .append("\"line\": ").append(n.line).append(", ")
            .append("\"column\": ").append(n.column).append(", ")
            .append("\"fullExpressionText\": ").append(QuestSemanticJson.jsonString(n.fullExpressionText))
            .append("}");
      }
      sb.append("\n  ");
    }
    sb.append("]\n");
    sb.append("}\n");

    Files.write(output, sb.toString().getBytes(UTF8));
  }

  private void writeSummaryReport(Path output, ScanSummary summary) throws Exception {
    StringBuilder sb = new StringBuilder();
    sb.append("{\n");
    sb.append("  \"generatedAt\": ").append(QuestSemanticJson.jsonString(summary.generatedAt)).append(",\n");
    sb.append("  \"questFileDetected\": ").append(summary.questFileDetected ? "true" : "false").append(",\n");
    sb.append("  \"totalFilesScanned\": ").append(summary.totalFilesScanned).append(",\n");
    sb.append("  \"totalNpcFilesScanned\": ").append(summary.totalNpcFilesScanned).append(",\n");
    sb.append("  \"totalQuestReferencesDetected\": ").append(summary.totalQuestReferencesDetected).append(",\n");
    sb.append("  \"totalGoalIndexedAccessDetected\": ").append(summary.totalGoalIndexedAccessDetected).append(",\n");
    sb.append("  \"missingFiles\": ").append(QuestSemanticJson.toJsonArrayString(summary.missingFiles)).append(",\n");
    sb.append("  \"parsingErrors\": ").append(QuestSemanticJson.toJsonArrayString(summary.parsingErrors)).append("\n");
    sb.append("}\n");
    Files.write(output, sb.toString().getBytes(UTF8));
  }

  private void ensureParent(Path path) throws Exception {
    if(path.getParent() != null && !Files.exists(path.getParent())) {
      Files.createDirectories(path.getParent());
    }
  }

  private String safe(String text) {
    return text == null ? "" : text;
  }

  private final class ExpressionParser {

    private final List<Token> tokens;
    private final int endExclusive;
    private int index;

    ExpressionParser(List<Token> tokens, int start, int endExclusive) {
      this.tokens = tokens;
      this.index = start;
      this.endExclusive = endExclusive;
    }

    ExprNode parseExpression() {
      if(isAtEnd()) {
        return null;
      }
      return parseOr();
    }

    boolean isAtEnd() {
      return index >= endExclusive;
    }

    private ExprNode parseOr() {
      ExprNode left = parseAnd();
      while(matchKeyword("or")) {
        Token op = previous();
        ExprNode right = parseAnd();
        left = new BinaryNode("or", left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    private ExprNode parseAnd() {
      ExprNode left = parseCompare();
      while(matchKeyword("and")) {
        Token op = previous();
        ExprNode right = parseCompare();
        left = new BinaryNode("and", left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    private ExprNode parseCompare() {
      ExprNode left = parseUnary();
      while(matchSymbol("==") || matchSymbol("~=") || matchSymbol(">=")
          || matchSymbol("<=") || matchSymbol(">") || matchSymbol("<")) {
        Token op = previous();
        ExprNode right = parseUnary();
        left = new BinaryNode(op.text, left, right, left.startOffset, right.endOffset, op.line, op.column);
      }
      return left;
    }

    private ExprNode parseUnary() {
      if(matchKeyword("not") || matchSymbol("-")) {
        Token op = previous();
        ExprNode child = parseUnary();
        return new UnaryNode(op.text, child, op.startOffset, child.endOffset, op.line, op.column);
      }
      return parsePrimary();
    }

    private ExprNode parsePrimary() {
      if(matchSymbol("(")) {
        Token left = previous();
        ExprNode inner = parseExpression();
        Token right = matchSymbol(")") ? previous() : left;
        return parsePostfix(new ParenNode(inner, left.startOffset, right.endOffset, left.line, left.column));
      }

      if(matchKind(TokenKind.IDENT) || matchKind(TokenKind.KEYWORD)) {
        Token token = previous();
        return parsePostfix(new NameNode(token.text, token.startOffset, token.endOffset, token.line, token.column));
      }

      if(matchKind(TokenKind.NUMBER)) {
        Token token = previous();
        return parsePostfix(new NumberNode(token.text, token.startOffset, token.endOffset, token.line, token.column));
      }

      if(matchKind(TokenKind.STRING)) {
        Token token = previous();
        return parsePostfix(new RawNode(token.text, token.startOffset, token.endOffset, token.line, token.column));
      }

      if(!isAtEnd()) {
        Token token = advance();
        return new RawNode(token.text, token.startOffset, token.endOffset, token.line, token.column);
      }
      return null;
    }

    private ExprNode parsePostfix(ExprNode base) {
      ExprNode current = base;
      while(!isAtEnd()) {
        if(matchSymbol(".")) {
          if(isAtEnd()) {
            break;
          }
          Token name = peek();
          if(name.kind != TokenKind.IDENT && name.kind != TokenKind.KEYWORD) {
            break;
          }
          advance();
          current = new FieldAccessNode(current, name.text, current.startOffset, name.endOffset, current.line, current.column);
          continue;
        }

        if(matchSymbol("[")) {
          int exprStart = index;
          int close = findMatchingWithin(exprStart - 1, "[", "]");
          if(close < 0) {
            break;
          }
          ExprNode idx = new ExpressionParser(tokens, exprStart, close).parseExpression();
          Token closeToken = tokens.get(close);
          current = new IndexAccessNode(current, idx, current.startOffset, closeToken.endOffset, current.line, current.column);
          index = close + 1;
          continue;
        }

        if(matchSymbol("(")) {
          int argStart = index;
          int close = findMatchingWithin(argStart - 1, "(", ")");
          if(close < 0) {
            break;
          }
          List<ExprNode> args = parseArgs(tokens, argStart, close);
          Token closeToken = tokens.get(close);
          current = new CallNode(current, args, current.startOffset, closeToken.endOffset, current.line, current.column);
          index = close + 1;
          continue;
        }
        break;
      }
      return current;
    }

    private int findMatchingWithin(int openIndex, String open, String close) {
      int depth = 0;
      for(int i = openIndex; i < endExclusive; i++) {
        Token t = tokens.get(i);
        if(t.isSymbol(open)) depth++;
        else if(t.isSymbol(close)) {
          depth--;
          if(depth == 0) {
            return i;
          }
        }
      }
      return -1;
    }

    private boolean matchKind(TokenKind kind) {
      if(isAtEnd()) return false;
      if(peek().kind != kind) return false;
      advance();
      return true;
    }

    private boolean matchKeyword(String keyword) {
      if(isAtEnd()) return false;
      Token t = peek();
      if(t.kind == TokenKind.KEYWORD && keyword.equals(t.text)) {
        advance();
        return true;
      }
      return false;
    }

    private boolean matchSymbol(String symbol) {
      if(isAtEnd()) return false;
      Token t = peek();
      if(t.kind == TokenKind.SYMBOL && symbol.equals(t.text)) {
        advance();
        return true;
      }
      return false;
    }

    private Token previous() {
      return tokens.get(index - 1);
    }

    private Token peek() {
      return tokens.get(index);
    }

    private Token advance() {
      return tokens.get(index++);
    }
  }

  private static abstract class ExprNode {
    final int startOffset;
    final int endOffset;
    final int line;
    final int column;

    ExprNode(int startOffset, int endOffset, int line, int column) {
      this.startOffset = startOffset;
      this.endOffset = endOffset;
      this.line = line;
      this.column = column;
    }
  }

  private static final class NameNode extends ExprNode {
    final String name;
    NameNode(String name, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.name = name;
    }
  }

  private static final class NumberNode extends ExprNode {
    final String text;
    NumberNode(String text, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.text = text;
    }
  }

  private static final class RawNode extends ExprNode {
    final String text;
    RawNode(String text, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.text = text;
    }
  }

  private static final class ParenNode extends ExprNode {
    final ExprNode inner;
    ParenNode(ExprNode inner, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.inner = inner;
    }
  }

  private static final class UnaryNode extends ExprNode {
    final String op;
    final ExprNode expr;
    UnaryNode(String op, ExprNode expr, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.op = op;
      this.expr = expr;
    }
  }

  private static final class BinaryNode extends ExprNode {
    final String op;
    final ExprNode left;
    final ExprNode right;
    BinaryNode(String op, ExprNode left, ExprNode right, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.op = op;
      this.left = left;
      this.right = right;
    }
  }

  private static final class FieldAccessNode extends ExprNode {
    final ExprNode base;
    final String field;
    FieldAccessNode(ExprNode base, String field, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.base = base;
      this.field = field;
    }
  }

  private static final class IndexAccessNode extends ExprNode {
    final ExprNode base;
    final ExprNode indexExpr;
    IndexAccessNode(ExprNode base, ExprNode indexExpr, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.base = base;
      this.indexExpr = indexExpr;
    }
  }

  private static final class CallNode extends ExprNode {
    final ExprNode callee;
    final List<ExprNode> arguments;
    CallNode(ExprNode callee, List<ExprNode> arguments, int startOffset, int endOffset, int line, int column) {
      super(startOffset, endOffset, line, column);
      this.callee = callee;
      this.arguments = arguments == null ? Collections.<ExprNode>emptyList() : arguments;
    }
  }

  private enum TokenKind {
    IDENT,
    NUMBER,
    STRING,
    SYMBOL,
    KEYWORD
  }

  private static final class Token {
    final TokenKind kind;
    final String text;
    final int startOffset;
    final int endOffset;
    final int line;
    final int column;

    Token(TokenKind kind, String text, int startOffset, int endOffset, int line, int column) {
      this.kind = kind;
      this.text = text;
      this.startOffset = startOffset;
      this.endOffset = endOffset;
      this.line = line;
      this.column = column;
    }

    boolean isSymbol(String symbol) {
      return kind == TokenKind.SYMBOL && symbol.equals(text);
    }
  }

  private static final class ParseResult {
    ExprNode node;
    int nextIndex;
  }

  private static final class QuestRefMatch {
    int questId;
    int index;
    String accessType;
    boolean goalAccess;
  }

  private static final class DialogArrays {
    final List<String> contents = new ArrayList<String>();
    final List<String> answer = new ArrayList<String>();
    final List<String> info = new ArrayList<String>();
  }

  private static final class GoalItem {
    int id;
    int count;
    String toJson() {
      return "{\"id\":" + id + ",\"count\":" + count + "}";
    }
  }

  private static final class GoalKill {
    int id;
    int count;
    String toJson() {
      return "{\"id\":" + id + ",\"count\":" + count + "}";
    }
  }

  private static final class QuestGoalBlock {
    final List<GoalItem> getItem = new ArrayList<GoalItem>();
    final List<GoalKill> killMonster = new ArrayList<GoalKill>();
    final List<Integer> meetNpc = new ArrayList<Integer>();

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{")
          .append("\"getItem\":").append(jsonGoalItems(getItem)).append(",")
          .append("\"killMonster\":").append(jsonGoalKills(killMonster)).append(",")
          .append("\"meetNpc\":").append(QuestSemanticJson.toJsonArrayInt(meetNpc))
          .append("}");
      return sb.toString();
    }
  }

  private static String jsonGoalItems(List<GoalItem> items) {
    StringBuilder sb = new StringBuilder();
    sb.append("[");
    for(int i = 0; i < items.size(); i++) {
      if(i > 0) sb.append(',');
      sb.append(items.get(i).toJson());
    }
    sb.append("]");
    return sb.toString();
  }

  private static String jsonGoalKills(List<GoalKill> kills) {
    StringBuilder sb = new StringBuilder();
    sb.append("[");
    for(int i = 0; i < kills.size(); i++) {
      if(i > 0) sb.append(',');
      sb.append(kills.get(i).toJson());
    }
    sb.append("]");
    return sb.toString();
  }

  private static final class RewardItem {
    int id;
    int count;
    String toJson() {
      return "{\"id\":" + id + ",\"count\":" + count + "}";
    }
  }

  private static final class RewardBlock {
    int exp;
    int gold;
    final List<RewardItem> items = new ArrayList<RewardItem>();

    String toJson() {
      StringBuilder sb = new StringBuilder();
      sb.append("{")
          .append("\"exp\":").append(exp).append(",")
          .append("\"gold\":").append(gold).append(",")
          .append("\"items\":").append(jsonRewardItems(items))
          .append("}");
      return sb.toString();
    }
  }

  private static String jsonRewardItems(List<RewardItem> items) {
    StringBuilder sb = new StringBuilder();
    sb.append("[");
    for(int i = 0; i < items.size(); i++) {
      if(i > 0) sb.append(',');
      sb.append(items.get(i).toJson());
    }
    sb.append("]");
    return sb.toString();
  }

  private static final class QuestRecord {
    int questId;
    String name = "";
    final List<String> contents = new ArrayList<String>();
    final List<String> answer = new ArrayList<String>();
    final List<String> info = new ArrayList<String>();
    final QuestGoalBlock goal = new QuestGoalBlock();
    final RewardBlock reward = new RewardBlock();
    int needLevel;
    int bQLoop;
  }

  private static final class QuestDataReport {
    String generatedAt = "";
    String sourceQuestLuc = "";
    int totalQuestCount;
    final List<QuestRecord> quests = new ArrayList<QuestRecord>();
  }

  private static final class QuestRef {
    final Set<String> npcFiles = new LinkedHashSet<String>();
    int referenceCount;
    int goalAccessCount;

    String toJson() {
      return "{\"npcFiles\":" + QuestSemanticJson.toJsonArrayString(new ArrayList<String>(npcFiles))
          + ",\"referenceCount\":" + referenceCount
          + ",\"goalAccessCount\":" + goalAccessCount + "}";
    }
  }

  private static final class NpcFileRef {
    final Set<Integer> referencedQuestIds = new LinkedHashSet<Integer>();
    int referenceCount;
    int goalAccessCount;

    String toJson() {
      return "{\"referencedQuestIds\":" + QuestSemanticJson.toJsonArrayInt(new ArrayList<Integer>(referencedQuestIds))
          + ",\"referenceCount\":" + referenceCount
          + ",\"goalAccessCount\":" + goalAccessCount + "}";
    }
  }

  private static final class NodeLocation {
    int questId;
    String npcFile = "";
    String accessType = "";
    int index;
    int line;
    int column;
    boolean goalAccess;
    String fullExpressionText = "";
  }

  private static final class NpcReferenceReport {
    String generatedAt = "";
    String sourceNpcDir = "";
    int totalNpcFiles;
    int totalQuestReferences;
    int totalGoalIndexedAccess;
    final Map<String, QuestRef> byQuestId = new LinkedHashMap<String, QuestRef>();
    final Map<String, NpcFileRef> byNpcFile = new LinkedHashMap<String, NpcFileRef>();
    final List<NodeLocation> nodeLocations = new ArrayList<NodeLocation>();
  }

  private static final class ScanSummary {
    String generatedAt = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    boolean questFileDetected = true;
    int totalFilesScanned;
    int totalNpcFilesScanned;
    int totalQuestReferencesDetected;
    int totalGoalIndexedAccessDetected;
    final List<String> missingFiles = new ArrayList<String>();
    final List<String> parsingErrors = new ArrayList<String>();
  }

  public static final class Phase2Result {
    QuestDataReport questData = new QuestDataReport();
    NpcReferenceReport npcIndex = new NpcReferenceReport();
    ScanSummary summary = new ScanSummary();
  }

  private static final class DecodedText {
    Charset charset;
    byte[] bom;
    String text;
  }
}
