function npcsay(id)
  if id ~= 4222006 then
    return
  end
  clickNPCid = id
  NPC_SAY("哎呀 准备好的料理已经没了，请稍等~哈哈哈")
  if qData[1055].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1055].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("哈哈哈~如果是{0xFFFFFF00}PLAYERNAME{END}的话应该能做好的。来来 我给你奖励吧")
        SET_QUEST_STATE(1055, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("是{0xFFFFFF00}100个种子{END}。要时刻把材料准备充足。再加把劲吧")
    end
  end
  if qData[2714].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2714].goal.getItem) then
      NPC_SAY("哈哈，谢谢！")
      SET_QUEST_STATE(2714, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}干涸的沼泽{END}击退{0xFFFFFF00}志鬼心火{END}收集30个{0xFFFFFF00}志鬼心火火焰{END} ，击退 {0xFFFFFF00}破戒僧{END}收集30个{0xFFFFFF00}咒术仗{END}回来吧。")
    end
  end
  if qData[2800].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2800].goal.getItem) then
      NPC_SAY("哇~这就是{0xFFFFFF00}志鬼心火火焰{END}！")
      SET_QUEST_STATE(2800, 2)
      return
    else
      NPC_SAY("收集15个{0xFFFFFF00}志鬼心火火焰{END}回来吧。")
    end
  end
  if qData[2801].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2801].goal.getItem) then
      NPC_SAY("厉..厉害。")
      SET_QUEST_STATE(2801, 2)
      return
    else
      NPC_SAY("收集30个{0xFFFFFF00}志鬼心火火焰{END}回来吧。")
    end
  end
  if qData[2802].state == 1 then
    if CHECK_ITEM_CNT(qt[2802].goal.getItem[1].id) >= qt[2802].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("来，这是{0xFFFFFF00}调查獐子潭许可证{END}。你随便吧。还有...我们下次见。")
        SET_QUEST_STATE(2802, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("收集30个{0xFFFFFF00}志鬼心火火焰{END}回来吧。这是最后一次了。")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10055)
  if qData[1055].state == 0 then
    ADD_QUEST_BTN(qt[1055].id, qt[1055].name)
  end
  if qData[2714].state == 0 and qData[2713].state == 2 and GET_PLAYER_LEVEL() >= qt[2714].needLevel then
    ADD_QUEST_BTN(qt[2714].id, qt[2714].name)
  end
  if qData[2800].state == 0 and qData[2799].state == 1 and GET_PLAYER_LEVEL() >= qt[2800].needLevel then
    ADD_QUEST_BTN(qt[2800].id, qt[2800].name)
  end
  if qData[2801].state == 0 and qData[2800].state == 2 and GET_PLAYER_LEVEL() >= qt[2801].needLevel then
    ADD_QUEST_BTN(qt[2801].id, qt[2801].name)
  end
  if qData[2802].state == 0 and qData[2801].state == 2 and GET_PLAYER_LEVEL() >= qt[2802].needLevel then
    ADD_QUEST_BTN(qt[2802].id, qt[2802].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1055].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1055].needLevel then
    if qData[1055].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1055].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2714].state ~= 2 and qData[2713].state == 2 and GET_PLAYER_LEVEL() >= qt[2714].needLevel then
    if qData[2714].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2714].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2800].state ~= 2 and qData[2799].state == 1 and GET_PLAYER_LEVEL() >= qt[2800].needLevel then
    if qData[2800].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2800].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2801].state ~= 2 and qData[2800].state == 2 and GET_PLAYER_LEVEL() >= qt[2801].needLevel then
    if qData[2801].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2801].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2802].state ~= 2 and qData[2801].state == 2 and GET_PLAYER_LEVEL() >= qt[2802].needLevel then
    if qData[2802].state == 1 then
      if CHECK_ITEM_CNT(qt[2802].goal.getItem[1].id) >= qt[2802].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
