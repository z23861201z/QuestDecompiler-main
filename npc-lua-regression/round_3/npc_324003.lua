function npcsay(id)
  if id ~= 4324003 then
    return
  end
  clickNPCid = id
  NPC_SAY("真天光明 拜火成势！远道而来辛苦了。兄弟们，我们是在中原的复兴魔教的先锋队，一定要尽力。")
  if qData[2262].state == 1 then
    NPC_SAY("复明魔尊！光荣千岁！辛苦了，我的兄弟。大家凝聚力量让魔教的光辉笼罩着中原大地吧")
    SET_QUEST_STATE(2262, 2)
    return
  end
  if qData[2267].state == 1 then
    NPC_SAY("复明魔尊！光荣千岁！辛苦了，我的兄弟。大家凝聚力量让魔教的光辉笼罩着中原大地吧")
    SET_QUEST_STATE(2267, 2)
    return
  end
  if qData[1913].state == 1 then
    NPC_SAY("我的兄弟，身体还好吗？看来是经历千辛万苦来到了这里啊")
    SET_QUEST_STATE(1913, 2)
    return
  end
  if qData[1919].state == 1 then
    NPC_SAY("我的兄弟，身体还好吗？看来是经历千辛万苦来到了这里?")
    SET_QUEST_STATE(1919, 2)
    return
  end
  if qData[1912].state == 1 then
    NPC_SAY("复明魔尊！光荣千岁！回过神来了吗？我的兄弟啊")
    SET_QUEST_STATE(1912, 2)
    return
  end
  if qData[1918].state == 1 then
    NPC_SAY("复明魔尊！光荣千岁！回过神来了吗？我的兄弟啊")
    SET_QUEST_STATE(1918, 2)
    return
  end
  if qData[1515].state == 1 then
    NPC_SAY("复明魔尊！光荣千岁！辛苦了，我的兄弟。大家凝聚力量让魔教的光辉笼罩着中原大地吧")
    SET_QUEST_STATE(1515, 2)
    return
  end
  if qData[1516].state == 1 then
    NPC_SAY("复明魔尊！光荣千岁！辛苦了，我的兄弟。大家凝聚力量让魔教的光辉笼罩着中原大地吧")
    SET_QUEST_STATE(1516, 2)
    return
  end
  if qData[1517].state == 1 then
    NPC_SAY("{0xFFFFFF00}是使用[I]键打开行囊，利用窗口下方的便捷功能-魔气充电将普通装备箱子登录上去转换成魔教装备箱子。{END}记住了吗？准备好了再次跟我对话吧")
    SET_QUEST_STATE(1517, 2)
  end
  if qData[1518].state == 1 then
    if CHECK_ITEM_CNT(17991041) > 0 then
      NPC_SAY("做得好。以后每次得到装备箱子的时候就按刚才的方式魔气充电后打开吧。千万不要随便打开箱子。性急打开箱子的结果都会是你本人的责任！")
      SET_QUEST_STATE(1518, 2)
    else
      NPC_SAY("使用{0xFFFFFF00}[I]{END}键打开行囊，利用窗口下方的{0xFFFFFF00}便捷功能，[ 魔气充电]{END}将{0xFFFFFF00}普通装备箱子{END}登录上去转换成魔教装备箱子吧")
    end
  end
  if qData[1519].state == 1 then
    NPC_SAY("试着学武功吧，我的兄弟")
    SET_QUEST_STATE(1519, 2)
  end
  if qData[1520].state == 1 then
    NPC_SAY("我再说一次，我的兄弟，按[D]键打开武功窗口后点击要学习的泰华武功，将怪物击退给泰华武功积累魂，魂满后你就学到泰华武功了")
    SET_QUEST_STATE(1520, 2)
  end
  if qData[1521].state == 1 then
    NPC_SAY("辛苦了，兄弟。不要忘了时刻做好战斗准备")
    SET_QUEST_STATE(1521, 2)
  end
  if qData[1522].state == 1 then
    NPC_SAY("{0xFFFFFF00}按[Shift]键变身鬼魂者后，再按[D]键佩戴想要的魂坛子吧。{END}那样就可以使用你内心潜在的强大的力量了")
    SET_QUEST_STATE(1522, 2)
  end
  if qData[1523].state == 1 then
    if qData[1523].killMonster[qt[1523].goal.killMonster[1].id] >= qt[1523].goal.killMonster[1].count then
      NPC_SAY("辛苦了。虽然功力减少了一半，但依然拥有出众的武艺啊")
      SET_QUEST_STATE(1523, 2)
    else
      NPC_SAY("击退{0xFFFFFF00}[龙林山]{END}的10个{0xFFFFFF00}[虾米狼]{END}后回来吧")
    end
  end
  if qData[1524].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1524].goal.getItem) then
      NPC_SAY("辛苦了！你获得了门主的资格。我的兄弟")
      SET_QUEST_STATE(1524, 2)
    else
      NPC_SAY("击退{0xFFFFFF00}[龙林山]{END}的{0xFFFFFF00}猴赛雷{END}，给我拿来{0xFFFFFF00}1张猴赛雷符咒{END}吧")
    end
  end
  if qData[1525].state == 1 then
    NPC_SAY("通过{0xFFFFFF00}[异界门]{END}前的{0xFFFFFF00}[黄泉结界高僧]{END}，进入{0xFFFFFF00}[异界门]{END}见到{0xFFFFFF00}[汉谟拉比商人]{END}，帮助她就可以了")
  end
  if qData[1526].state == 1 then
    NPC_SAY("击退{0xFFFFFF00}[龙林谷]{END}的{0xFFFFFF00}[铁牛运功散]20只{END}后，去找{0xFFFFFF00}[龙林城 北边]{END}的{0xFFFFFF00}[龙林城父母官]")
  end
  if qData[885].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[885].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("哦哦…我不会忘记你给我的帮助的。这里是奖励，如果不合心意的话明天再来找我！")
        SET_QUEST_STATE(885, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}一天之内{END}击退功力不相差10的怪物，收集{0xFFFFFF00}10个[魔教令牌]{END}可以获取{0xFFFFFF00}[魔教宝箱]{END}，里面有意想不到的礼物")
    end
  end
  if qData[2614].state == 1 then
    NPC_SAY("来的正好！这是以后在这里生活所需的补给品。")
    SET_QUEST_STATE(2614, 2)
    return
  end
  if qData[2620].state == 1 then
    NPC_SAY("来的正好！这是以后在这里生活所需的补给品。")
    SET_QUEST_STATE(2620, 2)
    return
  end
  if qData[2768].state == 1 then
    NPC_SAY("来，这里...")
    SET_QUEST_STATE(2768, 2)
    return
  end
  if qData[2772].state == 1 then
    NPC_SAY("来，这里...")
    SET_QUEST_STATE(2772, 2)
    return
  end
  if qData[2777].state == 1 then
    NPC_SAY("欢迎来到中原...")
    SET_QUEST_STATE(2777, 2)
    return
  end
  if qData[2778].state == 1 then
    NPC_SAY("欢迎来到中原...")
    SET_QUEST_STATE(2778, 2)
    return
  end
  if 0 < GET_PLAYER_JOB2() and qData[1519].state == 2 then
    LearnSkill(id)
  end
  if qData[1524].state == 2 then
    ADD_NPC_GUILD_CREATE(id)
  end
  if qData[1524].state == 2 then
    GET_NPC_GUILD_LIST(id)
  end
  if qData[1517].state == 0 and GET_PLAYER_FACTION() == 2 then
    ADD_QUEST_BTN(qt[1517].id, qt[1517].name)
  end
  if qData[1518].state == 0 and qData[1517].state == 2 then
    ADD_QUEST_BTN(qt[1518].id, qt[1518].name)
  end
  if qData[1519].state == 0 and qData[1518].state == 2 then
    ADD_QUEST_BTN(qt[1519].id, qt[1519].name)
  end
  if qData[1520].state == 0 and qData[1519].state == 2 then
    ADD_QUEST_BTN(qt[1520].id, qt[1520].name)
  end
  if qData[1521].state == 0 and qData[1520].state == 2 then
    ADD_QUEST_BTN(qt[1521].id, qt[1521].name)
  end
  if qData[1522].state == 0 and qData[1521].state == 2 then
    ADD_QUEST_BTN(qt[1522].id, qt[1522].name)
  end
  if qData[1523].state == 0 and qData[1522].state == 2 then
    ADD_QUEST_BTN(qt[1523].id, qt[1523].name)
  end
  if qData[1524].state == 0 and qData[1523].state == 2 then
    ADD_QUEST_BTN(qt[1524].id, qt[1524].name)
  end
  if qData[1525].state == 0 and qData[1523].state == 2 then
    ADD_QUEST_BTN(qt[1525].id, qt[1525].name)
  end
  if qData[1526].state == 0 and qData[1523].state == 2 then
    ADD_QUEST_BTN(qt[1526].id, qt[1526].name)
  end
  if qData[2777].state == 0 and qData[2768].state == 2 and GET_PLAYER_LEVEL() >= qt[2777].needLevel then
    ADD_QUEST_BTN(qt[2777].id, qt[2777].name)
  end
  if qData[2778].state == 0 and qData[2772].state == 2 and GET_PLAYER_LEVEL() >= qt[2778].needLevel then
    ADD_QUEST_BTN(qt[2778].id, qt[2778].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2262].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2267].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1913].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1919].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1912].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1918].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1515].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1516].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1517].state ~= 2 and GET_PLAYER_FACTION() == 2 then
    if qData[1517].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1518].state ~= 2 and qData[1517].state == 2 then
    if qData[1518].state == 1 then
      if 0 < CHECK_ITEM_CNT(17991041) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1519].state ~= 2 and qData[1518].state == 2 then
    if qData[1519].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1520].state ~= 2 and qData[1519].state == 2 then
    if qData[1520].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1521].state ~= 2 and qData[1520].state == 2 then
    if qData[1521].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1522].state ~= 2 and qData[1521].state == 2 then
    if qData[1522].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1523].state ~= 2 and qData[1522].state == 2 then
    if qData[1523].state == 1 then
      if qData[1523].killMonster[qt[1523].goal.killMonster[1].id] >= qt[1523].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1524].state ~= 2 and qData[1523].state == 2 then
    if qData[1524].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1524].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1525].state ~= 2 and qData[1523].state == 2 then
    if qData[1525].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1526].state ~= 2 and qData[1523].state == 2 then
    if qData[1526].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[885].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[885].goal.getItem) then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[2614].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2620].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2768].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2772].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2777].state ~= 2 and qData[2768].state == 2 and GET_PLAYER_LEVEL() >= qt[2777].needLevel then
    if qData[2777].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2778].state ~= 2 and qData[2772].state == 2 and GET_PLAYER_LEVEL() >= qt[2778].needLevel then
    if qData[2778].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
end
