function npcsay(id)
  if id ~= 4300004 then
    return
  end
  clickNPCid = id
  NPC_SAY("虽然失去了胳膊，但绝对不能就这样放弃。")
end
function chkQState(id)
  QSTATE(id, -1)
end
