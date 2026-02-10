function npcsay(id)
  if id ~= 4314002 then
    return
  end
  clickNPCid = id
  if qData[1129].state == 1 then
    if qData[1129].killMonster[qt[1129].goal.killMonster[1].id] >= qt[1129].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("你看吧！我说的对吧？这是谢礼。")
        SET_QUEST_STATE(1129, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("帮我证明我不是做梦！去击退北清阴平原的15个蛋蛋小妖吧。")
    end
  end
  if qData[1144].state == 1 then
    if qData[1144].killMonster[qt[1144].goal.killMonster[1].id] >= qt[1144].goal.killMonster[1].count then
      NPC_SAY("现在可以睡个安稳觉… 不是，是警戒了。谢谢你，少侠。")
      SET_QUEST_STATE(1144, 2)
    else
      NPC_SAY("我不是胆小鬼！快点击退芦苇林的20个姜丝男吧。")
    end
  end
  if qData[1129].state == 0 then
    ADD_QUEST_BTN(qt[1129].id, qt[1129].name)
  end
  if qData[1144].state == 0 then
    ADD_QUEST_BTN(qt[1144].id, qt[1144].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1129].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1129].needLevel then
    if qData[1129].state == 1 then
      if qData[1129].killMonster[qt[1129].goal.killMonster[1].id] >= qt[1129].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1144].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1129].needLevel then
    if qData[1144].state == 1 then
      if qData[1144].killMonster[qt[1144].goal.killMonster[1].id] >= qt[1144].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
