function npcsay(id)
  if id ~= 4314045 then
    return
  end
  clickNPCid = id
  NPC_SAY("这..我想关闭黄泉的门，但是力量不够。嗯？你也放弃了吗？想要回到村里就跟我说一声。我虽然是个武士，但是可以利用从云善道人处学来的道术把你送回村里。啊..当然不可能是免费的。")
  NPC_WARP_THEME_1(id)
  NPC_WARP_THEME_42(id)
  NPC_WARP_THEME_10(id)
  NPC_WARP_THEME_15(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
