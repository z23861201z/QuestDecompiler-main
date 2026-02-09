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
  if id ~= 4318001 then
    return
  end
  clickNPCid = id
  if qData[611].state == 1 then
    NPC_SAY("什么事啊？")
    SET_MEETNPC(611, 1, id)
    SET_QUEST_STATE(611, 2)
  end
  if qData[612].state == 1 then
    NPC_SAY("??????? ?????. ??? ?? ?? ???? ????.")
  end
  if qData[1045].state == 1 then
    NPC_SAY("从兰霉匠部下那儿得到了暗号文？")
    SET_QUEST_STATE(1045, 2)
    return
  end
  if qData[1046].state == 1 then
    NPC_SAY("快点转达吧。以免受到怀疑。")
    return
  end
  if qData[1286].state == 1 then
    NPC_SAY("你是说敌人盯上了韩野村码头？")
    SET_QUEST_STATE(1286, 2)
    return
  end
  if qData[1287].state == 1 then
    NPC_SAY("土著民沈叶浪在韩野村南边。如果你能说服他，那我会很感谢你的。")
    return
  end
  if qData[1293].state == 1 and GET_PLAYER_LEVEL() >= 68 then
    NPC_SAY("来得正好。")
    SET_QUEST_STATE(1293, 2)
    return
  end
  if qData[1294].state == 1 then
    NPC_SAY("听说皇宫武士陈调依然在龙林城南边。")
    return
  end
  if qData[2059].state == 1 then
    SET_QUEST_STATE(2059, 2)
    NPC_SAY("什么？那个我已经知道了。已经早早的通过所有的联系体系通知了12弟子不要出现了。那些兰霉匠的军队，我们韩野城的优秀军队足以抵挡的~")
  end
  if qData[2060].state == 1 then
    NPC_SAY("这样特意找过来关心我们，我们就更加有信心了！(回到[佣兵领袖]处)")
  end
  if qData[3659].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3659].goal.getItem) then
      NPC_SAY("收集回来了啊，那我给你讲讲我的事情")
      SET_QUEST_STATE(3659, 2)
      return
    else
      NPC_SAY("去{0xFFFFFF00}西危峡谷{END}收集{0xFFFFFF00}50个寿衣{END}后，给高一燕送去吧")
    end
  end
  if qData[3660].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3660].goal.getItem) then
      NPC_SAY("收集回来了啊，那我给你讲讲我的事情")
      SET_QUEST_STATE(3660, 2)
      return
    else
      NPC_SAY("去{0xFFFFFF00}西危峡谷{END}收集{0xFFFFFF00}50个突眼怪的尾巴{END}后，给高一燕送去吧")
    end
  end
  if qData[3661].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3661].goal.getItem) then
      NPC_SAY("收集回来了啊，那我给你讲讲我的事情")
      SET_QUEST_STATE(3661, 2)
      return
    else
      NPC_SAY("去{0xFFFFFF00}古老的渡头{END}收集{0xFFFFFF00}50个野蛮族的宝珠{END}后，给高一燕送去吧")
    end
  end
  if qData[862].state == 1 and qData[862].meetNpc[1] == qt[862].goal.meetNpc[1] and qData[862].meetNpc[2] == qt[862].goal.meetNpc[2] and qData[862].meetNpc[3] == qt[862].goal.meetNpc[3] and qData[862].meetNpc[4] ~= id then
    NPC_QSAY(862, 13)
    SET_INFO(862, 4)
    SET_MEETNPC(862, 4, id)
    return
  end
  ADD_EQUIP_DELIVERY(id)
  ADD_EQUIP_DELIVERY_CURRENT(id)
  if qData[944].state == 0 then
    ADD_QUEST_BTN(qt[944].id, qt[944].name)
  end
  if qData[983].state == 0 then
    ADD_QUEST_BTN(qt[983].id, qt[983].name)
  end
  if qData[945].state == 0 then
    ADD_QUEST_BTN(qt[945].id, qt[945].name)
  end
  if qData[946].state == 0 then
    ADD_QUEST_BTN(qt[946].id, qt[946].name)
  end
  if qData[947].state == 0 then
    ADD_QUEST_BTN(qt[947].id, qt[947].name)
  end
  if qData[948].state == 0 then
    ADD_QUEST_BTN(qt[948].id, qt[948].name)
  end
  if qData[949].state == 0 then
    ADD_QUEST_BTN(qt[949].id, qt[949].name)
  end
  if qData[950].state == 0 then
    ADD_QUEST_BTN(qt[950].id, qt[950].name)
  end
  if qData[951].state == 0 then
    ADD_QUEST_BTN(qt[951].id, qt[951].name)
  end
  if qData[952].state == 0 then
    ADD_QUEST_BTN(qt[952].id, qt[952].name)
  end
  if qData[1045].state == 2 and qData[1046].state == 0 then
    ADD_QUEST_BTN(qt[1046].id, qt[1046].name)
  end
  if qData[1287].state == 0 and qData[1286].state == 2 and GET_PLAYER_LEVEL() >= qt[1287].needLevel then
    ADD_QUEST_BTN(qt[1287].id, qt[1287].name)
  end
  if qData[1294].state == 0 and qData[1293].state == 2 and GET_PLAYER_LEVEL() >= qt[1294].needLevel then
    ADD_QUEST_BTN(qt[1294].id, qt[1294].name)
  end
  if qData[2060].state == 0 and qData[2059].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2060].id, qt[2060].name)
  end
  if qData[3659].state == 0 and GET_PLAYER_LEVEL() >= qt[3659].needLevel then
    ADD_QUEST_BTN(qt[3659].id, qt[3659].name)
  end
  if qData[3660].state == 0 and GET_PLAYER_LEVEL() >= qt[3660].needLevel then
    ADD_QUEST_BTN(qt[3660].id, qt[3660].name)
  end
  if qData[3661].state == 0 and GET_PLAYER_LEVEL() >= qt[3661].needLevel then
    ADD_QUEST_BTN(qt[3661].id, qt[3661].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1045].state == 2 and qData[1046].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1046].needLevel then
    if qData[1045].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1286].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1293].state == 1 and GET_PLAYER_LEVEL() >= 68 then
    QSTATE(id, 2)
  end
  if qData[1287].state ~= 2 and qData[1286].state == 2 and GET_PLAYER_LEVEL() >= qt[1287].needLevel then
    if qData[1287].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1294].state ~= 2 and qData[1293].state == 2 and GET_PLAYER_LEVEL() >= qt[1294].needLevel then
    if qData[1294].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[862].state == 1 and GET_PLAYER_LEVEL() >= qt[862].needLevel then
    QSTATE(id, 1)
  end
  if qData[2059].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2060].state ~= 2 and qData[2059].state == 2 and GET_PLAYER_LEVEL() >= qt[2060].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2060].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3659].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3659].needLevel then
    if qData[3659].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3659].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3660].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3660].needLevel then
    if qData[3660].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3660].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3661].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3661].needLevel then
    if qData[3661].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3661].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
