local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4301002 then
    return
  end
  clickNPCid = id
  NPC_SAY("好饿啊~谁要是能给我鱼就好了~")
  if qData[1078].state == 1 and __QUEST_CHECK_ITEMS(qt[1078].goal.getItem) then
    NPC_SAY("喵？让我把娃娃分给孩子们？谢谢 喵~这样我的人气会更高的 喵~")
    SET_QUEST_STATE(1078, 2)
    return
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1078].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1078].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
end
