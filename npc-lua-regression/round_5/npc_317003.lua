function npcsay(id)
  if id ~= 4317003 then
    return
  end
  clickNPCid = id
  if qData[333].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[333].goal.getItem) then
      NPC_SAY("谢谢了。托PLAYERNAME的福可以顺利的祭祀了。这是我的诚意，请收下吧…")
      SET_QUEST_STATE(333, 2)
    else
      NPC_SAY("得快点祭祀…8个[蓝色的灯油]还没收集完吗？")
    end
  end
  if qData[1137].state == 1 and qData[1137].meetNpc[1] ~= id and CHECK_ITEM_CNT(8990012) > 0 then
    NPC_SAY("啊！真的太谢谢了。看到这个真是勇气倍增啊。")
    SET_MEETNPC(1137, 1, id)
  end
  if qData[1170].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1170].goal.getItem) then
      NPC_SAY("谢谢了。托PLAYERNAME的福可以顺利的祭祀了。这是我的诚意，请收下吧…")
      SET_QUEST_STATE(1170, 2)
    else
      NPC_SAY("得快点祭祀…10个[蓝色的灯油]还没收集完吗？蓝色大菜头在强悍巷道里。")
    end
  end
  if qData[1170].state == 0 then
    ADD_QUEST_BTN(qt[1170].id, qt[1170].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1137].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1137].needLevel and qData[1137].state == 1 and qData[1137].meetNpc[1] ~= id then
    QSTATE(id, 1)
  end
  if qData[1170].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1170].needLevel then
    if qData[1170].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1170].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
