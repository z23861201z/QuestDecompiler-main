local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4314001 then
    return
  end
  clickNPCid = id
  if qData[1130].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1130].goal.getItem) and __QUEST_CHECK_ITEMS(qt[1130].goal.getItem) then
      NPC_SAY("谢谢了，现在长长的押镖之路也不用担心了。")
      SET_QUEST_STATE(1130, 2)
    else
      NPC_SAY("拜托你收集10个[ 蝎脚亭的尾巴 ]，10个[ 破烂的雨伞 ]。")
    end
  end
  if qData[1145].state == 1 then
    if qData[1145].meetNpc[1] == qt[1145].goal.meetNpc[1] and qData[1145].meetNpc[2] == qt[1145].goal.meetNpc[2] and qData[1145].meetNpc[3] ~= id then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("什么？说忙都不见你？没办法了。让你再去找你就快点去吧。总之谢谢了。")
        SET_MEETNPC(1145, 3, id)
        SET_QUEST_STATE(1145, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去见见白斩姬和乌骨鸡了解一下情况吧。")
    end
  end
  if qData[1183].state == 1 then
    NPC_SAY("替无名湖的精灵匠人去竹林击退箭骨头，收集20个[ 受诅咒的骨头 ]回来吧。")
  end
  if qData[1130].state == 0 and GET_PLAYER_LEVEL() >= qt[1130].needLevel then
    ADD_QUEST_BTN(qt[1130].id, qt[1130].name)
  end
  if qData[1145].state == 0 and GET_PLAYER_LEVEL() >= qt[1145].needLevel then
    ADD_QUEST_BTN(qt[1145].id, qt[1145].name)
  end
  if qData[1183].state == 0 and GET_PLAYER_LEVEL() >= qt[1183].needLevel then
    ADD_QUEST_BTN(qt[1183].id, qt[1183].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1130].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1130].needLevel then
    if qData[1130].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[1130].goal.getItem) and __QUEST_CHECK_ITEMS(qt[1130].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1121].state == 2 and qData[1145].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1145].needLevel then
    if qData[1145].state == 1 then
      if qData[1145].meetNpc[1] == qt[1145].goal.meetNpc[1] and qData[1145].meetNpc[2] == qt[1145].goal.meetNpc[2] and qData[1145].meetNpc[3] ~= id then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1183].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1183].needLevel then
    if qData[1183].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
