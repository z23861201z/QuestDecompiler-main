function npcsay(id)
  if id ~= 4391001 then
    return
  end
  clickNPCid = id
  NPC_SAY("选择要挑战的黄泉吧。但，每个黄泉都会审查资格，请注意。")
  if qData[1195].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("什么？发现了奇怪现象…要出事了啊..知道了。辛苦你了。")
      SET_QUEST_STATE(1195, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1502].state == 1 then
    if CHECK_ITEM_CNT(qt[1502].goal.getItem[1].id) >= qt[1502].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("?? ???. ??? ???? ?? ???? ??? ?? ???. {0xFFFFFF00}???? ?? ??? ?? ????? ??. ? ? ?? ??? ?????.{END}")
        SET_QUEST_STATE(1502, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("什么事情啊？这 完了..")
    end
  end
  if qData[3629].state == 1 and CHECK_ITEM_CNT(qt[3629].goal.getItem[1].id) >= qt[3629].goal.getItem[1].count then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("啊，在这样的时期还能送来供米...佛祖定会保佑你的 ")
      SET_QUEST_STATE(3629, 2)
      return
    else
      NPC_SAY("行囊太沉。")
    end
  end
  HELL_ENTER(id)
  INFINITY_DUNGEON_1P(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1195].state ~= 2 and qData[1195].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1502].state == 1 then
    if CHECK_ITEM_CNT(qt[1502].goal.getItem[1].id) >= qt[1502].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[3629].state == 1 and CHECK_ITEM_CNT(qt[3629].goal.getItem[1].id) >= qt[3629].goal.getItem[1].count then
    QSTATE(id, 2)
  end
end
