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
  if id ~= 4241002 then
    return
  end
  clickNPCid = id
  NPC_SAY("我无所不知，无所不能。")
  if qData[3787].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3787].goal.getItem) then
      NPC_SAY("1,2,3..49.50。刚好。这是答应你的谢礼。明天你有时间的话再帮我吧。")
      SET_QUEST_STATE(3787, 2)
      return
    else
      NPC_SAY("工程进行的时间会很长。今天去{0xFFFFFF00}大瀑布{END}击退{0xFFFFFF00}晶石矿工长{END}，收集回来50个{0xFFFFFF00}断了的镐头把{END}回来就可以了。")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10087)
  ADD_MOVESOUL_BTN(id)
  ADD_ENCHANT_BTN(id)
  ADD_PURIFICATION_BTN(id)
  ADD_NPC_CR_REWARD(id)
  if qData[3787].state == 0 and GET_PLAYER_LEVEL() >= qt[3787].needLevel then
    ADD_QUEST_BTN(qt[3787].id, qt[3787].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3787].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3787].needLevel then
    if qData[3787].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3787].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
