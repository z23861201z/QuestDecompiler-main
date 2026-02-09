function npcsay(id)
  if id ~= 4341010 then
    return
  end
  clickNPCid = id
  NPC_SAY("我是亲卫队老兵莫尼。")
end
function chkQState(id)
  QSTATE(id, -1)
end
