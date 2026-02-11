function npcsay(id)
  if id ~= 4341016 then
    return
  end
  clickNPCid = id
  NPC_SAY("我好不容易从最下层逃出来的。那里已经完全变成了怪物们的巢穴。")
end
function chkQState(id)
  QSTATE(id, -1)
end
