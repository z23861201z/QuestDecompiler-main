function npcsay(id)
  if id ~= 4323007 then
    return
  end
  NPC_SAY("前方出现了居首者。但是，好漂亮~~")
  clickNPCid = id
  if qData[1481].state == 1 then
    NPC_SAY("嗯？是{0xFFFFFF00}亲卫队长罗新{END}让你来的？但是，你有漂亮的姐姐或妹妹吗？")
    SET_QUEST_STATE(1481, 2)
    return
  end
  if qData[1482].state == 1 then
    NPC_SAY("在{0xFFFFFF00}安哥拉广场{END}的{0xFFFFFF00}医生八字胡老头{END}处购买{0xFFFFFF00}女儿红{END}之后，交给{0xFFFFFF00}安哥拉市后门{END}的{0xFFFFFF00}近卫兵哈玛")
    return
  end
  if qData[1484].state == 1 then
    NPC_SAY("那个~老兄。有什么有所掌握的吗？")
    SET_QUEST_STATE(1484, 2)
    return
  end
  if qData[1485].state == 1 then
    NPC_SAY("去{0xFFFFFF00}安哥拉市后门{END}的{0xFFFFFF00}近卫兵哈玛特{END}处看看吧 老兄。不要忘了拿着女儿红过去")
    return
  end
  if qData[2592].state == 1 then
    if qData[2592].killMonster[qt[2592].goal.killMonster[1].id] >= qt[2592].goal.killMonster[1].count then
      NPC_SAY("辛苦了~这下我也不用担心同僚们的安全了。")
      SET_QUEST_STATE(2592, 2)
      return
    else
      NPC_SAY("去燃烧的废墟，击退{0xFFFFFF00}100个[熏黑的巨石守护者]{END}吧。")
    end
  end
  if qData[2882].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2882].goal.getItem) then
    NPC_SAY("{0xFFFFCCCC}(可心快速地抢过解毒剂就喝下了。){END}哎呀，我的肚子！喝了药肚子还是疼！看来得休息几天才能好。你替我向{0xFFFFFF00}亲卫队长罗新{END}请假吧！哎呀！我的肚子！")
    SET_QUEST_STATE(2882, 2)
    return
  end
  if qData[2884].state == 1 then
    NPC_SAY("早退呢？嗯？不让早退，给了这{0xFFFFFF00}腹痛药{END}？")
    SET_QUEST_STATE(2884, 2)
    return
  end
  if qData[2885].state == 1 then
    NPC_SAY("{0xFFFFCCCC}(可心现在不是能对话的状态。回到亲卫队长罗新处吧。){END}")
    return
  end
  if qData[2886].state == 1 then
    if qData[2886].killMonster[qt[2886].goal.killMonster[1].id] >= qt[2886].goal.killMonster[1].count then
      NPC_SAY("呵呵，这么快就全部击退了？不是说谎吧？")
      SET_QUEST_STATE(2886, 2)
      return
    else
      NPC_SAY("不会不知道{0xFFFFFF00}咸兴魔灵{END}在哪儿吧？不就在{0xFFFFFF00}吕墩平原{END}吗，快去击退50个吧。")
    end
  end
  if qData[2887].state == 1 then
    if qData[2887].killMonster[qt[2887].goal.killMonster[1].id] >= qt[2887].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}紫色头发外地人{END}?我看到那边的{0xFFFFFF00}近卫兵降落伞{END}见了那个人。哈哈哈！{0xFFFFCCCC}(刚好这时近卫兵降落伞呵斥可心。){END}")
      SET_QUEST_STATE(2887, 2)
      return
    else
      NPC_SAY("你不会不知道{0xFFFFFF00}马面人鬼{END}在哪儿吧？在{0xFFFFFF00}吕墩平原{END}。快去击退50个吧。")
    end
  end
  if qData[1482].state == 0 and qData[1481].state == 2 then
    ADD_QUEST_BTN(qt[1482].id, qt[1482].name)
  end
  if qData[1485].state == 0 and qData[1484].state == 2 then
    ADD_QUEST_BTN(qt[1485].id, qt[1485].name)
  end
  if qData[2592].state == 0 and GET_PLAYER_LEVEL() >= qt[2592].needLevel then
    ADD_QUEST_BTN(qt[2592].id, qt[2592].name)
  end
  if qData[2885].state == 0 and qData[2884].state == 2 and GET_PLAYER_LEVEL() >= qt[2885].needLevel then
    ADD_QUEST_BTN(qt[2885].id, qt[2885].name)
  end
  if qData[2886].state == 0 and qData[2885].state == 2 and GET_PLAYER_LEVEL() >= qt[2886].needLevel then
    ADD_QUEST_BTN(qt[2886].id, qt[2886].name)
  end
  if qData[2887].state == 0 and qData[2886].state == 2 and GET_PLAYER_LEVEL() >= qt[2887].needLevel then
    ADD_QUEST_BTN(qt[2887].id, qt[2887].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1481].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1482].state ~= 2 and qData[1481].state == 2 then
    if qData[1482].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1484].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1485].state ~= 2 and qData[1484].state == 2 then
    if qData[1485].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2592].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2592].needLevel then
    if qData[2592].state == 1 then
      if qData[2592].killMonster[qt[2592].goal.killMonster[1].id] >= qt[2592].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2882].state ~= 2 and qData[2881].state == 2 and GET_PLAYER_LEVEL() >= qt[2882].needLevel then
    if qData[2882].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2882].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2884].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2885].state ~= 2 and qData[2884].state == 2 then
    if qData[2885].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2886].state ~= 2 and qData[2885].state == 2 and GET_PLAYER_LEVEL() >= qt[2886].needLevel then
    if qData[2886].state == 1 then
      if qData[2886].killMonster[qt[2886].goal.killMonster[1].id] >= qt[2886].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2887].state ~= 2 and qData[2886].state == 2 and GET_PLAYER_LEVEL() >= qt[2887].needLevel then
    if qData[2887].state == 1 then
      if qData[2887].killMonster[qt[2887].goal.killMonster[1].id] >= qt[2887].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
