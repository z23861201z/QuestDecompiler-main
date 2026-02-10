function npcsay(id)
  if id ~= 4215001 then
    return
  end
  clickNPCid = id
  if qData[151].state == 1 then
    NPC_SAY("{0xFFFFFF00}??? ???{END}? ?? ?????")
  end
  if qData[237].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[237].goal.getItem) then
      NPC_SAY("??! ?? ?????. ??? ?????? ???? ?? ??? ??. ?~ ?? ???? ??? ??? ???. ?? ???? ????. ????. ")
      SET_QUEST_STATE(237, 2)
    else
      NPC_SAY("??. ??? ????? ???? ??? ????? {0xFFFFFF00}???? 50?{END}? ??? ????? ??.")
    end
  end
  if qData[1023].state == 1 then
    if CHECK_ITEM_CNT(qt[1023].goal.getItem[1].id) >= qt[1023].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1023, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1024].state == 1 then
    if CHECK_ITEM_CNT(qt[1024].goal.getItem[1].id) >= qt[1024].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1024, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1033].state == 1 then
    if CHECK_ITEM_CNT(qt[1033].goal.getItem[1].id) >= qt[1033].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1033, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1034].state == 1 then
    if CHECK_ITEM_CNT(qt[1034].goal.getItem[1].id) >= qt[1034].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1034, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1025].state == 1 then
    if CHECK_ITEM_CNT(qt[1025].goal.getItem[1].id) >= qt[1025].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1025, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("??????? 1?? ??????")
    end
  end
  if qData[1026].state == 1 then
    if CHECK_ITEM_CNT(qt[1026].goal.getItem[1].id) >= qt[1026].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1026, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("??????? 1?? ??????")
    end
  end
  if qData[1035].state == 1 then
    if CHECK_ITEM_CNT(qt[1035].goal.getItem[1].id) >= qt[1035].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1035, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("??????? 1?? ??????")
    end
  end
  if qData[1036].state == 1 then
    if CHECK_ITEM_CNT(qt[1036].goal.getItem[1].id) >= qt[1036].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1036, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("??????? 1?? ??????")
    end
  end
  if qData[1027].state == 1 then
    if CHECK_ITEM_CNT(qt[1027].goal.getItem[1].id) >= qt[1027].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1027, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1028].state == 1 then
    if CHECK_ITEM_CNT(qt[1028].goal.getItem[1].id) >= qt[1028].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1028, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1037].state == 1 then
    if CHECK_ITEM_CNT(qt[1037].goal.getItem[1].id) >= qt[1037].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1037, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1038].state == 1 then
    if CHECK_ITEM_CNT(qt[1038].goal.getItem[1].id) >= qt[1038].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1038, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1029].state == 1 then
    if CHECK_ITEM_CNT(qt[1029].goal.getItem[1].id) >= qt[1029].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1029, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1030].state == 1 then
    if CHECK_ITEM_CNT(qt[1030].goal.getItem[1].id) >= qt[1030].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1030, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1039].state == 1 then
    if CHECK_ITEM_CNT(qt[1039].goal.getItem[1].id) >= qt[1039].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1039, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1040].state == 1 then
    if CHECK_ITEM_CNT(qt[1040].goal.getItem[1].id) >= qt[1040].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1040, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1031].state == 1 then
    if CHECK_ITEM_CNT(qt[1031].goal.getItem[1].id) >= qt[1031].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1031, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1032].state == 1 then
    if CHECK_ITEM_CNT(qt[1032].goal.getItem[1].id) >= qt[1032].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1032, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1041].state == 1 then
    if CHECK_ITEM_CNT(qt[1041].goal.getItem[1].id) >= qt[1041].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1041, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1042].state == 1 then
    if CHECK_ITEM_CNT(qt[1042].goal.getItem[1].id) >= qt[1042].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?? ????. ?~ ??? ?? ?????. ????.")
        SET_QUEST_STATE(1042, 2)
      else
        NPC_SAY("行囊已满。")
      end
    else
      NPC_SAY("?????? 1?? ??????")
    end
  end
  if qData[1274].state == 1 then
    if CHECK_ITEM_CNT(qt[1274].goal.getItem[1].id) >= qt[1274].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("谢谢。这样的话反而会比定的日程早完成啊。")
        SET_QUEST_STATE(1274, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退铁腕山的白发老妖，收集30个白灰粉回来吧。")
    end
  end
  if qData[1282].state == 1 then
    if CHECK_ITEM_CNT(qt[1282].goal.getItem[1].id) >= qt[1282].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。这下大家都可以安心睡觉了。")
        SET_QUEST_STATE(1282, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("能帮我击退铁腕山的石碑怪，收集30个石碑碎片回来吗？")
    end
  end
  if qData[1296].state == 1 then
    NPC_SAY("哎！你怎么才来啊。")
    SET_QUEST_STATE(1296, 2)
  end
  if qData[1297].state == 1 then
    if CHECK_ITEM_CNT(qt[1297].goal.getItem[1].id) >= qt[1297].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("谢谢。这下人们可以安心了。总之辛苦你了。")
        SET_QUEST_STATE(1297, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退铁腕山的独眼跳跳，收集30个毒囊包回来吧。")
    end
  end
  if qData[1298].state == 1 then
    if CHECK_ITEM_CNT(qt[1298].goal.getItem[1].id) >= qt[1298].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("啊 辛苦了。这是答应你的蓝奇石块。")
        SET_QUEST_STATE(1298, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("通过龙林城井台进入岳秀洞矿山，采集5个蓝奇石回来吧。当然，镐头是要自己花钱购买的。")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10012)
  ADD_UPGRADE_ITEM_BTN(id)
  ADD_EQUIP_REFINE_BTN(id)
  ADD_REPAIR_EQUIPMENT(id)
  RARE_BOX_OPEN(id)
  RARE_BOX_MIXTURE(id)
  if qData[151].state == 0 and GET_PLAYER_FAME() >= 60 then
    ADD_QUEST_BTN(qt[151].id, qt[151].name)
  end
  if qData[237].state == 0 then
    ADD_QUEST_BTN(qt[237].id, qt[237].name)
  end
  if qData[1023].state == 0 and GET_PLAYER_JOB1() == 1 and CHECK_ITEM_CNT(qt[1023].goal.getItem[1].id) >= qt[1023].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1023].id, qt[1023].name)
  end
  if qData[1024].state == 0 and GET_PLAYER_JOB1() == 1 and CHECK_ITEM_CNT(qt[1024].goal.getItem[1].id) >= qt[1024].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1024].id, qt[1024].name)
  end
  if qData[1033].state == 0 and GET_PLAYER_JOB1() == 1 and CHECK_ITEM_CNT(qt[1033].goal.getItem[1].id) >= qt[1033].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1033].id, qt[1033].name)
  end
  if qData[1034].state == 0 and GET_PLAYER_JOB1() == 1 and CHECK_ITEM_CNT(qt[1034].goal.getItem[1].id) >= qt[1034].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1034].id, qt[1034].name)
  end
  if qData[1025].state == 0 and GET_PLAYER_JOB1() == 2 and CHECK_ITEM_CNT(qt[1025].goal.getItem[1].id) >= qt[1025].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1025].id, qt[1025].name)
  end
  if qData[1026].state == 0 and GET_PLAYER_JOB1() == 2 and CHECK_ITEM_CNT(qt[1026].goal.getItem[1].id) >= qt[1026].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1026].id, qt[1026].name)
  end
  if qData[1035].state == 0 and GET_PLAYER_JOB1() == 2 and CHECK_ITEM_CNT(qt[1035].goal.getItem[1].id) >= qt[1035].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1035].id, qt[1035].name)
  end
  if qData[1036].state == 0 and GET_PLAYER_JOB1() == 2 and CHECK_ITEM_CNT(qt[1036].goal.getItem[1].id) >= qt[1036].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1036].id, qt[1036].name)
  end
  if qData[1027].state == 0 and GET_PLAYER_JOB1() == 3 and CHECK_ITEM_CNT(qt[1027].goal.getItem[1].id) >= qt[1027].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1027].id, qt[1027].name)
  end
  if qData[1028].state == 0 and GET_PLAYER_JOB1() == 3 and CHECK_ITEM_CNT(qt[1028].goal.getItem[1].id) >= qt[1028].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1028].id, qt[1028].name)
  end
  if qData[1037].state == 0 and GET_PLAYER_JOB1() == 3 and CHECK_ITEM_CNT(qt[1037].goal.getItem[1].id) >= qt[1037].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1037].id, qt[1037].name)
  end
  if qData[1038].state == 0 and GET_PLAYER_JOB1() == 3 and CHECK_ITEM_CNT(qt[1038].goal.getItem[1].id) >= qt[1038].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1038].id, qt[1038].name)
  end
  if qData[1029].state == 0 and GET_PLAYER_JOB1() == 4 and CHECK_ITEM_CNT(qt[1029].goal.getItem[1].id) >= qt[1029].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1029].id, qt[1029].name)
  end
  if qData[1030].state == 0 and GET_PLAYER_JOB1() == 4 and CHECK_ITEM_CNT(qt[1030].goal.getItem[1].id) >= qt[1030].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1030].id, qt[1030].name)
  end
  if qData[1039].state == 0 and GET_PLAYER_JOB1() == 4 and CHECK_ITEM_CNT(qt[1039].goal.getItem[1].id) >= qt[1039].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1039].id, qt[1039].name)
  end
  if qData[1040].state == 0 and GET_PLAYER_JOB1() == 4 and CHECK_ITEM_CNT(qt[1040].goal.getItem[1].id) >= qt[1040].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1040].id, qt[1040].name)
  end
  if qData[1031].state == 0 and GET_PLAYER_JOB1() == 5 and CHECK_ITEM_CNT(qt[1031].goal.getItem[1].id) >= qt[1031].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1031].id, qt[1031].name)
  end
  if qData[1032].state == 0 and GET_PLAYER_JOB1() == 5 and CHECK_ITEM_CNT(qt[1032].goal.getItem[1].id) >= qt[1032].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1032].id, qt[1032].name)
  end
  if qData[1041].state == 0 and GET_PLAYER_JOB1() == 5 and CHECK_ITEM_CNT(qt[1041].goal.getItem[1].id) >= qt[1041].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1041].id, qt[1041].name)
  end
  if qData[1042].state == 0 and GET_PLAYER_JOB1() == 5 and CHECK_ITEM_CNT(qt[1042].goal.getItem[1].id) >= qt[1042].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1042].id, qt[1042].name)
  end
  if qData[1274].state == 0 and qData[1273].state == 2 and GET_PLAYER_LEVEL() >= qt[1274].needLevel then
    ADD_QUEST_BTN(qt[1274].id, qt[1274].name)
  end
  if qData[1282].state == 0 and GET_PLAYER_LEVEL() >= qt[1282].needLevel then
    ADD_QUEST_BTN(qt[1282].id, qt[1282].name)
  end
  if qData[1297].state == 0 and qData[1296].state == 2 and GET_PLAYER_LEVEL() >= qt[1297].needLevel then
    ADD_QUEST_BTN(qt[1297].id, qt[1297].name)
  end
  if qData[1298].state == 0 and qData[1297].state == 2 and GET_PLAYER_LEVEL() >= qt[1298].needLevel then
    ADD_QUEST_BTN(qt[1298].id, qt[1298].name)
  end
  if qData[901].state == 0 then
    ADD_QUEST_BTN(qt[901].id, qt[901].name)
  end
  if qData[902].state == 0 then
    ADD_QUEST_BTN(qt[902].id, qt[902].name)
  end
  if qData[903].state == 0 then
    ADD_QUEST_BTN(qt[903].id, qt[903].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if (qData[1023].state ~= 2 or qData[1024].state ~= 2 or qData[1033].state ~= 2 or qData[1034].state ~= 2) and GET_PLAYER_JOB1() == 1 and (CHECK_ITEM_CNT(qt[1023].goal.getItem[1].id) >= qt[1023].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1024].goal.getItem[1].id) >= qt[1024].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1033].goal.getItem[1].id) >= qt[1033].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1034].goal.getItem[1].id) >= qt[1034].goal.getItem[1].count) then
    if qData[1023].state == 1 or qData[1024].state == 1 or qData[1033].state == 1 or qData[1034].state == 1 then
      if CHECK_ITEM_CNT(qt[1023].goal.getItem[1].id) >= qt[1023].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1024].goal.getItem[1].id) >= qt[1024].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1033].goal.getItem[1].id) >= qt[1033].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1034].goal.getItem[1].id) >= qt[1034].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[1025].state ~= 2 or qData[1026].state ~= 2 or qData[1035].state ~= 2 or qData[1036].state ~= 2) and GET_PLAYER_JOB1() == 2 and (CHECK_ITEM_CNT(qt[1025].goal.getItem[1].id) >= qt[1025].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1026].goal.getItem[1].id) >= qt[1026].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1035].goal.getItem[1].id) >= qt[1035].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1036].goal.getItem[1].id) >= qt[1036].goal.getItem[1].count) then
    if qData[1025].state == 1 or qData[1026].state == 1 or qData[1035].state == 1 or qData[1036].state == 1 then
      if CHECK_ITEM_CNT(qt[1025].goal.getItem[1].id) >= qt[1025].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1026].goal.getItem[1].id) >= qt[1026].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1035].goal.getItem[1].id) >= qt[1035].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1036].goal.getItem[1].id) >= qt[1036].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[1027].state ~= 2 or qData[1028].state ~= 2 or qData[1037].state ~= 2 or qData[1038].state ~= 2) and GET_PLAYER_JOB1() == 3 and (CHECK_ITEM_CNT(qt[1027].goal.getItem[1].id) >= qt[1027].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1028].goal.getItem[1].id) >= qt[1028].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1037].goal.getItem[1].id) >= qt[1037].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1038].goal.getItem[1].id) >= qt[1038].goal.getItem[1].count) then
    if qData[1027].state == 1 or qData[1028].state == 1 or qData[1037].state == 1 or qData[1038].state == 1 then
      if CHECK_ITEM_CNT(qt[1027].goal.getItem[1].id) >= qt[1027].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1028].goal.getItem[1].id) >= qt[1028].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1037].goal.getItem[1].id) >= qt[1037].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1038].goal.getItem[1].id) >= qt[1038].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[1029].state ~= 2 or qData[1030].state ~= 2 or qData[1039].state ~= 2 or qData[1040].state ~= 2) and GET_PLAYER_JOB1() == 4 and (CHECK_ITEM_CNT(qt[1029].goal.getItem[1].id) >= qt[1029].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1030].goal.getItem[1].id) >= qt[1030].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1039].goal.getItem[1].id) >= qt[1039].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1040].goal.getItem[1].id) >= qt[1040].goal.getItem[1].count) then
    if qData[1029].state == 1 or qData[1030].state == 1 or qData[1039].state == 1 or qData[1040].state == 1 then
      if CHECK_ITEM_CNT(qt[1029].goal.getItem[1].id) >= qt[1029].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1030].goal.getItem[1].id) >= qt[1030].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1039].goal.getItem[1].id) >= qt[1039].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1040].goal.getItem[1].id) >= qt[1040].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[1031].state ~= 2 or qData[1032].state ~= 2 or qData[1041].state ~= 2 or qData[1042].state ~= 2) and GET_PLAYER_JOB1() == 5 and (CHECK_ITEM_CNT(qt[1031].goal.getItem[1].id) >= qt[1031].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1032].goal.getItem[1].id) >= qt[1032].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1041].goal.getItem[1].id) >= qt[1041].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1042].goal.getItem[1].id) >= qt[1042].goal.getItem[1].count) then
    if qData[1031].state == 1 or qData[1032].state == 1 or qData[1041].state == 1 or qData[1042].state == 1 then
      if CHECK_ITEM_CNT(qt[1031].goal.getItem[1].id) >= qt[1031].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1032].goal.getItem[1].id) >= qt[1032].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1041].goal.getItem[1].id) >= qt[1041].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1042].goal.getItem[1].id) >= qt[1042].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1274].state ~= 2 and qData[1273].state == 2 and GET_PLAYER_LEVEL() >= qt[1274].needLevel then
    if qData[1274].state == 1 then
      if CHECK_ITEM_CNT(qt[1274].goal.getItem[1].id) >= qt[1274].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1282].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1282].needLevel then
    if qData[1282].state == 1 then
      if CHECK_ITEM_CNT(qt[1282].goal.getItem[1].id) >= qt[1282].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1296].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1297].state ~= 2 and qData[1296].state == 2 and GET_PLAYER_LEVEL() >= qt[1297].needLevel then
    if qData[1297].state == 1 then
      if CHECK_ITEM_CNT(qt[1297].goal.getItem[1].id) >= qt[1297].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1298].state ~= 2 and qData[1297].state == 2 and GET_PLAYER_LEVEL() >= qt[1298].needLevel then
    if qData[1298].state == 1 then
      if CHECK_ITEM_CNT(qt[1298].goal.getItem[1].id) >= qt[1298].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
