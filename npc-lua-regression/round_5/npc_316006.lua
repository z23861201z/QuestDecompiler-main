function npcsay(id)
  if id ~= 4316006 then
    return
  end
  clickNPCid = id
  if qData[1560].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1560].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("确定都拿来了吗？没有落下的吧？好了。你回去吧。不要再来烦我！（这个人不行。决定不行。完全不可以。绝对不是！）")
        SET_QUEST_STATE(1560, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("嘻嘻嘻，之前看我很不顺眼？击退{0xFFFFFF00}第一阶梯{END}的{0xFFFFFF00}幽灵使者{END}就能获得的{0xFFFFFF00}40个幽灵帽子{END}，就能好好耍耍全体村民了吧？")
      return
    end
  end
  if qData[1559].state == 1 then
    if qData[1559].killMonster[qt[1559].goal.killMonster[1].id] >= qt[1559].goal.killMonster[1].count then
      NPC_SAY("嗯，看起来不像是假话。最近有很多可恶的骗子。")
      SET_QUEST_STATE(1559, 2)
    else
      NPC_SAY("击退{0xFFFFFF00}第一阶梯{END}的{0xFFFFFF00}60个地狱狂牛{END}回来，我就相信你。")
    end
  end
  if qData[284].state == 1 and qData[286].state == 1 then
    if qData[286].killMonster[qt[286].goal.killMonster[1].id] >= qt[286].goal.killMonster[1].count then
      if __QUEST_HAS_ALL_ITEMS(qt[286].goal.getItem) then
        NPC_SAY("呵呵呵 你比我想象的还要有实力啊…火魔石我收下了 呼…")
        SET_QUEST_STATE(286, 2)
      else
        NPC_SAY("快点收集回来{0xFFFFFF00}50个火魔石{END}吧..")
      end
    else
      NPC_SAY("火魔都击退完了吗？")
    end
  end
  if qData[284].state == 1 and qData[287].state == 1 then
    NPC_SAY("去{0xFFFF0000}古乐村哞读册{END}处看看吧")
  end
  if qData[284].state == 1 and qData[290].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[290].goal.getItem) then
      NPC_SAY("回来了？对啊 就是那个~呵呵呵 把书给我吧")
      SET_QUEST_STATE(290, 2)
    else
      NPC_SAY("{0xFFFFFF00}古乐村哞读册{END}没给你什么东西吗？")
    end
  end
  if qData[288].state == 1 then
    if qData[288].killMonster[qt[288].goal.killMonster[1].id] >= qt[288].goal.killMonster[1].count and __QUEST_HAS_ALL_ITEMS(qt[288].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("汗…你竟赢了我啊…本来想那是绝对不可能的事情的…来…在这儿呢…这个书记录了我的所有 呼…没想到会有人知道我的秘密…")
        SET_QUEST_STATE(288, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}90个大穷鬼和90个木材背囊{END}还没完成吗？呼~")
    end
  end
  if qData[483].state == 1 then
    if qData[483].meetNpc[1] == qt[483].goal.meetNpc[1] and qData[483].meetNpc[2] == qt[483].goal.meetNpc[2] then
      if qData[483].meetNpc[3] ~= id and __QUEST_HAS_ALL_ITEMS(qt[483].goal.getItem) then
        if 1 <= CHECK_INVENTORY_CNT(2) then
          SET_MEETNPC(483, 3, id)
          NPC_QSAY(483, 11)
          SET_QUEST_STATE(483, 2)
        else
          NPC_SAY("行囊太沉。")
        end
      end
    else
      NPC_SAY("白斩姬眉毛下面不消失的痣就是说明白斩姬是个多么狡猾的人的证据。快去证明这一点吧。白斩姬在清阴关呢")
    end
  end
  if qData[1907].state == 1 then
    if qData[1907].meetNpc[1] ~= qt[1907].goal.meetNpc[1] then
      NPC_QSAY(1907, 1)
      SET_MEETNPC(1907, 1, id)
      return
    else
      NPC_SAY("你怎么会知道我以前的事情的啊？")
      return
    end
  end
  if qData[1581].state == 1 then
    if qData[1581].meetNpc[1] ~= id and CHECK_ITEM_CNT(8980110) > 0 then
      NPC_QSAY(1581, 1)
      SET_INFO(1581, 2)
      SET_MEETNPC(1581, 1, id)
      return
    else
      NPC_SAY("看来大家都没忘记我这个老婆子，这比收到礼物还要开心啊！")
    end
  end
  if qData[1560].state == 0 and qData[1559].state == 2 and GET_PLAYER_LEVEL() >= qt[1560].needLevel then
    ADD_QUEST_BTN(qt[1560].id, qt[1560].name)
  end
  if qData[1559].state == 0 and qData[1554].state == 1 and GET_PLAYER_LEVEL() >= qt[1559].needLevel then
    ADD_QUEST_BTN(qt[1559].id, qt[1559].name)
  end
  if qData[284].state == 1 and qData[286].state == 0 then
    ADD_QUEST_BTN(qt[286].id, qt[286].name)
  end
  if qData[284].state == 1 and qData[286].state == 2 and qData[287].state == 0 then
    ADD_QUEST_BTN(qt[287].id, qt[287].name)
  end
  if qData[284].state == 1 and qData[287].state == 2 and qData[290].state == 2 and qData[288].state == 0 then
    ADD_QUEST_BTN(qt[288].id, qt[288].name)
  end
  if qData[483].state == 0 then
    ADD_QUEST_BTN(qt[483].id, qt[483].name)
  end
  if GET_PLAYER_JOB2() == 10 then
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1092].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1559].state ~= 2 and qData[1554].state == 1 and GET_PLAYER_LEVEL() >= qt[1559].needLevel then
    if qData[1559].state == 1 then
      if qData[1559].killMonster[qt[1559].goal.killMonster[1].id] >= qt[1559].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1560].state ~= 2 and qData[1559].state == 2 and GET_PLAYER_LEVEL() >= qt[1560].needLevel then
    if qData[1560].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1560].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1581].state == 1 then
    QSTATE(id, 1)
  end
end
