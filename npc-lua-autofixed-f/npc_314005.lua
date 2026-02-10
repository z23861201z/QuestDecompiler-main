function npcsay(id)
  if id ~= 4314005 then
    return
  end
  clickNPCid = id
  if qData[1].state == 1 then
    if qData[1].meetNpc[1] == qt[1].goal.meetNpc[1] and qData[1].meetNpc[2] ~= id or qData[1].meetNpc[1] == qt[1].goal.meetNpc[1] and qData[1].meetNpc[2] == id and CHECK_ITEM_CNT(8990001) <= 0 and qData[1].meetNpc[3] ~= qt[1].goal.meetNpc[3] then
      NPC_QSAY(1, 4)
      SET_INFO(1, 2)
      SET_MEETNPC(1, 2, id)
      return
    elseif qData[1].meetNpc[3] == qt[1].goal.meetNpc[3] and qData[1].meetNpc[4] ~= id then
      NPC_QSAY(1, 10)
      SET_MEETNPC(1, 4, id)
      SET_QUEST_STATE(1, 2)
      return
    else
      NPC_SAY("?? ??? ????")
    end
  end
  if qData[1].state == 0 then
    ADD_QUEST_BTN(qt[1].id, qt[1].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1].needLevel then
    if qData[1].state == 1 then
      if qData[1].meetNpc[1] == qt[1].goal.meetNpc[1] and qData[1].meetNpc[2] ~= id or qData[1].meetNpc[1] == qt[1].goal.meetNpc[1] and qData[1].meetNpc[2] == id and CHECK_ITEM_CNT(8990001) <= 0 and qData[1].meetNpc[3] ~= qt[1].goal.meetNpc[3] then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
