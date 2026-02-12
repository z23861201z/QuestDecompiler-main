package unluac.web.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import unluac.web.request.AdminNpcTextSaveRequest;
import unluac.web.result.AdminNpcTextItem;
import unluac.web.result.PagedResult;
import unluac.web.support.AdminRecentModifiedService;
import unluac.web.support.WebJdbcSupport;

public final class AdminNpcTextService {

  private final AdminRecentModifiedService recentModifiedService = new AdminRecentModifiedService();

  public PagedResult<AdminNpcTextItem> list(String jdbcUrl,
                                            String user,
                                            String password,
                                            Integer questId,
                                            String npcFile,
                                            String keyword,
                                            int page,
                                            int pageSize) throws Exception {
    int safePage = page <= 0 ? 1 : page;
    int safePageSize = pageSize <= 0 ? 20 : Math.min(pageSize, 100);
    int offset = (safePage - 1) * safePageSize;

    PagedResult<AdminNpcTextItem> out = new PagedResult<AdminNpcTextItem>();
    out.page = safePage;
    out.pageSize = safePageSize;

    try(Connection connection = WebJdbcSupport.open(jdbcUrl, user, password)) {
      ensureUpdatedAtColumn(connection);
      out.total = count(connection, questId, npcFile, keyword);
      String sql = "SELECT m.textId, m.npcFile, m.line, m.columnNumber, m.callType, m.rawText, m.modifiedText, m.astMarker,"
          + " COALESCE(q.linkedCount, 0) AS linkedQuestCount"
          + " FROM npc_text_edit_map m"
          + " LEFT JOIN (SELECT npc_file, COUNT(DISTINCT quest_id) AS linkedCount FROM npc_quest_reference GROUP BY npc_file) q"
          + " ON q.npc_file = m.npcFile"
          + " WHERE (? IS NULL OR ? = '' OR m.npcFile = ?)"
          + " AND (? IS NULL OR ? = '' OR m.rawText LIKE CONCAT('%', ?, '%') OR m.modifiedText LIKE CONCAT('%', ?, '%'))"
          + " AND (? IS NULL OR EXISTS (SELECT 1 FROM npc_quest_reference r WHERE r.npc_file=m.npcFile AND r.quest_id=?))"
          + " ORDER BY m.updated_at DESC, m.textId DESC LIMIT ? OFFSET ?";

      try(PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, npcFile);
        ps.setString(2, npcFile);
        ps.setString(3, npcFile);
        ps.setString(4, keyword);
        ps.setString(5, keyword);
        ps.setString(6, keyword);
        ps.setString(7, keyword);
        if(questId == null) {
          ps.setObject(8, null);
          ps.setObject(9, null);
        } else {
          ps.setInt(8, questId.intValue());
          ps.setInt(9, questId.intValue());
        }
        ps.setInt(10, safePageSize);
        ps.setInt(11, offset);

        try(ResultSet rs = ps.executeQuery()) {
          while(rs.next()) {
            AdminNpcTextItem item = new AdminNpcTextItem();
            item.textId = rs.getLong("textId");
            item.npcFile = rs.getString("npcFile");
            item.line = getNullableInt(rs, "line");
            item.columnNumber = getNullableInt(rs, "columnNumber");
            item.callType = rs.getString("callType");
            item.rawText = rs.getString("rawText");
            item.modifiedText = rs.getString("modifiedText");
            item.astMarker = rs.getString("astMarker");
            item.linkedQuestCount = getNullableInt(rs, "linkedQuestCount");
            item.recentModifiedAt = recentModifiedService.findNpcTextRecentModifiedAt(connection, item.textId);
            out.records.add(item);
          }
        }
      }
    }
    return out;
  }

  public int save(String jdbcUrl, String user, String password, long textId, AdminNpcTextSaveRequest request) throws Exception {
    if(request == null) {
      throw new IllegalArgumentException("request is required");
    }
    try(Connection connection = WebJdbcSupport.open(jdbcUrl, user, password)) {
      ensureUpdatedAtColumn(connection);
      String sql = "UPDATE npc_text_edit_map SET modifiedText=?, updated_at=NOW() WHERE textId=?";
      try(PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, request.modifiedText);
        ps.setLong(2, textId);
        return ps.executeUpdate();
      }
    }
  }

  private long count(Connection connection,
                     Integer questId,
                     String npcFile,
                     String keyword) throws Exception {
    String sql = "SELECT COUNT(*)"
        + " FROM npc_text_edit_map m"
        + " WHERE (? IS NULL OR ? = '' OR m.npcFile = ?)"
        + " AND (? IS NULL OR ? = '' OR m.rawText LIKE CONCAT('%', ?, '%') OR m.modifiedText LIKE CONCAT('%', ?, '%'))"
        + " AND (? IS NULL OR EXISTS (SELECT 1 FROM npc_quest_reference r WHERE r.npc_file=m.npcFile AND r.quest_id=?))";
    try(PreparedStatement ps = connection.prepareStatement(sql)) {
      ps.setString(1, npcFile);
      ps.setString(2, npcFile);
      ps.setString(3, npcFile);
      ps.setString(4, keyword);
      ps.setString(5, keyword);
      ps.setString(6, keyword);
      ps.setString(7, keyword);
      if(questId == null) {
        ps.setObject(8, null);
        ps.setObject(9, null);
      } else {
        ps.setInt(8, questId.intValue());
        ps.setInt(9, questId.intValue());
      }
      try(ResultSet rs = ps.executeQuery()) {
        if(rs.next()) {
          return rs.getLong(1);
        }
      }
    }
    return 0L;
  }

  private void ensureUpdatedAtColumn(Connection connection) throws Exception {
    if(hasColumn(connection, "npc_text_edit_map", "updated_at")) {
      return;
    }
    String ddl = "ALTER TABLE npc_text_edit_map ADD COLUMN updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP";
    try(PreparedStatement ps = connection.prepareStatement(ddl)) {
      ps.execute();
    } catch(Exception ignored) {
    }
  }

  private boolean hasColumn(Connection connection, String table, String column) throws Exception {
    String sql = "SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME=? AND COLUMN_NAME=? LIMIT 1";
    try(PreparedStatement ps = connection.prepareStatement(sql)) {
      ps.setString(1, table);
      ps.setString(2, column);
      try(ResultSet rs = ps.executeQuery()) {
        return rs.next();
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
}
