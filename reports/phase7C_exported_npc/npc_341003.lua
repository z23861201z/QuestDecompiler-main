function npcsay(id)
  if id ~= 4341003 then
    return
  end
  clickNPCid = id
  NPC_SAY("大家要为打造美好的空中庭院而努力！")
end
function chkQState(id)
  QSTATE(id, -1)
end
