local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4318013 then
    return
  end
  clickNPCid = id
  if qData[1291].state == 1 then
    NPC_SAY("真的吗？土著民真的答应帮忙了吗？")
    SET_QUEST_STATE(1291, 2)
  end
  if qData[1292].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1292].goal.getItem) and __QUEST_CHECK_ITEMS(qt[1292].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢。现在可以正式进行战斗了。")
        SET_QUEST_STATE(1292, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退铁腕山的石碑怪和饿死鬼，收集石碑碎片和水瓢各20个回来吧。")
    end
  end
  if qData[1293].state == 1 then
    NPC_SAY("高一燕在韩野都城。功力达68之后，去见高一燕就可以了。")
  end
  if qData[1379].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("又有什么事情啊？这，这是？")
      SET_QUEST_STATE(1379, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1380].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1380].goal.getItem) then
      NPC_SAY("谢谢。韩野岛地带的海上权就要属于即将完成的龟船了。当然！肯定会是这样的！")
      SET_QUEST_STATE(1380, 2)
    else
      NPC_SAY("击退生死之房的黑树妖，收集35个黑树妖皮回来吧。")
    end
  end
  if qData[1381].state == 1 then
    NPC_SAY("要回到生死之塔入口的武艺僧长经处？好可惜啊。想好好的招待你一下…")
  end
  if qData[1292].state == 0 and qData[1291].state == 2 and GET_PLAYER_LEVEL() >= qt[1292].needLevel then
    ADD_QUEST_BTN(qt[1292].id, qt[1292].name)
  end
  if qData[1293].state == 0 and qData[1292].state == 2 and GET_PLAYER_LEVEL() >= qt[1293].needLevel then
    ADD_QUEST_BTN(qt[1293].id, qt[1293].name)
  end
  if qData[1380].state == 0 and qData[1379].state == 2 and GET_PLAYER_LEVEL() >= qt[1380].needLevel then
    ADD_QUEST_BTN(qt[1380].id, qt[1380].name)
  end
  if qData[1381].state == 0 and qData[1380].state == 2 and GET_PLAYER_LEVEL() >= qt[1381].needLevel then
    ADD_QUEST_BTN(qt[1381].id, qt[1381].name)
  end
end
function chkQState(id)
  QSTATE(id, false)
  if qData[1291].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1292].state ~= 2 and qData[1291].state == 2 and GET_PLAYER_LEVEL() >= qt[1292].needLevel then
    if qData[1292].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[1292].goal.getItem) and __QUEST_CHECK_ITEMS(qt[1292].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1293].state ~= 2 and qData[1292].state == 2 and GET_PLAYER_LEVEL() >= qt[1293].needLevel then
    if qData[1293].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1379].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1380].state ~= 2 and qData[1379].state == 2 and GET_PLAYER_LEVEL() >= qt[1380].needLevel then
    if qData[1380].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[1380].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1381].state ~= 2 and qData[1380].state == 2 and GET_PLAYER_LEVEL() >= qt[1381].needLevel then
    if qData[1381].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
