function npcsay(id)
  if id ~= 4300148 then
    return
  end
  clickNPCid = id
  NPC_SAY("我为了寻找慰灵花，从另一世界过来的。")
end
function chkQState(id)
  QSTATE(id, -1)
end
