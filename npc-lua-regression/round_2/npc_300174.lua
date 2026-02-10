function npcsay(id)
  if id ~= 4300174 then
    return
  end
  clickNPCid = id
  NPC_SAY("我想变成人类~")
  if qData[2844].state == 1 then
    NPC_SAY("我想变成人类，请帮帮我吧。")
  end
  if qData[2845].state == 1 then
    NPC_SAY("吃100天艾草和大蒜？呜呜！")
    SET_QUEST_STATE(2845, 2)
    return
  end
  if qData[3768].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3768].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("拿来了啊。谢谢。明天也拜托了！")
        SET_QUEST_STATE(3768, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退怪物，各收集10个艾草和大蒜回来吧。")
    end
  end
  if qData[2844].state == 0 then
    ADD_QUEST_BTN(qt[2844].id, qt[2844].name)
  end
  if qData[3768].state == 0 and qData[2845].state == 2 then
    ADD_QUEST_BTN(qt[3768].id, qt[3768].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2844].state ~= 2 then
    if qData[2844].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2845].state == 1 then
    QSTATE(id, 2)
  end
  if qData[3768].state ~= 2 and qData[2845].state == 2 then
    if qData[3768].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3768].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
