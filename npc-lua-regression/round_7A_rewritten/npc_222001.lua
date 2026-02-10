local function __QUEST_HAS_ALL_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4222001 then
    return
  end
  clickNPCid = id
  NPC_SAY("没有比事先做好准备更好的了。第一是安全！第二还是安全。")
  if qData[2328].state == 1 then
    NPC_SAY("欢迎光临！我是吕林城唯一的宝芝林")
    SET_QUEST_STATE(2328, 2)
    return
  end
  if qData[2329].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2329].goal.getItem) then
      NPC_SAY("我也准备好了，把材料给我吧")
      SET_QUEST_STATE(2329, 2)
    else
      NPC_SAY("快点吧！收集{0xFFFFFF00}50个食人花的种子和15个鹿茸药剂{END}回来。解毒要争分夺秒")
    end
  end
  if qData[2330].state == 1 then
    NPC_SAY("你快把药送过去吧。还有，千万要记得喝龙井茶和禁食油腻食物的事情！还有，静养8小时！")
  end
  if qData[2662].state == 1 then
    NPC_SAY("你是秋叨鱼的保护人吗？来得正好，太万幸了！")
    SET_QUEST_STATE(2662, 2)
    return
  end
  if qData[2663].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2663].goal.getItem) then
      NPC_SAY("这么快啊！")
      SET_QUEST_STATE(2663, 2)
      return
    else
      NPC_SAY("在嗜食怪身上收集10个{0xFFFFFF00}嗜食怪的眼睛{END}回来吧。")
    end
  end
  if qData[2664].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2664].goal.getItem) then
      NPC_SAY("这么快就收集好了？果然很厉害！")
      SET_QUEST_STATE(2664, 2)
      return
    else
      NPC_SAY("在临浦怪身上收集20个{0xFFFFFF00}临浦怪的眼睛{END}回来吧。")
    end
  end
  if qData[2665].state == 1 then
    NPC_SAY("{0xFFFFFF00}吕林城武器店{END}在{0xFFFFFF00}吕林城南{END}。我现在用嗜食怪和临浦怪的眼睛做好制作药的准备。")
  end
  if qData[2667].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2667].goal.getItem) then
    NPC_SAY("我正等着你呢。我会把应急药和之前的药材一起制作药给秋叨鱼吃。现在只能等待。")
    SET_QUEST_STATE(2667, 2)
    return
  end
  if qData[2669].state == 1 then
    NPC_SAY("对了…好像是叫走火入魔的病。中原的病中原的人应该更了解。")
  end
  if qData[2678].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2678].goal.getItem) then
      NPC_SAY("太感谢了！")
      SET_QUEST_STATE(2678, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}临浦怪{END}? 听说在{0xFFFFFF00}干涸的沼泽{END}那边。")
    end
  end
  if qData[2694].state == 1 then
    NPC_SAY("秋叨鱼刚吃了药睡着了。短时间内很难醒过来。")
    SET_QUEST_STATE(2694, 2)
    return
  end
  if qData[2732].state == 1 then
    NPC_SAY("击退70个{0xFFFFFF00}巨木重林{END}的{0xFFFFFF00}食人花{END}后，去找{0xFFFFFF00}巨木重林中心地{END}的{0xFFFFFF00}[巨木守护者]{END}吧。")
  end
  if qData[2738].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[2738].goal.getItem) then
    NPC_SAY("（听完说明后）所以这是特制药和制作法是吧。谢谢。")
    SET_QUEST_STATE(2738, 2)
    return
  end
  if qData[2739].state == 1 then
    NPC_SAY("将信转交给{0xFFFFFF00}治疗中的秋叨鱼{END}吧。")
  end
  if qData[2803].state == 1 then
    if CHECK_ITEM_CNT(qt[2803].goal.getItem[1].id) >= qt[2803].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2803].goal.getItem[2].id) >= qt[2803].goal.getItem[2].count then
      NPC_SAY("上次收集回来的果然不是偶然啊、")
      SET_QUEST_STATE(2803, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}击退{0xFFFFFF00}原虫{END}和{0xFFFFFF00}妖粉怪{END}后，各收集10个{0xFFFFFF00}獐子潭苔藓{END}和{0xFFFFFF00}獐子潭水晶粉末{END}回来吧。")
    end
  end
  if qData[2804].state == 1 then
    if CHECK_ITEM_CNT(qt[2804].goal.getItem[1].id) >= qt[2804].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2804].goal.getItem[2].id) >= qt[2804].goal.getItem[2].count then
      NPC_SAY("好的，那现在开始研究一下?")
      SET_QUEST_STATE(2804, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}击退{0xFFFFFF00}原虫{END}和{0xFFFFFF00}妖粉怪{END}后，各收集20个{0xFFFFFF00}獐子潭苔藓{END}和{0xFFFFFF00}獐子潭水晶粉末{END}回来吧。")
    end
  end
  if qData[2805].state == 1 then
    if CHECK_ITEM_CNT(qt[2805].goal.getItem[1].id) >= qt[2805].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2805].goal.getItem[2].id) >= qt[2805].goal.getItem[2].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("辛苦你了~这是{0xFFFFFF00}调查獐子潭许可证{END}。")
        SET_QUEST_STATE(2805, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}击退{0xFFFFFF00}原虫{END}和{0xFFFFFF00}妖粉怪{END}后，各收集30个{0xFFFFFF00}獐子潭苔藓{END}和{0xFFFFFF00}獐子潭水晶粉末{END}回来吧。")
    end
  end
  if qData[3742].state == 1 then
    if CHECK_ITEM_CNT(qt[3742].goal.getItem[1].id) >= qt[3742].goal.getItem[1].count and CHECK_ITEM_CNT(qt[3742].goal.getItem[2].id) >= qt[3742].goal.getItem[2].count then
      NPC_SAY("我来看看~收集对了。辛苦了。")
      SET_QUEST_STATE(3742, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}獐子潭洞穴{END}击退{0xFFFFFF00}原虫{END}和{0xFFFFFF00}妖粉怪{END}，各收集30个{0xFFFFFF00}獐子潭苔藓{END}和{0xFFFFFF00}獐子潭水晶粉末{END}回来吧。")
    end
  end
  if qData[2329].state == 0 and qData[2328].state == 2 and GET_PLAYER_LEVEL() >= qt[2329].needLevel then
    ADD_QUEST_BTN(qt[2329].id, qt[2329].name)
  end
  if qData[2330].state == 0 and qData[2329].state == 2 and GET_PLAYER_LEVEL() >= qt[2330].needLevel then
    ADD_QUEST_BTN(qt[2330].id, qt[2330].name)
  end
  if qData[2663].state == 0 and qData[2662].state == 2 and GET_PLAYER_LEVEL() >= qt[2663].needLevel then
    ADD_QUEST_BTN(qt[2663].id, qt[2663].name)
  end
  if qData[2664].state == 0 and qData[2663].state == 2 and GET_PLAYER_LEVEL() >= qt[2664].needLevel then
    ADD_QUEST_BTN(qt[2664].id, qt[2664].name)
  end
  if qData[2665].state == 0 and qData[2664].state == 2 and GET_PLAYER_LEVEL() >= qt[2665].needLevel then
    ADD_QUEST_BTN(qt[2665].id, qt[2665].name)
  end
  if qData[2669].state == 0 and qData[2668].state == 2 and GET_PLAYER_LEVEL() >= qt[2669].needLevel then
    ADD_QUEST_BTN(qt[2669].id, qt[2669].name)
  end
  if qData[2678].state == 0 and qData[2677].state == 2 and GET_PLAYER_LEVEL() >= qt[2678].needLevel then
    ADD_QUEST_BTN(qt[2678].id, qt[2678].name)
  end
  if qData[2732].state == 0 and qData[2731].state == 2 and GET_PLAYER_LEVEL() >= qt[2732].needLevel then
    ADD_QUEST_BTN(qt[2732].id, qt[2732].name)
  end
  if qData[2739].state == 0 and qData[2738].state == 2 and GET_PLAYER_LEVEL() >= qt[2739].needLevel then
    ADD_QUEST_BTN(qt[2739].id, qt[2739].name)
  end
  if qData[2803].state == 0 and qData[2799].state == 1 and GET_PLAYER_LEVEL() >= qt[2803].needLevel then
    ADD_QUEST_BTN(qt[2803].id, qt[2803].name)
  end
  if qData[2804].state == 0 and qData[2803].state == 2 and GET_PLAYER_LEVEL() >= qt[2804].needLevel then
    ADD_QUEST_BTN(qt[2804].id, qt[2804].name)
  end
  if qData[2805].state == 0 and qData[2804].state == 2 and GET_PLAYER_LEVEL() >= qt[2805].needLevel then
    ADD_QUEST_BTN(qt[2805].id, qt[2805].name)
  end
  if qData[3742].state == 0 and qData[2738].state == 2 and GET_PLAYER_LEVEL() >= qt[3742].needLevel then
    ADD_QUEST_BTN(qt[3742].id, qt[3742].name)
  end
  ADD_NEW_SHOP_BTN(id, 10051)
  GIVE_DONATION_BUFF(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2328].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2329].state ~= 2 and qData[2328].state == 2 and GET_PLAYER_LEVEL() >= qt[2329].needLevel then
    if qData[2329].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2329].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2330].state ~= 2 and qData[2329].state == 2 and GET_PLAYER_LEVEL() >= qt[2330].needLevel then
    if qData[2330].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2662].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2663].state ~= 2 and qData[2662].state == 2 and GET_PLAYER_LEVEL() >= qt[2663].needLevel then
    if qData[2663].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2663].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2664].state ~= 2 and qData[2663].state == 2 and GET_PLAYER_LEVEL() >= qt[2664].needLevel then
    if qData[2664].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2664].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2665].state ~= 2 and qData[2664].state == 2 and GET_PLAYER_LEVEL() >= qt[2665].needLevel then
    if qData[2665].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2667].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2667].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2669].state ~= 2 and qData[2668].state == 2 and GET_PLAYER_LEVEL() >= qt[2669].needLevel then
    if qData[2669].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2678].state ~= 2 and qData[2677].state == 2 and GET_PLAYER_LEVEL() >= qt[2678].needLevel then
    if qData[2678].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2678].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2694].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2732].state ~= 2 and qData[2731].state == 2 and GET_PLAYER_LEVEL() >= qt[2732].needLevel then
    if qData[2732].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2738].state ~= 2 and qData[2737].state == 2 and GET_PLAYER_LEVEL() >= qt[2738].needLevel then
    if qData[2738].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2738].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2739].state ~= 2 and qData[2738].state == 2 and GET_PLAYER_LEVEL() >= qt[2739].needLevel then
    if qData[2739].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2803].state ~= 2 and qData[2799].state == 1 and GET_PLAYER_LEVEL() >= qt[2803].needLevel then
    if qData[2803].state == 1 then
      if CHECK_ITEM_CNT(qt[2803].goal.getItem[1].id) >= qt[2803].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2803].goal.getItem[2].id) >= qt[2803].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2804].state ~= 2 and qData[2803].state == 2 and GET_PLAYER_LEVEL() >= qt[2804].needLevel then
    if qData[2804].state == 1 then
      if CHECK_ITEM_CNT(qt[2804].goal.getItem[1].id) >= qt[2804].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2804].goal.getItem[2].id) >= qt[2804].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2805].state ~= 2 and qData[2804].state == 2 and GET_PLAYER_LEVEL() >= qt[2805].needLevel then
    if qData[2805].state == 1 then
      if CHECK_ITEM_CNT(qt[2805].goal.getItem[1].id) >= qt[2805].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2805].goal.getItem[2].id) >= qt[2805].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3742].state ~= 2 and qData[2738].state == 2 and GET_PLAYER_LEVEL() >= qt[3742].needLevel then
    if qData[3742].state == 1 then
      if CHECK_ITEM_CNT(qt[3742].goal.getItem[1].id) >= qt[3742].goal.getItem[1].count and CHECK_ITEM_CNT(qt[3742].goal.getItem[2].id) >= qt[3742].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
