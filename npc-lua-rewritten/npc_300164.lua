local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4300164 then
    return
  end
  clickNPCid = id
  if qData[3744].state == 1 then
    if qData[3745].state ~= 2 then
      if __QUEST_CHECK_ITEMS(qt[3744].goal.getItem) then
        if 1 <= CHECK_INVENTORY_CNT(2) then
          NPC_SAY("拿来了吗？来，好好使用吧~跟我借了就不能再跟乌龟借了。")
          SET_QUEST_STATE(3744, 2)
          return
        else
          NPC_SAY("行囊太沉")
        end
      else
        NPC_SAY("这个腰带可以将经验值增加400%，达到5倍效果呢！但是只能使用1小时，每天能租赁1次。要租赁吗？还要注意的是，借了我的腰带，就不能再跟旁边的乌龟借了。快拿来15个8周年纪念币吧。")
      end
    else
      NPC_SAY("领取了乌龟的腰带就不能领取我的...")
    end
  end
  if qData[3744].state == 0 and qData[3745].state ~= 2 then
    ADD_QUEST_BTN(qt[3744].id, qt[3744].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3744].state ~= 2 then
    if qData[3744].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[3744].goal.getItem) and qData[3745].state ~= 2 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
