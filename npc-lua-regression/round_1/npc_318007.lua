function npcsay(id)
  if id ~= 4318007 then
    return
  end
  clickNPCid = id
  if qData[612].state == 1 then
    if qData[612].meetNpc[1] == qt[612].goal.meetNpc[1] then
      NPC_SAY([[
?? ??? ???????.
??? ??? ??? ? ?? ??? ??? ?????.
??? ??, {0xFFFF8C00}???? ??? ??? ??? ???.{END}]])
      SET_QUEST_STATE(612, 2)
    else
      SET_MEETNPC(612, 1, id)
    end
    return
  elseif qData[613].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(613, 2)
    return
  elseif qData[614].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(614, 2)
    return
  elseif qData[615].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(615, 2)
    return
  elseif qData[616].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(616, 2)
    return
  elseif qData[617].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(617, 2)
    return
  elseif qData[618].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(618, 2)
    return
  elseif qData[619].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(619, 2)
    return
  elseif qData[620].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(620, 2)
    return
  elseif qData[621].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(621, 2)
    return
  elseif qData[622].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(622, 2)
    return
  elseif qData[623].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(623, 2)
    return
  elseif qData[624].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(624, 2)
    return
  else
    NPC_SAY("我是射手技能传授NPC。你有什么想问我的吗？")
    ADD_EX_BTN(id)
  end
end
function saychjob(id)
  if GET_PLAYER_JOB1() ~= 0 then
    NPC_SAY("已经拥有职业了啊。")
    return
  end
  if GET_PLAYER_LEVEL() >= qt[612].needLevel then
    if qData[612].state == 0 then
      if qData[16].state ~= 0 or qData[19].state ~= 0 or qData[21].state ~= 0 or qData[351].state ~= 0 then
        NPC_SAY("????? ???? ??? ? ???.")
      elseif GET_PLAYER_USESKILLPOINT_C() < 18 then
        NPC_SAY([[
?? ?? 10??? ?? ???? ?? ???? ??? ?? ??. 
{0xFFFF8C00}[D]?? ??? ?? ???? ??? ?????.{END} ?? ???? ?? ???? [Shift]?? ??? ?? ???? ????.]])
      else
        ADD_QUEST_BTN(qt[612].id, qt[612].name)
      end
    end
  else
    NPC_SAY([[
?? ??????.
??? ??? {0xFFFF8C00}???{END}?? ??? ? ?? {0xFFFFFF00}?? 10{END}?
??? ?????.]])
  end
end
function saycanleanskill(id)
  if GET_PLAYER_JOB1() ~= 5 then
    NPC_SAY("没有可以教你的武功")
    return
  end
  if qData[613].state == 1 or qData[614].state == 1 or qData[615].state == 1 or qData[616].state == 1 or qData[617].state == 1 or qData[618].state == 1 or qData[619].state == 1 or qData[620].state == 1 or qData[621].state == 1 or qData[622].state == 1 or qData[623].state == 1 or qData[624].state == 1 then
    NPC_SAY("武功任务不能重复进行 ")
    return
  end
  if CHECK_SKILL(qt[613].reward.getSkill[1]) == false and qData[613].state == 0 then
    ADD_QUEST_BTN(qt[613].id, qt[613].name)
  end
  if CHECK_SKILL(qt[614].reward.getSkill[1]) == false and qData[614].state == 0 then
    ADD_QUEST_BTN(qt[614].id, qt[614].name)
  end
  if CHECK_SKILL(qt[615].reward.getSkill[1]) == false and qData[615].state == 0 then
    ADD_QUEST_BTN(qt[615].id, qt[615].name)
  end
  if CHECK_SKILL(qt[616].reward.getSkill[1]) == false and qData[616].state == 0 then
    ADD_QUEST_BTN(qt[616].id, qt[616].name)
  end
  if CHECK_SKILL(qt[617].reward.getSkill[1]) == false and qData[617].state == 0 then
    ADD_QUEST_BTN(qt[617].id, qt[617].name)
  end
  if CHECK_SKILL(qt[618].reward.getSkill[1]) == false and qData[618].state == 0 then
    ADD_QUEST_BTN(qt[618].id, qt[618].name)
  end
  if CHECK_SKILL(qt[619].reward.getSkill[1]) == false and qData[619].state == 0 then
    ADD_QUEST_BTN(qt[619].id, qt[619].name)
  end
  if CHECK_SKILL(qt[620].reward.getSkill[1]) == false and qData[620].state == 0 then
    ADD_QUEST_BTN(qt[620].id, qt[620].name)
  end
  if CHECK_SKILL(qt[621].reward.getSkill[1]) == false and qData[621].state == 0 then
    ADD_QUEST_BTN(qt[621].id, qt[621].name)
  end
  if CHECK_SKILL(qt[622].reward.getSkill[1]) == false and qData[622].state == 0 then
    ADD_QUEST_BTN(qt[622].id, qt[622].name)
  end
  if CHECK_SKILL(qt[623].reward.getSkill[1]) == false and qData[623].state == 0 then
    ADD_QUEST_BTN(qt[623].id, qt[623].name)
  end
  if CHECK_SKILL(qt[624].reward.getSkill[1]) == false and qData[624].state == 0 then
    ADD_QUEST_BTN(qt[624].id, qt[624].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
