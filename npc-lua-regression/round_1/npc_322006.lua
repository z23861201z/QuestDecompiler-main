function npcsay(id)
  if id ~= 4322006 then
    return
  end
  clickNPCid = id
  if qData[1048].state == 1 then
    if qData[1048].killMonster[qt[1048].goal.killMonster[1].id] >= qt[1048].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("嗯~你怎么会有我的杖啊？竟然能主动帮我找回来，太感谢了。我没什么可给你的，就拿着这个吧！")
        SET_QUEST_STATE(1048, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("以为我老了，就想耍我啊~连10个都没办法击退，就干脆放弃吧！")
      return
    end
  end
  if qData[2679].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2679].goal.getItem) then
      NPC_SAY("谢谢~之后的事情我会看着办的。")
      SET_QUEST_STATE(2679, 2)
      return
    else
      NPC_SAY("应该是在{0xFFFFFF00}干涸的沼泽{END}那边。")
    end
  end
  if qData[2793].state == 1 then
    NPC_SAY("那个石板是！")
    SET_QUEST_STATE(2793, 2)
    return
  end
  if qData[2794].state == 1 then
    NPC_SAY("绝对不能靠近獐子潭。")
  end
  if qData[2795].state == 1 then
    NPC_SAY("怎么又来了？")
    SET_QUEST_STATE(2795, 2)
    return
  end
  if qData[2796].state == 1 then
    NPC_SAY("带着{0xFFFFFF00}吕林城南{END}的{0xFFFFFF00}治疗中的秋叨鱼{END}离开这里吧。")
  end
  if qData[2799].state == 1 then
    if CHECK_ITEM_CNT(qt[2799].goal.getItem[1].id) >= qt[2799].goal.getItem[1].count then
      NPC_SAY("还是..得到了大家的认可啊。那就按照你的意思办吧。")
      SET_QUEST_STATE(2799, 2)
      return
    else
      NPC_SAY("去找{0xFFFFFF00}厨师，宝芝林，银行{END}拿到调查獐子潭许可证吧。")
    end
  end
  if qData[1048].state == 0 then
    ADD_QUEST_BTN(qt[1048].id, qt[1048].name)
  end
  if qData[2679].state == 0 and qData[2678].state == 2 and GET_PLAYER_LEVEL() >= qt[2679].needLevel then
    ADD_QUEST_BTN(qt[2679].id, qt[2679].name)
  end
  if qData[2794].state == 0 and qData[2793].state == 2 and GET_PLAYER_LEVEL() >= qt[2794].needLevel then
    ADD_QUEST_BTN(qt[2794].id, qt[2794].name)
  end
  if qData[2796].state == 0 and qData[2795].state == 2 and GET_PLAYER_LEVEL() >= qt[2796].needLevel then
    ADD_QUEST_BTN(qt[2796].id, qt[2796].name)
  end
  if qData[2799].state == 0 and qData[2798].state == 2 and GET_PLAYER_LEVEL() >= qt[2799].needLevel then
    ADD_QUEST_BTN(qt[2799].id, qt[2799].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1048].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1048].needLevel then
    if qData[1048].state == 1 then
      if qData[1048].killMonster[qt[1048].goal.killMonster[1].id] >= qt[1048].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[1048].state)
      end
    else
      QSTATE(id, qData[1048].state)
    end
  end
  if qData[2679].state ~= 2 and qData[2678].state == 2 and GET_PLAYER_LEVEL() >= qt[2679].needLevel then
    if qData[2679].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2679].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2793].state == 1 and CHECK_ITEM_CNT(qt[2793].goal.getItem[1].id) >= qt[2793].goal.getItem[1].count then
    QSTATE(id, 2)
  end
  if qData[2794].state ~= 2 and qData[2793].state == 2 and GET_PLAYER_LEVEL() >= qt[2794].needLevel then
    if qData[2794].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2795].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2796].state ~= 2 and qData[2795].state == 2 and GET_PLAYER_LEVEL() >= qt[2796].needLevel then
    if qData[2796].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2799].state ~= 2 and qData[2798].state == 2 and GET_PLAYER_LEVEL() >= qt[2799].needLevel then
    if qData[2799].state == 1 then
      if CHECK_ITEM_CNT(qt[2799].goal.getItem[1].id) >= qt[2799].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
