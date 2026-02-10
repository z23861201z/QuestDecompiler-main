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
  if id ~= 4240005 then
    return
  end
  clickNPCid = id
  NPC_SAY("欢迎光临。探险家，在神秘的安哥拉王国尽情的享受探险的乐趣吧。")
  ADD_STORE_BTN(id)
  ADD_EVENT_BTN_JEWEL(id)
  GIVE_DONATION_ITEM(id)
  ADD_PARCEL_SERVICE_BTN(id)
  ADD_NEW_SHOP_BTN(id, 10084)
  if qData[1478].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1478].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("哇！真的是百闻不如一见啊！果然跟传说中的一样，辛苦你了！这是答应你的{0xFFFFFF00}推荐书{END}！")
        SET_QUEST_STATE(1478, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去{0xFFFFFF00}獐子潭洞穴{END}击退{0xFFFFFF00}曲怪人{END}，如果能帮我收集{0xFFFFFF00}20个望天的眼{END}，我就会给你{0xFFFFFF00}推荐书{END}！")
    end
  end
  if qData[2857].state == 1 then
    NPC_SAY("{0xFFFFCCCC}(辛巴达小心的招手){END}你来这边。")
    SET_QUEST_STATE(2857, 2)
    return
  end
  if qData[2858].state == 1 then
    NPC_SAY("喜欢{0xFFFFFF00}酒{END}的{0xFFFFFF00}近卫兵哈玛特{END}会对{0xFF99ff99}PLAYERNAME{END}有帮助的。")
  end
  if qData[1478].state == 0 and qData[1477].state == 1 then
    ADD_QUEST_BTN(qt[1478].id, qt[1478].name)
  end
  if qData[2858].state == 0 and qData[2857].state == 2 and GET_PLAYER_LEVEL() >= qt[2858].needLevel then
    ADD_QUEST_BTN(qt[2858].id, qt[2858].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1478].state ~= 2 and qData[1477].state == 1 then
    if qData[1478].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1478].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2857].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2858].state ~= 2 and qData[2857].state == 2 and GET_PLAYER_LEVEL() >= qt[2858].needLevel then
    if qData[2858].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
