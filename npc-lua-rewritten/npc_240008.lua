local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4240008 then
    return
  end
  clickNPCid = id
  NPC_SAY("欢迎光临！我一直都是个良心卖家~")
  if qData[3699].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[3699].goal.getItem) and __QUEST_CHECK_ITEMS(qt[3699].goal.getItem) then
      NPC_SAY("数量刚好啊~辛苦了！（感觉好像被骗了。）")
      SET_QUEST_STATE(3699, 2)
      return
    else
      NPC_SAY("看来你很悠闲啊~因为生意难做，我每时每刻都很累…快点帮我收集回来{0xFFFFFF00}50个黑色阿佩普的鳞{END},  {0xFFFFFF00}50个白色阿佩普的毒牙{END}吧！")
    end
  end
  if qData[3700].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[3700].goal.getItem) and __QUEST_CHECK_ITEMS(qt[3700].goal.getItem) then
      NPC_SAY("这次也很快啊！我可以出售石材赚取很多利润了，谢谢~（好像是被骗了）")
      SET_QUEST_STATE(3700, 2)
      return
    else
      NPC_SAY("少侠磨蹭期间，安哥拉的建筑商们因为昂贵的岩石费用而承受着巨大的压力呢。快去击退{0xFFFFFF00}[熏黑的巨石守护者]和[红色巨石守护者]{END}，收集回来{0xFFFFFF00}50个熏黑的巨石碎块{END},  {0xFFFFFF00}50个红色巨石碎块{END}吧。")
    end
  end
  if qData[3703].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[3703].goal.getItem) then
      NPC_SAY("嘿嘿，谢谢~以后也要经常拜托你了~")
      SET_QUEST_STATE(3703, 2)
      return
    else
      NPC_SAY("不是说三拳就能解决雷神的吗？怎么还没好啊…快去帮我收集回来{0xFFFFFF00}1个雷神符咒{END}吧~")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10083)
  if qData[3699].state == 0 and GET_PLAYER_LEVEL() >= qt[3699].needLevel then
    ADD_QUEST_BTN(qt[3699].id, qt[3699].name)
  end
  if qData[3700].state == 0 and GET_PLAYER_LEVEL() >= qt[3700].needLevel then
    ADD_QUEST_BTN(qt[3700].id, qt[3700].name)
  end
  if qData[3703].state == 0 and GET_PLAYER_LEVEL() >= qt[3703].needLevel then
    ADD_QUEST_BTN(qt[3703].id, qt[3703].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3699].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3699].needLevel then
    if qData[3699].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[3699].goal.getItem) and __QUEST_CHECK_ITEMS(qt[3699].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3700].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3700].needLevel then
    if qData[3700].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[3700].goal.getItem) and __QUEST_CHECK_ITEMS(qt[3700].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3703].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3703].needLevel then
    if qData[3703].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[3703].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
