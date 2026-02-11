function npcsay(id)
  if id ~= 4315017 then
    return
  end
  clickNPCid = id
  NPC_SAY("在生死之塔关门通往悲伤之房的路已被封印，一边有插入{0xFF36B8C2}钥匙{END}之类的\n缝隙。")
  ADD_USE_KEY_BTN(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
