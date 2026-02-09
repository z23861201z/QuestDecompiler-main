function npcsay(id)
  if id ~= 4315012 then
    return
  end
  clickNPCid = id
  if qData[109].state == 1 then
    if qData[109].meetNpc[1] ~= qt[109].goal.meetNpc[1] then
      NPC_SAY("不要误会我的话，好好听着~只是觉得仙女的处境很为难，快去{0xFFFFFF00}[樵夫]{END}那儿把衣服拿来吧。")
    elseif qData[109].killMonster[qt[109].goal.killMonster[1].id] >= qt[109].goal.killMonster[1].count then
      NPC_SAY("不要误会我的话，好好听着~只是觉得仙女的处境很为难，快去{0xFFFFFF00}[樵夫]{END}那儿把衣服拿来吧。")
    end
  end
  if qData[107].state == 1 then
    if qData[107].meetNpc[1] == qt[107].goal.meetNpc[1] then
      NPC_SAY("什么啊！说我每天都在偷看仙女！可恶的家伙…要好好教训一下。")
      SET_QUEST_STATE(107, 2)
    else
      NPC_SAY("你问{0xFFFFFF00}[樵夫]{END}在哪儿？是啊..在通往龙林谷的路上见过一次。")
    end
  end
  if qData[107].state == 2 and qData[109].state ~= 1 then
    NPC_SAY("什么啊！说我每天都在偷看仙女！可恶的家伙…要好好教训一下。")
    ADD_NPC_WARP_A(id)
  end
  if qData[1247].state == 1 then
    NPC_SAY("呵呵呵呵呵呵…啊！恩恩…什么事啊？")
    SET_QUEST_STATE(1247, 2)
  end
  if qData[1248].state == 1 then
    if qData[1248].killMonster[qt[1248].goal.killMonster[1].id] >= qt[1248].goal.killMonster[1].count then
      NPC_SAY("啊！这么快就完成了？好吧。虽然烦但约定就是约定…。")
      SET_QUEST_STATE(1248, 2)
    else
      NPC_SAY("击退了{0xFFFFFF00}40只黑熊{END}才能告诉你东泼肉的行踪。")
    end
  end
  if qData[1249].state == 1 then
    NPC_SAY("我能告诉你的就这些。（告诉龙林客栈的南呱湃这消息吧。）")
  end
  if qData[1250].state == 1 then
    NPC_SAY("击退{0xFFFFFF00}龙林谷{END}的{0xFFFFFF00}大菜头{END}收集{0xFFFFFF00}20个电碳{END}拿给{0xFFFFFF00}来坐老板娘{END}吧。")
  end
  if qData[107].state == 0 then
    ADD_QUEST_BTN(qt[107].id, qt[107].name)
  end
  if qData[107].state == 2 and qData[109].state == 0 then
    ADD_QUEST_BTN(qt[109].id, qt[109].name)
  end
  if qData[1248].state == 0 and qData[1247].state == 2 and GET_PLAYER_LEVEL() >= qt[1248].needLevel then
    ADD_QUEST_BTN(qt[1248].id, qt[1248].name)
  end
  if qData[1249].state == 0 and qData[1248].state == 2 and GET_PLAYER_LEVEL() >= qt[1249].needLevel then
    ADD_QUEST_BTN(qt[1249].id, qt[1249].name)
  end
  if qData[1250].state == 0 and qData[1249].state == 2 and GET_PLAYER_LEVEL() >= qt[1250].needLevel then
    ADD_QUEST_BTN(qt[1250].id, qt[1250].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[107].state ~= 2 and GET_PLAYER_LEVEL() >= qt[107].needLevel then
    if qData[107].state == 1 then
      if qData[107].meetNpc[1] == qt[107].goal.meetNpc[1] then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[107].state == 2 and qData[109].state ~= 2 and GET_PLAYER_LEVEL() >= qt[109].needLevel then
    if qData[109].state == 1 then
      if qData[109].killMonster[qt[109].goal.killMonster[1].id] >= qt[109].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1247].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1248].state ~= 2 and qData[1247].state == 2 and GET_PLAYER_LEVEL() >= qt[1248].needLevel then
    if qData[1248].state == 1 then
      if qData[1248].killMonster[qt[1248].goal.killMonster[1].id] >= qt[1248].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1249].state ~= 2 and qData[1248].state == 2 and GET_PLAYER_LEVEL() >= qt[1249].needLevel then
    if qData[1249].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1250].state ~= 2 and qData[1249].state == 2 and GET_PLAYER_LEVEL() >= qt[1250].needLevel then
    if qData[1250].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
