function npcsay(id)
  if id ~= 4213009 then
    return
  end
  clickNPCid = id
  if qData[802].state == 1 then
    NPC_SAY("韩野城的{0xFFFFFF00}汉谟拉比商人{END}掌管阻挡巨大鬼怪食欲的灯火，{0xFFFFFF00}冥珠城父母官{END}知道如何找到巨大鬼怪。我会保护好居民，并看准打怪时机出现的。")
  else
    NPC_SAY("我是冥珠都城的{0xFFFFFF00}内部管理人{END}。请问需要什么？")
  end
  ADD_NEW_SHOP_BTN(id, 10032)
  if qData[676].state == 2 and qData[805].state == 0 then
    ADD_QUEST_BTN(qt[805].id, qt[805].name)
  end
  GIVE_REPAY(id)
  NPC_WARP_TO_CHUNGUM_MARKET_PLACE(id)
  NPC_WARP_THEME_1(id)
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
  if qData[676].state == 2 and qData[805].state == 0 then
    QSTATE(id, true)
  end
end
