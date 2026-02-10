function npcsay(id)
  if id ~= 4317005 then
    return
  end
  clickNPCid = id
  if qData[1137].state == 1 and qData[1137].meetNpc[1] == qt[1137].goal.meetNpc[1] and qData[1137].meetNpc[2] ~= id and CHECK_ITEM_CNT(8990012) > 0 then
    NPC_SAY("啊！真的太谢谢了。看到这个真是勇气倍增啊。")
    SET_MEETNPC(1137, 2, id)
  end
  if qData[1158].state == 1 then
    if qData[1158].killMonster[qt[1158].goal.killMonster[1].id] >= qt[1158].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("回来了？这么快？你很厉害啊？下次有事情还会叫你的。")
        SET_QUEST_STATE(1158, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去强悍巷道击退20只蓝舌跳跳鬼。")
    end
  end
  if qData[1169].state == 1 then
    if qData[1169].killMonster[qt[1169].goal.killMonster[1].id] >= qt[1169].goal.killMonster[1].count then
      NPC_SAY("谢谢。托PLAYERNAME的福可以创作出更好的作品了。那，这是我的诚意，请收下吧。")
      SET_QUEST_STATE(1169, 2)
    else
      NPC_SAY("20只土拨鼠还没击退完吗？土拨鼠在强悍巷道了。")
    end
  end
  if qData[1158].state == 0 then
    ADD_QUEST_BTN(qt[1158].id, qt[1158].name)
  end
  if qData[1169].state == 0 then
    ADD_QUEST_BTN(qt[1169].id, qt[1169].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1137].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1137].needLevel and qData[1137].state == 1 and qData[1137].meetNpc[1] == qt[1137].goal.meetNpc[1] and qData[1137].meetNpc[2] ~= id then
    QSTATE(id, 1)
  end
  if qData[1158].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1137].needLevel then
    if qData[1158].state == 1 then
      if qData[1158].killMonster[qt[1158].goal.killMonster[1].id] >= qt[1158].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1169].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1169].needLevel then
    if qData[1169].state == 1 then
      if qData[1169].killMonster[qt[1169].goal.killMonster[1].id] >= qt[1169].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
