function npcsay(id)
  if id ~= 4241004 then
    return
  end
  clickNPCid = id
  NPC_SAY("这些猫和小鸟是我的朋友。")
  if qData[2904].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2904].goal.getItem) then
      NPC_SAY("{0xFFFFCCCC}(摸了摸失去光泽的晶石块){END}这就足够了。太感谢了。")
      SET_QUEST_STATE(2904, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}晶石怪{END}，帮我收集50个{0xFFFFFF00}失去光泽的晶石块{END}吧。")
    end
  end
  if qData[2910].state == 1 then
    if CHECK_ITEM_CNT(qt[2910].goal.getItem[1].id) >= qt[2910].goal.getItem[1].count then
      NPC_SAY("这么快就回来了啊，太感谢了。")
      SET_QUEST_STATE(2910, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}大瀑布{END}击退{0xFFFFFF00}晶石喙龟{END}，收集回来60个{0xFFFFFF00}晶石喙龟的龟壳{END}就可以了。")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10089)
  ADD_EQUIP_REFINE_BTN(id)
  ADD_REPAIR_EQUIPMENT(id)
  RARE_BOX_OPEN(id)
  RARE_BOX_MIXTURE(id)
  if qData[2904].state == 0 and GET_PLAYER_LEVEL() >= qt[2904].needLevel then
    ADD_QUEST_BTN(qt[2904].id, qt[2904].name)
  end
  if qData[2910].state == 0 and GET_PLAYER_LEVEL() >= qt[2910].needLevel then
    ADD_QUEST_BTN(qt[2910].id, qt[2910].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2904].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2904].needLevel then
    if qData[2904].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2904].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2910].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2910].needLevel then
    if qData[2910].state == 1 then
      if CHECK_ITEM_CNT(qt[2910].goal.getItem[1].id) >= qt[2910].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
