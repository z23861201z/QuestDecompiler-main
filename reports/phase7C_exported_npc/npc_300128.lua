function npcsay(id)
  if id ~= 4300128 then
    return
  end
  clickNPCid = id
  if qData[2012].state == 1 then
    if CHECK_ITEM_CNT(qt[2012].goal.getItem[1].id) >= qt[2012].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2012].goal.getItem[2].id) >= qt[2012].goal.getItem[2].count and CHECK_ITEM_CNT(qt[2012].goal.getItem[3].id) >= qt[2012].goal.getItem[3].count and CHECK_ITEM_CNT(qt[2012].goal.getItem[4].id) >= qt[2012].goal.getItem[4].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("多谢了...这是给您的报答...")
        SET_QUEST_STATE(2012, 2)
        return
      else
        NPC_SAY("行囊太沉.")
        return
      end
    else
      NPC_SAY("攻击南瓜装饰，获得琥珀宝箱后，打开获得{0xFFFFFF00}玩具骷髅、玩具捕捉器、玩具炸弹、讨人厌的纸条各1个{END}后，交给我吧！")
      return
    end
  end
  if qData[2013].state == 1 then
    if CHECK_ITEM_CNT(qt[2013].goal.getItem[1].id) >= qt[2013].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2013].goal.getItem[2].id) >= qt[2013].goal.getItem[2].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("谢谢...这是答应给您的黄金骷髅...")
        SET_QUEST_STATE(2013, 2)
        return
      else
        NPC_SAY("行囊太沉.")
        return
      end
    else
      NPC_SAY("您能去击退跟您等级相近的怪物，收集{0xFFFFFF00}5个蓝色棒棒糖和5个红色棒棒糖{END}给我吗？")
      return
    end
  end
  if qData[2014].state == 1 then
    if CHECK_ITEM_CNT(qt[2014].goal.getItem[1].id) >= qt[2014].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("来，这些当中选一个吧...希望您能有一个难忘的万圣节夜晚...")
        SET_QUEST_STATE(2014, 2)
        return
      else
        NPC_SAY("行囊太沉.")
        return
      end
    else
      NPC_SAY("给我3个黄金骷髅，就可以兑换箭骨头面具、魔女高帽、琥珀帽这几个中的1个，在打开琥珀宝箱时，有一定几率可以获得黄金骷髅哦...")
      return
    end
  end
  if qData[2012].state == 0 then
    ADD_QUEST_BTN(qt[2012].id, qt[2012].name)
  end
  if qData[2013].state == 0 and qData[2012].state == 2 then
    ADD_QUEST_BTN(qt[2013].id, qt[2013].name)
  end
  if qData[2014].state == 0 and qData[2013].state == 2 then
    ADD_QUEST_BTN(qt[2014].id, qt[2014].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2012].state ~= 2 then
    if qData[2012].state == 1 then
      if CHECK_ITEM_CNT(qt[2012].goal.getItem[1].id) >= qt[2012].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2012].goal.getItem[2].id) >= qt[2012].goal.getItem[2].count and CHECK_ITEM_CNT(qt[2012].goal.getItem[3].id) >= qt[2012].goal.getItem[3].count and CHECK_ITEM_CNT(qt[2012].goal.getItem[4].id) >= qt[2012].goal.getItem[4].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2013].state ~= 2 and qData[2012].state == 2 then
    if qData[2013].state == 1 then
      if CHECK_ITEM_CNT(qt[2013].goal.getItem[1].id) >= qt[2013].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2013].goal.getItem[2].id) >= qt[2013].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2014].state ~= 2 and qData[2013].state == 2 then
    if qData[2014].state == 1 then
      if CHECK_ITEM_CNT(qt[2014].goal.getItem[1].id) >= qt[2014].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
