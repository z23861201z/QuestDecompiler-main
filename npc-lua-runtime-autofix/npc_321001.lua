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
  if id ~= 4321001 then
    return
  end
  clickNPCid = id
  NPC_SAY("南丰馆由我来守护!")
  if qData[3657].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3657].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[3657].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("谢谢。明天也拜托了！")
        SET_QUEST_STATE(3657, 2)
      else
        NPC_SAY("行囊空间不足")
      end
    else
      NPC_SAY("收集赤灵甲的灵魂头盔，山贼王的山贼王的王冠，黑岩石怪的黑岩石碎片各10回来就可以了")
    end
  end
  if qData[3657].state == 0 then
    ADD_QUEST_BTN(qt[3657].id, qt[3657].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3657].state ~= 2 then
    if qData[3657].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3657].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[3657].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
