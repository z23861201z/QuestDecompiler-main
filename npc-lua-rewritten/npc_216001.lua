local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4216001 then
    return
  end
  clickNPCid = id
  if qData[1551].state == 1 then
    NPC_SAY("去找古乐村南边的老长老应该就可以的。")
  end
  if qData[1555].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1555].goal.getItem) then
      NPC_SAY("谢谢。对患者应该很有帮助的。（作长老的候补，毫不逊色。）")
      SET_QUEST_STATE(1555, 2)
    else
      NPC_SAY("去{0xFFFFFF00}第一阶梯{END}击退{0xFFFFFF00}骷髅鸟{END}，作为证据收集回来{0xFFFFFF00}40个骷髅鸟碎片{END}吧。")
    end
  end
  if qData[1550].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1550].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢。可以制作连{0xFFFFFF00}老长老{END}都能马上就吃的药了。")
        SET_QUEST_STATE(1550, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("嗯？什么事啊？")
    end
  end
  if qData[1544].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1544].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("真的辛苦了。这下可以为{0xFFFFFF00}老长老{END}制作药了。药制作完成之后我会亲自转达的。你{0xFFFFFF00}功力达101{END}的时候，药应该也能完成了。")
        SET_QUEST_STATE(1544, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("击退{0xFFFFFF00}生死之塔，生死之房{END}的{0xFFFFFF00}红树妖{END}，收集回来{0xFFFFFF00}40个红树生死液{END}吧。")
      return
    end
  end
  if qData[1543].state == 1 then
    NPC_SAY("是说长老的病情啊。你来的正好")
    SET_QUEST_STATE(1543, 2)
    return
  end
  if qData[293].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[293].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("?? ?????. ? ?? ??????. ")
        SET_QUEST_STATE(293, 2)
        return
      else
        NPC_SAY("??? ??? ?? ???")
      end
    else
      NPC_SAY("{0xFFFFFF00}??? ? 100?{END}? ??? ???. ?? ???.")
    end
  end
  if qData[484].state == 1 then
    if qData[484].killMonster[qt[484].goal.killMonster[1].id] >= qt[484].goal.killMonster[1].count then
      NPC_SAY("????. ? ????.. ????, ??? ?? ??.. ?? ?? ????? ???? ?? ? ??? ?? ????. ???? ?? ?? ?? ?????. ???? ??? ??? ???? ? ? ?????.")
      SET_QUEST_STATE(484, 2)
      return
    else
      NPC_SAY("?? ?? ????? ??? ????? ??? ?? ?? ????. 70????? ?? ???? ??? ?? ????? ??? ?? ?? ?????.")
    end
  end
  if qData[553].state == 1 and qData[553].meetNpc[1] ~= id and 1 <= CHECK_ITEM_CNT(8990092) then
    SET_MEETNPC(553, 1, id)
    NPC_SAY("??? ?? ???.. ? ??? ???????.")
    SET_QUEST_STATE(553, 2)
  end
  ADD_NEW_SHOP_BTN(id, 10018)
  GIVE_DONATION_BUFF(id)
  if qData[1551].state == 0 and qData[1550].state == 2 and GET_PLAYER_LEVEL() >= qt[1551].needLevel then
    ADD_QUEST_BTN(qt[1551].id, qt[1551].name)
  end
  if qData[1555].state == 0 and qData[1554].state == 1 and GET_PLAYER_LEVEL() >= qt[1555].needLevel then
    ADD_QUEST_BTN(qt[1555].id, qt[1555].name)
  end
  if qData[1544].state == 0 and qData[1543].state == 2 and GET_PLAYER_LEVEL() >= qt[1544].needLevel then
    ADD_QUEST_BTN(qt[1544].id, qt[1544].name)
  end
  if qData[293].state == 0 then
    ADD_QUEST_BTN(qt[293].id, qt[293].name)
  end
  if qData[484].state == 0 then
    ADD_QUEST_BTN(qt[484].id, qt[484].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1555].state ~= 2 and qData[1554].state == 1 and GET_PLAYER_LEVEL() >= qt[1555].needLevel then
    if qData[1555].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[1555].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1551].state ~= 2 and qData[1550].state == 2 and GET_PLAYER_LEVEL() >= qt[1551].needLevel then
    if qData[1551].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1550].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1550].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1544].state ~= 2 and qData[1543].state == 2 and GET_PLAYER_LEVEL() >= qt[1544].needLevel then
    if qData[1544].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[1544].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1543].state == 1 then
    QSTATE(id, 2)
  end
  if qData[553].state == 1 and GET_PLAYER_LEVEL() > qt[553].needLevel then
    if 1 <= CHECK_ITEM_CNT(8990092) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
end
