function npcsay(id)
  if id ~= 4314011 then
    return
  end
  clickNPCid = id
  if qData[21].state == 1 then
    if qData[21].meetNpc[1] == qt[21].goal.meetNpc[1] then
      NPC_SAY([[
?? ??? ?????.
??? ??? ??? ? ?? ??? ??? ????.
??? ?? ??? {0xFFFF8C00}???? ???? ??? ???.{END}
??? ???? ???? ??? ?????.]])
      SET_QUEST_STATE(21, 2)
    else
      SET_MEETNPC(21, 1, id)
    end
    return
  elseif qData[42].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(42, 2)
    return
  elseif qData[43].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(43, 2)
    return
  elseif qData[44].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(44, 2)
    return
  elseif qData[45].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(45, 2)
    return
  elseif qData[46].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(46, 2)
    return
  elseif qData[47].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(47, 2)
    return
  elseif qData[48].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(48, 2)
    return
  elseif qData[49].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(49, 2)
    return
  elseif qData[50].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(50, 2)
    return
  elseif qData[51].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(51, 2)
    return
  elseif qData[682].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(682, 2)
    return
  elseif qData[683].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(683, 2)
    return
  elseif qData[279].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[279].goal.getItem) then
      NPC_SAY("??? ?? ??? ??? ?? ?? ???! ?? ???? ? ??? ???? ???? ??? ????.")
      SET_MEETNPC(279, 1, id)
      SET_QUEST_STATE(279, 2)
    else
      NPC_SAY("{0xFFFFFF00}???? ??{END}? ??????")
    end
  elseif qData[280].state == 1 then
    NPC_SAY("{0xFFFFFF00}??????{END}? ??? {0xFFFFFF00}?????? ????.{END}")
  else
    NPC_SAY("我是道士技能传授NPC。你想从我这个老人家这里知道什么啊？")
    ADD_EX_BTN(id)
  end
  if qData[279].state == 2 and qData[280].state == 0 then
    ADD_QUEST_BTN(qt[280].id, qt[280].name)
  end
end
function saychjob(id)
  if GET_PLAYER_JOB1() ~= 0 then
    NPC_SAY("已经拥有职业了啊。")
    return
  end
  if GET_PLAYER_LEVEL() >= qt[21].needLevel then
    if qData[21].state == 0 then
      if qData[16].state ~= 0 or qData[19].state ~= 0 or qData[351].state ~= 0 or qData[612].state ~= 0 then
        NPC_SAY("????? ???? ??? ? ???.")
      elseif GET_PLAYER_USESKILLPOINT_C() < 18 then
        NPC_SAY([[
?? ?? 10??? ?? ???? ?? ???? ??? ?? ??. 
{0xFFFF8C00}[D]?? ??? ?? ???? ??? ?????.{END} ?? ???? ?? ???? ?? [Shift]?? ??? ?? ???? ????.]])
      else
        ADD_QUEST_BTN(qt[21].id, qt[21].name)
      end
    end
  else
    NPC_SAY([[
??? ?? ????.
??? ??? {0xFFFF8C00}???{END}?? ??? ? ?? {0xFFFFFF00}?? 10{END}?
??? ?????.]])
  end
end
function saycanleanskill(id)
  if GET_PLAYER_JOB1() ~= 3 then
    NPC_SAY("没有可以教你的武功")
    return
  end
  if qData[42].state == 1 or qData[43].state == 1 or qData[44].state == 1 or qData[45].state == 1 or qData[46].state == 1 or qData[47].state == 1 or qData[48].state == 1 or qData[49].state == 1 or qData[50].state == 1 or qData[51].state == 1 then
    NPC_SAY("武功任务不能重复进行 ")
    return
  end
  if CHECK_SKILL(qt[42].reward.getSkill[1]) == false and qData[42].state == 0 then
    ADD_QUEST_BTN(qt[42].id, qt[42].name)
  end
  if CHECK_SKILL(qt[43].reward.getSkill[1]) == false and qData[43].state == 0 then
    ADD_QUEST_BTN(qt[43].id, qt[43].name)
  end
  if CHECK_SKILL(qt[44].reward.getSkill[1]) == false and qData[44].state == 0 then
    ADD_QUEST_BTN(qt[44].id, qt[44].name)
  end
  if CHECK_SKILL(qt[45].reward.getSkill[1]) == false and qData[45].state == 0 then
    ADD_QUEST_BTN(qt[45].id, qt[45].name)
  end
  if CHECK_SKILL(qt[46].reward.getSkill[1]) == false and qData[46].state == 0 then
    ADD_QUEST_BTN(qt[46].id, qt[46].name)
  end
  if CHECK_SKILL(qt[47].reward.getSkill[1]) == false and qData[47].state == 0 then
    ADD_QUEST_BTN(qt[47].id, qt[47].name)
  end
  if CHECK_SKILL(qt[48].reward.getSkill[1]) == false and qData[48].state == 0 then
    ADD_QUEST_BTN(qt[48].id, qt[48].name)
  end
  if CHECK_SKILL(qt[49].reward.getSkill[1]) == false and qData[49].state == 0 then
    ADD_QUEST_BTN(qt[49].id, qt[49].name)
  end
  if CHECK_SKILL(qt[50].reward.getSkill[1]) == false and qData[50].state == 0 then
    ADD_QUEST_BTN(qt[50].id, qt[50].name)
  end
  if CHECK_SKILL(qt[51].reward.getSkill[1]) == false and qData[51].state == 0 then
    ADD_QUEST_BTN(qt[51].id, qt[51].name)
  end
  if CHECK_SKILL(qt[682].reward.getSkill[1]) == false and qData[682].state == 0 then
    ADD_QUEST_BTN(qt[682].id, qt[682].name)
  end
  if CHECK_SKILL(qt[683].reward.getSkill[1]) == false and qData[683].state == 0 then
    ADD_QUEST_BTN(qt[683].id, qt[683].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[21].state ~= 2 and GET_PLAYER_LEVEL() >= qt[21].needLevel and GET_PLAYER_JOB1() <= 0 then
    if qData[21].state == 1 then
      if qData[21].meetNpc[1] == qt[21].goal.meetNpc[1] then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[279].state == 2 and qData[280].state ~= 2 and GET_PLAYER_LEVEL() >= qt[280].needLevel then
    if qData[280].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
