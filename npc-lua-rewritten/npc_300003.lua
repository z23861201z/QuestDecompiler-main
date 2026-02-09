local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4300003 then
    return
  end
  clickNPCid = id
  NPC_SAY("虽然失去了胳膊，但绝对不能就这样放弃。")
  ADD_BTN_WARP_61(id)
  if qData[1461].state == 1 then
    NPC_SAY("呃…如果我的胳膊还在的话…")
    SET_QUEST_STATE(1461, 2)
    return
  end
  if qData[1462].state == 1 then
    NPC_SAY("击退{0xFFFFFF00}超火车轮怪{END}，营救{0xFFFFFF00}菊花碴{END}！")
  end
  if qData[1464].state == 1 then
    NPC_SAY("你，你是师傅的分身？也就是说再也找不到师傅了")
    SET_QUEST_STATE(1464, 2)
    return
  end
  if qData[1465].state == 1 then
    NPC_SAY("我听说{0xFFFFFF00}南丰馆桥{END}上有可以唤醒一部分记忆的{0xFFFFFF00}记忆诊疗师{END}。值得去看一下")
  end
  if qData[2413].state == 1 then
    NPC_SAY("捞 茨篮捞俊霸 公郊 捞具扁甫 秦林矫妨绊 茫酒坷继绰瘤夸?")
    SET_QUEST_STATE(2413, 2)
    return
  end
  if qData[2414].state == 1 then
    NPC_SAY("构 喊芭 乐嚼聪鳖? 弊成 何碟媚焊技夸.")
    SET_QUEST_STATE(2414, 2)
    return
  end
  if qData[2415].state == 1 then
    NPC_SAY("呈公 绢菲霸 倒酒啊瘤 付矫绊 奖霸 积阿窍技夸.")
  end
  if qData[2558].state == 1 then
    NPC_SAY("菊花碴不知道怎么样了..一定要平安才行啊..")
  end
  if qData[2560].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[2560].goal.getItem) then
      NPC_SAY("谢谢，太谢谢啊")
      SET_QUEST_STATE(2560, 2)
      return
    else
      NPC_SAY("去{0xFFFFFF00}[巨木重林[3]]{END}击退{0xFFFFFF00}八脚魔怪{END}收集100个{0xFFFFFF00}八脚魔怪的蜘蛛丝{END}回来就可以了")
    end
  end
  if qData[2561].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[2561].goal.getItem) and __QUEST_CHECK_ITEMS(qt[2561].goal.getItem) then
      NPC_SAY("师傅，不是..{0xFFFFFF00}PLAYERNAME{END}一点都没变啊。现在不用再管我了")
      SET_QUEST_STATE(2561, 2)
      return
    else
      NPC_SAY("师..{0xFFFFFF00}PLAYERNAME{END}，{0xFFFFFF00}巨大的钳子{END}可在巨木重林[5]]{END}的{0xFFFFFF00}太极蜈蚣{END}身上获得。{0xFFFFFF00}临浦怪的独角{END}可在{0xFFFFFF00}[干涸的沼泽[1]]{END}的{0xFFFFFF00}临浦怪{END}身上获得。是各150个和100个")
    end
  end
  if qData[2654].state == 1 or qData[2655].state == 1 then
    NPC_SAY("这个珠子里已经装了鬼魂者的真气，你拿给秋叨鱼吧。对了，你别忘了秋叨鱼为了避开兰霉匠的眼线，装成疯癫的老人。")
  end
  if qData[2660].state == 1 then
    NPC_SAY("不久前，我跟冬混汤联系上了。冬混汤跟秋叨鱼一起来到了这附近的{0xFFFFFF00}西南沼泽地带{END}。")
    SET_QUEST_STATE(2660, 2)
    return
  end
  if qData[2661].state == 1 then
    NPC_SAY("都是为了修炼。在干涸的沼泽击退50个嗜食怪后去见秋叨鱼吧。")
  end
  if qData[2669].state == 1 then
    NPC_SAY("你有什么事吗？")
    SET_QUEST_STATE(2669, 2)
    return
  end
  if qData[2670].state == 1 then
    NPC_SAY("{0xFFFFFF00}临浦怪{END}在{0xFFFFFF00}干涸的沼泽{END}。去见{0xFFFFFF00}隐藏的干涸的沼泽[1]{END}的{0xFFFFFF00}修炼中的冬混汤{END}之前，先击退50个左右的{0xFFFFFF00}临浦怪{END}吧。")
  end
  if qData[2690].state == 1 and qData[2690].killMonster[qt[2690].goal.killMonster[1].id] >= qt[2690].goal.killMonster[1].count then
    NPC_SAY("出，出大事了。")
    SET_QUEST_STATE(2690, 2)
    return
  end
  if qData[2691].state == 1 then
    NPC_SAY("是超火车轮怪的逆袭开始了吗？帮忙击退80个{0xFFFFFF00}志鬼心火{END}吧。")
  end
  if qData[2693].state == 1 then
    NPC_SAY("冬混汤那边的情况怎么样了？")
    SET_QUEST_STATE(2693, 2)
    return
  end
  if qData[2694].state == 1 then
    NPC_SAY("去吕林城告诉秋叨鱼这些情况，再商量一下对策吧。")
  end
  if qData[2703].state == 1 and qData[2703].killMonster[qt[2703].goal.killMonster[1].id] >= qt[2703].goal.killMonster[1].count then
    NPC_SAY("{0xFF99ff99}PLAYERNAME{END}！我正等你呢。")
    SET_QUEST_STATE(2703, 2)
    return
  end
  if qData[2704].state == 1 then
    if qData[2704].killMonster[qt[2704].goal.killMonster[1].id] >= qt[2704].goal.killMonster[1].count then
      NPC_SAY("情况不是很妙。希望巨木神的封印能快点完成。")
      SET_QUEST_STATE(2704, 2)
      return
    else
      NPC_SAY("{0xFF99ff99}PLAYERNAME{END}帮忙击退50个{0xFFFFFF00}破戒僧{END} 吧。")
    end
  end
  if qData[2705].state == 1 then
    NPC_SAY("去{0xFFFFFF00}巨木重林中心地{END}见{0xFFFFFF00}巨木守护者{END}就行。")
  end
  if qData[2706].state == 1 and __QUEST_CHECK_ITEMS(qt[2706].goal.getItem) and GET_SEAL_BOX_SOUL_PERSENT(8590010) >= 100 then
    NPC_SAY("啊，那是封印吗？")
    SET_QUEST_STATE(2706, 2)
    return
  end
  if qData[2707].state == 1 then
    NPC_SAY("去击退超火车轮怪吧。(跟超火车轮怪的厌恶的缘分也该结束了吧...)")
  end
  if qData[2709].state == 1 then
    NPC_SAY("兰霉匠！大怪物！你们等着！")
  end
  if qData[1462].state == 0 and qData[1461].state == 2 then
    ADD_QUEST_BTN(qt[1462].id, qt[1462].name)
  end
  if qData[1465].state == 0 and qData[1464].state == 2 then
    ADD_QUEST_BTN(qt[1465].id, qt[1465].name)
  end
  if qData[2558].state == 0 and qData[2557].state == 2 and GET_PLAYER_LEVEL() >= qt[2558].needLevel then
    ADD_QUEST_BTN(qt[2558].id, qt[2558].name)
  end
  if qData[2560].state == 0 and qData[2559].state == 2 and GET_PLAYER_LEVEL() >= qt[2560].needLevel then
    ADD_QUEST_BTN(qt[2560].id, qt[2560].name)
  end
  if qData[2561].state == 0 and qData[2560].state == 2 and GET_PLAYER_LEVEL() >= qt[2561].needLevel then
    ADD_QUEST_BTN(qt[2561].id, qt[2561].name)
  end
  if qData[2654].state == 0 and qData[1465].state == 2 and GET_PLAYER_LEVEL() >= qt[2654].needLevel and GET_PLAYER_FACTION() == 0 then
    ADD_QUEST_BTN(qt[2654].id, qt[2654].name)
  end
  if qData[2655].state == 0 and qData[1465].state == 2 and GET_PLAYER_LEVEL() >= qt[2655].needLevel and GET_PLAYER_FACTION() == 1 then
    ADD_QUEST_BTN(qt[2655].id, qt[2655].name)
  end
  if qData[2660].state == 0 and qData[2575].state == 2 and GET_PLAYER_LEVEL() >= qt[2660].needLevel then
    ADD_QUEST_BTN(qt[2660].id, qt[2660].name)
  end
  if qData[2661].state == 0 and qData[2660].state == 2 and GET_PLAYER_LEVEL() >= qt[2661].needLevel then
    ADD_QUEST_BTN(qt[2661].id, qt[2661].name)
  end
  if qData[2670].state == 0 and qData[2669].state == 2 and GET_PLAYER_LEVEL() >= qt[2670].needLevel then
    ADD_QUEST_BTN(qt[2670].id, qt[2670].name)
  end
  if qData[2691].state == 0 and qData[2690].state == 2 and GET_PLAYER_LEVEL() >= qt[2691].needLevel then
    ADD_QUEST_BTN(qt[2691].id, qt[2691].name)
  end
  if qData[2694].state == 0 and qData[2693].state == 2 and GET_PLAYER_LEVEL() >= qt[2694].needLevel then
    ADD_QUEST_BTN(qt[2694].id, qt[2694].name)
  end
  if qData[2704].state == 0 and qData[2703].state == 2 and GET_PLAYER_LEVEL() >= qt[2704].needLevel then
    ADD_QUEST_BTN(qt[2704].id, qt[2704].name)
  end
  if qData[2705].state == 0 and qData[2704].state == 2 and GET_PLAYER_LEVEL() >= qt[2705].needLevel then
    ADD_QUEST_BTN(qt[2705].id, qt[2705].name)
  end
  if qData[2707].state == 0 and qData[2706].state == 2 and GET_PLAYER_LEVEL() >= qt[2707].needLevel then
    ADD_QUEST_BTN(qt[2707].id, qt[2707].name)
  end
  if qData[2709].state == 0 and qData[2708].state == 2 and GET_PLAYER_LEVEL() >= qt[2709].needLevel then
    ADD_QUEST_BTN(qt[2709].id, qt[2709].name)
  end
  ADD_BTN_WARP_61(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1461].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1462].state ~= 2 and qData[1461].state == 2 and GET_PLAYER_LEVEL() >= qt[1462].needLevel then
    if qData[1462].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1464].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1465].state ~= 2 and qData[1464].state == 2 and GET_PLAYER_LEVEL() >= qt[1465].needLevel then
    if qData[1465].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2558].state ~= 2 and qData[2557].state == 2 and GET_PLAYER_LEVEL() >= qt[2558].needLevel then
    if qData[2558].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2560].state ~= 2 then
    if qData[2560].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[2560].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2561].state ~= 2 then
    if qData[2561].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[2561].goal.getItem) and __QUEST_CHECK_ITEMS(qt[2561].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2654].state ~= 2 and qData[1465].state == 2 and GET_PLAYER_LEVEL() >= qt[2654].needLevel then
    if qData[2654].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2655].state ~= 2 and qData[1465].state == 2 and GET_PLAYER_LEVEL() >= qt[2655].needLevel then
    if qData[2654].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2660].state ~= 2 and qData[2575].state == 2 and GET_PLAYER_LEVEL() >= qt[2660].needLevel then
    if qData[2660].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2661].state ~= 2 and qData[2660].state == 2 and GET_PLAYER_LEVEL() >= qt[2661].needLevel then
    if qData[2661].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2669].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2670].state ~= 2 and qData[2669].state == 2 and GET_PLAYER_LEVEL() >= qt[2670].needLevel then
    if qData[2670].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2690].state == 1 and qData[2690].killMonster[qt[2690].goal.killMonster[1].id] >= qt[2690].goal.killMonster[1].count then
    QSTATE(id, 2)
  end
  if qData[2691].state ~= 2 and qData[2690].state == 2 and GET_PLAYER_LEVEL() >= qt[2691].needLevel then
    if qData[2691].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2693].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2694].state ~= 2 and qData[2693].state == 2 and GET_PLAYER_LEVEL() >= qt[2694].needLevel then
    if qData[2694].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2703].state == 1 and qData[2703].killMonster[qt[2703].goal.killMonster[1].id] >= qt[2703].goal.killMonster[1].count then
    QSTATE(id, 2)
  end
  if qData[2704].state ~= 2 and qData[2703].state == 2 and GET_PLAYER_LEVEL() >= qt[2704].needLevel then
    if qData[2704].state == 1 then
      if qData[2704].killMonster[qt[2704].goal.killMonster[1].id] >= qt[2704].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2705].state ~= 2 and qData[2704].state == 2 and GET_PLAYER_LEVEL() >= qt[2705].needLevel then
    if qData[2705].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2706].state == 1 and __QUEST_CHECK_ITEMS(qt[2706].goal.getItem) and GET_SEAL_BOX_SOUL_PERSENT(8590010) >= 100 then
    QSTATE(id, 2)
  end
  if qData[2707].state ~= 2 and qData[2706].state == 2 and GET_PLAYER_LEVEL() >= qt[2707].needLevel then
    if qData[2707].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2709].state ~= 2 and qData[2708].state == 2 and GET_PLAYER_LEVEL() >= qt[2709].needLevel then
    if qData[2709].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
