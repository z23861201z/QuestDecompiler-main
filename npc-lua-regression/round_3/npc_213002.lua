function npcsay(id)
  if id ~= 4213002 then
    return
  end
  clickNPCid = id
  if qData[104].state == 1 then
    if qData[104].meetNpc[1] ~= qt[104].goal.meetNpc[1] then
      NPC_QSAY(104, 1)
      SET_MEETNPC(104, 1, id)
      return
    else
      NPC_SAY("只要你肯卖{0xFFFFFF00}珠子{END}，价格包你满意！")
    end
  end
  if qData[101].state == 1 then
    if qData[101].meetNpc[1] ~= qt[101].goal.meetNpc[1] then
      NPC_QSAY(101, 1)
      SET_MEETNPC(101, 1, id)
      return
    else
      NPC_SAY("只要你肯卖{0xFFFFFF00}珠子{END}，价格包你满意！")
    end
  end
  if qData[82].state == 1 then
    if 1 <= CHECK_ITEM_CNT(8910501) then
      if qData[82].meetNpc[1] ~= id then
        SET_INFO(82, 2)
        NPC_QSAY(82, 1)
        SET_MEETNPC(82, 1, id)
        return
      end
    elseif qData[82].meetNpc[1] ~= qt[82].goal.meetNpc[1] then
      NPC_SAY("需要{0xFFFFFF00}1张鸡冠呛符咒{END}")
    end
  end
  if qData[93].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[93].goal.getItem) then
      NPC_SAY("你帮我找回了我的传家宝，真的很谢谢，礼物虽小，却是我的心意。\n")
      SET_QUEST_STATE(93, 2)
    else
      NPC_SAY("请一定要帮我找到，听说冥珠城南的建筑上有[偷笔怪盗]出现，应该是他没错！")
    end
  end
  if qData[94].state == 1 then
    NPC_SAY("我弟弟是{0xFFFFFF00}[清阴关]{END}的{0xFFFFFF00}[哞读册]{END}，快把{0xFFFFFF00}传家宝{END}交给我弟弟吧！")
  end
  if qData[96].state == 1 then
    if qData[96].meetNpc[1] ~= qt[96].goal.meetNpc[1] then
      SET_MEETNPC(96, 1, id)
      NPC_QSAY(96, 1)
      return
    else
      NPC_SAY("利息太高了，没法还啊！")
    end
  end
  if qData[450].state == 1 and qData[450].meetNpc[1] == qt[450].goal.meetNpc[1] then
    if __QUEST_HAS_ALL_ITEMS(qt[450].goal.getItem) then
      NPC_SAY(qt[450].npcsay[2])
      SET_QUEST_STATE(450, 2)
      return
    else
      NPC_SAY(qt[450].npcsay[4])
    end
  end
  if qData[451].state == 1 and qData[451].meetNpc[1] ~= id then
    NPC_SAY(qt[451].npcsay[1])
    SET_MEETNPC(451, 1, id)
    return
  end
  if qData[1086].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1086].goal.getItem) then
      if CHECK_INVENTORY_CNT(3) > 0 then
        NPC_SAY("好美味！如果你还有剩下的巧克力，我都要了，我是一个很注重生活品质的男人。这是对美味巧克力的报答，恩恩，那就下次再见吧！")
        SET_QUEST_STATE(1086, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("不是说要给巧克力礼盒的吗，不会是骗我的吧？")
    end
  end
  if qData[1094].state == 1 then
    if CHECK_ITEM_CNT(qt[1094].goal.getItem[1].id) >= qt[1094].goal.getItem[1].count then
      if CHECK_INVENTORY_CNT(3) > 0 then
        NPC_SAY("呼…之前的债都还清了吧？如果你拿来材料，我还是可以帮你制作糖果的，我是一个有风度的男人")
        SET_QUEST_STATE(1094, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("是10个糖块。快点吧，我都着急了！")
    end
  end
  if qData[1217].state == 1 then
    NPC_SAY("啊！少侠就是冥珠城武器店说的那位？")
    SET_QUEST_STATE(1217, 2)
    return
  end
  if qData[1218].state == 1 then
    if CHECK_ITEM_CNT(qt[1218].goal.getItem[1].id) >= qt[1218].goal.getItem[1].count then
      if CHECK_INVENTORY_CNT(2) > 0 then
        NPC_SAY("啊，找回来了？我没想到偷笔怪盗是处于那样的考虑才这样做的。")
        SET_QUEST_STATE(1218, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("听说偷笔怪盗经常路过冥珠城南边的建筑上头。你去找找他，帮我取回黄金佛像吧。")
    end
  end
  if qData[1219].state == 1 then
    NPC_SAY("把黄金佛像转交给冥珠城南边的偷笔怪盗吧。")
  end
  ADD_NEW_SHOP_BTN(id, 10008)
  ADD_MOVESOUL_BTN(id)
  ADD_ENCHANT_BTN(id)
  ADD_PURIFICATION_BTN(id)
  if qData[1094].state == 0 then
    ADD_QUEST_BTN(qt[1094].id, qt[1094].name)
  end
  if qData[1218].state == 0 and qData[1217].state == 2 and GET_PLAYER_LEVEL() >= qt[1218].needLevel then
    ADD_QUEST_BTN(qt[1218].id, qt[1218].name)
  end
  if qData[1219].state == 0 and qData[1218].state == 2 and GET_PLAYER_LEVEL() >= qt[1219].needLevel then
    ADD_QUEST_BTN(qt[1219].id, qt[1219].name)
  end
  if qData[868].state == 0 and GET_PLAYER_LEVEL() >= qt[868].needLevel then
    ADD_QUEST_BTN(qt[868].id, qt[868].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1217].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1218].state == 0 and qData[1217].state == 2 and GET_PLAYER_LEVEL() >= qt[1218].needLevel then
    QSTATE(id, 0)
  end
  if qData[1218].state == 1 and CHECK_ITEM_CNT(qt[1218].goal.getItem[1].id) >= qt[1218].goal.getItem[1].count then
    if 0 < CHECK_INVENTORY_CNT(2) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1219].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1219].state == 0 and qData[1218].state == 2 and GET_PLAYER_LEVEL() >= qt[1219].needLevel then
    QSTATE(id, 0)
  end
  if qData[82].state == 1 and GET_PLAYER_LEVEL() >= qt[82].needLevel then
    if 1 <= CHECK_ITEM_CNT(8910501) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[93].state ~= 2 and GET_PLAYER_LEVEL() >= qt[93].needLevel then
    if __QUEST_HAS_ALL_ITEMS(qt[93].goal.getItem) then
      QSTATE(id, 2)
    elseif qData[93].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[93].state == 2 and qData[94].state ~= 2 and GET_PLAYER_LEVEL() >= qt[94].needLevel then
    if qData[94].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[450].state == 1 and GET_PLAYER_LEVEL() >= qt[450].needLevel then
    if qData[450].meetNpc[1] == qt[450].goal.meetNpc[1] and __QUEST_HAS_ALL_ITEMS(qt[450].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[451].state == 1 and GET_PLAYER_LEVEL() >= qt[451].needLevel and qData[451].meetNpc[1] ~= id then
    QSTATE(id, 1)
  end
  if qData[1086].state == 1 and GET_PLAYER_LEVEL() >= qt[1086].needLevel then
    if __QUEST_HAS_ALL_ITEMS(qt[1086].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  else
    QSTATE(id, 0)
  end
end
