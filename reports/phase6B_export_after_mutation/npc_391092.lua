function npcsay(id)
  if id ~= 4391092 then
    return
  end
  clickNPCid = id
  if qData[857].state == 1 then
    NPC_SAY("真的很谢谢…但是不知道什么时候还会再来…还是很感谢。来，这是礼物。")
    SET_MEETNPC(857, 1, id)
    SET_QUEST_STATE(857, 2)
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[857].state == 1 and GET_PLAYER_LEVEL() >= qt[857].needLevel then
    QSTATE(id, 2)
  end
end
