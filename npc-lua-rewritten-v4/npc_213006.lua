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
  if id ~= 4213006 then
    return
  end
  clickNPCid = id
  if qData[57].state == 1 then
    if qData[57].killMonster[qt[57].goal.killMonster[1].id] >= qt[57].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}PLAYERNAME{END}???? ????? ??? ????? ??????. ?? ? ??? ?????. ?.. ??? ?? ?? ??? ??? ???? ??????.")
      SET_QUEST_STATE(57, 2)
    else
      NPC_SAY("{0xFFFFFF00}[????] 20??{END}? ??????")
    end
  end
  if qData[132].state == 1 then
    if qData[132].meetNpc[1] ~= id then
      SET_INFO(132, 2)
      SET_MEETNPC(132, 1, id)
      NPC_QSAY(132, 1)
      return
    elseif __QUEST_HAS_ALL_ITEMS(qt[132].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("?? ???????. ??? ??? ???? ?? ?? ?? ?? ??? ????, {0xFFFFFF00}'???'?{END}? ??? ?? ?? ????????.")
        SET_QUEST_STATE(132, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("??? ???? {0xFFFFFF00}?? ???{END}? ?? ??? {0xFFFFFF00}???{END}? ?? ??? ?? ??? ???? ?? ?????.")
    end
  end
  if qData[133].state == 1 then
    NPC_SAY("{0xFFFFFF00}??{END}? {0xFFFFFF00}????{END}??? ?? ? ??? ???.")
  end
  if qData[338].state == 1 then
    if qData[338].meetNpc[1] ~= id then
      SET_INFO(338, 1)
      SET_MEETNPC(338, 1, id)
      NPC_QSAY(338, 1)
      return
    else
      NPC_SAY("??? ??? ??? ????. ?? ?? ?? ?????.")
    end
  end
  if qData[429].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[429].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?????. ?????. ? ???? ?? ???.")
        SET_QUEST_STATE(429, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}[????] 10?{END}? {0xFFFFFF00}[??????] 10?{END}?  ?? ?? ????.")
    end
  end
  if qData[430].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[430].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?????. ?????. ? ???? ?? ???.")
        SET_QUEST_STATE(430, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}[????] 10?{END}? {0xFFFFFF00}[??????] 10?{END}?  ?? ?? ????.")
    end
  end
  if qData[431].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[431].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?????. ?????. ? ???? ?? ???.")
        SET_QUEST_STATE(431, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}[????] 10?{END}? {0xFFFFFF00}[??????] 10?{END}?  ?? ?? ????.")
    end
  end
  if qData[432].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[432].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?????. ?????. ? ???? ?? ???.")
        SET_QUEST_STATE(432, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}[????] 10?{END}? {0xFFFFFF00}[??????] 10?{END}?  ?? ?? ????.")
    end
  end
  if qData[687].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[687].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("?????. ?????. ? ???? ?? ???.")
        SET_QUEST_STATE(687, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}[????] 10?{END}? {0xFFFFFF00}[??????] 10?{END}?  ?? ?? ????.")
    end
  end
  if qData[437].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[437].goal.getItem) then
    NPC_SAY(" ?? ??? ??? ? ??? ???? ??? ?? ?????? ?? ?????.")
    SET_QUEST_STATE(437, 2)
    return
  end
  if qData[447].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[447].goal.getItem) then
      NPC_SAY(qt[447].npcsay[2])
      SET_QUEST_STATE(447, 2)
      return
    else
      NPC_SAY(qt[447].npcsay[1])
    end
  end
  if qData[1149].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("欢迎光临。哈哈哈，你说我的胡子很帅气？哈哈 其实真是小时候… 啊！对我的故事感兴趣吗？")
      SET_QUEST_STATE(1149, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1151].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1151].goal.getItem) then
      NPC_SAY("啊！那不是[ 鸟人的蛋 ]吗？啊！你想要知道什么？被袭击当时的情况？听乌骨鸡大侠说的？我什么都不知道。应该是个错误的情报。去跟乌骨鸡大侠再次确认一下吧。")
      SET_QUEST_STATE(1151, 2)
    else
      NPC_SAY("我看到15个[ 鸟人的蛋 ]也会浑身起鸡皮疙瘩。")
    end
  end
  if qData[1185].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1185].goal.getItem) then
      NPC_SAY("咕咚！啊~你也要来一个吗？嗯…很好吃的啊…总之过去的事情就忘掉吧。")
      SET_QUEST_STATE(1185, 2)
    else
      NPC_SAY("你只要拿来20个[ 糯米肠的蛋 ]我们就是朋友了。击退蛇腹窟的糯米肠收集20个[ 糯米肠的蛋 ]回来吧。")
    end
  end
  if qData[1186].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1186].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢。啊，这脆脆的口感！你真的不吃也没关系吗？")
        SET_QUEST_STATE(1186, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("帮我收集15个[ 蛛蛛人的脚 ]吧。光是想想也会流口,呵呵呵…蜘蛛人在蛇腹窟。")
    end
  end
  if qData[1188].state == 1 then
    NPC_SAY("收集竹林的5个[ 独脚天狗仙的角 ]和7个[ 双节龙的牙齿 ]，去冥珠城银行换取奖励吧。")
  end
  if qData[2037].state == 1 then
    SET_QUEST_STATE(2037, 2)
    NPC_SAY("什么？要我离开这里？你开玩笑呢？我虽然是货郎，但这里却是像我们这种货郎的安乐窝。你从哪儿来就滚回哪里去！")
  end
  if qData[2038].state == 1 then
    NPC_SAY("李无极应该是死了，如果还活着的话，我不可能还在这里（向佣兵领袖报告李无极和那一带的事情吧）")
  end
  ADD_NEW_SHOP_BTN(id, 10009)
  if qData[132].state == 2 and qData[133].state == 0 then
    ADD_QUEST_BTN(qt[133].id, qt[133].name)
  end
  if qData[1149].state == 2 and qData[1151].state == 0 then
    ADD_QUEST_BTN(qt[1151].id, qt[1151].name)
  end
  if qData[1185].state == 0 then
    ADD_QUEST_BTN(qt[1185].id, qt[1185].name)
  end
  if qData[1186].state == 0 and qData[1185].state == 2 then
    ADD_QUEST_BTN(qt[1186].id, qt[1186].name)
  end
  if qData[1188].state == 0 then
    ADD_QUEST_BTN(qt[1188].id, qt[1188].name)
  end
  if qData[2038].state == 0 and qData[2037].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2038].id, qt[2038].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[338].state == 1 and GET_PLAYER_LEVEL() >= qt[338].needLevel then
    QSTATE(id, 1)
  end
  if qData[1149].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1149].state == 2 and qData[1151].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1151].needLevel then
    if qData[1151].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1151].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1185].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1185].needLevel then
    if qData[1185].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1185].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1185].state == 2 and qData[1186].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1186].needLevel then
    if qData[1186].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1186].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1188].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1188].needLevel then
    if qData[1188].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2037].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2038].state ~= 2 and qData[2037].state == 2 and GET_PLAYER_LEVEL() >= qt[2038].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2038].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
