function npcsay(id)
  if id ~= 4915017 then
    return
  end
  clickNPCid = id
  if qData[155].state == 1 then
    if CHECK_ITEM_CNT(qt[155].goal.getItem[1].id) >= qt[155].goal.getItem[1].count and CHECK_ITEM_CNT(qt[155].goal.getItem[2].id) >= qt[155].goal.getItem[2].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("?? ???~ ??? ?? ????. ????! ?? ?? ?? ?? ?? ? ?? ? ???.")
        SET_QUEST_STATE(155, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("?…. ?? ?? ???? ?? ??. ?? ??? {0xFFFFFF00}???? 10?? ??? 30?{END}? ??????")
    end
  end
  if qData[155].state == 0 and GET_PLAYER_FAME() >= 60 then
    ADD_QUEST_BTN(qt[155].id, qt[155].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
