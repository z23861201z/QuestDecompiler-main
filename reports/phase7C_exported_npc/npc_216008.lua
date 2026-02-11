function npcsay(id)
  if id ~= 4216008 then
    return
  end
  clickNPCid = id
  NPC_SAY("现在我只有这些了，想买就买吧。")
  if qData[1011].state == 1 then
    if CHECK_ITEM_CNT(qt[1011].goal.getItem[1].id) >= qt[1011].goal.getItem[1].count then
      NPC_SAY("真太感谢您的帮忙了。我能报答的就只有这些了")
      SET_QUEST_STATE(1011, 2)
      return
    else
      NPC_SAY("还不够{0xFFFFFF00}50个破旧轴画{END}么？")
      return
    end
  end
  if qData[1012].state == 1 then
    NPC_SAY("没时间了。快一点儿")
    return
  end
  if qData[2354].state == 1 and qData[2354].meetNpc[1] ~= id then
    NPC_SAY("困瘤荐丛阑 茫绰促绊夸? 臂疥夸. 焊矫绰 官客 鞍捞 咯扁绰 历甫 器窃秦辑 技荤恩挥涝聪促.")
    SET_MEETNPC(2354, 1, id)
  end
  if qData[2419].state == 1 then
    NPC_SAY("捞 寇柳 镑俊 绢骂 荤恩捞 促 茫酒吭绰绊?")
    SET_QUEST_STATE(2419, 2)
    return
  end
  if qData[2420].state == 1 then
    NPC_SAY("硅甫 绊媚具 邓聪促. 拳瞒符阑 硼摹窍绊 {0xFFFFFF00}弊阑赴唱公炼阿 30俺{END}甫 备秦辑 荤傍丛膊 傈秦靛府技夸.")
  end
  if qData[2422].state == 1 then
    NPC_SAY("啊厘 啊鳖款 镑篮 {0xFFFFFF00}绊遏锰狼盔丛捞 拌矫绰 绊遏锰涝聪促.{END}")
  end
  if qData[2439].state == 1 then
    if CHECK_ITEM_CNT(qt[2439].goal.getItem[1].id) >= qt[2439].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2439].goal.getItem[2].id) >= qt[2439].goal.getItem[2].count then
      NPC_SAY("皑荤钦聪促.")
      SET_QUEST_STATE(2439, 2)
      return
    else
      NPC_SAY("蓖林档俊辑父 唱绰 拱扒甸涝聪促. {0xFFFFFF00}孺窍悼滴俺榜苞 盔屈焕炼阿阑 10俺究{END} 备秦林矫搁 邓聪促. 孺窍悼滴俺榜篮 孺窍悼阑, 盔屈焕炼阿篮 盟澜阑 硼摹窍绊 掘阑 荐 乐嚼聪促.")
    end
  end
  if qData[2440].state == 1 then
    if CHECK_ITEM_CNT(qt[2440].goal.getItem[1].id) >= qt[2440].goal.getItem[1].count then
      NPC_SAY("皑荤钦聪促.")
      SET_QUEST_STATE(2440, 2)
      return
    else
      NPC_SAY("蓖林档俊 啊寂辑 {0xFFFFFF00}孺窍悼滴俺榜阑 70俺{END}父 备秦林技夸. 孺窍悼滴俺榜篮 孺窍悼阑 硼摹窍绊 掘阑 荐 乐嚼聪促.")
    end
  end
  if qData[2441].state == 1 then
    if CHECK_ITEM_CNT(qt[2441].goal.getItem[1].id) >= qt[2441].goal.getItem[1].count then
      NPC_SAY("皑荤钦聪促. 备秦林脚 蓖林档狼 拱扒甸篮 肋 静摆嚼聪促.")
      SET_QUEST_STATE(2441, 2)
      return
    else
      NPC_SAY("蓖林档俊 啊寂辑 盟澜阑 硼摹窍绊 {0xFFFFFF00}盔屈焕炼阿 70俺{END}父 备秦林技夸.")
    end
  end
  if qData[2489].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("坷罚父俊 核嚼聪促. 公郊 老肺 坷继唱夸?")
      SET_QUEST_STATE(2489, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促!")
    end
  end
  if qData[2490].state == 1 then
    if CHECK_ITEM_CNT(qt[2490].goal.getItem[1].id) >= qt[2490].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("亮嚼聪促. 官肺 惑磊甫 荐府窍摆嚼聪促.")
        SET_QUEST_STATE(2490, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促!")
      end
    else
      NPC_SAY("{0xFFFFFF00}伙碍悼傈殿辉篮 孺蓖林盔俊辑 伙碍悼傈阑 硼摹窍搁{END} 备且 荐 乐嚼聪促. {0xFFFFFF00}伙碍悼傈殿辉 50俺{END}甫 备秦林技夸.")
    end
  end
  if qData[2491].state == 1 then
    if CHECK_ITEM_CNT(qt[2491].goal.getItem[1].id) >= qt[2491].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("绢叼.. 嘎焙夸. 力啊 吝拳矫虐摆嚼聪促.")
        SET_QUEST_STATE(2491, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促!")
      end
    else
      NPC_SAY("{0xFFFFFF00}荤豪蓖刀魔篮 归蓖林盔俊辑 荤豪蓖甫 硼摹窍搁{END} 备且 荐 乐嚼聪促. {0xFFFFFF00}荤豪蓖刀魔 70俺{END}甫 备秦林技夸.")
    end
  end
  if qData[2492].state == 1 then
    if CHECK_ITEM_CNT(qt[2492].goal.getItem[1].id) >= qt[2492].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2492].goal.getItem[2].id) >= qt[2492].goal.getItem[2].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("绢叼.. 嘎焙夸.")
        SET_QUEST_STATE(2492, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促!")
      end
    else
      NPC_SAY("{0xFFFFFF00}孺蓖林盔俊辑 腊救蓖{END}甫 硼摹窍绊 {0xFFFFFF00}腊救蓖荐咀 50俺{END}甫, {0xFFFFFF00}孺蓖趋肺俊辑 藕林绢{END}甫 硼摹窍绊 {0xFFFFFF00}藕林绢弧魄 50俺{END}甫 备秦林技夸.")
    end
  end
  if qData[2493].state == 1 then
    if CHECK_ITEM_CNT(qt[2493].goal.getItem[1].id) >= qt[2493].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("亮嚼聪促. 捞力 葛电 霖厚啊 场车嚼聪促. 咯扁 {0xFFFFFF00}备鞭距惑磊{END}涝聪促.")
        SET_QUEST_STATE(2493, 2)
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促!")
      end
    else
      NPC_SAY("{0xFFFFFF00}孺蓖趋肺俊辑 荤锋{END}阑 硼摹窍矫绊 {0xFFFFFF00}荤锋荐堪{END}阑 35俺甫 备秦坷矫搁 邓聪促.")
    end
  end
  if qData[3666].state == 1 then
    if CHECK_ITEM_CNT(qt[3666].goal.getItem[1].id) >= qt[3666].goal.getItem[1].count then
      NPC_SAY("谢谢！")
      SET_QUEST_STATE(3666, 2)
      return
    else
      NPC_SAY("帮忙收集{0xFFFFFF00}虎头蛇怪{END}的{0xFFFFFF00}60个怪异的虎皮{END}回来吧")
    end
  end
  if qData[3667].state == 1 then
    if CHECK_ITEM_CNT(qt[3667].goal.getItem[1].id) >= qt[3667].goal.getItem[1].count then
      NPC_SAY("谢谢！")
      SET_QUEST_STATE(3667, 2)
      return
    else
      NPC_SAY("帮忙收集{0xFFFFFF00}轴画妖女{END}的{0xFFFFFF00}60个破旧轴画{END}回来吧")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10035)
  if qData[1011].state == 0 then
    ADD_QUEST_BTN(qt[1011].id, qt[1011].name)
  end
  if qData[1012].state == 0 then
    ADD_QUEST_BTN(qt[1012].id, qt[1012].name)
  end
  if qData[3666].state == 0 and GET_PLAYER_LEVEL() >= qt[3666].needLevel then
    ADD_QUEST_BTN(qt[3666].id, qt[3666].name)
  end
  if qData[3667].state == 0 and GET_PLAYER_LEVEL() >= qt[3667].needLevel then
    ADD_QUEST_BTN(qt[3667].id, qt[3667].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1011].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1011].needLevel then
    if qData[1011].state == 1 then
      if CHECK_ITEM_CNT(qt[1011].goal.getItem[1].id) >= qt[1011].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1012].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1012].needLevel then
    if qData[1012].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3666].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3666].needLevel then
    if qData[3666].state == 1 then
      if CHECK_ITEM_CNT(qt[3666].goal.getItem[1].id) >= qt[3666].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3667].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3667].needLevel then
    if qData[3667].state == 1 then
      if CHECK_ITEM_CNT(qt[3667].goal.getItem[1].id) >= qt[3667].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
