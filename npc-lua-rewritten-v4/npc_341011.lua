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
  if id ~= 4341011 then
    return
  end
  clickNPCid = id
  NPC_SAY("亲，亲卫队莎易！执勤中 无异常!”")
  if qData[2908].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2908].goal.getItem) then
      NPC_SAY("谢，谢谢。")
      SET_QUEST_STATE(2908, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}大瀑布{END}的{0xFFFFFF00}飞翅怪鱼{END}，收集60个{0xFFFFFF00}发光的触角{END}回来吧。")
    end
  end
  if qData[2908].state == 0 and GET_PLAYER_LEVEL() >= qt[2908].needLevel then
    ADD_QUEST_BTN(qt[2908].id, qt[2908].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2908].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2908].needLevel then
    if qData[2908].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2908].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
