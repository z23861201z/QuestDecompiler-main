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
  if id ~= 4215004 then
    return
  end
  clickNPCid = id
  if qData[160].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[160].goal.getItem) then
      NPC_SAY("????! ?? ??????. ???? ???? ?? ????? ??…. ???. ????. ??? ??? ???? ?, ?? ????~")
      SET_QUEST_STATE(160, 2)
    else
      NPC_SAY("??~ ??? ?????? ???? ?????~ ??? ?? {0xFFFFFF00}?????? 20?{END}? ?? ???. ?? ??? ??? ???? ???~")
    end
  end
  if qData[164].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[164].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("??! ?????. ? ??? ???? ??? ????. ?????. ?? ????? ?????.")
        SET_QUEST_STATE(164, 2)
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("???? {0xFFFFFF00}??? ? 40?{END}? ??????")
    end
  end
  if qData[275].state == 1 then
    NPC_SAY("?? ???. ?? ???? ???? ?????.")
    SET_MEETNPC(275, 1, id)
    SET_QUEST_STATE(275, 2)
  end
  if qData[276].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[276].goal.getItem) then
      NPC_SAY("?? ??? ? ?? ??? ? ??? ????.")
      SET_QUEST_STATE(276, 2)
    else
      NPC_SAY("??? ? ??? ?????? {0xFFFFFF00}????? 50?? ????? 50?, ????? 50?, ????? 50?{END}? ??? ???.")
    end
  end
  if qData[277].state == 1 then
    NPC_SAY("{0xFFFFFF00}???? ??? ??? ?????{END}? ??? ???.")
  end
  if qData[451].state == 1 and qData[451].meetNpc[1] == qt[451].goal.meetNpc[1] then
    if __QUEST_HAS_ALL_ITEMS(qt[451].goal.getItem) then
      NPC_SAY(qt[451].npcsay[2])
      SET_QUEST_STATE(451, 2)
      return
    else
      NPC_SAY(qt[451].npcsay[4])
    end
  end
  if qData[517].state == 1 and qData[517].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(517, 1, id)
    SET_QUEST_STATE(517, 2)
    return
  end
  if qData[521].state == 1 and qData[521].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(521, 1, id)
    SET_QUEST_STATE(521, 2)
    return
  end
  if qData[525].state == 1 and qData[525].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(525, 1, id)
    SET_QUEST_STATE(525, 2)
    return
  end
  if qData[529].state == 1 and qData[529].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(529, 1, id)
    SET_QUEST_STATE(529, 2)
    return
  end
  if qData[669].state == 1 and qData[669].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(669, 1, id)
    SET_QUEST_STATE(669, 2)
    return
  end
  if qData[2096].state == 1 and qData[2096].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(2096, 1, id)
    SET_QUEST_STATE(2096, 2)
    return
  end
  if qData[519].state == 1 and qData[519].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(519, 1, id)
    SET_QUEST_STATE(519, 2)
    return
  end
  if qData[523].state == 1 and qData[523].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(523, 1, id)
    SET_QUEST_STATE(523, 2)
    return
  end
  if qData[527].state == 1 and qData[527].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(527, 1, id)
    SET_QUEST_STATE(527, 2)
    return
  end
  if qData[531].state == 1 and qData[531].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(531, 1, id)
    SET_QUEST_STATE(531, 2)
    return
  end
  if qData[671].state == 1 and qData[671].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(671, 1, id)
    SET_QUEST_STATE(671, 2)
    return
  end
  if qData[2098].state == 1 and qData[2098].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(2098, 1, id)
    SET_QUEST_STATE(2098, 2)
    return
  end
  if qData[1530].state == 1 and qData[1530].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(1530, 1, id)
    SET_QUEST_STATE(1530, 2)
    return
  end
  if qData[1569].state == 1 and qData[1569].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(1569, 1, id)
    SET_QUEST_STATE(1569, 2)
    return
  end
  if qData[2268].state == 1 and qData[2268].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(2268, 1, id)
    SET_QUEST_STATE(2268, 2)
    return
  end
  if qData[2621].state == 1 and qData[2621].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(2621, 1, id)
    SET_QUEST_STATE(2621, 2)
    return
  end
  if qData[2773].state == 1 and qData[2773].meetNpc[1] ~= id then
    NPC_SAY("是不明来历的僧人委托的书吗？那个书名叫金刚书，书没有找到，但是书的内容我知道了。")
    SET_MEETNPC(2773, 1, id)
    SET_QUEST_STATE(2773, 2)
    return
  end
  if qData[518].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[522].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[526].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[530].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[670].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[2097].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[520].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[524].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[528].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[532].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[672].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[2099].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[1531].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[1570].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[2269].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。")
    return
  end
  if qData[2622].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。 ")
    return
  end
  if qData[2774].state == 1 then
    NPC_SAY("先师说过，能抵挡100个地狱狂牛的突进就可以学习。 ")
    return
  end
  if qData[556].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[556].goal.getItem) then
      NPC_SAY("??? ?? ???? ????, ?? ??????.")
      SET_QUEST_STATE(556, 2)
      return
    else
      NPC_SAY("???? ???? ????? ?? ? ????. 50?? ???? ???? ?? ???? ??? ???? ??? ? ? ?? ???.")
      return
    end
  end
  if qData[1283].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1283].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("来了啊！现在只希望她们的冤魂能够得到慰藉。")
        SET_QUEST_STATE(1283, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退铁腕山的饿死鬼，收集30个水瓢回来吧。我会在此准备祭祀的。")
    end
  end
  if qData[1305].state == 1 then
    NPC_SAY("额，来了啊？")
    SET_QUEST_STATE(1305, 2)
  end
  if qData[1306].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1306].goal.getItem) then
      NPC_SAY("好。果真拥有一身好武艺啊。")
      SET_QUEST_STATE(1306, 2)
    else
      NPC_SAY("击退铁腕山的夜光魔，收集30个夜光粉回来吧。之后再给你往下讲。")
    end
  end
  if qData[1307].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1307].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。之后是…。")
        SET_QUEST_STATE(1307, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退铁腕谷的树妖，收集30个树枝回来吧。")
    end
  end
  if qData[1308].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1308].goal.getItem) then
      NPC_SAY("谢谢。现在应该可以进行调查了。")
      SET_QUEST_STATE(1308, 2)
    else
      NPC_SAY("你可以击退铁腕谷的魔蛋，帮我收集回来30个魔蛋符咒吗？")
    end
  end
  if qData[1309].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1309].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("嗯。还纹丝不动？这次试着击退别的怪物看看？")
        SET_QUEST_STATE(1309, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退铁腕谷的魔蛋，帮我收集回来30个魔蛋符咒吧。")
    end
  end
  if qData[1310].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1310].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("太了不起了！但是十二妖怪还纹丝不动呢。会是什么原因呢？")
        SET_QUEST_STATE(1310, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退铁腕谷的树妖、夜光魔、魔蛋这三个怪物，收集树枝、夜光粉和魔蛋符咒各10个回来吧。")
    end
  end
  if qData[1311].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1311].goal.getItem) then
      NPC_SAY("现在魔必方也消停了不少啊。")
      SET_QUEST_STATE(1311, 2)
    else
      NPC_SAY("击退铁腕谷的魔必方，收集30个魔必方爪回来吧。")
    end
  end
  if qData[1312].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1312].goal.getItem) then
      NPC_SAY("谢谢。现在暂时不用担心神檀树了。")
      SET_QUEST_STATE(1312, 2)
    else
      NPC_SAY("击退铁腕谷的九尾妖狐，收集30个狐尾回来吧。")
    end
  end
  if qData[1313].state == 1 then
    NPC_SAY("龙林派师弟在龙林城的南边。")
  end
  ADD_NEW_SHOP_BTN(id, 10015)
  ADD_MOVESOUL_BTN(id)
  ADD_ENCHANT_BTN(id)
  ADD_PURIFICATION_BTN(id)
  if qData[160].state == 0 then
    ADD_QUEST_BTN(qt[160].id, qt[160].name)
  end
  if qData[164].state == 0 and GET_PLAYER_FAME() >= 75 then
    ADD_QUEST_BTN(qt[164].id, qt[164].name)
  end
  if qData[275].state == 2 and qData[276].state == 0 then
    ADD_QUEST_BTN(qt[276].id, qt[276].name)
  end
  if qData[276].state == 2 and qData[277].state == 0 then
    ADD_QUEST_BTN(qt[277].id, qt[277].name)
  end
  if qData[533].state == 2 and qData[517].state == 2 and qData[518].state == 0 then
    ADD_QUEST_BTN(qt[518].id, qt[518].name)
  end
  if qData[533].state == 2 and qData[521].state == 2 and qData[522].state == 0 then
    ADD_QUEST_BTN(qt[522].id, qt[522].name)
  end
  if qData[533].state == 2 and qData[525].state == 2 and qData[526].state == 0 then
    ADD_QUEST_BTN(qt[526].id, qt[526].name)
  end
  if qData[533].state == 2 and qData[529].state == 2 and qData[530].state == 0 then
    ADD_QUEST_BTN(qt[530].id, qt[530].name)
  end
  if qData[533].state == 2 and qData[669].state == 2 and qData[670].state == 0 then
    ADD_QUEST_BTN(qt[670].id, qt[670].name)
  end
  if qData[533].state == 2 and qData[2096].state == 2 and qData[2097].state == 0 then
    ADD_QUEST_BTN(qt[2097].id, qt[2097].name)
  end
  if qData[533].state == 2 and qData[519].state == 2 and qData[520].state == 0 then
    ADD_QUEST_BTN(qt[520].id, qt[520].name)
  end
  if qData[533].state == 2 and qData[523].state == 2 and qData[524].state == 0 then
    ADD_QUEST_BTN(qt[524].id, qt[524].name)
  end
  if qData[533].state == 2 and qData[527].state == 2 and qData[528].state == 0 then
    ADD_QUEST_BTN(qt[528].id, qt[528].name)
  end
  if qData[533].state == 2 and qData[531].state == 2 and qData[532].state == 0 then
    ADD_QUEST_BTN(qt[532].id, qt[532].name)
  end
  if qData[533].state == 2 and qData[671].state == 2 and qData[672].state == 0 then
    ADD_QUEST_BTN(qt[672].id, qt[672].name)
  end
  if qData[533].state == 2 and qData[2098].state == 2 and qData[2099].state == 0 then
    ADD_QUEST_BTN(qt[2099].id, qt[2099].name)
  end
  if qData[533].state == 2 and qData[1530].state == 2 and qData[1531].state == 0 then
    ADD_QUEST_BTN(qt[1531].id, qt[1531].name)
  end
  if qData[533].state == 2 and qData[1569].state == 2 and qData[1570].state == 0 then
    ADD_QUEST_BTN(qt[1570].id, qt[1570].name)
  end
  if qData[533].state == 2 and qData[2268].state == 2 and qData[2269].state == 0 then
    ADD_QUEST_BTN(qt[2269].id, qt[2269].name)
  end
  if qData[533].state == 2 and qData[2621].state == 2 and qData[2622].state == 0 then
    ADD_QUEST_BTN(qt[2622].id, qt[2622].name)
  end
  if qData[533].state == 2 and qData[2773].state == 2 and qData[2774].state == 0 then
    ADD_QUEST_BTN(qt[2774].id, qt[2774].name)
  end
  if qData[556].state == 0 then
    ADD_QUEST_BTN(qt[556].id, qt[556].name)
  end
  if qData[1283].state == 0 and GET_PLAYER_LEVEL() >= qt[1283].needLevel then
    ADD_QUEST_BTN(qt[1283].id, qt[1283].name)
  end
  if qData[1306].state == 0 and qData[1305].state == 2 and GET_PLAYER_LEVEL() >= qt[1306].needLevel then
    ADD_QUEST_BTN(qt[1306].id, qt[1306].name)
  end
  if qData[1307].state == 0 and qData[1306].state == 2 and GET_PLAYER_LEVEL() >= qt[1307].needLevel then
    ADD_QUEST_BTN(qt[1307].id, qt[1307].name)
  end
  if qData[1308].state == 0 and qData[1307].state == 2 and GET_PLAYER_LEVEL() >= qt[1308].needLevel then
    ADD_QUEST_BTN(qt[1308].id, qt[1308].name)
  end
  if qData[1309].state == 0 and qData[1308].state == 2 and GET_PLAYER_LEVEL() >= qt[1309].needLevel then
    ADD_QUEST_BTN(qt[1309].id, qt[1309].name)
  end
  if qData[1310].state == 0 and qData[1309].state == 2 and GET_PLAYER_LEVEL() >= qt[1310].needLevel then
    ADD_QUEST_BTN(qt[1310].id, qt[1310].name)
  end
  if qData[1311].state == 0 and qData[1310].state == 2 and GET_PLAYER_LEVEL() >= qt[1311].needLevel then
    ADD_QUEST_BTN(qt[1311].id, qt[1311].name)
  end
  if qData[1312].state == 0 and qData[1311].state == 2 and GET_PLAYER_LEVEL() >= qt[1312].needLevel then
    ADD_QUEST_BTN(qt[1312].id, qt[1312].name)
  end
  if qData[1313].state == 0 and qData[1312].state == 2 and GET_PLAYER_LEVEL() >= qt[1313].needLevel then
    ADD_QUEST_BTN(qt[1313].id, qt[1313].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[275].state == 1 and GET_PLAYER_LEVEL() >= qt[275].needLevel then
    QSTATE(id, 2)
  end
  if qData[276].state ~= 2 and qData[275].state == 2 and GET_PLAYER_LEVEL() >= qt[276].needLevel then
    if qData[276].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[276].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[277].state ~= 2 and qData[276].state == 2 and GET_PLAYER_LEVEL() >= qt[277].needLevel then
    if qData[277].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if (qData[517].state == 1 or qData[521].state == 1 or qData[525].state == 1 or qData[529].state == 1 or qData[669].state == 1 or qData[2096].state == 1 or qData[519].state == 1 or qData[523].state == 1 or qData[527].state == 1 or qData[531].state == 1 or qData[671].state == 1 or qData[2098].state == 1 or qData[1530].state == 1 or qData[1569].state == 1 or qData[2268].state == 1 or qData[2621].state == 1 or qData[2773].state == 1) and (qData[517].meetNpc[1] ~= id or qData[521].meetNpc[1] ~= id or qData[525].meetNpc[1] ~= id or qData[529].meetNpc[1] ~= id or qData[669].meetNpc[1] ~= id or qData[2096].meetNpc[1] ~= id or qData[519].meetNpc[1] ~= id or qData[523].meetNpc[1] ~= id or qData[527].meetNpc[1] ~= id or qData[531].meetNpc[1] ~= id or qData[671].meetNpc[1] ~= id or qData[2098].meetNpc[1] ~= id or qData[1530].meetNpc[1] ~= id or qData[1569].meetNpc[1] ~= id or qData[2268].meetNpc[1] ~= id or qData[2621].meetNpc[1] ~= id or qData[2773].meetNpc[1] ~= id) then
    QSTATE(id, 2)
  end
  if qData[533].state == 2 and (qData[517].state == 2 or qData[521].state == 2 or qData[525].state == 2 or qData[529].state == 2 or qData[669].state == 2 or qData[2096].state == 2 or qData[519].state == 2 or qData[523].state == 2 or qData[527].state == 2 or qData[531].state == 2 or qData[671].state == 2 or qData[2098].state == 2 or qData[1530].state == 2 or qData[1569].state == 2 or qData[2268].state == 2 or qData[2621].state == 2 or qData[2773].state == 2) and (qData[518].state ~= 2 or qData[522].state ~= 2 or qData[526].state ~= 2 or qData[530].state ~= 2 or qData[670].state ~= 2 or qData[2097].state ~= 2 or qData[520].state ~= 2 or qData[524].state ~= 2 or qData[528].state ~= 2 or qData[532].state ~= 2 or qData[672].state ~= 2 or qData[2099].state ~= 2 or qData[1531].state ~= 2 or qData[1570].state ~= 2 or qData[2269].state ~= 2 or qData[2622].state ~= 2 or qData[2774].state ~= 2) then
    if qData[518].state == 1 or qData[522].state == 1 or qData[526].state == 1 or qData[530].state == 1 or qData[670].state == 1 or qData[2097].state == 1 or qData[520].state == 1 or qData[524].state == 1 or qData[528].state == 1 or qData[532].state == 1 or qData[672].state == 1 or qData[2099].state == 1 or qData[1531].state == 1 or qData[1570].state == 1 or qData[2269].state == 1 or qData[2622].state == 1 or qData[2774].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1283].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1283].needLevel then
    if qData[1283].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1283].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1305].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1306].state ~= 2 and qData[1305].state == 2 and GET_PLAYER_LEVEL() >= qt[1306].needLevel then
    if qData[1306].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1306].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1307].state ~= 2 and qData[1306].state == 2 and GET_PLAYER_LEVEL() >= qt[1307].needLevel then
    if qData[1307].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1307].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1308].state ~= 2 and qData[1307].state == 2 and GET_PLAYER_LEVEL() >= qt[1308].needLevel then
    if qData[1308].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1308].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1309].state ~= 2 and qData[1308].state == 2 and GET_PLAYER_LEVEL() >= qt[1309].needLevel then
    if qData[1309].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1309].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1310].state ~= 2 and qData[1309].state == 2 and GET_PLAYER_LEVEL() >= qt[1310].needLevel then
    if qData[1310].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1310].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1311].state ~= 2 and qData[1310].state == 2 and GET_PLAYER_LEVEL() >= qt[1311].needLevel then
    if qData[1311].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1311].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1312].state ~= 2 and qData[1311].state == 2 and GET_PLAYER_LEVEL() >= qt[1312].needLevel then
    if qData[1312].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1312].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1313].state ~= 2 and qData[1312].state == 2 and GET_PLAYER_LEVEL() >= qt[1313].needLevel then
    if qData[1313].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
