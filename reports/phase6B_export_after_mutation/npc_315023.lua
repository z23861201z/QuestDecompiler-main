function npcsay(id)
  if id ~= 4315023 then
    return
  end
  clickNPCid = id
  NPC_SAY("呵呵呵，能来到这里说明您实力超群啊.那么，{0xFFFFFF00}血玉髓种子{END}找到了吗？")
  if qData[1824].state == 1 and qData[1824].killMonster[qt[1824].goal.killMonster[1].id] >= qt[1824].goal.killMonster[1].count then
    NPC_SAY("谢谢。在天上的夫人应该会高兴的。 ")
    SET_QUEST_STATE(1824, 2)
  end
  if qData[1391].state == 1 then
    NPC_SAY("卡卡卡。我已经和世俗绝缘了。只是想要拥有力量，就给我拿来血玉髓种子把！")
    SET_QUEST_STATE(1391, 2)
  end
  if qData[3630].state == 1 and qData[3630].killMonster[qt[3630].goal.killMonster[1].id] >= qt[3630].goal.killMonster[1].count then
    if 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_SAY("是吗？他是拜托过我的。这就是血玉髓的种子。你可以随时来找我，呵呵")
      SET_QUEST_STATE(3630, 2)
    else
      NPC_SAY("行囊太沉")
      return
    end
  end
  ADD_NEW_SHOP_BTN(id, 10026)
  ADD_TOWER_ESCAPE_BTN(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1824].state == 1 and GET_PLAYER_LEVEL() >= qt[110].needLevel then
    if qData[1824].killMonster[qt[1824].goal.killMonster[1].id] >= qt[1824].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1391].state == 1 then
    QSTATE(id, 2)
  end
  if qData[3630].state == 1 and GET_PLAYER_LEVEL() >= qt[3630].needLevel then
    if qData[3630].killMonster[qt[3630].goal.killMonster[1].id] >= qt[3630].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
end
