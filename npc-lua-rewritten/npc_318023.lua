local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4318023 then
    return
  end
  clickNPCid = id
  if qData[778].state == 1 then
    if qData[778].killMonster[qt[778].goal.killMonster[1].id] >= qt[778].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}???{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(778, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}???{END}? ??? ??????")
    end
  end
  if qData[779].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[779].goal.getItem) then
      NPC_SAY("?? {0xFFFFFF00}??? ??{END}?? ??? ???.")
      return
    else
      NPC_SAY("{0xFFFFFF00}?????{END}? ??????")
    end
  end
  if qData[780].state == 1 then
    if qData[780].killMonster[qt[780].goal.killMonster[1].id] >= qt[780].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}???{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(780, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}???{END}? ??? ??????")
    end
  end
  if qData[781].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[781].goal.getItem) then
      NPC_SAY("??? {0xFFFFFF00}??? ??{END}?? ?? ?? ?????.")
      SET_QUEST_STATE(781, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}????{END}? ??????")
    end
  end
  if qData[782].state == 1 then
    if qData[782].killMonster[qt[782].goal.killMonster[1].id] >= qt[782].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}????{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(782, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}????{END}? ??? ??????")
    end
  end
  if qData[783].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[783].goal.getItem) then
      NPC_SAY("??? {0xFFFFFF00}??? ??{END}?? ?? ?? ?????.")
      SET_QUEST_STATE(783, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}??????{END}? ??????")
    end
  end
  if qData[784].state == 1 then
    if qData[784].killMonster[qt[784].goal.killMonster[1].id] >= qt[784].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}????{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(784, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}????{END}? ??? ??????")
    end
  end
  if qData[785].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[785].goal.getItem) then
      NPC_SAY("{0xFFFFFF00}????{END}? ????? ??? ??? ???? ??? ????. {0xFFFFFF00}PLAYERNAME{END}?? ??? ? ???? ????.")
      SET_QUEST_STATE(785, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}??????{END}? ??????")
    end
  end
  if qData[786].state == 1 then
    if qData[786].killMonster[qt[786].goal.killMonster[1].id] >= qt[786].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}???{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(786, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}???{END}? ??? ??????")
    end
  end
  if qData[787].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[787].goal.getItem) then
      NPC_SAY("??? {0xFFFFFF00}??? ??{END}?? ?? ?? ?????. ")
      SET_QUEST_STATE(787, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}?????{END}? ??????")
    end
  end
  if qData[788].state == 1 then
    if qData[788].killMonster[qt[788].goal.killMonster[1].id] >= qt[788].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}???{END}? ???? ?? ?? ???? ?? ??? ?????.")
      SET_QUEST_STATE(788, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}???{END}? ??? ??????")
    end
  end
  if qData[789].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[789].goal.getItem) then
      NPC_SAY("?????. {0xFFFFFF00}???? ???{END}? ?? ?? ?????.{0xFFFFFF00}PLAYERNAME{END}?? ?? ?? ?? ?????. ???[3]?? ?? ?????? ?? ???.")
      SET_QUEST_STATE(789, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}?????{END}? ??????")
    end
  end
  if qData[778].state == 0 then
    ADD_QUEST_BTN(qt[778].id, qt[778].name)
  end
  if qData[779].state == 0 then
    ADD_QUEST_BTN(qt[779].id, qt[779].name)
  end
  if qData[780].state == 0 then
    ADD_QUEST_BTN(qt[780].id, qt[780].name)
  end
  if qData[781].state == 0 then
    ADD_QUEST_BTN(qt[781].id, qt[781].name)
  end
  if qData[782].state == 0 then
    ADD_QUEST_BTN(qt[782].id, qt[782].name)
  end
  if qData[783].state == 0 then
    ADD_QUEST_BTN(qt[783].id, qt[783].name)
  end
  if qData[784].state == 0 then
    ADD_QUEST_BTN(qt[784].id, qt[784].name)
  end
  if qData[785].state == 0 then
    ADD_QUEST_BTN(qt[785].id, qt[785].name)
  end
  if qData[786].state == 0 then
    ADD_QUEST_BTN(qt[786].id, qt[786].name)
  end
  if qData[787].state == 0 then
    ADD_QUEST_BTN(qt[787].id, qt[787].name)
  end
  if qData[788].state == 0 then
    ADD_QUEST_BTN(qt[788].id, qt[788].name)
  end
  if qData[789].state == 0 then
    ADD_QUEST_BTN(qt[789].id, qt[789].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[778].state ~= 2 and GET_PLAYER_LEVEL() >= qt[778].needLevel then
    if qData[778].state == 1 then
      if qData[778].killMonster[qt[778].goal.killMonster[1].id] >= qt[778].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[778].state)
      end
    else
      QSTATE(id, qData[778].state)
    end
  end
  if qData[779].state ~= 2 and GET_PLAYER_LEVEL() >= qt[779].needLevel then
    if qData[779].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[779].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[779].state)
      end
    else
      QSTATE(id, qData[779].state)
    end
  end
  if qData[780].state ~= 2 and GET_PLAYER_LEVEL() >= qt[780].needLevel then
    if qData[780].state == 1 then
      if qData[780].killMonster[qt[780].goal.killMonster[1].id] >= qt[780].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[780].state)
      end
    else
      QSTATE(id, qData[780].state)
    end
  end
  if qData[781].state ~= 2 and GET_PLAYER_LEVEL() >= qt[781].needLevel then
    if qData[781].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[781].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[781].state)
      end
    else
      QSTATE(id, qData[781].state)
    end
  end
  if qData[782].state ~= 2 and GET_PLAYER_LEVEL() >= qt[782].needLevel then
    if qData[782].state == 1 then
      if qData[782].killMonster[qt[782].goal.killMonster[1].id] >= qt[782].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[782].state)
      end
    else
      QSTATE(id, qData[782].state)
    end
  end
  if qData[783].state ~= 2 and GET_PLAYER_LEVEL() >= qt[783].needLevel then
    if qData[783].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[783].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[783].state)
      end
    else
      QSTATE(id, qData[783].state)
    end
  end
  if qData[784].state ~= 2 and GET_PLAYER_LEVEL() >= qt[784].needLevel then
    if qData[784].state == 1 then
      if qData[784].killMonster[qt[784].goal.killMonster[1].id] >= qt[784].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[784].state)
      end
    else
      QSTATE(id, qData[784].state)
    end
  end
  if qData[785].state ~= 2 and GET_PLAYER_LEVEL() >= qt[785].needLevel then
    if qData[785].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[785].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[785].state)
      end
    else
      QSTATE(id, qData[785].state)
    end
  end
  if qData[786].state ~= 2 and GET_PLAYER_LEVEL() >= qt[786].needLevel then
    if qData[786].state == 1 then
      if qData[786].killMonster[qt[786].goal.killMonster[1].id] >= qt[786].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[786].state)
      end
    else
      QSTATE(id, qData[786].state)
    end
  end
  if qData[787].state ~= 2 and GET_PLAYER_LEVEL() >= qt[787].needLevel then
    if qData[787].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[787].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[787].state)
      end
    else
      QSTATE(id, qData[787].state)
    end
  end
  if qData[788].state ~= 2 and GET_PLAYER_LEVEL() >= qt[788].needLevel then
    if qData[788].state == 1 then
      if qData[788].killMonster[qt[788].goal.killMonster[1].id] >= qt[788].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[788].state)
      end
    else
      QSTATE(id, qData[788].state)
    end
  end
  if qData[789].state ~= 2 and GET_PLAYER_LEVEL() >= qt[789].needLevel then
    if qData[789].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[789].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[789].state)
      end
    else
      QSTATE(id, qData[789].state)
    end
  end
end
