function npcsay(id)
  if id ~= 4320002 then
    return
  end
  clickNPCid = id
  if qData[3668].state == 1 then
    if qData[3668].killMonster[qt[3668].goal.killMonster[1].id] >= qt[3668].goal.killMonster[1].count then
      NPC_SAY("谢谢，托你的福度过了危险")
      SET_QUEST_STATE(3668, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}白鬼血路击退180个龟壳童{END}吧")
    end
  end
  if qData[3669].state == 1 then
    if qData[3669].killMonster[qt[3669].goal.killMonster[1].id] >= qt[3669].goal.killMonster[1].count then
      NPC_SAY("谢谢，托你的福度过了危险")
      SET_QUEST_STATE(3669, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}白鬼血路击退180个蛇头怪{END}吧")
    end
  end
  if qData[3670].state == 1 then
    if qData[3670].killMonster[qt[3670].goal.killMonster[1].id] >= qt[3670].goal.killMonster[1].count then
      NPC_SAY("谢谢，托你的福度过了危险")
      SET_QUEST_STATE(3670, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}白鬼血路击退180个食人鱼{END}吧")
    end
  end
  if qData[3671].state == 1 then
    if qData[3671].killMonster[qt[3671].goal.killMonster[1].id] >= qt[3671].goal.killMonster[1].count then
      NPC_SAY("谢谢，托你的福度过了危险")
      SET_QUEST_STATE(3671, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}白鬼血路击退180个凶面魔女{END}吧")
    end
  end
  if qData[3672].state == 1 then
    if qData[3672].killMonster[qt[3672].goal.killMonster[1].id] >= qt[3672].goal.killMonster[1].count then
      NPC_SAY("谢谢，托你的福度过了危险")
      SET_QUEST_STATE(3672, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}白鬼血路击退50个吸血怪{END}吧")
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
