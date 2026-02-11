function npcsay(id)
  if id ~= 4316007 then
    return
  end
  clickNPCid = id
  if qData[1561].state == 1 then
    NPC_SAY("去帮我转告{0xFFFFFF00}老长老{END}结果吧。他就在{0xFFFFFF00}古乐村南{END}")
    return
  end
  if qData[1554].state == 1 then
    if qData[1555].state == 2 and qData[1556].state == 2 and qData[1557].state == 2 and qData[1558].state == 2 and qData[1559].state == 2 and qData[1560].state == 2 then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("都解决完回来的？太厉害了！")
        SET_QUEST_STATE(1554, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("{0xFFFFFF00}功力103时解决古乐村宝芝林和古乐村服装店的委托，功力104时解决年轻书生和年老书生的委托，功力105时解决心情很坏的老媪{END}的委托怎么样？")
      return
    end
  end
  if qData[1553].state == 1 then
    NPC_SAY("HOHO，又来了啊？")
    SET_QUEST_STATE(1553, 2)
    return
  end
  if qData[1550].state == 1 then
    NPC_SAY("击退{0xFFFFFF00}第一阶梯{END}的{0xFFFFFF00}骷髅鸟，收集{0xFFFFFF00}40个骷髅鸟碎片{END}，交给{0xFFFFFF00}古乐村南额古乐村宝芝林{END}吧")
    return
  end
  if qData[1549].state == 1 then
    NPC_SAY("你说什么？爷爷？哎呀 怎么又要那样啊？")
    SET_QUEST_STATE(1549, 2)
    return
  end
  if qData[1561].state == 0 and qData[1554].state == 2 then
    ADD_QUEST_BTN(qt[1561].id, qt[1561].name)
  end
  if qData[1554].state == 0 and qData[1553].state == 2 then
    ADD_QUEST_BTN(qt[1554].id, qt[1554].name)
  end
  if qData[1550].state == 0 and qData[1549].state == 2 then
    ADD_QUEST_BTN(qt[1550].id, qt[1550].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1561].state ~= 2 and qData[1554].state == 2 then
    if qData[1561].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1554].state ~= 2 and qData[1553].state == 2 and GET_PLAYER_LEVEL() >= qt[1554].needLevel then
    if qData[1554].state == 1 then
      if qData[1555].state == 2 and qData[1556].state == 2 and qData[1557].state == 2 and qData[1558].state == 2 and qData[1559].state == 2 and qData[1560].state == 2 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1553].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1550].state ~= 2 and qData[1549].state == 2 then
    if qData[1550].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1549].state == 1 then
    QSTATE(id, 2)
  end
end
