function npcsay(id)
  if id ~= 4322014 then
    return
  end
  clickNPCid = id
  NPC_SAY("久违的阳光...")
  if qData[2733].state == 1 then
    NPC_SAY("你来这里是有什么事吗？什么？问我知不知道{0xFFFFFF00}獐子潭{END}？")
    SET_QUEST_STATE(2733, 2)
    return
  end
  if qData[2734].state == 1 then
    NPC_SAY("{0xFFFFFF00}獐子潭洞穴[1]{END}里有很强的怪物。请一定要小心。那个人的名字叫{0xFFFFFF00}辛巴达{END}。")
  end
  if qData[2736].state == 1 then
    NPC_SAY("在{0xFFFFFF00}干涸的沼泽{END}击退70个{0xFFFFFF00}志鬼心火{END}后，去找{0xFFFFFF00}巨木重林中心地{END}的{0xFFFFFF00}[巨木守护者]{END}吧。")
  end
  if qData[2813].state == 1 then
    NPC_SAY("原来攻击怪物们后方的人是{0xFF99ff99}PLAYERNAME{END}啊！真的很感谢。")
    SET_QUEST_STATE(2813, 2)
    return
  end
  if qData[2814].state == 1 then
    NPC_SAY("在{0xFFFFFF00}獐子潭洞穴[1]{END}击退30个{0xFFFFFF00}原虫{END}后，去{0xFFFFFF00}银行员辛巴达{END}那儿吧。")
  end
  if qData[2815].state == 1 then
    NPC_SAY("这么快就回来了啊。那{0xFFFFFF00}奇怪的纸条{END}到底是什么啊？")
    SET_QUEST_STATE(2815, 2)
    return
  end
  if qData[2816].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2816].goal.getItem) then
      NPC_SAY("辛苦了。收集纸条来确认一下有什么样的内容吧。")
      SET_QUEST_STATE(2816, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}边击退{0xFFFFFF00}原虫{END}，边收集30个{0xFFFFFF00}春水糖的纸条{END}后，去找{0xFFFFFF00}[封印之石]{END}的{0xFFFFFF00}[菊花碴]{END}吧。")
    end
  end
  if qData[2817].state == 1 then
    NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}找找{0xFFFFFF00}春水糖的住处{END}吧。")
  end
  if qData[2818].state == 1 then
    NPC_SAY("找到什么东西了吗？")
    SET_QUEST_STATE(2818, 2)
    return
  end
  if qData[2819].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2819].goal.getItem) then
      NPC_SAY("我们快点拼一下看看吧。")
      SET_QUEST_STATE(2819, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}击退{0xFFFFFF00}曲怪人{END}，收集10个{0xFFFFFF00}春水糖的日志{END}回来吧。")
    end
  end
  if qData[2820].state == 1 then
    NPC_SAY("{0xFFFFFF00}银行员辛巴达{END}在{0xFFFFFF00}獐子潭洞穴[1]{END}。")
  end
  if qData[2734].state == 0 and qData[2733].state == 2 and GET_PLAYER_LEVEL() >= qt[2734].needLevel then
    ADD_QUEST_BTN(qt[2734].id, qt[2734].name)
  end
  if qData[2736].state == 0 and qData[2735].state == 2 and GET_PLAYER_LEVEL() >= qt[2736].needLevel then
    ADD_QUEST_BTN(qt[2736].id, qt[2736].name)
  end
  if qData[2814].state == 0 and qData[2813].state == 2 and GET_PLAYER_LEVEL() >= qt[2814].needLevel then
    ADD_QUEST_BTN(qt[2814].id, qt[2814].name)
  end
  if qData[2816].state == 0 and qData[2815].state == 2 and GET_PLAYER_LEVEL() >= qt[2816].needLevel then
    ADD_QUEST_BTN(qt[2816].id, qt[2816].name)
  end
  if qData[2817].state == 0 and qData[2816].state == 2 and GET_PLAYER_LEVEL() >= qt[2817].needLevel then
    ADD_QUEST_BTN(qt[2817].id, qt[2817].name)
  end
  if qData[2819].state == 0 and qData[2818].state == 2 and GET_PLAYER_LEVEL() >= qt[2819].needLevel then
    ADD_QUEST_BTN(qt[2819].id, qt[2819].name)
  end
  if qData[2820].state == 0 and qData[2819].state == 2 and GET_PLAYER_LEVEL() >= qt[2820].needLevel then
    ADD_QUEST_BTN(qt[2820].id, qt[2820].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2733].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2734].state ~= 2 and qData[2733].state == 2 and GET_PLAYER_LEVEL() >= qt[2734].needLevel then
    if qData[2734].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2736].state ~= 2 and qData[2735].state == 2 and GET_PLAYER_LEVEL() >= qt[2736].needLevel then
    if qData[2736].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2813].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2813].needLevel then
    if qData[2813].state == 1 then
      if qData[2813].killMonster[qt[2813].goal.killMonster[1].id] >= qt[2813].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2814].state ~= 2 and qData[2813].state == 2 and GET_PLAYER_LEVEL() >= qt[2814].needLevel then
    if qData[2814].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2815].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2816].state ~= 2 and qData[2815].state == 2 and GET_PLAYER_LEVEL() >= qt[2816].needLevel then
    if qData[2816].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2816].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2817].state ~= 2 and qData[2816].state == 2 and GET_PLAYER_LEVEL() >= qt[2817].needLevel then
    if qData[2817].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2818].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2819].state ~= 2 and qData[2814].state == 2 and GET_PLAYER_LEVEL() >= qt[2819].needLevel then
    if qData[2819].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2819].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2820].state ~= 2 and qData[2819].state == 2 and GET_PLAYER_LEVEL() >= qt[2820].needLevel then
    if qData[2820].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
