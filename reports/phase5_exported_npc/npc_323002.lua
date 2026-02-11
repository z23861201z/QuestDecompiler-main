function npcsay(id)
  if id ~= 4323002 then
    return
  end
  NPC_SAY("不是不知道大家的心…。那我的梦想会变成什么样呢？")
  clickNPCid = id
  if qData[2597].state == 1 then
    if qData[2597].killMonster[qt[2597].goal.killMonster[1].id] >= qt[2597].goal.killMonster[1].count then
      NPC_SAY("谢谢。这是我为你准备的小小礼物。")
      SET_QUEST_STATE(2597, 2)
      return
    else
      NPC_SAY("帮我击退黑色丘陵的{0xFFFFFF00}100个[恶灵巫师]{END}吧。趁数量还没增多之前，得赶紧处理。")
    end
  end
  if qData[2891].state == 1 then
    NPC_SAY("哦哦，见到你很高兴。我是安哥拉王国的法定继承人{0xFFFFFF00}安哥拉大世子{END}。")
    SET_QUEST_STATE(2891, 2)
    return
  end
  if qData[2892].state == 1 then
    if qData[2892].killMonster[qt[2892].goal.killMonster[1].id] >= qt[2892].goal.killMonster[1].count then
      NPC_SAY("哇，这么快就回来了？{0xFFFFFF00}甲山女鬼{END}是什么样的怪物啊？")
      SET_QUEST_STATE(2892, 2)
      return
    else
      NPC_SAY("知己知彼百战不殆，击退30个{0xFFFFFF00}吕墩平原{END}的{0xFFFFFF00}甲山女鬼{END}后回到{0xFFFFFF00}[安哥拉大世子]{END}处吧。")
    end
  end
  if qData[2893].state == 1 then
    if qData[2893].killMonster[qt[2893].goal.killMonster[1].id] >= qt[2893].goal.killMonster[1].count then
      NPC_SAY("哇，这么快就回来了？{0xFFFFFF00}狂豚魔人{END}是什么样的怪物啊？")
      SET_QUEST_STATE(2893, 2)
      return
    else
      NPC_SAY("知己知彼，百战不殆。击退30个{0xFFFFFF00}吕墩平原{END}的{0xFFFFFF00}狂豚魔人{END}后回来吧。")
    end
  end
  if qData[2894].state == 1 then
    if qData[2894].killMonster[qt[2894].goal.killMonster[1].id] >= qt[2894].goal.killMonster[1].count then
      NPC_SAY("哇，这么快就回来了？{0xFFFFFF00}咸兴魔灵{END}是什么样的怪物啊？")
      SET_QUEST_STATE(2894, 2)
      return
    else
      NPC_SAY("知己知彼，百战不殆。击退30个{0xFFFFFF00}吕墩平原{END}的{0xFFFFFF00}咸兴魔灵{END}后回来吧。")
    end
  end
  if qData[2895].state == 1 then
    if qData[2895].killMonster[qt[2895].goal.killMonster[1].id] >= qt[2895].goal.killMonster[1].count then
      NPC_SAY("哇，这么快就回来了？{0xFFFFFF00}马面人鬼{END}是什么样的怪物啊？")
      SET_QUEST_STATE(2895, 2)
      return
    else
      NPC_SAY("知己知彼，百战不殆。击退30个{0xFFFFFF00}吕墩平原{END}的{0xFFFFFF00}马面人鬼{END}后回来吧。")
    end
  end
  if qData[2896].state == 1 then
    NPC_SAY("达到{0xFFFFFF00}175功力{END}后再来找我吧。")
    SET_QUEST_STATE(2896, 2)
    return
  end
  if qData[2597].state == 0 and GET_PLAYER_LEVEL() >= qt[2597].needLevel then
    ADD_QUEST_BTN(qt[2597].id, qt[2597].name)
  end
  if qData[2892].state == 0 and qData[2891].state == 2 and GET_PLAYER_LEVEL() >= qt[2892].needLevel then
    ADD_QUEST_BTN(qt[2892].id, qt[2892].name)
  end
  if qData[2893].state == 0 and qData[2892].state == 2 and GET_PLAYER_LEVEL() >= qt[2893].needLevel then
    ADD_QUEST_BTN(qt[2893].id, qt[2893].name)
  end
  if qData[2894].state == 0 and qData[2893].state == 2 and GET_PLAYER_LEVEL() >= qt[2894].needLevel then
    ADD_QUEST_BTN(qt[2894].id, qt[2894].name)
  end
  if qData[2895].state == 0 and qData[2894].state == 2 and GET_PLAYER_LEVEL() >= qt[2895].needLevel then
    ADD_QUEST_BTN(qt[2895].id, qt[2895].name)
  end
  if qData[2896].state == 0 and qData[2895].state == 2 and GET_PLAYER_LEVEL() >= qt[2896].needLevel then
    ADD_QUEST_BTN(qt[2896].id, qt[2896].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2597].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2597].needLevel then
    if qData[2597].state == 1 then
      if qData[2597].killMonster[qt[2597].goal.killMonster[1].id] >= qt[2597].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2891].state ~= 2 and qData[2890].state == 2 and GET_PLAYER_LEVEL() >= qt[2891].needLevel and qData[2891].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2892].state ~= 2 and qData[2891].state == 2 and GET_PLAYER_LEVEL() >= qt[2892].needLevel then
    if qData[2892].state == 1 then
      if qData[2892].killMonster[qt[2892].goal.killMonster[1].id] >= qt[2892].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2893].state ~= 2 and qData[2892].state == 2 and GET_PLAYER_LEVEL() >= qt[2893].needLevel then
    if qData[2893].state == 1 then
      if qData[2893].killMonster[qt[2893].goal.killMonster[1].id] >= qt[2893].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2894].state ~= 2 and qData[2893].state == 2 and GET_PLAYER_LEVEL() >= qt[2894].needLevel then
    if qData[2894].state == 1 then
      if qData[2894].killMonster[qt[2894].goal.killMonster[1].id] >= qt[2894].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2895].state ~= 2 and qData[2894].state == 2 and GET_PLAYER_LEVEL() >= qt[2895].needLevel then
    if qData[2895].state == 1 then
      if qData[2895].killMonster[qt[2895].goal.killMonster[1].id] >= qt[2895].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2896].state ~= 2 and qData[2895].state == 2 and GET_PLAYER_LEVEL() >= qt[2896].needLevel then
    if qData[2896].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
end
