function npcsay(id)
  if id ~= 4300111 then
    return
  end
  clickNPCid = id
  if qData[1114].state == 1 then
    NPC_SAY("哦哦哦！你，你就是…新，新来的团员，没错吧？")
    SET_QUEST_STATE(1114, 2)
  end
  if qData[1338].state == 1 then
    if qData[1338].killMonster[qt[1338].goal.killMonster[1].id] >= qt[1338].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("了不起。从今起你就是清阴关自警团的一员了。")
        SET_QUEST_STATE(1338, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("只有击退{0xFFFFFF00}清阴谷的8只蝎角亭{END}，才能进入自警团。")
    end
  end
  if qData[1339].state == 1 then
    if CHECK_ITEM_CNT(qt[1339].goal.getItem[1].id) >= qt[1339].goal.getItem[1].count then
      NPC_SAY("辛苦了。不要忘记，我们自警团向来都怀着为清阴关居民们牺牲和服务的心。")
      SET_QUEST_STATE(1339, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}清阴谷的小星星{END}，收集{0xFFFFFF00}4个小星星的毛{END}。用它做成衣服送给难民。")
    end
  end
  if qData[1340].state == 1 then
    if CHECK_ITEM_CNT(qt[1340].goal.getItem[1].id) >= qt[1340].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("迈出了宝贵的第一步。希望难民们的心情会因此稍微舒服一些。")
        SET_QUEST_STATE(1340, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("去{0xFFFFFF00}南清阴平原{END}，击退{0xFFFFFF00}三只手{END}，收集{0xFFFFFF00}6个三只手手骨{END}！")
    end
  end
  if qData[1341].state == 1 then
    NPC_SAY("击退{0xFFFFFF00}清阴谷的毛毛{END}，带{0xFFFFFF00}4个药草{END}给{0xFFFFFF00}清阴关宝芝林{END}后，他会给你药的。")
  end
  if qData[1342].state == 1 then
    if CHECK_ITEM_CNT(qt[1342].goal.getItem[1].id) >= qt[1342].goal.getItem[1].count then
      NPC_SAY("辛苦了。不过还不够。")
      SET_QUEST_STATE(1342, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}清阴谷的螳螂勇勇{END}，收集{0xFFFFFF00}3个勇勇的前脚{END}。")
    end
  end
  if qData[1343].state == 1 then
    if qData[1343].killMonster[qt[1343].goal.killMonster[1].id] >= qt[1343].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("由此承认PLAYERNAME团员退团。")
        SET_QUEST_STATE(1343, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("去击退{0xFFFFFF00}5只清阴谷的螳螂勇勇{END}！")
    end
  end
  if qData[1344].state == 1 then
    NPC_SAY("去找清阴镖局的清阴银行吧。这段时间辛苦你了。")
  end
  if qData[1338].state == 0 and qData[1114].state == 2 and GET_PLAYER_LEVEL() >= qt[1338].needLevel then
    ADD_QUEST_BTN(qt[1338].id, qt[1338].name)
  end
  if qData[1339].state == 0 and qData[1338].state == 2 and GET_PLAYER_LEVEL() >= qt[1339].needLevel then
    ADD_QUEST_BTN(qt[1339].id, qt[1339].name)
  end
  if qData[1340].state == 0 and qData[1339].state == 2 and GET_PLAYER_LEVEL() >= qt[1340].needLevel then
    ADD_QUEST_BTN(qt[1340].id, qt[1340].name)
  end
  if qData[1341].state == 0 and qData[1340].state == 2 and GET_PLAYER_LEVEL() >= qt[1341].needLevel then
    ADD_QUEST_BTN(qt[1341].id, qt[1341].name)
  end
  if qData[1342].state == 0 and qData[1341].state == 2 and GET_PLAYER_LEVEL() >= qt[1342].needLevel then
    ADD_QUEST_BTN(qt[1342].id, qt[1342].name)
  end
  if qData[1343].state == 0 and qData[1342].state == 2 and GET_PLAYER_LEVEL() >= qt[1343].needLevel then
    ADD_QUEST_BTN(qt[1343].id, qt[1343].name)
  end
  if qData[1344].state == 0 and qData[1343].state == 2 and GET_PLAYER_LEVEL() >= qt[1344].needLevel then
    ADD_QUEST_BTN(qt[1344].id, qt[1344].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1114].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1338].state ~= 2 and qData[1114].state == 2 and GET_PLAYER_LEVEL() >= qt[1338].needLevel then
    if qData[1338].state == 1 then
      if qData[1338].killMonster[qt[1338].goal.killMonster[1].id] >= qt[1338].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1339].state ~= 2 and qData[1338].state == 2 and GET_PLAYER_LEVEL() >= qt[1339].needLevel then
    if qData[1339].state == 1 then
      if CHECK_ITEM_CNT(qt[1339].goal.getItem[1].id) >= qt[1339].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1340].state ~= 2 and qData[1339].state == 2 and GET_PLAYER_LEVEL() >= qt[1340].needLevel then
    if qData[1340].state == 1 then
      if CHECK_ITEM_CNT(qt[1340].goal.getItem[1].id) >= qt[1340].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1341].state ~= 2 and qData[1340].state == 2 and GET_PLAYER_LEVEL() >= qt[1341].needLevel then
    if qData[1341].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1342].state ~= 2 and qData[1341].state == 2 and GET_PLAYER_LEVEL() >= qt[1342].needLevel then
    if qData[1342].state == 1 then
      if CHECK_ITEM_CNT(qt[1342].goal.getItem[1].id) >= qt[1342].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1343].state ~= 2 and qData[1342].state == 2 and GET_PLAYER_LEVEL() >= qt[1343].needLevel then
    if qData[1343].state == 1 then
      if qData[1343].killMonster[qt[1343].goal.killMonster[1].id] >= qt[1343].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1344].state ~= 2 and qData[1343].state == 2 and GET_PLAYER_LEVEL() >= qt[1344].needLevel then
    if qData[1344].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
