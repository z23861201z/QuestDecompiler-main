function npcsay(id)
  if id ~= 4324013 then
    return
  end
  clickNPCid = id
  if qData[2767].state == 1 and qData[2767].killMonster[qt[2767].goal.killMonster[1].id] >= qt[2767].goal.killMonster[1].count then
    NPC_SAY("(这就是春水糖说的香炉吗...)")
    SET_QUEST_STATE(2767, 2)
  end
  if qData[2768].state == 1 then
    NPC_SAY("(在这里举行祭祀是吧...烧香后鞠个躬吧。)")
  end
  if qData[2771].state == 1 and qData[2771].killMonster[qt[2771].goal.killMonster[1].id] >= qt[2771].goal.killMonster[1].count then
    NPC_SAY("(这就是春水糖说的香炉吗...)")
    SET_QUEST_STATE(2771, 2)
  end
  if qData[2772].state == 1 then
    NPC_SAY("(在这里举行祭祀是吧...烧香后鞠个躬吧。)")
  end
  if SET_PLAYER_SEX() == 1 and qData[2768].state == 0 and qData[2767].state == 2 then
    ADD_QUEST_BTN(qt[2768].id, qt[2768].name)
  end
  if SET_PLAYER_SEX() == 2 and qData[2772].state == 0 and qData[2771].state == 2 then
    ADD_QUEST_BTN(qt[2772].id, qt[2772].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if SET_PLAYER_SEX() == 1 then
    if qData[2767].state == 1 and qData[2767].killMonster[qt[2767].goal.killMonster[1].id] >= qt[2767].goal.killMonster[1].count then
      QSTATE(id, 2)
    end
    if qData[2768].state ~= 2 and qData[2767].state == 2 then
      if qData[2768].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
  end
  if SET_PLAYER_SEX() == 2 then
    if qData[2771].state == 1 and qData[2771].killMonster[qt[2771].goal.killMonster[1].id] >= qt[2771].goal.killMonster[1].count then
      QSTATE(id, 2)
    end
    if qData[2772].state ~= 2 and qData[2771].state == 2 then
      if qData[2772].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
  end
end
