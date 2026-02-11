function npcsay(id)
  if id ~= 4315021 then
    return
  end
  clickNPCid = id
  if CHECK_BLOOD_ROOM() == 0 then
    NPC_SAY("只有使用 {0xFFFFFF00}'嘉和符咒'{END}才能进入.但只有{0xFFFFFF00}队长才能使用{END}。")
    NPC_WARP_BLOOD_ROOM(id)
    NPC_ANSWER_CANCEL(id)
  else
    NPC_SAY("火焰凶猛无法进入内部。似乎别人已经进去了。")
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
