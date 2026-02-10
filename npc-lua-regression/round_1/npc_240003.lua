function npcsay(id)
  if id ~= 4240003 then
    return
  end
  clickNPCid = id
  NPC_SAY("这个装置很神奇吗？转动原理是秘密。恩恩。")
  if qData[2182].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2182].goal.getItem) then
      NPC_SAY("拿来了啊，谢谢~下次也拜托你了！")
      SET_QUEST_STATE(2182, 2)
      return
    else
      NPC_SAY("拜托你帮我收集50个凝固的熔岩回来吧~")
    end
  end
  if qData[3645].state == 1 then
    if CHECK_ITEM_CNT(qt[3645].goal.getItem[1].id) >= qt[3645].goal.getItem[1].count then
      NPC_SAY("拿来了啊，谢谢~明天也拜托你了！")
      SET_QUEST_STATE(3645, 2)
      return
    else
      NPC_SAY("拜托你帮我收集50个凝固的熔岩回来吧~")
    end
  end
  if qData[3698].state == 1 then
    if CHECK_ITEM_CNT(qt[3698].goal.getItem[1].id) >= qt[3698].goal.getItem[1].count then
      NPC_SAY("谢谢。托你的福，能制作好武器了。")
      SET_QUEST_STATE(3698, 2)
      return
    else
      NPC_SAY("击退黑色丘陵的{0xFFFFFF00}[黑色阿拉克涅]{END}，收集{0xFFFFFF00}50个阿拉克涅的三叉戟{END}回来交给我吧。")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10063)
  ADD_UPGRADE_ITEM_BTN(id)
  ADD_EQUIP_REFINE_BTN(id)
  ADD_REPAIR_EQUIPMENT(id)
  RARE_BOX_OPEN(id)
  RARE_BOX_MIXTURE(id)
  if qData[2182].state == 0 then
    ADD_QUEST_BTN(qt[2182].id, qt[2182].name)
  end
  if qData[3645].state == 0 and qData[2182].state == 2 then
    ADD_QUEST_BTN(qt[3645].id, qt[3645].name)
  end
  if qData[3698].state == 0 and GET_PLAYER_LEVEL() >= qt[3698].needLevel then
    ADD_QUEST_BTN(qt[3698].id, qt[3698].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2182].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2182].needLevel then
    if qData[2182].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2182].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3645].state ~= 2 and qData[2182].state == 2 and GET_PLAYER_LEVEL() >= qt[3645].needLevel then
    if qData[3645].state == 1 then
      if CHECK_ITEM_CNT(qt[3645].goal.getItem[1].id) >= qt[3645].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3698].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3698].needLevel then
    if qData[3698].state == 1 then
      if CHECK_ITEM_CNT(qt[3698].goal.getItem[1].id) >= qt[3698].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
