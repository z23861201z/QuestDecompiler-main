function npcsay(id)
  if id ~= 4300159 then
    return
  end
  clickNPCid = id
  NPC_SAY("今年是猪！！我的本命年！请期待己亥年的另一个活动吧~~")
end
function chkQState(id)
  QSTATE(id, -1)
end
