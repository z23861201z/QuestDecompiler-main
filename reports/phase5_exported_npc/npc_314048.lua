function npcsay(id)
  if id ~= 4314048 then
    return
  end
  clickNPCid = id
  NPC_SAY("利用仆人召唤里的云善道人就能{0xFFFFFF00}随时都可以免费移动到想要去的地方{END}。")
  NPC_WARP_TO_CHUNGUM_MARKET_PLACE(id)
  NPC_WARP_THEME_1(id)
  NPC_WARP_THEME_42(id)
  NPC_WARP_THEME_27(id)
  NPC_WARP_THEME_16(id)
  NPC_WARP_THEME_10(id)
  NPC_WARP_THEME_46(id)
  NPC_WARP_THEME_20(id)
  NPC_WARP_THEME_12(id)
  NPC_WARP_THEME_15(id)
  NPC_WARP_THEME_18(id)
  NPC_WARP_THEME_25(id)
  NPC_WARP_THEME_26(id)
  NPC_WARP_THEME_34_6(id)
  NPC_WARP_THEME_39(id)
  NPC_WARP_THEME_41(id)
  NPC_WARP_THEME_50(id)
  NPC_WARP_THEME_53(id)
  NPC_WARP_THEME_55(id)
  NPC_WARP_THEME_56(id)
  NPC_WARP_THEME_63(id)
  NPC_WARP_THEME_67(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
