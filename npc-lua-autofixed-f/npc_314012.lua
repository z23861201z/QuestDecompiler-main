function npcsay(id)
  if id ~= 4314012 then
    return
  end
  clickNPCid = id
  if qData[351].state == 1 then
    if qData[351].meetNpc[1] == qt[351].goal.meetNpc[1] then
      NPC_SAY([[
?? ?? ??? ????!
??? ??? ??? ? ?? ??? ??? ????.
??? ?? ??? {0xFFFF8C00}???? ??? ??? ????.{END}
?? ???.]])
      SET_QUEST_STATE(351, 2)
    else
      SET_MEETNPC(351, 1, id)
    end
    return
  elseif qData[352].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(352, 2)
    return
  elseif qData[353].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(353, 2)
    return
  elseif qData[354].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(354, 2)
    return
  elseif qData[355].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(355, 2)
    return
  elseif qData[356].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(356, 2)
    return
  elseif qData[357].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(357, 2)
    return
  elseif qData[358].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(358, 2)
    return
  elseif qData[359].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(359, 2)
    return
  elseif qData[360].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(360, 2)
    return
  elseif qData[361].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(361, 2)
    return
  elseif qData[684].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(684, 2)
    return
  elseif qData[685].state == 1 then
    NPC_SAY("您好像已经决定了。那我就教您武功了。")
    SET_QUEST_STATE(685, 2)
    return
  else
    NPC_SAY("我是力士技能传授NPC。怎么了？有什么疑问就问吧。")
    ADD_EX_BTN(id)
  end
  if qData[362].state == 1 and CHECK_ITEM_CNT(8990031) > 0 then
    NPC_SAY("{0xFFFFFF00}????? ???{END} ???? ????.")
    return
  end
  if qData[1418].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1418].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("???? ???. ?? ??? ? ??? ?? ??? ??. ?, ?? ? ??? ??? ???. ? ? ??? ??? ???. ? ? ??? ?? ??? ? ??.")
        SET_QUEST_STATE(1418, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("[6????] 300?? ?? ???? ? ??? ??? ?? ????.")
    end
  end
end
function saychjob(id)
  if GET_PLAYER_JOB1() ~= 0 then
    NPC_SAY("已经拥有职业了啊。")
    return
  end
  if GET_PLAYER_LEVEL() >= qt[351].needLevel then
    if qData[351].state == 0 then
      if qData[16].state ~= 0 or qData[19].state ~= 0 or qData[21].state ~= 0 or qData[612].state ~= 0 then
        NPC_SAY("????? ???? ??? ? ???.")
      elseif GET_PLAYER_USESKILLPOINT_C() < 18 then
        NPC_SAY([[
?? ?? 10??? ?? ???? ?? ???? ??? ?? ??. 
{0xFFFF8C00}[D]?? ??? ?? ???? ??? ?????.{END} ?? ???? ?? ???? [Shift]?? ??? ?? ???? ????.]])
      else
        ADD_QUEST_BTN(qt[351].id, qt[351].name)
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
  if GET_PLAYER_JOB1() ~= 4 then
    NPC_SAY("没有可以教你的武功")
    return
  end
  if qData[352].state == 1 or qData[353].state == 1 or qData[354].state == 1 or qData[355].state == 1 or qData[356].state == 1 or qData[357].state == 1 or qData[358].state == 1 or qData[359].state == 1 or qData[360].state == 1 or qData[361].state == 1 then
    NPC_SAY("武功任务不能重复进行 ")
    return
  end
  if CHECK_SKILL(qt[352].reward.getSkill[1]) == false and qData[352].state == 0 then
    ADD_QUEST_BTN(qt[352].id, qt[352].name)
  end
  if CHECK_SKILL(qt[353].reward.getSkill[1]) == false and qData[353].state == 0 then
    ADD_QUEST_BTN(qt[353].id, qt[353].name)
  end
  if CHECK_SKILL(qt[354].reward.getSkill[1]) == false and qData[354].state == 0 then
    ADD_QUEST_BTN(qt[354].id, qt[354].name)
  end
  if CHECK_SKILL(qt[355].reward.getSkill[1]) == false and qData[355].state == 0 then
    ADD_QUEST_BTN(qt[355].id, qt[355].name)
  end
  if CHECK_SKILL(qt[356].reward.getSkill[1]) == false and qData[356].state == 0 then
    ADD_QUEST_BTN(qt[356].id, qt[356].name)
  end
  if CHECK_SKILL(qt[357].reward.getSkill[1]) == false and qData[357].state == 0 then
    ADD_QUEST_BTN(qt[357].id, qt[357].name)
  end
  if CHECK_SKILL(qt[358].reward.getSkill[1]) == false and qData[358].state == 0 then
    ADD_QUEST_BTN(qt[358].id, qt[358].name)
  end
  if CHECK_SKILL(qt[359].reward.getSkill[1]) == false and qData[359].state == 0 then
    ADD_QUEST_BTN(qt[359].id, qt[359].name)
  end
  if CHECK_SKILL(qt[360].reward.getSkill[1]) == false and qData[360].state == 0 then
    ADD_QUEST_BTN(qt[360].id, qt[360].name)
  end
  if CHECK_SKILL(qt[361].reward.getSkill[1]) == false and qData[361].state == 0 then
    ADD_QUEST_BTN(qt[361].id, qt[361].name)
  end
  if CHECK_SKILL(qt[684].reward.getSkill[1]) == false and qData[684].state == 0 then
    ADD_QUEST_BTN(qt[684].id, qt[684].name)
  end
  if CHECK_SKILL(qt[685].reward.getSkill[1]) == false and qData[685].state == 0 then
    ADD_QUEST_BTN(qt[685].id, qt[685].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
