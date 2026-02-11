function npcsay(id)
  if id ~= 4341002 then
    return
  end
  clickNPCid = id
  NPC_SAY("呼...下层的怪物，还有西部边境地带的怪物们...太让人操心了…")
  if qData[2717].state == 1 then
    if qData[2717].killMonster[qt[2717].goal.killMonster[1].id] >= qt[2717].goal.killMonster[1].count then
      NPC_SAY("{0xFF99ff99}PLAYERNAME{END}果然厉害！太厉害了！")
      SET_QUEST_STATE(2717, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}西部边境地带{END}击退100个{0xFFFFFF00}地龙战士{END}就可以。拜托了！")
    end
  end
  if qData[2915].state == 1 then
    if qData[2915].killMonster[qt[2915].goal.killMonster[1].id] >= qt[2915].goal.killMonster[1].count then
      NPC_SAY("为我们赢得了充足的时间。谢谢~")
      SET_QUEST_STATE(2915, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}大瀑布{END}击退1个{0xFFFFFF00}虎羊大仙{END}后回来吧。")
    end
  end
  if qData[3734].state == 1 then
    if qData[3734].killMonster[qt[3734].goal.killMonster[1].id] >= qt[3734].goal.killMonster[1].count then
      NPC_SAY("辛苦了。下次再拜托你。")
      SET_QUEST_STATE(3734, 2)
      return
    else
      NPC_SAY("谢谢。那就讨伐60个地龙守卫吧。")
    end
  end
  if qData[2717].state == 0 and GET_PLAYER_LEVEL() >= qt[2717].needLevel then
    ADD_QUEST_BTN(qt[2717].id, qt[2717].name)
  end
  if qData[2915].state == 0 and GET_PLAYER_LEVEL() >= qt[2915].needLevel then
    ADD_QUEST_BTN(qt[2915].id, qt[2915].name)
  end
  if qData[3734].state == 0 and GET_PLAYER_LEVEL() >= qt[3734].needLevel then
    ADD_QUEST_BTN(qt[3734].id, qt[3734].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2717].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2717].needLevel then
    if qData[2717].state == 1 then
      if qData[2717].killMonster[qt[2717].goal.killMonster[1].id] >= qt[2717].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2915].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2915].needLevel then
    if qData[2915].state == 1 then
      if qData[2915].killMonster[qt[2915].goal.killMonster[1].id] >= qt[2915].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3734].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3734].needLevel then
    if qData[3734].state == 1 then
      if qData[3734].killMonster[qt[3734].goal.killMonster[1].id] >= qt[3734].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
