function npcsay(id)
  if id ~= 4222005 then
    return
  end
  clickNPCid = id
  NPC_SAY("欢迎来到吕林城。行囊空间不足的时候就来找我吧。")
  if qData[2806].state == 1 then
    if qData[2806].killMonster[qt[2806].goal.killMonster[1].id] >= qt[2806].goal.killMonster[1].count then
      NPC_SAY("果然有实力啊！")
      SET_QUEST_STATE(2806, 2)
      return
    else
      NPC_SAY("击退30个{0xFFFFFF00}太极蜈蚣{END}后回来吧。因为那些怪物贸易都很困难。")
    end
  end
  if qData[2807].state == 1 then
    if qData[2807].killMonster[qt[2807].goal.killMonster[1].id] >= qt[2807].goal.killMonster[1].count then
      NPC_SAY("果然有实力啊！")
      SET_QUEST_STATE(2807, 2)
      return
    else
      NPC_SAY("击退30个妨碍银行贸易的{0xFFFFFF00}志鬼心火{END}吧。也能知道你的实力到底怎么样。")
    end
  end
  if qData[2808].state == 1 then
    if qData[2808].killMonster[qt[2808].goal.killMonster[1].id] >= qt[2808].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("你真的很了不起。这是约定好的{0xFFFFFF00}调查獐子潭许可证{END}。")
        SET_QUEST_STATE(2808, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退30个{0xFFFFFF00}妖粉怪{END}吧。")
    end
  end
  ADD_STORE_BTN(id)
  GIVE_DONATION_ITEM(id)
  ADD_SOULALCOHOL_CHANGE_BTN(id)
  ADD_PARCEL_SERVICE_BTN(id)
  if qData[2806].state == 0 and qData[2799].state == 1 and GET_PLAYER_LEVEL() >= qt[2806].needLevel then
    ADD_QUEST_BTN(qt[2806].id, qt[2806].name)
  end
  if qData[2807].state == 0 and qData[2806].state == 2 and GET_PLAYER_LEVEL() >= qt[2807].needLevel then
    ADD_QUEST_BTN(qt[2807].id, qt[2807].name)
  end
  if qData[2808].state == 0 and qData[2807].state == 2 and GET_PLAYER_LEVEL() >= qt[2808].needLevel then
    ADD_QUEST_BTN(qt[2808].id, qt[2808].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2806].state ~= 2 and qData[2799].state == 1 and GET_PLAYER_LEVEL() >= qt[2806].needLevel then
    if qData[2806].state == 1 then
      if qData[2806].killMonster[qt[2806].goal.killMonster[1].id] >= qt[2806].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2807].state ~= 2 and qData[2806].state == 2 and GET_PLAYER_LEVEL() >= qt[2807].needLevel then
    if qData[2807].state == 1 then
      if qData[2807].killMonster[qt[2807].goal.killMonster[1].id] >= qt[2807].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2808].state ~= 2 and qData[2807].state == 2 and GET_PLAYER_LEVEL() >= qt[2808].needLevel then
    if qData[2808].state == 1 then
      if qData[2808].killMonster[qt[2808].goal.killMonster[1].id] >= qt[2808].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
