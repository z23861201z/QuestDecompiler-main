function npcsay(id)
  if id ~= 4314060 then
    return
  end
  clickNPCid = id
  if qData[1105].state == 1 then
    NPC_SAY("啊，你是长老捡来…不，救回来的PLAYERNAME吧。气色看起来好多了。训练所长广柱知道的话该高兴了。我有事情拜托你，再来和我对话吧。")
    SET_QUEST_STATE(1105, 2)
  end
  if qData[1106].state == 1 then
    NPC_SAY("使用寻路功能去见见训练所长广柱吧。")
  end
  if qData[1108].state == 1 then
    NPC_SAY("训练所长广柱收到了啊。辛苦了。哎呦，我们家小甜甜到底在做什么呢？")
    SET_QUEST_STATE(1108, 2)
  end
  if qData[1110].state == 1 then
    if CHECK_ITEM_CNT(qt[1110].goal.getItem[1].id) >= qt[1110].goal.getItem[1].count then
      NPC_SAY("谢谢你。真是村子的好帮手。如果能定居在我们村就好了。")
      SET_QUEST_STATE(1110, 2)
    else
      NPC_SAY("5个绊脚石绳。在大目仔来到之前快点行动。")
    end
  end
  if qData[1201].state == 1 then
    NPC_SAY("训练所长广柱的身体不知如何了…话说回来训练所长广柱好像在找{0xFF99ff99}PLAYERNAME{END}。在他跌到之前快点去看看吧。")
  end
  if qData[1106].state == 0 and qData[1105].state == 2 then
    ADD_QUEST_BTN(qt[1106].id, qt[1106].name)
  end
  if qData[1109].state == 2 and qData[1110].state == 0 then
    ADD_QUEST_BTN(qt[1110].id, qt[1110].name)
  end
  if qData[1201].state == 0 and qData[1110].state == 2 then
    ADD_QUEST_BTN(qt[1201].id, qt[1201].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1104].state == 2 and qData[1105].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1105].state == 2 and qData[1106].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1105].needLevel then
    if qData[1106].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1107].state == 2 and qData[1108].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1109].state == 2 and qData[1110].state ~= 2 then
    if qData[1110].state == 1 then
      if CHECK_ITEM_CNT(qt[1110].goal.getItem[1].id) >= qt[1110].goal.getItem[1].id then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1110].state == 2 and qData[1201].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1201].needLevel then
    if qData[1201].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
