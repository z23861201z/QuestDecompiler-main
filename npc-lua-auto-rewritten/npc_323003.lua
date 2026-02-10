function npcsay(id)
  if id ~= 4323003 then
    return
  end
  NPC_SAY("为什么我会比那傻瓜出生的晚呢？明明是我更适合当王的啊？")
  clickNPCid = id
  if qData[2599].state == 1 then
    if CHECK_ITEM_CNT(qt[2599].goal.getItem[1].id) >= qt[2599].goal.getItem[1].count then
      NPC_SAY("速度挺快啊~这是我答应你的奖励。")
      SET_QUEST_STATE(2599, 2)
      return
    else
      NPC_SAY("想要得到丰厚的奖励，就赶紧去击退{0xFFFFFF00}[真英招]{END}，收集{0xFFFFFF00}50个真英招的皮{END}回来吧。")
    end
  end
  if qData[2599].state == 0 and GET_PLAYER_LEVEL() >= qt[2599].needLevel then
    ADD_QUEST_BTN(qt[2599].id, qt[2599].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2599].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2599].needLevel then
    if qData[2599].state == 1 then
      if CHECK_ITEM_CNT(qt[2599].goal.getItem[1].id) >= qt[2599].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
