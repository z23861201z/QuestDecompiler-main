function npcsay(id)
  if id ~= 4300160 then
    return
  end
  clickNPCid = id
  NPC_SAY("腿受伤了！我们的春节为什么一定要是昨天啊！！")
end
function chkQState(id)
  QSTATE(id, -1)
end
