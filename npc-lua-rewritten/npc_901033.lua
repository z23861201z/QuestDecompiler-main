local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4901033 then
    return
  end
  clickNPCid = id
  if qData[107].state == 1 then
    if qData[107].meetNpc[1] ~= qt[107].goal.meetNpc[1] then
      SET_INFO(107, 1)
      NPC_QSAY(107, 1)
      SET_MEETNPC(107, 1, id)
      return
    else
      NPC_SAY("去找{0xFFFFFF00}[ 土地公 ]{END}，告诉他不要在偷看了。")
    end
  end
  if qData[109].state == 1 then
    if qData[109].meetNpc[1] ~= qt[109].goal.meetNpc[1] then
      SET_INFO(109, 1)
      NPC_QSAY(109, 1)
      SET_MEETNPC(109, 1, id)
      return
    elseif qData[109].killMonster[qt[109].goal.killMonster[1].id] >= qt[109].goal.killMonster[1].count then
      NPC_QSAY(109, 6)
      SET_QUEST_STATE(109, 2)
    else
      NPC_SAY("帮忙封印{0xFFFFFF00}20只{END}{0xFFFFFF00}[ 桶装黄鼠狼 ]{END} 吧。")
    end
  end
  if qData[1245].state == 1 and __QUEST_CHECK_ITEMS(qt[1245].goal.getItem) then
    NPC_SAY("谢谢。正好我正在担心母亲的…。")
    SET_QUEST_STATE(1245, 2)
  end
  if qData[1246].state == 1 then
    NPC_SAY("击退{0xFFFFFF00}龙林山的黑熊{END}，获得{0xFFFFFF00}20个熊胆{END}拿给{0xFFFFFF00}受伤的鹿{END}。")
  end
  if qData[1246].state == 0 and qData[1245].state == 2 and GET_PLAYER_LEVEL() >= qt[1246].needLevel then
    ADD_QUEST_BTN(qt[1246].id, qt[1246].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[107].state == 1 and GET_PLAYER_LEVEL() >= qt[107].needLevel then
    QSTATE(id, 1)
  end
  if qData[109].state == 1 and GET_PLAYER_LEVEL() >= qt[107].needLevel then
    if qData[109].killMonster[qt[109].goal.killMonster[1].id] >= qt[109].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1245].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1245].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1246].state == 0 and qData[1245].state == 2 and GET_PLAYER_LEVEL() >= qt[1246].needLevel then
    if qData[1246].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
