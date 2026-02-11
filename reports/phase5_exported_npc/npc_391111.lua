function npcsay(id)
  if id ~= 4391111 then
    return
  end
  clickNPCid = id
  NPC_SAY("在这里逗留太久的话无法抵挡妖气入侵。快点离开吧")
  if qData[3653].state == 1 then
    NPC_SAY("谢谢。至少找回了一部分东西...那里好像还有，下次你再帮我去找吧")
    SET_QUEST_STATE(3653, 2)
    return
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3653].state == 1 then
    QSTATE(id, 2)
  end
end
