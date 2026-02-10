function npcsay(id)
  if id ~= 4316013 then
    return
  end
  clickNPCid = id
  if qData[1009].state == 1 then
    if qData[1009].killMonster[qt[1009].goal.killMonster[1].id] >= qt[1009].goal.killMonster[1].count then
      NPC_SAY("Äã·âÓ¡ÁË»ğ³µÂÖ¹Ö¡­ÏÖÔÚÎíÆøÏûÉ¢£¬¿ÉÒÔ¿ª´¬ÁË")
      SET_QUEST_STATE(1009, 2)
      return
    else
      NPC_SAY("Çë·âÓ¡{0xFFFFFF00}50Ö»»ğ³µÂÖ¹Ö{END}")
      return
    end
  end
  if qData[1426].state == 1 then
    NPC_SAY("°¥ßÏ£¬ÔÙÕâÑùÏÂÈ¥¸Ã²»»áÓÀÔ¶Ò²¿ª²»ÁË´¬ÁË°É¡­")
    SET_QUEST_STATE(1426, 2)
  end
  if qData[1427].state == 1 then
    if qData[1427].killMonster[qt[1427].goal.killMonster[1].id] >= qt[1427].goal.killMonster[1].count then
      NPC_SAY("ÕæµÄ£¿60Ö»È«²¿¶¼»÷ÍËÁË£¿ÁË²»Æğ°¡£¡")
      SET_QUEST_STATE(1427, 2)
      return
    else
      NPC_SAY("Çë°ïÃ¦»÷ÍË¹ÅÀÏµÄ¶ÉÍ·µÄ{0xFFFFFF00}60Ö»»ğ³µÂÖ¹Ö{END}")
      return
    end
  end
  if qData[1428].state == 1 then
    NPC_SAY("ÄãÒªÈ¥¼ûÉúËÀÖ®ËşÈë¿ÚµÄÎäÒÕÉ®³¤¾­£¿Ï£ÍûÄÜÓĞµã¶ùÊ²Ã´°ì·¨")
  end
  if qData[1430].state == 1 then
    NPC_SAY("àÅ£¿Ì«ºÍÀÏ¾ıµÄµÜ×Ó£¿")
    SET_QUEST_STATE(1430, 2)
  end
  if qData[1431].state == 1 then
    NPC_SAY("ÄÇÀï£¬ÔÚ´¬Í·à«à«×ÔÓïµÄÀÏÈË")
  end
  if qData[2354].state == 1 and qData[2354].meetNpc[1] == qt[2354].goal.meetNpc[1] and qData[2354].meetNpc[2] ~= id then
    NPC_SAY("À§Áö¼ö´Ô? Á÷Á¢ ¿©±æ º¸°í ±×·± ¼Ò¸± ÇÏ¼î. Àú Àå»ç²ÛÇÏ°í ³ª, ±×¸®°í Àú ¿·¿¡ ½Ç¼ºÇÑ ³ëÀÎ»ÓÀÎµ¥.")
    SET_MEETNPC(2354, 2, id)
    return
  end
  if qData[2378].state == 1 then
    NPC_SAY("¿©±ä ¾îÂ¾ÀÏÀÌ½ÅÁö¿ä?")
    SET_QUEST_STATE(2378, 2)
    return
  end
  if qData[2379].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2379].goal.getItem) then
      NPC_SAY("°í¸¿±¸·Á. ´ç½ÅÀº Á¤¸» ÁÁÀº »ç¶÷ÀÌ±¸·Á.")
      SET_QUEST_STATE(2379, 2)
      return
    else
      NPC_SAY("¹¹... ¹Ù»Ú¸é ¾ÈÇØÁàµµ ÁÁ¼Ò. ÇØÁÙ ¼ö ÀÖ´Ù¸é {0xFFFFFF00}±×À»¸°³ª¹«Á¶°¢ 30°³{END}¸¸ Á» ±¸ÇØÁÖ½Ã¿À. È­Â÷·ûÀ» Ã³Ä¡ÇÏ¸é ±¸ÇÒ ¼ö ÀÖ¼ÒÀÌ´Ù.")
    end
  end
  if qData[2418].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("ÀÇÇù´ÔÀº Ç×»ó ¿©·¯°¡Áö·Î »ç¶÷À» ³î¶ó°Ô ÇÏ´Â±º¿ä.")
      SET_QUEST_STATE(2418, 2)
      return
    else
      NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
    end
  end
  if qData[2419].state == 1 then
    NPC_SAY("»ç¶÷ ÇÑ¹ø µµ¿ÍÁá´Ù°í »ı»ö³»´Â °ÇÁö ¹ºÁö...")
  end
  if qData[2420].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2420].goal.getItem) then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("ÀÌ°Ô... ¹¼´Ï±î? ¿¹? ¹è¸¦ ¼ö¸®ÇÏ´Âµ¥ ¾²¶ó°í¿ä?")
      SET_QUEST_STATE(2420, 2)
      return
    else
      NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
    end
  end
  if qData[2421].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2421].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("°¨»çÇÕ´Ï´Ù. °¡... °¨»çÇÕ´Ï´Ù.")
        SET_QUEST_STATE(2421, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
      end
    else
      NPC_SAY("¾ÆÀÌ°í, Á¦¹ß Á»... »ì·ÁÁÖ¼¼¿ä.{0xFFFFFF00}Á×¿±Ã»ÁÖ 10°³...{END}")
    end
  end
  if qData[2423].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2423].goal.getItem) then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("¾ÆÀÌ°í ¹è¾ß... ÀÌ°Ô ¹¼´Ï±î?")
      SET_QUEST_STATE(2423, 2)
      return
    else
      NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
    end
  end
  if qData[2424].state == 1 then
    NPC_SAY("Àß ÀÌÇØ´Â ¾ÈµÇÁö¸¸... ¾Ë°Ú½À´Ï´Ù. ´õ´Â ÀÇ½ÉÇÏÁö ¾Ê°Ú½À´Ï´Ù.")
    SET_QUEST_STATE(2424, 2)
    return
  end
  if qData[2425].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2425].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("°í¸¿½À´Ï´Ù. ¹Ù·Î ¼ö¸®¸¦ ½ÃÀÛÇÏÁÒ. 136°ø·ÂÀÌ µÇ¸é ´Ù½Ã Ã£¾Æ¿ÍÁÖ¼¼¿ä.")
        SET_QUEST_STATE(2425, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
      end
    else
      NPC_SAY("¼ö¸® Àç·á·Î {0xFFFFFF00}ÀÌ»óÇÑÈ£ÇÇ 50°³¿Í ³°ÀºÁ·ÀÚ30°³{END}°¡ ÇÊ¿äÇÕ´Ï´Ù. È«»ìÀÌ±Í½Å°ú Á·ÀÚ¿ä³à¸¦ ÅğÄ¡ÇÏ¸é ¾òÀ» ¼ö ÀÖ½À´Ï´Ù.")
    end
  end
  if qData[2426].state == 1 then
    NPC_SAY("±ÍÁÖµµ¶ó...")
  end
  if qData[2436].state == 1 then
    NPC_SAY("µµ¿òÀÌ µÇ¼­ Àúµµ ±â»Ş´Ï´Ù.")
    SET_QUEST_STATE(2436, 2)
    return
  end
  if qData[2442].state == 1 then
    if CHECK_ITEM_CNT(qt[2442].goal.getItem[1].id) >= qt[2442].goal.getItem[1].count then
      NPC_SAY("°¨»çÇÕ´Ï´Ù. Á¤¸» °í¸¿½À´Ï´Ù.")
      SET_QUEST_STATE(2442, 2)
      return
    else
      NPC_SAY("È«»ìÀÌ±Í½ÅÀ» ÅğÄ¡ÇÏ°í {0xFFFFFF00}ÀÌ»óÇÑÈ£ÇÇ 65°³{END}·Î ¹è ¹Ù´ÚÀ» ¼Õº¸°í ½Í½À´Ï´Ù.")
    end
  end
  if qData[2443].state == 1 then
    if CHECK_ITEM_CNT(qt[2443].goal.getItem[1].id) >= qt[2443].goal.getItem[1].count then
      NPC_SAY("°¨»çÇÕ´Ï´Ù. ²À ÇÊ¿äÇÑ °÷¿¡¸¸ ¾²°Ú½À´Ï´Ù.")
      SET_QUEST_STATE(2443, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}¸ÍÆÄ±Í´«¾Ë 30°³{END}ÀÔ´Ï´Ù. ¸ÍÆÄ±Í¸¦ ÅğÄ¡ÇÏ¸é ¾òÀ» ¼ö ÀÖ½À´Ï´Ù.")
    end
  end
  if qData[2444].state == 1 then
    if CHECK_ITEM_CNT(qt[2444].goal.getItem[1].id) >= qt[2444].goal.getItem[1].count then
      NPC_SAY("Á¤¸» °¨»çÇÕ´Ï´Ù. ¹è´Â °ğ ¼ö¸®µÉ °Ì´Ï´Ù. Á¤¸» °í¸¿½À´Ï´Ù.")
      SET_QUEST_STATE(2444, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}¸ğ·¡²ö²öÀÌ 90°³{END}¸¸ Á» ºÎÅ¹µå¸³´Ï´Ù. Èä¾È¸¶³à¸¦ ¹°¸®Ä¡¸é ¾òÀ» ¼ö ÀÖ½À´Ï´Ù.")
    end
  end
  if qData[2445].state == 1 then
    NPC_SAY("{0xFFFFFF00}±ÍÁÖµµ{END}·Î Ãâ¹ßÇÕ´Ï´Ù.")
  end
  if qData[2450].state == 1 then
    NPC_SAY("µµÂøÇß½À´Ï´Ù. ¿À·¡µÈ³ª·çÅÍÀÔ´Ï´Ù. Á» ½¬¾ú´Ù°¡ {0xFFFFFF00}139°ø·Â{END}ÀÌ µÇ½Ã¸é Ã£¾Æ¿ÍÁÖ¼¼¿ä.")
    SET_QUEST_STATE(2450, 2)
    return
  end
  if qData[2451].state == 1 then
    NPC_SAY("½Ä·®À» ³Ë³ËÇÏ°Ô ±¸ÇØ¼­ ´Ù½Ã °ÅºÏ¼¶À¸·Î °¡½ÃÁÒ.")
    SET_QUEST_STATE(2451, 2)
    return
  end
  if qData[2452].state == 1 then
    if CHECK_ITEM_CNT(qt[2452].goal.getItem[1].id) >= qt[2452].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2452].goal.getItem[2].id) >= qt[2452].goal.getItem[2].count and CHECK_ITEM_CNT(qt[2452].goal.getItem[3].id) >= qt[2452].goal.getItem[3].count then
      NPC_SAY("Á¤È®ÇÏ±º¿ä. ¹ö¼¸°ú ¿ìÀ°Æ÷´Â Àß ¸»¸®¸é ¿À·¡ º¸°üÇÒ ¼ö ÀÖÁÒ. ±×¸®°í ¼ÒÀÇ»ÔÀº ±¹¹°ÀÇ Àç·á·Î ¾´´ä´Ï´Ù.")
      SET_QUEST_STATE(2452, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}ÃµÀ½°è´Ü{END}¿¡¼­ {0xFFFFFF00}ÅğºÎµµ¿Í »ê°í{END}¸¦ ÅğÄ¡ÇÏ½Ã¸é µË´Ï´Ù. {0xFFFFFF00}ÅğºÎµµ´Â ¼ÒÀÇ»Ô{END}À», {0xFFFFFF00}»ê°í´Â »ê°í¹ö¼¸{END}À» Áİ´Ï´Ù.")
    end
  end
  if qData[2453].state == 1 then
    if CHECK_ITEM_CNT(qt[2453].goal.getItem[1].id) >= qt[2453].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2453].goal.getItem[2].id) >= qt[2453].goal.getItem[2].count then
      NPC_SAY("¾îÀÌÄí °íµå¸§Àº ¾ğÁ¦ºÁµµ Âü Â÷°©±º¿ä. Æí¸¶±ÍÄÚ°¡ »¡¸® »óÇÏ´Â °ÍÀ» ¸·¾ÆÁÙ°Ì´Ï´Ù.")
      SET_QUEST_STATE(2453, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}°íµå¸§ 20°³´Â ÃµÀ½¼±±³ÀÇ ºù±ØÀÎ{END}¿¡°Ô¼­, {0xFFFFFF00}Æí¸¶±ÍÄÚ 50°³´Â ¼­À§Çù°î¿¡¼­ Æí¸¶±Í{END}¸¦ ÅğÄ¡ÇÏ¸é ¾òÀ» ¼ö ÀÖ½À´Ï´Ù.")
    end
  end
  if qData[2454].state == 1 then
    if CHECK_ITEM_CNT(qt[2454].goal.getItem[1].id) >= qt[2454].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2454].goal.getItem[2].id) >= qt[2454].goal.getItem[2].count then
      NPC_SAY("¿¹. °¨»çÇÕ´Ï´Ù. Àúµµ ÀÌ°ÍÀú°Í °³º°ÀûÀ¸·Î ÁØºñ¸¦ ÇØ¾ßÇÏ´Ï±î {0xFFFFFF00}140°ø·Â{END}ÀÌ µÇ¸é ´Ù½Ã Ã£¾Æ¿ÍÁÖ¼¼¿ä. ±×¶§±îÁö ÁØºñ¸¦ ¸¶Ä¡°í ±â´Ù¸®°Ú½À´Ï´Ù.")
      SET_QUEST_STATE(2454, 2)
      return
    else
      NPC_SAY("°í¶ôÃÌÀÇ {0xFFFFFF00}°í¶ôÃÌÀÇ¿ø´Ô{END}¸»°íµµ ´Ù¸¥ °÷¿¡¼­µµ ±¸ÇÏ½Ç ¼ö ÀÖ½À´Ï´Ù. Àß Ã£¾Æº¸¼¼¿ä.")
    end
  end
  if qData[2455].state == 1 then
    NPC_SAY("ÀÌ ¹è´Â ±ÍÁÖµµ, ¿¾ °ÅºÏ¼¶À¸·Î °©´Ï´Ù.")
  end
  if qData[2489].state == 1 then
    NPC_SAY("ÀÇÇù´Ô ´öºĞ¿¡ Àúµµ ¸¹Àº °ÍÀ» ¹è¿ü½À´Ï´Ù. °¨»çÇÕ´Ï´Ù.")
  end
  if qData[2494].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("°í¸¿½À´Ï´Ù. Àı´ë ÀØÁö ¾Ê°Ú½À´Ï´Ù.")
      SET_QUEST_STATE(2494, 2)
      return
    else
      NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù!")
    end
  end
  if qData[3664].state == 1 then
    if CHECK_ITEM_CNT(qt[3664].goal.getItem[1].id) >= qt[3664].goal.getItem[1].count then
      NPC_SAY("Ğ»Ğ»£¡")
      SET_QUEST_STATE(3664, 2)
      return
    else
      NPC_SAY("Ö»ÒªÓĞ{0xFFFFFF00}60¸öÑ¬ºÚµÄÄ¾¿é{END}¾Í¿ÉÒÔ¡£»÷ÍË»ğ³µÂÖ¹Ö¾ÍÄÜÊÕ¼¯µ½")
    end
  end
  if qData[3665].state == 1 then
    if CHECK_ITEM_CNT(qt[3665].goal.getItem[1].id) >= qt[3665].goal.getItem[1].count then
      NPC_SAY("Ğ»Ğ»£¡")
      SET_QUEST_STATE(3665, 2)
      return
    else
      NPC_SAY("Ö»ÒªÓĞ{0xFFFFFF00}60¸ö¹íÃ«±Ê{END}¾Í¿ÉÒÔ¡£»÷ÍËÃ«±Ê¹Ö¾ÍÄÜÊÕ¼¯µ½")
    end
  end
  NPC_WARP_THEME_37(id)
  if qData[1009].state == 0 then
    ADD_QUEST_BTN(qt[1009].id, qt[1009].name)
  end
  if qData[1427].state == 0 and qData[1426].state == 2 and GET_PLAYER_LEVEL() >= qt[1427].needLevel then
    ADD_QUEST_BTN(qt[1427].id, qt[1427].name)
  end
  if qData[1428].state == 0 and qData[1427].state == 2 and GET_PLAYER_LEVEL() >= qt[1428].needLevel then
    ADD_QUEST_BTN(qt[1428].id, qt[1428].name)
  end
  if qData[1431].state == 0 and qData[1430].state == 2 and GET_PLAYER_LEVEL() >= qt[1431].needLevel then
    ADD_QUEST_BTN(qt[1431].id, qt[1431].name)
  end
  if qData[3664].state == 0 and GET_PLAYER_LEVEL() >= qt[3664].needLevel then
    ADD_QUEST_BTN(qt[3664].id, qt[3664].name)
  end
  if qData[3665].state == 0 and GET_PLAYER_LEVEL() >= qt[3665].needLevel then
    ADD_QUEST_BTN(qt[3665].id, qt[3665].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1009].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1009].needLevel then
    if qData[1009].state == 1 then
      if qData[1009].killMonster[qt[1009].goal.killMonster[1].id] >= qt[1009].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1426].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1427].state ~= 2 and qData[1426].state == 2 and GET_PLAYER_LEVEL() >= qt[1427].needLevel then
    if qData[1427].state == 1 then
      if qData[1427].killMonster[qt[1427].goal.killMonster[1].id] >= qt[1427].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1428].state ~= 2 and qData[1427].state == 2 and GET_PLAYER_LEVEL() >= qt[1428].needLevel then
    if qData[1428].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1430].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1431].state ~= 2 and qData[1430].state == 2 and GET_PLAYER_LEVEL() >= qt[1431].needLevel then
    if qData[1431].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3664].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3664].needLevel then
    if qData[3664].state == 1 then
      if CHECK_ITEM_CNT(qt[3664].goal.getItem[1].id) >= qt[3664].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3665].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3665].needLevel then
    if qData[3665].state == 1 then
      if CHECK_ITEM_CNT(qt[3665].goal.getItem[1].id) >= qt[3665].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
