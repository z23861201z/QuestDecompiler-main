local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4315024 then
    return
  end
  clickNPCid = id
  if qData[1091].state == 1 then
    if qData[1091].meetNpc[1] ~= id and CHECK_ITEM_CNT(8980109) > 0 then
      SET_INFO(1091, 1)
      NPC_QSAY(1091, 1)
      SET_MEETNPC(1091, 1, id)
      return
    else
      NPC_SAY("喜欢我的男的不止一两个，绝不原谅！")
    end
  end
  if qData[1254].state == 1 and __QUEST_CHECK_ITEMS(qt[1254].goal.getItem) then
    if 1 <= CHECK_INVENTORY_CNT(1) then
      NPC_SAY("这是…。没用的。又不是我的父母能活过来。呜呜…。")
      SET_QUEST_STATE(1254, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1255].state == 1 then
    if qData[1255].killMonster[qt[1255].goal.killMonster[1].id] >= qt[1255].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("现在…。现在在天之灵的双亲也可以安息了。真的很感谢。")
        SET_QUEST_STATE(1255, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去冥珠平原击退1只鸡冠呛吧。")
    end
  end
  if qData[1580].state == 1 then
    if qData[1580].meetNpc[1] ~= id and CHECK_ITEM_CNT(8980109) > 0 then
      SET_INFO(1580, 1)
      NPC_QSAY(1580, 1)
      SET_MEETNPC(1580, 1, id)
      return
    else
      NPC_SAY("在开学前收到了礼物，太开心了！")
    end
  end
  if qData[1255].state == 0 and qData[1254].state == 2 and GET_PLAYER_LEVEL() >= qt[1255].needLevel then
    ADD_QUEST_BTN(qt[1255].id, qt[1255].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1254].state ~= 2 and qData[1240].state == 2 and GET_PLAYER_LEVEL() >= qt[1254].needLevel and qData[1254].state == 1 and __QUEST_CHECK_ITEMS(qt[1254].goal.getItem) then
    if 1 <= CHECK_INVENTORY_CNT(1) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1255].state ~= 2 and qData[1254].state == 2 and GET_PLAYER_LEVEL() >= qt[1255].needLevel then
    if qData[1255].state == 1 then
      if qData[1255].killMonster[qt[1255].goal.killMonster[1].id] >= qt[1255].goal.killMonster[1].count then
        if 1 <= CHECK_INVENTORY_CNT(2) then
          QSTATE(id, 2)
        end
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1580].state == 1 then
    QSTATE(id, 1)
  end
end
