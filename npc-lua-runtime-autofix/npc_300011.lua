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
  if id ~= 4300011 then
    return
  end
  clickNPCid = id
  if qData[91].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[91].goal.getItem) then
    NPC_SAY("我只是可以看懂一点天象和风向的普通的老人而已…这是！{0xFFFFFF00}'北瓶押'{END}还活着啊。真是万幸啊")
    SET_QUEST_STATE(91, 2)
  end
  if qData[132].state == 1 then
    NPC_SAY("有烟雾弹就可以避开{0xFFFFFF00}'兰霉匠'{END}的收下了。去见{0xFFFFFF00}无名湖的路边摊{END}吧")
  end
  if qData[133].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[133].goal.getItem) then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("烟雾弹加上山参…。路边摊的关心让我涌出一股坚持的力量啊。少侠，谢谢你。虽然我很年老，但在见到{0xFFFFFF00}'太和老君'{END}之前不能死去…")
      SET_QUEST_STATE(133, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[134].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[134].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("做得好。有一次听{0xFFFFFF00}'东泼肉'{END}说{0xFFFFFF00}'太和老君'{END}离开之前跟{0xFFFFFF00}梅花弱{END}说了很重要的话。得找找他啊")
        SET_QUEST_STATE(134, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("有消息说，{0xFFFFFF00}金刚项链和金刚戒指{END}在狗骨头身上")
    end
  end
  if qData[135].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[135].goal.getItem) and SET_ITEM_PERCENT(8510061) >= 371 then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("我亲眼见到了少侠的能力，没有什么可疑心的。现在就剩下用真眼找找{0xFFFFFF00}'东泼肉'{END}的事情了。稍等一下")
        SET_QUEST_STATE(135, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("往这个封印宝牌装满怪物的魂回来吧")
    end
  end
  if qData[136].state == 1 then
    NPC_SAY("去有很多醉酒的人，又红又嘈杂的地方找找{0xFFFFFF00}'南呱湃'{END}吧。")
  end
  if qData[459].state == 1 and qData[458].state == 2 then
    NPC_QSAY(459, 3)
    SET_MEETNPC(459, 2, id)
    SET_QUEST_STATE(459, 2)
  end
  if qData[460].state == 1 and qData[459].state == 2 then
    NPC_QSAY(460, 1)
  end
  if qData[461].state == 1 and qData[460].state == 2 then
    NPC_QSAY(461, 3)
    SET_MEETNPC(461, 2, id)
    SET_QUEST_STATE(461, 2)
  end
  if qData[462].state == 1 and qData[461].state == 2 then
    NPC_QSAY(462, 1)
  end
  if qData[743].state == 1 then
    if qData[743].killMonster[qt[743].goal.killMonster[1].id] >= qt[743].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("来，收下吧。要好好使用啊")
        SET_QUEST_STATE(743, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("{0xFFFFFF00}[ 独角天狗仙 ]{END}在竹林里，证明一下你有能力使用强灵吧。击退{0xFFFFFF00}10个[ 独角天狗仙 ]{END}就可以")
    end
  end
  if qData[750].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("来，收下吧")
      SET_QUEST_STATE(750, 2)
      return
    else
      NPC_SAY("行囊太沉。")
      return
    end
  end
  if qData[1004].state == 1 then
    NPC_SAY("呵呵呵…兰霉匠的高级手下终于来到这里了。")
    SET_QUEST_STATE(1004, 2)
    return
  end
  if qData[1005].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1005].goal.getItem) then
      if CHECK_INVENTORY_CNT(4) == 0 then
        NPC_SAY("行囊太沉。")
        return
      end
      NPC_SAY("{0xFFFFFF00}[ 假千年参 ]{END}完成了。把这个送给兰霉匠的手下{0xFFFFFF00}[ 皇宫武士魏朗 ]{END}做礼物。")
      SET_QUEST_STATE(1005, 2)
      SET_MEETNPC(1005, 1, id)
    else
      NPC_SAY("如果现在不找来{0xFFFFFF00}[ 山参 ]{END}，晚了的话就没用了！快点去收集{0xFFFFFF00}10个[ 山参 ]{END}。")
    end
  end
  if qData[1007].state == 1 then
    SET_INFO(1007, 1)
    if qData[1007].meetNpc[1] ~= id then
      NPC_QSAY(1007, 1)
      SET_MEETNPC(1007, 1, id)
      return
    else
      NPC_SAY("去见{0xFFFFFF00}[ 皇宫武士魏朗 ]{END}，找找其他手下吧。")
      return
    end
  end
  if qData[1044].state == 1 then
    NPC_SAY("那其他情报打听回来了吗？")
    SET_QUEST_STATE(1044, 2)
    return
  end
  if qData[1045].state == 1 then
    NPC_SAY("快点吧。有不好的预感。")
    return
  end
  if qData[1180].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("我只是个会看点天象和风向的无不足道的老人… 这是！北瓶押还活着啊。万幸，真是万幸啊。")
      SET_QUEST_STATE(1180, 2)
    else
      NPC_SAY("行囊已满。")
    end
  end
  if qData[1206].state == 1 then
    if qData[1206].killMonster[qt[1206].goal.killMonster[1].id] >= qt[1206].goal.killMonster[1].count and GET_PLAYER_LEVEL() >= 40 then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("呵呵呵，我已经有了预感你会成功的。")
        SET_QUEST_STATE(1206, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("去蛇腹窟吧！觉得那就是你的宿命。记住了，不满足{0xFFFFFF00}功力40和击退狗骨头{END}这两个条件时不会认可的。")
    end
  end
  if qData[1207].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1207].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("啊！你找回来了？果，果然我没记错。收下吧，为你准备的。{0xFFFF3333}(佩戴任务物品的时候，任务无法完成。){END}")
        SET_QUEST_STATE(1207, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("如果能从狗骨头那儿找回{0xFFFFFF00}金刚戒指和金刚项链{END}就好了…。")
    end
  end
  if qData[1210].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1210].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("谢谢。要不现在就开始？")
        SET_QUEST_STATE(1210, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("去击退{0xFFFFFF00}竹林{END}里的{0xFFFFFF00}美丽人参{END}收集{0xFFFFFF00}20个山参{END}回来吧。")
    end
  end
  if qData[1211].state == 1 then
    if GET_PLAYER_LEVEL() >= 50 then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("找回全部的力量很难…。但是难得感觉到身体充满了活力。")
        SET_QUEST_STATE(1211, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("{0xFFFFFF00}功力达50{END}之后回来吧。我恢复功力的时间也差不多。")
    end
  end
  if qData[1241].state == 1 then
    NPC_SAY("拿着我的玉项链去龙林客栈见南呱湃师姐吧")
  end
  if qData[1433].state == 1 then
    NPC_SAY("发现秋叨鱼师兄了？")
    SET_QUEST_STATE(1433, 2)
    return
  end
  if qData[1434].state == 1 then
    NPC_SAY("快回生死之塔入口的武艺僧长经处想想办法吧。")
  end
  if qData[1436].state == 1 then
    NPC_SAY("秋叨鱼师兄苏醒了？辛苦了。我们师兄弟每次都麻烦你。")
    SET_QUEST_STATE(1436, 2)
    return
  end
  if qData[1457].state == 1 then
    NPC_SAY("你说冬混汤师兄在被破坏的密会所是吧？住持能把我送去吗？")
    return
  end
  if qData[2066].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2066].goal.getItem) then
      SET_QUEST_STATE(2066, 2)
      NPC_SAY("是你啊，早就听说过了~还准备了礼物，嗯…总之谢谢你，呵呵！")
    else
      NPC_SAY("你是谁啊？")
    end
  end
  if qData[2067].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2067].goal.getItem) then
      SET_QUEST_STATE(2067, 2)
      NPC_SAY("谢谢！你收集回来的大目王的头发足够应付一阵子了~")
    else
      NPC_SAY("我需要的是[大目王]的[大目王的头发]。只要有10个应该可以应付一段时间的。大目王在青岳秀洞深处，拜托你了！")
    end
  end
  if qData[2068].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2068].goal.getItem) then
      SET_QUEST_STATE(2068, 2)
      NPC_SAY("来了？果然是北瓶押看重的人才啊")
    else
      NPC_SAY("去[隐藏的冥珠平原]击退[鸡冠呛]后，收集1个鸡冠呛符咒回来吧")
    end
  end
  if qData[2069].state == 1 then
    NPC_SAY("去见[冥珠城北]的[证明管理人]吧。还有，用收到的证明购买装备吧")
  end
  if qData[2070].state == 1 then
    SET_QUEST_STATE(2070, 2)
    NPC_SAY("哈哈哈~没什么大不了的！妇女们的心思我清楚得很，以前让数十名妇女争风吃醋的实力还没有退化啊，哈哈哈！咦？北瓶押没跟你说过吗？")
  end
  if qData[2071].state == 1 then
    NPC_SAY("让你击退黄岳秀洞的[绿蜗牛]，收集15个左右的[绿蜗牛的壳]回去。感觉很依赖你啊")
  end
  if qData[2898].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2898].goal.getItem) then
      SET_QUEST_STATE(2898, 2)
      NPC_SAY("好的。我现在就帮你开放栏。")
    else
      NPC_SAY("去符合功力的黄泉收集{0xFFFFFF00}50个炼玉粉{END}回来吧。功力差太大的话，应该很难收集。")
    end
  end
  if qData[135].state == 2 and qData[136].state == 0 then
    ADD_QUEST_BTN(qt[136].id, qt[136].name)
  end
  if qData[460].state == 0 and qData[459].state == 2 then
    ADD_QUEST_BTN(qt[460].id, qt[460].name)
  end
  if qData[462].state == 0 and GET_PLAYER_LEVEL() >= qt[462].needLevel then
    ADD_QUEST_BTN(qt[462].id, qt[462].name)
  end
  if qData[743].state == 0 and qData[1241].state == 2 then
    ADD_QUEST_BTN(qt[743].id, qt[743].name)
  end
  if qData[750].state == 0 then
    ADD_QUEST_BTN(qt[750].id, qt[750].name)
  end
  if qData[1005].state == 0 and qData[1004].state == 2 then
    ADD_QUEST_BTN(qt[1005].id, qt[1005].name)
  end
  if qData[1044].state == 2 and qData[1045].state == 0 then
    ADD_QUEST_BTN(qt[1045].id, qt[1045].name)
  end
  if qData[1180].state == 2 and qData[1206].state == 0 and GET_PLAYER_LEVEL() >= qt[1206].needLevel then
    ADD_QUEST_BTN(qt[1206].id, qt[1206].name)
  end
  if qData[1207].state == 0 and GET_PLAYER_LEVEL() >= qt[1207].needLevel then
    ADD_QUEST_BTN(qt[1207].id, qt[1207].name)
  end
  if qData[1210].state == 0 and qData[1206].state == 2 and GET_PLAYER_LEVEL() >= qt[1210].needLevel then
    ADD_QUEST_BTN(qt[1210].id, qt[1210].name)
  end
  if qData[1211].state == 0 and qData[1210].state == 2 and GET_PLAYER_LEVEL() >= qt[1211].needLevel then
    ADD_QUEST_BTN(qt[1211].id, qt[1211].name)
  end
  if qData[1241].state == 0 and qData[1211].state == 2 and GET_PLAYER_LEVEL() >= qt[1241].needLevel then
    ADD_QUEST_BTN(qt[1241].id, qt[1241].name)
  end
  if qData[1434].state == 0 and qData[1433].state == 2 and GET_PLAYER_LEVEL() >= qt[1434].needLevel then
    ADD_QUEST_BTN(qt[1434].id, qt[1434].name)
  end
  if GET_PLAYER_TRANSFORMER() == 1 and qData[1457].state == 0 and qData[1436].state == 2 and GET_PLAYER_LEVEL() >= qt[1457].needLevel then
    ADD_QUEST_BTN(qt[1457].id, qt[1457].name)
  end
  if qData[2067].state == 0 and qData[2066].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2067].id, qt[2067].name)
  end
  if qData[2068].state == 0 and qData[2067].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2068].id, qt[2068].name)
  end
  if qData[2069].state == 0 and qData[2068].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2069].id, qt[2069].name)
  end
  if qData[2071].state == 0 and qData[2070].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2071].id, qt[2071].name)
  end
  if qData[2898].state == 0 and GET_PLAYER_LEVEL() >= qt[2898].needLevel then
    ADD_QUEST_BTN(qt[2898].id, qt[2898].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[91].state == 1 and GET_PLAYER_LEVEL() >= qt[91].needLevel then
    if __QUEST_HAS_ALL_ITEMS(qt[91].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[136].state ~= 2 and qData[135].state == 2 and GET_PLAYER_LEVEL() >= qt[136].needLevel then
    if qData[136].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[459].state == 1 and qData[458].state == 2 then
    QSTATE(id, 2)
  end
  if qData[460].state ~= 2 and GET_PLAYER_LEVEL() >= qt[460].needLevel and qData[459].state == 2 then
    if qData[460].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[461].state == 1 and qData[460].state == 2 and GET_PLAYER_LEVEL() >= qt[461].needLevel then
    QSTATE(id, 2)
  end
  if qData[462].state ~= 2 and GET_PLAYER_LEVEL() >= qt[462].needLevel then
    if qData[462].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[743].state ~= 2 and qData[136].state == 2 and GET_PLAYER_LEVEL() >= qt[743].needLevel then
    if qData[743].state == 1 then
      if qData[743].killMonster[qt[743].goal.killMonster[1].id] >= qt[743].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[750].state ~= 2 and GET_PLAYER_LEVEL() >= qt[750].needLevel then
    if qData[750].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1004].state == 1 and GET_PLAYER_LEVEL() >= qt[1004].needLevel then
    QSTATE(id, 2)
  end
  if qData[1005].state ~= 2 and qData[1004].state == 2 and GET_PLAYER_LEVEL() >= qt[1005].needLevel then
    if qData[1005].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1005].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1007].state == 1 and GET_PLAYER_LEVEL() >= qt[1007].needLevel then
    QSTATE(id, 1)
  end
  if qData[1044].state == 1 and GET_PLAYER_LEVEL() >= qt[1044].needLevel then
    QSTATE(id, 2)
  end
  if qData[1045].state ~= 2 and qData[1044].state == 2 and GET_PLAYER_LEVEL() >= qt[1045].needLevel then
    if qData[1045].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1180].state == 1 and GET_PLAYER_LEVEL() >= qt[1180].needLevel then
    QSTATE(id, 2)
  end
  if qData[1206].state == 1 then
    if qData[1206].killMonster[qt[1206].goal.killMonster[1].id] >= qt[1206].goal.killMonster[1].count and GET_PLAYER_LEVEL() >= 40 then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1180].state == 2 and qData[1206].state == 0 and GET_PLAYER_LEVEL() >= qt[1206].needLevel then
    QSTATE(id, 0)
  end
  if qData[1207].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1207].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1207].state == 0 and GET_PLAYER_LEVEL() >= qt[1207].needLevel then
    QSTATE(id, 0)
  end
  if qData[1210].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1210].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1210].state == 0 and qData[1206].state == 2 and GET_PLAYER_LEVEL() >= qt[1210].needLevel then
    QSTATE(id, 0)
  end
  if qData[1241].state == 1 then
    QSTATE(id, 1)
  end
  if qData[1241].state == 0 and qData[1211].state == 2 and GET_PLAYER_LEVEL() >= qt[1241].needLevel then
    QSTATE(id, 0)
  end
  if qData[1433].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1434].state ~= 2 and qData[1433].state == 2 and GET_PLAYER_LEVEL() >= qt[1434].needLevel then
    if qData[1434].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1436].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1447].state ~= 2 and qData[1437].state == 2 and GET_PLAYER_LEVEL() >= qt[1447].needLevel then
    if qData[1447].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1457].state ~= 2 and qData[1436].state == 2 and GET_PLAYER_LEVEL() >= qt[1457].needLevel then
    if qData[1457].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2066].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2066].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2067].state ~= 2 and qData[2066].state == 2 and GET_PLAYER_LEVEL() >= qt[2067].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2067].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2067].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2068].state ~= 2 and qData[2067].state == 2 and GET_PLAYER_LEVEL() >= qt[2068].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2068].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2068].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2069].state ~= 2 and qData[2068].state == 2 and GET_PLAYER_LEVEL() >= qt[2069].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2069].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2070].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2071].state ~= 2 and qData[2070].state == 2 and GET_PLAYER_LEVEL() >= qt[2071].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2071].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2898].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2898].needLevel then
    if qData[2898].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2898].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
