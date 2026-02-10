function npcsay(id)
  if id ~= 4320001 then
    return
  end
  clickNPCid = id
  if qData[892].state == 1 then
    if qData[892].killMonster[qt[892].goal.killMonster[1].id] >= qt[892].goal.killMonster[1].count then
      NPC_SAY("辛苦了。果然少侠才是可以继承英雄们的人才啊。")
      SET_QUEST_STATE(892, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}70个[束缚老]{END}之后回来，就给你{0xFFFFFF00}1个鬼觜守护符{END}。不过要记住，这个任务{0xFFFFFF00}一天只能完成一次{END}。")
    end
  end
  if qData[1016].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1016].goal.getItem) then
      NPC_SAY("材料很充足啊。托你的福可以堵上屋顶了")
      SET_QUEST_STATE(1016, 2)
      return
    else
      NPC_SAY("趁洞还没有扩大之前，赶紧把")
      return
    end
  end
  if qData[1017].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1017].goal.getItem) then
      NPC_SAY("谢谢。我该怎么报答呢？")
      SET_QUEST_STATE(1017, 2)
      return
    else
      NPC_SAY("收集150个闪亮的鳞片应该不容易的。加油啊")
      return
    end
  end
  if qData[1018].state == 1 then
    if CHECK_ITEM_CNT(qt[1018].goal.getItem[1].id) >= qt[1018].goal.getItem[1].count then
      NPC_SAY("谢谢。托你的福我可以美美容了")
      SET_QUEST_STATE(1018, 2)
      return
    else
      NPC_SAY("皮肤变得越来越不好了。那么拜托了")
      return
    end
  end
  if qData[2459].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("绢赣, 穿备矫烈? 汲付 荤恩牢啊夸?")
      SET_QUEST_STATE(2459, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2460].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("历扁 糠俊 给积变 赤籍苞档 牢荤甫 唱穿技夸. 积变巴苞绰 喊俺肺 酒林 馒窍翠聪促.")
      SET_QUEST_STATE(2460, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2462].state == 1 then
    if qData[2462].killMonster[qt[2462].goal.killMonster[1].id] >= qt[2462].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("国结 硼摹茄芭具? 寸脚 沥富 碍茄单?")
        SET_QUEST_STATE(2462, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}归蓖趋肺{END}俊 免隔窍绰 {0xFFFFFF00}悼吝炼蓖{END}捞鄂 赤籍阑 200付府 硼摹秦拎.")
    end
  end
  if qData[2464].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("措拳啊 登绰 惑措甫 父抄 巴档 坷罚父捞瘤父, 寸脚 沥富 抗狼官弗吧? 后 富捞扼档 绊付况.")
      SET_QUEST_STATE(2464, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2465].state == 1 then
    if qData[2465].killMonster[qt[2465].goal.killMonster[1].id] >= qt[2465].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("绊付况夸.")
        SET_QUEST_STATE(2465, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}蓖搁哎脚{END}篮 {0xFFFFFF00}归蓖林盔{END}俊 啊搁 乐绢夸. 仇甸阑 170付府 硼摹秦林技夸.")
    end
  end
  if qData[2466].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("酒林 烤朝 捞具扁牢单... 寸脚俊霸 档框捞 登菌促聪, 炼陛 狼寇焙夸.")
      SET_QUEST_STATE(2466, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2467].state == 1 then
    if CHECK_ITEM_CNT(qt[2467].goal.getItem[1].id) >= qt[2467].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("狼寇肺 弧府 坷继焙夸. 沥富 绊付况夸.")
        SET_QUEST_STATE(2467, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}归蓖林盔{END}栏肺 啊辑 {0xFFFFFF00}[蓖搁哎脚]{END}阑 硼摹窍绊 {0xFFFFFF00}付拱去{END}阑 80俺备秦辑 历俊霸 林矫搁 邓聪促.")
    end
  end
  if qData[2468].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("弊烦 肋 啊技夸. 栋唱绰 荤恩 嘿棱绰 秒固绰 绝绢夸. 弊府绊 炼缴窍技夸.")
      SET_QUEST_STATE(2468, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2564].state == 1 then
    NPC_SAY("你..拜托这种大事情，是不是脸皮太厚了啊！")
    SET_QUEST_STATE(2564, 2)
    return
  end
  if qData[2565].state == 1 then
    if qData[2565].killMonster[qt[2565].goal.killMonster[1].id] >= qt[2565].goal.killMonster[1].count then
      NPC_SAY("果然，你是个不错的人！")
      SET_QUEST_STATE(2565, 2)
      return
    else
      NPC_SAY("太久了不知道在什么地方？就在这附近。去{0xFFFFFF00}黑鬼觜源{END}击退200个{0xFFFFFF00}[复头龟]{END}后再回来吧")
    end
  end
  if qData[2566].state == 1 then
    if CHECK_ITEM_CNT(qt[2566].goal.getItem[1].id) >= qt[2566].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2566].goal.getItem[2].id) >= qt[2566].goal.getItem[2].count then
      NPC_SAY("我来看看..都对了")
      SET_QUEST_STATE(2566, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}怪物的魂魄{END}可在{0xFFFFFF00}白鬼觜源{END}的{0xFFFFFF00}鬼面蝎神{END}处获得。还有{0xFFFFFF00}邪龙须{END}可在{0xFFFFFF00}黑鬼血路{END}的{0xFFFFFF00}邪龙{END}身上获得")
    end
  end
  if qData[2567].state == 1 then
    if CHECK_ITEM_CNT(qt[2567].goal.getItem[1].id) >= qt[2567].goal.getItem[1].count then
      NPC_SAY("我来看看..都对了")
      SET_QUEST_STATE(2567, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}[仙游谷[3]]{END}击退琵琶妖女收集{0xFFFFFF00}50个奇妙的琵琶{END}后回来吧。虽然要去很远的地方，但是拜托了")
    end
  end
  if qData[2568].state == 1 then
    if CHECK_ITEM_CNT(qt[2568].goal.getItem[1].id) >= qt[2568].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2568].goal.getItem[2].id) >= qt[2568].goal.getItem[2].count then
      NPC_SAY("都收集齐了。我现在要开始仪式了，应该需要点时间")
      SET_QUEST_STATE(2568, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}[巨木重林[1]]{END}击退彩色虫收集{0xFFFFFF00}150个彩色虫符咒{END}，在{0xFFFFFF00}[干涸的沼泽[3]]{END}击退{0xFFFFFF00}志鬼心火{END}收集{0xFFFFFF00}150个燃烧的铠甲残片{END}后回来吧。你不会要放弃吧？")
    end
  end
  if qData[2571].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("知道龟神，还寻找龟神灵魂的存在..很好奇啊")
    else
      NPC_SAY("行囊已满。")
    end
  end
  if qData[3673].state == 1 then
    if qData[3673].killMonster[qt[3673].goal.killMonster[1].id] >= qt[3673].goal.killMonster[1].count then
      NPC_SAY("我太喜欢你了！")
      SET_QUEST_STATE(3673, 2)
      return
    else
      NPC_SAY("还顺利吗？以为对你来说很容易的...不美好的{0xFFFFFF00}邪蜂怪{END}在{0xFFFFFF00}白鬼觜源{END}出没。帮我击退50个吧")
    end
  end
  if qData[3674].state == 1 then
    if qData[3674].killMonster[qt[3674].goal.killMonster[1].id] >= qt[3674].goal.killMonster[1].count then
      NPC_SAY("我太喜欢你了！")
      SET_QUEST_STATE(3674, 2)
      return
    else
      NPC_SAY("还顺利吗？以为对你来说很容易的...不美好的{0xFFFFFF00}鬼面蝎神{END}在{0xFFFFFF00}白鬼觜源{END}出没。帮我击退50个吧")
    end
  end
  if qData[3675].state == 1 then
    if qData[3675].killMonster[qt[3675].goal.killMonster[1].id] >= qt[3675].goal.killMonster[1].count then
      NPC_SAY("我太喜欢你了！")
      SET_QUEST_STATE(3675, 2)
      return
    else
      NPC_SAY("还顺利吗？以为对你来说很容易的...不美好的{0xFFFFFF00}束缚老{END}在{0xFFFFFF00}白鬼觜源{END}出没。帮我击退50个吧")
    end
  end
  if qData[3741].state == 1 then
    NPC_SAY("去白鬼地狱击退怪物们，妨碍牛犄角聚集怪物吧。")
  end
  ADD_NEW_SHOP_BTN(id, 10069)
  if qData[976].state == 0 and GET_PLAYER_LEVEL() >= qt[976].needLevel and GET_PLAYER_JOB2() ~= 13 then
    ADD_QUEST_BTN(qt[976].id, qt[976].name)
  end
  if qData[892].state == 0 and GET_PLAYER_LEVEL() >= qt[892].needLevel and GET_PLAYER_JOB2() ~= 13 then
    ADD_QUEST_BTN(qt[892].id, qt[892].name)
  end
  if qData[1016].state == 0 then
    ADD_QUEST_BTN(qt[1016].id, qt[1016].name)
  end
  if qData[1017].state == 0 and qData[1016].state == 2 then
    ADD_QUEST_BTN(qt[1017].id, qt[1017].name)
  end
  if qData[1018].state == 0 and qData[1017].state == 2 then
    ADD_QUEST_BTN(qt[1018].id, qt[1018].name)
  end
  if qData[2564].state == 0 and qData[2563].state == 2 and GET_PLAYER_LEVEL() >= qt[2564].needLevel then
    ADD_QUEST_BTN(qt[2564].id, qt[2564].name)
  end
  if qData[2565].state == 0 and qData[2564].state == 2 and GET_PLAYER_LEVEL() >= qt[2565].needLevel then
    ADD_QUEST_BTN(qt[2565].id, qt[2565].name)
  end
  if qData[2566].state == 0 and qData[2565].state == 2 and GET_PLAYER_LEVEL() >= qt[2566].needLevel then
    ADD_QUEST_BTN(qt[2566].id, qt[2566].name)
  end
  if qData[2567].state == 0 and qData[2566].state == 2 and GET_PLAYER_LEVEL() >= qt[2567].needLevel then
    ADD_QUEST_BTN(qt[2567].id, qt[2567].name)
  end
  if qData[2568].state == 0 and qData[2567].state == 2 and GET_PLAYER_LEVEL() >= qt[2568].needLevel then
    ADD_QUEST_BTN(qt[2568].id, qt[2568].name)
  end
  if qData[2571].state == 0 and qData[2570].state == 2 and GET_PLAYER_LEVEL() >= qt[2571].needLevel then
    ADD_QUEST_BTN(qt[2571].id, qt[2571].name)
  end
  if qData[3673].state == 0 and GET_PLAYER_LEVEL() >= qt[3673].needLevel then
    ADD_QUEST_BTN(qt[3673].id, qt[3673].name)
  end
  if qData[3674].state == 0 and GET_PLAYER_LEVEL() >= qt[3674].needLevel then
    ADD_QUEST_BTN(qt[3674].id, qt[3674].name)
  end
  if qData[3675].state == 0 and GET_PLAYER_LEVEL() >= qt[3675].needLevel then
    ADD_QUEST_BTN(qt[3675].id, qt[3675].name)
  end
  if qData[3741].state == 0 and qData[676].state == 2 and GET_PLAYER_LEVEL() >= qt[3741].needLevel then
    ADD_QUEST_BTN(qt[3741].id, qt[3741].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[892].state ~= 2 and GET_PLAYER_LEVEL() >= qt[892].needLevel then
    if qData[892].state == 1 then
      if qData[892].killMonster[qt[892].goal.killMonster[1].id] >= qt[892].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1016].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1016].needLevel then
    if qData[1016].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1016].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[1016].state)
      end
    else
      QSTATE(id, qData[1016].state)
    end
  end
  if qData[1017].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1017].needLevel and qData[1016].state == 2 then
    if qData[1017].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1017].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[1017].state)
      end
    else
      QSTATE(id, qData[1017].state)
    end
  end
  if qData[1018].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1018].needLevel and qData[1017].state == 2 then
    if qData[1018].state == 1 then
      if CHECK_ITEM_CNT(qt[1018].goal.getItem[1].id) >= qt[1018].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[1018].state)
      end
    else
      QSTATE(id, qData[1018].state)
    end
  end
  if qData[2564].state ~= 2 and qData[2563].state == 2 and GET_PLAYER_LEVEL() >= qt[2564].needLevel then
    if qData[2564].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2565].state ~= 2 and qData[2564].state == 2 and GET_PLAYER_LEVEL() >= qt[2565].needLevel then
    if qData[2565].state == 1 then
      if qData[2565].killMonster[qt[2565].goal.killMonster[1].id] >= qt[2565].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2566].state ~= 2 and qData[2565].state == 2 and GET_PLAYER_LEVEL() >= qt[2566].needLevel then
    if qData[2566].state == 1 then
      if CHECK_ITEM_CNT(qt[2566].goal.getItem[1].id) >= qt[2566].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2566].goal.getItem[2].id) >= qt[2566].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 0)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2567].state ~= 2 and qData[2566].state == 2 and GET_PLAYER_LEVEL() >= qt[2567].needLevel then
    if qData[2567].state == 1 then
      if CHECK_ITEM_CNT(qt[2567].goal.getItem[1].id) >= qt[2567].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 0)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2568].state ~= 2 and qData[2567].state == 2 and GET_PLAYER_LEVEL() >= qt[2568].needLevel then
    if qData[2568].state == 1 then
      if CHECK_ITEM_CNT(qt[2568].goal.getItem[1].id) >= qt[2568].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2568].goal.getItem[2].id) >= qt[2568].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 0)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2571].state ~= 2 and qData[2570].state == 2 and GET_PLAYER_LEVEL() >= qt[2571].needLevel then
    if qData[2571].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3673].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3673].needLevel then
    if qData[3673].state == 1 then
      if qData[3673].killMonster[qt[3673].goal.killMonster[1].id] >= qt[3673].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3674].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3674].needLevel then
    if qData[3674].state == 1 then
      if qData[3674].killMonster[qt[3674].goal.killMonster[1].id] >= qt[3674].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3675].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3675].needLevel then
    if qData[3675].state == 1 then
      if qData[3675].killMonster[qt[3675].goal.killMonster[1].id] >= qt[3675].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2564].state ~= 2 and qData[2563].state == 2 and GET_PLAYER_LEVEL() >= qt[2564].needLevel then
    if qData[2564].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3741].state ~= 2 and qData[676].state == 2 and GET_PLAYER_LEVEL() >= qt[3741].needLevel then
    if qData[3741].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
