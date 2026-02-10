function npcsay(id)
  if id ~= 4341004 then
    return
  end
  clickNPCid = id
  NPC_SAY("我说话的时候，你听着就可以。")
  if qData[2718].state == 1 then
    if qData[2718].killMonster[qt[2718].goal.killMonster[1].id] >= qt[2718].goal.killMonster[1].count then
      NPC_SAY("真的击退了100个吧？这是答应你的奖励。")
      SET_QUEST_STATE(2718, 2)
      return
    else
      NPC_SAY("去{0xFFFFFF00}西部边境地带{END}击退100个{0xFFFFFF00}巨翅鸭嘴兽{END}后回来吧。当然，奖励肯定会很丰厚的。")
    end
  end
  if qData[2723].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2723].goal.getItem) then
      NPC_SAY("做得好。下次有事情也会找你帮忙的。办事情很利索啊。")
      SET_QUEST_STATE(2723, 2)
      return
    else
      NPC_SAY("收集50个巨翅鸭嘴兽的羽毛回来吧。趁这次机会得留有备份。")
    end
  end
  if qData[2905].state == 1 then
    if qData[2905].killMonster[qt[2905].goal.killMonster[1].id] >= qt[2905].goal.killMonster[1].count then
      NPC_SAY("你确定是击退了100个吧？这是约定好的奖励。")
      SET_QUEST_STATE(2905, 2)
      return
    else
      NPC_SAY("干什么呢？没听到我让你马上去{0xFFFFFF00}大瀑布{END}击退100个{0xFFFFFF00}晶石怪{END}后回来吗？")
    end
  end
  if qData[2718].state == 0 and GET_PLAYER_LEVEL() >= qt[2718].needLevel then
    ADD_QUEST_BTN(qt[2718].id, qt[2718].name)
  end
  if qData[2723].state == 0 and GET_PLAYER_LEVEL() >= qt[2723].needLevel then
    ADD_QUEST_BTN(qt[2723].id, qt[2723].name)
  end
  if qData[2905].state == 0 and GET_PLAYER_LEVEL() >= qt[2905].needLevel then
    ADD_QUEST_BTN(qt[2905].id, qt[2905].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2718].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2718].needLevel then
    if qData[2718].state == 1 then
      if qData[2718].killMonster[qt[2718].goal.killMonster[1].id] >= qt[2718].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2723].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2723].needLevel then
    if qData[2723].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2723].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2905].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2905].needLevel then
    if qData[2905].state == 1 then
      if qData[2905].killMonster[qt[2905].goal.killMonster[1].id] >= qt[2905].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
