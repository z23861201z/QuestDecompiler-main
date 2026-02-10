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
  if id ~= 4300012 then
    return
  end
  clickNPCid = id
  if qData[1002].state == 1 then
    NPC_SAY("刚刚我也收到消息，说兰霉匠的高级手下们现身了…")
    SET_QUEST_STATE(1002, 2)
    return
  end
  if qData[1003].state == 1 then
    NPC_SAY("到现在还没去吗？不要拖拖拉拉的，快点去{0xFFFFFF00}[ 冥珠城 ]{END}找兰霉匠的手下获取情报吧！")
    return
  end
  if qData[1132].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[1132].goal.getItem) then
    NPC_SAY("嗯？谁啊！")
    SET_QUEST_STATE(1132, 2)
  end
  if qData[1133].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1133].goal.getItem) and GET_SEAL_BOX_SOUL_PERSENT(8510011) >= 100 then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("很好。你充分的证明了自己的实力。")
        SET_QUEST_STATE(1133, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("往封印箱装满怪物的魂来证明你的实力吧。")
    end
  end
  if qData[1134].state == 1 then
    if GET_PLAYER_LEVEL() >= 18 then
      NPC_SAY("做得好。功力达18了。")
      SET_QUEST_STATE(1134, 2)
    else
      NPC_SAY("去完成战报任务，达功力18后回来吧。")
    end
  end
  if qData[1135].state == 1 then
    if GET_PLAYER_LEVEL() >= 35 then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("很好。现在告诉你师兄的行踪。")
        SET_QUEST_STATE(1135, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("同时完成普通任务和战报任务是迅速成长的捷径。功力还没达35吗？")
    end
  end
  if qData[1180].state == 1 then
    NPC_SAY("去冥珠城找西米路师兄。")
  end
  if qData[2025].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2025].goal.getItem) then
      SET_QUEST_STATE(2025, 2)
      NPC_SAY("谁啊！嗯…看着脸熟啊。是胡须张让你来的？这是剩余的款项")
    else
      NPC_SAY("谁都不见")
    end
  end
  if qData[2026].state == 1 then
    NPC_SAY("今天先回去吧，短时间内谁都不见(看来是不想招待我啊，回到{0xFFFFFF00}[胡须张]{END}处吧)")
  end
  if qData[2028].state == 1 then
    SET_QUEST_STATE(2028, 2)
    NPC_SAY("你来了？上次不好意思啊，把你误认为是故人，受到了冲击。哈哈哈！")
  end
  if qData[2029].state == 1 then
    NPC_SAY("战报任务对你以后的实力提升有很大的帮助。现在回去见{0xFFFFFF00}[佣兵领袖]{END}吧")
  end
  if qData[2065].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2065].goal.getItem) then
    SET_QUEST_STATE(2065, 2)
    NPC_SAY("来得正好，很久之前开始就印象很深刻，没想到还把这种事托付给你...")
  end
  if qData[2066].state == 1 then
    NPC_SAY("我会给西米路传音的，你收集10个[美丽人参]的山参和10个[飞头鬼]的黑粉后去冥珠城找到[西米路]告诉他我的近况吧~")
  end
  if qData[1003].state == 0 and qData[1002].state == 2 then
    ADD_QUEST_BTN(qt[1003].id, qt[1003].name)
  end
  if qData[1132].state == 2 and qData[1133].state == 0 then
    ADD_QUEST_BTN(qt[1133].id, qt[1133].name)
  end
  if qData[1133].state == 2 and qData[1134].state == 0 then
    ADD_QUEST_BTN(qt[1134].id, qt[1134].name)
  end
  if qData[1134].state == 2 and qData[1135].state == 0 then
    ADD_QUEST_BTN(qt[1135].id, qt[1135].name)
  end
  if qData[1180].state == 0 then
    ADD_QUEST_BTN(qt[1180].id, qt[1180].name)
  end
  if qData[2026].state == 0 and qData[2025].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2026].id, qt[2026].name)
  end
  if qData[2029].state == 0 and qData[2028].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2029].id, qt[2029].name)
  end
  if qData[2066].state == 0 and qData[2065].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2066].id, qt[2066].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1002].state == 1 and GET_PLAYER_LEVEL() >= qt[1002].needLevel then
    QSTATE(id, 2)
  end
  if qData[1003].state ~= 2 and qData[1002].state == 2 and GET_PLAYER_LEVEL() >= qt[1003].needLevel then
    if qData[1003].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1132].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1132].needLevel and qData[1132].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[1132].goal.getItem) then
    QSTATE(id, 2)
  end
  if qData[1132].state == 2 and qData[1133].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1133].needLevel then
    if qData[1133].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1133].goal.getItem) and GET_SEAL_BOX_SOUL_PERSENT(__QUEST_FIRST_ITEM_ID(qt[1133].goal.getItem)) >= 100 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1133].state == 2 and qData[1134].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1134].needLevel then
    if qData[1134].state == 1 then
      if GET_PLAYER_LEVEL() >= 18 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1135].state ~= 2 and qData[1134].state == 2 and GET_PLAYER_LEVEL() >= qt[1135].needLevel then
    if qDta[1135].state == 1 then
      if GET_PLAYER_LEVEL() >= 35 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1180].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1132].needLevel then
    if qData[1180].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2025].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2025].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2026].state ~= 2 and qData[2025].state == 2 and GET_PLAYER_LEVEL() >= qt[2026].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2026].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2028].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2029].state ~= 2 and qData[2028].state == 2 and GET_PLAYER_LEVEL() >= qt[2029].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2029].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2065].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2065].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2066].state ~= 2 and qData[2065].state == 2 and GET_PLAYER_LEVEL() >= qt[2066].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2066].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
