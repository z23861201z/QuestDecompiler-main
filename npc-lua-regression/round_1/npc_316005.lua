function npcsay(id)
  if id ~= 4316005 then
    return
  end
  clickNPCid = id
  if qData[1557].state == 1 then
    if CHECK_ITEM_CNT(qt[1557].goal.getItem[1].id) >= qt[1557].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1557].goal.getItem[2].id) >= qt[1557].goal.getItem[2].count and __QUEST_HAS_ALL_KILL_TARGETS(qt[1557].goal.killMonster) then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("真的谢谢。不知道该怎么感谢你…弄来了这么多的东西，不管村里发生什么事也不用担心了。呵呵呵。（真像个老油条，作为长老候选人是...）")
        SET_QUEST_STATE(1557, 2)
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("击退{0xFFFFFF00}第一阶梯{END}的{0xFFFFFF00}大脚怪和骷髅鸟{END}，收集{0xFFFFFF00}10个毒蘑菇和10个骷髅鸟碎片{END}回来吧。啊！反正都是要做的，也一并击退{0xFFFFFF00}20个地狱狂牛{END}的话就很感谢了。")
      return
    end
  end
  if qData[480].state == 1 then
    if qData[480].meetNpc[1] ~= id then
      SET_INFO(480, 2)
      SET_MEETNPC(480, 1, id)
      NPC_QSAY(480, 1)
      return
    else
      NPC_SAY("要给年轻书生的母亲抓药，得给龙林城宝芝林拿去1个黑树妖皮。")
      return
    end
  end
end
if qData[1557].state == 0 and qData[1554].state == 1 and GET_PLAYER_LEVEL() >= qt[1557].needLevel then
  ADD_QUEST_BTN(qt[1557].id, qt[1557].name)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1557].state ~= 2 and qData[1554].state == 1 and GET_PLAYER_LEVEL() >= qt[1557].needLevel then
    if qData[1557].state == 1 then
      if CHECK_ITEM_CNT(qt[1557].goal.getItem[1].id) >= qt[1557].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1557].goal.getItem[2].id) >= qt[1557].goal.getItem[2].count and __QUEST_HAS_ALL_KILL_TARGETS(qt[1557].goal.killMonster) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[480].state == 1 and GET_PLAYER_LEVEL() >= qt[110].needLevel then
    QSTATE(id, 1)
  end
end
