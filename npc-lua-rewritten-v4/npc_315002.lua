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
  if id ~= 4315002 then
    return
  end
  NPC_SAY("什么时候门主能教我秘传武功呢？")
  clickNPCid = id
  if qData[163].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[163].goal.getItem) then
      NPC_SAY("?? {0xFFFFFF00}PLAYERNAME{END}?? ??? ???. ?? ?????.????? ?????.")
      SET_QUEST_STATE(163, 2)
      return
    else
      NPC_SAY("????? ???? ????. {0xFFFFFF00}???? 40?{END}? ???????")
    end
  end
  if qData[1268].state == 1 then
    NPC_SAY("{0xFFFFFF00}龙林城南边{END}的{0xFFFFFF00}懒惰鬼{END}应该有办法帮到少侠的吧。")
  end
  if qData[1278].state == 1 then
    NPC_SAY("虽然你是很出名的少侠，但暂时我会把你当成是我的师弟。没关系吧？")
    SET_QUEST_STATE(1278, 2)
  end
  if qData[1279].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1279].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("一、二…。真，真的做到了啊。")
        SET_QUEST_STATE(1279, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退铁腕山的饿死鬼，收集30个水瓢回来吧。真的可以做到吗？")
    end
  end
  if qData[1280].state == 1 then
    NPC_SAY("帮助龙林城西边的龙林城宝芝林吧。")
  end
  if qData[1295].state == 1 then
    NPC_SAY("那个，最近去哪里了啊？都没见到你。")
    SET_QUEST_STATE(1295, 2)
  end
  if qData[1296].state == 1 then
    NPC_SAY("龙林城金系系武器店在龙林城南边。")
  end
  if qData[1299].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1299].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("了不起啊。现在可以搜索羊逃之了。")
        SET_QUEST_STATE(1299, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("如果有谁能击退铁腕山的独眼跳跳，收集30个毒囊包回来，就能制作解毒剂进行搜索了。")
    end
  end
  if qData[1300].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1300].goal.getItem) then
      NPC_SAY("辛苦了。终于可以和羊逃之一战胜负了。")
      SET_QUEST_STATE(1300, 2)
    else
      NPC_SAY("如果你击退铁腕山的树妖，收集30个树枝回来，我们就挂到神檀树上净化的。")
    end
  end
  if qData[1301].state == 1 then
    if qData[1301].killMonster[qt[1301].goal.killMonster[1].id] >= qt[1301].goal.killMonster[1].count then
      NPC_SAY("不，不会真的是一个人击退的吧？像少侠这样的人，我出生以来第一次见到。")
      SET_QUEST_STATE(1301, 2)
    else
      NPC_SAY("羊逃之在隐藏的铁腕山。击退1个羊逃之之后回来吧。千万要小心…")
    end
  end
  if qData[1302].state == 1 then
    NPC_SAY("龙林城银行在龙林城的西边。")
  end
  if qData[1313].state == 1 then
    NPC_SAY("来的正好。正在找少侠呢。")
    SET_QUEST_STATE(1313, 2)
  end
  if qData[1314].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1314].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("谢谢。现在可以正式的进行战斗了。")
        SET_QUEST_STATE(1314, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("拜托你击退铁腕谷的魔蛋、魔必方、九尾妖狐，收集魔蛋符咒、魔必方爪、狐尾各10个回来吧。")
    end
  end
  if qData[1315].state == 1 then
    NPC_SAY("龙林派师兄现在在龙林城北边。")
  end
  if qData[1527].state == 1 then
    NPC_SAY("失礼了，请问你是谁啊？")
    SET_QUEST_STATE(1527, 2)
  end
  if qData[163].state == 0 and GET_PLAYER_FAME() >= 74 then
    ADD_QUEST_BTN(qt[163].id, qt[163].name)
  end
  if qData[1268].state == 0 and GET_PLAYER_LEVEL() >= qt[1268].needLevel then
    ADD_QUEST_BTN(qt[1268].id, qt[1268].name)
  end
  if qData[1279].state == 0 and qData[1278].state == 2 and GET_PLAYER_LEVEL() >= qt[1279].needLevel then
    ADD_QUEST_BTN(qt[1279].id, qt[1279].name)
  end
  if qData[1280].state == 0 and qData[1279].state == 2 and GET_PLAYER_LEVEL() >= qt[1280].needLevel then
    ADD_QUEST_BTN(qt[1280].id, qt[1280].name)
  end
  if qData[1296].state == 0 and GET_PLAYER_LEVEL() >= qt[1296].needLevel then
    ADD_QUEST_BTN(qt[1296].id, qt[1296].name)
  end
  if qData[1299].state == 0 and GET_PLAYER_LEVEL() >= qt[1299].needLevel then
    ADD_QUEST_BTN(qt[1299].id, qt[1299].name)
  end
  if qData[1300].state == 0 and qData[1299].state == 2 and GET_PLAYER_LEVEL() >= qt[1300].needLevel then
    ADD_QUEST_BTN(qt[1300].id, qt[1300].name)
  end
  if qData[1301].state == 0 and qData[1300].state == 2 and GET_PLAYER_LEVEL() >= qt[1301].needLevel then
    ADD_QUEST_BTN(qt[1301].id, qt[1301].name)
  end
  if qData[1302].state == 0 and qData[1301].state == 2 and GET_PLAYER_LEVEL() >= qt[1302].needLevel then
    ADD_QUEST_BTN(qt[1302].id, qt[1302].name)
  end
  if qData[1314].state == 0 and qData[1313].state == 2 and GET_PLAYER_LEVEL() >= qt[1314].needLevel then
    ADD_QUEST_BTN(qt[1314].id, qt[1314].name)
  end
  if qData[1315].state == 0 and qData[1314].state == 2 and GET_PLAYER_LEVEL() >= qt[1315].needLevel then
    ADD_QUEST_BTN(qt[1315].id, qt[1315].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1489].state == 1 or qData[1490].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1527].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1268].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1268].needLevel then
    if qData[1268].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1278].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1279].state ~= 2 and qData[1278].state == 2 and GET_PLAYER_LEVEL() >= qt[1279].needLevel then
    if qData[1279].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1279].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1280].state == 0 and qData[1279].state == 2 and GET_PLAYER_LEVEL() >= qt[1280].needLevel then
    QSTATE(id, 0)
  end
  if qData[1280].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1295].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1296].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1296].needLevel then
    if qData[1296].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1299].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1299].needLevel then
    if qData[1299].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1299].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1300].state ~= 2 and qData[1299].state == 2 and GET_PLAYER_LEVEL() >= qt[1300].needLevel then
    if qData[1300].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1300].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1301].state ~= 2 and qData[1300].state == 2 and GET_PLAYER_LEVEL() >= qt[1301].needLevel then
    if qData[1301].state == 1 then
      if qData[1301].killMonster[qt[1301].goal.killMonster[1].id] >= qt[1301].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1302].state ~= 2 and qData[1301].state == 2 and GET_PLAYER_LEVEL() >= qt[1302].needLevel then
    if qData[1302].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1313].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1314].state ~= 2 and qData[1313].state == 2 and GET_PLAYER_LEVEL() >= qt[1314].needLevel then
    if qData[1314].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1314].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1315].state ~= 2 and qData[1314].state == 2 and GET_PLAYER_LEVEL() >= qt[1315].needLevel then
    if qData[1315].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
