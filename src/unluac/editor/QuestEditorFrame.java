package unluac.editor;

import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JComboBox;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTabbedPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.ListSelectionModel;
import javax.swing.RowFilter;
import javax.swing.SwingConstants;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.TableRowSorter;

import unluac.semantic.ItemRequirement;
import unluac.semantic.KillRequirement;
import unluac.semantic.NpcScriptModel;
import unluac.semantic.QuestGoal;
import unluac.semantic.ScriptTypeDetector;

public class QuestEditorFrame extends JFrame {

  private static final String VIEW_QUEST = "QUEST";
  private static final String VIEW_NPC = "NPC";

  private final QuestEditorService service = new QuestEditorService();

  private final CardLayout centerLayout = new CardLayout();
  private final JPanel centerCards = new JPanel(centerLayout);

  private final QuestTableModel tableModel = new QuestTableModel();
  private final JTable table = new JTable(tableModel);
  private final TableRowSorter<QuestTableModel> rowSorter = new TableRowSorter<QuestTableModel>(tableModel);

  private final JTextField searchField = new JTextField(24);
  private final JLabel filterCountLabel = new JLabel("0 / 0");

  private final JTextField titleField = new JTextField();
  private final JTextArea descriptionArea = new JTextArea();
  private final JTextField preQuestIdsField = new JTextField();

  private final JTextArea dialogJsonArea = new JTextArea();
  private final JComboBox<String> answerBranchCombo = new JComboBox<String>(
      new String[] { DialogLine.BRANCH_YES, DialogLine.BRANCH_NO, DialogLine.BRANCH_IF_NO });
  private final JTextField answerTextField = new JTextField();

  private final JTextField needLevelField = new JTextField();
  private final JTextArea goalItemsArea = new JTextArea();
  private final JTextArea goalMonstersArea = new JTextArea();

  private final JTextField rewardExpField = new JTextField();
  private final JTextField rewardFameField = new JTextField();
  private final JTextField rewardMoneyField = new JTextField();
  private final JTextField rewardPvppointField = new JTextField();
  private final JTextField rewardItemIdField = new JTextField();
  private final JTextField rewardItemCountField = new JTextField();
  private final JTextField rewardSkillIdsField = new JTextField();
  private final JTextArea rewardExtraFieldsArea = new JTextArea();
  private final JTextArea rewardFieldOrderArea = new JTextArea();
  private final JTextField rewardSkillInputField = new JTextField();
  private final JButton rewardSkillAddButton = new JButton("新增技能ID");
  private final JButton rewardSkillRemoveButton = new JButton("删除最后技能ID");

  private final JLabel statusLabel = new JLabel("Ready", SwingConstants.LEFT);

  private final JTextArea npcSummaryArea = new JTextArea();
  private final JTextArea npcBranchArea = new JTextArea();

  private ScriptTypeDetector.ScriptType currentScriptType = ScriptTypeDetector.ScriptType.UNKNOWN;

  private File currentLuc;
  private QuestEditorModel selected;

  public QuestEditorFrame() {
    setTitle("QuestEditor (Stage-Based)");
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setSize(new Dimension(1320, 860));
    setLocationRelativeTo(null);

    setLayout(new BorderLayout(8, 8));
    add(buildToolbar(), BorderLayout.NORTH);
    add(buildCenterContainer(), BorderLayout.CENTER);
    add(statusLabel, BorderLayout.SOUTH);

    wireEvents();
    setEditPanelEnabled(false);
  }

  private JPanel buildToolbar() {
    JPanel panel = new JPanel(new FlowLayout(FlowLayout.LEFT));

    JButton openButton = new JButton("打开 luc");
    openButton.setActionCommand("open");
    openButton.addActionListener(toolbarListener);

    JButton saveButton = new JButton("保存新 luc");
    saveButton.setActionCommand("save");
    saveButton.addActionListener(toolbarListener);

    JButton reloadButton = new JButton("重新加载");
    reloadButton.setActionCommand("reload");
    reloadButton.addActionListener(toolbarListener);

    JButton clearSearchButton = new JButton("清空筛选");
    clearSearchButton.setActionCommand("clear_search");
    clearSearchButton.addActionListener(toolbarListener);

    panel.add(openButton);
    panel.add(saveButton);
    panel.add(reloadButton);
    panel.add(new JLabel("搜索(quest_id/标题):"));
    panel.add(searchField);
    panel.add(clearSearchButton);
    panel.add(new JLabel("显示:"));
    panel.add(filterCountLabel);
    return panel;
  }

  private JPanel buildCenterContainer() {
    centerCards.add(buildQuestCenter(), VIEW_QUEST);
    centerCards.add(buildNpcCenter(), VIEW_NPC);
    centerLayout.show(centerCards, VIEW_QUEST);
    return centerCards;
  }

  private JSplitPane buildQuestCenter() {
    table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
    table.setRowSorter(rowSorter);
    JScrollPane left = new JScrollPane(table);

    JPanel rightPanel = buildEditorPanel();

    JSplitPane split = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, left, rightPanel);
    split.setResizeWeight(0.35D);
    return split;
  }

  private JPanel buildNpcCenter() {
    JPanel panel = new JPanel(new BorderLayout(8, 8));
    npcSummaryArea.setLineWrap(true);
    npcSummaryArea.setWrapStyleWord(true);
    npcSummaryArea.setEditable(false);

    npcBranchArea.setLineWrap(true);
    npcBranchArea.setWrapStyleWord(true);
    npcBranchArea.setEditable(false);

    panel.add(wrapTextArea("NPC 脚本摘要", npcSummaryArea), BorderLayout.NORTH);
    panel.add(wrapTextArea("NPC 语义分支（NPC_SAY / ADD_QUEST_BTN / SET_QUEST_STATE / CHECK_ITEM_CNT）", npcBranchArea), BorderLayout.CENTER);
    return panel;
  }

  private JPanel buildEditorPanel() {
    JPanel root = new JPanel(new BorderLayout(8, 8));

    JTabbedPane tabs = new JTabbedPane();
    tabs.addTab("基础信息", buildBasicTab());
    tabs.addTab("对话阶段", buildDialogStageTab());
    tabs.addTab("任务目标", buildGoalTab());
    tabs.addTab("奖励", buildRewardTab());
    root.add(tabs, BorderLayout.CENTER);

    JButton applyButton = new JButton("应用到当前任务");
    applyButton.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        try {
          applyEditToSelection();
        } catch(Exception ex) {
          showException(ex);
        }
      }
    });
    root.add(applyButton, BorderLayout.SOUTH);
    return root;
  }

  private JPanel buildBasicTab() {
    JPanel panel = new JPanel(new BorderLayout(8, 8));

    JPanel top = new JPanel(new GridLayout(2, 2, 6, 6));
    top.add(new JLabel("标题"));
    top.add(titleField);
    top.add(new JLabel("前置任务ID(JSON数组)"));
    top.add(preQuestIdsField);
    panel.add(top, BorderLayout.NORTH);

    JPanel center = new JPanel(new BorderLayout(6, 6));
    center.add(new JLabel("描述（兼容字段，默认映射为阶段1对话）"), BorderLayout.NORTH);
    descriptionArea.setLineWrap(true);
    descriptionArea.setWrapStyleWord(true);
    center.add(new JScrollPane(descriptionArea), BorderLayout.CENTER);
    panel.add(center, BorderLayout.CENTER);

    return panel;
  }

  private JPanel buildDialogStageTab() {
    JPanel panel = new JPanel(new BorderLayout(8, 8));
    panel.add(buildAnswerQuickAppendPanel(), BorderLayout.NORTH);
    panel.add(wrapTextArea("对话 JSON（start/progress/complete）", dialogJsonArea), BorderLayout.CENTER);

    return panel;
  }

  private JPanel buildAnswerQuickAppendPanel() {
    JPanel panel = new JPanel(new GridLayout(2, 4, 6, 6));
    panel.add(new JLabel("新增 ANSWER 分支"));
    panel.add(answerBranchCombo);
    panel.add(new JLabel("文本"));
    panel.add(answerTextField);

    JButton appendButton = new JButton("追加到 start");
    appendButton.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        try {
          appendAnswerLineToDialogJson();
        } catch(Exception ex) {
          showException(ex);
        }
      }
    });
    panel.add(appendButton);
    panel.add(new JLabel(""));
    panel.add(new JLabel(""));
    panel.add(new JLabel(""));
    return panel;
  }

  private JPanel buildGoalTab() {
    JPanel panel = new JPanel(new BorderLayout(8, 8));

    JPanel top = new JPanel(new GridLayout(1, 2, 6, 6));
    top.add(new JLabel("needLevel"));
    top.add(needLevelField);
    panel.add(top, BorderLayout.NORTH);

    JPanel center = new JPanel(new GridLayout(1, 2, 8, 8));
    center.add(wrapTextArea("物品需求（每行: meetcnt,itemid,itemcnt）", goalItemsArea));
    center.add(wrapTextArea("杀怪需求（每行: monsterId,killCount）", goalMonstersArea));
    panel.add(center, BorderLayout.CENTER);

    return panel;
  }

  private JPanel buildRewardTab() {
    JPanel panel = new JPanel(new BorderLayout(8, 8));

    JPanel fields = new JPanel(new GridLayout(6, 2, 8, 8));
    fields.add(new JLabel("reward_exp"));
    fields.add(rewardExpField);
    fields.add(new JLabel("reward_fame"));
    fields.add(rewardFameField);
    fields.add(new JLabel("reward_money"));
    fields.add(rewardMoneyField);
    fields.add(new JLabel("reward_pvppoint"));
    fields.add(rewardPvppointField);
    fields.add(new JLabel("reward_item_id(JSON数组)"));
    fields.add(rewardItemIdField);
    fields.add(new JLabel("reward_item_count(JSON数组)"));
    fields.add(rewardItemCountField);
    panel.add(fields, BorderLayout.NORTH);

    JPanel skillPanel = new JPanel(new BorderLayout(6, 6));
    JPanel skillTop = new JPanel(new GridLayout(1, 2, 6, 6));
    skillTop.add(new JLabel("reward_skill_ids(JSON数组)"));
    skillTop.add(rewardSkillIdsField);
    skillPanel.add(skillTop, BorderLayout.NORTH);

    JPanel skillButtons = new JPanel(new GridLayout(1, 3, 6, 6));
    skillButtons.add(rewardSkillInputField);
    skillButtons.add(rewardSkillAddButton);
    skillButtons.add(rewardSkillRemoveButton);
    skillPanel.add(skillButtons, BorderLayout.CENTER);

    rewardSkillAddButton.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        try {
          appendRewardSkillId();
        } catch(Exception ex) {
          showException(ex);
        }
      }
    });

    rewardSkillRemoveButton.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        try {
          removeLastRewardSkillId();
        } catch(Exception ex) {
          showException(ex);
        }
      }
    });

    panel.add(skillPanel, BorderLayout.CENTER);

    JPanel extraPanel = new JPanel(new GridLayout(1, 2, 8, 8));
    extraPanel.add(wrapTextArea("reward_extra_fields(JSON 对象)", rewardExtraFieldsArea));
    extraPanel.add(wrapTextArea("reward_field_order(JSON 数组)", rewardFieldOrderArea));
    panel.add(extraPanel, BorderLayout.SOUTH);

    return panel;
  }

  private JPanel wrapTextArea(String title, JTextArea textArea) {
    JPanel panel = new JPanel(new BorderLayout(4, 4));
    panel.add(new JLabel(title), BorderLayout.NORTH);
    textArea.setLineWrap(true);
    textArea.setWrapStyleWord(true);
    panel.add(new JScrollPane(textArea), BorderLayout.CENTER);
    return panel;
  }

  private void wireEvents() {
    table.getSelectionModel().addListSelectionListener(new ListSelectionListener() {
      @Override
      public void valueChanged(ListSelectionEvent e) {
        if(e.getValueIsAdjusting()) {
          return;
        }
        int viewRow = table.getSelectedRow();
        if(viewRow < 0) {
          selected = null;
          clearEditorFields();
          setEditPanelEnabled(false);
          return;
        }
        int modelRow = table.convertRowIndexToModel(viewRow);
        QuestEditorModel model = tableModel.getRow(modelRow);
        selected = model;
        loadSelectionToEditor(model);
        setEditPanelEnabled(true);
      }
    });

    searchField.getDocument().addDocumentListener(new DocumentListener() {
      @Override
      public void insertUpdate(DocumentEvent e) {
        applyFilter();
      }

      @Override
      public void removeUpdate(DocumentEvent e) {
        applyFilter();
      }

      @Override
      public void changedUpdate(DocumentEvent e) {
        applyFilter();
      }
    });
  }

  private void clearEditorFields() {
    titleField.setText("");
    descriptionArea.setText("");
    preQuestIdsField.setText("[]");

    dialogJsonArea.setText(QuestDialogJsonValidator.toJson(new QuestDialogJsonModel()));
    answerBranchCombo.setSelectedItem(DialogLine.BRANCH_YES);
    answerTextField.setText("");

    needLevelField.setText("0");
    goalItemsArea.setText("");
    goalMonstersArea.setText("");

    rewardExpField.setText("0");
    rewardFameField.setText("0");
    rewardMoneyField.setText("0");
    rewardPvppointField.setText("0");
    rewardItemIdField.setText("[]");
    rewardItemCountField.setText("[]");
    rewardSkillIdsField.setText("[]");
    rewardExtraFieldsArea.setText("{}");
    rewardFieldOrderArea.setText("[]");
    rewardSkillInputField.setText("");
  }

  private void loadSelectionToEditor(QuestEditorModel model) {
    if(model == null) {
      clearEditorFields();
      return;
    }

    if(model.stage == null) {
      model.stage = new QuestStageModel();
    }

    titleField.setText(nonNull(model.title));
    descriptionArea.setText(nonNull(model.description));
    preQuestIdsField.setText(emptyJsonArray(model.preQuestIdsJson));

    QuestDialogJsonModel dialogModel = model.dialogJsonModel;
    if(dialogModel == null) {
      dialogModel = new QuestDialogJsonModel();
    }
    dialogJsonArea.setText(QuestDialogJsonValidator.toJson(dialogModel));

    QuestGoal goal = model.stage.goal != null ? model.stage.goal : model.goal;
    needLevelField.setText(Integer.toString(goal == null ? 0 : goal.needLevel));
    goalItemsArea.setText(formatItemRequirements(goal));
    goalMonstersArea.setText(formatKillRequirements(goal));

    rewardExpField.setText(Integer.toString(model.rewardExp));
    rewardFameField.setText(Integer.toString(model.rewardFame));
    rewardMoneyField.setText(Integer.toString(model.rewardMoney));
    rewardPvppointField.setText(Integer.toString(model.rewardPvppoint));
    rewardItemIdField.setText(emptyJsonArray(model.rewardItemIdJson));
    rewardItemCountField.setText(emptyJsonArray(model.rewardItemCountJson));
    rewardSkillIdsField.setText(emptyJsonArray(model.rewardSkillIdsJson));
    rewardExtraFieldsArea.setText(nonNull(model.rewardExtraFieldsJson).trim().isEmpty() ? "{}" : model.rewardExtraFieldsJson);
    rewardFieldOrderArea.setText(nonNull(model.rewardFieldOrderJson).trim().isEmpty() ? "[]" : model.rewardFieldOrderJson);
  }

  private void applyEditToSelection() {
    if(selected == null) {
      throw new IllegalStateException("当前未选中任务");
    }
    int questIdSnapshot = selected.questId;

    selected.title = nonNull(titleField.getText()).trim();
    selected.description = nonNull(descriptionArea.getText());
    selected.preQuestIdsJson = nonEmptyJsonArray(preQuestIdsField.getText());

    if(selected.stage == null) {
      selected.stage = new QuestStageModel();
    }

    QuestDialogJsonModel dialogModel = QuestDialogJsonValidator.parseAndValidate(dialogJsonArea.getText());
    service.applyDialogJsonModel(selected, dialogModel);

    QuestGoal stageGoal = new QuestGoal();
    stageGoal.needLevel = parseIntStrict(needLevelField.getText(), "needLevel");
    stageGoal.items.addAll(parseItemRequirements(goalItemsArea.getText()));
    stageGoal.monsters.addAll(parseKillRequirements(goalMonstersArea.getText()));
    selected.stage.goal = stageGoal;
    selected.goal = stageGoal;

    if(selected.stage.reward == null) {
      selected.stage.reward = new QuestReward();
    }
    selected.stage.reward.exp = parseIntStrict(rewardExpField.getText(), "reward_exp");
    selected.stage.reward.fame = parseIntStrict(rewardFameField.getText(), "reward_fame");
    selected.stage.reward.money = parseIntStrict(rewardMoneyField.getText(), "reward_money");
    selected.stage.reward.pvppoint = parseIntStrict(rewardPvppointField.getText(), "reward_pvppoint");

    List<Integer> rewardItemIds = QuestEditorValidator.parseIntArray(nonEmptyJsonArray(rewardItemIdField.getText()));
    List<Integer> rewardItemCounts = QuestEditorValidator.parseIntArray(nonEmptyJsonArray(rewardItemCountField.getText()));
    if(rewardItemIds.size() != rewardItemCounts.size()) {
      throw new IllegalStateException("reward_item_id 与 reward_item_count 长度不一致");
    }
    selected.stage.reward.loadItemsFromLists(rewardItemIds, rewardItemCounts);
    selected.stage.reward.skillIds.clear();
    selected.stage.reward.skillIds.addAll(QuestEditorValidator.parseIntArray(nonEmptyJsonArray(rewardSkillIdsField.getText())));

    selected.rewardExp = selected.stage.reward.exp;
    selected.rewardFame = selected.stage.reward.fame;
    selected.rewardMoney = selected.stage.reward.money;
    selected.rewardPvppoint = selected.stage.reward.pvppoint;
    selected.rewardItemIdJson = toJsonIntArray(selected.stage.reward.toItemIdList());
    selected.rewardItemCountJson = toJsonIntArray(selected.stage.reward.toItemCountList());
    selected.rewardSkillIdsJson = toJsonIntArray(selected.stage.reward.skillIds);
    selected.rewardExtraFieldsJson = nonNull(rewardExtraFieldsArea.getText()).trim().isEmpty() ? "{}" : rewardExtraFieldsArea.getText().trim();
    selected.rewardFieldOrderJson = nonNull(rewardFieldOrderArea.getText()).trim().isEmpty() ? "[]" : rewardFieldOrderArea.getText().trim();

    selected.stage.reward.extraFields.clear();
    selected.stage.reward.extraFields.putAll(unluac.semantic.QuestSemanticJson.parseObject(
        selected.rewardExtraFieldsJson,
        "reward_extra_fields",
        0));
    selected.stage.reward.fieldOrder.clear();
    selected.stage.reward.fieldOrder.addAll(unluac.semantic.QuestSemanticJson.parseStringArray(
        selected.rewardFieldOrderJson,
        "reward_field_order",
        0));

    QuestEditorValidator.validateJsonIntArray(selected.rewardItemIdJson, "reward_item_id");
    QuestEditorValidator.validateJsonIntArray(selected.rewardItemCountJson, "reward_item_count");
    QuestEditorValidator.validateJsonIntArray(selected.rewardSkillIdsJson, "reward_skill_ids");
    unluac.semantic.QuestSemanticJson.parseObject(selected.rewardExtraFieldsJson, "reward_extra_fields", 0);
    unluac.semantic.QuestSemanticJson.parseStringArray(selected.rewardFieldOrderJson, "reward_field_order", 0);
    QuestEditorValidator.validateJsonIntArray(selected.preQuestIdsJson, "pre_quest_ids");

    service.markDirty(selected);
    tableModel.fireTableDataChanged();
    statusLabel.setText("已应用修改: quest_id=" + questIdSnapshot);
  }

  private int parseIntStrict(String text, String field) {
    try {
      return Integer.parseInt(nonNull(text).trim());
    } catch(Exception ex) {
      throw new IllegalStateException(field + " 不是有效整数");
    }
  }

  private void setEditPanelEnabled(boolean enabled) {
    titleField.setEnabled(enabled);
    descriptionArea.setEnabled(enabled);
    preQuestIdsField.setEnabled(enabled);

    dialogJsonArea.setEnabled(enabled);
    answerBranchCombo.setEnabled(enabled);
    answerTextField.setEnabled(enabled);

    needLevelField.setEnabled(enabled);
    goalItemsArea.setEnabled(enabled);
    goalMonstersArea.setEnabled(enabled);

    rewardExpField.setEnabled(enabled);
    rewardFameField.setEnabled(enabled);
    rewardMoneyField.setEnabled(enabled);
    rewardPvppointField.setEnabled(enabled);
    rewardItemIdField.setEnabled(enabled);
    rewardItemCountField.setEnabled(enabled);
    rewardSkillIdsField.setEnabled(enabled);
    rewardExtraFieldsArea.setEnabled(enabled);
    rewardFieldOrderArea.setEnabled(enabled);
    rewardSkillInputField.setEnabled(enabled);
    rewardSkillAddButton.setEnabled(enabled);
    rewardSkillRemoveButton.setEnabled(enabled);
  }

  private void appendRewardSkillId() {
    String raw = nonNull(rewardSkillInputField.getText()).trim();
    if(raw.isEmpty()) {
      throw new IllegalStateException("技能ID不能为空");
    }
    int value = parseIntStrict(raw, "reward_skill_id");
    List<Integer> ids = QuestEditorValidator.parseIntArray(nonEmptyJsonArray(rewardSkillIdsField.getText()));
    ids.add(Integer.valueOf(value));
    rewardSkillIdsField.setText(toJsonIntArray(ids));
    rewardSkillInputField.setText("");
  }

  private void removeLastRewardSkillId() {
    List<Integer> ids = QuestEditorValidator.parseIntArray(nonEmptyJsonArray(rewardSkillIdsField.getText()));
    if(ids.isEmpty()) {
      return;
    }
    ids.remove(ids.size() - 1);
    rewardSkillIdsField.setText(toJsonIntArray(ids));
  }

  private void appendAnswerLineToDialogJson() {
    String text = nonNull(answerTextField.getText()).trim();
    if(text.isEmpty()) {
      throw new IllegalStateException("新增 ANSWER 文本不能为空");
    }

    String branch = String.valueOf(answerBranchCombo.getSelectedItem());
    if(branch == null || branch.trim().isEmpty()) {
      branch = DialogLine.BRANCH_YES;
    }

    QuestDialogJsonModel model = QuestDialogJsonValidator.parseAndValidate(dialogJsonArea.getText());
    DialogLine line = new DialogLine();
    line.type = DialogLine.TYPE_ANSWER;
    line.branch = branch.trim();
    line.text = text;
    model.start.add(line);
    dialogJsonArea.setText(QuestDialogJsonValidator.toJson(model));
    answerTextField.setText("");
  }

  private String formatItemRequirements(QuestGoal goal) {
    if(goal == null || goal.items == null || goal.items.isEmpty()) {
      return "";
    }
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < goal.items.size(); i++) {
      ItemRequirement item = goal.items.get(i);
      if(i > 0) {
        sb.append('\n');
      }
      sb.append(item.meetCount).append(',').append(item.itemId).append(',').append(item.itemCount);
    }
    return sb.toString();
  }

  private String formatKillRequirements(QuestGoal goal) {
    if(goal == null || goal.monsters == null || goal.monsters.isEmpty()) {
      return "";
    }
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < goal.monsters.size(); i++) {
      KillRequirement monster = goal.monsters.get(i);
      if(i > 0) {
        sb.append('\n');
      }
      sb.append(monster.monsterId).append(',').append(monster.killCount);
    }
    return sb.toString();
  }

  private List<ItemRequirement> parseItemRequirements(String text) {
    List<ItemRequirement> out = new ArrayList<ItemRequirement>();
    String source = text == null ? "" : text.trim();
    if(source.isEmpty()) {
      return out;
    }
    String[] lines = source.split("\\r?\\n");
    for(int i = 0; i < lines.length; i++) {
      String line = lines[i].trim();
      if(line.isEmpty()) {
        continue;
      }
      String[] parts = line.split(",");
      if(parts.length != 3) {
        throw new IllegalStateException("item requirement line " + (i + 1) + " format must be: meetcnt,itemid,itemcnt");
      }
      ItemRequirement req = new ItemRequirement();
      req.meetCount = parseIntStrict(parts[0], "meetcnt(line " + (i + 1) + ")");
      req.itemId = parseIntStrict(parts[1], "itemid(line " + (i + 1) + ")");
      req.itemCount = parseIntStrict(parts[2], "itemcnt(line " + (i + 1) + ")");
      out.add(req);
    }
    return out;
  }

  private List<KillRequirement> parseKillRequirements(String text) {
    List<KillRequirement> out = new ArrayList<KillRequirement>();
    String source = text == null ? "" : text.trim();
    if(source.isEmpty()) {
      return out;
    }
    String[] lines = source.split("\\r?\\n");
    for(int i = 0; i < lines.length; i++) {
      String line = lines[i].trim();
      if(line.isEmpty()) {
        continue;
      }
      String[] parts = line.split(",");
      if(parts.length != 2) {
        throw new IllegalStateException("kill requirement line " + (i + 1) + " format must be: monsterId,killCount");
      }
      KillRequirement req = new KillRequirement();
      req.monsterId = parseIntStrict(parts[0], "monsterId(line " + (i + 1) + ")");
      req.killCount = parseIntStrict(parts[1], "killCount(line " + (i + 1) + ")");
      out.add(req);
    }
    return out;
  }

  private void applyFilter() {
    final String keyword = searchField.getText() == null ? "" : searchField.getText().trim().toLowerCase();
    if(keyword.isEmpty()) {
      rowSorter.setRowFilter(null);
      updateFilterCountLabel();
      return;
    }

    rowSorter.setRowFilter(new RowFilter<QuestTableModel, Integer>() {
      @Override
      public boolean include(Entry<? extends QuestTableModel, ? extends Integer> entry) {
        QuestTableModel model = entry.getModel();
        int row = entry.getIdentifier().intValue();
        QuestEditorModel quest = model.getRow(row);

        String questIdText = Integer.toString(quest.questId);
        String titleText = quest.title == null ? "" : quest.title.toLowerCase();
        return questIdText.contains(keyword) || titleText.contains(keyword);
      }
    });
    updateFilterCountLabel();
  }

  private void updateFilterCountLabel() {
    filterCountLabel.setText(table.getRowCount() + " / " + tableModel.getRowCount());
  }

  private final ActionListener toolbarListener = new ActionListener() {
    @Override
    public void actionPerformed(ActionEvent e) {
      try {
        String cmd = e.getActionCommand();
        if("open".equals(cmd)) {
          openLuc();
        } else if("save".equals(cmd)) {
          savePatchedLuc();
        } else if("reload".equals(cmd)) {
          reloadCurrent();
        } else if("clear_search".equals(cmd)) {
          searchField.setText("");
          applyFilter();
        }
      } catch(Exception ex) {
        showException(ex);
      }
    }
  };

  private void openLuc() throws Exception {
    JFileChooser chooser = new JFileChooser();
    chooser.setDialogTitle("选择 quest.luc");
    if(chooser.showOpenDialog(this) != JFileChooser.APPROVE_OPTION) {
      return;
    }

    currentLuc = chooser.getSelectedFile();

    ScriptTypeDetector.DetectionResult detection = service.detectScriptType(currentLuc.toPath());
    currentScriptType = detection.scriptType;

    if(currentScriptType == ScriptTypeDetector.ScriptType.NPC_SCRIPT) {
      NpcScriptModel npc = service.loadNpcScript(currentLuc.toPath());
      centerLayout.show(centerCards, VIEW_NPC);
      tableModel.setRows(new ArrayList<QuestEditorModel>());
      applyFilter();
      selected = null;
      clearEditorFields();
      setEditPanelEnabled(false);
      bindNpcModel(npc, detection);
      statusLabel.setText("已加载 NPC 脚本: " + currentLuc.getAbsolutePath()
          + " | branch_count=" + npc.branches.size());
      return;
    }

    centerLayout.show(centerCards, VIEW_QUEST);
    List<QuestEditorModel> rows = service.loadForEditor(currentLuc.toPath());
    tableModel.setRows(rows);
    applyFilter();

    selected = null;
    clearEditorFields();
    setEditPanelEnabled(false);
    statusLabel.setText("已加载 Quest: " + currentLuc.getAbsolutePath() + " | 任务数=" + rows.size());
  }

  private void reloadCurrent() throws Exception {
    if(currentLuc == null) {
      JOptionPane.showMessageDialog(this, "请先打开 luc 文件", "提示", JOptionPane.INFORMATION_MESSAGE);
      return;
    }

    ScriptTypeDetector.DetectionResult detection = service.detectScriptType(currentLuc.toPath());
    currentScriptType = detection.scriptType;

    if(currentScriptType == ScriptTypeDetector.ScriptType.NPC_SCRIPT) {
      NpcScriptModel npc = service.loadNpcScript(currentLuc.toPath());
      centerLayout.show(centerCards, VIEW_NPC);
      tableModel.setRows(new ArrayList<QuestEditorModel>());
      applyFilter();
      selected = null;
      clearEditorFields();
      setEditPanelEnabled(false);
      bindNpcModel(npc, detection);
      statusLabel.setText("已重新加载 NPC 脚本: " + currentLuc.getAbsolutePath());
      return;
    }

    centerLayout.show(centerCards, VIEW_QUEST);
    List<QuestEditorModel> rows = service.loadForEditor(currentLuc.toPath());
    tableModel.setRows(rows);
    applyFilter();
    selected = null;
    clearEditorFields();
    setEditPanelEnabled(false);
    statusLabel.setText("已重新加载: " + currentLuc.getAbsolutePath());
  }

  private void savePatchedLuc() throws Exception {
    if(currentLuc == null) {
      JOptionPane.showMessageDialog(this, "请先打开 luc 文件", "提示", JOptionPane.INFORMATION_MESSAGE);
      return;
    }
    if(currentScriptType == ScriptTypeDetector.ScriptType.NPC_SCRIPT) {
      throw new IllegalStateException("NPC_SCRIPT 当前阶段仅支持语义解析展示，未接入保存流程。");
    }
    if(selected != null) {
      applyEditToSelection();
    }

    JFileChooser chooser = new JFileChooser();
    chooser.setDialogTitle("保存 patched luc");
    chooser.setSelectedFile(new File(currentLuc.getParentFile(), "quest_patched.luc"));
    if(chooser.showSaveDialog(this) != JFileChooser.APPROVE_OPTION) {
      return;
    }
    File outFile = chooser.getSelectedFile();

    if(outFile.exists()) {
      int overwrite = JOptionPane.showConfirmDialog(this,
          "文件已存在，是否覆盖？\n" + outFile.getAbsolutePath(),
          "确认覆盖",
          JOptionPane.YES_NO_OPTION,
          JOptionPane.WARNING_MESSAGE);
      if(overwrite != JOptionPane.YES_OPTION) {
        return;
      }
    }

    List<QuestEditorModel> rows = new ArrayList<QuestEditorModel>(tableModel.rows);
    QuestEditorSaveResult result;
    try {
      result = service.savePatchedLuc(currentLuc.toPath(), rows, outFile.toPath());
    } catch(Exception ex) {
      String message = ex.getMessage() == null ? "" : ex.getMessage();
      if(message.contains("string overflow")) {
        throw new IllegalStateException(
            "保存失败：文本字节超出原始 luc 固定字符串槽位上限。\n"
                + "已中止写入，未生成 luc 文件。\n"
                + message,
            ex);
      }
      throw ex;
    }

    statusLabel.setText("已保存: " + outFile.getAbsolutePath()
        + " | 修改任务=" + result.modifiedQuestCount
        + " | diff=" + result.diffTotal
        + " | nonConstantDiff=" + result.nonConstantDiff);

    if(result.nonConstantDiff > 0) {
      JOptionPane.showMessageDialog(this,
          "检测到非 constant 区变化，已中止。\n" + result.validationSummary,
          "结构错误",
          JOptionPane.ERROR_MESSAGE);
      return;
    }

    JOptionPane.showMessageDialog(this,
        "保存成功\n修改任务: " + result.modifiedQuestCount
            + "\nconstant diff: " + result.constantDiff
            + "\nnon-constant diff: " + result.nonConstantDiff
            + (result.rewardDiffSummary == null || result.rewardDiffSummary.trim().isEmpty()
                ? ""
                : "\n\nreward diff:\n" + result.rewardDiffSummary),
        "完成",
        JOptionPane.INFORMATION_MESSAGE);
  }

  private void showException(Exception ex) {
    String message = ex.getMessage();
    if(message == null || message.trim().isEmpty()) {
      message = ex.getClass().getName();
    }
    JOptionPane.showMessageDialog(this, message, "错误", JOptionPane.ERROR_MESSAGE);
  }

  private void bindNpcModel(NpcScriptModel npc, ScriptTypeDetector.DetectionResult detection) {
    if(npc == null) {
      npcSummaryArea.setText("");
      npcBranchArea.setText("");
      return;
    }

    StringBuilder summary = new StringBuilder();
    summary.append("ScriptType: ").append(detection == null ? ScriptTypeDetector.ScriptType.NPC_SCRIPT : detection.scriptType).append('\n');
    summary.append("npcId: ").append(npc.npcId).append('\n');
    summary.append("relatedQuestIds: ").append(npc.relatedQuestIds).append('\n');
    summary.append("branchCount: ").append(npc.branches.size()).append('\n');
    if(detection != null) {
      summary.append("globalFunctions: ").append(detection.globalFunctionNames).append('\n');
      summary.append("hasNpcSayFunction: ").append(detection.hasNpcSayFunction).append('\n');
      summary.append("hasChkQStateFunction: ").append(detection.hasChkQStateFunction).append('\n');
      summary.append("hasQtAssignment: ").append(detection.hasQtAssignment).append('\n');
    }
    npcSummaryArea.setText(summary.toString());

    StringBuilder branchText = new StringBuilder();
    for(int i = 0; i < npc.branches.size(); i++) {
      NpcScriptModel.DialogBranch branch = npc.branches.get(i);
      branchText.append('#').append(i + 1)
          .append(" action=").append(nonNull(branch.action))
          .append(" function=").append(nonNull(branch.functionPath))
          .append(" pc=").append(branch.pc)
          .append(" questId=").append(branch.questId)
          .append(" state=").append(branch.stateValue)
          .append(" itemId=").append(branch.itemId)
          .append(" itemCount=").append(branch.itemCount)
          .append(" text=").append(nonNull(branch.text))
          .append('\n');
    }
    npcBranchArea.setText(branchText.toString());
    npcBranchArea.setCaretPosition(0);
  }

  private String nonEmptyJsonArray(String text) {
    String value = nonNull(text).trim();
    return value.isEmpty() ? "[]" : value;
  }

  private String emptyJsonArray(String text) {
    return text == null || text.trim().isEmpty() ? "[]" : text.trim();
  }

  private String nonNull(String text) {
    return text == null ? "" : text;
  }

  private String toJsonIntArray(List<Integer> values) {
    StringBuilder sb = new StringBuilder();
    sb.append('[');
    for(int i = 0; i < values.size(); i++) {
      if(i > 0) {
        sb.append(',');
      }
      sb.append(values.get(i).intValue());
    }
    sb.append(']');
    return sb.toString();
  }

  private static final class QuestTableModel extends AbstractTableModel {
    private final String[] columns = new String[] {
        "quest_id",
        "title",
        "start_dialog",
        "reward_exp",
        "reward_item_id",
        "reward_item_count",
        "reward_skill_ids"
    };

    private List<QuestEditorModel> rows = new ArrayList<QuestEditorModel>();

    void setRows(List<QuestEditorModel> rows) {
      this.rows = rows == null ? new ArrayList<QuestEditorModel>() : rows;
      fireTableDataChanged();
    }

    QuestEditorModel getRow(int row) {
      return rows.get(row);
    }

    @Override
    public int getRowCount() {
      return rows.size();
    }

    @Override
    public int getColumnCount() {
      return columns.length;
    }

    @Override
    public String getColumnName(int column) {
      return columns[column];
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
      QuestEditorModel row = rows.get(rowIndex);
      switch(columnIndex) {
        case 0:
          return row.questId;
        case 1:
          return row.title;
        case 2:
          if(row.stage != null && row.stage.dialogStageLines != null && !row.stage.dialogStageLines.isEmpty()) {
            return row.stage.dialogStageLines.get(0);
          }
          return row.stage == null ? "" : row.stage.startDialog;
        case 3:
          return row.rewardExp;
        case 4:
          return row.rewardItemIdJson;
        case 5:
          return row.rewardItemCountJson;
        case 6:
          return row.rewardSkillIdsJson;
        default:
          return "";
      }
    }
  }
}
