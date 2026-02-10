function npcsay(id)
  if id ~= 4315020 then
    return
  end
  clickNPCid = id
  if qData[1003].state == 1 then
    NPC_SAY("谁啊！看你在这附近徘徊，很可疑啊！")
    SET_QUEST_STATE(1003, 2)
    return
  end
  if qData[1004].state == 1 then
    NPC_SAY("听说{0xFFFFFF00}[西米路]{END}藏身在{0xFFFFFF00}[冥珠城]{END}。彻底搜查一边!")
    return
  end
  if qData[1006].state == 1 and CHECK_ITEM_CNT(qt[1006].goal.getItem[1].id) >= qt[1006].goal.getItem[1].count then
    NPC_SAY("是献给兰霉匠的药材，肯定对身体很好。我得吃吃。啊..吃了山参更晕了..敢骗..我…你..")
    SET_QUEST_STATE(1006, 2)
    return
  end
  if qData[1007].state == 1 then
    if qData[1007].meetNpc[1] == qt[1007].goal.meetNpc[1] then
      NPC_SAY("啊 怎么这么晕啊…。")
      SET_QUEST_STATE(1007, 2)
    else
      NPC_SAY("我一定会找到{0xFFFFFF00}[西米路]{END}的。请相信我！")
    end
  end
  if qData[1008].state == 1 then
    NPC_SAY("你问我{0xFFFFFF00}[白血鬼谷林]{END}在哪里吗？现在你在问你的上司吗？自己看着办。部下就应该这样…知道鬼谷村吗？就是给我们情报的村子。去那里再往北走。")
    return
  end
  if qData[1230].state == 1 and CHECK_ITEM_CNT(qt[1230].goal.getItem[1].id) >= qt[1230].goal.getItem[1].count then
    NPC_SAY("嗯？能缓解腰部疼痛的药？谢谢。你真是好人啊。什么？因为心情的关系吗？以前也这样过的…。")
    SET_QUEST_STATE(1230, 2)
    return
  end
  if qData[1231].state == 1 then
    NPC_SAY("呼噜噜…。恩恩，冥珠都城的冥珠城父母官这家伙一次都没有招待我…。")
  end
  if qData[1004].state == 0 and qData[1003].state == 2 then
    ADD_QUEST_BTN(qt[1004].id, qt[1004].name)
  end
  if qData[1006].state == 0 and qData[1005].state == 2 then
    ADD_QUEST_BTN(qt[1006].id, qt[1006].name)
  end
  if qData[1007].state == 0 and qData[1006].state == 2 then
    ADD_QUEST_BTN(qt[1007].id, qt[1007].name)
  end
  if qData[1008].state == 0 and qData[1007].state == 2 then
    ADD_QUEST_BTN(qt[1008].id, qt[1008].name)
  end
  if qData[1231].state == 0 and qData[1230].state == 2 and GET_PLAYER_LEVEL() >= qt[1231].needLevel then
    ADD_QUEST_BTN(qt[1231].id, qt[1231].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1003].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1003].needLevel and qData[1003].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1003].state == 2 and qData[1004].state ~= 2 then
    if qData[1004].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1006].state ~= 2 and qData[1005].state == 2 then
    if qData[1006].state == 1 then
      if CHECK_ITEM_CNT(qt[1006].goal.getItem[1].id) >= qt[1006].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1007].state ~= 2 and qData[1006].state == 2 then
    if qData[1007].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1008].state ~= 2 and qData[1007].state == 2 then
    if qData[1008].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1231].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1231].state == 0 and qData[1230].state == 2 and GET_PLAYER_LEVEL() >= qt[1231].needLevel then
    QSTATE(id, 0)
  end
end
