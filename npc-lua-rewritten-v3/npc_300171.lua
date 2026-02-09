function npcsay(id)
  if id ~= 4300171 then
    return
  end
  clickNPCid = id
  i = math.random(0, 1)
  if i == 0 then
    NPC_SAY("这个村庄像朝鲜时代。是我们回到了过去吗？")
  else
    NPC_SAY("得尽快修理才行啊...")
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
