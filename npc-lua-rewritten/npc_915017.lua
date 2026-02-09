local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4915017 then
    return
  end
  clickNPCid = id
  if qData[155].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[155].goal.getItem) and __QUEST_CHECK_ITEMS(qt[155].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("?? ???~ ??? ?? ????. ????! ?? ?? ?? ?? ?? ? ?? ? ???.")
        SET_QUEST_STATE(155, 2)
        return
      else
        NPC_SAY("ÐÐÄÒÌ«³Á¡£")
      end
    else
      NPC_SAY("?¡­. ?? ?? ???? ?? ??. ?? ??? {0xFFFFFF00}???? 10?? ??? 30?{END}? ??????")
    end
  end
  if qData[155].state == 0 and GET_PLAYER_FAME() >= 60 then
    ADD_QUEST_BTN(qt[155].id, qt[155].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
