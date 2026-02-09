function npcsay(id)
  if id ~= 4391042 then
    return
  end
  clickNPCid = id
  if qData[803].state == 1 then
    NPC_SAY("非常感谢。您是真正的武林侠客。")
    SET_QUEST_STATE(803, 2)
  end
end
ADD_NPC_WARP_INDUN_EXIT(id)
function chkQState(id)
  QSTATE(id, -1)
  if qData[803].state == 1 then
    QSTATE(id, 2)
  end
end
