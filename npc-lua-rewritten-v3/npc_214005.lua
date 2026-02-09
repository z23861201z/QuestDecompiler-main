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
  if id ~= 4214005 then
    return
  end
  clickNPCid = id
  NPC_SAY("欢迎光临。这里是负责保管物品的镖局。但不只是负责保管，也主管各种活动。你是为了什么事来的啊？")
  if qData[1505].state == 1 and qData[1505].meetNpc[1] == qt[1505].goal.meetNpc[1] then
    SET_INFO(1505, 2)
    NPC_SAY("终于找到我了啊。我出第三个问题。在一年四季都开着樱花的地方出售知识的人是谁？去见见吧。")
    SET_MEETNPC(1505, 2, id)
  end
  if qData[1120].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("嗯？谁是清阴银行？就是我啊。你有什么事吗？")
      SET_QUEST_STATE(1120, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1121].state == 1 then
    if qData[1121].meetNpc[1] == qt[1121].goal.meetNpc[1] and qData[1121].meetNpc[2] == qt[1121].goal.meetNpc[2] and qData[1121].meetNpc[3] ~= id then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。请先到这边来。怎么样？想起来了吗？")
        SET_MEETNPC(1121, 3, id)
        SET_QUEST_STATE(1121, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("得快点。天黑了就很难见了。白斩姬在清阴关南边的正派建筑里，乌骨鸡在北边的邪派建筑里。")
    end
  end
  if qData[1122].state == 1 then
    if qData[1122].killMonster[qt[1122].goal.killMonster[1].id] >= qt[1122].goal.killMonster[1].count then
      NPC_SAY("天啊，这么快就回来了。想要尽快获得名声吗？")
      SET_QUEST_STATE(1122, 2)
    else
      NPC_SAY("果然是害怕了？是击退南清阴平原的5个螳螂勇勇。")
    end
  end
  if qData[1123].state == 1 then
    NPC_SAY("乌骨鸡大侠这样的人物再找，还是快点去的好。乌骨鸡大侠在清阴关北边的邪派建筑里。")
  end
  if qData[1132].state == 1 then
    NPC_SAY("这件事一定要保密。北瓶押在隐藏的清阴谷。")
  end
  if qData[1181].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1181].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[1181].goal.getItem) then
      NPC_SAY("谢谢。我就知道大侠肯定可以的。这下那鲁莽的猪大长不会袭击我们押镖一行了吧。再次感谢您。")
      SET_QUEST_STATE(1181, 2)
    else
      NPC_SAY("如果不能抓到猪大长就帮忙击退他的手下吧。完成之后作为证明拿来4个[ 背影杀手的镜 ]和[ 红毛龟的壳 ]吧。那样应该会解点恨的。")
    end
  end
  if qData[1344].state == 1 then
    NPC_SAY("有什么事吗？")
    SET_QUEST_STATE(1344, 2)
  end
  ADD_STORE_BTN(id)
  GIVE_DONATION_ITEM(id)
  ADD_PARCEL_SERVICE_BTN(id)
  ADD_EVENT_BTN_JEWEL(id)
  if qData[1120].state == 2 and qData[1121].state == 0 and GET_PLAYER_LEVEL() >= qt[1121].needLevel then
    ADD_QUEST_BTN(qt[1121].id, qt[1121].name)
  end
  if qData[1121].state == 2 and qData[1122].state == 0 then
    ADD_QUEST_BTN(qt[1122].id, qt[1122].name)
  end
  if qData[1122].state == 2 and qData[1123].state == 0 then
    ADD_QUEST_BTN(qt[1123].id, qt[1123].name)
  end
  if qData[1132].state == 0 then
    ADD_QUEST_BTN(qt[1132].id, qt[1132].name)
  end
  if qData[1181].state == 0 then
    ADD_QUEST_BTN(qt[1181].id, qt[1181].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1119].state == 2 and qData[1120].state ~= 2 and qData[1120].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1120].state == 2 and qData[1121].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1121].needLevel then
    if qData[1121].state == 1 then
      if qData[1121].meetNpc[1] == qt[1121].goal.meetNpc[1] and qData[1121].meetNpc[2] == qt[1121].goal.meetNpc[2] and qData[1121].meetNpc[3] ~= id then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1121].state == 2 and qData[1122].state ~= 2 then
    if qData[1122].state == 1 then
      if qData[1122].killMonster[qt[1122].goal.killMonster[1].id] >= qt[1122].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1122].state == 2 and qData[1123].state ~= 2 then
    if qData[1123].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1132].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1132].needLevel then
    if qData[1132].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1181].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1181].needLevel then
    if qData[1181].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1181].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[1181].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1344].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1505].state == 1 then
    QSTATE(id, 1)
  end
end
