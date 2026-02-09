function npcsay(id)
  if id ~= 4213013 then
    return
  end
  clickNPCid = id
  NPC_SAY("你好。我是冥珠城补给负责人。负责鬼魂装备，鬼魂强化，装备组合。")
  ADD_NEW_SHOP_BTN(id, 10043)
  GIHON_ENDOWMENT(id)
  GIHON_STRENGTHENING(id)
  GIHON_MIXTURE(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
