function npcsay(id)
  if id ~= 4214004 then
    return
  end
  clickNPCid = id
  if qData[1085].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1085].goal.getItem) then
      if CHECK_INVENTORY_CNT(3) > 0 then
        NPC_SAY("真好吃啊！像这样的，你有多少给我拿来多少吧！这是作为对巧克力的报答，希望你能够喜欢，下次再见吧！")
        SET_QUEST_STATE(1085, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("不是说要给我巧克力礼盒的吗？难道只是拿我寻开心的吗？")
    end
  end
  if qData[1093].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1093].goal.getItem) then
      if CHECK_INVENTORY_CNT(3) > 0 then
        NPC_SAY("请收下这些糖吧！哈哈哈~只要你收集足够的材料回来就再给你制作，我就是这样豪爽的人，呵呵~")
        SET_QUEST_STATE(1093, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("是10个糖块，你要的不是糖吗？")
    end
  end
  if qData[1115].state == 1 and qData[1115].meetNpc[1] == qt[1115].goal.meetNpc[1] and qData[1115].meetNpc[2] ~= id and 0 < CHECK_ITEM_CNT(8990012) then
    NPC_SAY("啊！是简讯。谢谢。")
    SET_MEETNPC(1115, 2, id)
  end
  if qData[1118].state == 1 then
    if CHECK_ITEM_CNT(qt[1118].goal.getItem[1].id) >= qt[1118].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。光是想想那些孩子们的笑脸，什么疲劳都消除了。")
        SET_QUEST_STATE(1118, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("干什么呢？快去北清阴平原击退雨伞标收集5个[ 破烂的雨伞 ]回来吧。")
    end
  end
  if qData[1136].state == 1 then
    if CHECK_ITEM_CNT(qt[1136].goal.getItem[1].id) >= qt[1136].goal.getItem[1].count then
      NPC_SAY("谢谢了。正邪间的事端得尽快解决才行啊。")
      SET_QUEST_STATE(1136, 2)
    else
      NPC_SAY("忙呀，真忙！还没找来3个[ 铁块 ]啊。快去北清阴平原击退铜铃眼，收集3个[ 铁块 ]拿来给我吧。")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10004)
  ADD_UPGRADE_ITEM_BTN(id)
  ADD_EQUIP_REFINE_BTN(id)
  ADD_REPAIR_EQUIPMENT(id)
  RARE_BOX_OPEN(id)
  RARE_BOX_MIXTURE(id)
  if qData[1093].state == 0 then
    ADD_QUEST_BTN(qt[1093].id, qt[1093].name)
  end
  if qData[1118].state == 0 then
    ADD_QUEST_BTN(qt[1118].id, qt[1118].name)
  end
  if qData[1136].state == 0 then
    ADD_QUEST_BTN(qt[1136].id, qt[1136].name)
  end
  if qData[901].state == 0 then
    ADD_QUEST_BTN(qt[901].id, qt[901].name)
  end
  if qData[902].state == 0 then
    ADD_QUEST_BTN(qt[902].id, qt[902].name)
  end
  if qData[903].state == 0 then
    ADD_QUEST_BTN(qt[903].id, qt[903].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1085].state == 1 and GET_PLAYER_LEVEL() >= qt[1085].needLevel then
    if __QUEST_HAS_ALL_ITEMS(qt[1085].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  else
    QSTATE(id, 0)
  end
  if qData[1115].state ~= 2 and qData[1115].state == 1 and qData[1115].meetNpc[1] == qt[1115].goal.meetNpc[1] and qData[1115].meetNpc[2] ~= id then
    QSTATE(id, 1)
  end
  if qData[1118].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1118].needLevel then
    if qData[1118].state == 1 then
      if CHECK_ITEM_CNT(qt[1118].goal.getItem[1].id) >= qt[1118].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1136].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1136].needLevel then
    if qData[1136].state == 1 then
      if CHECK_ITEM_CNT(qt[1136].goal.getItem[1].id) >= qt[1136].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
