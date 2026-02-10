function npcsay(id)
  if id ~= 4341005 then
    return
  end
  clickNPCid = id
  if qData[3731].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3731].goal.getItem) then
      NPC_SAY("嗯，数目正确，下次再见吧。")
      SET_QUEST_STATE(3731, 2)
      return
    else
      NPC_SAY("去{0xFFFFFF00}西部边境地带{END}击退{0xFFFFFF00}巨翅鸭嘴兽{END}和{0xFFFFFF00}水灵儿{END}，各收集50个{0xFFFFFF00}巨翅鸭嘴兽的爪形足{END}和{0xFFFFFF00}水灵儿的水滴{END}回来当证据吧。就算少一个也不会给奖励的。")
    end
  end
  if qData[3731].state == 0 and GET_PLAYER_LEVEL() >= qt[3731].needLevel then
    ADD_QUEST_BTN(qt[3731].id, qt[3731].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3731].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3731].needLevel then
    if qData[3731].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3731].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
