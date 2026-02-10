function npcsay(id)
  if id ~= 4300010 then
    return
  end
  clickNPCid = id
  if qData[136].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[136].goal.getItem) then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("这个玉项链是{0xFFFFFF00}'西米路'{END}的…？是的，不知道你是怎么找到我的，但我就是{0xFFFFFF00}'南呱湃'{END}。但我已经不理世事很久了…。包括世间…青春…欢笑…。")
      SET_MEETNPC(136, 1, id)
      SET_QUEST_STATE(136, 2)
      return
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[241].state == 1 then
    NPC_SAY("可以从{0xFFFFFF00}龙林客栈{END}的来坐老板娘处帮我拿药回来吗？")
  end
  if qData[242].state == 1 and qData[241].state == 2 and qData[243].state == 2 and __QUEST_HAS_ALL_ITEMS(qt[242].goal.getItem) then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("现在到处都是怪物横行，还让你去来坐老板娘处拿药，是我的失误啊。走了那么远的路，辛苦你了。托{0xFFFFFF00}PLAYERNAME{END}的福，可以延续生命了")
      SET_QUEST_STATE(242, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[244].state == 1 and qData[242].state == 2 then
    NPC_SAY("{0xFFFFFF00}龙林派师兄在龙林城北{END}。拿着我的{0xFFFFFF00}证明{END}过去，他会帮助你的")
  end
  if qData[245].state == 1 and qData[244].state == 2 and qData[245].meetNpc[1] ~= qt[245].goal.meetNpc[1] then
    NPC_SAY("兰霉匠的影响力竟达到了那种程度…好的，知道了。我有想法，转告{0xFFFFFF00}龙林派师兄，让他等我的消息{END}")
    SET_MEETNPC(245, 1, id)
  end
  if qData[247].state == 1 then
    SET_MEETNPC(247, 2, id)
    NPC_SAY("回来了啊")
    SET_QUEST_STATE(247, 2)
  end
  if qData[248].state == 1 and qData[247].state == 2 then
    NPC_SAY("虽然不知道龙林派师兄的知己是谁，但如果是你，就信一次。和他一起去找{0xFFFFFF00}东泼肉，一定要把信交给东泼肉{END}")
  end
  if qData[456].state == 1 and qData[455].state == 2 then
    if CHECK_ITEM_CNT(qt[456].goal.getItem[1].id) >= qt[456].goal.getItem[1].count then
      NPC_QSAY(456, 3)
      SET_MEETNPC(456, 1, id)
      SET_QUEST_STATE(456, 2)
    else
      NPC_QSAY(456, 5)
    end
  end
  if qData[457].state == 1 and qData[456].state == 2 then
    NPC_QSAY(457, 1)
  end
  if qData[462].state == 1 then
    NPC_QSAY(462, 3)
    SET_MEETNPC(462, 1, id)
    SET_QUEST_STATE(462, 2)
  end
  if qData[463].state == 1 and qData[462].state == 2 then
    NPC_QSAY(463, 1)
  end
  if qData[472].state == 1 and qData[472].meetNpc[1] ~= id then
    SET_MEETNPC(472, 1, id)
    NPC_QSAY(472, 1)
    SET_QUEST_STATE(472, 2)
  end
  if qData[473].state == 1 then
    NPC_SAY("去铁腕谷收集50个魔蛋符咒，交给龙林派师兄吧。那样龙林派师兄就可以和鬼神对话了")
  end
  if qData[747].state == 1 then
    if qData[747].killMonster[qt[747].goal.killMonster[1].id] >= qt[747].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("强灵牌在此。希望能帮到{0xFFFFFF00}PLAYERNAME{END}。")
        SET_QUEST_STATE(747, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("{0xFFFFFF00}[ 鬼新娘 ]{END}在铁腕山。击退{0xFFFFFF00}15个[ 鬼新娘 ]{END}向我证明你有使用强灵牌的实力吧。")
      return
    end
  end
  if qData[1241].state == 1 and CHECK_ITEM_CNT(qt[1241].goal.getItem[1].id) >= qt[1241].goal.getItem[1].count then
    if 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_SAY("是谁啊？知道我的人很少啊…。啊！这玉项链？西米路师弟的…。")
      SET_QUEST_STATE(1241, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1242].state == 1 then
    if CHECK_ITEM_CNT(qt[1242].goal.getItem[1].id) >= qt[1242].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("好了，这下可以讨她欢心了。")
        SET_QUEST_STATE(1242, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("在{0xFFFFFF00}龙林山{END}击退{0xFFFFFF00}桶装黄鼠狼{END}，收集{0xFFFFFF00}20个桶装黄鼠狼的毛{END}回来吧。")
    end
  end
  if qData[1243].state == 1 then
    if CHECK_ITEM_CNT(qt[1243].goal.getItem[1].id) >= qt[1243].goal.getItem[1].count then
      NPC_SAY("希望这些能让她满意。")
      SET_QUEST_STATE(1243, 2)
    else
      NPC_SAY("击退{0xFFFFFF00}龙林山{END}的{0xFFFFFF00}多拉B梦{END}，收集{0xFFFFFF00}20个多拉B梦尾巴{END}回来吧。")
    end
  end
  if qData[1244].state == 1 then
    if CHECK_ITEM_CNT(qt[1244].goal.getItem[1].id) >= qt[1244].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("好了。现在可以问出东泼肉师兄的行踪了。")
        SET_QUEST_STATE(1244, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退{0xFFFFFF00}龙林山{END}的{0xFFFFFF00}黑熊{END}收集{0xFFFFFF00}20个熊胆{END}回来吧。")
    end
  end
  if qData[1245].state == 1 then
    NPC_SAY("击退{0xFFFFFF00}龙林山{END}的{0xFFFFFF00}多拉B梦{END}，收集{0xFFFFFF00}30个多拉B梦尾巴{END}给樵夫吧。")
  end
  if qData[1249].state == 1 then
    NPC_SAY("是这样啊。辛苦了。")
    SET_QUEST_STATE(1249, 2)
  end
  if qData[1250].state == 1 then
    NPC_SAY("击退龙林谷的大菜头收集20个电碳拿给来坐老板娘吧。")
  end
  if qData[1252].state == 1 then
    NPC_SAY("击退{0xFFFFFF00}龙林谷{END}的{0xFFFFFF00}铁牛运功散{END}，收集{0xFFFFFF00}20个肉块{END}拿给{0xFFFFFF00}龙林城北边{END}的{0xFFFFFF00}龙林派师兄{END}吧。")
  end
  if qData[1345].state == 1 then
    NPC_SAY("回来了啊。真，真的吗？知道了东泼肉师兄的下落？")
    SET_QUEST_STATE(1345, 2)
  end
  if qData[1346].state == 1 then
    NPC_SAY("快去{0xFFFFFF00}生死之塔{END}见{0xFFFFFF00}东泼肉师兄{END}转达我的赔罪吧。")
  end
  if qData[457].state == 0 and qData[456].state == 2 then
    ADD_QUEST_BTN(qt[457].id, qt[457].name)
  end
  if qData[463].state == 0 and qData[462].state == 2 then
    ADD_QUEST_BTN(qt[463].id, qt[463].name)
  end
  if qData[473].state == 0 and qData[472].state == 2 then
    ADD_QUEST_BTN(qt[473].id, qt[473].name)
  end
  if qData[747].state == 0 and qData[1252].state == 2 then
    ADD_QUEST_BTN(qt[747].id, qt[747].name)
  end
  if qData[1242].state == 0 and qData[1241].state == 2 and GET_PLAYER_LEVEL() >= qt[1242].needLevel then
    ADD_QUEST_BTN(qt[1242].id, qt[1242].name)
  end
  if qData[1243].state == 0 and qData[1242].state == 2 and GET_PLAYER_LEVEL() >= qt[1243].needLevel then
    ADD_QUEST_BTN(qt[1243].id, qt[1243].name)
  end
  if qData[1244].state == 0 and qData[1243].state == 2 and GET_PLAYER_LEVEL() >= qt[1244].needLevel then
    ADD_QUEST_BTN(qt[1244].id, qt[1244].name)
  end
  if qData[1245].state == 0 and qData[1244].state == 2 and GET_PLAYER_LEVEL() >= qt[1245].needLevel then
    ADD_QUEST_BTN(qt[1245].id, qt[1245].name)
  end
  if qData[1250].state == 0 and qData[1249].state == 2 and GET_PLAYER_LEVEL() >= qt[1250].needLevel then
    ADD_QUEST_BTN(qt[1250].id, qt[1250].name)
  end
  if qData[1252].state == 0 and qData[1251].state == 2 and GET_PLAYER_LEVEL() >= qt[1252].needLevel then
    ADD_QUEST_BTN(qt[1252].id, qt[1252].name)
  end
  if qData[1346].state == 0 and qData[1345].state == 2 and GET_PLAYER_LEVEL() >= qt[1346].needLevel then
    ADD_QUEST_BTN(qt[1346].id, qt[1346].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[136].state == 1 and GET_PLAYER_LEVEL() >= qt[136].needLevel then
    if __QUEST_HAS_ALL_ITEMS(qt[136].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[456].state == 1 and qData[455].state == 2 and GET_PLAYER_LEVEL() >= qt[456].needLevel then
    if CHECK_ITEM_CNT(qt[456].goal.getItem[1].id) >= qt[456].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[457].state ~= 2 and GET_PLAYER_LEVEL() >= qt[457].needLevel and qData[456].state == 2 then
    if qData[457].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[462].state == 1 and qData[461].state == 2 then
    QSTATE(id, 2)
  end
  if qData[463].state ~= 2 and GET_PLAYER_LEVEL() >= qt[463].needLevel and qData[462].state == 2 then
    if qData[463].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[747].state ~= 2 and GET_PLAYER_LEVEL() >= qt[747].needLevel and qData[242].state == 2 then
    if qData[747].state == 1 then
      if qData[747].killMonster[qt[747].goal.killMonster[1].id] >= qt[747].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1241].state == 1 then
    if CHECK_ITEM_CNT(qt[1241].goal.getItem[1].id) >= qt[1241].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1243].state == 1 then
    if CHECK_ITEM_CNT(qt[1243].goal.getItem[1].id) >= qt[1243].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1244].state == 1 then
    if CHECK_ITEM_CNT(qt[1244].goal.getItem[1].id) >= qt[1244].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1345].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1346].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1346].needLevel and qData[1345].state == 2 then
    if qData[1346].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
