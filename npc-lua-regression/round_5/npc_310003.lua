function npcsay(id)
  if id ~= 4310003 then
    return
  end
  clickNPCid = id
  if qData[560].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[560].goal.getItem) then
      NPC_SAY("啊~弄回来了啊。谢谢。当然钱我会分给穷困的人的。不知道能帮到什么程度。")
      SET_QUEST_STATE(560, 2)
      return
    else
      NPC_SAY("{0xFF36B8C2}50个毒蘑菇{END}收集回来了吗？还没有啊…击退第一阶梯的大脚怪就能获得。")
    end
  end
  if qData[560].state == 2 and qData[561].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[561].goal.getItem) then
      NPC_SAY("谢谢~吃这些我会变得更健康的吧。我会活的很久，也会变得更富有的。")
      SET_QUEST_STATE(561, 2)
      return
    else
      NPC_SAY("收集回来{0xFF36B8C2}50个骷髅鸟碎片{END}吧。击退第一阶梯的骷髅鸟就能获得。")
    end
  end
  if qData[1221].state == 1 then
    NPC_SAY("嗯，你是谁啊来找我？")
    SET_QUEST_STATE(1221, 2)
  end
  if qData[1222].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1222].goal.getItem) then
      if CHECK_INVENTORY_CNT(1) > 0 then
        NPC_SAY("嗯？就是我门下的武人全部出动也比你慢得多啊？你比想象的有用得多啊。哈哈哈！")
        SET_QUEST_STATE(1222, 2)
        return
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("击退{0xFFFFFF00}冥珠平原{END}的{0xFFFFFF00}狼牙棒叔叔{END}收集{0xFFFFFF00}25个断掉的棒子{END}回来。")
    end
  end
  if qData[1223].state == 1 then
    NPC_SAY("你去冥珠城南边的冥珠城服装店按照合约收来衣服或者地契中的一个吧。")
  end
  if qData[1225].state == 1 then
    NPC_SAY("回来了？切，在哪儿找的木屐呢？总之辛苦了。")
    SET_QUEST_STATE(1225, 2)
    return
  end
  if qData[1226].state == 1 then
    NPC_SAY("即使是在冥珠城南边出没的偷笔怪盗也不会知道。嗯，嗯，…。呼噜，呼噜！")
  end
  if qData[560].state == 0 then
    ADD_QUEST_BTN(qt[560].id, qt[560].name)
  end
  if qData[560].state == 2 and qData[561].state == 0 then
    ADD_QUEST_BTN(qt[561].id, qt[561].name)
  end
  if qData[1222].state == 0 and qData[1221].state == 2 and GET_PLAYER_LEVEL() >= qt[1222].needLevel then
    ADD_QUEST_BTN(qt[1222].id, qt[1222].name)
  end
  if qData[1223].state == 0 and qData[1222].state == 2 and GET_PLAYER_LEVEL() >= qt[1223].needLevel then
    ADD_QUEST_BTN(qt[1223].id, qt[1223].name)
  end
  if qData[1226].state == 0 and qData[1224].state == 2 and GET_PLAYER_LEVEL() >= qt[1226].needLevel then
    ADD_QUEST_BTN(qt[1226].id, qt[1226].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[560].state ~= 2 and GET_PLAYER_LEVEL() >= qt[560].needLevel then
    if qData[560].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[560].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[560].state == 2 and qData[561].state ~= 2 and GET_PLAYER_LEVEL() >= qt[561].needLevel then
    if qData[561].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[561].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1221].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1222].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1222].goal.getItem) then
      if 0 < CHECK_INVENTORY_CNT(1) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1223].state == 0 and qData[1222].state == 2 and GET_PLAYER_LEVEL() >= qt[1223].needLevel then
    QSTATE(id, 0)
  end
  if qData[1223].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1225].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1226].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1226].state == 0 and qData[1223].state == 2 and GET_PLAYER_LEVEL() >= qt[1226].needLevel then
    QSTATE(id, 0)
  end
end
