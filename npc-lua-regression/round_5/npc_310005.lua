function npcsay(id)
  if id ~= 4310005 then
    return
  end
  clickNPCid = id
  if qData[93].state == 1 and qData[93].meetNpc[1] ~= id then
    if 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_QSAY(93, 1)
      SET_MEETNPC(93, 1, id)
      SET_INFO(93, 2)
      return
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[95].state == 1 then
    if qData[95].meetNpc[1] ~= id then
      SET_INFO(95, 2)
      SET_MEETNPC(95, 1, id)
      NPC_QSAY(95, 1)
      return
    else
      NPC_SAY("为什么总是对我这样~请相信我这个人。你问问{0xFFFFFF00}[ 老当家 ]{END}吧")
      return
    end
  end
  if qData[97].state == 1 then
    if qData[97].meetNpc[1] ~= id then
      if CHECK_ITEM_CNT(8910431) >= 20 then
        SET_MEETNPC(97, 1, id)
        NPC_SAY("收集回来黑粉了啊。请相信我吧。稍后去名田瞧那儿看看会吓一跳的。哈哈")
      else
        NPC_SAY("击退{0xFFFFFF00}飞头鬼{END}就可以获得{0xFFFFFF00}黑粉{END}")
      end
    else
      NPC_SAY("到了晚上回去名田瞧家的")
    end
  end
  if qData[98].state == 1 then
    if qData[98].meetNpc[1] ~= id then
      if CHECK_ITEM_CNT(8910431) >= 20 then
        SET_MEETNPC(98, 1, id)
        NPC_SAY("收集回来黑粉了啊。请相信我吧。稍后去名田瞧那儿看看会吓一跳的。哈哈")
      else
        NPC_SAY("击退{0xFFFFFF00}飞头鬼{END}就可以获得{0xFFFFFF00}黑粉{END}")
      end
    else
      NPC_SAY("到了晚上回去名田瞧家的")
    end
  end
  if qData[168].state == 1 then
    if qData[168].meetNpc[1] ~= id then
      if 1 <= CHECK_ITEM_CNT(8810012) then
        NPC_SAY("正义之事不分大小。少侠钓来的这条真鲷能让许多饱受饥饿之苦的人填饱肚子。我会跟白斩姬多说些你的好话的，你快回去看看吧。")
        SET_MEETNPC(168, 1, id)
        return
      end
    else
      NPC_SAY("快回去见见{0xFFFFFF00}白斩姬{END}吧。")
      return
    end
  end
  if qData[171].state == 1 then
    if qData[171].meetNpc[1] ~= id then
      if 1 <= CHECK_ITEM_CNT(8810012) then
        NPC_SAY("虽然身为邪派之人，但是行侠仗义是人类的基本。这条真鲷我会好好利用的，你快回到乌骨鸡处吧。")
        SET_MEETNPC(171, 1, id)
        return
      end
    else
      NPC_SAY("快回去见见{0xFFFFFF00}乌骨鸡{END}吧。")
      SET_INFO(171, 2)
      return
    end
  end
  if qData[174].state == 1 then
    if qData[174].meetNpc[1] ~= id then
      if 1 <= CHECK_ITEM_CNT(8810012) then
        NPC_SAY("正义之事不分大小。少侠钓来的这条真鲷能让许多饱受饥饿之苦的人填饱肚子。我会跟白斩姬多说些你的好话的，你快回去看看吧。")
        SET_MEETNPC(174, 1, id)
        return
      end
    else
      NPC_SAY("快回去见见{0xFFFFFF00}白斩姬{END}吧。")
      return
    end
  end
  if qData[177].state == 1 then
    if qData[177].meetNpc[1] ~= id then
      if 1 <= CHECK_ITEM_CNT(8810012) then
        NPC_SAY("虽然身为邪派之人，但是行侠仗义是人类的基本。这条真鲷我会好好利用的，你快回到乌骨鸡处吧。")
        SET_MEETNPC(177, 1, id)
        return
      end
    else
      NPC_SAY("快回去见见{0xFFFFFF00}乌骨鸡{END}吧。")
      SET_INFO(177, 2)
      return
    end
  end
  if qData[180].state == 1 then
    if qData[180].meetNpc[1] ~= id then
      if 1 <= CHECK_ITEM_CNT(8810012) then
        NPC_SAY("正义之事不分大小。少侠钓来的这条真鲷能让许多饱受饥饿之苦的人填饱肚子。我会跟白斩姬多说些你的好话的，你快回去看看吧。")
        SET_MEETNPC(180, 1, id)
        return
      end
    else
      NPC_SAY("快回去见见{0xFFFFFF00}白斩姬{END}吧。")
      return
    end
  end
  if qData[183].state == 1 then
    if qData[183].meetNpc[1] ~= id then
      if 1 <= CHECK_ITEM_CNT(8810012) then
        NPC_SAY("虽然身为邪派之人，但是行侠仗义是人类的基本。这条真鲷我会好好利用的，你快回到乌骨鸡处吧。")
        SET_MEETNPC(183, 1, id)
        return
      end
    else
      NPC_SAY("快回去见见{0xFFFFFF00}乌骨鸡{END}吧。")
      SET_INFO(183, 2)
      return
    end
  end
  if qData[384].state == 1 then
    if qData[384].meetNpc[1] ~= id then
      if 1 <= CHECK_ITEM_CNT(8810012) then
        NPC_SAY("正义之事不分大小。少侠钓来的这条真鲷能让许多饱受饥饿之苦的人填饱肚子。我会跟白斩姬多说些你的好话的，你快回去看看吧。")
        SET_MEETNPC(384, 1, id)
        return
      end
    else
      NPC_SAY("快回去见见{0xFFFFFF00}白斩姬{END}吧。")
      return
    end
  end
  if qData[387].state == 1 then
    if qData[387].meetNpc[1] ~= id then
      if 1 <= CHECK_ITEM_CNT(8810012) then
        NPC_SAY("虽然身为邪派之人，但是行侠仗义是人类的基本。这条真鲷我会好好利用的，你快回到乌骨鸡处吧。")
        SET_MEETNPC(387, 1, id)
        return
      end
    else
      NPC_SAY("快回去见见{0xFFFFFF00}乌骨鸡{END}吧。")
      SET_INFO(387, 2)
      return
    end
  end
  if qData[2091].state == 1 then
    if qData[2091].meetNpc[1] ~= id then
      if 1 <= CHECK_ITEM_CNT(8810012) then
        NPC_SAY("正义之事不分大小。少侠钓来了真鲷对正在饱受饥饿之苦的人很有帮助。我会好好跟白斩姬说的，你先回去吧~")
        SET_MEETNPC(2091, 1, id)
        return
      end
    else
      NPC_SAY("快回到{0xFFFFFF00}白斩姬{END}处吧")
      return
    end
  end
  if qData[2094].state == 1 then
    if qData[2094].meetNpc[1] ~= id then
      if 1 <= CHECK_ITEM_CNT(8810012) then
        NPC_SAY("虽然加入了邪派，但是做正义之事是人类的本分。这个真鲷我会好好使用的，你回去找乌骨鸡吧~")
        SET_MEETNPC(2094, 1, id)
        return
      end
    else
      NPC_SAY("快回到{0xFFFFFF00}乌骨鸡{END}处吧")
      SET_INFO(2094, 2)
      return
    end
  end
  if qData[202].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[202].goal.getItem) then
      NPC_SAY("还是我有看人的眼光啊。就知道你轻松就能做到的")
      SET_QUEST_STATE(202, 2)
    else
      NPC_SAY("少侠，{0xFFFFFF00}10个[ 金牙 ]{END}收集回来了吗？世上到处都有困难的人啊")
    end
  end
  if qData[246].state == 1 then
    if qData[246].meetNpc[1] ~= id then
      NPC_QSAY(246, 1)
      SET_INFO(246, 1)
      SET_MEETNPC(246, 1, id)
      return
    elseif __QUEST_HAS_ALL_ITEMS(qt[246].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[246].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("实力不错啊。这种程度击败一两个皇宫武士轻而易举了。但他们是大军，轻率地行动吃亏的不只是你，还会连累到相关的所有人员，一定要小心")
        SET_MEETNPC(246, 2, id)
        SET_QUEST_STATE(246, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("收集回来铁腕山的白发老妖和独眼跳跳的{0xFFFFFF00}白灰粉和毒囊包各100个{END}，从冥珠城南的井台下去，在地下秀洞的矿山通过采矿获得的{0xFFFFFF00}灰煤块和黑煤块各1个{END}吧")
    end
  end
  if qData[247].state == 1 and qData[246].state == 2 then
    NPC_SAY("还没给龙林派师兄传话吗？龙林派行动的时候，我也要一起采取行动的。快去传话吧。十万火急啊")
  end
  if qData[249].state == 1 and qData[248].state == 1 then
    NPC_SAY("小心身体啊")
    SET_MEETNPC(249, 1, id)
    SET_QUEST_STATE(249, 2)
    return
  end
  if qData[274].state == 1 then
    NPC_SAY("这次是为了什么事来找我的啊")
    SET_MEETNPC(274, 1, id)
    SET_QUEST_STATE(274, 2)
  end
  if qData[275].state == 1 then
    NPC_SAY("我事先已经拜托了哞读册，快去见见{0xFFFFFF00}龙林城哞读册{END}吧")
    return
  end
  if qData[277].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[277].goal.getItem) then
      NPC_SAY("来啦…比我想象的更有实力啊")
      SET_MEETNPC(277, 1, id)
      SET_QUEST_STATE(277, 2)
    else
      NPC_SAY("收集回来{0xFFFFFF00}未完成的符咒{END}吧")
    end
  end
  if qData[278].state == 1 then
    NPC_SAY("去见{0xFFFFFF00}武士转职NPC和刺客转职NPC，道士转职NPC{END}，领取鬼力回来吧")
  end
  if qData[281].state == 1 then
    if CHECK_ITEM_CNT(__QUEST_HAS_ALL_ITEMS(qt[280].goal.getItem)) >= __QUEST_HAS_ALL_ITEMS(qt[282].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("辛苦了。帮你制作成完成的符咒")
        SET_MEETNPC(281, 1, id)
        SET_QUEST_STATE(281, 2)
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("接受了鬼力的{0xFFFFFF00}未完成的符咒{END}在哪儿啊？")
      return
    end
  end
  if qData[282].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[282].goal.getItem) then
      NPC_SAY("你具备了很强的实力啊。收下这个奖励吧。什么？重新去往血玉髓房间的方法？很特别的人啊。听说邪教制作的嘉和符咒藏在红树妖那儿，仔细找找吧")
      SET_QUEST_STATE(282, 2)
    else
      NPC_SAY("{0xFFFFFF00}血玉髓种子{END}…。把那个收集回来给我吧。还有，如果没有{0xFFFFFF00}嘉和符咒就在生死之塔的红树妖身上{END}找找看吧。有传言说邪教把东西藏在那儿了...")
    end
  end
  if qData[463].state == 1 and qData[462].state == 2 then
    NPC_QSAY(463, 3)
    SET_MEETNPC(463, 2, id)
    SET_QUEST_STATE(463, 2)
  end
  if qData[464].state == 1 and qData[463].state == 2 then
    if CHECK_ITEM_CNT(qt[464].goal.getItem[1].id) >= qt[464].goal.getItem[1].count then
      NPC_QSAY(464, 3)
      SET_QUEST_STATE(464, 2)
    else
      NPC_QSAY(464, 1)
    end
  end
  if qData[465].state == 1 and qData[464].state == 2 then
    if CHECK_ITEM_CNT(qt[465].goal.getItem[1].id) >= qt[465].goal.getItem[1].count and CHECK_ITEM_CNT(qt[465].goal.getItem[2].id) >= qt[465].goal.getItem[2].count then
      NPC_QSAY(465, 3)
      SET_QUEST_STATE(465, 2)
    else
      NPC_QSAY(465, 1)
    end
  end
  if qData[466].state == 1 and qData[465].state == 2 then
    if CHECK_ITEM_CNT(qt[466].goal.getItem[1].id) >= qt[466].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_QSAY(466, 3)
        SET_QUEST_STATE(466, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_QSAY(466, 1)
    end
  end
  if qData[477].state == 1 and qData[477].meetNpc[1] ~= qt[477].goal.meetNpc[1] then
    NPC_SAY("冥珠城的名田瞧啊，那不就只有一个人吗！竟干那些坏事，不能原谅")
    SET_MEETNPC(477, 1, id)
    SET_QUEST_STATE(477, 2)
  end
  if qData[478].state == 1 then
    if qData[478].meetNpc[1] ~= id then
      if CHECK_ITEM_CNT(8910841) >= 50 then
        NPC_QSAY(478, 1)
        SET_INFO(478, 2)
        SET_MEETNPC(478, 1, id)
        return
      else
        NPC_SAY("影魔在生死之塔，快收集回来50个影魔粉吧")
      end
    else
      NPC_SAY("会给冥珠城的名田瞧很大的惩罚的。会让他忘记用恶毒的手法收集来的财富藏在哪里。哈哈哈哈哈哈哈哈")
    end
  end
  if qData[713].state == 1 then
    NPC_SAY("{0xFFFFFF00}[第一寺]{END}的{0xFFFFFF00}[住持]{END}应该知道秋叨鱼的住处吧。你快去见见他吧。")
    SET_INFO(713, 1)
  end
  if qData[749].state == 1 then
    NPC_SAY("这是我攒下来的钱，请用在做好事上吧")
    SET_QUEST_STATE(749, 2)
    return
  end
  if qData[1218].state == 1 and qData[1218].meetNpc[1] ~= id then
    NPC_QSAY(1218, 1)
    SET_MEETNPC(1218, 1, id)
    return
  end
  if qData[1219].state == 1 and CHECK_ITEM_CNT(qt[1219].goal.getItem[1].id) >= qt[1219].goal.getItem[1].count then
    if CHECK_INVENTORY_CNT(1) > 0 then
      NPC_SAY("嗯？哞读册明白的我的用意啊。我会负责保管佛像的。")
      SET_QUEST_STATE(1219, 2)
      return
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1220].state == 1 then
    if CHECK_ITEM_CNT(qt[1220].goal.getItem[1].id) >= qt[1220].goal.getItem[1].count then
      NPC_SAY("辛苦了。那现在就剩烧毁账簿的事情了。你稍等一会儿。")
      SET_QUEST_STATE(1220, 2)
      return
    else
      NPC_SAY("去击退{0xFFFFFF00}冥珠平原或青岳秀洞{END}的{0xFFFFFF00}飞头鬼{END}收集{0xFFFFFF00}10个黑粉{END}回来吧。")
    end
  end
  if qData[1221].state == 1 then
    NPC_SAY("{0xFFFFFF00}冥珠城东边{END}有{0xFFFFFF00}冥珠城名田瞧{END}，你去诱哄他获得账簿的位置吧。")
  end
  if qData[1226].state == 1 then
    NPC_SAY("藏在寝室的墙壁里了啊。辛苦了，但现在还剩下一件事要处理。")
    SET_QUEST_STATE(1226, 2)
    return
  end
  if qData[1227].state == 1 then
    if CHECK_ITEM_CNT(qt[1227].goal.getItem[1].id) >= qt[1227].goal.getItem[1].count then
      if CHECK_INVENTORY_CNT(3) > 0 then
        NPC_SAY("辛苦了。我这就出发。等我的好消息吧。")
        SET_QUEST_STATE(1227, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退{0xFFFFFF00}冥珠平原{END}的{0xFFFFFF00}独角阿鲁巴巴{END}收集{0xFFFFFF00}25个断掉的链子{END}回来吧。")
    end
  end
  if qData[1228].state == 1 then
    NPC_SAY("{0xFFFFFF00}冥珠城南边{END}的{0xFFFFFF00}冥珠城银行{END}会告诉你该为冥珠城做的事情。")
  end
  if qData[1316].state == 1 then
    NPC_SAY("少侠，好久不见了。")
    SET_QUEST_STATE(1316, 2)
    return
  end
  if qData[1317].state == 1 then
    NPC_SAY("快去看看吧。神檀树在铁腕谷的第7个山峰上。")
  end
  if qData[1318].state == 1 then
    NPC_SAY("可以和神檀树对话吗？")
    SET_QUEST_STATE(1318, 2)
    return
  end
  if qData[1319].state == 1 then
    if CHECK_ITEM_CNT(qt[1319].goal.getItem[1].id) >= qt[1319].goal.getItem[1].count then
      NPC_SAY("辛苦了。但是有个很着急的消息。")
      SET_QUEST_STATE(1319, 2)
      return
    else
      NPC_SAY("击退铁腕谷的四不象，收集30个巨大的象牙回来吧。")
    end
  end
  if qData[1320].state == 1 then
    if CHECK_ITEM_CNT(qt[1320].goal.getItem[1].id) >= qt[1320].goal.getItem[1].count then
      NPC_SAY("辛苦了。轮到我们做准备了。")
      SET_QUEST_STATE(1320, 2)
      return
    else
      NPC_SAY("击退铁腕谷的四不象，收集30个巨大的象牙回来吧。")
    end
  end
  if qData[1321].state == 1 then
    if CHECK_ITEM_CNT(qt[1321].goal.getItem[1].id) >= qt[1321].goal.getItem[1].count then
      if CHECK_INVENTORY_CNT(1) > 0 then
        NPC_SAY("辛苦了。下面是…。")
        SET_QUEST_STATE(1321, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退古乐山的幽冥武士，收集30个白色珍珠回来吧。")
    end
  end
  if qData[1322].state == 1 then
    if CHECK_ITEM_CNT(qt[1322].goal.getItem[1].id) >= qt[1322].goal.getItem[1].count then
      NPC_SAY("现在应该是准备就绪了。")
      SET_QUEST_STATE(1322, 2)
      return
    else
      NPC_SAY("击退股乐山的豆腐鬼童，收集30个腐烂的豆腐回来吧。")
    end
  end
  if qData[1323].state == 1 then
    if qData[1323].killMonster[qt[1323].goal.killMonster[1].id] >= qt[1323].goal.killMonster[1].count then
      if CHECK_INVENTORY_CNT(2) > 0 then
        NPC_SAY("辛苦了。已经把它们赶到一起了，现在就剩最后的战斗了。")
        SET_QUEST_STATE(1323, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退1个铁腕谷的马四掌吧。")
    end
  end
  if qData[1324].state == 1 then
    NPC_SAY("给龙林城北边的龙林派师兄传话，告诉他已经准备就绪了。")
  end
  ADD_DONATION_BTN(id)
  if GET_PLAYER_FACTION() == 1 then
    if qData[96].state == 2 and qData[97].state == 0 then
      ADD_QUEST_BTN(qt[97].id, qt[97].name)
    end
  elseif GET_PLAYER_FACTION() == 0 and qData[98].state == 0 then
    ADD_QUEST_BTN(qt[98].id, qt[98].name)
  end
  if qData[274].state == 2 and qData[275].state == 0 then
    ADD_QUEST_BTN(qt[275].id, qt[275].name)
  end
  if qData[277].state == 2 and qData[278].state == 0 then
    ADD_QUEST_BTN(qt[278].id, qt[278].name)
  end
  if qData[281].state == 2 and qData[282].state == 0 then
    ADD_QUEST_BTN(qt[282].id, qt[282].name)
  end
  if qData[464].state == 0 and qData[463].state == 2 then
    ADD_QUEST_BTN(qt[464].id, qt[464].name)
  end
  if qData[465].state == 0 and qData[464].state == 2 then
    ADD_QUEST_BTN(qt[465].id, qt[465].name)
  end
  if qData[466].state == 0 and qData[465].state == 2 then
    ADD_QUEST_BTN(qt[466].id, qt[466].name)
  end
  if qData[478].state == 0 and qData[477].state == 2 then
    ADD_QUEST_BTN(qt[478].id, qt[478].name)
  end
  if qData[466].state == 2 and qData[713].state == 0 then
    ADD_QUEST_BTN(qt[713].id, qt[713].name)
  end
  if qData[749].state == 0 then
    ADD_QUEST_BTN(qt[749].id, qt[749].name)
  end
  if qData[1220].state == 0 and qData[1218].state == 2 and GET_PLAYER_LEVEL() >= qt[1220].needLevel then
    ADD_QUEST_BTN(qt[1220].id, qt[1220].name)
  end
  if qData[1221].state == 0 and qData[1220].state == 2 and GET_PLAYER_LEVEL() >= qt[1221].needLevel then
    ADD_QUEST_BTN(qt[1221].id, qt[1221].name)
  end
  if qData[1227].state == 0 and qData[1226].state == 2 and GET_PLAYER_LEVEL() >= qt[1227].needLevel then
    ADD_QUEST_BTN(qt[1227].id, qt[1227].name)
  end
  if qData[1228].state == 0 and qData[1227].state == 2 and GET_PLAYER_LEVEL() >= qt[1228].needLevel then
    ADD_QUEST_BTN(qt[1228].id, qt[1228].name)
  end
  if qData[1317].state == 0 and qData[1316].state == 2 and GET_PLAYER_LEVEL() >= qt[1317].needLevel then
    ADD_QUEST_BTN(qt[1317].id, qt[1317].name)
  end
  if qData[1319].state == 0 and qData[1318].state == 2 and GET_PLAYER_LEVEL() >= qt[1319].needLevel then
    ADD_QUEST_BTN(qt[1319].id, qt[1319].name)
  end
  if qData[1320].state == 0 and qData[1319].state == 2 and GET_PLAYER_LEVEL() >= qt[1320].needLevel then
    ADD_QUEST_BTN(qt[1320].id, qt[1320].name)
  end
  if qData[1321].state == 0 and qData[1320].state == 2 and GET_PLAYER_LEVEL() >= qt[1321].needLevel then
    ADD_QUEST_BTN(qt[1321].id, qt[1321].name)
  end
  if qData[1322].state == 0 and qData[1321].state == 2 and GET_PLAYER_LEVEL() >= qt[1322].needLevel then
    ADD_QUEST_BTN(qt[1322].id, qt[1322].name)
  end
  if qData[1323].state == 0 and qData[1322].state == 2 and GET_PLAYER_LEVEL() >= qt[1323].needLevel then
    ADD_QUEST_BTN(qt[1323].id, qt[1323].name)
  end
  if qData[1324].state == 0 and qData[1323].state == 2 and GET_PLAYER_LEVEL() >= qt[1324].needLevel then
    ADD_QUEST_BTN(qt[1324].id, qt[1324].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[168].state == 1 and GET_PLAYER_LEVEL() >= qt[168].needLevel then
    if 1 <= CHECK_ITEM_CNT(8810012) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[171].state == 1 and GET_PLAYER_LEVEL() >= qt[171].needLevel then
    if 1 <= CHECK_ITEM_CNT(8810012) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[174].state == 1 and GET_PLAYER_LEVEL() >= qt[174].needLevel then
    if 1 <= CHECK_ITEM_CNT(8810012) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[177].state == 1 and GET_PLAYER_LEVEL() >= qt[177].needLevel then
    if 1 <= CHECK_ITEM_CNT(8810012) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[180].state == 1 and GET_PLAYER_LEVEL() >= qt[180].needLevel then
    if 1 <= CHECK_ITEM_CNT(8810012) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[183].state == 1 and GET_PLAYER_LEVEL() >= qt[183].needLevel then
    if 1 <= CHECK_ITEM_CNT(8810012) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[384].state == 1 and GET_PLAYER_LEVEL() >= qt[384].needLevel then
    if 1 <= CHECK_ITEM_CNT(8810012) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[387].state == 1 and GET_PLAYER_LEVEL() >= qt[387].needLevel then
    if 1 <= CHECK_ITEM_CNT(8810012) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2091].state == 1 and GET_PLAYER_LEVEL() >= qt[2091].needLevel then
    if 1 <= CHECK_ITEM_CNT(8810012) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2094].state == 1 and GET_PLAYER_LEVEL() >= qt[2094].needLevel then
    if 1 <= CHECK_ITEM_CNT(8810012) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[277].state == 1 and GET_PLAYER_LEVEL() >= qt[277].needLevel and qData[277].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[277].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if GET_PLAYER_LEVEL() >= qt[278].needLevel and qData[277].state == 2 and qData[278].state ~= 2 then
    if qData[278].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[463].state == 1 and qData[462].state == 2 and GET_PLAYER_LEVEL() >= qt[463].needLevel then
    QSTATE(id, 2)
  end
  if qData[464].state ~= 2 and GET_PLAYER_LEVEL() >= qt[464].needLevel and qData[463].state == 2 then
    if qData[464].state == 1 then
      if CHECK_ITEM_CNT(qt[464].goal.getItem[1].id) >= qt[464].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[465].state ~= 2 and GET_PLAYER_LEVEL() >= qt[465].needLevel and qData[464].state == 2 then
    if qData[465].state == 1 then
      if CHECK_ITEM_CNT(qt[465].goal.getItem[1].id) >= qt[465].goal.getItem[1].count and CHECK_ITEM_CNT(qt[465].goal.getItem[2].id) >= qt[465].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[466].state ~= 2 and GET_PLAYER_LEVEL() >= qt[466].needLevel and qData[465].state == 2 then
    if qData[466].state == 1 then
      if CHECK_ITEM_CNT(qt[466].goal.getItem[1].id) >= qt[466].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[713].state ~= 2 and GET_PLAYER_LEVEL() >= qt[713].needLevel then
    if qData[713].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[749].state ~= 2 and GET_PLAYER_LEVEL() >= qt[749].needLevel then
    if qData[749].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1219].state == 1 then
    if CHECK_ITEM_CNT(qt[1219].goal.getItem[1].id) >= qt[1219].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1220].state ~= 2 and qData[1219].state == 2 and GET_PLAYER_LEVEL() >= qt[1220].needLevel then
    if qData[1220].state == 1 then
      if CHECK_ITEM_CNT(qt[1220].goal.getItem[1].id) >= qt[1220].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1221].state ~= 2 and qData[1220].state == 2 and GET_PLAYER_LEVEL() >= qt[1221].needLevel then
    if qData[1220].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1226].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1221].state ~= 2 and qData[1220].state == 2 and GET_PLAYER_LEVEL() >= qt[1221].needLevel then
    if qData[1227].state == 1 then
      if CHECK_ITEM_CNT(qt[1227].goal.getItem[1].id) >= qt[1227].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1228].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1316].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1318].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1317].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1316].needLevel and qData[1317].state == 2 then
    if qData[1317].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1319].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1319].needLevel and qData[1318].state == 2 then
    if qData[1319].state == 1 then
      if CHECK_ITEM_CNT(qt[1319].goal.getItem[1].id) >= qt[1319].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1320].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1320].needLevel and qData[1319].state == 2 then
    if qData[1320].state == 1 then
      if CHECK_ITEM_CNT(qt[1320].goal.getItem[1].id) >= qt[1320].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1321].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1321].needLevel and qData[1320].state == 2 then
    if qData[1321].state == 1 then
      if CHECK_ITEM_CNT(qt[1321].goal.getItem[1].id) >= qt[1321].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1322].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1322].needLevel and qData[1321].state == 2 then
    if qData[1322].state == 1 then
      if CHECK_ITEM_CNT(qt[1322].goal.getItem[1].id) >= qt[1322].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1323].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1323].needLevel and qData[1322].state == 2 then
    if qData[1323].state == 1 then
      if qData[1323].killMonster[qt[1323].goal.killMonster[1].id] >= qt[1323].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1324].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1324].needLevel and qData[1323].state == 2 then
    if qData[1324].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
