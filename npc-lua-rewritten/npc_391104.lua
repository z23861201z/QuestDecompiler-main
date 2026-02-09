local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4391104 then
    return
  end
  clickNPCid = id
  if qData[1347].state == 1 and __QUEST_CHECK_ITEMS(qt[1347].goal.getItem) then
    NPC_SAY("很厉害啊。没想到真的跟过来了。")
    SET_QUEST_STATE(1347, 2)
  end
  if qData[1390].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("你就是上次的？原来是这样啊。看来这个手镯的主人就是你了。先拿着这个手镯，我们稍后在生死之塔见吧。")
      SET_QUEST_STATE(1390, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1347].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1390].state == 1 then
    QSTATE(id, 2)
  end
end
