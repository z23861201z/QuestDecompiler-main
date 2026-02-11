function npcsay(id)
  if id ~= 4314056 then
    return
  end
  clickNPCid = id
  NPC_SAY("要去哪儿啊？只要支付费用就可以移动到想要去的地方。")
  NPC_WARP_THEME_42(id)
  NPC_WARP_THEME_1(id)
  NPC_WARP_TO_CHUNGUM_MARKET_PLACE(id)
  NPC_WARP_THEME_16(id)
  NPC_WARP_THEME_10(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
