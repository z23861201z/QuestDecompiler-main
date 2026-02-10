function npcsay(id)
  if id ~= 4300140 then
    return
  end
  clickNPCid = id
  NPC_SAY("欢迎来到大目仔爱尔兰！这里景色不错吧？！")
  if qData[3705].state == 1 then
    if qData[3705].killMonster[qt[3705].goal.killMonster[1].id] >= qt[3705].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("谢谢！这是我给你的礼物~")
        SET_QUEST_STATE(3705, 2)
        return
      else
        NPC_SAY("行囊空间不足。")
      end
    else
      NPC_SAY("击退15个{0xFFFFFF00}[奇怪的杂草]{END}吧。")
    end
  end
  if qData[3705].state == 0 then
    ADD_QUEST_BTN(qt[3705].id, qt[3705].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3705].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3705].needLevel then
    if qData[3705].state == 1 then
      if qData[3705].killMonster[qt[3705].goal.killMonster[1].id] >= qt[3705].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
