function npcsay(id)
  if id ~= 4316004 then
    return
  end
  clickNPCid = id
  if qData[1558].state == 1 then
    if CHECK_ITEM_CNT(qt[1558].goal.getItem[1].id) >= qt[1558].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1558].goal.getItem[2].id) >= qt[1558].goal.getItem[2].count then
      NPC_SAY("谢谢。现在母亲应该可以康复了。（是个绝对的孝子啊，不知道作为长老候选人会怎么样…。）")
      SET_QUEST_STATE(1558, 2)
    else
      NPC_SAY("如果你能击退{0xFFFFFF00}第一阶梯{END}的{0xFFFFFF00}大脚怪和地狱狂牛{END}，收集回来{0xFFFFFF00}毒蘑菇和牛角各20个{END}就再好不过了。")
    end
  end
  if qData[1551].state == 1 then
    NPC_SAY("去见{0xFFFFFF00}古乐村南边{END}的{0xFFFFFF00}老长老{END}，应该就可以了。")
    return
  end
  if qData[1547].state == 1 then
    NPC_SAY("希望你去见{0xFFFFFF00}古乐村南边{END}的{0xFFFFFF00}老长老{END}。")
    return
  end
  if qData[1546].state == 1 then
    if CHECK_ITEM_CNT(qt[1546].goal.getItem[1].id) >= qt[1546].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢。我会把{0xFFFFFF00}老长老{END}的药也一起中和的。")
        SET_QUEST_STATE(1546, 2)
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("击退栖息在{0xFFFFFF00}第一阶梯{END}的{0xFFFFFF00}大脚怪{END}，收集{0xFFFFFF00}40个毒蘑菇{END}回来吧。")
      return
    end
  end
  if qData[1545].state == 1 then
    NPC_SAY("找我有什么事情吗？")
    SET_QUEST_STATE(1545, 2)
    return
  end
  if qData[480].state == 1 then
    SET_INFO(480, 1)
    NPC_SAY("年老书生的健康秘诀是什么啊？真的很好奇啊。")
    return
  end
  if qData[480].state == 2 and qData[481].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[481].goal.getItem) then
    NPC_SAY("啊 真的好感动。帮我找来了这么贵重的药…真的太谢谢了。得马上熬药才行。嗯…嗯…为了给我送药，跑了这么远的路，真的很感谢。这里虽然不多，但请你手下。")
    SET_QUEST_STATE(481, 2)
    return
  end
  if qData[1558].state == 0 and qData[1554].state == 1 and GET_PLAYER_LEVEL() >= qt[1558].needLevel then
    ADD_QUEST_BTN(qt[1558].id, qt[1558].name)
  end
  if qData[480].state == 0 then
    ADD_QUEST_BTN(qt[480].id, qt[480].name)
  end
  if qData[1546].state == 0 and qData[1545].state == 2 and GET_PLAYER_LEVEL() >= qt[1546].needLevel then
    ADD_QUEST_BTN(qt[1546].id, qt[1546].name)
  end
  if qData[1547].state == 0 and qData[1546].state == 2 and GET_PLAYER_LEVEL() >= qt[1547].needLevel then
    ADD_QUEST_BTN(qt[1547].id, qt[1547].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1558].state ~= 2 and qData[1554].state == 1 and GET_PLAYER_LEVEL() >= qt[1558].needLevel then
    if qData[1558].state == 1 then
      if CHECK_ITEM_CNT(qt[1558].goal.getItem[1].id) >= qt[1558].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1558].goal.getItem[2].id) >= qt[1558].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1547].state ~= 2 and qData[1546].state == 2 and GET_PLAYER_LEVEL() >= qt[1547].needLevel then
    if qData[1547].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1546].state ~= 2 and qData[1545].state == 2 and GET_PLAYER_LEVEL() >= qt[1546].needLevel then
    if qData[1546].state == 1 then
      if CHECK_ITEM_CNT(qt[1546].goal.getItem[1].id) >= qt[1546].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1545].state == 1 then
    QSTATE(id, 2)
  end
end
