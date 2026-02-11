function npcsay(id)
  if id ~= 4315013 then
    return
  end
  clickNPCid = id
  if qData[1317].state == 1 then
    NPC_SAY("好久不见。")
    SET_QUEST_STATE(1317, 2)
    return
  end
  if qData[1318].state == 1 then
    NPC_SAY("（回到冥珠城南边的偷笔怪盗那儿吧。）")
  end
  if qData[1386].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(1) then
      NPC_SAY("又来了？这次是为了血玉髓，那孩子而来的吧？")
      SET_QUEST_STATE(1386, 2)
      return
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1387].state == 1 then
    if qData[1387].killMonster[qt[1387].goal.killMonster[1].id] >= qt[1387].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("来得很快啊，总是让我很惊讶。但跟以前的你比起来，差距还是很大的。")
        SET_QUEST_STATE(1387, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退50个生死之房的侵蚀红树妖之后回来吧。之后才可以告诉你方法。")
    end
  end
  if qData[1388].state == 1 then
    NPC_SAY("……。（又没有回应了。得去生死之塔入口见见武艺僧长经。）")
  end
  if qData[1318].state == 0 and qData[1317].state == 2 and GET_PLAYER_LEVEL() >= qt[1318].needLevel then
    ADD_QUEST_BTN(qt[1318].id, qt[1318].name)
  end
  if qData[1387].state == 0 and qData[1386].state == 2 and GET_PLAYER_LEVEL() >= qt[1387].needLevel then
    ADD_QUEST_BTN(qt[1387].id, qt[1387].name)
  end
  if qData[1388].state == 0 and qData[1387].state == 2 and GET_PLAYER_LEVEL() >= qt[1388].needLevel then
    ADD_QUEST_BTN(qt[1388].id, qt[1388].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1317].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1318].state ~= 2 and qData[1317].state == 2 and GET_PLAYER_LEVEL() >= qt[1318].needLevel then
    if qData[1318].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1386].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1387].state ~= 2 and qData[1386].state == 2 and GET_PLAYER_LEVEL() >= qt[1387].needLevel then
    if qData[1387].state == 1 then
      if qData[1387].killMonster[qt[1387].goal.killMonster[1].id] >= qt[1387].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1388].state ~= 2 and qData[1387].state == 2 and GET_PLAYER_LEVEL() >= qt[1388].needLevel then
    if qData[1388].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
