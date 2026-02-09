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
  if id ~= 4214002 then
    return
  end
  clickNPCid = id
  if qData[861].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[861].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("真是美好的回忆啊！作为报答给您灵游记纪念册的附录，请打开使用吧。希望对您有用。要记录在纪念册的回忆现在还很少，一有空就过来帮我吧")
        SET_QUEST_STATE(861, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("看来[我的记忆]还没有出现啊，请保管好1小时")
    end
  end
  if qData[1115].state == 1 and qData[1115].meetNpc[1] ~= id and CHECK_ITEM_CNT(8990012) > 0 then
    NPC_SAY("啊！是简讯。谢谢。")
    SET_MEETNPC(1115, 1, id)
  end
  if qData[1116].state == 1 then
    NPC_SAY("快点吧。已经给她发信了。她是谁可不能告诉你。去清阴谷击退蝎角亭收集7个[ 蝎脚亭的尾巴 ]拿给钱难赚吧。")
  end
  if qData[1199].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("{0xFFFFFF00}各村的哞读册负责鬼魂和控灵相关事宜{END}。对鬼魂和控灵有什么疑问可以去找附近的哞读册。")
      SET_QUEST_STATE(1199, 2)
    else
      NPC_SAY("行囊太沉了，请空出{0xFFFFFF00}行囊(装备2){END}。")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10002)
  ADD_MOVESOUL_BTN(id)
  ADD_ENCHANT_BTN(id)
  ADD_PURIFICATION_BTN(id)
  if qData[1116].state == 0 then
    ADD_QUEST_BTN(qt[1116].id, qt[1116].name)
  end
  if qData[1199].state == 0 then
    ADD_QUEST_BTN(qt[1199].id, qt[1199].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1115].state ~= 2 and qData[1115].state == 1 and qData[1115].meetNpc[1] ~= id then
    QSTATE(id, 1)
  end
  if qData[1116].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1116].needLevel then
    if qData[1116].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1199].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1199].needLevel then
    if qData[1199].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
end
