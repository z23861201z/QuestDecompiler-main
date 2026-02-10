function npcsay(id)
  if id ~= 4300009 then
    return
  end
  clickNPCid = id
  if qData[1541].state == 1 then
    NPC_SAY("去见{0xFFFFFF00}古乐村南边{END}的{0xFFFFFF00}老长老{END}，帮古乐村度过难关吧。趁此时间我要整理一下想法。")
    return
  end
  if qData[248].state == 1 and qData[247].state == 2 and CHECK_ITEM_CNT(qt[248].goal.getItem[1].id) >= qt[248].goal.getItem[1].count then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("你是谁啊？嗯…是前不久以前的搜查团长说的那个人吗？这封信是…嗯~她还是跟之前一样啊")
      SET_QUEST_STATE(248, 2)
      return
    else
      NPC_SAY("行囊太沉。")
      return
    end
  end
  if qData[454].state == 1 then
    if qData[454].killMonster[qt[454].goal.killMonster[1].id] >= qt[454].goal.killMonster[1].count then
      NPC_QSAY(454, 3)
      SET_QUEST_STATE(454, 2)
    else
      NPC_QSAY(454, 1)
    end
  end
  if qData[455].state == 1 and qData[454].state == 2 then
    if qData[455].killMonster[qt[455].goal.killMonster[1].id] >= qt[455].goal.killMonster[1].count then
      NPC_QSAY(455, 3)
      SET_QUEST_STATE(455, 2)
    else
      NPC_QSAY(455, 1)
    end
  end
  if qData[456].state == 1 and qData[455].state == 2 then
    NPC_QSAY(456, 1)
  end
  if qData[457].state == 1 and qData[456].state == 2 then
    NPC_QSAY(457, 3)
    SET_MEETNPC(457, 2, id)
    SET_QUEST_STATE(457, 2)
  end
  if qData[458].state == 1 and qData[457].state == 2 then
    if qData[458].killMonster[qt[458].goal.killMonster[1].id] >= qt[458].goal.killMonster[1].count then
      NPC_QSAY(458, 3)
      SET_QUEST_STATE(458, 2)
    else
      NPC_QSAY(458, 1)
    end
  end
  if qData[459].state == 1 and qData[458].state == 2 then
    NPC_QSAY(459, 1)
  end
  if qData[460].state == 1 and qData[459].state == 2 then
    if CHECK_ITEM_CNT(qt[460].goal.getItem[1].id) >= qt[460].goal.getItem[1].count then
      NPC_QSAY(460, 3)
      SET_QUEST_STATE(460, 2)
    else
      NPC_QSAY(460, 5)
    end
  end
  if qData[461].state == 1 and qData[460].state == 2 then
    NPC_QSAY(461, 1)
  end
  if qData[717].state == 1 then
    NPC_SAY("嗯？你见到了冬混汤师兄？怎么样？他还好吧？")
    SET_QUEST_STATE(717, 2)
  end
  if qData[718].state == 1 then
    NPC_SAY("冬混汤的城已经沦陷，{0xFFFFFF00}[冬混汤一族的文章]{END}应该也没有用了。拿着那个文章去找{0xFFFFFF00}[冬混汤]{END}师兄，告诉他你是可以信任的人。")
  end
  if qData[1346].state == 1 and CHECK_ITEM_CNT(qt[1346].goal.getItem[1].id) >= qt[1346].goal.getItem[1].count then
    NPC_SAY("如果跟兰霉匠有关系，就趁早结束生命的好。")
    SET_QUEST_STATE(1346, 2)
  end
  if qData[1347].state == 1 then
    NPC_SAY("( 看来只能是{0xFFFFFF00}功力达100{END}之后通过{0xFFFFFF00}黄泉结界高僧{END}完成{0xFFFFFF00}生死地狱{END}之后，把信交给{0xFFFFFF00}东泼肉{END}了。)")
  end
  if qData[1541].state == 0 and qData[1347].state == 2 then
    ADD_QUEST_BTN(qt[1541].id, qt[1541].name)
  end
  if qData[454].state == 0 and GET_PLAYER_LEVEL() >= 80 then
    ADD_QUEST_BTN(qt[454].id, qt[454].name)
  end
  if qData[455].state == 0 and qData[454].state == 2 then
    ADD_QUEST_BTN(qt[455].id, qt[455].name)
  end
  if qData[456].state == 0 and qData[455].state == 2 then
    ADD_QUEST_BTN(qt[456].id, qt[456].name)
  end
  if qData[458].state == 0 and qData[457].state == 2 then
    ADD_QUEST_BTN(qt[458].id, qt[458].name)
  end
  if qData[459].state == 0 and qData[458].state == 2 then
    ADD_QUEST_BTN(qt[459].id, qt[459].name)
  end
  if qData[461].state == 0 and qData[460].state == 2 then
    ADD_QUEST_BTN(qt[461].id, qt[461].name)
  end
  if qData[718].state == 0 and qData[717].state == 2 then
    ADD_QUEST_BTN(qt[718].id, qt[718].name)
  end
  if qData[1347].state == 0 and qData[1346].state == 2 and GET_PLAYER_LEVEL() >= qt[1347].needLevel then
    ADD_QUEST_BTN(qt[1347].id, qt[1347].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1541].state ~= 2 and qData[1347].state == 2 then
    if qData[1541].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[248].state == 1 and qData[247].state == 2 and GET_PLAYER_LEVEL() >= qt[248].needLevel and CHECK_ITEM_CNT(qt[248].goal.getItem[1].id) >= qt[248].goal.getItem[1].count then
    QSTATE(id, 2)
  end
  if qData[717].state == 1 and GET_PLAYER_LEVEL() >= qt[717].needLevel and qData[716].state == 2 then
    QSTATE(id, 2)
  end
  if qData[718].state ~= 2 and GET_PLAYER_LEVEL() >= qt[718].needLevel and qData[717].state == 2 then
    if qData[718].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1346].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1347].state ~= 2 and qData[1346].state == 2 and GET_PLAYER_LEVEL() >= qt[1347].needLevel then
    if qData[1347].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
