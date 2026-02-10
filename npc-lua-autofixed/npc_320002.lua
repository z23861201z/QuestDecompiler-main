function npcsay(id)
  if id ~= 4320002 then
    return
  end
  clickNPCid = id
  if qData[3668].state == 1 then
    if qData[3668].killMonster[qt[3668].goal.killMonster[1].id] >= qt[3668].goal.killMonster[1].count then
      NPC_SAY("Ð»Ð»£¬ÍÐÄãµÄ¸£¶È¹ýÁËÎ£ÏÕ")
      SET_QUEST_STATE(3668, 2)
      return
    else
      NPC_SAY("ÔÚ{0xFFFFFF00}°×¹íÑªÂ·»÷ÍË180¸ö¹ê¿ÇÍ¯{END}°É")
    end
  end
  if qData[3669].state == 1 then
    if qData[3669].killMonster[qt[3669].goal.killMonster[1].id] >= qt[3669].goal.killMonster[1].count then
      NPC_SAY("Ð»Ð»£¬ÍÐÄãµÄ¸£¶È¹ýÁËÎ£ÏÕ")
      SET_QUEST_STATE(3669, 2)
      return
    else
      NPC_SAY("ÔÚ{0xFFFFFF00}°×¹íÑªÂ·»÷ÍË180¸öÉßÍ·¹Ö{END}°É")
    end
  end
  if qData[3670].state == 1 then
    if qData[3670].killMonster[qt[3670].goal.killMonster[1].id] >= qt[3670].goal.killMonster[1].count then
      NPC_SAY("Ð»Ð»£¬ÍÐÄãµÄ¸£¶È¹ýÁËÎ£ÏÕ")
      SET_QUEST_STATE(3670, 2)
      return
    else
      NPC_SAY("ÔÚ{0xFFFFFF00}°×¹íÑªÂ·»÷ÍË180¸öÊ³ÈËÓã{END}°É")
    end
  end
  if qData[3671].state == 1 then
    if qData[3671].killMonster[qt[3671].goal.killMonster[1].id] >= qt[3671].goal.killMonster[1].count then
      NPC_SAY("Ð»Ð»£¬ÍÐÄãµÄ¸£¶È¹ýÁËÎ£ÏÕ")
      SET_QUEST_STATE(3671, 2)
      return
    else
      NPC_SAY("ÔÚ{0xFFFFFF00}°×¹íÑªÂ·»÷ÍË180¸öÐ×ÃæÄ§Å®{END}°É")
    end
  end
  if qData[3672].state == 1 then
    if qData[3672].killMonster[qt[3672].goal.killMonster[1].id] >= qt[3672].goal.killMonster[1].count then
      NPC_SAY("Ð»Ð»£¬ÍÐÄãµÄ¸£¶È¹ýÁËÎ£ÏÕ")
      SET_QUEST_STATE(3672, 2)
      return
    else
      NPC_SAY("ÔÚ{0xFFFFFF00}°×¹íÑªÂ·»÷ÍË50¸öÎüÑª¹Ö{END}°É")
    end
  end
  NPC_WARP_THEME_34(id)
  if qData[3668].state == 0 and GET_PLAYER_LEVEL() >= qt[3668].needLevel then
    ADD_QUEST_BTN(qt[3668].id, qt[3668].name)
  end
  if qData[3669].state == 0 and GET_PLAYER_LEVEL() >= qt[3669].needLevel then
    ADD_QUEST_BTN(qt[3669].id, qt[3669].name)
  end
  if qData[3670].state == 0 and GET_PLAYER_LEVEL() >= qt[3670].needLevel then
    ADD_QUEST_BTN(qt[3670].id, qt[3670].name)
  end
  if qData[3671].state == 0 and GET_PLAYER_LEVEL() >= qt[3671].needLevel then
    ADD_QUEST_BTN(qt[3671].id, qt[3671].name)
  end
  if qData[3672].state == 0 and GET_PLAYER_LEVEL() >= qt[3672].needLevel then
    ADD_QUEST_BTN(qt[3672].id, qt[3672].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3668].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3668].needLevel then
    if qData[3668].state == 1 then
      if qData[3668].killMonster[qt[3668].goal.killMonster[1].id] >= qt[3668].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3669].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3669].needLevel then
    if qData[3669].state == 1 then
      if qData[3669].killMonster[qt[3669].goal.killMonster[1].id] >= qt[3669].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3670].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3670].needLevel then
    if qData[3670].state == 1 then
      if qData[3670].killMonster[qt[3670].goal.killMonster[1].id] >= qt[3670].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3671].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3671].needLevel then
    if qData[3671].state == 1 then
      if qData[3671].killMonster[qt[3671].goal.killMonster[1].id] >= qt[3671].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3672].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3672].needLevel then
    if qData[3672].state == 1 then
      if qData[3672].killMonster[qt[3672].goal.killMonster[1].id] >= qt[3672].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
