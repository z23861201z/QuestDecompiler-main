local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4318006 then
    return
  end
  clickNPCid = id
  if qData[1287].state == 1 then
    NPC_SAY("爸爸给我送来了这个？什么意思呢？总之我先收下。")
    SET_QUEST_STATE(1287, 2)
    return
  end
  if qData[1288].state == 1 then
    NPC_SAY("我父亲是土著民副族长，现在在韩野村南边的宝芝林内部。")
  end
  if qData[1290].state == 1 and __QUEST_CHECK_ITEMS(qt[1290].goal.getItem) then
    NPC_SAY("嗯？为什么要让我看这个呢？")
    SET_QUEST_STATE(1290, 2)
  end
  if qData[1291].state == 1 then
    NPC_SAY("在我们还没有到之前去见韩野村码头的研究船的人，提前做好准备吧。")
  end
  if qData[1288].state == 0 and qData[1287].state == 2 and GET_PLAYER_LEVEL() >= qt[1288].needLevel then
    ADD_QUEST_BTN(qt[1288].id, qt[1288].name)
  end
  if qData[1291].state == 0 and qData[1290].state == 2 and GET_PLAYER_LEVEL() >= qt[1291].needLevel then
    ADD_QUEST_BTN(qt[1291].id, qt[1291].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1287].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1288].state ~= 2 and qData[1287].state == 2 and GET_PLAYER_LEVEL() >= qt[1288].needLevel then
    if qData[1288].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1291].state ~= 2 and qData[1290].state == 2 and GET_PLAYER_LEVEL() >= qt[1291].needLevel then
    if qData[1291].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
