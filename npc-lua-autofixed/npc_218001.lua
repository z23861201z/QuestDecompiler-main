function npcsay(id)
  if id ~= 4218001 then
    return
  end
  clickNPCid = id
  if qData[1288].state == 1 then
    NPC_SAY("你看起来不像是患者，何故来到这简陋的地方啊？")
    SET_QUEST_STATE(1288, 2)
    return
  end
  if qData[1289].state == 1 then
    NPC_SAY("给兰霉匠军队营地的皇宫武士柳江传达皇宫圣旨，并拿到假皇宫圣旨给沈叶浪送去。")
  end
  ADD_NEW_SHOP_BTN(id, 10022)
  if qData[1289].state == 0 and qData[1288].state == 2 and GET_PLAYER_LEVEL() >= qt[1289].needLevel then
    ADD_QUEST_BTN(qt[1289].id, qt[1289].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1288].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1289].state ~= 2 and qData[1288].state == 2 and GET_PLAYER_LEVEL() >= qt[1289].needLevel then
    if qData[1289].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
