function npcsay(id)
  if id ~= 4313008 then
    return
  end
  clickNPCid = id
  NPC_SAY("想要退出此处就请按{0xFFFFFF00}退出都城{END}。")
  CW_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
