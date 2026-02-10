function npcsay(id)
  if id ~= 4323009 then
    return
  end
  NPC_SAY("我，我不是喝酒了！只，只是不知道怎么就……嗯？不是近卫兵亚夫啊？\n{0xFFFF3333}※功力160以上才可以进入安哥拉外城，进场需要物品'女儿红'。{END}")
  clickNPCid = id
  if qData[1498].state == 1 then
    NPC_SAY("那现在要怎么办啊？")
    SET_QUEST_STATE(1498, 2)
    return
  end
  if qData[1482].state == 1 then
    NPC_SAY("停下！咦？这香气是？不会是{0xFFFFFF00}医生八字胡老头的女儿红{END}？")
    SET_QUEST_STATE(1482, 2)
    return
  end
  if qData[1483].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1483].goal.getItem) then
      NPC_SAY("辛苦了，辛苦了！差点就被{0xFFFFFF00}近卫兵亚夫{END}发现，但结果是好的就行了不是吗？呵呵呵。先去那边说话吧")
      SET_QUEST_STATE(1483, 2)
      return
    else
      NPC_SAY("去击退{0xFFFFFF00}安哥拉小胡同{END}的{0xFFFFFF00}癞蛤怪{END}，收集{0xFFFFFF00}50个受诅咒的纪念币{END}回来吧。那我就给你情报")
    end
  end
  if qData[1484].state == 1 then
    NPC_SAY("嗯？还没去吗？(回到{0xFFFFFF00}安哥拉王宫{END}的{0xFFFFFF00}近卫兵可心{END}处吧)")
    return
  end
  if qData[1485].state == 1 then
    NPC_SAY("又来了？虽然从{0xFFFFFF00}近卫兵可心{END}处听说了，但总觉得会吃亏呢？")
    SET_QUEST_STATE(1485, 2)
    return
  end
  if qData[874].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[874].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[874].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。这是{0xFFFFFF00}近卫兵可心{END}送来的奖励。那明天见吧！")
        SET_QUEST_STATE(874, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退{0xFFFFFF00}癞蛤怪和屠杀怪、狐尾怪{END}，各收集{0xFFFFFF00}20个受诅咒的纪念币、20瓶屠杀鬼油瓶、1个凭依念珠{END}回来吧")
    end
  end
  if qData[875].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[875].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[875].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。这是{0xFFFFFF00}近卫兵可心{END}送来的奖励。那明天见吧！")
        SET_QUEST_STATE(875, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退{0xFFFFFF00}银发木怪和银胡木怪、狐尾怪队长{END}，各收集{0xFFFFFF00}20个银发、20个古木年轮、1个鬼魂附着的圣珠{END}回来吧")
    end
  end
  if qData[877].state == 1 then
    NPC_SAY("趁近卫兵亚夫回来之前，击退你所看到的或发现你的怪物，看清情况之后回到我这儿")
  end
  if qData[878].state == 1 then
    NPC_SAY("趁近卫兵亚夫回来之前，击退你所看到的或发现你的怪物，看清情况之后回到我这儿")
  end
  if qData[2858].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2858].goal.getItem) then
    NPC_SAY("这是什么味道啊？这不是{0xFFFFFF00}女儿红{END}吗？什么？是辛巴达介绍来的？")
    SET_QUEST_STATE(2858, 2)
    return
  end
  if qData[2859].state == 1 then
    if CHECK_ITEM_CNT(qt[2859].goal.getItem[1].id) >= qt[2859].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2859].goal.getItem[2].id) >= qt[2859].goal.getItem[2].count and CHECK_ITEM_CNT(qt[2859].goal.getItem[3].id) >= qt[2859].goal.getItem[3].count then
      NPC_SAY("哇！这就是新的酒！~")
      SET_QUEST_STATE(2859, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}清阴酒酿{END},{0xFFFFFF00}冥珠米酒{END},{0xFFFFFF00}龙林松茶{END}..很期待啊~")
    end
  end
  if qData[2860].state == 1 then
    if CHECK_ITEM_CNT(qt[2860].goal.getItem[1].id) >= qt[2860].goal.getItem[1].count then
      NPC_SAY("这就是{0xFFFFFF00}龙林派张飞{END}的{0xFFFFFF00}张家烈酒{END}？！！太感谢了。")
      SET_QUEST_STATE(2860, 2)
      return
    else
      NPC_SAY("温和的酒好是好！但酒还得有点度数。")
    end
  end
  if qData[2862].state == 1 then
    NPC_SAY("不能让..近卫兵亚夫..知道..嗝..我醉了..嗝..{0xFFFFFF00}安哥拉市广场{END}..嗝..{0xFFFFFF00}医生八字胡老头{END}..{0xFFFFFF00}解酒剂{END}..嗝")
  end
  if qData[2864].state == 1 and CHECK_ITEM_CNT(qt[2864].goal.getItem[1].id) >= qt[2864].goal.getItem[1].count then
    NPC_SAY("{0xFFFFFF00}近卫兵亚夫{END}在{0xFFFFFF00}吕墩平原[废墟]{END}。")
    SET_QUEST_STATE(2864, 2)
    return
  end
  if qData[1498].state == 0 and qData[874].state == 2 then
    ADD_QUEST_BTN(qt[1498].id, qt[1498].name)
  end
  if qData[1483].state == 0 and qData[1482].state == 2 then
    ADD_QUEST_BTN(qt[1483].id, qt[1483].name)
  end
  if qData[1484].state == 0 and qData[1483].state == 2 then
    ADD_QUEST_BTN(qt[1484].id, qt[1484].name)
  end
  if qData[874].state == 0 and qData[1485].state == 2 then
    ADD_QUEST_BTN(qt[874].id, qt[874].name)
  end
  if qData[875].state == 0 and qData[1485].state == 2 then
    ADD_QUEST_BTN(qt[875].id, qt[875].name)
  end
  if qData[877].state == 0 and qData[1498].state == 2 then
    ADD_QUEST_BTN(qt[877].id, qt[877].name)
  end
  if qData[878].state == 0 and qData[1498].state == 2 then
    ADD_QUEST_BTN(qt[878].id, qt[878].name)
  end
  if qData[2859].state == 0 and qData[2858].state == 2 and GET_PLAYER_LEVEL() >= qt[2859].needLevel then
    ADD_QUEST_BTN(qt[2859].id, qt[2859].name)
  end
  if qData[2860].state == 0 and qData[2859].state == 2 and GET_PLAYER_LEVEL() >= qt[2860].needLevel then
    ADD_QUEST_BTN(qt[2860].id, qt[2860].name)
  end
  if qData[2862].state == 0 and qData[2860].state == 2 and GET_PLAYER_LEVEL() >= qt[2862].needLevel then
    ADD_QUEST_BTN(qt[2862].id, qt[2862].name)
  end
  if qData[2864].state == 0 and qData[2863].state == 2 and GET_PLAYER_LEVEL() >= qt[2864].needLevel then
    ADD_QUEST_BTN(qt[2864].id, qt[2864].name)
  end
  if qData[1482].state == 2 then
    ADD_BTN_HELL_BACKSTREET(id)
  end
  if qData[1482].state == 2 then
    ADD_BTN_HELL_OUTSKIRTS(id)
  end
  if qData[1482].state == 2 then
    ADD_BTN_HELL_DARKROAD(id)
  end
  if qData[1482].state == 2 then
    ADD_BTN_HELL_TOWN_WAR(id)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[874].state == 2 and qData[1498].state ~= 2 then
    if qData[1498].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1482].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1483].state ~= 2 and qData[1482].state == 2 then
    if qData[1483].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1483].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1484].state ~= 2 and qData[1483].state == 2 then
    if qData[1484].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1485].state == 1 then
    QSTATE(id, 2)
  end
  if qData[874].state ~= 2 and qData[1485].state == 2 then
    if qData[874].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[874].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[874].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[875].state ~= 2 and qData[1485].state == 2 then
    if qData[875].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[875].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[875].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[877].state ~= 2 and qData[1498].state == 2 then
    if qData[877].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[878].state ~= 2 and qData[1498].state == 2 then
    if qData[878].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2858].state ~= 2 and qData[2857].state == 2 and GET_PLAYER_LEVEL() >= qt[2858].needLevel then
    if qData[2858].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2858].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2859].state ~= 2 and qData[2858].state == 2 and GET_PLAYER_LEVEL() >= qt[2859].needLevel then
    if qData[2859].state == 1 then
      if CHECK_ITEM_CNT(qt[2859].goal.getItem[1].id) >= qt[2859].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2859].goal.getItem[2].id) >= qt[2859].goal.getItem[2].count and CHECK_ITEM_CNT(qt[2859].goal.getItem[3].id) >= qt[2859].goal.getItem[3].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2860].state ~= 2 and qData[2859].state == 2 and GET_PLAYER_LEVEL() >= qt[2860].needLevel then
    if qData[2860].state == 1 then
      if CHECK_ITEM_CNT(qt[2860].goal.getItem[1].id) >= qt[2860].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2862].state ~= 2 and qData[2860].state == 2 and GET_PLAYER_LEVEL() >= qt[2862].needLevel then
    if qData[2862].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2864].state ~= 2 and qData[2863].state == 2 and GET_PLAYER_LEVEL() >= qt[2864].needLevel then
    if qData[2864].state == 1 then
      if CHECK_ITEM_CNT(qt[2864].goal.getItem[1].id) >= qt[2864].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
