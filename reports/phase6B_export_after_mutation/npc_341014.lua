function npcsay(id)
  if id ~= 4341014 then
    return
  end
  clickNPCid = id
  NPC_SAY("这下面是原来的下层，但是被怪物们侵占了。")
  if qData[3732].state == 1 then
    if CHECK_ITEM_CNT(qt[3732].goal.getItem[1].id) >= qt[3732].goal.getItem[1].count then
      NPC_SAY("哇！真的收集回来了啊！真的太感谢了！")
      SET_QUEST_STATE(3732, 2)
      return
    else
      NPC_SAY("去{0xFFFFFF00}西部边境地带{END}击退{0xFFFFFF00}地龙战士{END}后，收集50个{0xFFFFFF00}地龙战士的枪{END}回来吧。拜托了！")
    end
  end
  if qData[2909].state == 1 then
    if qData[2909].killMonster[qt[2909].goal.killMonster[1].id] >= qt[2909].goal.killMonster[1].count then
      NPC_SAY("这么快就击退110个了？嗯，所以说{0xFFFFFF00}飞翅怪鱼{END}会飞来飞去，近距离攻击是吧？真的很感谢。这是我的谢礼，请收下吧。")
      SET_QUEST_STATE(2909, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}大瀑布{END}击退110个{0xFFFFFF00}飞翅怪鱼{END}，并把它们的特征告诉我吧。")
    end
  end
  if qData[2913].state == 1 then
    if qData[2913].killMonster[qt[2913].goal.killMonster[1].id] >= qt[2913].goal.killMonster[1].count then
      NPC_SAY("这么快就击退110个了？嗯，所以说{0xFFFFFF00}晶石矿工长{END}是走来走去，近距离攻击是吧？真的很感谢。这是我的谢礼，请收下吧。")
      SET_QUEST_STATE(2913, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}大瀑布{END}击退110个{0xFFFFFF00}晶石矿工长{END}，告诉我怪物的特征吧。")
    end
  end
  if qData[3732].state == 0 and GET_PLAYER_LEVEL() >= qt[3732].needLevel then
    ADD_QUEST_BTN(qt[3732].id, qt[3732].name)
  end
  if qData[2909].state == 0 and GET_PLAYER_LEVEL() >= qt[2909].needLevel then
    ADD_QUEST_BTN(qt[2909].id, qt[2909].name)
  end
  if qData[2913].state == 0 and GET_PLAYER_LEVEL() >= qt[2913].needLevel then
    ADD_QUEST_BTN(qt[2913].id, qt[2913].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3732].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3732].needLevel then
    if qData[3732].state == 1 then
      if CHECK_ITEM_CNT(qt[3732].goal.getItem[1].id) >= qt[3732].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2909].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2909].needLevel then
    if qData[2909].state == 1 then
      if qData[2909].killMonster[qt[2909].goal.killMonster[1].id] >= qt[2909].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2913].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2913].needLevel then
    if qData[2913].state == 1 then
      if qData[2913].killMonster[qt[2913].goal.killMonster[1].id] >= qt[2913].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
