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
  if id ~= 4315018 then
    return
  end
  clickNPCid = id
  if qData[1270].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1270].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。但还没有结束。")
        SET_QUEST_STATE(1270, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("击退铁腕川的歇顶龟龟，收集30个歇顶龟龟壳回来吧。")
      return
    end
  end
  if qData[1043].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[1043].goal.getItem) then
    NPC_SAY("这么快就到时候了吗..可是那家伙好像是第一次见到。")
    SET_QUEST_STATE(1043, 2)
    return
  end
  if qData[1044].state == 1 then
    NPC_SAY("怎么现在还在这里！")
    return
  end
  if qData[1269].state == 1 then
    NPC_SAY("盲目的走进我不会客气的。")
    SET_QUEST_STATE(1269, 2)
  end
  if qData[1271].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1271].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。但还没有结束。先等一下。")
        SET_QUEST_STATE(1271, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退铁腕川的鬼新娘，收集30个彩缎回来吧。")
    end
  end
  if qData[1272].state == 1 then
    NPC_SAY("去龙林城南边的龙林城害了了防具店帮助她吧。")
  end
  if qData[1276].state == 1 then
    NPC_SAY("（没有再问的了，去龙林城南边找懒惰鬼商量吧。）")
  end
  if qData[1285].state == 1 then
    NPC_SAY("希望你这次也可以顺利的处理掉。")
  end
  if qData[1294].state == 1 then
    NPC_SAY("来了？比想象的晚了很多。")
    SET_QUEST_STATE(1294, 2)
  end
  if qData[1295].state == 1 then
    NPC_SAY("去龙林城南边的龙林派师弟那儿看看吧。")
  end
  if qData[1044].state == 0 and qData[1043].state == 2 then
    ADD_QUEST_BTN(qt[1044].id, qt[1044].name)
  end
  if qData[1270].state == 0 and qData[1269].state == 2 and GET_PLAYER_LEVEL() >= qt[1270].needLevel then
    ADD_QUEST_BTN(qt[1270].id, qt[1270].name)
  end
  if qData[1271].state == 0 and qData[1270].state == 2 and GET_PLAYER_LEVEL() >= qt[1271].needLevel then
    ADD_QUEST_BTN(qt[1271].id, qt[1271].name)
  end
  if qData[1272].state == 0 and qData[1271].state == 2 and GET_PLAYER_LEVEL() >= qt[1272].needLevel then
    ADD_QUEST_BTN(qt[1272].id, qt[1272].name)
  end
  if qData[1276].state == 0 and qData[1275].state == 2 and GET_PLAYER_LEVEL() >= qt[1276].needLevel then
    ADD_QUEST_BTN(qt[1276].id, qt[1276].name)
  end
  if qData[1285].state == 0 and qData[1280].state == 2 and GET_PLAYER_LEVEL() >= qt[1285].needLevel then
    ADD_QUEST_BTN(qt[1285].id, qt[1285].name)
  end
  if qData[1295].state == 0 and qData[1294].state == 2 and GET_PLAYER_LEVEL() >= qt[1295].needLevel then
    ADD_QUEST_BTN(qt[1295].id, qt[1295].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1043].state == 1 and GET_PLAYER_LEVEL() >= qt[1043].needLevel then
    if __QUEST_HAS_ALL_ITEMS(qt[1043].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1044].state ~= 2 and qData[1043].state == 2 then
    if qData[1044].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1269].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1270].state ~= 2 and qData[1269].state == 2 and GET_PLAYER_LEVEL() >= qt[1270].needLevel then
    if qData[1270].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1270].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1271].state ~= 2 and qData[1270].state == 2 and GET_PLAYER_LEVEL() >= qt[1271].needLevel then
    if qData[1271].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1271].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1272].state ~= 2 and qData[1271].state == 2 and GET_PLAYER_LEVEL() >= qt[1272].needLevel then
    if qData[1272].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1276].state ~= 2 and qData[1275].state == 2 and GET_PLAYER_LEVEL() >= qt[1276].needLevel then
    if qData[1276].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1285].state ~= 2 and qData[1280].state == 2 and GET_PLAYER_LEVEL() >= qt[1285].needLevel then
    if qData[1285].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1285].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1294].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1295].state ~= 2 and qData[1294].state == 2 and GET_PLAYER_LEVEL() >= qt[1295].needLevel then
    if qData[1295].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
