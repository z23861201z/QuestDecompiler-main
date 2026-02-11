function npcsay(id)
  if id ~= 4316013 then
    return
  end
  clickNPCid = id
  if qData[1009].state == 1 then
    if qData[1009].killMonster[qt[1009].goal.killMonster[1].id] >= qt[1009].goal.killMonster[1].count then
      NPC_SAY("你封印了火车轮怪…现在雾气消散，可以开船了")
      SET_QUEST_STATE(1009, 2)
      return
    else
      NPC_SAY("请封印{0xFFFFFF00}50只火车轮怪{END}")
      return
    end
  end
  if qData[1426].state == 1 then
    NPC_SAY("哎呦，再这样下去该不会永远也开不了船了吧…")
    SET_QUEST_STATE(1426, 2)
  end
  if qData[1427].state == 1 then
    if qData[1427].killMonster[qt[1427].goal.killMonster[1].id] >= qt[1427].goal.killMonster[1].count then
      NPC_SAY("真的？60只全部都击退了？了不起啊！")
      SET_QUEST_STATE(1427, 2)
      return
    else
      NPC_SAY("请帮忙击退古老的渡头的{0xFFFFFF00}60只火车轮怪{END}")
      return
    end
  end
  if qData[1428].state == 1 then
    NPC_SAY("你要去见生死之塔入口的武艺僧长经？希望能有点儿什么办法")
  end
  if qData[1430].state == 1 then
    NPC_SAY("嗯？太和老君的弟子？")
    SET_QUEST_STATE(1430, 2)
  end
  if qData[1431].state == 1 then
    NPC_SAY("那里，在船头喃喃自语的老人")
  end
  if qData[2354].state == 1 and qData[2354].meetNpc[1] == qt[2354].goal.meetNpc[1] and qData[2354].meetNpc[2] ~= id then
    NPC_SAY("困瘤荐丛? 流立 咯辨 焊绊 弊繁 家副 窍碱. 历 厘荤槽窍绊 唱, 弊府绊 历 糠俊 角己茄 畴牢挥牢单.")
    SET_MEETNPC(2354, 2, id)
    return
  end
  if qData[2378].state == 1 then
    NPC_SAY("咯变 绢戮老捞脚瘤夸?")
    SET_QUEST_STATE(2378, 2)
    return
  end
  if qData[2379].state == 1 then
    if CHECK_ITEM_CNT(qt[2379].goal.getItem[1].id) >= qt[2379].goal.getItem[1].count then
      NPC_SAY("绊缚备妨. 寸脚篮 沥富 亮篮 荤恩捞备妨.")
      SET_QUEST_STATE(2379, 2)
      return
    else
      NPC_SAY("构... 官悔搁 救秦拎档 亮家. 秦临 荐 乐促搁 {0xFFFFFF00}弊阑赴唱公炼阿 30俺{END}父 粱 备秦林矫坷. 拳瞒符阑 贸摹窍搁 备且 荐 乐家捞促.")
    end
  end
  if qData[2418].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("狼蛆丛篮 亲惑 咯矾啊瘤肺 荤恩阑 愁扼霸 窍绰焙夸.")
      SET_QUEST_STATE(2418, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2419].state == 1 then
    NPC_SAY("荤恩 茄锅 档客玲促绊 积祸郴绰 扒瘤 购瘤...")
  end
  if qData[2420].state == 1 and CHECK_ITEM_CNT(qt[2420].goal.getItem[1].id) >= qt[2420].goal.getItem[1].count then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("捞霸... 辜聪鳖? 抗? 硅甫 荐府窍绰单 静扼绊夸?")
      SET_QUEST_STATE(2420, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2421].state == 1 then
    if CHECK_ITEM_CNT(qt[2421].goal.getItem[1].id) >= qt[2421].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("皑荤钦聪促. 啊... 皑荤钦聪促.")
        SET_QUEST_STATE(2421, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("酒捞绊, 力惯 粱... 混妨林技夸.{0xFFFFFF00}磷勘没林 10俺...{END}")
    end
  end
  if qData[2423].state == 1 and CHECK_ITEM_CNT(qt[2423].goal.getItem[1].id) >= qt[2423].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2423].goal.getItem[2].id) >= qt[2423].goal.getItem[2].count then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("酒捞绊 硅具... 捞霸 辜聪鳖?")
      SET_QUEST_STATE(2423, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2424].state == 1 then
    NPC_SAY("肋 捞秦绰 救登瘤父... 舅摆嚼聪促. 歹绰 狼缴窍瘤 臼摆嚼聪促.")
    SET_QUEST_STATE(2424, 2)
    return
  end
  if qData[2425].state == 1 then
    if CHECK_ITEM_CNT(qt[2425].goal.getItem[1].id) >= qt[2425].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2425].goal.getItem[2].id) >= qt[2425].goal.getItem[2].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("绊缚嚼聪促. 官肺 荐府甫 矫累窍烈. 136傍仿捞 登搁 促矫 茫酒客林技夸.")
        SET_QUEST_STATE(2425, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("荐府 犁丰肺 {0xFFFFFF00}捞惑茄龋乔 50俺客 嘲篮练磊30俺{END}啊 鞘夸钦聪促. 全混捞蓖脚苞 练磊夸赤甫 硼摹窍搁 掘阑 荐 乐嚼聪促.")
    end
  end
  if qData[2426].state == 1 then
    NPC_SAY("蓖林档扼...")
  end
  if qData[2436].state == 1 then
    NPC_SAY("档框捞 登辑 历档 扁晦聪促.")
    SET_QUEST_STATE(2436, 2)
    return
  end
  if qData[2442].state == 1 then
    if CHECK_ITEM_CNT(qt[2442].goal.getItem[1].id) >= qt[2442].goal.getItem[1].count then
      NPC_SAY("皑荤钦聪促. 沥富 绊缚嚼聪促.")
      SET_QUEST_STATE(2442, 2)
      return
    else
      NPC_SAY("全混捞蓖脚阑 硼摹窍绊 {0xFFFFFF00}捞惑茄龋乔 65俺{END}肺 硅 官蹿阑 颊焊绊 酵嚼聪促.")
    end
  end
  if qData[2443].state == 1 then
    if CHECK_ITEM_CNT(qt[2443].goal.getItem[1].id) >= qt[2443].goal.getItem[1].count then
      NPC_SAY("皑荤钦聪促. 怖 鞘夸茄 镑俊父 静摆嚼聪促.")
      SET_QUEST_STATE(2443, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}竿颇蓖传舅 30俺{END}涝聪促. 竿颇蓖甫 硼摹窍搁 掘阑 荐 乐嚼聪促.")
    end
  end
  if qData[2444].state == 1 then
    if CHECK_ITEM_CNT(qt[2444].goal.getItem[1].id) >= qt[2444].goal.getItem[1].count then
      NPC_SAY("沥富 皑荤钦聪促. 硅绰 梆 荐府瞪 疤聪促. 沥富 绊缚嚼聪促.")
      SET_QUEST_STATE(2444, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}葛贰馋馋捞 90俺{END}父 粱 何殴靛赋聪促. 蠕救付赤甫 拱府摹搁 掘阑 荐 乐嚼聪促.")
    end
  end
  if qData[2445].state == 1 then
    NPC_SAY("{0xFFFFFF00}蓖林档{END}肺 免惯钦聪促.")
  end
  if qData[2450].state == 1 then
    NPC_SAY("档馒沁嚼聪促. 坷贰等唱风磐涝聪促. 粱 浆菌促啊 {0xFFFFFF00}139傍仿{END}捞 登矫搁 茫酒客林技夸.")
    SET_QUEST_STATE(2450, 2)
    return
  end
  if qData[2451].state == 1 then
    NPC_SAY("侥樊阑 乘乘窍霸 备秦辑 促矫 芭合级栏肺 啊矫烈.")
    SET_QUEST_STATE(2451, 2)
    return
  end
  if qData[2452].state == 1 then
    if CHECK_ITEM_CNT(qt[2452].goal.getItem[1].id) >= qt[2452].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2452].goal.getItem[2].id) >= qt[2452].goal.getItem[2].count and CHECK_ITEM_CNT(qt[2452].goal.getItem[3].id) >= qt[2452].goal.getItem[3].count then
      NPC_SAY("沥犬窍焙夸. 滚几苞 快腊器绰 肋 富府搁 坷贰 焊包且 荐 乐烈. 弊府绊 家狼辉篮 惫拱狼 犁丰肺 敬翠聪促.")
      SET_QUEST_STATE(2452, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}玫澜拌窜{END}俊辑 {0xFFFFFF00}硼何档客 魂绊{END}甫 硼摹窍矫搁 邓聪促. {0xFFFFFF00}硼何档绰 家狼辉{END}阑, {0xFFFFFF00}魂绊绰 魂绊滚几{END}阑 凛聪促.")
    end
  end
  if qData[2453].state == 1 then
    if CHECK_ITEM_CNT(qt[2453].goal.getItem[1].id) >= qt[2453].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2453].goal.getItem[2].id) >= qt[2453].goal.getItem[2].count then
      NPC_SAY("绢捞捻 绊靛抚篮 攫力毫档 曼 瞒癌焙夸. 祈付蓖内啊 弧府 惑窍绰 巴阑 阜酒临疤聪促.")
      SET_QUEST_STATE(2453, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}绊靛抚 20俺绰 玫澜急背狼 葫必牢{END}俊霸辑, {0xFFFFFF00}祈付蓖内 50俺绰 辑困蛆邦俊辑 祈付蓖{END}甫 硼摹窍搁 掘阑 荐 乐嚼聪促.")
    end
  end
  if qData[2454].state == 1 then
    if CHECK_ITEM_CNT(qt[2454].goal.getItem[1].id) >= qt[2454].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2454].goal.getItem[2].id) >= qt[2454].goal.getItem[2].count then
      NPC_SAY("抗. 皑荤钦聪促. 历档 捞巴历巴 俺喊利栏肺 霖厚甫 秦具窍聪鳖 {0xFFFFFF00}140傍仿{END}捞 登搁 促矫 茫酒客林技夸. 弊锭鳖瘤 霖厚甫 付摹绊 扁促府摆嚼聪促.")
      SET_QUEST_STATE(2454, 2)
      return
    else
      NPC_SAY("绊遏锰狼 {0xFFFFFF00}绊遏锰狼盔丛{END}富绊档 促弗 镑俊辑档 备窍角 荐 乐嚼聪促. 肋 茫酒焊技夸.")
    end
  end
  if qData[2455].state == 1 then
    NPC_SAY("捞 硅绰 蓖林档, 烤 芭合级栏肺 癌聪促.")
  end
  if qData[2489].state == 1 then
    NPC_SAY("狼蛆丛 傣盒俊 历档 腹篮 巴阑 硅奎嚼聪促. 皑荤钦聪促.")
  end
  if qData[2494].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("绊缚嚼聪促. 例措 镭瘤 臼摆嚼聪促.")
      SET_QUEST_STATE(2494, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促!")
    end
  end
  if qData[3664].state == 1 then
    if CHECK_ITEM_CNT(qt[3664].goal.getItem[1].id) >= qt[3664].goal.getItem[1].count then
      NPC_SAY("谢谢！")
      SET_QUEST_STATE(3664, 2)
      return
    else
      NPC_SAY("只要有{0xFFFFFF00}60个熏黑的木块{END}就可以。击退火车轮怪就能收集到")
    end
  end
  if qData[3665].state == 1 then
    if CHECK_ITEM_CNT(qt[3665].goal.getItem[1].id) >= qt[3665].goal.getItem[1].count then
      NPC_SAY("谢谢！")
      SET_QUEST_STATE(3665, 2)
      return
    else
      NPC_SAY("只要有{0xFFFFFF00}60个鬼毛笔{END}就可以。击退毛笔怪就能收集到")
    end
  end
  NPC_WARP_THEME_37(id)
  if qData[1009].state == 0 then
    ADD_QUEST_BTN(qt[1009].id, qt[1009].name)
  end
  if qData[1427].state == 0 and qData[1426].state == 2 and GET_PLAYER_LEVEL() >= qt[1427].needLevel then
    ADD_QUEST_BTN(qt[1427].id, qt[1427].name)
  end
  if qData[1428].state == 0 and qData[1427].state == 2 and GET_PLAYER_LEVEL() >= qt[1428].needLevel then
    ADD_QUEST_BTN(qt[1428].id, qt[1428].name)
  end
  if qData[1431].state == 0 and qData[1430].state == 2 and GET_PLAYER_LEVEL() >= qt[1431].needLevel then
    ADD_QUEST_BTN(qt[1431].id, qt[1431].name)
  end
  if qData[3664].state == 0 and GET_PLAYER_LEVEL() >= qt[3664].needLevel then
    ADD_QUEST_BTN(qt[3664].id, qt[3664].name)
  end
  if qData[3665].state == 0 and GET_PLAYER_LEVEL() >= qt[3665].needLevel then
    ADD_QUEST_BTN(qt[3665].id, qt[3665].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1009].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1009].needLevel then
    if qData[1009].state == 1 then
      if qData[1009].killMonster[qt[1009].goal.killMonster[1].id] >= qt[1009].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1426].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1427].state ~= 2 and qData[1426].state == 2 and GET_PLAYER_LEVEL() >= qt[1427].needLevel then
    if qData[1427].state == 1 then
      if qData[1427].killMonster[qt[1427].goal.killMonster[1].id] >= qt[1427].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1428].state ~= 2 and qData[1427].state == 2 and GET_PLAYER_LEVEL() >= qt[1428].needLevel then
    if qData[1428].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1430].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1431].state ~= 2 and qData[1430].state == 2 and GET_PLAYER_LEVEL() >= qt[1431].needLevel then
    if qData[1431].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3664].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3664].needLevel then
    if qData[3664].state == 1 then
      if CHECK_ITEM_CNT(qt[3664].goal.getItem[1].id) >= qt[3664].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3665].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3665].needLevel then
    if qData[3665].state == 1 then
      if CHECK_ITEM_CNT(qt[3665].goal.getItem[1].id) >= qt[3665].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
