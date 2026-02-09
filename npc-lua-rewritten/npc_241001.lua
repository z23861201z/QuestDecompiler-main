local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4241001 then
    return
  end
  clickNPCid = id
  NPC_SAY("卫生和清洁是治疗的第一步。")
  if qData[3736].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[3736].goal.getItem) and __QUEST_CHECK_ITEMS(qt[3736].goal.getItem) then
      NPC_SAY("谢谢。下次再拜托你。")
      SET_QUEST_STATE(3736, 2)
      return
    else
      NPC_SAY("你帮忙收集30个地龙的皮肤和20个巨翅鸭嘴兽的腿吧。")
    end
  end
  if qData[3736].state == 0 and GET_PLAYER_LEVEL() >= qt[3736].needLevel then
    ADD_QUEST_BTN(qt[3736].id, qt[3736].name)
  end
  ADD_NEW_SHOP_BTN(id, 10086)
  GIVE_DONATION_BUFF(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3736].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3736].needLevel then
    if qData[3736].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[3736].goal.getItem) and __QUEST_CHECK_ITEMS(qt[3736].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
