function npcsay(id)
  if id ~= 4391072 then
    return
  end
  clickNPCid = id
  if qData[855].state == 1 then
    NPC_SAY("哈哈，做得好。怎么样，击退猪大长易如反掌吧？来，现在我给你点谢礼。")
    SET_MEETNPC(855, 1, id)
    SET_QUEST_STATE(855, 2)
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[855].state == 1 and GET_PLAYER_LEVEL() >= qt[855].needLevel then
    QSTATE(id, 2)
  end
end
