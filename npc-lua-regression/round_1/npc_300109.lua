function npcsay(id)
  if id ~= 4300109 then
    return
  end
  clickNPCid = id
  if qData[3757].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("谢谢。把我现在给你的礼物袋和礼物包裹打开后，再跟我对话吧。")
      SET_QUEST_STATE(3757, 2)
      return
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[3758].state == 1 then
    NPC_SAY("把礼物送给小甜甜后拿着跑腿章回来就可以。用收集的跑腿章可以在我这儿交换其他物品。")
  end
  if qData[3759].state == 1 then
    NPC_SAY("把礼物送给冥珠城东边的哭泣美眉后拿着跑腿章回来就可以。用收集的跑腿章可以在我这儿交换其他物品。")
  end
  if qData[3760].state == 1 then
    NPC_SAY("把礼物送给古乐村南的长老的外甥女后拿着跑腿章回来就可以。用收集的跑腿章可以在我这儿交换其他物品。")
  end
  if qData[3761].state == 1 then
    NPC_SAY("把礼物送给第一寺入口的发疯的童子僧后拿着跑腿章回来就可以。用收集的跑腿章可以在我这儿交换其他物品。")
  end
  if qData[3762].state == 1 then
    NPC_SAY("把礼物送给鬼谷村南的带花女后拿着跑腿章回来就可以。用收集的跑腿章可以在我这儿交换其他物品。")
  end
  if qData[3763].state == 1 then
    NPC_SAY("把礼物送给韩野村南的莲花后拿着跑腿章回来就可以。用收集的跑腿章可以在我这儿交换其他物品。")
  end
  if qData[3764].state == 1 then
    NPC_SAY("把礼物送给南丰馆桥的刺猬头后拿着跑腿章回来就可以。用收集的跑腿章可以在我这儿交换其他物品。")
  end
  if qData[3765].state == 1 then
    NPC_SAY("把礼物送给吕林城西的可爱小女孩后拿着跑腿章回来就可以。用收集的跑腿章可以在我这儿交换其他物品。")
  end
  if qData[3766].state == 1 then
    NPC_SAY("把礼物送给安哥拉市广场的山茶后拿着跑腿章回来就可以。用收集的跑腿章可以在我这儿交换其他物品。")
  end
  ADD_NEW_SHOP_BTN(id, 10091)
  if qData[3757].state == 0 and GET_PLAYER_LEVEL() >= qt[3757].needLevel then
    ADD_QUEST_BTN(qt[3757].id, qt[3757].name)
  end
  if qData[3758].state == 0 and GET_PLAYER_LEVEL() >= qt[3758].needLevel and 1 <= CHECK_ITEM_CNT(8980356) then
    ADD_QUEST_BTN(qt[3758].id, qt[3758].name)
  end
  if qData[3759].state == 0 and GET_PLAYER_LEVEL() >= qt[3759].needLevel and 1 <= CHECK_ITEM_CNT(8980357) then
    ADD_QUEST_BTN(qt[3759].id, qt[3759].name)
  end
  if qData[3760].state == 0 and GET_PLAYER_LEVEL() >= qt[3760].needLevel and 1 <= CHECK_ITEM_CNT(8980358) then
    ADD_QUEST_BTN(qt[3760].id, qt[3760].name)
  end
  if qData[3761].state == 0 and GET_PLAYER_LEVEL() >= qt[3761].needLevel and 1 <= CHECK_ITEM_CNT(8980359) then
    ADD_QUEST_BTN(qt[3761].id, qt[3761].name)
  end
  if qData[3762].state == 0 and GET_PLAYER_LEVEL() >= qt[3762].needLevel and 1 <= CHECK_ITEM_CNT(8980360) then
    ADD_QUEST_BTN(qt[3762].id, qt[3762].name)
  end
  if qData[3763].state == 0 and GET_PLAYER_LEVEL() >= qt[3763].needLevel and 1 <= CHECK_ITEM_CNT(8980361) then
    ADD_QUEST_BTN(qt[3763].id, qt[3763].name)
  end
  if qData[3764].state == 0 and GET_PLAYER_LEVEL() >= qt[3764].needLevel and 1 <= CHECK_ITEM_CNT(8980362) then
    ADD_QUEST_BTN(qt[3764].id, qt[3764].name)
  end
  if qData[3765].state == 0 and GET_PLAYER_LEVEL() >= qt[3765].needLevel and 1 <= CHECK_ITEM_CNT(8980363) then
    ADD_QUEST_BTN(qt[3765].id, qt[3765].name)
  end
  if qData[3766].state == 0 and GET_PLAYER_LEVEL() >= qt[3766].needLevel and 1 <= CHECK_ITEM_CNT(8980364) then
    ADD_QUEST_BTN(qt[3766].id, qt[3766].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3757].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3757].needLevel then
    if qData[3757].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3758].state ~= 2 and qData[3757].state == 2 and GET_PLAYER_LEVEL() >= qt[3758].needLevel and 1 <= CHECK_ITEM_CNT(8980356) then
    if qData[3758].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3759].state ~= 2 and qData[3757].state == 2 and GET_PLAYER_LEVEL() >= qt[3759].needLevel and 1 <= CHECK_ITEM_CNT(8980357) then
    if qData[3759].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3760].state ~= 2 and qData[3757].state == 2 and GET_PLAYER_LEVEL() >= qt[3760].needLevel and 1 <= CHECK_ITEM_CNT(8980358) then
    if qData[3760].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3761].state ~= 2 and qData[3757].state == 2 and GET_PLAYER_LEVEL() >= qt[3761].needLevel and 1 <= CHECK_ITEM_CNT(8980359) then
    if qData[3761].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3762].state ~= 2 and qData[3757].state == 2 and GET_PLAYER_LEVEL() >= qt[3762].needLevel and 1 <= CHECK_ITEM_CNT(8980360) then
    if qData[3762].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3763].state ~= 2 and qData[3757].state == 2 and GET_PLAYER_LEVEL() >= qt[3763].needLevel and 1 <= CHECK_ITEM_CNT(8980361) then
    if qData[3763].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3764].state ~= 2 and qData[3757].state == 2 and GET_PLAYER_LEVEL() >= qt[3764].needLevel and 1 <= CHECK_ITEM_CNT(8980362) then
    if qData[3764].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3765].state ~= 2 and qData[3757].state == 2 and GET_PLAYER_LEVEL() >= qt[3765].needLevel and 1 <= CHECK_ITEM_CNT(8980363) then
    if qData[3765].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3766].state ~= 2 and qData[3757].state == 2 and GET_PLAYER_LEVEL() >= qt[3766].needLevel and 1 <= CHECK_ITEM_CNT(8980364) then
    if qData[3766].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
