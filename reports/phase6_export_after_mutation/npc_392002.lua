function npcsay(id)
  if id ~= 4392002 then
    return
  end
  clickNPCid = id
  NPC_SAY("满意结果吗？辛苦了。希望下次还可以见面。")
  ADD_RETURN_WARP_BTN(id)
end
function chkQState(id)
  QSTATE(id, false)
end
