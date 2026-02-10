function npcsay(id)
  if id ~= 4391010 then
    return
  end
  clickNPCid = id
  NPC_SAY("去异界门帮助正在封印黄泉裂缝的承宪道僧吧。只有我才能把你送到异界门。想去的时候跟我对话吧。")
  if qData[1195].state == 1 then
    NPC_SAY("快去异界门，传话给承宪道僧吧。")
  end
  BTN_HWANGCHUN_ENTER(id)
  if qData[1195].state == 0 then
    ADD_QUEST_BTN(qt[1195].id, qt[1195].name)
  end
  if qData[961].state == 0 then
    ADD_QUEST_BTN(qt[961].id, qt[961].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1195].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1195].needLevel then
    if qData[1195].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
