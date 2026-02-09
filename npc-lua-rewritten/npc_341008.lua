local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4341008 then
    return
  end
  clickNPCid = id
  if qData[2912].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[2912].goal.getItem) then
      NPC_SAY("谢谢！太谢谢了！")
      SET_QUEST_STATE(2912, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}大瀑布{END}击退{0xFFFFFF00}晶石矿工长{END}，作为证据拿回来60个{0xFFFFFF00}断了的镐头把{END}吧。")
    end
  end
  if qData[2912].state == 0 and GET_PLAYER_LEVEL() >= qt[2912].needLevel then
    ADD_QUEST_BTN(qt[2912].id, qt[2912].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2912].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2912].needLevel then
    if qData[2912].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[2912].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
