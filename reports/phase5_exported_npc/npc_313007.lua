function npcsay(id)
  if id ~= 4313007 then
    return
  end
  clickNPCid = id
  NPC_SAY("我负责管理{0xFFFFFF00}都城战{END}和{0xFFFFFF00}同盟联合{END}。")
  if qData[804].state == 1 then
    if qData[804].meetNpc[1] ~= qt[804].goal.meetNpc[1] then
      NPC_QSAY(804, 1)
      SET_MEETNPC(804, 1, id)
      SET_INFO(804, 2)
    else
      NPC_SAY("通过{0xFFFFFF00}左侧红色的时空世界{END}可以到达通往巨大鬼怪的小胡同。和从黄泉进入一样，把灯火放入巨大的传送点后便可和队友一起入场")
    end
  end
  if qData[1229].state == 1 and CHECK_ITEM_CNT(qt[1229].goal.getItem[1].id) >= qt[1229].goal.getItem[1].count then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("少侠击退了大胡子吗？真是帮我去除了一个心病。谢谢了。")
      SET_QUEST_STATE(1229, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1230].state == 1 then
    NPC_SAY("击退{0xFFFFFF00}夺命鬼萝莉{END}，收集{0xFFFFFF00}20个夺命鬼萝莉的舌头{END}拿给{0xFFFFFF00}皇宫武士魏朗{END}，讨他欢心吧。")
  end
  if qData[1231].state == 1 and CHECK_ITEM_CNT(qt[1231].goal.getItem[1].id) >= qt[1231].goal.getItem[1].count then
    NPC_SAY("好了！现在把这件事告诉冥珠城的武林人，那他们间的争斗也会缓和很多。")
    SET_QUEST_STATE(1231, 2)
  end
  if qData[1232].state == 1 then
    if CHECK_ITEM_CNT(qt[1232].goal.getItem[1].id) >= qt[1232].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。现在可以正式的做准备了。")
        SET_QUEST_STATE(1232, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("通过{0xFFFFFF00}冥珠城井台{END}去{0xFFFFFF00}青岳秀洞{END}击退{0xFFFFFF00}黄蜗牛{END}，收集{0xFFFFFF00}25个黄蜗牛的壳{END}回来吧。")
    end
  end
  if qData[1233].state == 1 then
    NPC_SAY("快去{0xFFFFFF00}冥珠城东边{END}的{0xFFFFFF00}哭泣美眉{END}那儿看看吧。")
  end
  if qData[1238].state == 1 then
    NPC_SAY("来了啊。正在等你呢。")
    SET_QUEST_STATE(1238, 2)
  end
  if qData[1239].state == 1 then
    if CHECK_ITEM_CNT(qt[1239].goal.getItem[1].id) >= qt[1239].goal.getItem[1].count then
      NPC_SAY("托你的福，高官贵爵马上就下命令了。以后皇宫武士该消停了。真是辛苦你了。")
      SET_QUEST_STATE(1239, 2)
    else
      NPC_SAY("通过{0xFFFFFF00}冥珠城井台{END}去{0xFFFFFF00}青岳秀洞{END}就能找到{0xFFFFFF00}蓝蜗牛{END}。击退蓝蜗牛收集{0xFFFFFF00}25个蓝蜗牛的壳{END}回来吧。")
    end
  end
  if qData[1240].state == 1 then
    NPC_SAY("击退{0xFFFFFF00}龙林山的黑熊{END}收集{0xFFFFFF00}20个熊胆{END}，给{0xFFFFFF00}龙林客栈的来坐老板娘{END}送去吧。")
  end
  if qData[869].state == 1 then
    NPC_SAY("经过{0xFFFFFF00}冥珠城小胡同{END}进入{0xFFFFFF00}鬼怪战场入口{END}击退{0xFFFFFF00}愤怒的巨大鬼怪{END}吧")
  end
  if qData[2073].state == 1 and CHECK_ITEM_CNT(qt[2073].goal.getItem[1].id) >= qt[2073].goal.getItem[1].count then
    SET_QUEST_STATE(2073, 2)
    NPC_SAY("欢迎光临！你就是PLAYERNAME啊~")
  end
  if qData[2074].state == 1 then
    if CHECK_ITEM_CNT(qt[2074].goal.getItem[1].id) >= qt[2074].goal.getItem[1].count then
      SET_QUEST_STATE(2074, 2)
      NPC_SAY("辛苦了~总算在最后期限之前凑够了。可气的是这么辛苦集齐的税收要用到培养兰霉匠的军队上。虽然怒火中烧，但现在是没什么办法啊~")
    else
      NPC_SAY("你去龙林谷击退[大菜头]，收集20个[电碳]回来吧。只有龙林谷才有电碳，所以在国外能卖出高价")
    end
  end
  if qData[2075].state == 1 then
    if CHECK_ITEM_CNT(qt[2075].goal.getItem[1].id) >= qt[2075].goal.getItem[1].count then
      SET_QUEST_STATE(2075, 2)
      NPC_SAY("这些足够应付一段时间了。管理文件也筛选了一些无关紧要的，应该没什么问题")
    else
      NPC_SAY("[红蜗牛的壳]可以从[红蜗牛]身上获得。[红蜗牛]在[黄岳秀洞]的深处出没。收集20个[红蜗牛的壳]回来吧")
    end
  end
  if qData[2076].state == 1 then
    NPC_SAY("快回到佣兵团请求帮助吧。以佣兵团的能力应该可以抵挡的了的，你快点吧！")
  end
  if qData[2077].state == 1 then
    if CHECK_ITEM_CNT(qt[2077].goal.getItem[1].id) >= qt[2077].goal.getItem[1].count then
      SET_QUEST_STATE(2077, 2)
      NPC_SAY("你来了啊~现在佣兵团成员们正在跟巨大鬼怪战斗呢。稍微晚一点的话，别说是粮食了，连人都要被吃掉了！")
    else
      NPC_SAY("听说会收集粮食回来的。听说是击退[铁牛运功散]，收集20个[肉块]回来的")
    end
  end
  if qData[2078].state == 1 then
    if CHECK_ITEM_CNT(qt[2078].goal.getItem[1].id) >= qt[2078].goal.getItem[1].count then
      SET_QUEST_STATE(2078, 2)
      NPC_SAY("这些应该足够解决了~")
    else
      NPC_SAY("可以从栖息在黄岳秀洞深处的[变异毛毛虫]身上获得[变异毛毛的卵]。要给巨大鬼怪用的，所以要收集25个")
    end
  end
  if qData[2079].state == 1 then
    NPC_SAY("如果对2次转职有兴趣的话，去见[佣兵领袖]吧")
  end
  if qData[925].state == 0 then
    ADD_QUEST_BTN(qt[925].id, qt[925].name)
  end
  CW_PROCLAMATION(id)
  CW_REQUEST(id)
  CW_ENTER(id)
  ALLI_CREATE(id)
  ALLI_QUEST(id)
  ALLI_LISTVIEW(id)
  ALLI_DEFENSE_SIDE(id)
  ALLI_ATTACK_PROPOSE(id)
  if qData[1239].state == 0 and qData[1237].state == 2 and GET_PLAYER_LEVEL() >= qt[1239].needLevel then
    ADD_QUEST_BTN(qt[1239].id, qt[1239].name)
  end
  if qData[1240].state == 0 and qData[1239].state == 2 and GET_PLAYER_LEVEL() >= qt[1240].needLevel then
    ADD_QUEST_BTN(qt[1240].id, qt[1240].name)
  end
  if qData[1230].state == 0 and qData[1229].state == 2 and GET_PLAYER_LEVEL() >= qt[1230].needLevel then
    ADD_QUEST_BTN(qt[1230].id, qt[1230].name)
  end
  if qData[1232].state == 0 and qData[1231].state == 2 and GET_PLAYER_LEVEL() >= qt[1232].needLevel then
    ADD_QUEST_BTN(qt[1232].id, qt[1232].name)
  end
  if qData[1233].state == 0 and qData[1232].state == 2 and GET_PLAYER_LEVEL() >= qt[1233].needLevel then
    ADD_QUEST_BTN(qt[1233].id, qt[1233].name)
  end
  if qData[869].state == 0 then
    ADD_QUEST_BTN(qt[869].id, qt[869].name)
  end
  if qData[2074].state == 0 and qData[2073].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2074].id, qt[2074].name)
  end
  if qData[2075].state == 0 and qData[2074].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2075].id, qt[2075].name)
  end
  if qData[2076].state == 0 and qData[2075].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2076].id, qt[2076].name)
  end
  if qData[2078].state == 0 and qData[2077].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2078].id, qt[2078].name)
  end
  if qData[2079].state == 0 and qData[2078].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2079].id, qt[2079].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[676].state == 2 and qData[804].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1229].state == 1 and CHECK_ITEM_CNT(qt[1229].goal.getItem[1].id) >= qt[1229].goal.getItem[1].count then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1230].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1230].state == 0 and qData[1229].state == 2 and GET_PLAYER_LEVEL() >= qt[1230].needLevel then
    QSTATE(id, 0)
  end
  if qData[1231].state == 1 then
    if CHECK_ITEM_CNT(qt[1231].goal.getItem[1].id) >= qt[1231].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1232].state == 1 then
    if CHECK_ITEM_CNT(qt[1232].goal.getItem[1].id) >= qt[1232].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1232].state == 0 and qData[1231].state == 2 and GET_PLAYER_LEVEL() >= qt[1232].needLevel then
    QSTATE(id, 0)
  end
  if qData[1233].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1233].state == 0 and qData[1232].state == 2 and GET_PLAYER_LEVEL() >= qt[1233].needLevel then
    QSTATE(id, 0)
  end
  if qData[1238].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1239].state == 1 then
    if CHECK_ITEM_CNT(qt[1239].goal.getItem[1].id) >= qt[1239].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1232].state == 0 and qData[1231].state == 2 and GET_PLAYER_LEVEL() >= qt[1232].needLevel then
    QSTATE(id, 0)
  end
  if qData[1239].state == 0 and qData[1237].state == 2 and GET_PLAYER_LEVEL() >= qt[1239].needLevel then
    QSTATE(id, 0)
  end
  if qData[1240].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1240].state == 0 and qData[1239].state == 2 and GET_PLAYER_LEVEL() >= qt[1240].needLevel then
    QSTATE(id, 0)
  end
  if qData[869].state == 0 and GET_PLAYER_LEVEL() >= qt[869].needLevel then
    QSTATE(id, 0)
  end
  if qData[2073].state == 1 and CHECK_ITEM_CNT(qt[2073].goal.getItem[1].id) >= qt[2073].goal.getItem[1].count then
    QSTATE(id, 2)
  end
  if qData[2074].state ~= 2 and qData[2073].state == 2 and GET_PLAYER_LEVEL() >= qt[2074].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2074].state == 1 then
      if CHECK_ITEM_CNT(qt[2074].goal.getItem[1].id) >= qt[2074].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2075].state ~= 2 and qData[2074].state == 2 and GET_PLAYER_LEVEL() >= qt[2075].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2075].state == 1 then
      if CHECK_ITEM_CNT(qt[2075].goal.getItem[1].id) >= qt[2075].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2076].state ~= 2 and qData[2075].state == 2 and GET_PLAYER_LEVEL() >= qt[2076].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2076].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2077].state == 1 then
    if CHECK_ITEM_CNT(qt[2077].goal.getItem[1].id) >= qt[2077].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2078].state ~= 2 and qData[2077].state == 2 and GET_PLAYER_LEVEL() >= qt[2078].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2078].state == 1 then
      if CHECK_ITEM_CNT(qt[2078].goal.getItem[1].id) >= qt[2078].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2079].state ~= 2 and qData[2078].state == 2 and GET_PLAYER_LEVEL() >= qt[2079].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2079].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
