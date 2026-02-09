local function __QUEST_HAS_ALL_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

local function __QUEST_FIRST_ITEM_ID(goalItems)
  if goalItems == nil or goalItems[1] == nil then
    return 0
  end
  return goalItems[1].id
end

local function __QUEST_FIRST_ITEM_COUNT(goalItems)
  if goalItems == nil or goalItems[1] == nil then
    return 0
  end
  return goalItems[1].count
end

function npcsay(id)
  if id ~= 4323013 then
    return
  end
  NPC_SAY("竟然随便接近小孩儿和女子，太无礼了。")
  clickNPCid = id
  if qData[2587].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2587].goal.getItem) then
      NPC_SAY("谢谢，这是我的一点心意~")
      SET_QUEST_STATE(2587, 2)
      return
    else
      NPC_SAY("击退黑色阿佩普，收集回来50个黑色阿佩普的鳞就可以了。要质量好的鳞~")
    end
  end
  if qData[2591].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2591].goal.getItem) then
      NPC_SAY("谢谢。我也可以舒服的度过一夏了~")
      SET_QUEST_STATE(2591, 2)
      return
    else
      NPC_SAY("帮我击退{0xFFFFFF00}[黑色英招]{END}，收集{0xFFFFFF00}50个黑色英招的羽毛{END}回来吧。{0xFFFFFF00}[黑色英招]{END}栖息在黑色丘陵。")
    end
  end
  if qData[2587].state == 0 and GET_PLAYER_LEVEL() >= qt[2587].needLevel then
    ADD_QUEST_BTN(qt[2587].id, qt[2587].name)
  end
  if qData[2591].state == 0 and qData[2587].state == 2 and GET_PLAYER_LEVEL() >= qt[2591].needLevel then
    ADD_QUEST_BTN(qt[2591].id, qt[2591].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2587].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2587].needLevel then
    if qData[2587].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2587].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2591].state ~= 2 and qData[2587].state == 2 and GET_PLAYER_LEVEL() >= qt[2591].needLevel then
    if qData[2591].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2591].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
