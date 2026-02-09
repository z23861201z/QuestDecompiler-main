function npcsay(id)
  if id ~= 4341012 then
    return
  end
  clickNPCid = id
  NPC_SAY("西部边境地带很危险，要做好万全准备再出发！")
  if qData[2715].state == 1 then
    if qData[2715].killMonster[qt[2715].goal.killMonster[1].id] >= qt[2715].goal.killMonster[1].count then
      NPC_SAY("哇，真的很了不起！我的眼光果然很毒啊。")
      SET_QUEST_STATE(2715, 2)
      return
    else
      NPC_SAY("在空中庭院旁边的{0xFFFFFF00}西部边境地带{END}击退100个{0xFFFFFF00}锯齿飞鱼{END}吧。 击退后回到我，也就是{0xFFFFFF00}[守卫阿皮普]{END}处就可以了。")
    end
  end
  if qData[2715].state == 0 and GET_PLAYER_LEVEL() >= qt[2715].needLevel then
    ADD_QUEST_BTN(qt[2715].id, qt[2715].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2715].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2715].needLevel then
    if qData[2715].state == 1 then
      if qData[2715].killMonster[qt[2715].goal.killMonster[1].id] >= qt[2715].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
