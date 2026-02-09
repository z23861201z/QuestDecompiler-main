local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4216003 then
    return
  end
  clickNPCid = id
  if qData[1556].state == 1 then
    if qData[1556].killMonster[qt[1556].goal.killMonster[1].id] >= qt[1556].goal.killMonster[1].count then
      NPC_SAY("谢谢。以后居民们不用受冻了。（作长老的候补，毫不逊色。）")
      SET_QUEST_STATE(1556, 2)
    else
      NPC_SAY("你帮我击退{0xFFFFFF00}60个第一阶梯的大脚怪{END}，我会过去收集皮制作衣服，让居民们暖暖的过冬。")
    end
  end
  if qData[295].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[295].goal.getItem) and __QUEST_CHECK_ITEMS(qt[295].goal.getItem) then
      NPC_SAY("?????. ??? ??? ????! ?? ? ??? ?? ???. ?? ???.")
      SET_QUEST_STATE(295, 2)
    else
      NPC_SAY("{0xFFFFFF00}????? ????{END}? ??? ????? ?… ??? ???… ")
    end
  end
  if qData[482].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[482].goal.getItem) then
      NPC_SAY("?? ?????. ?? ??? ???????. ?? ??????! ?? ??? 30?? ?? ??? ??? ?? ??? ????~")
      SET_QUEST_STATE(482, 2)
    else
      NPC_SAY("????? ???????. 50? ????? ??? ??? ??????. ?? ???~ ?. ?. ?. ?~")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10020)
  if qData[1556].state == 0 and qData[1554].state == 1 and GET_PLAYER_LEVEL() >= qt[1556].needLevel then
    ADD_QUEST_BTN(qt[1556].id, qt[1556].name)
  end
  if qData[295].state == 0 then
    ADD_QUEST_BTN(qt[295].id, qt[295].name)
  end
  if qData[482].state == 0 then
    ADD_QUEST_BTN(qt[482].id, qt[482].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1556].state ~= 2 and qData[1554].state == 1 and GET_PLAYER_LEVEL() >= qt[1556].needLevel then
    if qData[1556].state == 1 then
      if qData[1556].killMonster[qt[1556].goal.killMonster[1].id] >= qt[1556].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
