function npcsay(id)
  if id ~= 4300135 then
    return
  end
  clickNPCid = id
  if qData[2177].state == 1 then
    if CHECK_ITEM_CNT(qt[2177].goal.getItem[1].id) >= qt[2177].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2177].goal.getItem[2].id) >= qt[2177].goal.getItem[2].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("给，这是燃烧的手镯[3阶段]。")
        SET_QUEST_STATE(2177, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("收集{0xFFFFFF00}[燃烧的手镯[2阶段]]{END}和4个{0xFFFFFF00}[燃烧的结晶]{END}来的话我会给你{0xFFFFFF00}[燃烧的手镯[3阶段]]{END}。")
    end
  end
  if qData[2178].state == 1 then
    if CHECK_ITEM_CNT(qt[2178].goal.getItem[1].id) >= qt[2178].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2178].goal.getItem[2].id) >= qt[2178].goal.getItem[2].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("给，这是燃烧的戒指[3阶段]。")
        SET_QUEST_STATE(2178, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("收集{0xFFFFFF00}[燃烧的戒指[2阶段]]{END}和4个{0xFFFFFF00}[燃烧的结晶]{END}来的话我会给你{0xFFFFFF00}[燃烧的戒指[3阶段]]{END}。")
    end
  end
  if qData[2179].state == 1 then
    if CHECK_ITEM_CNT(qt[2179].goal.getItem[1].id) >= qt[2179].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2179].goal.getItem[2].id) >= qt[2179].goal.getItem[2].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("给，这是燃烧的项链[3阶段]。")
        SET_QUEST_STATE(2179, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("收集{0xFFFFFF00}燃烧的项链[2阶段]{END}和{0xFFFFFF00}4个燃烧的结晶{END}交给{0xFFFFFF00}活动助手{END}后获取{0xFFFFFF00}燃烧的项链[3阶段]{END}吧。")
    end
  end
  if qData[2180].state == 1 then
    if CHECK_ITEM_CNT(qt[2180].goal.getItem[1].id) >= qt[2180].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2180].goal.getItem[2].id) >= qt[2180].goal.getItem[2].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("给，这是燃烧的耳环[3阶段]。")
        SET_QUEST_STATE(2180, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("收集{0xFFFFFF00}[燃烧的耳环[2阶段]]{END}和4个{0xFFFFFF00}[燃烧的结晶]{END}来的话我会给你{0xFFFFFF00}[燃烧的耳环[3阶段]]{END}。")
    end
  end
  if qData[3643].state == 1 then
    if CHECK_ITEM_CNT(qt[3643].goal.getItem[1].id) >= qt[3643].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("给，就是这个了。还需要的话明天再来吧。做这个可不是件容易的事。")
        SET_QUEST_STATE(3643, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("我说过{0xFFFFFF00}一天只能进行1次{END}。不管怎么说先收集50个{0xFFFFFF00}[燃烧的根源]{END}来吧。")
    end
  end
  if qData[2177].state == 0 then
    ADD_QUEST_BTN(qt[2177].id, qt[2177].name)
  end
  if qData[2178].state == 0 then
    ADD_QUEST_BTN(qt[2178].id, qt[2178].name)
  end
  if qData[2179].state == 0 then
    ADD_QUEST_BTN(qt[2179].id, qt[2179].name)
  end
  if qData[2180].state == 0 then
    ADD_QUEST_BTN(qt[2180].id, qt[2180].name)
  end
  if qData[3643].state == 0 then
    ADD_QUEST_BTN(qt[3643].id, qt[3643].name)
  end
end
function getsell()
  ({
    ["8871513"] = 2000000
  })["8871514"] = 2000000
  ;({
    ["8871513"] = 2000000
  })["8871523"] = 1000000
  ;({
    ["8871513"] = 2000000
  })["8871524"] = 1000000
  ;({
    ["8871513"] = 2000000
  })["8871611"] = 500000000
  ;({
    ["8871513"] = 2000000
  })["8871581"] = 8880000
  ;({
    ["8871513"] = 2000000
  })["8890158"] = 500000
  ;local ({
    ["8871513"] = 2000000
  })["8890275"], list = 5000000, {
    ["8871513"] = 2000000
  }
  return clickNPCid, list
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2177].state ~= 2 then
    if qData[2177].state == 1 then
      if CHECK_ITEM_CNT(qt[2177].goal.getItem[1].id) >= qt[2177].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2177].goal.getItem[2].id) >= qt[2177].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2178].state ~= 2 then
    if qData[2178].state == 1 then
      if CHECK_ITEM_CNT(qt[2178].goal.getItem[1].id) >= qt[2178].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2178].goal.getItem[2].id) >= qt[2178].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2179].state ~= 2 then
    if qData[2179].state == 1 then
      if CHECK_ITEM_CNT(qt[2179].goal.getItem[1].id) >= qt[2179].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2179].goal.getItem[2].id) >= qt[2179].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2180].state ~= 2 then
    if qData[2180].state == 1 then
      if CHECK_ITEM_CNT(qt[2180].goal.getItem[1].id) >= qt[2180].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2180].goal.getItem[2].id) >= qt[2180].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3643].state ~= 2 then
    if qData[3643].state == 1 then
      if CHECK_ITEM_CNT(qt[3643].goal.getItem[1].id) >= qt[3643].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
