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
  if id ~= 4300170 then
    return
  end
  clickNPCid = id
  i = math.random(0, 1)
  if i == 0 then
    NPC_SAY("我们是海军。")
  else
    NPC_SAY("如果不是台风的话，已经回到祖国了...")
  end
  if qData[3751].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3751].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢。作为报答，把我们的{0xFFFFFF00}1个军用口粮{END}送给你吧。")
        SET_QUEST_STATE(3751, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去{0xFFFFFF00}韩野海岸{END}击退{0xFFFFFF00}怪物{END}，找回{0xFFFFFF00}5个海军补给品{END}吧。")
    end
  end
  if qData[3751].state == 0 then
    ADD_QUEST_BTN(qt[3751].id, qt[3751].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3751].state ~= 2 then
    if qData[3751].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3751].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
