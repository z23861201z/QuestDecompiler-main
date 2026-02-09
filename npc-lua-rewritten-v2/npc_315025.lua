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
  if id ~= 4315025 then
    return
  end
  clickNPCid = id
  if qData[889].state == 1 then
    if qData[889].killMonster[qt[889].goal.killMonster[1].id] >= qt[889].goal.killMonster[1].count then
      NPC_SAY("辛苦了。果然你就是可以继承英雄们的人才啊。")
      SET_QUEST_STATE(889, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}40个[影魔]{END}之后回来就给你{0xFFFFFF00}1个生死守护符{END}。记住了，这个任务{0xFFFFFF00}一天只能进行一次{END}..")
    end
  end
  if qData[1348].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1348].goal.getItem) then
      NPC_SAY("比想象的要快啊。辛苦了。")
      SET_QUEST_STATE(1348, 2)
    else
      NPC_SAY("击退{0xFFFFFF00}忘却之房{END}的{0xFFFFFF00}幽冥忍者{END}，收集{0xFFFFFF00}35个黑色刀刃{END}回来吧。")
    end
  end
  if qData[1349].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1349].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。原来是那样啊。这下可以知道内部结构了。")
        SET_QUEST_STATE(1349, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退忘却之房的幽冥忍者，收集35个黑色刀刃回来吧。")
    end
  end
  if qData[1350].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1350].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。先用这些调查侵蚀的原因吧。")
        SET_QUEST_STATE(1350, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退忘却之房的侵蚀幽冥忍者，收集35个光泽修理剑回来吧。")
    end
  end
  if qData[1351].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1351].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("辛苦了。来看看…阿嚏！")
        SET_QUEST_STATE(1351, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退忘却之房的影魔，收集35个影魔粉回来吧。")
    end
  end
  if qData[1352].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1352].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("这，这次我捂着鼻子呢。不用担心了。")
        SET_QUEST_STATE(1352, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("再次去忘却之房击退影魔，收集35个影魔粉回来吧。")
    end
  end
  if qData[1353].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1353].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。现在对侵蚀幽冥忍者的研究会有所成就了吧。")
        SET_QUEST_STATE(1353, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去击退侵蚀幽冥忍者，收集35个光泽修理剑回来吧。")
    end
  end
  if qData[1354].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1354].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[1354].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("下面的楼层确实安静了不少？")
        SET_QUEST_STATE(1354, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去击退忘却之房的幽冥忍者和影魔，黑色刀刃和影魔粉各收集15个回来吧。")
    end
  end
  if qData[1355].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1355].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("好极了！就是用这个把那树藤烧掉！")
        SET_QUEST_STATE(1355, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退在忘却之房徘徊的火焰怪，收集35个火焰碎片回来吧。用那个… 呵呵呵")
    end
  end
  if qData[1356].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1356].goal.getItem) then
      NPC_SAY("好！成功了！")
      SET_QUEST_STATE(1356, 2)
    else
      NPC_SAY("击退忘却之房的火焰怪，收集35个火焰碎片回来吧。")
    end
  end
  if qData[1357].state == 1 then
    if qData[1357].killMonster[qt[1357].goal.killMonster[1].id] >= qt[1357].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。怎么样？比想象的要方便吧？")
        SET_QUEST_STATE(1357, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("在苦痛之房击退1只火焰怪之后5分钟内回来吧。")
    end
  end
  if qData[1358].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1358].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。现在岩石怪是不用担心了。")
        SET_QUEST_STATE(1358, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去苦痛之房击退岩石怪之后，收集35个鬼声符咒吧。")
    end
  end
  if qData[1359].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1359].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("我现在仿佛看到了住持和小童子僧们欢乐的笑容。")
        SET_QUEST_STATE(1359, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退苦痛之房的火焰怪，收集35个火焰碎片回来吧。那些应该足够过完冬了。")
    end
  end
  if qData[1360].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1360].goal.getItem) then
      NPC_SAY("辛苦了。现在塔没有了倒塌的危险。")
      SET_QUEST_STATE(1360, 2)
    else
      NPC_SAY("击退苦痛之房的魔眼，收集35个痛苦的粘液回来吧。")
    end
  end
  if qData[1361].state == 1 then
    if qData[1361].killMonster[qt[1361].goal.killMonster[1].id] >= qt[1361].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("辛苦了。这次可以正式的进行调查了。")
        SET_QUEST_STATE(1361, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("能帮我击退苦痛之房的50个侵蚀岩石怪吗？")
    end
  end
  if qData[1362].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1362].goal.getItem) then
      NPC_SAY("辛苦了。现在该轮到我来努力了。")
      SET_QUEST_STATE(1362, 2)
    else
      NPC_SAY("在苦痛之房击退侵蚀岩石怪，再收集35个侵蚀岩石怪的拳回来就感激不尽了。")
    end
  end
  if qData[1363].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1363].goal.getItem) then
      NPC_SAY("辛苦了。现在上悲伤之房看看吧。")
      SET_QUEST_STATE(1363, 2)
    else
      NPC_SAY("一般是击退生死之塔内部的怪物可以获得，如果你收集35个痛苦的粘液回来的话，我可以给你制作。")
    end
  end
  if qData[1364].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1364].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("好了，来这边吧。我把你扔上去。")
        SET_QUEST_STATE(1364, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去苦痛之房击退魔眼，收集35个痛苦的粘液回来吧。")
    end
  end
  if qData[1365].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1365].goal.getItem) then
      NPC_SAY("辛苦了。现在可以稍微放心了。")
      SET_QUEST_STATE(1365, 2)
    else
      NPC_SAY("击退悲伤之房的小穷鬼，收集35个穷鬼布袋回来吧。")
    end
  end
  if qData[1366].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1366].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。施主。但那是！")
        SET_QUEST_STATE(1366, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退悲伤之房的小穷鬼并收集35个穷鬼布袋,让小穷鬼们不敢再制毒。")
    end
  end
  if qData[1367].state == 1 then
    if qData[1367].killMonster[qt[1367].goal.killMonster[1].id] >= qt[1367].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("一个人击退了那么大的怪物…不，不会施主就是最近很出名的PLAYERNAME大侠？")
        SET_QUEST_STATE(1367, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("快去悲伤之房击退1个蛇吞象吧！")
    end
  end
  if qData[1368].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1368].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("好了！以后再也不能使用分身了。现在只要上去击退那家伙就可以了！")
        SET_QUEST_STATE(1368, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退悲伤之房的蛇吞象，收集1张蛇吞象符咒回来吧。")
    end
  end
  if qData[1369].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1369].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。还是跟预想的一样…")
        SET_QUEST_STATE(1369, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退悲伤之房的幽灵甲，收集35个幽灵魔珠回来吧。")
    end
  end
  if qData[1370].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1370].goal.getItem) then
      NPC_SAY("千万要去到好的地方…")
      SET_QUEST_STATE(1370, 2)
    else
      NPC_SAY("击退悲伤之房的幽灵甲，收集35个幽灵魔珠回来吧。我会用那些祭祀，安慰一下灵魂的。")
    end
  end
  if qData[1371].state == 1 then
    NPC_SAY("住持在第一寺。去那里的路很险峻，但如果是施主的话，我相信可以平安来回的。")
  end
  if qData[1372].state == 1 then
    NPC_SAY("辛苦了。现在他们也舒服多了吧。")
    SET_QUEST_STATE(1372, 2)
  end
  if qData[1373].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1373].goal.getItem) then
      NPC_SAY("辛苦了。但还有几件事情需要你帮忙。")
      SET_QUEST_STATE(1373, 2)
    else
      NPC_SAY("击退悲伤之房的影妖，收集35个痛苦黑晶体回来吧。我会先准备术法的。")
    end
  end
  if qData[1374].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1374].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[1374].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。现在试试看吧。")
        SET_QUEST_STATE(1374, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退悲伤之房的影妖，收集35个痛苦黑晶体回来吧。快点吧！")
    end
  end
  if qData[1375].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1375].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("好了！这次成功了。但是把施主扔上去的事情等我喘口气之后再说吧。我现在也累了。")
        SET_QUEST_STATE(1375, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退悲伤之房的幽灵甲和小穷鬼，收集幽灵魔珠和穷鬼布袋各15个回来就可以了。")
    end
  end
  if qData[1376].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1376].goal.getItem) then
      NPC_SAY("辛苦了。下面是…。")
      SET_QUEST_STATE(1376, 2)
    else
      NPC_SAY("在悲伤之房击退侵蚀影妖，收集35个侵蚀影妖的油回来吧。")
    end
  end
  if qData[1377].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1377].goal.getItem) then
      NPC_SAY("辛苦了。稍微在努力就…")
      SET_QUEST_STATE(1377, 2)
    else
      NPC_SAY("在生死之房击退黑树妖，收集35个黑树妖皮回来吧。")
    end
  end
  if qData[1378].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1378].goal.getItem) then
      NPC_SAY("辛苦了。恩恩。以后不会再犯相同的失误了。")
      SET_QUEST_STATE(1378, 2)
    else
      NPC_SAY("击退生死之房的侵蚀影妖，收集35个侵蚀影妖的油回来吧。")
    end
  end
  if qData[1379].state == 1 then
    NPC_SAY("去，去哪里啊？（去韩野村码头见研究船的人！）")
  end
  if qData[1381].state == 1 then
    NPC_SAY("嗯？施主，你去哪了了啊？")
    SET_QUEST_STATE(1381, 2)
  end
  if qData[1382].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1382].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。但是不知道这些够不够…")
        SET_QUEST_STATE(1382, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退生死之房的侵蚀黑树妖，收集35个人面根回来吧。")
    end
  end
  if qData[1383].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1383].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("辛苦了。现在不用担心塔会坍塌了。")
        SET_QUEST_STATE(1383, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退生死之房的侵蚀黑树妖，收集35个人面根回来吧。")
    end
  end
  if qData[1384].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1384].goal.getItem) then
      NPC_SAY("辛苦了。我这就出发。等我的好消息吧。")
      SET_QUEST_STATE(1384, 2)
    else
      NPC_SAY("击退生死之房的红树妖，收集35个红树生死液回来吧。")
    end
  end
  if qData[1385].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1385].goal.getItem) then
      NPC_SAY("知，知道了！谁知道会隐藏着这，这样的秘密啊！")
      SET_QUEST_STATE(1385, 2)
    else
      NPC_SAY("击退生死之房的红树妖，收集35个红树生死液回来吧。")
    end
  end
  if qData[1386].state == 1 then
    NPC_SAY("快去见铁腕谷（7）的神檀树，听取答案后回来吧。")
  end
  if qData[1388].state == 1 then
    NPC_SAY("是那样说的吗？知道了。")
    SET_QUEST_STATE(1388, 2)
  end
  if qData[1389].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1389].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("现在一切都结束了。去吧。去面对围绕这个塔的所有真相吧。")
        SET_QUEST_STATE(1389, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退生死之房的侵蚀红树妖，收集35个红树妖皮回来吧。")
    end
  end
  if qData[1390].state == 1 then
    NPC_SAY("去生死地狱见东泼肉吧。")
  end
  if qData[867].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[867].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("来，这是嘉和符咒。希望你能成功击退血玉髓。")
        SET_QUEST_STATE(867, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("快去组队吧。也别忘了拿一个红树生死液回来。")
    end
  end
  if qData[1391].state == 1 then
    NPC_SAY("凶徒匪人在血玉髓房屋顶。")
  end
  if qData[1426].state == 1 then
    NPC_SAY("去{0xFFFFFF00}古老的渡头(6){END}的受苦的导游那儿调查情况吧。")
  end
  if qData[1428].state == 1 then
    NPC_SAY("回来了？到底怎么样？")
    SET_QUEST_STATE(1428, 2)
  end
  if qData[1429].state == 1 then
    NPC_SAY("去见{0xFFFFFF00}第一寺{END}的{0xFFFFFF00}主持{END}听听他的意见")
  end
  if qData[1434].state == 1 then
    NPC_SAY("你来了？有好消息")
    SET_QUEST_STATE(1434, 2)
  end
  if qData[1435].state == 1 then
    NPC_SAY("通过龙林城南边的黄泉结界高僧进入皲裂地狱")
  end
  if qData[3630].state == 1 then
    NPC_SAY("击退血玉髓后去见凶徒匪人吧")
  end
  ADD_NEW_SHOP_BTN(id, 10066)
  if qData[973].state == 0 and GET_PLAYER_LEVEL() >= qt[973].needLevel and GET_PLAYER_JOB2() ~= 13 then
    ADD_QUEST_BTN(qt[973].id, qt[973].name)
  end
  if qData[889].state == 0 and GET_PLAYER_LEVEL() >= qt[889].needLevel and GET_PLAYER_JOB2() ~= 13 then
    ADD_QUEST_BTN(qt[889].id, qt[889].name)
  end
  if qData[1348].state == 0 and GET_PLAYER_LEVEL() >= qt[1348].needLevel then
    ADD_QUEST_BTN(qt[1348].id, qt[1348].name)
  end
  if qData[1349].state == 0 and qData[1348].state == 2 and GET_PLAYER_LEVEL() >= qt[1349].needLevel then
    ADD_QUEST_BTN(qt[1349].id, qt[1349].name)
  end
  if qData[1350].state == 0 and qData[1349].state == 2 and GET_PLAYER_LEVEL() >= qt[1350].needLevel then
    ADD_QUEST_BTN(qt[1350].id, qt[1350].name)
  end
  if qData[1351].state == 0 and qData[1350].state == 2 and GET_PLAYER_LEVEL() >= qt[1351].needLevel then
    ADD_QUEST_BTN(qt[1351].id, qt[1351].name)
  end
  if qData[1352].state == 0 and qData[1351].state == 2 and GET_PLAYER_LEVEL() >= qt[1352].needLevel then
    ADD_QUEST_BTN(qt[1352].id, qt[1352].name)
  end
  if qData[1353].state == 0 and GET_PLAYER_LEVEL() >= qt[1353].needLevel then
    ADD_QUEST_BTN(qt[1353].id, qt[1353].name)
  end
  if qData[1354].state == 0 and qData[1352].state == 2 and GET_PLAYER_LEVEL() >= qt[1354].needLevel then
    ADD_QUEST_BTN(qt[1354].id, qt[1354].name)
  end
  if qData[1355].state == 0 and qData[1354].state == 2 and GET_PLAYER_LEVEL() >= qt[1355].needLevel then
    ADD_QUEST_BTN(qt[1355].id, qt[1355].name)
  end
  if qData[1356].state == 0 and qData[1355].state == 2 and GET_PLAYER_LEVEL() >= qt[1356].needLevel then
    ADD_QUEST_BTN(qt[1356].id, qt[1356].name)
  end
  if qData[1357].state == 0 and qData[1356].state == 2 and GET_PLAYER_LEVEL() >= qt[1357].needLevel then
    ADD_QUEST_BTN(qt[1357].id, qt[1357].name)
  end
  if qData[1358].state == 0 and qData[1357].state == 2 and GET_PLAYER_LEVEL() >= qt[1358].needLevel then
    ADD_QUEST_BTN(qt[1358].id, qt[1358].name)
  end
  if qData[1359].state == 0 and GET_PLAYER_LEVEL() >= qt[1359].needLevel then
    ADD_QUEST_BTN(qt[1359].id, qt[1359].name)
  end
  if qData[1360].state == 0 and qData[1358].state == 2 and GET_PLAYER_LEVEL() >= qt[1360].needLevel then
    ADD_QUEST_BTN(qt[1360].id, qt[1360].name)
  end
  if qData[1361].state == 0 and qData[1360].state == 2 and GET_PLAYER_LEVEL() >= qt[1361].needLevel then
    ADD_QUEST_BTN(qt[1361].id, qt[1361].name)
  end
  if qData[1362].state == 0 and qData[1361].state == 2 and GET_PLAYER_LEVEL() >= qt[1362].needLevel then
    ADD_QUEST_BTN(qt[1362].id, qt[1362].name)
  end
  if qData[1363].state == 0 and GET_PLAYER_LEVEL() >= qt[1363].needLevel then
    ADD_QUEST_BTN(qt[1363].id, qt[1363].name)
  end
  if qData[1364].state == 0 and qData[1347].state == 2 and GET_PLAYER_LEVEL() >= qt[1364].needLevel then
    ADD_QUEST_BTN(qt[1364].id, qt[1364].name)
  end
  if qData[1365].state == 0 and GET_PLAYER_LEVEL() >= qt[1365].needLevel then
    ADD_QUEST_BTN(qt[1365].id, qt[1365].name)
  end
  if qData[1366].state == 0 and GET_PLAYER_LEVEL() >= qt[1366].needLevel then
    ADD_QUEST_BTN(qt[1366].id, qt[1366].name)
  end
  if qData[1367].state == 0 and qData[1366].state == 2 and GET_PLAYER_LEVEL() >= qt[1367].needLevel then
    ADD_QUEST_BTN(qt[1367].id, qt[1367].name)
  end
  if qData[1368].state == 0 and qData[1367].state == 2 and GET_PLAYER_LEVEL() >= qt[1368].needLevel then
    ADD_QUEST_BTN(qt[1368].id, qt[1368].name)
  end
  if qData[1369].state == 0 and qData[1368].state == 2 and GET_PLAYER_LEVEL() >= qt[1369].needLevel then
    ADD_QUEST_BTN(qt[1369].id, qt[1369].name)
  end
  if qData[1370].state == 0 and qData[1369].state == 2 and GET_PLAYER_LEVEL() >= qt[1370].needLevel then
    ADD_QUEST_BTN(qt[1370].id, qt[1370].name)
  end
  if qData[1371].state == 0 and qData[1370].state == 2 and GET_PLAYER_LEVEL() >= qt[1371].needLevel then
    ADD_QUEST_BTN(qt[1371].id, qt[1371].name)
  end
  if qData[1373].state == 0 and qData[1372].state == 2 and GET_PLAYER_LEVEL() >= qt[1373].needLevel then
    ADD_QUEST_BTN(qt[1373].id, qt[1373].name)
  end
  if qData[1374].state == 0 and qData[1373].state == 2 and GET_PLAYER_LEVEL() >= qt[1374].needLevel then
    ADD_QUEST_BTN(qt[1374].id, qt[1374].name)
  end
  if qData[1375].state == 0 and qData[1374].state == 2 and GET_PLAYER_LEVEL() >= qt[1375].needLevel then
    ADD_QUEST_BTN(qt[1375].id, qt[1375].name)
  end
  if qData[1376].state == 0 and qData[1375].state == 2 and GET_PLAYER_LEVEL() >= qt[1376].needLevel then
    ADD_QUEST_BTN(qt[1376].id, qt[1376].name)
  end
  if qData[1377].state == 0 and qData[1376].state == 2 and GET_PLAYER_LEVEL() >= qt[1377].needLevel then
    ADD_QUEST_BTN(qt[1377].id, qt[1377].name)
  end
  if qData[1378].state == 0 and qData[1377].state == 2 and GET_PLAYER_LEVEL() >= qt[1378].needLevel then
    ADD_QUEST_BTN(qt[1378].id, qt[1378].name)
  end
  if qData[1379].state == 0 and qData[1378].state == 2 and GET_PLAYER_LEVEL() >= qt[1379].needLevel then
    ADD_QUEST_BTN(qt[1379].id, qt[1379].name)
  end
  if qData[1382].state == 0 and qData[1381].state == 2 and GET_PLAYER_LEVEL() >= qt[1382].needLevel then
    ADD_QUEST_BTN(qt[1382].id, qt[1382].name)
  end
  if qData[1383].state == 0 and qData[1382].state == 2 and GET_PLAYER_LEVEL() >= qt[1383].needLevel then
    ADD_QUEST_BTN(qt[1383].id, qt[1383].name)
  end
  if qData[1384].state == 0 and qData[1383].state == 2 and GET_PLAYER_LEVEL() >= qt[1384].needLevel then
    ADD_QUEST_BTN(qt[1384].id, qt[1384].name)
  end
  if qData[1385].state == 0 and qData[1384].state == 2 and GET_PLAYER_LEVEL() >= qt[1385].needLevel then
    ADD_QUEST_BTN(qt[1385].id, qt[1385].name)
  end
  if qData[1386].state == 0 and qData[1385].state == 2 and GET_PLAYER_LEVEL() >= qt[1386].needLevel then
    ADD_QUEST_BTN(qt[1386].id, qt[1386].name)
  end
  if qData[1389].state == 0 and qData[1388].state == 2 and GET_PLAYER_LEVEL() >= qt[1389].needLevel then
    ADD_QUEST_BTN(qt[1389].id, qt[1389].name)
  end
  if qData[1390].state == 0 and qData[1389].state == 2 and GET_PLAYER_LEVEL() >= qt[1390].needLevel then
    ADD_QUEST_BTN(qt[1390].id, qt[1390].name)
  end
  if qData[867].state == 0 and GET_PLAYER_LEVEL() >= qt[867].needLevel then
    ADD_QUEST_BTN(qt[867].id, qt[867].name)
  end
  if qData[1391].state == 0 and qData[1390].state == 2 and GET_PLAYER_LEVEL() >= qt[1391].needLevel then
    ADD_QUEST_BTN(qt[1391].id, qt[1391].name)
  end
  if qData[1426].state == 0 and GET_PLAYER_LEVEL() >= qt[1426].needLevel and GET_PLAYER_JOB2() then
    ADD_QUEST_BTN(qt[1426].id, qt[1426].name)
  end
  if qData[1429].state == 0 and qData[1428].state == 2 and GET_PLAYER_LEVEL() >= qt[1429].needLevel then
    ADD_QUEST_BTN(qt[1429].id, qt[1429].name)
  end
  if qData[1435].state == 0 and qData[1434].state == 2 and GET_PLAYER_LEVEL() >= qt[1435].needLevel then
    ADD_QUEST_BTN(qt[1435].id, qt[1435].name)
  end
  if qData[3630].state == 0 and qData[1391].state == 2 and GET_PLAYER_LEVEL() >= qt[3630].needLevel then
    ADD_QUEST_BTN(qt[3630].id, qt[3630].name)
  end
  if qData[1356].state == 2 then
    NPC_WARP_TO_PAINROOM(id)
  end
  if qData[1363].state == 2 then
    NPC_WARP_TO_SADROOM(id)
  end
  if qData[1375].state == 2 then
    NPC_WARP_TO_LIFEROOM(id)
  end
  if qData[1390].state == 2 then
    NPC_WARP_TO_BLOODROOM(id)
  end
  if qData[1391].state == 2 then
    NPC_WARP_TO_BLOODUPROOM(id)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[889].state ~= 2 and GET_PLAYER_LEVEL() >= qt[889].needLevel then
    if qData[889].state == 1 then
      if qData[889].killMonster[qt[889].goal.killMonster[1].id] >= qt[889].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1348].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1348].needLevel then
    if qData[1348].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1348].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1349].state ~= 2 and qData[1348].state == 2 and GET_PLAYER_LEVEL() >= qt[1349].needLevel then
    if qData[1349].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1349].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1350].state ~= 2 and qData[1349].state == 2 and GET_PLAYER_LEVEL() >= qt[1350].needLevel then
    if qData[1350].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1350].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1351].state ~= 2 and qData[1350].state == 2 and GET_PLAYER_LEVEL() >= qt[1351].needLevel then
    if qData[1351].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1351].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1352].state ~= 2 and qData[1351].state == 2 and GET_PLAYER_LEVEL() >= qt[1352].needLevel then
    if qData[1352].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1352].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1353].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1353].needLevel then
    if qData[1353].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1353].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1354].state ~= 2 and qData[1352].state == 2 and GET_PLAYER_LEVEL() >= qt[1354].needLevel then
    if qData[1354].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1354].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[1354].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1355].state ~= 2 and qData[1354].state == 2 and GET_PLAYER_LEVEL() >= qt[1355].needLevel then
    if qData[1355].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1355].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1356].state ~= 2 and qData[1355].state == 2 and GET_PLAYER_LEVEL() >= qt[1356].needLevel then
    if qData[1356].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1356].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1357].state ~= 2 and qData[1356].state == 2 and GET_PLAYER_LEVEL() >= qt[1357].needLevel then
    if qData[1357].state == 1 then
      if qData[1357].killMonster[qt[1357].goal.killMonster[1].id] >= qt[1357].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1358].state ~= 2 and qData[1357].state == 2 and GET_PLAYER_LEVEL() >= qt[1358].needLevel then
    if qData[1358].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1358].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1359].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1359].needLevel then
    if qData[1359].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1359].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1360].state ~= 2 and qData[1358].state == 2 and GET_PLAYER_LEVEL() >= qt[1360].needLevel then
    if qData[1360].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1360].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1361].state ~= 2 and qData[1360].state == 2 and GET_PLAYER_LEVEL() >= qt[1361].needLevel then
    if qData[1361].state == 1 then
      if qData[1361].killMonster[qt[1361].goal.killMonster[1].id] >= qt[1361].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1362].state ~= 2 and qData[1361].state == 2 and GET_PLAYER_LEVEL() >= qt[1362].needLevel then
    if qData[1362].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1362].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1363].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1363].needLevel then
    if qData[1363].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1363].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1364].state ~= 2 and qData[1347].state == 2 and GET_PLAYER_LEVEL() >= qt[1364].needLevel then
    if qData[1364].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1364].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1365].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1365].needLevel then
    if qData[1365].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1365].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1366].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1366].needLevel then
    if qData[1366].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1366].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1367].state ~= 2 and qData[1366].state == 2 and GET_PLAYER_LEVEL() >= qt[1367].needLevel then
    if qData[1367].state == 1 then
      if qData[1367].killMonster[qt[1367].goal.killMonster[1].id] >= qt[1367].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1368].state ~= 2 and qData[1367].state == 2 and GET_PLAYER_LEVEL() >= qt[1368].needLevel then
    if qData[1368].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1368].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1369].state ~= 2 and qData[1368].state == 2 and GET_PLAYER_LEVEL() >= qt[1369].needLevel then
    if qData[1369].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1369].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1370].state ~= 2 and qData[1369].state == 2 and GET_PLAYER_LEVEL() >= qt[1370].needLevel then
    if qData[1370].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1370].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1371].state ~= 2 and qData[1370].state == 2 and GET_PLAYER_LEVEL() >= qt[1371].needLevel then
    if qData[1371].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1372].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1373].state ~= 2 and qData[1372].state == 2 and GET_PLAYER_LEVEL() >= qt[1373].needLevel then
    if qData[1373].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1373].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1374].state ~= 2 and qData[1373].state == 2 and GET_PLAYER_LEVEL() >= qt[1374].needLevel then
    if qData[1374].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1374].goal.getItem) and __QUEST_HAS_ALL_ITEMS(qt[1374].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1375].state ~= 2 and qData[1374].state == 2 and GET_PLAYER_LEVEL() >= qt[1375].needLevel then
    if qData[1375].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1375].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1376].state ~= 2 and qData[1375].state == 2 and GET_PLAYER_LEVEL() >= qt[1376].needLevel then
    if qData[1376].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1376].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1377].state ~= 2 and qData[1376].state == 2 and GET_PLAYER_LEVEL() >= qt[1377].needLevel then
    if qData[1377].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1377].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1378].state ~= 2 and qData[1377].state == 2 and GET_PLAYER_LEVEL() >= qt[1378].needLevel then
    if qData[1378].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1378].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1379].state ~= 2 and qData[1378].state == 2 and GET_PLAYER_LEVEL() >= qt[1379].needLevel then
    if qData[1379].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1381].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1382].state ~= 2 and qData[1381].state == 2 and GET_PLAYER_LEVEL() >= qt[1382].needLevel then
    if qData[1382].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1382].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1383].state ~= 2 and qData[1382].state == 2 and GET_PLAYER_LEVEL() >= qt[1383].needLevel then
    if qData[1383].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1383].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1384].state ~= 2 and qData[1383].state == 2 and GET_PLAYER_LEVEL() >= qt[1384].needLevel then
    if qData[1384].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1384].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1385].state ~= 2 and qData[1384].state == 2 and GET_PLAYER_LEVEL() >= qt[1385].needLevel then
    if qData[1385].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1385].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1386].state ~= 2 and qData[1385].state == 2 and GET_PLAYER_LEVEL() >= qt[1386].needLevel then
    if qData[1386].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1388].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1389].state ~= 2 and qData[1388].state == 2 and GET_PLAYER_LEVEL() >= qt[1389].needLevel then
    if qData[1389].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1389].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1390].state ~= 2 and qData[1389].state == 2 and GET_PLAYER_LEVEL() >= qt[1390].needLevel then
    if qData[1390].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[867].state ~= 2 and GET_PLAYER_LEVEL() >= qt[867].needLevel then
    if qData[867].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[867].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1391].state ~= 2 and qData[1390].state == 2 and GET_PLAYER_LEVEL() >= qt[1391].needLevel then
    if qData[1391].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1426].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1426].needLevel and GET_PLAYER_JOB2() ~= 13 then
    if qData[1426].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1426].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1428].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1429].state ~= 2 and qData[1428].state == 2 and GET_PLAYER_LEVEL() >= qt[1429].needLevel then
    if qData[1429].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1434].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1435].state ~= 2 and qData[1434].state == 2 and GET_PLAYER_LEVEL() >= qt[1435].needLevel then
    if qData[1435].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3630].state ~= 2 and qData[1391].state == 2 and GET_PLAYER_LEVEL() >= qt[3630].needLevel then
    if qData[3630].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
