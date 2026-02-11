function npcsay(id)
  if id ~= 4318002 then
    return
  end
  clickNPCid = id
  if qData[566].state == 1 then
    NPC_SAY("你是谁啊？有什么事情吗？")
    SET_MEETNPC(566, 1, id)
    SET_QUEST_STATE(566, 2)
  end
  if qData[567].state == 1 then
    if qData[567].killMonster[qt[567].goal.killMonster[1].id] >= qt[567].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}[海蟹怪]{END}击退完了吗？不是什么太难的事情，知道你会很快就回来的")
      SET_QUEST_STATE(567, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[海蟹怪]{END}在韩野海岸。帮我击退{0xFFFFFF00}5个{END}吧")
      return
    end
  end
  if qData[1064].state == 1 then
    NPC_SAY("好啊！你是想训练是吧？那我就一个个的好好教你")
    SET_QUEST_STATE(1064, 2)
    return
  end
  if qData[858].state == 1 and qData[858].killMonster[qt[858].goal.killMonster[1].id] >= qt[858].goal.killMonster[1].count then
    NPC_SAY("做得很好！你随时可以使用改造的士兵等候室，有时间就过去吧")
    SET_QUEST_STATE(858, 2)
    return
  end
  if qData[859].state == 1 and qData[859].killMonster[qt[859].goal.killMonster[1].id] >= qt[859].goal.killMonster[1].count then
    NPC_SAY("做得很好！你随时可以使用改造的火焰之房，有时间就过去吧")
    SET_QUEST_STATE(859, 2)
    return
  end
  if qData[860].state == 1 and qData[860].killMonster[qt[860].goal.killMonster[1].id] >= qt[860].goal.killMonster[1].count then
    NPC_SAY("做得很好！你随时可以使用改造的岩石下投室，有时间就过去吧")
    SET_QUEST_STATE(860, 2)
    return
  end
  if qData[566].state == 2 and qData[567].state == 0 then
    ADD_QUEST_BTN(qt[567].id, qt[567].name)
  end
  if qData[1064].state == 0 and GET_PLAYER_LEVEL() >= qt[1064].needLevel then
    ADD_QUEST_BTN(qt[1064].id, qt[1064].name)
  end
  if qData[1064].state == 2 and qData[858].state == 0 and GET_PLAYER_LEVEL() >= qt[858].needLevel then
    ADD_QUEST_BTN(qt[858].id, qt[858].name)
  end
  if qData[1064].state == 2 and qData[859].state == 0 and GET_PLAYER_LEVEL() >= qt[859].needLevel then
    ADD_QUEST_BTN(qt[859].id, qt[859].name)
  end
  if qData[1064].state == 2 and qData[860].state == 0 and GET_PLAYER_LEVEL() >= qt[860].needLevel then
    ADD_QUEST_BTN(qt[860].id, qt[860].name)
  end
  if GET_PLAYER_LEVEL() >= qt[858].needLevel then
    ADD_WARP_EASY_YANG_15LV(id)
  end
  if GET_PLAYER_LEVEL() >= qt[859].needLevel then
    ADD_WARP_EASY_YANG_35LV(id)
  end
  if GET_PLAYER_LEVEL() >= qt[860].needLevel then
    ADD_WARP_EASY_YANG_25LV(id)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[566].state == 2 and qData[566].state ~= 2 and qData[567].state == 0 and GET_PLAYER_LEVEL() >= qt[567].needLevel then
    if qData[566].state == 1 then
      if qData[567].killMonster[qt[567].goal.killMonster[1].id] >= qt[567].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1064].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1064].needLevel then
    if qData[1064].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1064].state == 2 and qData[858].state ~= 2 and GET_PLAYER_LEVEL() >= qt[858].needLevel then
    if qData[858].state == 1 then
      if qData[858].killMonster[qt[858].goal.killMonster[1].id] >= qt[858].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1064].state == 2 and qData[859].state ~= 2 and GET_PLAYER_LEVEL() >= qt[859].needLevel then
    if qData[859].state == 1 then
      if qData[859].killMonster[qt[859].goal.killMonster[1].id] >= qt[859].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1064].state == 2 and qData[860].state ~= 2 and GET_PLAYER_LEVEL() >= qt[860].needLevel then
    if qData[860].state == 1 then
      if qData[860].killMonster[qt[860].goal.killMonster[1].id] >= qt[860].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
