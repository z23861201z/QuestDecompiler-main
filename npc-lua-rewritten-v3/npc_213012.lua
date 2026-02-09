function npcsay(id)
  if id ~= 4213012 then
    return
  end
  clickNPCid = id
  NPC_SAY("你好。我是冥珠城补给负责人。负责鬼魂移动，鬼魂合成，装备强化，饰品强化。")
  ADD_NEW_SHOP_BTN(id, 10042)
  ADD_MOVESOUL_BTN(id)
  ADD_ENCHANT_BTN(id)
  ADD_ENCHANTEQUIP_BTN(id)
  ADD_ENCHANTEACCESSORY_BTN(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
