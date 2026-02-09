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
  if id ~= 4323001 then
    return
  end
  NPC_SAY("只有笑容才是熬过这艰难时期的原动力！")
  clickNPCid = id
  if qData[2600].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2600].goal.getItem) then
      NPC_SAY("谢谢！你是我们王国的恩人~这是我给恩人准备的礼物。")
      SET_QUEST_STATE(2600, 2)
      return
    else
      NPC_SAY("那我就信你一次。击退{0xFFFFFF00}[雷神]{END}后，作为证据拿来{0xFFFFFF00}1个雷神符咒{END}就可以了。")
    end
  end
  if qData[2600].state == 0 and GET_PLAYER_LEVEL() >= qt[2600].needLevel then
    ADD_QUEST_BTN(qt[2600].id, qt[2600].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2600].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2600].needLevel then
    if qData[2600].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2600].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
