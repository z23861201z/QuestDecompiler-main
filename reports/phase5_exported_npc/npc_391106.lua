function npcsay(id)
  if id ~= 4391106 then
    return
  end
  clickNPCid = id
  if qData[1435].state == 1 then
    NPC_SAY("不要惊慌！是超火车轮怪啊......嗯，很符合我这大天才军师登场的敌人啊。你先逃离此处，重新回到我身边吧 ")
    SET_QUEST_STATE(1435, 2)
    return
  end
  if qData[870].state == 1 then
    NPC_SAY("辛苦了，请收下奖励吧 ")
    SET_QUEST_STATE(870, 2)
    return
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1435].state == 1 then
    QSTATE(id, 2)
  end
  if qData[870].state == 1 then
    QSTATE(id, 2)
  end
end
