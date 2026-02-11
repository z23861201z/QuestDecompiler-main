function npcsay(id)
  if id ~= 4240001 then
    return
  end
  clickNPCid = id
  NPC_SAY("先说清楚，安哥拉王国只处理最好的物品。")
  if qData[2594].state == 1 then
    if CHECK_ITEM_CNT(qt[2594].goal.getItem[1].id) >= qt[2594].goal.getItem[1].count then
      NPC_SAY("谢谢。这下我可以加快研究进度了。")
      SET_QUEST_STATE(2594, 2)
      return
    else
      NPC_SAY("从燃烧的废墟的{0xFFFFFF00}[泥娃娃]{END}身上，收集{0xFFFFFF00}50个泥块{END}回来就可以了。")
    end
  end
  if qData[2596].state == 1 then
    if CHECK_ITEM_CNT(qt[2596].goal.getItem[1].id) >= qt[2596].goal.getItem[1].count then
      NPC_SAY("辛苦了！请收下我的一点心意吧。")
      SET_QUEST_STATE(2596, 2)
      return
    else
      NPC_SAY("击退燃烧的废墟里的{0xFFFFFF00}[破损的巨石守护者]{END}，帮我收集回来{0xFFFFFF00}50个破损的巨石碎块{END}吧。")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10060)
  ADD_MOVESOUL_BTN(id)
  ADD_ENCHANT_BTN(id)
  ADD_PURIFICATION_BTN(id)
  if qData[2594].state == 0 and GET_PLAYER_LEVEL() >= qt[2594].needLevel then
    ADD_QUEST_BTN(qt[2594].id, qt[2594].name)
  end
  if qData[2596].state == 0 and qData[2594].state == 2 and GET_PLAYER_LEVEL() >= qt[2596].needLevel then
    ADD_QUEST_BTN(qt[2596].id, qt[2596].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2594].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2594].needLevel then
    if qData[2594].state == 1 then
      if CHECK_ITEM_CNT(qt[2594].goal.getItem[1].id) >= qt[2594].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2596].state ~= 2 and qData[2594].state == 2 and GET_PLAYER_LEVEL() >= qt[2596].needLevel then
    if qData[2596].state == 1 then
      if CHECK_ITEM_CNT(qt[2596].goal.getItem[1].id) >= qt[2596].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
