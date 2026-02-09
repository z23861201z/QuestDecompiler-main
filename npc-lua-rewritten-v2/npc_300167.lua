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
  if id ~= 4300167 then
    return
  end
  clickNPCid = id
  NPC_SAY("嗷呜！")
  if qData[2846].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2846].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[2846].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("拿来了啊。谢谢。我马上也要变成人类了！")
        SET_QUEST_STATE(2846, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("要吃100天艾草和大蒜啊...你帮我一次性收集回来各100个艾草和大蒜吧。我想比黑熊儿更快变成人类！")
    end
  end
  if qData[2846].state == 0 and qData[2845].state == 2 then
    ADD_QUEST_BTN(qt[2846].id, qt[2846].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2846].state ~= 2 and qData[2845].state == 2 then
    if qData[2846].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2846].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[2846].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
