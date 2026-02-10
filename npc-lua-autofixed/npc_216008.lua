function npcsay(id)
  if id ~= 4216008 then
    return
  end
  clickNPCid = id
  NPC_SAY("ÏÖÔÚÎÒÖ»ÓĞÕâĞ©ÁË£¬ÏëÂò¾ÍÂò°É¡£")
  if qData[1011].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1011].goal.getItem) then
      NPC_SAY("ÕæÌ«¸ĞĞ»ÄúµÄ°ïÃ¦ÁË¡£ÎÒÄÜ±¨´ğµÄ¾ÍÖ»ÓĞÕâĞ©ÁË")
      SET_QUEST_STATE(1011, 2)
      return
    else
      NPC_SAY("»¹²»¹»{0xFFFFFF00}50¸öÆÆ¾ÉÖá»­{END}Ã´£¿")
      return
    end
  end
  if qData[1012].state == 1 then
    NPC_SAY("Ã»Ê±¼äÁË¡£¿ìÒ»µã¶ù")
    return
  end
  if qData[2354].state == 1 and qData[2354].meetNpc[1] ~= id then
    NPC_SAY("À§Áö¼ö´ÔÀ» Ã£´Â´Ù°í¿ä? ±Û½ê¿ä. º¸½Ã´Â ¹Ù¿Í °°ÀÌ ¿©±â´Â Àú¸¦ Æ÷ÇÔÇØ¼­ ¼¼»ç¶÷»ÓÀÔ´Ï´Ù.")
    SET_MEETNPC(2354, 1, id)
  end
  if qData[2419].state == 1 then
    NPC_SAY("ÀÌ ¿ÜÁø °÷¿¡ ¾îÂî »ç¶÷ÀÌ ´Ù Ã£¾Æ¿Ô´Â°í?")
    SET_QUEST_STATE(2419, 2)
    return
  end
  if qData[2420].state == 1 then
    NPC_SAY("¹è¸¦ °íÃÄ¾ß µË´Ï´Ù. È­Â÷·ûÀ» ÅğÄ¡ÇÏ°í {0xFFFFFF00}±×À»¸°³ª¹«Á¶°¢ 30°³{END}¸¦ ±¸ÇØ¼­ »ç°ø´Ô²² ÀüÇØµå¸®¼¼¿ä.")
  end
  if qData[2422].state == 1 then
    NPC_SAY("°¡Àå °¡±î¿î °÷Àº {0xFFFFFF00}°í¶ôÃÌÀÇ¿ø´ÔÀÌ °è½Ã´Â °í¶ôÃÌÀÔ´Ï´Ù.{END}")
  end
  if qData[2439].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2439].goal.getItem) then
      NPC_SAY("°¨»çÇÕ´Ï´Ù.")
      SET_QUEST_STATE(2439, 2)
      return
    else
      NPC_SAY("±ÍÁÖµµ¿¡¼­¸¸ ³ª´Â ¹°°ÇµéÀÔ´Ï´Ù. {0xFFFFFF00}ÈæÇÏµ¿µÎ°³°ñ°ú ¿øÇü»ÀÁ¶°¢À» 10°³¾¿{END} ±¸ÇØÁÖ½Ã¸é µË´Ï´Ù. ÈæÇÏµ¿µÎ°³°ñÀº ÈæÇÏµ¿À», ¿øÇü»ÀÁ¶°¢Àº ÃËÀ½À» ÅğÄ¡ÇÏ°í ¾òÀ» ¼ö ÀÖ½À´Ï´Ù.")
    end
  end
  if qData[2440].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2440].goal.getItem) then
      NPC_SAY("°¨»çÇÕ´Ï´Ù.")
      SET_QUEST_STATE(2440, 2)
      return
    else
      NPC_SAY("±ÍÁÖµµ¿¡ °¡¼Å¼­ {0xFFFFFF00}ÈæÇÏµ¿µÎ°³°ñÀ» 70°³{END}¸¸ ±¸ÇØÁÖ¼¼¿ä. ÈæÇÏµ¿µÎ°³°ñÀº ÈæÇÏµ¿À» ÅğÄ¡ÇÏ°í ¾òÀ» ¼ö ÀÖ½À´Ï´Ù.")
    end
  end
  if qData[2441].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2441].goal.getItem) then
      NPC_SAY("°¨»çÇÕ´Ï´Ù. ±¸ÇØÁÖ½Å ±ÍÁÖµµÀÇ ¹°°ÇµéÀº Àß ¾²°Ú½À´Ï´Ù.")
      SET_QUEST_STATE(2441, 2)
      return
    else
      NPC_SAY("±ÍÁÖµµ¿¡ °¡¼Å¼­ ÃËÀ½À» ÅğÄ¡ÇÏ°í {0xFFFFFF00}¿øÇü»ÀÁ¶°¢ 70°³{END}¸¸ ±¸ÇØÁÖ¼¼¿ä.")
    end
  end
  if qData[2489].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("¿À·£¸¸¿¡ ºË½À´Ï´Ù. ¹«½¼ ÀÏ·Î ¿À¼Ì³ª¿ä?")
      SET_QUEST_STATE(2489, 2)
      return
    else
      NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù!")
    end
  end
  if qData[2490].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2490].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("ÁÁ½À´Ï´Ù. ¹Ù·Î »óÀÚ¸¦ ¼ö¸®ÇÏ°Ú½À´Ï´Ù.")
        SET_QUEST_STATE(2490, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù!")
      end
    else
      NPC_SAY("{0xFFFFFF00}»ï°­µ¿Àüµî»ÔÀº Èæ±ÍÁÖ¿ø¿¡¼­ »ï°­µ¿ÀüÀ» ÅğÄ¡ÇÏ¸é{END} ±¸ÇÒ ¼ö ÀÖ½À´Ï´Ù. {0xFFFFFF00}»ï°­µ¿Àüµî»Ô 50°³{END}¸¦ ±¸ÇØÁÖ¼¼¿ä.")
    end
  end
  if qData[2491].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2491].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("¾îµğ.. ¸Â±º¿ä. Á¦°¡ ÁßÈ­½ÃÅ°°Ú½À´Ï´Ù.")
        SET_QUEST_STATE(2491, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù!")
      end
    else
      NPC_SAY("{0xFFFFFF00}»çºÀ±Íµ¶Ä§Àº ¹é±ÍÁÖ¿ø¿¡¼­ »çºÀ±Í¸¦ ÅğÄ¡ÇÏ¸é{END} ±¸ÇÒ ¼ö ÀÖ½À´Ï´Ù. {0xFFFFFF00}»çºÀ±Íµ¶Ä§ 70°³{END}¸¦ ±¸ÇØÁÖ¼¼¿ä.")
    end
  end
  if qData[2492].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2492].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("¾îµğ.. ¸Â±º¿ä.")
        SET_QUEST_STATE(2492, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù!")
      end
    else
      NPC_SAY("{0xFFFFFF00}Èæ±ÍÁÖ¿ø¿¡¼­ À°¾È±Í{END}¸¦ ÅğÄ¡ÇÏ°í {0xFFFFFF00}À°¾È±Í¼ö¾× 50°³{END}¸¦, {0xFFFFFF00}Èæ±ÍÇ÷·Î¿¡¼­ ÅºÁÖ¾î{END}¸¦ ÅğÄ¡ÇÏ°í {0xFFFFFF00}ÅºÁÖ¾î»¡ÆÇ 50°³{END}¸¦ ±¸ÇØÁÖ¼¼¿ä.")
    end
  end
  if qData[2493].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2493].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("ÁÁ½À´Ï´Ù. ÀÌÁ¦ ¸ğµç ÁØºñ°¡ ³¡³µ½À´Ï´Ù. ¿©±â {0xFFFFFF00}±¸±Ş¾à»óÀÚ{END}ÀÔ´Ï´Ù.")
        SET_QUEST_STATE(2493, 2)
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù!")
      end
    else
      NPC_SAY("{0xFFFFFF00}Èæ±ÍÇ÷·Î¿¡¼­ »ç·æ{END}À» ÅğÄ¡ÇÏ½Ã°í {0xFFFFFF00}»ç·æ¼ö¿°{END}À» 35°³¸¦ ±¸ÇØ¿À½Ã¸é µË´Ï´Ù.")
    end
  end
  if qData[3666].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3666].goal.getItem) then
      NPC_SAY("Ğ»Ğ»£¡")
      SET_QUEST_STATE(3666, 2)
      return
    else
      NPC_SAY("°ïÃ¦ÊÕ¼¯{0xFFFFFF00}»¢Í·Éß¹Ö{END}µÄ{0xFFFFFF00}60¸ö¹ÖÒìµÄ»¢Æ¤{END}»ØÀ´°É")
    end
  end
  if qData[3667].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3667].goal.getItem) then
      NPC_SAY("Ğ»Ğ»£¡")
      SET_QUEST_STATE(3667, 2)
      return
    else
      NPC_SAY("°ïÃ¦ÊÕ¼¯{0xFFFFFF00}Öá»­ÑıÅ®{END}µÄ{0xFFFFFF00}60¸öÆÆ¾ÉÖá»­{END}»ØÀ´°É")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10035)
  if qData[1011].state == 0 then
    ADD_QUEST_BTN(qt[1011].id, qt[1011].name)
  end
  if qData[1012].state == 0 then
    ADD_QUEST_BTN(qt[1012].id, qt[1012].name)
  end
  if qData[3666].state == 0 and GET_PLAYER_LEVEL() >= qt[3666].needLevel then
    ADD_QUEST_BTN(qt[3666].id, qt[3666].name)
  end
  if qData[3667].state == 0 and GET_PLAYER_LEVEL() >= qt[3667].needLevel then
    ADD_QUEST_BTN(qt[3667].id, qt[3667].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1011].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1011].needLevel then
    if qData[1011].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1011].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1012].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1012].needLevel then
    if qData[1012].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3666].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3666].needLevel then
    if qData[3666].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3666].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3667].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3667].needLevel then
    if qData[3667].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3667].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
