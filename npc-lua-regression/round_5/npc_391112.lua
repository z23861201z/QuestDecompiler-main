function npcsay(id)
  if id ~= 4391112 then
    return
  end
  clickNPCid = id
  if qData[2333].state == 1 then
    NPC_SAY("快回去吧，你还没有准备好~")
  end
  if qData[2334].state == 1 then
    NPC_SAY("我是巨木神，也是巨木守护者！")
    SET_QUEST_STATE(2334, 2)
    return
  end
  if qData[2335].state == 1 then
    NPC_SAY("快回去吧，你还没有准备好~")
    SET_QUEST_STATE(2335, 2)
    return
  end
  if qData[2336].state == 1 then
    NPC_SAY("巨木神该说的都说了")
    SET_QUEST_STATE(2336, 2)
    return
  end
  if qData[2337].state == 1 then
    NPC_SAY("想这种状态跟巨木神抗衡？")
  end
  if qData[2555].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("芭格脚捞 急攫茄促. {0xFFFFFF00}怕拳畴焙{END}狼 茄 炼阿, {0xFFFFFF00}PLAYERNAME{END}. 弊措绰 捞力 霖厚啊 登菌促.")
      SET_QUEST_STATE(2555, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促!")
    end
  end
  if qData[2556].state == 1 then
    NPC_SAY("巨木神说了。龟神已经列入了神仙班列，即使死了，灵魂还活着")
    SET_QUEST_STATE(2556, 2)
    return
  end
  if qData[2557].state == 1 then
    NPC_SAY("巨木神发话了，要速度")
    SET_QUEST_STATE(2557, 2)
    return
  end
  if qData[2562].state == 1 then
    NPC_SAY("巨木神期待见到老朋友")
    SET_QUEST_STATE(2562, 2)
    return
  end
  if qData[2571].state == 1 then
    NPC_SAY("巨木神很期待见到老朋友！")
    SET_QUEST_STATE(2571, 2)
    return
  end
  if qData[2572].state == 1 then
    NPC_SAY("巨木神在介绍。还记得吗？是你介绍给我的人")
    SET_QUEST_STATE(2572, 2)
    return
  end
  if qData[2573].state == 1 then
    NPC_SAY("巨木神再次强调。我会再次把你推向{0xFFFFFF00}玄境{END}的境界")
    SET_QUEST_STATE(2573, 2)
    return
  end
  if qData[2574].state == 1 then
    NPC_SAY("放马过来吧！我会让你记起以前的事的")
  end
  if qData[2575].state == 1 then
    NPC_SAY("巨木神很期待。（...）巨木神相信龟神的眼光。龟神的眼光很准。（...）{0xFFFFFF00}刚才看到了吗？再次到达玄境境界的瞬间..{END}")
    SET_QUEST_STATE(2575, 2)
    return
  end
  if qData[2697].state == 1 then
    NPC_SAY("好久不见。巨木神正在等你呢。")
    SET_QUEST_STATE(2697, 2)
    return
  end
  if qData[2698].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2698].goal.getItem) then
      NPC_SAY("巨木神很惊讶。然后称赞你。")
      SET_QUEST_STATE(2698, 2)
      return
    else
      NPC_SAY("巨木神在等待。去{0xFFFFFF00}干涸的沼泽{END}收集40个 {0xFFFFFF00}嗜食怪的眼睛{END} 和50个 {0xFFFFFF00}僵硬的跳蚤{END} 回来吧。")
    end
  end
  if qData[2699].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2699].goal.getItem) then
      NPC_SAY("巨木神很满足。")
      SET_QUEST_STATE(2699, 2)
      return
    else
      NPC_SAY("巨木神很期待。去{0xFFFFFF00}干涸的沼泽{END}击退{0xFFFFFF00}临浦怪{END}，收集50个{0xFFFFFF00}临浦怪的眼睛{END} 和50个{0xFFFFFF00}临浦怪的独角{END} 回来吧。")
    end
  end
  if qData[2700].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2700].goal.getItem) then
      NPC_SAY("巨木神很满意。")
      SET_QUEST_STATE(2700, 2)
      return
    else
      NPC_SAY("巨木神再次告诉你。去{0xFFFFFF00}干涸的沼泽{END}击退 {0xFFFFFF00}志鬼心火{END}，收集30个 {0xFFFFFF00}志鬼心火火焰{END} 和50个 {0xFFFFFF00}燃烧的铠甲残片{END} 回来吧。")
    end
  end
  if qData[2701].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2701].goal.getItem) then
      NPC_SAY("巨木神在准备。巨木神说，到时候了会叫你。")
      SET_QUEST_STATE(2701, 2)
      return
    else
      NPC_SAY("巨木神说，去{0xFFFFFF00}干涸的沼泽{END}击退 {0xFFFFFF00}破戒僧{END}，收集30个 {0xFFFFFF00}咒术仗{END} 和50个 {0xFFFFFF00}咒术短剑{END} 回来吧。")
    end
  end
  if qData[2702].state == 1 then
    NPC_SAY("巨木神让你快点。{0xFFFFFF00}隐藏的干涸的沼泽[1]{END}的{0xFFFFFF00}修炼中的冬混汤{END}很危险。")
  end
  if qData[2705].state == 1 then
    NPC_SAY("巨木神说，封印基本上完成了。")
    SET_QUEST_STATE(2705, 2)
    return
  end
  if qData[2706].state == 1 then
    NPC_SAY("巨木神要求。往这个{0xFFFFFF00}木制鬼魂封印箱{END}里装鬼魂交给{0xFFFFFF00}竹统泛{END}后，一起击退超火车轮怪吧。巨木守护者为了准备封印，会先过去。")
  end
  if qData[2732].state == 1 and qData[2732].killMonster[qt[2732].goal.killMonster[1].id] >= qt[2732].goal.killMonster[1].count then
    NPC_SAY("巨木神又惊又喜。")
    SET_QUEST_STATE(2732, 2)
    return
  end
  if qData[2733].state == 1 then
    NPC_SAY("在{0xFFFFFF00}干涸的沼泽{END}击退70个{0xFFFFFF00}破戒僧{END}后，去找獐子潭吧。（去找{0xFFFFFF00}封印之石{END}的{0xFFFFFF00}菊花碴{END}吧。）")
  end
  if qData[2736].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2736].goal.getItem) and qData[2736].killMonster[qt[2736].goal.killMonster[1].id] >= qt[2736].goal.killMonster[1].count then
    NPC_SAY("巨木神好奇。找到{0xFFFFFF00}獐子潭{END}了吗？哦，这是{0xFFFFFF00}水晶碎片{END}啊。")
    SET_QUEST_STATE(2736, 2)
    return
  end
  if qData[2737].state == 1 then
    if CHECK_ITEM_CNT(qt[2737].goal.getItem[1].id) >= qt[2737].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2737].goal.getItem[2].id) >= qt[2737].goal.getItem[2].count then
      NPC_SAY("巨木神称赞，辛苦了。")
      SET_QUEST_STATE(2737, 2)
      return
    else
      NPC_SAY("巨木神说，在{0xFFFFFF00}獐子潭洞穴{END}击退怪物，各收集30个{0xFFFFFF00}獐子潭苔藓{END}和 {0xFFFFFF00}獐子潭水晶粉末{END}后，回到{0xFFFFFF00}巨木重林中心地{END}的{0xFFFFFF00}[巨木守护者]{END}处。")
    end
  end
  if qData[2738].state == 1 then
    NPC_SAY("巨木神说，这些{0xFFFFFF00}特制药{END}和制作药的{0xFFFFFF00}特制药制作法{END}用来治疗秋叨鱼的内功吧。")
  end
  if qData[3663].state == 1 then
    NPC_SAY("挑战巨木神取的好成绩，就送你{0xFFFFFF00}巨木神像{END}")
  end
  if qData[2333].state == 0 and qData[2332].state == 2 and GET_PLAYER_LEVEL() >= qt[2333].needLevel then
    ADD_QUEST_BTN(qt[2333].id, qt[2333].name)
  end
  if qData[2335].state == 0 and qData[2334].state == 2 and GET_PLAYER_LEVEL() >= qt[2335].needLevel then
    ADD_QUEST_BTN(qt[2335].id, qt[2335].name)
  end
  if qData[2336].state == 0 and qData[2335].state == 2 and GET_PLAYER_LEVEL() >= qt[2336].needLevel then
    ADD_QUEST_BTN(qt[2336].id, qt[2336].name)
  end
  if qData[2337].state == 0 and qData[2336].state == 2 and GET_PLAYER_LEVEL() >= qt[2337].needLevel then
    ADD_QUEST_BTN(qt[2337].id, qt[2337].name)
  end
  if qData[2556].state == 0 and GET_PLAYER_LEVEL() >= qt[2556].needLevel then
    ADD_QUEST_BTN(qt[2556].id, qt[2556].name)
  end
  if qData[2557].state == 0 and qData[2556].state == 2 and GET_PLAYER_LEVEL() >= qt[2557].needLevel then
    ADD_QUEST_BTN(qt[2557].id, qt[2557].name)
  end
  if qData[2562].state == 0 and qData[2561].state == 2 and GET_PLAYER_LEVEL() >= qt[2562].needLevel then
    ADD_QUEST_BTN(qt[2562].id, qt[2562].name)
  end
  if qData[2572].state == 0 and qData[2571].state == 2 and GET_PLAYER_LEVEL() >= qt[2572].needLevel then
    ADD_QUEST_BTN(qt[2572].id, qt[2572].name)
  end
  if qData[2573].state == 0 and qData[2572].state == 2 and GET_PLAYER_LEVEL() >= qt[2573].needLevel then
    ADD_QUEST_BTN(qt[2573].id, qt[2573].name)
  end
  if qData[2574].state == 0 and qData[2573].state == 2 and GET_PLAYER_LEVEL() >= qt[2574].needLevel then
    ADD_QUEST_BTN(qt[2574].id, qt[2574].name)
  end
  if qData[2575].state == 0 and qData[2574].state == 2 and GET_PLAYER_LEVEL() >= qt[2575].needLevel then
    ADD_QUEST_BTN(qt[2575].id, qt[2575].name)
  end
  if qData[2698].state == 0 and qData[2697].state == 2 and GET_PLAYER_LEVEL() >= qt[2698].needLevel then
    ADD_QUEST_BTN(qt[2698].id, qt[2698].name)
  end
  if qData[2699].state == 0 and qData[2698].state == 2 and GET_PLAYER_LEVEL() >= qt[2699].needLevel then
    ADD_QUEST_BTN(qt[2699].id, qt[2699].name)
  end
  if qData[2700].state == 0 and qData[2699].state == 2 and GET_PLAYER_LEVEL() >= qt[2700].needLevel then
    ADD_QUEST_BTN(qt[2700].id, qt[2700].name)
  end
  if qData[2701].state == 0 and qData[2700].state == 2 and GET_PLAYER_LEVEL() >= qt[2701].needLevel then
    ADD_QUEST_BTN(qt[2701].id, qt[2701].name)
  end
  if qData[2702].state == 0 and qData[2701].state == 2 and GET_PLAYER_LEVEL() >= qt[2702].needLevel then
    ADD_QUEST_BTN(qt[2702].id, qt[2702].name)
  end
  if qData[2706].state == 0 and qData[2705].state == 2 and GET_PLAYER_LEVEL() >= qt[2706].needLevel then
    ADD_QUEST_BTN(qt[2706].id, qt[2706].name)
  end
  if qData[2733].state == 0 and qData[2732].state == 2 and GET_PLAYER_LEVEL() >= qt[2733].needLevel then
    ADD_QUEST_BTN(qt[2733].id, qt[2733].name)
  end
  if qData[2737].state == 0 and qData[2736].state == 2 and GET_PLAYER_LEVEL() >= qt[2737].needLevel then
    ADD_QUEST_BTN(qt[2737].id, qt[2737].name)
  end
  if qData[2738].state == 0 and qData[2737].state == 2 and GET_PLAYER_LEVEL() >= qt[2738].needLevel then
    ADD_QUEST_BTN(qt[2738].id, qt[2738].name)
  end
  if qData[3663].state == 0 and qData[2339].state == 2 and GET_PLAYER_LEVEL() >= qt[3663].needLevel then
    ADD_QUEST_BTN(qt[3663].id, qt[3663].name)
  end
  LearnSkill(id)
  ADD_NEW_SHOP_BTN(id, 10081)
  ADD_BTN_INDUN_GOD_OF_TREE(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2333].state ~= 2 and qData[2332].state == 2 and GET_PLAYER_LEVEL() >= qt[2333].needLevel then
    if qData[2333].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2334].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2335].state ~= 2 and qData[2334].state == 2 and GET_PLAYER_LEVEL() >= qt[2335].needLevel then
    if qData[2335].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2336].state ~= 2 and qData[2335].state == 2 and GET_PLAYER_LEVEL() >= qt[2336].needLevel then
    if qData[2336].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2337].state ~= 2 and qData[2336].state == 2 and GET_PLAYER_LEVEL() >= qt[2337].needLevel then
    if qData[2337].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2556].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2556].needLevel then
    if qData[2556].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2557].state ~= 2 and qData[2556].state == 2 and GET_PLAYER_LEVEL() >= qt[2557].needLevel then
    if qData[2557].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2562].state ~= 2 and qData[2561].state == 2 and GET_PLAYER_LEVEL() >= qt[2562].needLevel then
    if qData[2562].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2571].state ~= 2 and qData[2570].state == 2 and GET_PLAYER_LEVEL() >= qt[2571].needLevel then
    if qData[2571].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2572].state ~= 2 and qData[2571].state == 2 and GET_PLAYER_LEVEL() >= qt[2572].needLevel then
    if qData[2572].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2573].state ~= 2 and qData[2572].state == 2 and GET_PLAYER_LEVEL() >= qt[2573].needLevel then
    if qData[2573].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2574].state ~= 2 and qData[2573].state == 2 and GET_PLAYER_LEVEL() >= qt[2574].needLevel then
    if qData[2574].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2575].state ~= 2 and qData[2574].state == 2 and GET_PLAYER_LEVEL() >= qt[2575].needLevel then
    if qData[2575].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2697].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2698].state ~= 2 and qData[2697].state == 2 and GET_PLAYER_LEVEL() >= qt[2698].needLevel then
    if qData[2698].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2698].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2699].state ~= 2 and qData[2698].state == 2 and GET_PLAYER_LEVEL() >= qt[2699].needLevel then
    if qData[2699].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2699].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2700].state ~= 2 and qData[2699].state == 2 and GET_PLAYER_LEVEL() >= qt[2700].needLevel then
    if qData[2700].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2700].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2701].state ~= 2 and qData[2700].state == 2 and GET_PLAYER_LEVEL() >= qt[2701].needLevel then
    if qData[2701].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2701].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2702].state ~= 2 and qData[2701].state == 2 and GET_PLAYER_LEVEL() >= qt[2702].needLevel then
    if qData[2702].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2705].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2706].state ~= 2 and qData[2705].state == 2 and GET_PLAYER_LEVEL() >= qt[2706].needLevel then
    if qData[2706].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2732].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2733].state ~= 2 and qData[2732].state == 2 and GET_PLAYER_LEVEL() >= qt[2733].needLevel then
    if qData[2733].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2737].state ~= 2 and qData[2736].state == 2 and GET_PLAYER_LEVEL() >= qt[2737].needLevel then
    if qData[2737].state == 1 then
      if CHECK_ITEM_CNT(qt[2737].goal.getItem[1].id) >= qt[2737].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2737].goal.getItem[2].id) >= qt[2737].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2738].state ~= 2 and qData[2737].state == 2 and GET_PLAYER_LEVEL() >= qt[2738].needLevel then
    if qData[2738].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3663].state ~= 2 and qData[2339].state == 2 and GET_PLAYER_LEVEL() >= qt[3663].needLevel then
    if qData[3663].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
