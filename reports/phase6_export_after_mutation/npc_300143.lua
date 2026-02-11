function npcsay(id)
  if id ~= 4300143 then
    return
  end
  clickNPCid = id
  NPC_SAY("哥哥想做的康乃馨需要很多的彩纸")
end
function chkQState(id)
  QSTATE(id, -1)
end
