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
  if id ~= 4341001 then
    return
  end
  clickNPCid = id
  NPC_SAY("我是大汉莫拉比帝国的宰相卡利普。")
  if qData[2911].state == 1 then
    if qData[2911].killMonster[qt[2911].goal.killMonster[1].id] >= qt[2911].goal.killMonster[1].count then
      NPC_SAY("这么快就回来了？我能相信你吧？啊，当然信。")
      SET_QUEST_STATE(2911, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}大瀑布{END}击退110个{0xFFFFFF00}晶石喙龟{END}后回到我，也就是{0xFFFFFF00}宰相卡利普{END}处吧。")
    end
  end
  if qData[3729].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3729].goal.getItem) then
      NPC_SAY("我来看看，数量对了。这是今天的奖励。明天再来吧。")
      SET_QUEST_STATE(3729, 2)
      return
    else
      NPC_SAY("去{0xFFFFFF00}西部边境地带{END}击退{0xFFFFFF00}锯齿飞鱼{END}后作为证据收集50个{0xFFFFFF00}翅鳍{END}回来就可以了。")
    end
  end
  if qData[3783].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3783].goal.getItem) then
      NPC_SAY("我来看看，刚好啊。这是今天的奖励，如果还想继续的话明天再来找我吧。")
      SET_QUEST_STATE(3783, 2)
      return
    else
      NPC_SAY("{0xFFFFCCCC}(自言自语)怎样才能用此事形成水路联合..{END}嗯？你还没出发吗？快去{0xFFFFFF00}大瀑布{END}击退{0xFFFFFF00}晶石怪{END}，收集50个{0xFFFFFF00}晶石怪的腿{END}回来吧。")
    end
  end
  if qData[2911].state == 0 and GET_PLAYER_LEVEL() >= qt[2911].needLevel then
    ADD_QUEST_BTN(qt[2911].id, qt[2911].name)
  end
  if qData[3729].state == 0 and GET_PLAYER_LEVEL() >= qt[3729].needLevel then
    ADD_QUEST_BTN(qt[3729].id, qt[3729].name)
  end
  if qData[3783].state == 0 and GET_PLAYER_LEVEL() >= qt[3783].needLevel then
    ADD_QUEST_BTN(qt[3783].id, qt[3783].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2911].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2911].needLevel then
    if qData[2911].state == 1 then
      if qData[2911].killMonster[qt[2911].goal.killMonster[1].id] >= qt[2911].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3729].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3729].needLevel then
    if qData[3729].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3729].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3783].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3783].needLevel then
    if qData[3783].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3783].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
