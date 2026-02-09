local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4241003 then
    return
  end
  clickNPCid = id
  NPC_SAY("对于美丽的表现，衣服尤为重要！")
  if qData[2721].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[2721].goal.getItem) then
      NPC_SAY("谢谢。看一看我在出售的衣服吧。")
      SET_QUEST_STATE(2721, 2)
      return
    else
      NPC_SAY("20个锯齿飞鱼的断掉的锯齿就可以了。可以帮我收集吗？")
    end
  end
  if qData[3785].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[3785].goal.getItem) then
      NPC_SAY("谢谢。下次有机会也来看看我卖的衣服吧。")
      SET_QUEST_STATE(3785, 2)
      return
    else
      NPC_SAY("需要50个{0xFFFFFF00}飞翅怪鱼{END}的{0xFFFFFF00}柔软的鳍{END}。能帮我收集回来吗？")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10088)
  GIHON_MIXTURE(id)
  ARMY_BOX_OPEN(id)
  if qData[2721].state == 0 and GET_PLAYER_LEVEL() >= qt[2721].needLevel then
    ADD_QUEST_BTN(qt[2721].id, qt[2721].name)
  end
  if qData[3785].state == 0 and GET_PLAYER_LEVEL() >= qt[3785].needLevel then
    ADD_QUEST_BTN(qt[3785].id, qt[3785].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2721].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2721].needLevel then
    if qData[2721].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[2721].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3785].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3785].needLevel then
    if qData[3785].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[3785].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
