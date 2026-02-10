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
  if id ~= 4300173 then
    return
  end
  clickNPCid = id
  NPC_SAY("你好~")
  if qData[3756].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3756].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢。作为报答我给你神秘袋。明天也能帮我吗？")
        SET_QUEST_STATE(3756, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退白兔的时候应该能发现黑兔。击退黑兔收集20个黑兔毛拿给我吧。")
    end
  end
  if qData[3756].state == 0 then
    ADD_QUEST_BTN(qt[3756].id, qt[3756].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3756].state ~= 2 then
    if qData[3756].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3756].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
