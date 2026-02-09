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
  if id ~= 4314061 then
    return
  end
  clickNPCid = id
  if qData[1109].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1109].goal.getItem) then
      SET_QUEST_STATE(1109, 2)
      NPC_SAY("哇。谢谢你。我的朋友幼恩一定会很开心的。哦对了！如果没事儿的话可以帮帮我妈妈吗？")
    else
      NPC_SAY("5个啐花的叶子。可以在左侧外形如花的怪物身上获取。")
    end
  end
  if qData[1108].state == 2 and qData[1109].state == 0 then
    ADD_QUEST_BTN(qt[1109].id, qt[1109].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1108].state == 2 and qData[1109].state ~= 2 then
    if qData[1109].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1109].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
