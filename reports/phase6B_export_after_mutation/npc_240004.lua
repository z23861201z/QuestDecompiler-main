function npcsay(id)
  if id ~= 4240004 then
    return
  end
  clickNPCid = id
  NPC_SAY("不要到处看，要买就买，不买就出去！")
  if qData[1479].state == 1 then
    if CHECK_ITEM_CNT(qt[1479].goal.getItem[1].id) >= qt[1479].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("让我看看啊 把这个和这个混在一起…好了！可以重新制作失传的祖传药了！谢谢。这是答应你的{0xFFFFFF00}推荐书{END}！")
        SET_QUEST_STATE(1479, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去{0xFFFFFF00}獐子潭洞穴{END}击退{0xFFFFFF00}妖粉怪{END}之后，收集{0xFFFFFF00}50个妖精粉{END}回来就给你{0xFFFFFF00}推荐书{END}")
    end
  end
  if qData[2184].state == 1 then
    if CHECK_ITEM_CNT(qt[2184].goal.getItem[1].id) >= qt[2184].goal.getItem[1].count then
      NPC_SAY("谢谢。我以后不会再发脾气了")
      SET_QUEST_STATE(2184, 2)
      return
    else
      NPC_SAY("击退小火龙，收集50个小火龙翅膀回来吧")
    end
  end
  if qData[2588].state == 1 then
    if CHECK_ITEM_CNT(qt[2588].goal.getItem[1].id) >= qt[2588].goal.getItem[1].count then
      NPC_SAY("辛苦了，你有机会也喝一次红色英招的尾巴汤吧，味道一流！")
      SET_QUEST_STATE(2588, 2)
      return
    else
      NPC_SAY("击退黑色丘陵的{0xFFFFFF00}[红色英招]{END}，收集{0xFFFFFF00}50个红色英招的尾巴{END}回来就可以了。")
    end
  end
  if qData[2590].state == 1 then
    if CHECK_ITEM_CNT(qt[2590].goal.getItem[1].id) >= qt[2590].goal.getItem[1].count then
      NPC_SAY("比我预想的还要快啊！看来你的武功很不一般啊~")
      SET_QUEST_STATE(2590, 2)
      return
    else
      NPC_SAY("那你去击退黑色丘陵的{0xFFFFFF00}[白色阿佩普]{END}，收集{0xFFFFFF00}50个白色阿佩普的毒牙{END}回来吧。抓的时候千万要小心，可别被咬伤了。")
    end
  end
  if qData[2598].state == 1 then
    if CHECK_ITEM_CNT(qt[2598].goal.getItem[1].id) >= qt[2598].goal.getItem[1].count then
      NPC_SAY("谢谢。这是我的心意，请收下吧~")
      SET_QUEST_STATE(2598, 2)
      return
    else
      NPC_SAY("击退黑色丘陵的{0xFFFFFF00}[深渊的阿拉克涅]{END}，收集{0xFFFFFF00}50个深渊的阿拉克涅心脏{END}回来就可以了。那个怪物可不简单，你要当心啊！")
    end
  end
  if qData[3647].state == 1 then
    if CHECK_ITEM_CNT(qt[3647].goal.getItem[1].id) >= qt[3647].goal.getItem[1].count then
      NPC_SAY("那~开始熬国王陛下的药吧~咦？还没走吗？快走吧！")
      SET_QUEST_STATE(3647, 2)
      return
    else
      NPC_SAY("击退小火龙，收集50个小火龙翅膀回来吧")
    end
  end
  if qData[2862].state == 1 then
    NPC_SAY("有什么事啊？有事就说，没事就出去！")
    SET_QUEST_STATE(2862, 2)
    return
  end
  if qData[2863].state == 1 then
    if CHECK_ITEM_CNT(qt[2863].goal.getItem[1].id) >= qt[2863].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("{0xFFFFCCCC}(医生八字胡老头把椰枣捣碎后跟其他药材混合制作了解酒剂。){END}那，这是答应你的解酒剂。")
        SET_QUEST_STATE(2863, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去{0xFFFFFF00}吕墩平原{END}击退{0xFFFFFF00}甲山女鬼{END}，收集{0xFFFFFF00}30个{END}{0xFFFFFF00}椰枣{END}回来吧。")
    end
  end
  if qData[2869].state == 1 then
    if CHECK_ITEM_CNT(qt[2869].goal.getItem[1].id) >= qt[2869].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2869].goal.getItem[2].id) >= qt[2869].goal.getItem[2].count then
      NPC_SAY("{0xFFFFCCCC}(医生八字胡老头将仙人掌碎片和仙人掌花捣碎后，和其他药材混合制作了治疗剂。){END}那，这是答应你的治疗剂。赶紧去看看亚夫吧。")
      SET_QUEST_STATE(2869, 2)
      return
    else
      NPC_SAY("记住，是{0xFFFFFF00}仙人掌碎片{END}和{0xFFFFFF00}仙人掌花{END}各收集15个才能制作治疗剂。")
    end
  end
  if qData[2870].state == 1 then
    NPC_SAY("又有什么事啊？")
    SET_QUEST_STATE(2870, 2)
    return
  end
  if qData[2871].state == 1 then
    if CHECK_ITEM_CNT(qt[2871].goal.getItem[1].id) >= qt[2871].goal.getItem[1].count then
      NPC_SAY("知道下一步该做什么了吧？")
      SET_QUEST_STATE(2871, 2)
      return
    else
      NPC_SAY("世上哪有免费的啊。击退{0xFFFFFF00}吕墩平原{END}的{0xFFFFFF00}狂豚魔人{END}收集30个{0xFFFFFF00}仙人掌碎片{END}回来吧。")
    end
  end
  if qData[2872].state == 1 then
    if CHECK_ITEM_CNT(qt[2872].goal.getItem[1].id) >= qt[2872].goal.getItem[1].count then
      NPC_SAY("不错啊。比我想的快多了。")
      SET_QUEST_STATE(2872, 2)
      return
    else
      NPC_SAY("世上哪有免费的啊。击退{0xFFFFFF00}吕墩平原{END}的{0xFFFFFF00}咸兴魔灵{END}收集30个{0xFFFFFF00}仙人掌花{END}回来吧。")
    end
  end
  if qData[2873].state == 1 then
    if CHECK_ITEM_CNT(qt[2873].goal.getItem[1].id) >= qt[2873].goal.getItem[1].count then
      NPC_SAY("太感谢了。一次都没有发火，一直尽心尽力的帮我..")
      SET_QUEST_STATE(2873, 2)
      return
    else
      NPC_SAY("世上哪有免费的啊。击退{0xFFFFFF00}吕墩平原{END}的{0xFFFFFF00}甲山女鬼{END}收集50个{0xFFFFFF00}被丢弃的绷带{END}回来吧。")
    end
  end
  if qData[2874].state == 1 then
    NPC_SAY("怎么样？对你有帮助吗？")
    SET_QUEST_STATE(2874, 2)
    return
  end
  if qData[2877].state == 1 then
    if CHECK_ITEM_CNT(qt[2877].goal.getItem[1].id) >= qt[2877].goal.getItem[1].count then
      NPC_SAY("这么快就回来了？确实很有实力啊。")
      SET_QUEST_STATE(2877, 2)
      return
    else
      NPC_SAY("你还磨蹭什么啊？击退{0xFFFFFF00}吕墩平原{END}的{0xFFFFFF00}狂豚魔人{END}，收集15个{0xFFFFFF00}狂豚魔人的指甲{END}回来吧。")
    end
  end
  if qData[2878].state == 1 then
    if CHECK_ITEM_CNT(qt[2878].goal.getItem[1].id) >= qt[2878].goal.getItem[1].count then
      NPC_SAY("回来了？来来，快点给我，我比较着急。")
      SET_QUEST_STATE(2878, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}吕墩平原{END}的{0xFFFFFF00}咸兴魔灵{END}，拿来30个{0xFFFFFF00}仙人掌花{END}吧。")
    end
  end
  if qData[2879].state == 1 then
    NPC_SAY("你磨蹭什么呢？快点出发吧。")
    SET_QUEST_STATE(2879, 2)
    return
  end
  if qData[2881].state == 1 then
    if CHECK_ITEM_CNT(qt[2881].goal.getItem[1].id) >= qt[2881].goal.getItem[1].count then
      NPC_SAY("都第二次了，快点吧。")
      SET_QUEST_STATE(2881, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}吕墩平原{END}的{0xFFFFFF00}咸兴魔灵{END}，拿来30个{0xFFFFFF00}仙人掌花{END}吧。")
    end
  end
  if qData[2882].state == 1 then
    NPC_SAY("干什么呢？还不去？{0xFFFFFF00}近卫兵可心{END}应该在{0xFFFFFF00}安哥拉王宫{END}。")
  end
  ADD_NEW_SHOP_BTN(id, 10061)
  GIVE_DONATION_BUFF(id)
  if qData[1479].state == 0 and qData[1477].state == 1 then
    ADD_QUEST_BTN(qt[1479].id, qt[1479].name)
  end
  if qData[2184].state == 0 then
    ADD_QUEST_BTN(qt[2184].id, qt[2184].name)
  end
  if qData[2588].state == 0 and GET_PLAYER_LEVEL() >= qt[2588].needLevel then
    ADD_QUEST_BTN(qt[2588].id, qt[2588].name)
  end
  if qData[2590].state == 0 and GET_PLAYER_LEVEL() >= qt[2590].needLevel then
    ADD_QUEST_BTN(qt[2590].id, qt[2590].name)
  end
  if qData[2598].state == 0 and qData[2590].state == 2 and GET_PLAYER_LEVEL() >= qt[2598].needLevel then
    ADD_QUEST_BTN(qt[2598].id, qt[2598].name)
  end
  if qData[3647].state == 0 and qData[2184].state == 2 then
    ADD_QUEST_BTN(qt[3647].id, qt[3647].name)
  end
  if qData[2863].state == 0 and qData[2862].state == 2 and GET_PLAYER_LEVEL() >= qt[2863].needLevel then
    ADD_QUEST_BTN(qt[2863].id, qt[2863].name)
  end
  if qData[2869].state == 0 and qData[2868].state == 2 and GET_PLAYER_LEVEL() >= qt[2869].needLevel then
    ADD_QUEST_BTN(qt[2869].id, qt[2869].name)
  end
  if qData[2871].state == 0 and qData[2870].state == 2 and GET_PLAYER_LEVEL() >= qt[2871].needLevel then
    ADD_QUEST_BTN(qt[2871].id, qt[2871].name)
  end
  if qData[2872].state == 0 and qData[2871].state == 2 and GET_PLAYER_LEVEL() >= qt[2872].needLevel then
    ADD_QUEST_BTN(qt[2872].id, qt[2872].name)
  end
  if qData[2873].state == 0 and qData[2872].state == 2 and GET_PLAYER_LEVEL() >= qt[2873].needLevel then
    ADD_QUEST_BTN(qt[2873].id, qt[2873].name)
  end
  if qData[2874].state == 0 and qData[2873].state == 2 and GET_PLAYER_LEVEL() >= qt[2874].needLevel then
    ADD_QUEST_BTN(qt[2874].id, qt[2874].name)
  end
  if qData[2877].state == 0 and qData[2874].state == 2 and GET_PLAYER_LEVEL() >= qt[2877].needLevel then
    ADD_QUEST_BTN(qt[2877].id, qt[2877].name)
  end
  if qData[2878].state == 0 and qData[2877].state == 2 and GET_PLAYER_LEVEL() >= qt[2878].needLevel then
    ADD_QUEST_BTN(qt[2878].id, qt[2878].name)
  end
  if qData[2879].state == 0 and qData[2878].state == 2 and GET_PLAYER_LEVEL() >= qt[2879].needLevel then
    ADD_QUEST_BTN(qt[2879].id, qt[2879].name)
  end
  if qData[2881].state == 0 and qData[2880].state == 2 and GET_PLAYER_LEVEL() >= qt[2881].needLevel then
    ADD_QUEST_BTN(qt[2881].id, qt[2881].name)
  end
  if qData[2882].state == 0 and qData[2881].state == 2 and GET_PLAYER_LEVEL() >= qt[2882].needLevel then
    ADD_QUEST_BTN(qt[2882].id, qt[2882].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1479].state ~= 2 and qData[1477].state == 1 then
    if qData[1479].state == 1 then
      if CHECK_ITEM_CNT(qt[1479].goal.getItem[1].id) >= qt[1479].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2184].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2184].needLevel then
    if qData[2184].state == 1 then
      if CHECK_ITEM_CNT(qt[2184].goal.getItem[1].id) >= qt[2184].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2588].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2588].needLevel then
    if qData[2588].state == 1 then
      if CHECK_ITEM_CNT(qt[2588].goal.getItem[1].id) >= qt[2588].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2590].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2590].needLevel then
    if qData[2590].state == 1 then
      if CHECK_ITEM_CNT(qt[2590].goal.getItem[1].id) >= qt[2590].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2598].state ~= 2 and qData[2590].state == 2 and GET_PLAYER_LEVEL() >= qt[2598].needLevel then
    if qData[2598].state == 1 then
      if CHECK_ITEM_CNT(qt[2598].goal.getItem[1].id) >= qt[2598].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3647].state ~= 2 and qData[2184].state == 2 and GET_PLAYER_LEVEL() >= qt[3647].needLevel then
    if qData[3647].state == 1 then
      if CHECK_ITEM_CNT(qt[3647].goal.getItem[1].id) >= qt[3647].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2862].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2863].state ~= 2 and qData[2862].state == 2 and GET_PLAYER_LEVEL() >= qt[2863].needLevel then
    if qData[2863].state == 1 then
      if CHECK_ITEM_CNT(qt[2863].goal.getItem[1].id) >= qt[2863].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2869].state ~= 2 and qData[2868].state == 2 and GET_PLAYER_LEVEL() >= qt[2869].needLevel then
    if qData[2869].state == 1 then
      if CHECK_ITEM_CNT(qt[2869].goal.getItem[1].id) >= qt[2869].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2869].goal.getItem[2].id) >= qt[2869].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2870].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2871].state ~= 2 and qData[2870].state == 2 and GET_PLAYER_LEVEL() >= qt[2871].needLevel then
    if qData[2871].state == 1 then
      if CHECK_ITEM_CNT(qt[2871].goal.getItem[1].id) >= qt[2871].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2872].state ~= 2 and qData[2871].state == 2 and GET_PLAYER_LEVEL() >= qt[2872].needLevel then
    if qData[2872].state == 1 then
      if CHECK_ITEM_CNT(qt[2872].goal.getItem[1].id) >= qt[2872].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2873].state ~= 2 and qData[2872].state == 2 and GET_PLAYER_LEVEL() >= qt[2873].needLevel then
    if qData[2873].state == 1 then
      if CHECK_ITEM_CNT(qt[2873].goal.getItem[1].id) >= qt[2873].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2874].state ~= 2 and qData[2873].state == 2 and GET_PLAYER_LEVEL() >= qt[2874].needLevel then
    if qData[2874].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2877].state ~= 2 and qData[2874].state == 2 and GET_PLAYER_LEVEL() >= qt[2877].needLevel then
    if qData[2877].state == 1 then
      if CHECK_ITEM_CNT(qt[2877].goal.getItem[1].id) >= qt[2877].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2878].state ~= 2 and qData[2877].state == 2 and GET_PLAYER_LEVEL() >= qt[2878].needLevel then
    if qData[2878].state == 1 then
      if CHECK_ITEM_CNT(qt[2878].goal.getItem[1].id) >= qt[2878].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2879].state ~= 2 and qData[2878].state == 2 and GET_PLAYER_LEVEL() >= qt[2879].needLevel then
    if qData[2879].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2881].state ~= 2 and qData[2880].state == 2 and GET_PLAYER_LEVEL() >= qt[2881].needLevel then
    if qData[2881].state == 1 then
      if CHECK_ITEM_CNT(qt[2881].goal.getItem[1].id) >= qt[2881].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2882].state ~= 2 and qData[2881].state == 2 and GET_PLAYER_LEVEL() >= qt[2882].needLevel then
    if qData[2882].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
