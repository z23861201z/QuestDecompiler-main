function npcsay(id)
  if id ~= 4341019 then
    return
  end
  clickNPCid = id
  NPC_SAY("嗯，好无聊啊…")
  if qData[2720].state == 1 then
    if qData[2720].meetNpc[1] == qt[2720].goal.meetNpc[1] and qData[2720].meetNpc[2] ~= id and __QUEST_HAS_ALL_ITEMS(qt[2720].goal.getItem) then
      NPC_SAY("哈哈！这就是{0xFFFFFF00}地龙的舌头佳肴{END}啊？我来尝一下~呕！！呸呸！！这到底是什么味道啊！！！！！剩下的你都吃了吧！！")
      SET_MEETNPC(2720, 2, id)
      SET_QUEST_STATE(2720, 2)
      return
    else
      NPC_SAY("不知道~听说是新来的料理师...总之那个料理师研发出了{0xFFFFFF00}地龙的舌头佳肴{END}，你去收集30个{0xFFFFFF00}地龙的舌头{END}，制作成料理拿来给我吧。")
    end
  end
  if qData[2906].state == 1 then
    NPC_SAY("还~没~走~吗~？在{0xFFFFFF00}大瀑布{END}击退{0xFFFFFF00}多足怪虫{END}，收集10个{0xFFFFFF00}多足怪虫的脚{END}就可以。一定要记得送去给东方料理王飞燕。")
    return
  end
  if qData[2720].state == 0 and GET_PLAYER_LEVEL() >= qt[2720].needLevel then
    ADD_QUEST_BTN(qt[2720].id, qt[2720].name)
  end
  if qData[2906].state == 0 and GET_PLAYER_LEVEL() >= qt[2906].needLevel then
    ADD_QUEST_BTN(qt[2906].id, qt[2906].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2720].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2720].needLevel then
    if qData[2720].state == 1 then
      if qData[2720].meetNpc[1] == qt[2720].goal.meetNpc[1] and qData[2720].meetNpc[2] ~= id and __QUEST_HAS_ALL_ITEMS(qt[2720].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2906].state ~= 2 and qData[2906].state == 2 then
    if qData[2906].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
