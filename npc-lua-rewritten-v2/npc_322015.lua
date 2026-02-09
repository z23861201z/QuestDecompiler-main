local function __QUEST_HAS_ALL_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

local function __QUEST_FIRST_ITEM_ID(goalItems)
  if goalItems == nil or goalItems[1] == nil then
    return 0
  end
  return goalItems[1].id
end

local function __QUEST_FIRST_ITEM_COUNT(goalItems)
  if goalItems == nil or goalItems[1] == nil then
    return 0
  end
  return goalItems[1].count
end

function npcsay(id)
  if id ~= 4322015 then
    return
  end
  clickNPCid = id
  if qData[2709].state == 2 then
    NPC_SAY("见到你很荣幸。我是刘备，龙林派师兄嘱咐我要帮助十二弟子。")
  else
    NPC_SAY("这乱世，怎么办才好啊...")
  end
  if qData[2709].state == 1 then
    NPC_SAY("能见到你是我的荣幸！我是这段时间给大家传递消息的{0xFF99ff99}龙林派刘备{END}。秋叨鱼还在治疗中，所以我替他过来了。")
    SET_QUEST_STATE(2709, 2)
    return
  end
  if qData[2741].state == 1 then
    if qData[2741].killMonster[qt[2741].goal.killMonster[1].id] >= qt[2741].goal.killMonster[1].count then
      NPC_SAY("果然厉害。击退70个{0xFFFFFF00}破戒僧{END}会如此迅速。")
      SET_QUEST_STATE(2741, 2)
      return
    else
      NPC_SAY("去{0xFFFFFF00}干涸的沼泽{END}击退70个{0xFFFFFF00}破戒僧{END}后，回到我这里吧。")
    end
  end
  if qData[2742].state == 1 then
    NPC_SAY("对的。我们在找{0xFFFFFF00}12弟子{END}们和{0xFF99ff99}PLAYERNAME{END}。")
    SET_QUEST_STATE(2742, 2)
    return
  end
  if qData[2743].state == 1 then
    if qData[2743].killMonster[qt[2743].goal.killMonster[1].id] >= qt[2743].goal.killMonster[1].count then
      NPC_SAY("谢谢。多亏了你，我们找到了{0xFFFFFF00}春水糖{END}的痕迹。")
      SET_QUEST_STATE(2743, 2)
      return
    else
      NPC_SAY("替我们在{0xFFFFFF00}獐子潭洞穴{END}击退{0xFFFFFF00}原虫{END}，那期间我们会继续搜查。")
    end
  end
  if qData[2744].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2744].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[2744].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[2744].goal.getItem) then
      NPC_SAY("光看这些痕迹，{0xFFFFFF00}春水糖{END}应该是在此处修炼了武功。")
      SET_QUEST_STATE(2744, 2)
    else
      NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}击退{0xFFFFFF00}破戒僧{END}和{0xFFFFFF00}原虫{END}，收集{0xFFFFFF00}熏黑的甲壳{END}, {0xFFFFFF00}断了的臼齿{END}, {0xFFFFFF00}分成两截的杖{END}各30个回来吧。")
    end
  end
  if qData[2745].state == 1 then
    if qData[2745].killMonster[qt[2745].goal.killMonster[1].id] >= qt[2745].goal.killMonster[1].count then
      NPC_SAY("真的帮了我们很多次，非常感谢！")
      SET_QUEST_STATE(2745, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}击退25个{0xFFFFFF00}曲怪人{END}吧。拜托了。")
    end
  end
  if qData[2746].state == 1 then
    NPC_SAY("啊，天下什么时候能太平啊~")
    SET_QUEST_STATE(2746, 2)
    return
  end
  if qData[2786].state == 1 then
    NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}击退30个{0xFFFFFF00}原虫{END}后，去找{0xFFFFFF00}冒险家辛巴达{END}吧。")
  end
  if qData[2789].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2789].goal.getItem) then
    NPC_SAY("我在龙林派关羽处听了说个大概。")
    SET_QUEST_STATE(2789, 2)
  end
  if qData[2790].state == 1 then
    NPC_SAY("把{0xFFFFFF00}獐子潭石板{END}拿去给{0xFFFFFF00}獐子潭洞穴{END}的{0xFFFFFF00}冒险家辛巴达{END}吧。")
  end
  if qData[2741].state == 0 and qData[2740].state == 2 and GET_PLAYER_LEVEL() >= qt[2741].needLevel then
    ADD_QUEST_BTN(qt[2741].id, qt[2741].name)
  end
  if qData[2742].state == 0 and qData[2741].state == 2 and GET_PLAYER_LEVEL() >= qt[2742].needLevel then
    ADD_QUEST_BTN(qt[2742].id, qt[2742].name)
  end
  if qData[2743].state == 0 and qData[2742].state == 2 and GET_PLAYER_LEVEL() >= qt[2743].needLevel then
    ADD_QUEST_BTN(qt[2743].id, qt[2743].name)
  end
  if qData[2744].state == 0 and qData[2743].state == 2 and GET_PLAYER_LEVEL() >= qt[2744].needLevel then
    ADD_QUEST_BTN(qt[2744].id, qt[2744].name)
  end
  if qData[2745].state == 0 and qData[2744].state == 2 and GET_PLAYER_LEVEL() >= qt[2745].needLevel then
    ADD_QUEST_BTN(qt[2745].id, qt[2745].name)
  end
  if qData[2746].state == 0 and qData[2745].state == 2 and GET_PLAYER_LEVEL() >= qt[2746].needLevel then
    ADD_QUEST_BTN(qt[2746].id, qt[2746].name)
  end
  if qData[2786].state == 0 and qData[2746].state == 2 and GET_PLAYER_LEVEL() >= qt[2786].needLevel then
    ADD_QUEST_BTN(qt[2786].id, qt[2786].name)
  end
  if qData[2790].state == 0 and qData[2789].state == 2 and GET_PLAYER_LEVEL() >= qt[2790].needLevel then
    ADD_QUEST_BTN(qt[2790].id, qt[2790].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2709].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2741].state ~= 2 and qData[2740].state == 2 and GET_PLAYER_LEVEL() >= qt[2741].needLevel then
    if qData[2741].state == 1 then
      if qData[2741].killMonster[qt[2741].goal.killMonster[1].id] >= qt[2741].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2742].state ~= 2 and qData[2741].state == 2 and GET_PLAYER_LEVEL() >= qt[2742].needLevel then
    if qData[2742].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2743].state ~= 2 and qData[2742].state == 2 and GET_PLAYER_LEVEL() >= qt[2743].needLevel then
    if qData[2743].state == 1 then
      if qData[2743].killMonster[qt[2743].goal.killMonster[1].id] >= qt[2743].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2744].state ~= 2 and qData[2743].state == 2 and GET_PLAYER_LEVEL() >= qt[2744].needLevel then
    if qData[2744].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2744].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[2744].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[2744].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2745].state ~= 2 and qData[2744].state == 2 and GET_PLAYER_LEVEL() >= qt[2745].needLevel then
    if qData[2745].state == 1 then
      if qData[2745].killMonster[qt[2745].goal.killMonster[1].id] >= qt[2745].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2746].state ~= 2 and qData[2745].state == 2 and GET_PLAYER_LEVEL() >= qt[2746].needLevel then
    if qData[2746].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2786].state ~= 2 and qData[2746].state == 2 and GET_PLAYER_LEVEL() >= qt[2786].needLevel then
    if qData[2786].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2789].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2789].goal.getItem) then
    QSTATE(id, 2)
  end
  if qData[2790].state ~= 2 and qData[2789].state == 2 and GET_PLAYER_LEVEL() >= qt[2790].needLevel then
    if qData[2790].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
