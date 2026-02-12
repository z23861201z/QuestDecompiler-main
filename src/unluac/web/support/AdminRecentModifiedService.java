package unluac.web.support;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;

public final class AdminRecentModifiedService {

  private static final DateTimeFormatter FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

  public String findQuestRecentModifiedAt(Connection connection, int questId) throws Exception {
    String sql = "SELECT MAX(v.ts) AS latestTs FROM ("
        + " SELECT updated_at AS ts FROM quest_main WHERE quest_id=?"
        + " UNION ALL SELECT updated_at AS ts FROM quest_contents WHERE quest_id=?"
        + " UNION ALL SELECT updated_at AS ts FROM quest_answer WHERE quest_id=?"
        + " UNION ALL SELECT updated_at AS ts FROM quest_info WHERE quest_id=?"
        + " UNION ALL SELECT updated_at AS ts FROM quest_goal_getitem WHERE quest_id=?"
        + " UNION ALL SELECT updated_at AS ts FROM quest_goal_killmonster WHERE quest_id=?"
        + " UNION ALL SELECT updated_at AS ts FROM quest_goal_meetnpc WHERE quest_id=?"
        + " UNION ALL SELECT updated_at AS ts FROM quest_reward_item WHERE quest_id=?"
        + ") v";
    try(PreparedStatement ps = connection.prepareStatement(sql)) {
      for(int i = 1; i <= 8; i++) {
        ps.setInt(i, questId);
      }
      try(ResultSet rs = ps.executeQuery()) {
        if(rs.next()) {
          java.sql.Timestamp ts = rs.getTimestamp("latestTs");
          if(ts != null) {
            return FMT.format(ts.toInstant().atOffset(OffsetDateTime.now().getOffset()));
          }
        }
      }
    } catch(Exception ignored) {
    }
    return FMT.format(OffsetDateTime.now());
  }

  public String findNpcTextRecentModifiedAt(Connection connection, long textId) throws Exception {
    String sql = "SELECT updated_at FROM npc_text_edit_map WHERE textId=?";
    try(PreparedStatement ps = connection.prepareStatement(sql)) {
      ps.setLong(1, textId);
      try(ResultSet rs = ps.executeQuery()) {
        if(rs.next()) {
          java.sql.Timestamp ts = rs.getTimestamp("updated_at");
          if(ts != null) {
            return FMT.format(ts.toInstant().atOffset(OffsetDateTime.now().getOffset()));
          }
        }
      }
    } catch(Exception ignored) {
    }
    return FMT.format(OffsetDateTime.now());
  }

  public String now() {
    return FMT.format(OffsetDateTime.now());
  }
}

