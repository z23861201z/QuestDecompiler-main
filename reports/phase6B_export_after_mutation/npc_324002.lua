function npcsay(id)
  if id ~= 4324002 then
    return
  end
  clickNPCid = id
  NPC_SAY("去中原吧…在那里寻找太和老君和他的弟子拯救世界并正确的引导魔教…")
  if qData[1528].state == 1 then
    NPC_SAY("卡啊…是我太大意了…")
    SET_QUEST_STATE(1528, 2)
    return
  end
  if qData[1529].state == 1 then
    NPC_SAY("卡啊…是我太大意了…")
    SET_QUEST_STATE(1529, 2)
    return
  end
  if qData[1513].state == 1 then
    NPC_SAY("啊…听着…不是所有的魔教都是敌人…其他的长老才是你的敌人…")
    SET_QUEST_STATE(1513, 2)
  end
  if qData[1514].state == 1 then
    NPC_SAY("啊…听着…不是所有的魔教都是敌人…其他的长老才是你的敌人…")
    SET_QUEST_STATE(1514, 2)
  end
  if qData[1515].state == 1 then
    NPC_SAY("（师傅的尸体已经凉透了。得按照师傅的遗言快速去{0xFFFFFF00}龙林客栈{END}找{0xFFFFFF00}魔教使徒{END}）")
    return
  end
  if qData[1516].state == 1 then
    NPC_SAY("（父亲的尸体已经凉透了。得按照父亲的遗言快速去{0xFFFFFF00}龙林客栈{END}找{0xFFFFFF00}魔教使徒{END}）")
    return
  end
  if qData[1513].state == 0 and SET_PLAYER_SEX() == 1 and GET_PLAYER_JOB1() <= 7 then
    ADD_QUEST_BTN(qt[1513].id, qt[1513].name)
  end
  if qData[1514].state == 0 and SET_PLAYER_SEX() == 2 and GET_PLAYER_JOB1() <= 7 then
    ADD_QUEST_BTN(qt[1514].id, qt[1514].name)
  end
  if qData[1515].state == 0 and qData[1513].state == 2 and SET_PLAYER_SEX() == 1 then
    ADD_QUEST_BTN(qt[1515].id, qt[1515].name)
  end
  if qData[1516].state == 0 and qData[1514].state == 2 and SET_PLAYER_SEX() == 2 then
    ADD_QUEST_BTN(qt[1516].id, qt[1516].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1528].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1529].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1513].state ~= 2 and qData[1528].state == 2 and GET_PLAYER_JOB1() <= 7 then
    if qData[1513].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1514].state ~= 2 and qData[1529].state == 2 and GET_PLAYER_JOB1() <= 7 then
    if qData[1514].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1515].state ~= 2 and qData[1513].state == 2 then
    if qData[1515].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1516].state ~= 2 and qData[1514].state == 2 then
    if qData[1516].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
