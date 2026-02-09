local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4317007 then
    return
  end
  clickNPCid = id
  if qData[330].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[330].goal.getItem) then
      NPC_SAY("这么快就收集回来了啊。辛苦了。马上就让你见识一下。怎么样？神奇吧？")
      SET_QUEST_STATE(330, 2)
    else
      NPC_SAY("那种场景不是很容易就能见到的。10个[红色胶皮鞋]还没收集好吗？吸血鬼在强悍巷道里面。")
    end
  end
  if qData[1139].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("啊！是清江银行派过来的少侠啊。这是清阴符。")
      SET_QUEST_STATE(1139, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1140].state == 1 then
    NPC_SAY("快点使用清阴符去找胡须张吧。")
  end
  if qData[1164].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1164].goal.getItem) then
      NPC_SAY("这么快就收集回来了啊。辛苦了。马上就让你见识一下。怎么样？神奇吧？")
      SET_QUEST_STATE(1164, 2)
    else
      NPC_SAY("那种场景不是很容易就能见到的。10个[红色胶皮鞋]还没收集好吗？吸血鬼在强悍巷道里面。")
    end
  end
  if qData[1171].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1171].goal.getItem) and __QUEST_CHECK_ITEMS(qt[1171].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("真的完成了啊？谢谢。虽然微不足道但是请收下吧。")
        SET_QUEST_STATE(1171, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("帮我收集强悍巷道里的蓝色大菜头的3个[蓝色的灯油]和土拨鼠的5个[鼠须]吧。那些程度应该就能安心了。")
    end
  end
  if qData[1139].state == 2 and qData[1140].state == 0 then
    ADD_QUEST_BTN(qt[1140].id, qt[1140].name)
  end
  if qData[1164].state == 0 then
    ADD_QUEST_BTN(qt[1164].id, qt[1164].name)
  end
  if qData[1171].state == 0 then
    ADD_QUEST_BTN(qt[1171].id, qt[1171].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1139].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1139].needLevel and qData[1139].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1139].state == 2 and qData[1140].state ~= 2 then
    if qData[1140].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1164].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1164].needLevel then
    if qData[1164].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[1164].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1171].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1171].needLevel then
    if qData[1171].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[1171].goal.getItem) and __QUEST_CHECK_ITEMS(qt[1171].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
