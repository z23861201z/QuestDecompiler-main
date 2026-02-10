package unluac.semantic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class QuestNpcDependencyGraph {

  public final Map<Integer, QuestNode> questNodes = new LinkedHashMap<Integer, QuestNode>();
  public final Map<String, NpcNode> npcNodes = new LinkedHashMap<String, NpcNode>();

  public QuestNode ensureQuestNode(int questId) {
    QuestNode node = questNodes.get(Integer.valueOf(questId));
    if(node == null) {
      node = new QuestNode();
      node.questId = questId;
      questNodes.put(Integer.valueOf(questId), node);
    }
    return node;
  }

  public NpcNode ensureNpcNode(String filePath) {
    String key = normalizePath(filePath);
    NpcNode node = npcNodes.get(key);
    if(node == null) {
      node = new NpcNode();
      node.filePath = key;
      npcNodes.put(key, node);
    }
    return node;
  }

  public void link(int questId, String npcFilePath) {
    QuestNode questNode = ensureQuestNode(questId);
    NpcNode npcNode = ensureNpcNode(npcFilePath);
    questNode.linkNpc(npcNode);
    npcNode.linkQuest(questNode);
  }

  public int totalEdges() {
    int count = 0;
    for(QuestNode questNode : questNodes.values()) {
      count += questNode.referencedNpcs.size();
    }
    return count;
  }

  public List<Integer> highRiskQuestIds() {
    List<Integer> out = new ArrayList<Integer>();
    for(QuestNode questNode : questNodes.values()) {
      if("HIGH".equals(QuestNode.normalizeRisk(questNode.riskLevel))) {
        out.add(Integer.valueOf(questNode.questId));
      }
    }
    Collections.sort(out);
    return out;
  }

  public List<List<String>> stronglyConnectedComponents() {
    // 双向边下，每个连通块即强连通块
    Set<String> visited = new LinkedHashSet<String>();
    List<List<String>> components = new ArrayList<List<String>>();

    for(QuestNode questNode : questNodes.values()) {
      String start = questVertexKey(questNode.questId);
      if(visited.contains(start)) {
        continue;
      }
      List<String> component = bfsComponent(start, visited);
      if(!component.isEmpty()) {
        Collections.sort(component, String.CASE_INSENSITIVE_ORDER);
        components.add(component);
      }
    }

    for(NpcNode npcNode : npcNodes.values()) {
      String start = npcVertexKey(npcNode.filePath);
      if(visited.contains(start)) {
        continue;
      }
      List<String> component = bfsComponent(start, visited);
      if(!component.isEmpty()) {
        Collections.sort(component, String.CASE_INSENSITIVE_ORDER);
        components.add(component);
      }
    }

    Collections.sort(components, (a, b) -> Integer.compare(b.size(), a.size()));
    return components;
  }

  private List<String> bfsComponent(String start, Set<String> visited) {
    List<String> queue = new ArrayList<String>();
    List<String> component = new ArrayList<String>();
    queue.add(start);
    visited.add(start);

    for(int i = 0; i < queue.size(); i++) {
      String current = queue.get(i);
      component.add(current);
      for(String next : adjacent(current)) {
        if(visited.add(next)) {
          queue.add(next);
        }
      }
    }
    return component;
  }

  private List<String> adjacent(String vertex) {
    List<String> out = new ArrayList<String>();
    if(vertex == null || vertex.isEmpty()) {
      return out;
    }
    if(vertex.startsWith("Q:")) {
      int qid = parseIntSafe(vertex.substring(2));
      QuestNode questNode = questNodes.get(Integer.valueOf(qid));
      if(questNode == null) {
        return out;
      }
      for(NpcNode npc : questNode.referencedNpcs) {
        out.add(npcVertexKey(npc.filePath));
      }
      return out;
    }

    if(vertex.startsWith("N:")) {
      String file = vertex.substring(2);
      NpcNode npcNode = npcNodes.get(file);
      if(npcNode == null) {
        return out;
      }
      for(QuestNode quest : npcNode.referencedQuests) {
        out.add(questVertexKey(quest.questId));
      }
      return out;
    }
    return out;
  }

  private int parseIntSafe(String text) {
    try {
      return Integer.parseInt(text.trim());
    } catch(Exception ex) {
      return -1;
    }
  }

  public static String questVertexKey(int questId) {
    return "Q:" + questId;
  }

  public static String npcVertexKey(String filePath) {
    return "N:" + normalizePath(filePath);
  }

  public static String normalizePath(String filePath) {
    if(filePath == null) {
      return "";
    }
    return filePath.replace('\\', '/').trim();
  }
}

