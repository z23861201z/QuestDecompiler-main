function npcsay(id)
  if id ~= 4324006 then
    return
  end
  clickNPCid = id
  NPC_SAY("策士很强大!")
  if qData[2258].state == 1 then
    if qData[2258].killMonster[qt[2258].goal.killMonster[1].id] >= qt[2258].goal.killMonster[1].count then
      NPC_SAY("将复仇的刀刃高高举起！胜利是属于我们的!")
      SET_QUEST_STATE(2258, 2)
    else
      NPC_SAY("准备好了就去{0xFFFFFF00}沉默的神殿深处1{END}击退{0xFFFFFF00}3个木棉怪{END}后回来吧")
    end
  end
  if qData[2259].state == 1 then
    if qData[2259].killMonster[qt[2259].goal.killMonster[1].id] >= qt[2259].goal.killMonster[1].count then
      NPC_SAY("将复仇的刀刃高高举起！胜利是属于我们的!")
      SET_QUEST_STATE(2259, 2)
    else
      NPC_SAY("准备好了就去{0xFFFFFF00}沉默的神殿深处2{END}击退{0xFFFFFF00}5个光辉令{END}后回来吧")
    end
  end
  if qData[2260].state == 1 then
    if qData[2260].killMonster[qt[2260].goal.killMonster[1].id] >= qt[2260].goal.killMonster[1].count then
      NPC_SAY("将复仇的刀刃高高举起！胜利是属于我们的!")
      SET_QUEST_STATE(2260, 2)
    else
      NPC_SAY("准备好了就去{0xFFFFFF00}沉默的神殿深处3{END}击退 {0xFFFFFF00}5个异教徒祭司长{END}后回来吧")
    end
  end
  if qData[2261].state == 1 then
    NPC_SAY("到底是谁敢在策士的补给品中动手脚？！")
    return
  end
  if qData[2263].state == 1 then
    if qData[2263].killMonster[qt[2263].goal.killMonster[1].id] >= qt[2263].goal.killMonster[1].count then
      NPC_SAY("将复仇的刀刃高高举起！胜利是属于我们的!")
      SET_QUEST_STATE(2263, 2)
    else
      NPC_SAY("准备好了就去{0xFFFFFF00}沉默的神殿深处1{END}击退{0xFFFFFF00}3个木棉怪{END}后回来吧")
    end
  end
  if qData[2264].state == 1 then
    if qData[2264].killMonster[qt[2264].goal.killMonster[1].id] >= qt[2264].goal.killMonster[1].count then
      NPC_SAY("将复仇的刀刃高高举起！胜利是属于我们的!")
      SET_QUEST_STATE(2264, 2)
    else
      NPC_SAY("准备好了就去{0xFFFFFF00}沉默的神殿深处2{END}击退{0xFFFFFF00}5个光辉令{END}后回来吧")
    end
  end
  if qData[2265].state == 1 then
    if qData[2265].killMonster[qt[2265].goal.killMonster[1].id] >= qt[2265].goal.killMonster[1].count then
      NPC_SAY("将复仇的刀刃高高举起！胜利是属于我们的!")
      SET_QUEST_STATE(2265, 2)
    else
      NPC_SAY("准备好了就去{0xFFFFFF00}沉默的神殿深处3{END}击退 {0xFFFFFF00}5个异教徒祭司长{END}后回来吧")
    end
  end
  if qData[2266].state == 1 then
    NPC_SAY("到底是谁敢在策士的补给品中动手脚？！")
    return
  end
  if qData[2258].state == 1 then
    NPC_WARP_SILENCE_TEMPLE1(id)
  end
  if qData[2259].state == 1 then
    NPC_WARP_SILENCE_TEMPLE2(id)
  end
  if qData[2260].state == 1 then
    NPC_WARP_SILENCE_TEMPLE3(id)
  end
  if qData[2263].state == 1 then
    NPC_WARP_SILENCE_TEMPLE1(id)
  end
  if qData[2264].state == 1 then
    NPC_WARP_SILENCE_TEMPLE2(id)
  end
  if qData[2265].state == 1 then
    NPC_WARP_SILENCE_TEMPLE3(id)
  end
  if qData[2258].state == 0 and SET_PLAYER_SEX() == 1 and GET_PLAYER_JOB1() == 10 then
    ADD_QUEST_BTN(qt[2258].id, qt[2258].name)
  end
  if qData[2259].state == 0 and qData[2258].state == 2 and SET_PLAYER_SEX() == 1 then
    ADD_QUEST_BTN(qt[2259].id, qt[2259].name)
  end
  if qData[2260].state == 0 and qData[2259].state == 2 and SET_PLAYER_SEX() == 1 then
    ADD_QUEST_BTN(qt[2260].id, qt[2260].name)
  end
  if qData[2261].state == 0 and qData[2260].state == 2 and SET_PLAYER_SEX() == 1 then
    ADD_QUEST_BTN(qt[2261].id, qt[2261].name)
  end
  if qData[2263].state == 0 and SET_PLAYER_SEX() == 2 and GET_PLAYER_JOB1() == 10 then
    ADD_QUEST_BTN(qt[2263].id, qt[2263].name)
  end
  if qData[2264].state == 0 and qData[2263].state == 2 and SET_PLAYER_SEX() == 2 then
    ADD_QUEST_BTN(qt[2264].id, qt[2264].name)
  end
  if qData[2265].state == 0 and qData[2264].state == 2 and SET_PLAYER_SEX() == 2 then
    ADD_QUEST_BTN(qt[2265].id, qt[2265].name)
  end
  if qData[2266].state == 0 and qData[2265].state == 2 and SET_PLAYER_SEX() == 2 then
    ADD_QUEST_BTN(qt[2266].id, qt[2266].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2258].state ~= 2 and SET_PLAYER_SEX() == 1 and GET_PLAYER_JOB1() <= 10 then
    if qData[2258].state == 1 then
      if qData[2258].killMonster[qt[2258].goal.killMonster[1].id] >= qt[2258].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2259].state ~= 2 and qData[2258].state == 2 then
    if qData[2259].state == 1 then
      if qData[2259].killMonster[qt[2259].goal.killMonster[1].id] >= qt[2259].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2260].state ~= 2 and qData[2259].state == 2 then
    if qData[2260].state == 1 then
      if qData[2260].killMonster[qt[2260].goal.killMonster[1].id] >= qt[2260].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2261].state ~= 2 and qData[2260].state == 2 then
    if qData[2261].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2263].state ~= 2 and SET_PLAYER_SEX() == 2 and GET_PLAYER_JOB1() <= 10 then
    if qData[2263].state == 1 then
      if qData[2263].killMonster[qt[2263].goal.killMonster[1].id] >= qt[2263].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2264].state ~= 2 and qData[2263].state == 2 then
    if qData[2264].state == 1 then
      if qData[2264].killMonster[qt[2264].goal.killMonster[1].id] >= qt[2264].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2265].state ~= 2 and qData[2264].state == 2 then
    if qData[2265].state == 1 then
      if qData[2265].killMonster[qt[2265].goal.killMonster[1].id] >= qt[2265].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2266].state ~= 2 and qData[2265].state == 2 then
    if qData[2266].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
