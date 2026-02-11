function npcsay(id)
  if id ~= 4300166 then
    return
  end
  clickNPCid = id
  if qData[2751].state == 1 then
    if CHECK_ITEM_CNT(qt[2751].goal.getItem[1].id) >= qt[2751].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("哇~太感谢了。我把这个长得像火烈鸟？的武器给你。")
        SET_QUEST_STATE(2751, 2)
        return
      else
        NPC_SAY("行囊太沉")
      end
    else
      NPC_SAY("如果发现了兔娃娃，一定要还给我啊。对来我说是很重要的。如果你帮我找回来的话，就把我手上的...嗯？火烈鸟？武器？这个给你。（不会有谁捡到了后再卖吧？）")
    end
  end
  if qData[2751].state == 0 then
    ADD_QUEST_BTN(qt[2751].id, qt[2751].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2751].state ~= 2 then
    if qData[2751].state == 1 then
      if CHECK_ITEM_CNT(qt[2751].goal.getItem[1].id) >= qt[2751].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
