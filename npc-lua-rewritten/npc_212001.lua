local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4212001 then
    return
  end
  clickNPCid = id
  if qData[103].state == 1 then
    if qData[103].meetNpc[1] ~= qt[103].goal.meetNpc[1] then
      NPC_QSAY(103, 1)
      SET_MEETNPC(103, 1, id)
      if 1 <= CHECK_INVENTORY_CNT(4) then
        SET_QUEST_STATE(103, 2)
      else
        NPC_SAY("行囊太沉。")
      end
      return
    elseif 1 <= CHECK_INVENTORY_CNT(4) then
      SET_QUEST_STATE(103, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[100].state == 1 then
    if qData[100].meetNpc[1] ~= qt[100].goal.meetNpc[1] then
      NPC_QSAY(100, 1)
      SET_MEETNPC(100, 1, id)
      if 1 <= CHECK_INVENTORY_CNT(4) then
        SET_QUEST_STATE(100, 2)
      else
        NPC_SAY("行囊太沉。")
      end
      return
    elseif 1 <= CHECK_INVENTORY_CNT(4) then
      SET_QUEST_STATE(100, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[110].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[110].goal.getItem) then
      NPC_SAY("真的封印了怪物了啊。谢谢。今天晚上可以好好的睡一觉了。女人的睡眠要充足，皮肤才会好看。呵呵呵。")
      SET_QUEST_STATE(110, 2)
    else
      NPC_SAY("{0xFFFFFF00}1张猴赛雷符咒{END}就可以安心睡觉了吧。拜托你了。")
    end
  end
  if qData[156].state == 1 then
    if qData[156].meetNpc[1] ~= qt[156].goal.meetNpc[1] then
      NPC_QSAY(156, 1)
      SET_INFO(156, 1)
      SET_MEETNPC(156, 1, id)
      return
    else
      NPC_SAY("是说工人吗？去{0xFFFFFF00}龙林谷{END}的路上应该能见到，最近因为怪物的出没，正在担心工程的…")
    end
  end
  if qData[1240].state == 1 and __QUEST_CHECK_ITEMS(qt[1240].goal.getItem) then
    if 1 <= CHECK_INVENTORY_CNT(1) then
      NPC_SAY("这个，还准备了这些…。我睡不着是因为别的事情，但还是谢谢了。")
      SET_QUEST_STATE(1240, 2)
      return
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1250].state == 1 and __QUEST_CHECK_ITEMS(qt[1250].goal.getItem) then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("哎哟，这该怎么谢你啊？正好现在电碳不够呢，总之太感谢了。")
      SET_QUEST_STATE(1250, 2)
      return
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1251].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1251].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("谢谢。这里是推荐书。还有南呱湃好像在找你呢。")
        SET_QUEST_STATE(1251, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退黄岳秀洞的红蜗牛，收集20个红蜗牛的壳回来吧。")
    end
  end
  if qData[1254].state == 1 then
    NPC_SAY("击退明珠平原的大胡子收集20个大胡子的牙齿拿给最强舞者郑贤吧。")
  end
  if qData[1256].state == 1 then
    NPC_SAY("去龙林谷入口找受伤的工人吧。")
  end
  ADD_NEW_SHOP_BTN(id, 10011)
  if qData[110].state == 0 then
    ADD_QUEST_BTN(qt[110].id, qt[110].name)
  end
  if qData[1251].state == 0 and qData[1250].state == 2 and GET_PLAYER_LEVEL() >= qt[1251].needLevel then
    ADD_QUEST_BTN(qt[1251].id, qt[1251].name)
  end
  if qData[1254].state == 0 and qData[1240].state == 2 and GET_PLAYER_LEVEL() >= qt[1254].needLevel then
    ADD_QUEST_BTN(qt[1254].id, qt[1254].name)
  end
  if qData[1256].state == 0 and qData[1255].state == 2 and GET_PLAYER_LEVEL() >= qt[1256].needLevel then
    ADD_QUEST_BTN(qt[1256].id, qt[1256].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1580].state == 1 and qData[1580].meetNpc[1] == qt[1580].goal.meetNpc[1] and qData[1580].meetNpc[2] == qt[1580].goal.meetNpc[2] and qData[1580].meetNpc[3] ~= id and CHECK_ITEM_CNT(8980109) > 0 then
    QSTATE(id, 2)
  end
  if qData[1581].state ~= 2 and qData[1580].state == 2 then
    if qData[1581].state == 1 then
      if qData[1581].meetNpc[1] == qt[1581].goal.meetNpc[1] and qData[1580].meetNpc[2] ~= id then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[103].state == 1 then
    QSTATE(id, 1)
  end
  if qData[100].state == 1 then
    QSTATE(id, 1)
  end
  if qData[110].state ~= 2 and GET_PLAYER_LEVEL() >= qt[110].needLevel then
    if qData[110].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[110].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[110].state)
      end
    else
      QSTATE(id, qData[110].state)
    end
  end
  if qData[156].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1240].state == 1 and GET_PLAYER_LEVEL() >= qt[1240].needLevel and __QUEST_CHECK_ITEMS(qt[1240].goal.getItem) then
    if 1 <= CHECK_INVENTORY_CNT(1) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1250].state == 1 and __QUEST_CHECK_ITEMS(qt[1250].goal.getItem) then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1251].state == 0 and qData[1250].state == 2 and GET_PLAYER_LEVEL() >= qt[1251].needLevel then
    QSTATE(id, 0)
  end
  if qData[1254].state == 0 and qData[1240].state == 2 and GET_PLAYER_LEVEL() >= qt[1254].needLevel then
    QSTATE(id, 0)
  end
  if qData[1256].state == 0 and qData[1255].state == 2 and GET_PLAYER_LEVEL() >= qt[1256].needLevel then
    QSTATE(id, 0)
  end
  if qData[1256].state == 0 and qData[1255].state == 2 and GET_PLAYER_LEVEL() >= qt[1256].needLevel then
    QSTATE(id, 0)
  end
end
