function npcsay(id)
  if id ~= 4313005 then
    return
  end
  clickNPCid = id
  if qData[1501].state == 1 then
    NPC_SAY("{0xFFFFFF00}??????{END}? {0xFFFFFF00}?? 100%{END} ??? {0xFFFFFF00}??????{END} ??????.")
  end
  if qData[81].state == 1 then
    NPC_SAY("要下雨了吗…下雨的话腰会疼的啊…")
  end
  if qData[336].state == 1 and CHECK_ITEM_CNT(qt[336].goal.getItem[1].id) >= qt[336].goal.getItem[1].count then
    NPC_SAY("?? ????? ? ???…. ????. ?? ?? ??? ??? ? ??? ?? ??? ???? ?????.")
    SET_QUEST_STATE(336, 2)
    return
  end
  if qData[337].state == 1 then
    NPC_SAY("? ?? ??? ?? ?? ??? ??? ??? ?? ?? ?? ????? ?? ???.")
  end
  if qData[1189].state == 1 then
    if qData[857].state == 2 then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("真是快的惊人啊。我有可能看错了少侠。按照约定我已经在冥珠城传开了消息。大家都会找少侠帮忙的。")
        SET_QUEST_STATE(1189, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("跟下面的黄泉结界高僧对话进入到异界门看看吧。跟在那里的汉谟拉比商人领取[ 凶徒地狱-邪恶魔王犬 ]来完成之后回到我这边就可以了。")
    end
  end
  if qData[450].state == 1 then
    NPC_SAY(qt[450].npcsay[3])
  end
  if qData[451].state == 1 then
    NPC_SAY(qt[451].npcsay[3])
  end
  if qData[337].state == 0 and qData[336].state == 2 then
    ADD_QUEST_BTN(qt[337].id, qt[337].name)
  end
  if qData[81].state == 0 then
    ADD_QUEST_BTN(qt[81].id, qt[81].name)
  end
  if qData[1501].state == 0 then
    ADD_QUEST_BTN(qt[1501].id, qt[1501].name)
  end
  if qData[1189].state == 0 then
    ADD_QUEST_BTN(qt[1189].id, qt[1189].name)
  end
  if qData[1209].state == 0 and qData[1189].state == 2 and GET_PLAYER_LEVEL() >= qt[1209].needLevel then
    ADD_QUEST_BTN(qt[1209].id, qt[1209].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1501].state == 1 then
    QSTATE(id, 1)
  else
    QSTATE(id, 0)
  end
  if qData[81].state ~= 2 and GET_PLAYER_LEVEL() >= qt[81].needLevel then
    if qData[81].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1189].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1189].needLevel then
    if qData[1189].state == 1 then
      if qData[857].state == 2 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1209].state == 0 and qData[1189].state == 2 and GET_PLAYER_LEVEL() >= qt[1209].needLevel then
    QSTATE(id, 0)
  end
end
