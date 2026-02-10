function npcsay(id)
  if id ~= 4320004 then
    return
  end
  clickNPCid = id
  NPC_SAY("ÏÖÔÚËäÈ»ÈõĞ¡£¬µ«ÊÇÎÒ±Ø¶¨»á±äµÃÇ¿´óÆğÀ´µÄ")
  if qData[2477].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("´ç½Å, ³ª¸¦ ¾î¶»°Ô Ã£¾ÒÁö?")
      SET_QUEST_STATE(2477, 2)
      return
    else
      NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
    end
  end
  if qData[2478].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("°â¼ÕÇÏ½Ç ÇÊ¿ä ¾ø½À´Ï´Ù. ÀÇÇù´ÔÀÌ ´ë´ÜÇÏ½Å °Ì´Ï´Ù.")
      SET_QUEST_STATE(2478, 2)
      return
    else
      NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
    end
  end
  if qData[2479].state == 1 then
    if qData[2479].killMonster[qt[2479].goal.killMonster[1].id] >= qt[2479].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("¹ú½á 130¸¶¸®¸¦ ÅğÄ¡ÇÏ½Å°Å¿ä? ¼ÒÀÎÀÌ Á³±¸·Á.")
        SET_QUEST_STATE(2479, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
      end
    else
      NPC_SAY("{0xFFFFFF00}Èæ±ÍÇ÷·Î{END}¿¡ Ãâ¸ôÇÏ´Â {0xFFFFFF00}¼ö±İ¾Æ{END} 130¸¶¸®¸¦ ´©°¡ ¸ÕÀú ÅğÄ¡ÇÏ´ÂÁö °æÀïÇØº¾½Ã´Ù.")
    end
  end
  if qData[2480].state == 1 then
    if qData[2480].killMonster[qt[2480].goal.killMonster[1].id] >= qt[2480].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("ÀÌ¹ø¿¡´Â ¼ÒÀÎÀÌ ÀÌ°å¼ÒÀÌ´Ù. ÇÏÁö¸¸ Á¤¸» °£¹ßÀÇ Â÷ÀÌ¿´¼Ò.")
        SET_QUEST_STATE(2480, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
      end
    else
      NPC_SAY("{0xFFFFFF00}Èæ±ÍÇ÷·Î{END}¿¡ Ãâ¸ôÇÏ´Â {0xFFFFFF00}ÅºÁÖ¾î{END} 150¸¶¸®¸¦ ´©°¡ ¸ÕÀú ÅğÄ¡ÇÏ´ÂÁö °æÀïÇØº¾½Ã´Ù.")
    end
  end
  if qData[2481].state == 1 then
    if qData[2481].killMonster[qt[2481].goal.killMonster[1].id] >= qt[2481].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("¹ú½á ´Ù ÅğÄ¡ÇÏ¼Ì¼ÒÀÌ±î? À½.. ÀÏ´Ü Á» ½¬¾ú´Ù ´Ù½Ã ¸¸³³½Ã´Ù. {0xFFFFFF00}146°ø·Â{END}ÀÌ µÇ¸é ´Ù½Ã º¸µµ·Ï ÇÏÁÒ.")
        SET_QUEST_STATE(2481, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
      end
    else
      NPC_SAY("{0xFFFFFF00}Èæ±ÍÇ÷·Î{END}¿¡ Ãâ¸ôÇÏ´Â {0xFFFFFF00}»ç·æ{END} 120¸¶¸®¸¦ ´©°¡ ¸ÕÀú ÅğÄ¡ÇÏ´ÂÁö °æÀïÇØº¾½Ã´Ù.")
    end
  end
  if qData[2482].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2482].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("¸¿¼Ò»ç, ¹ú½á ´Ù ±¸ÇÏ¼Ì´Ù°í¿ä?")
        SET_QUEST_STATE(2482, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
      end
    else
      NPC_SAY("{0xFFFFFF00}Èæ±ÍÇ÷·Î{END}¿¡ °¡¼­ {0xFFFFFF00}[¼ö±İ¾Æ]{END}¸¦ ÅğÄ¡ÇÏ°í {0xFFFFFF00}Ä®³¯²¿¸®{END}¸¦ 100°³¸¦ ¸ÕÀú ±¸ÇØ¿À¸é ÀÌ±â´Â °Ì´Ï´Ù.")
    end
  end
  if qData[2483].state == 1 then
    if CHECK_ITEM_CNT(qt[2483].goal.getItem[1].id) >= qt[2483].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("¾Æ´Ï, ÀÌ·²¼ö°¡! ÀÌ¹ø¿¡µµ ¼ÒÀÎÀÌ Áö´Ù´Ï..")
        SET_QUEST_STATE(2483, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
      end
    else
      NPC_SAY("{0xFFFFFF00}Èæ±ÍÇ÷·Î{END}¿¡ °¡¼­ {0xFFFFFF00}[ÅºÁÖ¾î]{END}¸¦ ÅğÄ¡ÇÏ°í {0xFFFFFF00}ÅºÁÖ¾î»¡ÆÇ{END}À» 100°³¸¦ ¸ÕÀú ±¸ÇØ¿À¸é ÀÌ±â´Â °Ì´Ï´Ù.")
    end
  end
  if qData[2484].state == 1 then
    if CHECK_ITEM_CNT(qt[2484].goal.getItem[1].id) >= qt[2484].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("Á¤¸»ÀÌÁö... ´ë´ÜÇÏ½Ê´Ï´Ù. ÀÌ¹ø¿¡µµ Á³½À´Ï´Ù.")
        SET_QUEST_STATE(2484, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
      end
    else
      NPC_SAY("{0xFFFFFF00}Èæ±ÍÇ÷·Î{END}¿¡ °¡¼­ {0xFFFFFF00}[»ç·æ]{END}¸¦ ÅğÄ¡ÇÏ°í {0xFFFFFF00}»ç·æ¼ö¿°{END}À» 100°³¸¦ ¸ÕÀú ±¸ÇØ¿À¸é ÀÌ±â´Â °Ì´Ï´Ù.")
    end
  end
  if qData[2485].state == 1 then
    NPC_SAY("¶æÇÏ½Å ¹Ù¸¦ ÀÌ·ç½Ã±â¸¦ ±â¿øÇÕ´Ï´Ù.")
    SET_QUEST_STATE(2485, 2)
    return
  end
  if qData[3679].state == 1 then
    if qData[3679].killMonster[qt[3679].goal.killMonster[1].id] >= qt[3679].goal.killMonster[1].count then
      NPC_SAY("ÔõÃ´»áÕâÑù£¡ÎÒÊäÁË~")
      SET_QUEST_STATE(3679, 2)
      return
    else
      NPC_SAY("ÊÇ¿´Ë­¸ü¿ìµÄ»÷ÍË{0xFFFFFF00}50¸öºÚ¹íÑªÂ·µÄÈËÉß¹Ö{END}µÄ¶Ô¾ö")
    end
  end
  if qData[3680].state == 1 then
    if qData[3680].killMonster[qt[3680].goal.killMonster[1].id] >= qt[3680].goal.killMonster[1].count then
      NPC_SAY("ÔõÃ´»áÕâÑù£¡ÎÒÊäÁË~")
      SET_QUEST_STATE(3680, 2)
      return
    else
      NPC_SAY("ÊÇ¿´Ë­¸ü¿ìµÄ»÷ÍË{0xFFFFFF00}50¸öºÚ¹íÑªÂ·µÄÍÌÖÛÓã{END}µÄ¶Ô¾ö")
    end
  end
  if qData[3681].state == 1 then
    if qData[3681].killMonster[qt[3681].goal.killMonster[1].id] >= qt[3681].goal.killMonster[1].count then
      NPC_SAY("ÔõÃ´»áÕâÑù£¡ÎÒÊäÁË~")
      SET_QUEST_STATE(3681, 2)
      return
    else
      NPC_SAY("ÊÇ¿´Ë­¸ü¿ìµÄ»÷ÍË{0xFFFFFF00}50¸öºÚ¹íÑªÂ·µÄĞ°Áú{END}µÄ¶Ô¾ö")
    end
  end
  if qData[3679].state == 0 and GET_PLAYER_LEVEL() >= qt[3679].needLevel then
    ADD_QUEST_BTN(qt[3679].id, qt[3679].name)
  end
  if qData[3680].state == 0 and GET_PLAYER_LEVEL() >= qt[3680].needLevel then
    ADD_QUEST_BTN(qt[3680].id, qt[3680].name)
  end
  if qData[3681].state == 0 and GET_PLAYER_LEVEL() >= qt[3681].needLevel then
    ADD_QUEST_BTN(qt[3681].id, qt[3681].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3679].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3679].needLevel then
    if qData[3679].state == 1 then
      if qData[3679].killMonster[qt[3679].goal.killMonster[1].id] >= qt[3679].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3680].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3680].needLevel then
    if qData[3680].state == 1 then
      if qData[3680].killMonster[qt[3680].goal.killMonster[1].id] >= qt[3680].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3681].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3681].needLevel then
    if qData[3681].state == 1 then
      if qData[3681].killMonster[qt[3681].goal.killMonster[1].id] >= qt[3681].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
