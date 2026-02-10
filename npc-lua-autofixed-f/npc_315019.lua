function npcsay(id)
  if id ~= 4315019 then
    return
  end
  clickNPCid = id
  if qData[1008].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[1008].goal.getItem) then
    NPC_SAY("谁啊？嗯…。是[魏朗]让你来的？那傻家伙对手下是没话说。现在还没有要交给你这弱者的事情。嗯…。稍后会发生很帅气的事情，到时候再过来吧。")
    SET_QUEST_STATE(1008, 2)
    return
  end
  if qData[1823].state == 1 then
    NPC_SAY("??? ?? ???? ??? ??? ? ?? ??? ???? ???. ? ??? ??? ?? ?? ??.")
    SET_MEETNPC(1823, 1, id)
    return
  end
  if qData[1043].state == 1 then
    NPC_SAY("到现在还没出发吗？事情紧急，快点出发吧！")
    return
  end
  if qData[1046].state == 1 then
    NPC_SAY("啊~终于要开始了啊。恩恩..不是，辛苦了。你先去吧！")
    SET_QUEST_STATE(1046, 2)
    return
  end
  if qData[1289].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[1289].goal.getItem) then
    NPC_SAY("嗯？是陈调寄来的命令书？")
    SET_QUEST_STATE(1289, 2)
    return
  end
  if qData[1290].state == 1 then
    NPC_SAY("嗯。帮我跟陈调问声好。（快点去韩野村南边的土著民沈叶浪处吧。）")
  end
  if qData[1008].state == 2 and qData[1043].state == 0 then
    ADD_QUEST_BTN(qt[1043].id, qt[1043].name)
  end
  if qData[1290].state == 0 and qData[1289].state == 2 and GET_PLAYER_LEVEL() >= qt[1290].needLevel then
    ADD_QUEST_BTN(qt[1290].id, qt[1290].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1008].state == 1 and GET_PLAYER_LEVEL() >= qt[1008].needLevel then
    if __QUEST_HAS_ALL_ITEMS(qt[1008].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1008].state == 2 and qData[1043].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1043].needLevel then
    if qData[1043].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1823].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1823].needLevel and qData[1823].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1046].state == 1 and GET_PLAYER_LEVEL() >= qt[1046].needLevel then
    QSTATE(id, 2)
  end
  if qData[1290].state ~= 2 and qData[1289].state == 2 and GET_PLAYER_LEVEL() >= qt[1290].needLevel then
    if qData[1290].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
