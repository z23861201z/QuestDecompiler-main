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
  if id ~= 4341020 then
    return
  end
  clickNPCid = id
  NPC_SAY("今天也来喝一杯逃避现实吧！")
  if qData[2724].state == 1 then
    if qData[2724].meetNpc[1] == qt[2724].goal.meetNpc[1] and qData[2724].meetNpc[2] ~= id and __QUEST_HAS_ALL_ITEMS(qt[2724].goal.getItem) then
      NPC_SAY("哦~洗头的时候用这个搓一下就会变得垂顺飘逸是吧？谢谢。")
      SET_MEETNPC(2724, 2, id)
      SET_QUEST_STATE(2724, 2)
      return
    else
      NPC_SAY("我也想要那垂顺飘逸的头发...你能帮我打听一下保养发质的秘密吗？")
    end
  end
  if qData[2724].state == 0 and GET_PLAYER_LEVEL() >= qt[2724].needLevel then
    ADD_QUEST_BTN(qt[2724].id, qt[2724].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2724].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2724].needLevel then
    if qData[2724].state == 1 then
      if qData[2724].meetNpc[1] == qt[2724].goal.meetNpc[1] and qData[2724].meetNpc[2] ~= id and __QUEST_HAS_ALL_ITEMS(qt[2724].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
