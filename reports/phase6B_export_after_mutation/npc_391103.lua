function npcsay(id)
  if id ~= 4391103 then
    return
  end
  clickNPCid = id
  if qData[1325].state == 1 then
    NPC_SAY("从神檀树开始到现在…完全可以称你为代表龙林派的龙林城守护者！ ")
    SET_QUEST_STATE(1325, 2)
    return
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1325].state == 1 then
    QSTATE(id, 2)
  end
end
