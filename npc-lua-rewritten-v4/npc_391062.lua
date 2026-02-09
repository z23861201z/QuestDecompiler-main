function npcsay(id)
  if id ~= 4391062 then
    return
  end
  clickNPCid = id
  if qData[854].state == 1 then
    NPC_SAY("?? ??? ??? ?? ?? ?????. ???, ??? ??? ???. ? ?? ????? ?????.")
    SET_MEETNPC(854, 1, id)
    SET_QUEST_STATE(854, 2)
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[854].state == 1 and GET_PLAYER_LEVEL() >= qt[854].needLevel then
    QSTATE(id, 2)
  end
end
