function npcsay(id)
  if id ~= 4314027 then
    return
  end
  clickNPCid = id
  ADD_MINIGAME_PET_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
