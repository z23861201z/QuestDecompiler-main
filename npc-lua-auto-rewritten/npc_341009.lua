function npcsay(id)
  if id ~= 4341009 then
    return
  end
  clickNPCid = id
  NPC_SAY("空中庭院真正的守护者是我们亲卫队。")
  if qData[2716].state == 1 then
    if qData[2716].killMonster[qt[2716].goal.killMonster[1].id] >= qt[2716].goal.killMonster[1].count then
      NPC_SAY("辛苦了。太感谢了，那些怪物们应该不会随意来这边了吧？")
      SET_QUEST_STATE(2716, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}西部边境地带{END}击退100个{0xFFFFFF00}地龙守卫{END}可以。你速度快点吧。")
    end
  end
  if qData[2907].state == 1 then
    if qData[2907].killMonster[qt[2907].goal.killMonster[1].id] >= qt[2907].goal.killMonster[1].count then
      NPC_SAY("来，辛苦了。太感谢了。这下那些怪物不能随意欺负人了吧？")
      SET_QUEST_STATE(2907, 2)
      return
    else
      NPC_SAY("击退25个{0xFFFFFF00}大瀑布{END}的{0xFFFFFF00}多足怪虫{END}吧。你动作快点。")
    end
  end
  if qData[2716].state == 0 and GET_PLAYER_LEVEL() >= qt[2716].needLevel then
    ADD_QUEST_BTN(qt[2716].id, qt[2716].name)
  end
  if qData[2907].state == 0 and GET_PLAYER_LEVEL() >= qt[2907].needLevel then
    ADD_QUEST_BTN(qt[2907].id, qt[2907].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2716].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2716].needLevel then
    if qData[2716].state == 1 then
      if qData[2716].killMonster[qt[2716].goal.killMonster[1].id] >= qt[2716].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2907].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2907].needLevel then
    if qData[2907].state == 1 then
      if qData[2907].killMonster[qt[2907].goal.killMonster[1].id] >= qt[2907].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
