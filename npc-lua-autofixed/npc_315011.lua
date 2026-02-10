function npcsay(id)
  if id ~= 4315011 then
    return
  end
  clickNPCid = id
  if qData[108].state == 1 and qData[108].meetNpc[1] == qt[108].goal.meetNpc[1] then
    if qData[108].meetNpc[2] ~= id then
      if CHECK_ITEM_CNT(8820031) >= 100 then
        SET_INFO(108, 2)
        NPC_QSAY(108, 3)
        SET_MEETNPC(108, 2, id)
      end
    else
      NPC_SAY("???  ?? ?? ? ??? ?? ??? ????? ??? ????? ?? ????.")
    end
  end
  if qData[121].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[121].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("谢谢。真的拿来了啊。请收下这个{0xFFFFFF00}证书{END}吧。")
        SET_QUEST_STATE(121, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("帮我收集{0xFFFFFF00}40个[冥珠符]和40个[肉干]{END}吧。")
    end
  end
  if qData[126].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[126].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("哦…要重新看看？总之谢谢你帮了我。请收下这个{0xFFFFFF00}证书{END}吧。")
        SET_QUEST_STATE(126, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("帮我收集{0xFFFFFF00}40个[冥珠符]和40个[肉干]{END}吧。")
    end
  end
  if qData[156].state == 1 then
    if qData[156].meetNpc[2] ~= qt[156].goal.meetNpc[2] then
      NPC_QSAY(156, 5)
      SET_INFO(156, 2)
      SET_MEETNPC(156, 2, id)
      return
    else
      NPC_SAY("??????? ???? ??? ?? ?? ?? ??? ??? ??? ??? ??? ???? ? ?? ???.")
    end
  end
  if qData[1256].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("现在…。我不能就这样自己逃出龙林谷…。")
      SET_QUEST_STATE(1256, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1257].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1257].goal.getItem) then
      NPC_SAY("托您的福，藏起来的同僚应该是安全了。")
      SET_QUEST_STATE(1257, 2)
    else
      NPC_SAY("击退{0xFFFFFF00}龙林谷{END}的{0xFFFFFF00}虾米狼{END}，作为证据收集{0xFFFFFF00}20张虾米狼的皮{END}回来吧。")
    end
  end
  if qData[1258].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1258].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢。呜呜…。现在还是不敢相信。")
        SET_QUEST_STATE(1258, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退{0xFFFFFF00}龙林谷{END}的{0xFFFFFF00}八豆妖{END}，收集{0xFFFFFF00}30个八豆妖的烂衣{END}回来吧。")
    end
  end
  if qData[1259].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1259].goal.getItem) then
      NPC_SAY("谢谢。托您的福工人们在安全的逃离。")
      SET_QUEST_STATE(1259, 2)
    else
      NPC_SAY("为了确保脱离口的通畅，击退{0xFFFFFF00}龙林谷{END}的{0xFFFFFF00}大菜头{END}并收集{0xFFFFFF00}20个电碳{END}回来吧。")
    end
  end
  if qData[1260].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1260].goal.getItem) then
      NPC_SAY("托您的福，脱离口现在应该是安全了、")
      SET_QUEST_STATE(1260, 2)
    else
      NPC_SAY("击退{0xFFFFFF00}八豆妖和虾米狼{END}之后，收集{0xFFFFFF00}10个八豆妖的烂衣和10张虾米狼的皮{END}回来吧。")
    end
  end
  if qData[1261].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1261].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢。这都是托少侠的福。")
        SET_QUEST_STATE(1261, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("为了救援工作，希望少侠去击退{0xFFFFFF00}铁牛运功散{END}并收集回来{0xFFFFFF00}20个肉块{END}。")
    end
  end
  if qData[1262].state == 1 then
    NPC_SAY("希望少侠去找{0xFFFFFF00}龙林城北边{END}的{0xFFFFFF00}龙林城父母官{END}请求兵力支援。")
  end
  ADD_NPC_WARP_B(id)
  if (qData[118].state == 1 or qData[119].state == 1 or qData[120].state == 1 or qData[381].state == 1 or qData[627].state == 1 or qData[2083].state == 1) and qData[121].state == 0 then
    ADD_QUEST_BTN(qt[121].id, qt[121].name)
  end
  if (qData[123].state == 1 or qData[124].state == 1 or qData[125].state == 1 or qData[382].state == 1 or qData[631].state == 1 or qData[2087].state == 1) and qData[126].state == 0 then
    ADD_QUEST_BTN(qt[126].id, qt[126].name)
  end
  if qData[1257].state == 0 and qData[1256].state == 2 and GET_PLAYER_LEVEL() >= qt[1257].needLevel then
    ADD_QUEST_BTN(qt[1257].id, qt[1257].name)
  end
  if qData[1258].state == 0 and qData[1257].state == 2 and GET_PLAYER_LEVEL() >= qt[1258].needLevel then
    ADD_QUEST_BTN(qt[1258].id, qt[1258].name)
  end
  if qData[1259].state == 0 and qData[1258].state == 2 and GET_PLAYER_LEVEL() >= qt[1259].needLevel then
    ADD_QUEST_BTN(qt[1259].id, qt[1259].name)
  end
  if qData[1260].state == 0 and qData[1259].state == 2 and GET_PLAYER_LEVEL() >= qt[1260].needLevel then
    ADD_QUEST_BTN(qt[1260].id, qt[1260].name)
  end
  if qData[1261].state == 0 and qData[1260].state == 2 and GET_PLAYER_LEVEL() >= qt[1261].needLevel then
    ADD_QUEST_BTN(qt[1261].id, qt[1261].name)
  end
  if qData[1262].state == 0 and qData[1261].state == 2 and GET_PLAYER_LEVEL() >= qt[1262].needLevel then
    ADD_QUEST_BTN(qt[1262].id, qt[1262].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[108].state == 1 and GET_PLAYER_LEVEL() >= qt[108].needLevel then
    if qData[108].meetNpc[1] == qt[108].goal.meetNpc[1] and CHECK_ITEM_CNT(8820031) >= 100 then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if (qData[118].state == 1 or qData[119].state == 1 or qData[120].state == 1 or qData[381].state == 1 or qData[627].state == 1 or qData[2083].state == 1) and qData[121].state ~= 2 and GET_PLAYER_LEVEL() >= qt[121].needLevel then
    if qData[121].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[121].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[123].state == 1 or qData[124].state == 1 or qData[125].state == 1 or qData[382].state == 1 or qData[631].state == 1 or qData[2087].state == 1) and qData[126].state ~= 2 and GET_PLAYER_LEVEL() >= qt[126].needLevel then
    if qData[126].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[126].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[156].state == 1 and GET_PLAYER_LEVEL() >= qt[156].needLevel then
    QSTATE(id, 1)
  end
  if qData[1261].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1261].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        QSTATE(id, 2)
      end
    else
      QSTATE(id, 1)
    end
  end
  if qData[1256].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1257].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1257].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1258].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1258].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1259].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1259].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1260].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1260].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1257].state == 0 and qData[1256].state == 2 and GET_PLAYER_LEVEL() >= qt[1257].needLevel then
    QSTATE(id, 0)
  end
  if qData[1258].state == 0 and qData[1257].state == 2 and GET_PLAYER_LEVEL() >= qt[1258].needLevel then
    QSTATE(id, 0)
  end
  if qData[1259].state == 0 and qData[1258].state == 2 and GET_PLAYER_LEVEL() >= qt[1259].needLevel then
    QSTATE(id, 0)
  end
  if qData[1260].state == 0 and qData[1259].state == 2 and GET_PLAYER_LEVEL() >= qt[1260].needLevel then
    QSTATE(id, 0)
  end
  if qData[1261].state == 0 and qData[1260].state == 2 and GET_PLAYER_LEVEL() >= qt[1261].needLevel then
    QSTATE(id, 0)
  end
  if qData[1262].state == 0 and qData[1261].state == 2 and GET_PLAYER_LEVEL() >= qt[1262].needLevel then
    QSTATE(id, 0)
  end
  if qData[1262].state == 1 then
    QSTATE(id, 1)
  end
end
