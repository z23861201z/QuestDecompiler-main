function npcsay(id)
  if id ~= 4315006 then
    return
  end
  clickNPCid = id
  if qData[1526].state == 1 then
    if qData[1526].killMonster[qt[1526].goal.killMonster[1].id] >= qt[1526].goal.killMonster[1].count then
      NPC_SAY("哦哦，太感谢了，请问您尊姓大名？ 是{0xFFFFFF00}PLAYERNAME{END}大侠吗？我会让您的侠义行为流传开来的！")
      SET_QUEST_STATE(1526, 2)
    else
      NPC_SAY("谁能帮忙击退那让人头疼的{0xFFFFFF00}[铁牛运功散]{END}呢？")
    end
  end
  if qData[1527].state == 1 then
    NPC_SAY("请去?{0xFFFFFF00}[龙林城南]{END}的{0xFFFFFF00}[龙林派师弟]{END}吧！")
  end
  if qData[143].state == 1 then
    if qData[143].meetNpc[1] ~= qt[143].goal.meetNpc[1] then
      NPC_QSAY(143, 1)
      SET_INFO(143, 1)
      SET_MEETNPC(143, 1, id)
      return
    elseif qData[143].killMonster[qt[143].goal.killMonster[1].id] >= qt[143].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("嗯..实力不错啊！你叫…{0xFFFFFF00}PLAYERNAME{END}…?下次有事还会叫上你的.请收下奖励吧！")
        SET_QUEST_STATE(143, 2)
      else
        NPC_SAY("行囊太沉。")
      end
      return
    else
      NPC_SAY("击退{0xFFFFFF00}10个大菜头{END}才能获得奖励")
      return
    end
  end
  if qData[156].state == 1 then
    if qData[156].meetNpc[1] == qt[156].goal.meetNpc[1] and qData[156].meetNpc[2] == qt[156].goal.meetNpc[2] then
      NPC_SAY("??? ?? ? ?? ? ?????? ?????. ????? ?????…. ???? ?? ???? ??? ???????. ??? ???????.")
      SET_QUEST_STATE(156, 2)
      return
    else
      NPC_SAY("???? ????? ??? ?? ??????? ???? ? ? ???? ????.")
    end
  end
  if qData[157].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[157].goal.getItem) then
      NPC_SAY("?? ?????. ??? ??? ??? ??? ?????. ?, ??? ?????. ??? ???? ?? ???? ?????.")
      SET_QUEST_STATE(157, 2)
      return
    else
      NPC_SAY("????? ???? ????? ???? ????? ?? ? ?? ???. {0xFFFFFF00}???? 40?? ??? 20?{END}? ?? ????.")
    end
  end
  if qData[161].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[161].goal.getItem) then
      NPC_SAY("{0xFFFFFF00}PLAYERNAME{END}? ??? ?? ??? ???? ??????. ?? ???? ??????.")
      SET_QUEST_STATE(161, 2)
      return
    else
      NPC_SAY("??? ??? ???? ????. ? {0xFFFFFF00}???? ???? 40?{END}? ??????.")
    end
  end
  if qData[1262].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("咳咳，你说什么？龙通路有怪物？问题严重了!")
      SET_QUEST_STATE(1262, 2)
    else
      NPC_SAY("行囊已满。")
    end
  end
  if qData[1263].state == 1 then
    NPC_SAY("希望你通过{0xFFFFFF00}龙林城南{END}的{0xFFFFFF00}黄泉结界高僧{END}进入{0xFFFFFF00}暗血地狱{END}击退怪物。")
  end
  if qData[1263].state == 0 and qData[1262].state == 2 and GET_PLAYER_LEVEL() >= qt[1263].needLevel then
    ADD_QUEST_BTN(qt[1263].id, qt[1263].name)
  end
  if qData[1527].state == 0 and qData[1526].state == 2 then
    ADD_QUEST_BTN(qt[1527].id, qt[1527].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1526].state == 1 then
    if qData[1526].killMonster[qt[1526].goal.killMonster[1].id] >= qt[1526].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1527].state ~= 2 and qData[1526].state == 2 then
    if qData[1527].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[143].state == 1 and GET_PLAYER_LEVEL() >= qt[143].needLevel then
    if qData[143].killMonster[qt[143].goal.killMonster[1].id] >= qt[143].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1263].state == 0 and qData[1262].state == 2 and GET_PLAYER_LEVEL() >= qt[1263].needLevel then
    QSTATE(id, 0)
  elseif qData[1263].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1262].state == 1 then
    QSTATE(id, 2)
  end
end
