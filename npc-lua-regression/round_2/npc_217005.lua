function npcsay(id)
  if id ~= 4217005 then
    return
  end
  clickNPCid = id
  NPC_SAY("欢迎光临。信誉保证服务至上。")
  if qData[347].state == 1 then
    if qData[347].killMonster[qt[347].goal.killMonster[1].id] >= qt[347].goal.killMonster[1].count and __QUEST_HAS_ALL_ITEMS(qt[347].goal.getItem) then
      NPC_SAY("?? ?????. ?? ?? ????. ?? ?????.")
      SET_QUEST_STATE(347, 2)
      return
    else
      NPC_SAY("?????? ?, ????. ?? ? ??? ???... ????? ?????? ???? ?? {0xFFFFFF00}[????]? 1?? ?? ? [??????] 1?{END}? ??? ???.")
    end
  end
  if qData[1139].state == 1 then
    NPC_SAY("在跳舞的居民处领取清阴符回来吧。")
  end
  if qData[1154].state == 1 then
    NPC_SAY("疲惫的矿工让你来的？来的正好。")
    SET_QUEST_STATE(1154, 2)
  end
  if qData[1156].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1156].goal.getItem) then
      NPC_SAY("谢谢了。现在可以用这些制作衣服发给居民了。")
      SET_QUEST_STATE(1156, 2)
    else
      NPC_SAY("去击退强悍巷道的蓝舌跳跳鬼，收集10个[ 破旧的衣角 ]回来吧。")
    end
  end
  if qData[1163].state == 1 then
    if CHECK_ITEM_CNT(qt[1163].goal.getItem[1].id) >= qt[1163].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("真的很感谢。现在可以给全村的人发放礼物了。")
        SET_QUEST_STATE(1163, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退强悍巷道的吸血鬼收集15个[ 红色胶皮鞋 ]拿来吧。")
    end
  end
  ADD_STORE_BTN(id)
  GIVE_DONATION_ITEM(id)
  ADD_PARCEL_SERVICE_BTN(id)
  if qData[1139].state == 0 then
    ADD_QUEST_BTN(qt[1139].id, qt[1139].name)
  end
  if qData[1154].state == 2 and qData[1156].state == 0 then
    ADD_QUEST_BTN(qt[1156].id, qt[1156].name)
  end
  if qData[1163].state == 0 then
    ADD_QUEST_BTN(qt[1163].id, qt[1163].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1139].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1139].neetLevel then
    if qData[1139].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1154].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1154].state == 2 and qData[1156].state ~= 2 then
    if qData[1156].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1156].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1163].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1163].needLevel then
    if qData[1163].state == 1 then
      if CHECK_ITEM_CNT(qt[1163].goal.getItem[1].id) >= qt[1163].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
