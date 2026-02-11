function npcsay(id)
  if id ~= 4391115 then
    return
  end
  NPC_SAY("辛苦了。如果想出去的话告诉我。")
  clickNPCid = id
  if qData[2651].state == 1 then
    NPC_SAY("古龙不是那么容易被打退的。还请继续帮忙。")
    SET_QUEST_STATE(2651, 2)
    return
  end
  if qData[3721].state == 1 then
    NPC_SAY("古龙不是那么容易被打退的。还请继续帮忙。")
    SET_QUEST_STATE(3721, 2)
    return
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2651].state == 1 then
    QSTATE(id, 2)
  end
  if qData[3721].state == 1 then
    QSTATE(id, 2)
  end
end
