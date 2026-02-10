function npcsay(id)
  if id ~= 4324012 then
    return
  end
  clickNPCid = id
  NPC_SAY("")
  if qData[2765].state == 1 then
    if qData[2765].killMonster[qt[2765].goal.killMonster[1].id] >= qt[2765].goal.killMonster[1].count then
      NPC_SAY("很好，你合格了。进行下一步吧。")
      SET_QUEST_STATE(2765, 2)
    else
      NPC_SAY("在深处[1]净化3个木棉怪后回来吧。")
    end
  end
  if qData[2766].state == 1 then
    if qData[2766].killMonster[qt[2766].goal.killMonster[1].id] >= qt[2766].goal.killMonster[1].count then
      NPC_SAY("很好，你合格了。进行下一步吧。")
      SET_QUEST_STATE(2766, 2)
    else
      NPC_SAY("去深处[2]净化5个光辉令后回来吧。")
    end
  end
  if qData[2767].state == 1 then
    NPC_SAY("去神殿里面击退5个异教徒祭司长，然后去祭坛燃烧香炉后回来吧。")
  end
  if qData[2769].state == 1 then
    if qData[2769].killMonster[qt[2769].goal.killMonster[1].id] >= qt[2769].goal.killMonster[1].count then
      NPC_SAY("很好，你合格了。进行下一步吧。")
      SET_QUEST_STATE(2769, 2)
    else
      NPC_SAY("在深处[1]净化3个木棉怪后回来吧。")
    end
  end
  if qData[2770].state == 1 then
    if qData[2770].killMonster[qt[2770].goal.killMonster[1].id] >= qt[2770].goal.killMonster[1].count then
      NPC_SAY("很好，你合格了。进行下一步吧。")
      SET_QUEST_STATE(2770, 2)
    else
      NPC_SAY("去深处[2]净化5个光辉令后回来吧。")
    end
  end
  if qData[2771].state == 1 then
    NPC_SAY("去神殿里面击退5个异教徒祭司长，然后去祭坛燃烧香炉后回来吧。")
  end
  if qData[2765].state == 1 or qData[2769].state == 1 then
    NPC_WARP_SILENCE_TEMPLE1(id)
  end
  if qData[2766].state == 1 or qData[2770].state == 1 then
    NPC_WARP_SILENCE_TEMPLE2(id)
  end
  if qData[2767].state == 1 or qData[2771].state == 1 then
    NPC_WARP_SILENCE_TEMPLE3(id)
  end
  if qData[2767].state == 2 or qData[2771].state == 2 then
    NPC_WARP_SILENCE_TEMPLE4(id)
  end
  if SET_PLAYER_SEX() == 1 then
    if qData[2765].state == 0 then
      ADD_QUEST_BTN(qt[2765].id, qt[2765].name)
    end
    if qData[2766].state == 0 and qData[2765].state == 2 then
      ADD_QUEST_BTN(qt[2766].id, qt[2766].name)
    end
    if qData[2767].state == 0 and qData[2766].state == 2 then
      ADD_QUEST_BTN(qt[2767].id, qt[2767].name)
    end
  end
  if SET_PLAYER_SEX() == 2 then
    if qData[2769].state == 0 then
      ADD_QUEST_BTN(qt[2769].id, qt[2769].name)
    end
    if qData[2770].state == 0 and qData[2769].state == 2 then
      ADD_QUEST_BTN(qt[2770].id, qt[2770].name)
    end
    if qData[2771].state == 0 and qData[2770].state == 2 then
      ADD_QUEST_BTN(qt[2771].id, qt[2771].name)
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if SET_PLAYER_SEX() == 1 then
    if qData[2765].state ~= 2 then
      if qData[2765].state == 1 then
        if qData[2765].killMonster[qt[2765].goal.killMonster[1].id] >= qt[2765].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[2766].state ~= 2 and qData[2765].state == 2 then
      if qData[2766].state == 1 then
        if qData[2766].killMonster[qt[2766].goal.killMonster[1].id] >= qt[2766].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[2767].state ~= 2 and qData[2766].state == 2 then
      if qData[2767].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
  end
  if SET_PLAYER_SEX() == 2 then
    if qData[2769].state ~= 2 then
      if qData[2769].state == 1 then
        if qData[2769].killMonster[qt[2769].goal.killMonster[1].id] >= qt[2769].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[2770].state ~= 2 and qData[2769].state == 2 then
      if qData[2770].state == 1 then
        if qData[2770].killMonster[qt[2770].goal.killMonster[1].id] >= qt[2770].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[2771].state ~= 2 and qData[2770].state == 2 then
      if qData[2771].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
  end
end
