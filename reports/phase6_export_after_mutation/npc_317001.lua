function npcsay(id)
  if id ~= 4317001 then
    return
  end
  clickNPCid = id
  if qData[332].state == 1 then
    if qData[332].killMonster[qt[332].goal.killMonster[1].id] >= qt[332].goal.killMonster[1].count then
      NPC_SAY("?????. ?? ???? ?? ??? ???…")
      SET_QUEST_STATE(332, 2)
      return
    else
      NPC_SAY("??... {0xFFFFFF00}[????] 20??{END}? ????? ???? ?? ?????.")
    end
  end
  if qData[334].state == 1 then
    if qData[334].killMonster[qt[334].goal.killMonster[1].id] >= qt[334].goal.killMonster[1].count then
      NPC_SAY("?? ?????. ?? ?? ?? ?? ??? ???? ?????.")
      SET_QUEST_STATE(334, 2)
    else
      NPC_SAY("?????? ? ? ?????... {0xFFFFFF00}[????]? 15??{END} ??????.")
    end
  end
  if qData[1137].state == 1 and qData[1137].meetNpc[1] == qt[1137].goal.meetNpc[1] and qData[1137].meetNpc[2] == qt[1137].goal.meetNpc[2] and qData[1137].meetNpc[3] ~= id and CHECK_ITEM_CNT(8990012) > 0 then
    NPC_SAY("啊！真的太谢谢了。看到这个真是勇气倍增啊。")
    SET_MEETNPC(1137, 3, id)
  end
  if qData[1152].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("嗯？只有一个人？我是申请了支援兵力的啊！没办法了，先听我说。")
      SET_QUEST_STATE(1152, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1154].state == 1 then
    NPC_SAY("快把功力提升至31级吧。先去找清江银行。")
  end
  if qData[1167].state == 1 then
    if CHECK_ITEM_CNT(qt[1167].goal.getItem[1].id) >= qt[1167].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1167].goal.getItem[2].id) >= qt[1167].goal.getItem[2].count and CHECK_ITEM_CNT(qt[1167].goal.getItem[3].id) >= qt[1167].goal.getItem[3].count then
      NPC_SAY("辛苦了。现在功力快达31了吧？在做些努力吧。")
      SET_QUEST_STATE(1167, 2)
    else
      NPC_SAY("听好了。击退强悍巷道里的怪物，作为证据收集5个[鼠须]，4个[红色胶皮鞋]，3个[车轮残片]回来吧。这些程度应该能让怪物们安分点的。")
    end
  end
  if qData[1172].state == 1 then
    if CHECK_ITEM_CNT(qt[1172].goal.getItem[1].id) >= qt[1172].goal.getItem[1].count then
      NPC_SAY("谢谢…真的很感谢…")
      SET_QUEST_STATE(1172, 2)
    else
      NPC_SAY("为了转给遗属，去帮我收集变成矿工僵尸的我同僚的遗物回来吧。击退矿工僵尸收集20个[破烂的灯]。")
    end
  end
  if qData[1174].state == 1 then
    if qData[1174].killMonster[qt[1174].goal.killMonster[1].id] >= qt[1174].goal.killMonster[1].count then
      NPC_SAY("真，真的击退了猪大长？虽然说是分身，你真的是个了不起的人啊。")
      SET_QUEST_STATE(1174, 2)
    else
      NPC_SAY("去击退1只猪大长吧。应该是在隐藏的强悍巷道里。")
    end
  end
  if qData[1176].state == 1 then
    NPC_SAY("击退强悍巷道里的15只鬼铲之后回到白斩姬那边吧。")
  end
  if qData[1152].state == 2 and qData[1154].state == 0 then
    ADD_QUEST_BTN(qt[1154].id, qt[1154].name)
  end
  if qData[1167].state == 0 then
    ADD_QUEST_BTN(qt[1167].id, qt[1167].name)
  end
  if qData[1167].state == 2 and qData[1172].state == 0 then
    ADD_QUEST_BTN(qt[1172].id, qt[1172].name)
  end
  if qData[1172].state == 2 and qData[1174].state == 0 then
    ADD_QUEST_BTN(qt[1174].id, qt[1174].name)
  end
  if qData[1174].state == 2 and qData[1176].state == 0 then
    ADD_QUEST_BTN(qt[1176].id, qt[1176].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1137].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1137].needLevel and qData[1137].state == 1 and qData[1137].meetNpc[1] == qt[1137].goal.meetNpc[1] and qData[1137].meetNpc[2] == qt[1137].goal.meetNpc[2] and qData[1137].meetNpc[3] ~= id then
    QSTATE(id, 1)
  end
  if qData[1150].state == 2 and qData[1152].state ~= 2 and qData[1152].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1152].state == 2 and qData[1154].state ~= 2 then
    if qData[1154].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1167].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1167].needLevel then
    if qData[1167].state == 1 then
      if CHECK_ITEM_CNT(qt[1167].goal.getItem[1].id) >= qt[1167].goal.getItem[1].count and CHECK_ITEM_CNT(qt[1167].goal.getItem[2].id) >= qt[1167].goal.getItem[2].count and CHECK_ITEM_CNT(qt[1167].goal.getItem[3].id) >= qt[1167].goal.getItem[3].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1167].state == 2 and qData[1172].state ~= 2 then
    if qData[1172].state == 1 then
      if CHECK_ITEM_CNT(qt[1172].goal.getItem[1].id) >= qt[1172].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1172].state == 2 and qData[1174].state ~= 2 then
    if qData[1174].state == 1 then
      if qData[1174].killMonster[qt[1174].goal.killMonster[1].id] >= qt[1174].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1174].state == 2 and qData[1176].state ~= 2 then
    if qData[1176].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
