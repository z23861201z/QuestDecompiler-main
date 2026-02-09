local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4341013 then
    return
  end
  clickNPCid = id
  NPC_SAY("受了宰相的命令，当前沉默的神殿是封闭状态。")
  if qData[3730].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[3730].goal.getItem) then
      NPC_SAY("谢谢，太感谢了！")
      SET_QUEST_STATE(3730, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}今天{END}先在{0xFFFFFF00}西部边境地带{END}击退{0xFFFFFF00}地龙守卫{END}，收集50个{0xFFFFFF00}地龙守卫的剑{END}回来吧。")
    end
  end
  if qData[3730].state == 0 and GET_PLAYER_LEVEL() >= qt[3730].needLevel then
    ADD_QUEST_BTN(qt[3730].id, qt[3730].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3730].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3730].needLevel then
    if qData[3730].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[3730].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
