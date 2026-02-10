function npcsay(id)
  if id ~= 4315007 then
    return
  end
  clickNPCid = id
  if qData[1505].state == 1 and qData[1505].meetNpc[1] == qt[1505].goal.meetNpc[1] and qData[1505].meetNpc[2] == qt[1505].goal.meetNpc[2] and qData[1505].meetNpc[3] == qt[1505].goal.meetNpc[3] and qData[1505].meetNpc[4] == qt[1505].goal.meetNpc[4] and qData[1505].meetNpc[5] ~= id then
    NPC_SAY("你连我都找到了啊！辛苦了。这么热的天还要去三个地方，你受苦了。这是为你准备的礼物，从3种礼物中选择1种吧")
    SET_MEETNPC(1505, 5, id)
    SET_QUEST_STATE(1505, 2)
  end
  if qData[235].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[235].goal.getItem) then
      NPC_SAY("?? ??? ????. ??? ????? ??? ??? ??? ????? ??? ?? ??? ??? ?? ??? ????. ?? ????? ????.")
      SET_QUEST_STATE(235, 2)
    else
      NPC_SAY("{0xFFFFFF00}???? 50?{END}? ????? ?? ???? ??? ????. ? ? ?????.")
    end
  end
  if qData[240].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[240].goal.getItem) then
      NPC_SAY("?? ??? ??????. ?? ??? ???? ???? ??? ????. ??? ? ???? ? ?????? ??? ??? ?? ?? ??.")
      SET_QUEST_STATE(240, 2)
    else
      NPC_SAY("??? ??? ?????? ???? ??. ??? ? ??? ????? ??? ???.")
    end
  end
  if qData[244].state == 1 and qData[242].state == 2 and CHECK_ITEM_CNT(qt[244].goal.getItem[1].id) >= qt[244].goal.getItem[1].count then
    NPC_SAY("??? ??? ?? ????? ??? ??? ?? ???? ??? ?????")
    SET_QUEST_STATE(244, 2)
  end
  if qData[245].state == 1 and qData[244].state == 2 then
    if qData[245].meetNpc[1] == qt[245].goal.meetNpc[1] then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("??? ??? ????? ??? ?????…. ?, ????? ????. ?? ???. ???? ?? ??.")
        SET_MEETNPC(245, 1, id)
        SET_QUEST_STATE(245, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("?? ???? ????? ?? {0xFFFFFF00}?????? ????{END}.")
    end
  end
  if qData[246].state == 1 and qData[245].state == 2 then
    NPC_SAY("??? ????? {0xFFFFFF00}'??'{END}?? ??? ????…. ????? ? ??? ???. ??? ??? ??? ??? ?? ??? ??.")
  end
  if qData[247].state == 1 and qData[246].state == 2 then
    if qData[247].meetNpc[1] ~= qt[247].goal.meetNpc[1] then
      NPC_QSAY(247, 1)
      SET_INFO(247, 1)
      SET_MEETNPC(247, 1, id)
      return
    else
      NPC_SAY("?? {0xFFFFFF00}????? ?? ????{END}? ?? ???????.")
    end
  end
  if qData[472].state == 1 then
    NPC_SAY("????? ???? ??? ????.")
  end
  if qData[473].state == 1 and CHECK_ITEM_CNT(qt[473].goal.getItem[1].id) >= qt[473].goal.getItem[1].count then
    NPC_QSAY(473, 1)
    SET_QUEST_STATE(473, 2)
    return
  end
  if qData[474].state == 1 then
    if qData[474].killMonster[qt[474].goal.killMonster[1].id] >= qt[474].goal.killMonster[1].count then
      NPC_QSAY(474, 1)
      SET_QUEST_STATE(474, 2)
      return
    else
      NPC_SAY("????? ???? ??. ???? 2??? ???? ???? ??? ???.")
    end
  end
  if qData[475].state == 1 then
    if qData[475].killMonster[qt[475].goal.killMonster[1].id] >= qt[475].goal.killMonster[1].count then
      NPC_QSAY(475, 1)
      SET_QUEST_STATE(475, 2)
      return
    else
      NPC_SAY("???? ?? ???? 50?? ???? ???. ??? ??? ??? ????? ????? ????.")
    end
  end
  if qData[476].state == 1 then
    if qData[476].killMonster[qt[476].goal.killMonster[1].id] >= qt[476].goal.killMonster[1].count then
      NPC_SAY("?? ??? ??? ??? ??? ??? ? ?? ???. ??? ???? ???? ???? ??? ???? ?? ? ?? ???.")
      SET_QUEST_STATE(476, 2)
      return
    else
      NPC_SAY("??? ??? ??? ????? 1?? ??????.")
    end
  end
  if qData[477].state == 1 then
    NPC_SAY("???? ???? ?? ?? ?? ? ??. ?? ? ???? ????.")
    return
  end
  if qData[478].state == 1 and qData[478].meetNpc[1] == qt[478].goal.meetNpc[1] and qData[478].meetNpc[2] ~= id then
    NPC_SAY("??, ??????? ? ???? ?? ????? ?? ? ???. ??? ?? ?? ?? ??? ?? ?? ?? ???. ??? ??? ??? ??? ??? ?? ?????. ?? ? ? ??? ???? ???? ?? ? ?? ???.")
    SET_MEETNPC(478, 2, id)
    SET_QUEST_STATE(478, 2)
  end
  if qData[1071].state == 1 and qData[1071].killMonster[qt[1071].goal.killMonster[1].id] >= qt[1071].goal.killMonster[1].count then
    if CHECK_ITEM_CNT(qt[1071].goal.getItem[1].id) >= qt[1071].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1071].goal.getItem[2].id) >= qt[1071].goal.getItem[2].count then
      NPC_SAY("?? ??? ? ?? ?? ???? ??? ??? ? ????.")
      SET_QUEST_STATE(1071, 2)
      return
    else
      NPC_SAY("????? ???? ?? ???? {0xFFFFFF00}???? 20?{END}, ???? {0xFFFFFF00}????? 20?{END}? ????, {0xFFFFFF00}???? 20??{END}? ??? ???.")
    end
  end
  if qData[1252].state == 1 and CHECK_ITEM_CNT(qt[1252].goal.getItem[1].id) >= qt[1252].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1252].goal.getItem[2].id) >= qt[1252].goal.getItem[2].count then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("推荐书？呵呵 你就是…。还准备了这些，真是谢谢了。")
      SET_QUEST_STATE(1252, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1253].state == 1 then
    if GET_PLAYER_LEVEL() >= 80 then
      NPC_SAY("我都吓了一跳。你肯定是天生的资质。但这只是开始。")
      SET_QUEST_STATE(1253, 2)
    else
      NPC_SAY("功力达80之后回来找我吧。那时候再说吧。")
    end
  end
  if qData[1277].state == 1 then
    NPC_SAY("嗯？又来了？就像说过似的…。")
    SET_QUEST_STATE(1277, 2)
  end
  if qData[1278].state == 1 then
    NPC_SAY("龙林派师弟在龙林城的南边。")
  end
  if qData[1315].state == 1 then
    NPC_SAY("来了啊？正等着你呢。")
    SET_QUEST_STATE(1315, 2)
  end
  if qData[1316].state == 1 then
    NPC_SAY("别忘了。一定要去找冥珠城南边的偷笔怪盗。")
  end
  if qData[1324].state == 1 then
    NPC_SAY("是吗？知道了。我们也要马上就出发了。")
    SET_QUEST_STATE(1324, 2)
  end
  if qData[1325].state == 1 then
    NPC_SAY("快点吧。通过龙林城南边的黄泉结界僧可以进入隐蔽地狱。")
  end
  if qData[1345].state == 1 then
    NPC_SAY("听说{0xFFFFFF00}南呱湃{END}依然在{0xFFFFFF00}龙林客栈{END}。你快点出发吧。")
  end
  if qData[862].state == 1 and qData[862].meetNpc[1] == qt[862].goal.meetNpc[1] and qData[862].meetNpc[2] == qt[862].goal.meetNpc[2] and qData[862].meetNpc[3] ~= id then
    NPC_QSAY(862, 9)
    SET_INFO(862, 3)
    SET_MEETNPC(862, 3, id)
    return
  end
  if qData[888].state == 1 then
    if qData[888].killMonster[qt[888].goal.killMonster[1].id] >= qt[888].goal.killMonster[1].count then
      NPC_SAY("辛苦了。果然你就是可以继承英雄们的人才啊。")
      SET_QUEST_STATE(888, 2)
    else
      NPC_SAY("击退{0xFFFFFF00}30只[铁牛运功散]{END}之后回来就给你 {0xFFFFFF00}1个龙林守护符{END}。记住了，这个任务{0xFFFFFF00}一天只能进行一次{END}..")
    end
  end
  if qData[2081].state == 1 then
    SET_QUEST_STATE(2081, 2)
    NPC_SAY("你就是PLAYERNAME吗？欢迎光临！")
  end
  ADD_DONATION_BTN(id)
  ADD_NEW_SHOP_BTN(id, 10065)
  if qData[972].state == 0 and GET_PLAYER_LEVEL() >= qt[972].needLevel and GET_PLAYER_JOB2() ~= 13 then
    ADD_QUEST_BTN(qt[972].id, qt[972].name)
  end
  if qData[888].state == 0 and GET_PLAYER_LEVEL() >= qt[888].needLevel and GET_PLAYER_JOB2() ~= 13 then
    ADD_QUEST_BTN(qt[888].id, qt[888].name)
  end
  if qData[235].state == 0 then
    ADD_QUEST_BTN(qt[235].id, qt[235].name)
  end
  if qData[240].state == 0 then
    ADD_QUEST_BTN(qt[240].id, qt[240].name)
  end
  if qData[472].state == 0 then
    ADD_QUEST_BTN(qt[472].id, qt[472].name)
  end
  if qData[474].state == 0 and qData[473].state == 2 then
    ADD_QUEST_BTN(qt[474].id, qt[474].name)
  end
  if qData[475].state == 0 and qData[474].state == 2 then
    ADD_QUEST_BTN(qt[475].id, qt[475].name)
  end
  if qData[476].state == 0 and qData[475].state == 2 then
    ADD_QUEST_BTN(qt[476].id, qt[476].name)
  end
  if qData[477].state == 0 and qData[476].state == 2 then
    ADD_QUEST_BTN(qt[477].id, qt[477].name)
  end
  if qData[1071].state == 0 then
    ADD_QUEST_BTN(qt[1071].id, qt[1071].name)
  end
  if qData[1253].state == 0 and qData[1252].state == 2 and GET_PLAYER_LEVEL() >= qt[1253].needLevel then
    ADD_QUEST_BTN(qt[1253].id, qt[1253].name)
  end
  if qData[1278].state == 0 and qData[1277].state == 2 and GET_PLAYER_LEVEL() >= qt[1278].needLevel then
    ADD_QUEST_BTN(qt[1278].id, qt[1278].name)
  end
  if qData[1316].state == 0 and qData[1315].state == 2 and GET_PLAYER_LEVEL() >= qt[1316].needLevel then
    ADD_QUEST_BTN(qt[1316].id, qt[1316].name)
  end
  if qData[1325].state == 0 and qData[1324].state == 2 and GET_PLAYER_LEVEL() >= qt[1325].needLevel then
    ADD_QUEST_BTN(qt[1325].id, qt[1325].name)
  end
  if qData[1345].state == 0 and GET_PLAYER_LEVEL() >= qt[1345].needLevel then
    ADD_QUEST_BTN(qt[1345].id, qt[1345].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[888].state ~= 2 and GET_PLAYER_LEVEL() >= qt[888].needLevel then
    if qData[888].state == 1 then
      if qData[888].killMonster[qt[888].goal.killMonster[1].id] >= qt[888].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[244].state == 1 and qData[242].state == 2 and GET_PLAYER_LEVEL() >= qt[244].needLevel then
    if CHECK_ITEM_CNT(qt[244].goal.getItem[1].id) >= qt[244].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[245].state ~= 2 and qData[244].state == 2 and GET_PLAYER_LEVEL() >= qt[245].needLevel then
    if qData[245].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[246].state ~= 2 and qData[245].state == 2 and GET_PLAYER_LEVEL() >= qt[246].needLevel then
    if qData[246].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[473].state == 1 and GET_PLAYER_LEVEL() >= qt[472].needLevel then
    if CHECK_ITEM_CNT(qt[473].goal.getItem[1].id) >= qt[473].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1252].state == 1 and CHECK_ITEM_CNT(qt[1252].goal.getItem[1].id) >= qt[1252].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1252].goal.getItem[2].id) >= qt[1252].goal.getItem[2].count then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1253].state ~= 2 and qData[1252].state == 2 and GET_PLAYER_LEVEL() >= qt[1253].needLevel then
    if qData[1253].state == 1 then
      if GET_PLAYER_LEVEL() >= 80 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1277].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1278].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1278].state ~= 2 and qData[1277].state == 2 and GET_PLAYER_LEVEL() >= qt[1278].needLevel then
    if qData[1278].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1315].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1316].state ~= 2 and qData[1315].state == 2 and GET_PLAYER_LEVEL() >= qt[1316].needLevel then
    if qData[1316].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1324].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1325].state ~= 2 and qData[1324].state == 2 and GET_PLAYER_LEVEL() >= qt[1325].needLevel then
    if qData[1325].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1345].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1345].needLevel then
    if qData[1345].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1505].state == 1 and qData[1505].state == 1 then
    if qData[1505].meetNpc[1] == qt[1505].goal.meetNpc[1] and qData[1505].meetNpc[2] == qt[1505].goal.meetNpc[2] and qData[1505].meetNpc[3] == qt[1505].goal.meetNpc[3] and qData[1505].meetNpc[4] == qt[1505].goal.meetNpc[4] and qData[1505].meetNpc[5] ~= id then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2081].state == 1 then
    QSTATE(id, 2)
  end
end
