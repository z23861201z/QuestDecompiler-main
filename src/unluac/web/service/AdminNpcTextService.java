package unluac.web.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import unluac.web.request.AdminNpcTextSaveRequest;
import unluac.web.result.AdminNpcTextItem;
import unluac.web.support.WebJdbcSupport;

public final class AdminNpcTextService {

  public List<AdminNpcTextItem> list(String jdbcUrl,
                                     String user,
                                     String password,
                                     Integer questId,
                                     String npcFile,
                                     String keyword,
                                     int limit) throws Exception {
    int safeLimit = limit <= 0 ? 200 : Math.min(limit, 1000);
    List<AdminNpcTextItem> out = new ArrayList<AdminNpcTextItem>();
    try(Connection connection = WebJdbcSupport.open(jdbcUrl, user, password)) {
      String sql = "SELECT m.textId, m.npcFile, m.line, m.columnNumber, m.callType, m.rawText, m.modifiedText, m.astMarker,"
          + " COALESCE(q.linkedCount, 0) AS linkedQuestCount"
          + " FROM npc_text_edit_map m"
          + " LEFT JOIN (SELECT npc_file, COUNT(DISTINCT quest_id) AS linkedCount FROM npc_quest_reference GROUP BY npc_file) q"
          + " ON q.npc_file = m.npcFile"
          + " WHERE (? IS NULL OR ? = '' OR m.npcFile = ?)"
          + " AND (? IS NULL OR ? = '' OR m.rawText LIKE CONCAT('%', ?, '%') OR m.modifiedText LIKE CONCAT('%', ?, '%'))"
          + " AND (? IS NULL OR EXISTS (SELECT 1 FROM npc_quest_reference r WHERE r.npc_file=m.npcFile AND r.quest_id=?))"
          + " ORDER BY m.npcFile ASC, m.line ASC, m.columnNumber ASC LIMIT ?";

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
        ps.setInt(10, safeLimit);

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
            out.add(item);
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
      String sql = "UPDATE npc_text_edit_map SET modifiedText=? WHERE textId=?";
      try(PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, request.modifiedText);
        ps.setLong(2, textId);
        return ps.executeUpdate();
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

