function npcsay(id)
  if id ~= 4314009 then
    return
  end
  clickNPCid = id
  if qData[22].state == 1 then
    NPC_SAY("你好像已经决定了。那我就教你武功了。")
    SET_QUEST_STATE(22, 2)
    return
  elseif qData[23].state == 1 then
    NPC_SAY("你好像已经决定了。那我就教你武功了。")
    SET_QUEST_STATE(23, 2)
    return
  elseif qData[24].state == 1 then
    NPC_SAY("你好像已经决定了。那我就教你武功了。")
    SET_QUEST_STATE(24, 2)
    return
  elseif qData[25].state == 1 then
    NPC_SAY("你好像已经决定了。那我就教你武功了。")
    SET_QUEST_STATE(25, 2)
    return
  elseif qData[26].state == 1 then
    NPC_SAY("你好像已经决定了。那我就教你武功了。")
    SET_QUEST_STATE(26, 2)
    return
  elseif qData[27].state == 1 then
    NPC_SAY("你好像已经决定了。那我就教你武功了。")
    SET_QUEST_STATE(27, 2)
    return
  elseif qData[28].state == 1 then
    NPC_SAY("你好像已经决定了。那我就教你武功了。")
    SET_QUEST_STATE(28, 2)
    return
  elseif qData[29].state == 1 then
    NPC_SAY("你好像已经决定了。那我就教你武功了。")
    SET_QUEST_STATE(29, 2)
    return
  elseif qData[30].state == 1 then
    NPC_SAY("你好像已经决定了。那我就教你武功了。")
    SET_QUEST_STATE(30, 2)
    return
  elseif qData[31].state == 1 then
    NPC_SAY("你好像已经决定了。那我就教你武功了。")
    SET_QUEST_STATE(31, 2)
    return
  elseif qData[678].state == 1 then
    NPC_SAY("你好像已经决定了。那我就教你武功了。")
    SET_QUEST_STATE(678, 2)
    return
  elseif qData[679].state == 1 then
    NPC_SAY("你好像已经决定了。那我就教你武功了。")
    SET_QUEST_STATE(679, 2)
    return
  else
    NPC_SAY("我是武士技能传授NPC。你有什么想问我的吗？")
    ADD_EX_BTN(id)
  end
end
function saychjob(id)
  if GET_PLAYER_JOB1() ~= 0 then
    NPC_SAY("已经拥有职业了啊。")
    return
  end
end
function saycanleanskill(id)
  if GET_PLAYER_JOB1() ~= 1 then
    NPC_SAY("没有可以教你的武功")
    return
  end
  if qData[22].state == 1 or qData[23].state == 1 or qData[24].state == 1 or qData[25].state == 1 or qData[26].state == 1 or qData[27].state == 1 or qData[28].state == 1 or qData[29].state == 1 or qData[30].state == 1 or qData[31].state == 1 then
    NPC_SAY("武功任务不能重复进行 ")
    return
  end
  if CHECK_SKILL(qt[22].reward.getSkill[1]) == false and qData[22].state == 0 then
    ADD_QUEST_BTN(qt[22].id, qt[22].name)
  end
  if CHECK_SKILL(qt[23].reward.getSkill[1]) == false and qData[23].state == 0 then
    ADD_QUEST_BTN(qt[23].id, qt[23].name)
  end
  if CHECK_SKILL(qt[24].reward.getSkill[1]) == false and qData[24].state == 0 then
    ADD_QUEST_BTN(qt[24].id, qt[24].name)
  end
  if CHECK_SKILL(qt[25].reward.getSkill[1]) == false and qData[25].state == 0 then
    ADD_QUEST_BTN(qt[25].id, qt[25].name)
  end
  if CHECK_SKILL(qt[26].reward.getSkill[1]) == false and qData[26].state == 0 then
    ADD_QUEST_BTN(qt[26].id, qt[26].name)
  end
  if CHECK_SKILL(qt[27].reward.getSkill[1]) == false and qData[27].state == 0 then
    ADD_QUEST_BTN(qt[27].id, qt[27].name)
  end
  if CHECK_SKILL(qt[28].reward.getSkill[1]) == false and qData[28].state == 0 then
    ADD_QUEST_BTN(qt[28].id, qt[28].name)
  end
  if CHECK_SKILL(qt[29].reward.getSkill[1]) == false and qData[29].state == 0 then
    ADD_QUEST_BTN(qt[29].id, qt[29].name)
  end
  if CHECK_SKILL(qt[30].reward.getSkill[1]) == false and qData[30].state == 0 then
    ADD_QUEST_BTN(qt[30].id, qt[30].name)
  end
  if CHECK_SKILL(qt[31].reward.getSkill[1]) == false and qData[31].state == 0 then
    ADD_QUEST_BTN(qt[31].id, qt[31].name)
  end
  if CHECK_SKILL(qt[678].reward.getSkill[1]) == false and qData[678].state == 0 then
    ADD_QUEST_BTN(qt[678].id, qt[678].name)
  end
  if CHECK_SKILL(qt[679].reward.getSkill[1]) == false and qData[679].state == 0 then
    ADD_QUEST_BTN(qt[679].id, qt[679].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
