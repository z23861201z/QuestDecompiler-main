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
  if id ~= 4316008 then
    return
  end
  clickNPCid = id
  if qData[292].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[292].goal.getItem) then
      NPC_SAY("呼…还是不行啊。不管怎么说是我家小姐…谢谢你的帮忙。这是一点心意")
      SET_QUEST_STATE(292, 2)
    else
      NPC_SAY("帮我收集回来{0xFFFFFF00}80个腐烂的豆腐{END}吧")
    end
  end
  if qData[292].state == 0 then
    ADD_QUEST_BTN(qt[292].id, qt[292].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
