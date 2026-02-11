function npcsay(id)
  if id ~= 4300144 then
    return
  end
  clickNPCid = id
  NPC_SAY("我肚子上面的王字使用笔画的。嘿嘿~被老师发现了..")
end
function chkQState(id)
  QSTATE(id, -1)
end
