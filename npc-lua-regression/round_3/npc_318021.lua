function npcsay(id)
  if id ~= 4318021 then
    return
  end
  clickNPCid = id
  if qData[765].state == 1 then
    if qData[765].killMonster[qt[765].goal.killMonster[1].id] >= qt[765].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}???{END}? ???? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(765, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}???{END}? ??? ??????")
    end
  end
  if qData[766].state == 1 then
    if qData[766].killMonster[qt[766].goal.killMonster[1].id] >= qt[766].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}???{END}? ???? ???? ?? ??? ?? ?????. ")
      SET_QUEST_STATE(766, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}???{END}? ??? ??????")
    end
  end
  if qData[767].state == 1 then
    if qData[767].killMonster[qt[767].goal.killMonster[1].id] >= qt[767].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}???{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(767, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}???{END}? ??? ??????")
    end
  end
  if qData[768].state == 1 then
    if qData[768].killMonster[qt[768].goal.killMonster[1].id] >= qt[768].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}??{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(768, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}??{END}? ??? ??????")
    end
  end
  if qData[769].state == 1 then
    if qData[769].killMonster[qt[769].goal.killMonster[1].id] >= qt[769].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}???{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(769, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}???{END}? ??? ??????")
    end
  end
  if qData[770].state == 1 then
    if qData[770].killMonster[qt[770].goal.killMonster[1].id] >= qt[770].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}????{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(770, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}????{END}? ??? ??????")
    end
  end
  if qData[771].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[771].goal.getItem) then
      NPC_SAY("{0xFFFFFF00}?????{END}? ????? ?? ?? ????. ????. {0xFFFFFF00}PLAYERNAME{END}?? ?? ?? ?? ?????. {0xFFFFFF00}???[2]? ?? ?????{END}? ?? ???.")
      SET_QUEST_STATE(771, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}?????{END}? ?????? 10?? ?? ???.")
    end
  end
  if qData[765].state == 0 then
    ADD_QUEST_BTN(qt[765].id, qt[765].name)
  end
  if qData[766].state == 0 then
    ADD_QUEST_BTN(qt[766].id, qt[766].name)
  end
  if qData[767].state == 0 then
    ADD_QUEST_BTN(qt[767].id, qt[767].name)
  end
  if qData[768].state == 0 then
    ADD_QUEST_BTN(qt[768].id, qt[768].name)
  end
  if qData[769].state == 0 then
    ADD_QUEST_BTN(qt[769].id, qt[769].name)
  end
  if qData[770].state == 0 then
    ADD_QUEST_BTN(qt[770].id, qt[770].name)
  end
  if qData[771].state == 0 then
    ADD_QUEST_BTN(qt[771].id, qt[771].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[765].state ~= 2 and GET_PLAYER_LEVEL() >= qt[765].needLevel then
    if qData[765].state == 1 then
      if qData[765].killMonster[qt[765].goal.killMonster[1].id] >= qt[765].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[765].state)
      end
    else
      QSTATE(id, qData[765].state)
    end
  end
  if qData[766].state ~= 2 and GET_PLAYER_LEVEL() >= qt[766].needLevel then
    if qData[766].state == 1 then
      if qData[766].killMonster[qt[766].goal.killMonster[1].id] >= qt[766].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[766].state)
      end
    else
      QSTATE(id, qData[766].state)
    end
  end
  if qData[767].state ~= 2 and GET_PLAYER_LEVEL() >= qt[767].needLevel then
    if qData[767].state == 1 then
      if qData[767].killMonster[qt[767].goal.killMonster[1].id] >= qt[767].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[767].state)
      end
    else
      QSTATE(id, qData[767].state)
    end
  end
  if qData[768].state ~= 2 and GET_PLAYER_LEVEL() >= qt[768].needLevel then
    if qData[768].state == 1 then
      if qData[768].killMonster[qt[768].goal.killMonster[1].id] >= qt[768].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[768].state)
      end
    else
      QSTATE(id, qData[768].state)
    end
  end
  if qData[769].state ~= 2 and GET_PLAYER_LEVEL() >= qt[769].needLevel then
    if qData[769].state == 1 then
      if qData[769].killMonster[qt[769].goal.killMonster[1].id] >= qt[769].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[769].state)
      end
    else
      QSTATE(id, qData[769].state)
    end
  end
  if qData[770].state ~= 2 and GET_PLAYER_LEVEL() >= qt[770].needLevel then
    if qData[770].state == 1 then
      if qData[770].killMonster[qt[770].goal.killMonster[1].id] >= qt[770].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[770].state)
      end
    else
      QSTATE(id, qData[770].state)
    end
  end
  if qData[771].state ~= 2 and GET_PLAYER_LEVEL() >= qt[771].needLevel then
    if qData[771].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[771].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[771].state)
      end
    else
      QSTATE(id, qData[771].state)
    end
  end
end
