function npcsay(id)
  if id ~= 4391116 then
    return
  end
  clickNPCid = id
  if qData[3741].state == 1 then
    NPC_SAY("谢谢。虽然现在还不能完全放心，但是牛犄角的进攻也会推后的吧。")
    SET_QUEST_STATE(3741, 2)
    return
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3741].state == 1 then
    QSTATE(id, 2)
  end
end
