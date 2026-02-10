function npcsay(id)
  if id ~= 4215002 then
    return
  end
  clickNPCid = id
  if qData[153].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[153].goal.getItem) then
      NPC_SAY("我就知道你可以的，现在重感冒可以缓解了，真的很谢谢！")
      SET_QUEST_STATE(153, 2)
    else
      NPC_SAY("{0xFFFFFF00}40个白灰粉{END}还没收集完吗？得重感冒的患者越来越多了！")
    end
  end
  if qData[154].state == 1 then
    NPC_SAY("冥珠城百姓中得重感冒的患者越来越多了，快去分给大家吧！")
  end
  if qData[1280].state == 1 then
    NPC_SAY("嗯？来找我什么事啊？")
    SET_QUEST_STATE(1280, 2)
  end
  if qData[1281].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1281].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("弄回来了？以后人们不用因为感冒受苦了。")
        SET_QUEST_STATE(1281, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退铁腕山的白发老妖，收集30个白灰粉回来吧。")
    end
  end
  if qData[1095].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1095].goal.getItem) then
      if CHECK_INVENTORY_CNT(3) > 0 then
        NPC_SAY("这是装有我的心意的糖果，只要有材料，我就可以给你制作，我就是这样慷慨的人。哈哈~")
        SET_QUEST_STATE(1095, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("是10个糖块，要速度啊！")
    end
  end
  if qData[1580].state == 1 then
    NPC_SAY("给龙林客栈的最强舞者郑贤、送外送的女人、来坐老板娘送去开学礼物吧！")
  end
  ADD_NEW_SHOP_BTN(id, 10014)
  GIVE_DONATION_BUFF(id)
  if qData[153].state == 0 and GET_PLAYER_FAME() >= 60 then
    ADD_QUEST_BTN(qt[153].id, qt[153].name)
  end
  if qData[154].state == 0 and qData[153].state == 2 then
    ADD_QUEST_BTN(qt[154].id, qt[154].name)
  end
  if qData[239].state == 0 then
    ADD_QUEST_BTN(qt[239].id, qt[239].name)
  end
  if qData[481].state == 0 and qData[480].state == 2 then
    ADD_QUEST_BTN(qt[481].id, qt[481].name)
  end
  if qData[1281].state == 0 and qData[1280].state == 2 and GET_PLAYER_LEVEL() >= qt[1281].needLevel then
    ADD_QUEST_BTN(qt[1281].id, qt[1281].name)
  end
  if qData[1091].state == 0 then
    ADD_QUEST_BTN(qt[1091].id, qt[1091].name)
  end
  if qData[1095].state == 0 then
    ADD_QUEST_BTN(qt[1095].id, qt[1095].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1280].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1281].state ~= 2 and qData[1280].state == 2 and GET_PLAYER_LEVEL() >= qt[1281].needLevel then
    if qData[1281].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1281].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1087].state == 1 and GET_PLAYER_LEVEL() >= qt[1087].needLevel then
    if __QUEST_HAS_ALL_ITEMS(qt[1087].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  else
    QSTATE(id, 0)
  end
  if qData[1580].state ~= 1 and qData[1580].state ~= 2 then
    if qData[1580].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
