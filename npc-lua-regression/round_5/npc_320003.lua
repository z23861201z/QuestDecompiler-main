function npcsay(id)
  if id ~= 4320003 then
    return
  end
  clickNPCid = id
  NPC_SAY("ÄãÖªµÀÂğ£¿¹íõşµºÓĞºÜ¶à¹ÊÊÂµÄ")
  if qData[2471].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("ÀÒ¾î¹ö¸° ±â¾ïÀÌ¶ó, Âü ½½ÇÂ ÀÏÀÌ±º¿ä.")
      SET_QUEST_STATE(2471, 2)
      return
    else
      NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
    end
  end
  if qData[2472].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("Àú´Â ³ªÁß¿¡ ¿©ÇàÇÑ ÀÌ¾ß±â¸¦ Ã¥À¸·Î ¸¸µé »ı°¢ÀÔ´Ï´Ù. ±×¶§ ´ç½ÅÀÇ ÀÌ¾ß±â¸¦ Ã¥¿¡ ³Ö¾îµµ µÉ±î¿ä?(¸»ÀÌ ±æ¾îÁú °Í °°´Ù. 144°ø·ÂÀÌ µÈ ´ÙÀ½¿¡ ´Ù½Ã ¿ÀÀÚ.)")
      SET_QUEST_STATE(2472, 2)
      return
    else
      NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
    end
  end
  if qData[2473].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2473].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("°¨»çÇÕ´Ï´Ù. ÁÁÀº ÀÚ·á°¡ µÉ °ÍÀÔ´Ï´Ù.")
        SET_QUEST_STATE(2473, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
      end
    else
      NPC_SAY("{0xFFFFFF00}Èæ±ÍÁÖ¿ø{END}À¸·Î °¡¼­ {0xFFFFFF00}[»ï°­µ¿Àü]{END}À» ÅğÄ¡ÇÏ°í {0xFFFFFF00}»ï°­µ¿Àüµî»Ô{END}À» 85°³±¸ÇØÁÖ¼¼¿ä.")
    end
  end
  if qData[2474].state == 1 then
    if qData[2474].killMonster[qt[2474].goal.killMonster[1].id] >= qt[2474].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("À¯°ïÃş±ÍÀÇ Æ¯Â¡À» Á» ¾Ë·ÁÁÖ¼¼¿ä.")
        SET_QUEST_STATE(2474, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
      end
    else
      NPC_SAY("{0xFFFFFF00}Èæ±ÍÁÖ¿ø{END}À¸·Î °¡¼­ {0xFFFFFF00}[À¯°ïÃş±Í]{END}¸¦ 140¸¶¸® ÅğÄ¡ÇÏ°í ±×µéÀÇ Æ¯Â¡À» ¾Ë·ÁÁÖ¼¼¿ä.")
    end
  end
  if qData[2475].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2475].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("°¨»çÇÕ´Ï´Ù. ÁÁÀº ÀÚ·á°¡ µÉ °ÍÀÔ´Ï´Ù.")
        SET_QUEST_STATE(2475, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
      end
    else
      NPC_SAY("{0xFFFFFF00}Èæ±ÍÁÖ¿ø{END}À¸·Î °¡¼­ {0xFFFFFF00}[À¯°ïÃş±Í]{END}¸¦ ÅğÄ¡ÇÏ°í {0xFFFFFF00}ºÎ½º·¯ÁøÆÄÆí{END}À» 70°³±¸ÇØÁÖ¼¼¿ä.")
    end
  end
  if qData[2476].state == 1 then
    if qData[2476].killMonster[qt[2476].goal.killMonster[1].id] >= qt[2476].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("°í¸¿½À´Ï´Ù. ÀÌÁ¦ ³à¼®µéµµ ´õ ÀÌ»óÀº..")
        SET_QUEST_STATE(2476, 2)
        return
      else
        NPC_SAY("Çà³¶ÀÌ ³Ê¹« ¹«°Ì½À´Ï´Ù.")
      end
    else
      NPC_SAY("{0xFFFFFF00}Èæ±ÍÁÖ¿ø{END}À¸·Î °¡¼­ {0xFFFFFF00}[À°¾È±Í]{END}¸¦ 150¸¶¸® ÅğÄ¡ÇØÁÖ¼¼¿ä. ±× Á¤µµ¸é ÃæºĞÇÕ´Ï´Ù.")
    end
  end
  if qData[3678].state == 1 then
    if qData[3678].killMonster[qt[3678].goal.killMonster[1].id] >= qt[3678].goal.killMonster[1].count then
      NPC_SAY("Ì«¸ĞĞ»ÁË")
      SET_QUEST_STATE(3678, 2)
      return
    else
      NPC_SAY("»÷ÍË{0xFFFFFF00}50¸öºÚ¹íõşÔ´µÄÁùÑÛ¹Ö{END}°É")
    end
  end
  if qData[3682].state == 1 then
    if qData[3682].killMonster[qt[3682].goal.killMonster[1].id] >= qt[3682].goal.killMonster[1].count then
      NPC_SAY("Ì«¸ĞĞ»ÁË")
      SET_QUEST_STATE(3682, 2)
      return
    else
      NPC_SAY("»÷ÍË{0xFFFFFF00}50¸öºÚ¹íõşÔ´µÄ¶«À´³àÉ«¹í{END}°É")
    end
  end
  if qData[3678].state == 0 and GET_PLAYER_LEVEL() >= qt[3678].needLevel then
    ADD_QUEST_BTN(qt[3678].id, qt[3678].name)
  end
  if qData[3682].state == 0 and GET_PLAYER_LEVEL() >= qt[3682].needLevel then
    ADD_QUEST_BTN(qt[3682].id, qt[3682].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3678].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3678].needLevel then
    if qData[3678].state == 1 then
      if qData[3678].killMonster[qt[3678].goal.killMonster[1].id] >= qt[3678].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3682].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3682].needLevel then
    if qData[3682].state == 1 then
      if qData[3682].killMonster[qt[3682].goal.killMonster[1].id] >= qt[3682].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
