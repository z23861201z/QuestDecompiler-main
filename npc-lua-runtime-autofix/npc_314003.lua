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
  if id ~= 4314003 then
    return
  end
  clickNPCid = id
  if qData[675].state == 1 then
    NPC_SAY("去见见{0xFFFFFF00}白斩姬{END}吧。他清楚兰霉匠的恶行。正派建筑在清阴关南边中央位置。")
    return
  end
  if qData[1002].state == 1 then
    NPC_SAY("{0xFFFFFF00}[ 北瓶押 ]{END}就在{0xFFFFFF00}[ 隐藏的清阴谷 ]{END}！这么快就忘了吗？")
    return
  end
  if qData[1140].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("来的正好。")
      SET_QUEST_STATE(1140, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1141].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1141].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[1141].goal.getItem) then
      NPC_SAY("哈哈哈！果然消息没错啊。就是说你有击退怪物的热情和为人正直的消息！")
      SET_QUEST_STATE(1141, 2)
    else
      NPC_SAY("不会是想放弃吧？在北清阴平原击退雨伞标、蛋蛋小妖、触目仔、铜铃眼之后收集5个[ 破烂的雨伞 ]、5个[ 毒菇 ]、4个[ 触目仔的眼珠 ]、2个[ 铁块 ]回来吧。")
    end
  end
  if qData[1182].state == 1 then
    if qData[1182].killMonster[qt[1182].goal.killMonster[1].id] >= qt[1182].goal.killMonster[1].count then
      NPC_SAY("太谢谢了。是你救了清阴关全体居民啊。你的大恩大德清阴镖局不会忘记的。")
      SET_QUEST_STATE(1182, 2)
    else
      NPC_SAY("去蛇腹窟击退20只糯米肠吧。")
    end
  end
  if qData[2023].state == 1 then
    SET_QUEST_STATE(2023, 2)
    NPC_SAY("嗯..你就是佣兵领袖说的刚加入佣兵团的PLAYERNAME吗？")
  end
  if qData[2024].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2024].goal.getItem) then
      SET_QUEST_STATE(2024, 2)
      NPC_SAY("看来虽然你失去了记忆，不过实力应该很优秀啊，不然佣兵团也不会接受你~")
    else
      NPC_SAY("击退[南清阴平原]的[三只手]并收集6个三只手手骨回来吧。打算通过宝芝林制作成村里要用的药材")
    end
  end
  if qData[2025].state == 1 then
    NPC_SAY("在[清阴关宝芝林]处购买10个白米后给[北瓶押]送去吧。北瓶押在[隐藏的清阴谷]。给他送去白米，他会付剩余的款项的，剩余款项就当是你的报酬吧")
  end
  if qData[2026].state == 1 then
    SET_QUEST_STATE(2026, 2)
    NPC_SAY("什么？不理你？奇怪了，这不像他啊..")
  end
  if qData[2026].state == 1 then
    NPC_SAY("还没回去吗？你说要回[选择树林]的[佣兵领袖]处的是吧？向他说明我的近况吧")
  end
  if qData[675].state == 0 then
    ADD_QUEST_BTN(qt[675].id, qt[675].name)
  end
  if qData[1002].state == 0 then
    ADD_QUEST_BTN(qt[1002].id, qt[1002].name)
  end
  if qData[1141].state == 0 then
    ADD_QUEST_BTN(qt[1141].id, qt[1141].name)
  end
  if qData[1182].state == 0 then
    ADD_QUEST_BTN(qt[1182].id, qt[1182].name)
  end
  if qData[1208].state == 0 and qData[1182].state == 2 and GET_PLAYER_LEVEL() >= qt[1208].needLevel then
    ADD_QUEST_BTN(qt[1208].id, qt[1208].name)
  end
  if qData[2024].state == 0 and qData[2023].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2024].id, qt[2024].name)
  end
  if qData[2025].state == 0 and qData[2024].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2025].id, qt[2025].name)
  end
  if qData[2027].state == 0 and qData[2026].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2027].id, qt[2027].name)
  end
  ADD_DONATION_BTN(id)
  BTN_DONATION_FISH(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[675].state ~= 2 and GET_PLAYER_LEVEL() >= qt[675].needLevel then
    if qData[675].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1002].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1002].needLevel then
    if qData[1002].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1139].state == 2 and qData[1140].state ~= 2 and qData[1140].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1141].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1141].needLevel then
    if qData[1141].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1141].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[1141].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1182].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1182].needLevel then
    if qData[1182].state == 1 then
      if qData[1182].killMonster[qt[1182].goal.killMonster[1].id] >= qt[1182].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1208].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1208].state == 0 and qData[1182].state == 2 and GET_PLAYER_LEVEL() >= qt[1208].needLevel then
    QSTATE(id, 0)
  end
  if qData[2023].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2024].state ~= 2 and qData[2023].state == 2 and GET_PLAYER_LEVEL() >= qt[2024].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2024].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2024].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2025].state ~= 2 and qData[2024].state == 2 and GET_PLAYER_LEVEL() >= qt[2025].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2025].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2026].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2027].state ~= 2 and qData[2026].state == 2 and GET_PLAYER_LEVEL() >= qt[2027].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2027].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
