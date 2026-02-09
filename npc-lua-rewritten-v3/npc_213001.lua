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
  if id ~= 4213001 then
    return
  end
  clickNPCid = id
  if qData[60].state == 1 then
    if CHECK_GUILD_MYUSER() == 1 then
      NPC_SAY("你打算脱离你的门派吗？回去好好想想再来吧。")
      return
    elseif CHECK_INVENTORY_CNT(4) <= 0 then
      NPC_SAY("行囊太沉。")
      return
    elseif qData[60].meetNpc[1] ~= id and CHECK_ITEM_CNT(8910421) >= 15 then
      NPC_QSAY(60, 1)
      SET_INFO(60, 2)
      SET_MEETNPC(60, 1, id)
      return
    elseif qData[60].meetNpc[1] ~= id then
      NPC_SAY("没能收集到{0xFFFFFF00}15个[山参]{END}啊。")
    elseif qData[60].meetNpc[1] == id and qData[60].meetNpc[2] ~= qt[60].goal.meetNpc[2] then
      NPC_SAY("把推荐书给{0xFFFFFF00}白斩姬{END}送去。")
    end
  end
  if qData[64].state == 1 then
    if CHECK_GUILD_MYUSER() == 0 then
      NPC_SAY("你打算脱离你的门派吗？回去好好想想再来吧。")
      return
    elseif CHECK_INVENTORY_CNT(4) <= 0 then
      NPC_SAY("行囊太沉。")
      return
    elseif qData[64].meetNpc[1] ~= id and CHECK_ITEM_CNT(8910421) >= 15 then
      NPC_QSAY(64, 1)
      SET_INFO(64, 2)
      SET_MEETNPC(64, 1, id)
      return
    elseif qData[64].meetNpc[1] ~= id then
      NPC_SAY("没能收集到{0xFFFFFF00}15个[山参]{END}啊。")
    elseif qData[64].meetNpc[1] == id and qData[60].meetNpc[2] ~= qt[60].goal.meetNpc[2] then
      NPC_SAY("把推荐书给{0xFFFFFF00}乌骨鸡{END}送去。")
    end
  end
  if qData[1209].state == 1 then
    NPC_SAY("见到你很高兴。我正在等你呢。")
    SET_QUEST_STATE(1209, 2)
  end
  if qData[81].state == 1 and qData[81].meetNpc[1] == qt[81].goal.meetNpc[1] and qData[81].meetNpc[2] ~= id then
    NPC_QSAY(81, 5)
    SET_INFO(81, 2)
    SET_MEETNPC(81, 2, id)
    return
  end
  if qData[80].state == 1 then
    if qData[80].meetNpc[1] ~= id then
      SET_INFO(80, 1)
      NPC_QSAY(80, 1)
      SET_MEETNPC(80, 1, id)
    elseif qData[80].meetNpc[1] == qt[80].goal.meetNpc[1] and qData[80].meetNpc[2] ~= id then
      if CHECK_ITEM_CNT(8910491) >= 20 then
        if 1 <= CHECK_INVENTORY_CNT(4) then
          SET_MEETNPC(80, 2, id)
          NPC_SAY("好厉害。这么快就收集回来了啊…就像传闻一样啊。我马上就去制作药。那 现在完成了，快拿给冥珠城西边的{0xFFFFFF00}[薇薇安]{END}吧。")
          return
        else
          NPC_SAY("行囊太沉。")
        end
      else
        NPC_SAY("收集来20个[夺命鬼萝莉的舌头]就可以了。")
      end
    elseif qData[80].state == 1 and 1 <= CHECK_ITEM_CNT(8990026) then
      NPC_SAY("好厉害。这么快就收集回来了啊…就像传闻一样啊。我马上就去制作药。那 现在完成了，快拿给冥珠城西边的{0xFFFFFF00}[薇薇安]{END}吧。")
    end
    return
  end
  if qData[84].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[84].goal.getItem) then
      NPC_SAY("???? ?? ????. ??? ?????.. ??? ????? ???? ??? ? ??? ?? ????. ?????. ?? ??? ??????.")
      SET_QUEST_STATE(84, 2)
      return
    else
      NPC_SAY("???? ?? ? ???????  ??? {0xFFFFFF00}[???]? ?? 15?{END} ???.")
    end
  end
  if qData[96].state == 1 and qData[96].meetNpc[1] == qt[96].goal.meetNpc[1] then
    if qData[96].meetNpc[2] ~= qt[96].goal.meetNpc[2] then
      SET_MEETNPC(96, 2, id)
      NPC_QSAY(96, 4)
      return
    else
      NPC_SAY("??? ??? ?????.")
    end
  end
  if qData[97].state == 1 and qData[97].meetNpc[1] == qt[97].goal.meetNpc[1] and qData[97].meetNpc[2] == qt[97].goal.meetNpc[2] and qData[97].meetNpc[3] ~= id then
    NPC_SAY("????? ?? ????? ??? ??? ?? ????? ?? ??? ?????. ?? ???? ?? ?? ?? ???? ?????. ???")
    SET_MEETNPC(97, 3, id)
    SET_QUEST_STATE(97, 2)
  end
  if qData[98].state == 1 and qData[98].meetNpc[1] == qt[98].goal.meetNpc[1] and qData[98].meetNpc[2] == qt[98].goal.meetNpc[2] and qData[98].meetNpc[3] ~= id then
    NPC_SAY("????? ?? ????? ??? ??? ?? ????? ?? ??? ?????. ?? ???? ?? ?? ?? ???? ?????. ???")
    SET_MEETNPC(98, 3, id)
    SET_QUEST_STATE(98, 2)
  end
  if qData[108].state == 1 then
    if qData[108].meetNpc[1] ~= qt[108].goal.meetNpc[1] then
      SET_INFO(108, 1)
      NPC_QSAY(108, 1)
      SET_MEETNPC(108, 1, id)
      return
    elseif CHECK_ITEM_CNT(8820031) < 100 then
      NPC_SAY("{0xFFFFFF00}??(?){END}? 100?? ???????")
    end
  end
  if qData[122].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[122].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[122].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("谢谢你的救命之恩。真是个好人啊。我送你个证明。把那个证书拿给{0xFFFFFF00}[ 白斩姬 ]{END}吧。")
        SET_QUEST_STATE(122, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}25个[ 大胡子的牙齿 ]和25个[ 夺命鬼萝莉的舌头 ]{END}会给正在受苦的庶民点力量的。大胡子和夺命鬼萝莉在冥珠平原。")
    end
  end
  if qData[127].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[127].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[127].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("谢谢。我的不耐烦的语气是因为受了乌骨鸡的指示，要考验你的耐心，请消消气吧。 可以把这个{0xFFFFFF00}证明转给乌骨鸡吗？{END}")
        SET_QUEST_STATE(127, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}25个[ 大胡子的牙齿 ]和25个[ 夺命鬼萝莉的舌头 ]{END}会给正在受苦的庶民点力量的。大胡子和夺命鬼萝莉在冥珠平原。")
    end
  end
  if qData[154].state == 1 and qData[154].meetNpc[1] ~= id and __QUEST_HAS_ALL_ITEMS(qt[154].goal.getItem) then
    SET_MEETNPC(154, 1, id)
    NPC_SAY("? ?? ???!! ??? ?????? ???? ????, ?? ?? ??? ???? ???? ?????!")
    SET_QUEST_STATE(154, 2)
    return
  end
  if qData[201].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[201].goal.getItem) then
      NPC_SAY("?????. ?????. ???? ??? ??? ?? ? ????. ????? ??? ??? ??? ??? ????. ?? ?????.")
      SET_QUEST_STATE(201, 2)
      return
    else
      NPC_SAY("????? ??? ?? ?? ?? ????. ?? {0xFFFFFF00}[??????] 20?{END}? ???? ??? ?????.")
    end
  end
  if qData[338].state == 1 and qData[338].meetNpc[1] == qt[338].goal.meetNpc[1] then
    NPC_SAY("?? {0xFFFFFF00}'??? ??'{END} ????? ?? ??? ??? ?? ???. ??.")
    SET_MEETNPC(338, 2, id)
    SET_QUEST_STATE(338, 2)
    return
  end
  if qData[339].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[339].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("?, ?? ???????. ?, ????? ?? ?? ????? ?????? ? ?? ??? ?????.")
        SET_QUEST_STATE(339, 2)
        return
      else
        NPC_SAY("行囊不足。")
      end
    else
      NPC_SAY("?? ??? ??????? {0xFFFFFF00}'?????'{END}? ??? ??? ???.")
    end
  end
  if qData[340].state == 1 then
    NPC_SAY("?? ??? ??? ?????. ? ??? ??? ???.")
  end
  if qData[342].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[342].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[342].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[342].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[342].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("?~ ??? ??????. ??? ?????…. ?! ??????.")
        SET_QUEST_STATE(342, 2)
        return
      else
        NPC_SAY("行囊不足。")
      end
    else
      NPC_SAY("{0xFFFFFF00}?,?,?,? ????? ?? ?? 60?{END}????. ?? ??? ???? ?? ????? {0xFFFFFF00}??? ??{END}? ?? ??? ?? ???. ?? ?????.")
    end
  end
  if qData[348].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[348].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("?????. ?? ?????. ?? ? ??? ?? ???. ??? ???? ??? ? ????.")
        SET_QUEST_STATE(348, 2)
        return
      else
        NPC_SAY("行囊不足。")
      end
    else
      NPC_SAY("?? {0xFFFFFF00}[?????] 20?{END}? ??? ???. ???? ?????? ??? ???.")
    end
  end
  if qData[548].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[548].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[548].goal.getItem) then
    NPC_SAY("?? ??? ??????")
    SET_QUEST_STATE(548, 2)
  end
  if qData[549].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[549].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[549].goal.getItem) then
      NPC_SAY("???? ?? ???. ?? ????.")
      SET_QUEST_STATE(549, 2)
    else
      NPC_SAY("????? ???? ???? ????. ?? ?????? 30?? ???? 40?? ??? ???.")
    end
  end
  if qData[550].state == 1 then
    NPC_SAY("? ???????? ?????.")
  end
  if qData[551].state == 1 and qData[551].meetNpc[1] ~= id then
    NPC_SAY("???.. ????.")
    SET_MEETNPC(551, 1, id)
    SET_QUEST_STATE(551, 2)
  end
  if qData[552].state == 1 then
    NPC_SAY("?? ???????? ? ?? ??? ???.")
  end
  if qData[555].state == 1 then
    if qData[555].killMonster[qt[555].goal.killMonster[1].id] >= qt[555].goal.killMonster[1].count then
      NPC_SAY("??? ?? ?????? ?????. ?? PLAYERNAME?????.")
      SET_QUEST_STATE(555, 2)
    else
      NPC_SAY("{0xFFFFFF00}[??] 20??{END}? ???????, ? ??? ?????, ??? ???? ?? ?? ?? ?? ????.")
    end
  end
  if qData[862].state == 1 and qData[862].meetNpc[1] == qt[862].goal.meetNpc[1] and qData[862].meetNpc[2] ~= id then
    NPC_QSAY(862, 5)
    SET_INFO(862, 2)
    SET_MEETNPC(862, 2, id)
    return
  end
  if qData[1212].state == 1 then
    if GET_PLAYER_FACTION() == 1 or GET_PLAYER_FACTION() == 0 or GET_PLAYER_FACTION() == 2 then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("见到你很高兴。我正在等你呢。")
        SET_QUEST_STATE(1212, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去找{0xFFFFFF00}清阴关南边和北边{END}的{0xFFFFFF00}白斩姬姑娘和乌骨鸡大侠{END}选择{0xFFFFFF00}派系后{END}回到我这边吧。")
    end
  end
  if qData[1213].state == 1 then
    NPC_SAY("去冥珠城东边的老当家处帮忙吧。")
  end
  if qData[1264].state == 1 then
    NPC_SAY("去冥珠城东边的老当家处帮忙吧。")
  end
  ADD_NEW_SHOP_BTN(id, 10005)
  GIVE_DONATION_BUFF(id)
  if (qData[118].state == 1 or qData[119].state == 1 or qData[120].state == 1 or qData[381].state == 1 or qData[627].state == 1 or qData[2083].state == 1) and qData[121].state == 2 and qData[122].state == 0 then
    ADD_QUEST_BTN(qt[122].id, qt[122].name)
  end
  if (qData[123].state == 1 or qData[124].state == 1 or qData[125].state == 1 or qData[382].state == 1 or qData[631].state == 1 or qData[2087].state == 1) and qData[126].state == 2 and qData[127].state == 0 then
    ADD_QUEST_BTN(qt[127].id, qt[127].name)
  end
  if qData[549].state == 0 and qData[548].state == 2 then
    ADD_QUEST_BTN(qt[549].id, qt[549].name)
  end
  if qData[550].state == 0 and qData[549].state == 2 then
    ADD_QUEST_BTN(qt[550].id, qt[550].name)
  end
  if qData[552].state == 0 and qData[551].state == 2 then
    ADD_QUEST_BTN(qt[552].id, qt[552].name)
  end
  if qData[1212].state == 0 and qData[1209].state == 2 and GET_PLAYER_LEVEL() >= qt[1212].needLevel then
    ADD_QUEST_BTN(qt[1212].id, qt[1212].name)
  end
  if qData[1213].state == 0 and GET_PLAYER_LEVEL() >= qt[1213].needLevel and GET_PLAYER_FACTION() == 0 then
    ADD_QUEST_BTN(qt[1213].id, qt[1213].name)
  end
  if qData[1264].state == 0 and GET_PLAYER_LEVEL() >= qt[1264].needLevel and GET_PLAYER_FACTION() == 1 then
    ADD_QUEST_BTN(qt[1264].id, qt[1264].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[60].state == 1 and GET_PLAYER_LEVEL() >= qt[60].needLevel then
    if qData[60].meetNpc[1] ~= id and CHECK_ITEM_CNT(8910421) >= 15 then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[64].state == 1 and GET_PLAYER_LEVEL() >= qt[64].needLevel then
    if qData[64].meetNpc[1] ~= id and CHECK_ITEM_CNT(8910421) >= 15 then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[80].state == 1 and GET_PLAYER_LEVEL() >= qt[80].needLevel then
    if qData[80].state == 1 and CHECK_ITEM_CNT(8910491) >= 20 then
      QSTATE(id, 2)
    elseif qData[80].state == 1 and CHECK_ITEM_CNT(8990026) ~= 1 then
      QSTATE(id, 1)
    end
  end
  if qData[81].state == 1 and qData[81].meetNpc[1] == qt[81].goal.meetNpc[1] and qData[81].meetNpc[2] ~= id then
    QSTATE(id, 1)
  end
  if (qData[118].state == 1 or qData[119].state == 1 or qData[120].state == 1 or qData[381].state == 1 or qData[627].state == 1 or qData[2083].state == 1) and qData[121].state == 2 and qData[122].state ~= 2 and GET_PLAYER_LEVEL() >= qt[122].needLevel then
    if __QUEST_HAS_ALL_ITEMS(qt[122].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[122].goal.getItem) then
      QSTATE(id, 2)
    elseif qData[122].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if (qData[123].state == 1 or qData[124].state == 1 or qData[125].state == 1 or qData[382].state == 1 or qData[631].state == 1 or qData[2087].state == 1) and qData[127].state ~= 2 and GET_PLAYER_LEVEL() >= qt[127].needLevel then
    if __QUEST_HAS_ALL_ITEMS(qt[127].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[127].goal.getItem) then
      QSTATE(id, 2)
    elseif qData[127].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1212].state ~= 2 then
    if qData[1212].state == 1 then
      if (GET_PLAYER_FACTION() == 1 or GET_PLAYER_FACTION() == 0) and 1 <= CHECK_INVENTORY_CNT(3) then
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
