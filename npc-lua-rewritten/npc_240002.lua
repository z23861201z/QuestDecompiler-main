local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4240002 then
    return
  end
  clickNPCid = id
  NPC_SAY("被我的话吸引忘了购买物品可不行啊。")
  if qData[2181].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[2181].goal.getItem) then
      NPC_SAY("谢谢！这下我的手指能少受点罪了~")
      SET_QUEST_STATE(2181, 2)
      return
    else
      NPC_SAY("从古龙山的灰色大脚怪身上收集50个大脚怪的指甲回来吧")
    end
  end
  if qData[3644].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[3644].goal.getItem) then
      NPC_SAY("谢谢！这下我的手指能少受点罪了~")
      SET_QUEST_STATE(3644, 2)
      return
    else
      NPC_SAY("击退古龙山的灰色大脚怪，收集50个大脚怪的指甲交给莎莉吧")
    end
  end
  if qData[3702].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[3702].goal.getItem) then
      NPC_SAY("谢谢！这是我给你的报酬。")
      SET_QUEST_STATE(3702, 2)
      return
    else
      NPC_SAY("击退黑色丘陵的{0xFFFFFF00}[恶灵巫师]{END}，收集回来{0xFFFFFF00}50个旧的黑色披风{END}就可以了~")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10062)
  GIHON_MIXTURE(id)
  if qData[2181].state == 0 then
    ADD_QUEST_BTN(qt[2181].id, qt[2181].name)
  end
  if qData[3644].state == 0 and qData[2181].state == 2 then
    ADD_QUEST_BTN(qt[3644].id, qt[3644].name)
  end
  if qData[3702].state == 0 and GET_PLAYER_LEVEL() >= qt[3702].needLevel then
    ADD_QUEST_BTN(qt[3702].id, qt[3702].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2181].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2181].needLevel then
    if qData[2181].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[2181].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3644].state ~= 2 and qData[2181].state == 2 and GET_PLAYER_LEVEL() >= qt[3644].needLevel then
    if qData[3644].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[3644].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3702].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3702].needLevel then
    if qData[3702].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[3702].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
