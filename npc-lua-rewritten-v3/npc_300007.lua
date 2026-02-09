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
  if id ~= 4300007 then
    return
  end
  clickNPCid = id
  if qData[1431].state == 1 then
    NPC_SAY("保护天子…喃喃自语…只有师傅回来才能阻止师兄…喃喃自语…")
    SET_QUEST_STATE(1431, 2)
    return
  end
  if qData[1432].state == 1 then
    NPC_SAY("好怕…好怕…不要过来！（瑟瑟发抖。先回到第一寺主持那里）")
  end
  if qData[1436].state == 1 then
    NPC_SAY("把我的消息转达给西米路师弟。你说他现在在冥珠城西是吧？")
  end
  if qData[1460].state == 1 then
    NPC_SAY("嘻，嘻…我什么都不知道。嘻…咳咳…你来了？")
    SET_QUEST_STATE(1460, 2)
    return
  end
  if qData[1461].state == 1 then
    NPC_SAY("去{0xFFFFFF00}血魔深窟{END}见见{0xFFFFFF00}竹统泛{END}")
  end
  if qData[2654].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2654].goal.getItem) then
    NPC_SAY("这就是鬼魂者的真气…跟过去师傅给看的一样。（秋叨鱼一边把脉）感受这儿跟这儿的真气流动并使用技能即可。来，现在应该可以使用鬼魂者的所有能力了。")
    SET_QUEST_STATE(2654, 2)
  end
  if qData[2655].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2655].goal.getItem) then
    NPC_SAY("这就是鬼魂者的真气…跟过去师傅给看的一样。（秋叨鱼一边把脉）感受这儿跟这儿的真气流动并使用技能即可。来，现在应该可以使用鬼魂者的所有能力了。")
    SET_QUEST_STATE(2655, 2)
  end
  if qData[1432].state == 0 and qData[1431].state == 2 and GET_PLAYER_LEVEL() >= qt[1432].needLevel then
    ADD_QUEST_BTN(qt[1432].id, qt[1432].name)
  end
  if qData[1436].state == 0 and qData[1435].state == 2 and GET_PLAYER_LEVEL() >= qt[1436].needLevel then
    ADD_QUEST_BTN(qt[1436].id, qt[1436].name)
  end
  if qData[1461].state == 0 and qData[1460].state == 2 then
    ADD_QUEST_BTN(qt[1461].id, qt[1461].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1431].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1432].state ~= 2 and qData[1431].state == 2 and GET_PLAYER_LEVEL() >= qt[1432].needLevel then
    if qData[1432].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1436].state ~= 2 and qData[1435].state == 2 and GET_PLAYER_LEVEL() >= qt[1436].needLevel then
    if qData[1436].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1460].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1461].state ~= 2 and qData[1460].state == 2 and GET_PLAYER_LEVEL() >= qt[1461].needLevel then
    if qData[1461].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2654].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2654].goal.getItem) then
    QSTATE(id, 2)
  end
  if qData[2655].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2655].goal.getItem) then
    QSTATE(id, 2)
  end
end
