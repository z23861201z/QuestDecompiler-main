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
  if id ~= 4300139 then
    return
  end
  clickNPCid = id
  NPC_SAY("休假的时候就想在家里休息…")
  if qData[3706].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3706].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("太感谢了，这是一点心意，收下吧！")
        SET_QUEST_STATE(3706, 2)
        return
      else
        NPC_SAY("给行囊减负后再来吧。")
      end
    else
      NPC_SAY("击退{0xFFFFFF00}[凶残海蟹怪]{END},收集30个{0xFFFFFF00}[火烫的蟹钳]{END}回来吧。千万不要说是我让你去的！")
    end
  end
  if qData[3706].state == 0 then
    ADD_QUEST_BTN(qt[3706].id, qt[3706].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3706].state ~= 2 then
    if qData[3706].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3706].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
