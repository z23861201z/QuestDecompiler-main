local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4314007 then
    return
  end
  clickNPCid = id
  if qData[1116].state == 1 and __QUEST_CHECK_ITEMS(qt[1116].goal.getItem) then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("啊！谢谢。可是你怎么会知道？哞读册吗？这家伙！以为这样我就会答应他和我姐姐交往吗？但是先谢谢少侠了。")
      SET_QUEST_STATE(1116, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1143].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1143].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("终于！可以赶走鸟群了。现在不用担心今年的收成了。哈哈哈，太感谢了。")
        SET_QUEST_STATE(1143, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("触目仔在被清阴平原。快去收集10个[ 触目仔的眼珠 ]回来吧。")
    end
  end
  if qData[1143].state == 0 then
    ADD_QUEST_BTN(qt[1143].id, qt[1143].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1116].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1116].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1143].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1143].needLevel then
    if qData[1143].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[1143].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
