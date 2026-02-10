function npcsay(id)
  if id ~= 4321002 then
    return
  end
  clickNPCid = id
  NPC_SAY("因仙游谷的毒雾分散开，通往仙游谷的路被封锁了。想去仙游谷就跟我说。啊！还有，想要去仙游谷，就先去{0xFFFFFF00}南丰馆南边的医生爱仕达{END}处购买清明丹吧。可以保护你不受毒雾的伤害。")
  if qData[3656].state == 1 then
    if CHECK_ITEM_CNT(qt[3656].goal.getItem[1].id) >= qt[3656].goal.getItem[1].count and CHECK_ITEM_CNT(qt[3656].goal.getItem[2].id) >= qt[3656].goal.getItem[2].count and CHECK_ITEM_CNT(qt[3656].goal.getItem[3].id) >= qt[3656].goal.getItem[3].count and CHECK_ITEM_CNT(qt[3656].goal.getItem[4].id) >= qt[3656].goal.getItem[4].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("谢谢。明天也拜托了！")
        SET_QUEST_STATE(3656, 2)
      else
        NPC_SAY("行囊空间不足")
      end
    else
      NPC_SAY("收集白毛毛掉落的发霉的药草，蓝色无眼怪掉落的粘稠的蓝色液体，恶魂黑鬼掉落的黑鬼的喙，赤影魔掉落的掉了尖儿的影魔刀各10个回来就可以了")
    end
  end
  NPC_WARP_GUARD_TO_SUNYOOGOK(id)
  if qData[939].state == 0 then
    ADD_QUEST_BTN(qt[939].id, qt[939].name)
  end
  if qData[940].state == 0 then
    ADD_QUEST_BTN(qt[940].id, qt[940].name)
  end
  if qData[941].state == 0 then
    ADD_QUEST_BTN(qt[941].id, qt[941].name)
  end
  if qData[3656].state == 0 then
    ADD_QUEST_BTN(qt[3656].id, qt[3656].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3656].state ~= 2 then
    if qData[3656].state == 1 then
      if CHECK_ITEM_CNT(qt[3656].goal.getItem[1].id) >= qt[3656].goal.getItem[1].count and CHECK_ITEM_CNT(qt[3656].goal.getItem[2].id) >= qt[3656].goal.getItem[2].count and CHECK_ITEM_CNT(qt[3656].goal.getItem[3].id) >= qt[3656].goal.getItem[3].count and CHECK_ITEM_CNT(qt[3656].goal.getItem[4].id) >= qt[3656].goal.getItem[4].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
