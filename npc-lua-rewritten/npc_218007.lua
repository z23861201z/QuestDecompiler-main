local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4218007 then
    return
  end
  clickNPCid = id
  if qData[576].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[576].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("??? ?? ??? ??? ????!! ??? ????!! ?~ ? ???? ??? ??? ? ??? ?? ? ? ????. ?? ???. ????.")
        SET_QUEST_STATE(576, 2)
        return
      else
        NPC_SAY("??? ? ??? ???")
      end
    else
      NPC_SAY("? ??? ?? ?? ??? ??? ?? {0xFFFFFF00}[???]{END}? {0xFFFFFF00}5?{END}? ????.")
    end
  end
  if qData[576].state == 0 then
    ADD_QUEST_BTN(qt[576].id, qt[576].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[576].state ~= 2 and GET_PLAYER_LEVEL() >= qt[576].needLevel then
    if qData[576].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[576].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
