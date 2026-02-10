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
  if id ~= 4214010 then
    return
  end
  clickNPCid = id
  NPC_SAY("尽情地挑吧。看着像杂物，却是干净又好的东西。")
  if qData[1101].state == 1 and qData[1101].meetNpc[1] ~= id then
    NPC_SAY("长老派你来的？你就是传说中的异邦人。很高兴见到你。点击{0xFFFFFF00}[ 商店 ]{END}，蓝水就在出现的物品之中。选择蓝水后点击购买即可。")
    SET_INFO(1101, 1)
    SET_MEETNPC(1101, 1, id)
  end
  ADD_NEW_SHOP_BTN(id, 10057)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1101].state == 1 and not __QUEST_HAS_ALL_ITEMS(qt[1101].goal.getItem) then
    QSTATE(id, 1)
  end
end
