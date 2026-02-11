function npcsay(id)
  if id ~= 4314010 then
    return
  end
  clickNPCid = id
  if qData[138].state == 1 and CHECK_ITEM_CNT(8990031) > 0 then
    NPC_SAY("{0xFFFFFF00}????? ???{END} ???? ?????.")
    return
  end
  if qData[19].state == 1 then
    if qData[19].meetNpc[1] == qt[19].goal.meetNpc[1] then
      NPC_SAY([[
?? ?? ??? ????.
??? ??? ??? ? ?? ??? ??? ?????.
??? ?? ?? {0xFFFF8C00}???? ??? ??? ????.{END}
??? ?? ???? ?? ?????.]])
      SET_QUEST_STATE(19, 2)
    else
      SET_MEETNPC(19, 1, id)
    end
    return
  elseif qData[32].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(32, 2)
    return
  elseif qData[33].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(33, 2)
    return
  elseif qData[34].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(34, 2)
    return
  elseif qData[35].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(35, 2)
    return
  elseif qData[36].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(36, 2)
    return
  elseif qData[37].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(37, 2)
    return
  elseif qData[38].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(38, 2)
    return
  elseif qData[39].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(39, 2)
    return
  elseif qData[40].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(40, 2)
    return
  elseif qData[41].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(41, 2)
    return
  elseif qData[680].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(680, 2)
    return
  elseif qData[681].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(681, 2)
    return
  elseif qData[280].state == 1 then
    if CHECK_ITEM_CNT(qt[280].goal.getItem[1].id) >= qt[280].goal.getItem[1].count then
      NPC_SAY("?? ???. ????? ??? ?? ????. ? ??? ?? ????.")
      SET_MEETNPC(280, 1, id)
      SET_QUEST_STATE(280, 2)
    else
      NPC_SAY("{0xFFFFFF00}???? ??{END}? ?????")
    end
  elseif qData[281].state == 1 then
    NPC_SAY("{0xFFFFFF00}??????{END}? ??? {0xFFFF0000}?????{END}?? ????.")
  else
    NPC_SAY("我是刺客技能传授NPC。你有什么想问我的吗？")
    ADD_EX_BTN(id)
  end
  if qData[280].state == 2 and qData[281].state == 0 then
    ADD_QUEST_BTN(qt[281].id, qt[281].name)
  end
end
function saychjob(id)
  if GET_PLAYER_JOB1() ~= 0 then
    NPC_SAY("已经拥有职业了啊。")
    return
  end
  if GET_PLAYER_LEVEL() >= qt[19].needLevel then
    if qData[19].state == 0 then
      if qData[16].state ~= 0 or qData[21].state ~= 0 or qData[351].state ~= 0 or qData[612].state ~= 0 then
        NPC_SAY("????? ???? ??? ? ????.")
      elseif GET_PLAYER_USESKILLPOINT_C() < 18 then
        NPC_SAY([[
?? ?? 10??? ?? ???? ?? ?? ??? ??? ?????. 
{0xFFFF8C00}[D]?? ??? ?? ???? ??? ??????.{END} ?? ???? ?? ???? [Shift]?? ??? ?? ???? ?????.]])
      else
        ADD_QUEST_BTN(qt[19].id, qt[19].name)
      end
    end
  else
    NPC_SAY([[
?? ??? ?????.
??? ??? {0xFFFF8C00}???{END}?? ??? ? ?? {0xFFFFFF00}?? 10{END}?
??? ?? ???.]])
  end
end
function saycanleanskill(id)
  if GET_PLAYER_JOB1() ~= 2 then
    NPC_SAY("没有可以教你的武功")
    return
  end
  if qData[32].state == 1 or qData[33].state == 1 or qData[34].state == 1 or qData[35].state == 1 or qData[36].state == 1 or qData[37].state == 1 or qData[38].state == 1 or qData[39].state == 1 or qData[40].state == 1 or qData[41].state == 1 then
    NPC_SAY("武功任务不能重复进行 ")
    return
  end
  if CHECK_SKILL(qt[32].reward.getSkill[1]) == false and qData[32].state == 0 then
    ADD_QUEST_BTN(qt[32].id, qt[32].name)
  end
  if CHECK_SKILL(qt[33].reward.getSkill[1]) == false and qData[33].state == 0 then
    ADD_QUEST_BTN(qt[33].id, qt[33].name)
  end
  if CHECK_SKILL(qt[34].reward.getSkill[1]) == false and qData[34].state == 0 then
    ADD_QUEST_BTN(qt[34].id, qt[34].name)
  end
  if CHECK_SKILL(qt[35].reward.getSkill[1]) == false and qData[35].state == 0 then
    ADD_QUEST_BTN(qt[35].id, qt[35].name)
  end
  if CHECK_SKILL(qt[36].reward.getSkill[1]) == false and qData[36].state == 0 then
    ADD_QUEST_BTN(qt[36].id, qt[36].name)
  end
  if CHECK_SKILL(qt[37].reward.getSkill[1]) == false and qData[37].state == 0 then
    ADD_QUEST_BTN(qt[37].id, qt[37].name)
  end
  if CHECK_SKILL(qt[38].reward.getSkill[1]) == false and qData[38].state == 0 then
    ADD_QUEST_BTN(qt[38].id, qt[38].name)
  end
  if CHECK_SKILL(qt[39].reward.getSkill[1]) == false and qData[39].state == 0 then
    ADD_QUEST_BTN(qt[39].id, qt[39].name)
  end
  if CHECK_SKILL(qt[40].reward.getSkill[1]) == false and qData[40].state == 0 then
    ADD_QUEST_BTN(qt[40].id, qt[40].name)
  end
  if CHECK_SKILL(qt[41].reward.getSkill[1]) == false and qData[41].state == 0 then
    ADD_QUEST_BTN(qt[41].id, qt[41].name)
  end
  if CHECK_SKILL(qt[680].reward.getSkill[1]) == false and qData[680].state == 0 then
    ADD_QUEST_BTN(qt[680].id, qt[680].name)
  end
  if CHECK_SKILL(qt[681].reward.getSkill[1]) == false and qData[681].state == 0 then
    ADD_QUEST_BTN(qt[681].id, qt[681].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[19].state ~= 2 and GET_PLAYER_LEVEL() >= qt[19].needLevel and GET_PLAYER_JOB1() <= 0 then
    if qData[19].state == 1 then
      if qData[19].meetNpc[1] == qt[19].goal.meetNpc[1] then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[280].state == 1 and GET_PLAYER_LEVEL() >= qt[280].needLevel then
    if CHECK_ITEM_CNT(qt[280].goal.getItem[1].id) >= qt[280].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[281].state ~= 2 and qData[280].state == 2 and GET_PLAYER_LEVEL() >= qt[281].needLevel then
    if qData[281].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
