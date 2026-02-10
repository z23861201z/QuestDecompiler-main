function npcsay(id)
  if id ~= 4314006 then
    return
  end
  clickNPCid = id
  if qData[1119].state == 1 then
    if CHECK_ITEM_CNT(qt[1119].goal.getItem[1].id) >= qt[1119].goal.getItem[1].count then
      NPC_SAY("你真的收集回来了啊？天啊，真的会帮别人的忙啊，你是不是傻啊？总之谢谢了。")
      SET_QUEST_STATE(1119, 2)
    else
      NPC_SAY("不是你说的吗，说大家都想帮我？别忘了，去清阴谷击退螳螂勇勇收集5个[ 勇勇的前脚 ]。")
    end
  end
  if qData[1120].state == 1 then
    NPC_SAY("不用说谢谢。你帮了我多少我也就帮你多少。快去清阴镖局见见清阴银行吧。")
  end
  ADD_NEW_SHOP_BTN(id, 10027)
  if qData[1119].state == 0 then
    ADD_QUEST_BTN(qt[1119].id, qt[1119].name)
  end
  if qData[1119].state == 2 and qData[1120].state == 0 then
    ADD_QUEST_BTN(qt[1120].id, qt[1120].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1119].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1119].needLevel then
    if qData[1119].state == 1 then
      if CHECK_ITEM_CNT(qt[1119].goal.getItem[1].id) >= qt[1119].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1120].state ~= 2 and qData[1119].state == 2 and GET_PLAYER_LEVEL() >= qt[1120].needLevel then
    if qData[1120].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
