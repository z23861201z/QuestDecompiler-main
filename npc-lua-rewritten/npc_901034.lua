local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4901034 then
    return
  end
  clickNPCid = id
  if qData[111].state == 1 then
    if qData[111].meetNpc[1] ~= qt[111].goal.meetNpc[1] then
      SET_INFO(111, 1)
      NPC_QSAY(111, 1)
      SET_MEETNPC(111, 1, id)
      return
    elseif __QUEST_CHECK_ITEMS(qt[111].goal.getItem) then
      NPC_QSAY(111, 8)
      SET_QUEST_STATE(111, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[??]{END}? ?????? {0xFFFFFF00}15?{END}? ??? ??? ??? ???????.")
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[111].state == 1 and GET_PLAYER_LEVEL() >= qt[111].needLevel and qData[111].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[111].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
end
