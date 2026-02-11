package unluac.web.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import unluac.web.request.AdminQuestSaveRequest;
import unluac.web.result.AdminQuestDetail;
import unluac.web.result.AdminQuestListItem;
import unluac.web.support.WebJdbcSupport;

public final class AdminQuestService {

  public List<AdminQuestListItem> list(String jdbcUrl, String user, String password, String keyword, int limit) throws Exception {
    int safeLimit = limit <= 0 ? 100 : Math.min(limit, 500);
    List<AdminQuestListItem> out = new ArrayList<AdminQuestListItem>();
    try(Connection connection = WebJdbcSupport.open(jdbcUrl, user, password)) {
      String sql = "SELECT quest_id, name, need_level, reward_exp, reward_gold FROM quest_main"
          + " WHERE (? IS NULL OR ? = '' OR name LIKE CONCAT('%', ?, '%') OR CAST(quest_id AS CHAR) LIKE CONCAT('%', ?, '%'))"
          + " ORDER BY quest_id ASC LIMIT ?";
      try(PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, keyword);
        ps.setString(2, keyword);
        ps.setString(3, keyword);
        ps.setString(4, keyword);
        ps.setInt(5, safeLimit);
        try(ResultSet rs = ps.executeQuery()) {
          while(rs.next()) {
            AdminQuestListItem item = new AdminQuestListItem();
            item.questId = rs.getInt("quest_id");
            item.name = rs.getString("name");
            item.needLevel = getNullableInt(rs, "need_level");
            item.rewardExp = getNullableInt(rs, "reward_exp");
            item.rewardGold = getNullableInt(rs, "reward_gold");
            out.add(item);
          }
        }
      }
    }
    return out;
  }

  public AdminQuestDetail detail(String jdbcUrl, String user, String password, int questId) throws Exception {
    AdminQuestDetail out = new AdminQuestDetail();
    out.questId = questId;
    try(Connection connection = WebJdbcSupport.open(jdbcUrl, user, password)) {
      String mainSql = "SELECT quest_id, name, need_level, bq_loop, reward_exp, reward_gold FROM quest_main WHERE quest_id=?";
      try(PreparedStatement ps = connection.prepareStatement(mainSql)) {
        ps.setInt(1, questId);
        try(ResultSet rs = ps.executeQuery()) {
          if(!rs.next()) {
            throw new IllegalStateException("quest not found: " + questId);
          }
          out.questId = rs.getInt("quest_id");
          out.name = rs.getString("name");
          out.needLevel = getNullableInt(rs, "need_level");
          out.bqLoop = getNullableInt(rs, "bq_loop");
          out.rewardExp = getNullableInt(rs, "reward_exp");
          out.rewardGold = getNullableInt(rs, "reward_gold");
        }
      }

      loadTextArray(connection, out.contents, "quest_contents", questId);
      loadTextArray(connection, out.answer, "quest_answer", questId);
      loadTextArray(connection, out.info, "quest_info", questId);
    }
    return out;
  }

  public int save(String jdbcUrl, String user, String password, int questId, AdminQuestSaveRequest request) throws Exception {
    if(request == null) {
      throw new IllegalArgumentException("request is required");
    }
    int changed = 0;
    try(Connection connection = WebJdbcSupport.open(jdbcUrl, user, password)) {
      connection.setAutoCommit(false);
      try {
        if(request.name != null) {
          changed += updateQuestName(connection, questId, request.name);
        }
        if(request.contents != null) {
          changed += replaceTextArray(connection, "quest_contents", questId, request.contents);
        }
        if(request.answer != null) {
          changed += replaceTextArray(connection, "quest_answer", questId, request.answer);
        }
        if(request.info != null) {
          changed += replaceTextArray(connection, "quest_info", questId, request.info);
        }
        connection.commit();
      } catch(Throwable ex) {
        connection.rollback();
        throw ex;
      } finally {
        connection.setAutoCommit(true);
      }
    }
    return changed;
  }

  private int updateQuestName(Connection connection, int questId, String name) throws Exception {
    String sql = "UPDATE quest_main SET name=? WHERE quest_id=?";
    try(PreparedStatement ps = connection.prepareStatement(sql)) {
      ps.setString(1, name);
      ps.setInt(2, questId);
      return ps.executeUpdate();
    }
  }

  private int replaceTextArray(Connection connection, String table, int questId, List<String> values) throws Exception {
    List<String> safeValues = values == null ? Collections.<String>emptyList() : values;
    int changed = 0;
    String deleteSql = "DELETE FROM " + table + " WHERE quest_id=?";
    try(PreparedStatement delete = connection.prepareStatement(deleteSql)) {
      delete.setInt(1, questId);
      changed += delete.executeUpdate();
    }

    if(!safeValues.isEmpty()) {
      String insertSql = "INSERT INTO " + table + "(quest_id, seq_index, text) VALUES(?,?,?)";
      try(PreparedStatement insert = connection.prepareStatement(insertSql)) {
        for(int i = 0; i < safeValues.size(); i++) {
          insert.setInt(1, questId);
          insert.setInt(2, i);
          insert.setString(3, safe(safeValues.get(i)));
          insert.addBatch();
        }
        int[] counts = insert.executeBatch();
        for(int c : counts) {
          if(c > 0) {
            changed += c;
          }
        }
      }
    }
    return changed;
  }

  private void loadTextArray(Connection connection, List<String> out, String table, int questId) throws Exception {
    String sql = "SELECT seq_index, text FROM " + table + " WHERE quest_id=? ORDER BY seq_index ASC";
    try(PreparedStatement ps = connection.prepareStatement(sql)) {
      ps.setInt(1, questId);
      try(ResultSet rs = ps.executeQuery()) {
        while(rs.next()) {
          out.add(rs.getString("text"));
        }
      }
    }
  }

  private Integer getNullableInt(ResultSet rs, String column) throws Exception {
    int value = rs.getInt(column);
    if(rs.wasNull()) {
      return null;
    }
    return Integer.valueOf(value);
  }

  private String safe(String value) {
    return value == null ? "" : value;
  }
}

