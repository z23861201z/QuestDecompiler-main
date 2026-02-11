function npcsay(id)
  if id ~= 4220001 then
    return
  end
  clickNPCid = id
  i = math.random(0, 1)
  if i == 0 then
    NPC_SAY("我是… 什么… 我是… 人… 妖怪… ")
  else
    NPC_SAY("时间… 过了…又过…")
  end
  ADD_SHOP_BTN(id)
  if qData[1012].state == 1 then
    NPC_SAY("什么事情啊？这 完了..")
    SET_QUEST_STATE(1012, 2)
    return
  end
  if qData[1013].state == 1 then
    if CHECK_ITEM_CNT(qt[1013].goal.getItem[1].id) >= qt[1013].goal.getItem[1].count then
      NPC_SAY("非常感谢")
      SET_QUEST_STATE(1013, 2)
      return
    else
      NPC_SAY("50个圆形骨块，就拜托你了")
    end
  end
  if qData[1014].state == 1 then
    if CHECK_ITEM_CNT(qt[1014].goal.getItem[1].id) >= qt[1014].goal.getItem[1].count then
      NPC_SAY("谢谢。终于可以做项链装饰了")
      SET_QUEST_STATE(1014, 2)
      return
    else
      NPC_SAY("食人鱼的眼珠还不够100个么？")
    end
  end
  if qData[1015].state == 1 then
    if qData[1015].killMonster[qt[1015].goal.killMonster[1].id] >= qt[1015].goal.killMonster[1].count then
      NPC_SAY("多亏你，我心情好多了。请收下我的礼物")
      SET_QUEST_STATE(1015, 2)
      return
    else
      NPC_SAY("还没击退50只邪蜂怪么？")
    end
  end
  if qData[2461].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("唱绰 公均牢啊...")
      SET_QUEST_STATE(2461, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2463].state == 1 then
    if qData[2463].killMonster[qt[2463].goal.killMonster[1].id] >= qt[2463].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("绊缚.. 促. 捞 篮驱绰 镭瘤 臼摆促.")
        SET_QUEST_STATE(2463, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}归蓖林盔{END}俊 啊搁 {0xFFFFFF00}荤豪蓖 {END}啊 乐促. 仇甸阑 150付府父 硼摹秦.. 促坷.")
    end
  end
  if qData[2469].state == 1 then
    if CHECK_ITEM_CNT(qt[2469].goal.getItem[1].id) >= qt[2469].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("绊缚.. 促. 捞 篮驱绰 镭瘤 臼摆促. 郴啊 亮篮 巴.. 舅妨霖促..")
        SET_QUEST_STATE(2469, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}厚锰{END}.. 仇甸篮 {0xFFFFFF00}{END}俊辑 免隔窍瘤.. {0xFFFFFF00}大扁赣府{END}绰.. 100俺搁.. 面盒窍促..")
    end
  end
  if qData[2470].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("何叼.. 盔窍绰 巴阑.. 捞风辨 官鄂促.. 绊付奎促..")
      SET_QUEST_STATE(2470, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2569].state == 1 then
    if qData[2569].killMonster[qt[2569].goal.killMonster[1].id] >= qt[2569].goal.killMonster[1].count then
      NPC_SAY("谢..谢..")
      SET_QUEST_STATE(2569, 2)
      return
    else
      NPC_SAY("那些怪在..{0xFFFFFF00}[黑鬼血路[6]]{END}..去击退200个{0xFFFFFF00}邪龙{END}吧")
    end
  end
  if qData[2570].state == 1 then
    if qData[2570].killMonster[qt[2570].goal.killMonster[1].id] >= qt[2570].goal.killMonster[1].count then
      NPC_SAY("你..很厉害..好..羡慕..还有..谢..谢..")
      SET_QUEST_STATE(2570, 2)
      return
    else
      NPC_SAY("去..{0xFFFFFF00}[隐藏的黑鬼血路[2]]{END}..击退..{0xFFFFFF00}鼠偷盗{END}..吧")
    end
  end
  if qData[3676].state == 1 then
    if qData[3676].killMonster[qt[3676].goal.killMonster[1].id] >= qt[3676].goal.killMonster[1].count then
      NPC_SAY("谢谢..")
      SET_QUEST_STATE(3676, 2)
      return
    else
      NPC_SAY("帮我击退..{0xFFFFFF00}50个黑鬼觜源..的复头龟{END}吧")
    end
  end
  if qData[3677].state == 1 then
    if qData[3677].killMonster[qt[3677].goal.killMonster[1].id] >= qt[3677].goal.killMonster[1].count then
      NPC_SAY("谢谢..")
      SET_QUEST_STATE(3677, 2)
      return
    else
      NPC_SAY("帮我击退..{0xFFFFFF00}50个黑鬼觜源..的污染怪{END}吧")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10039)
  if qData[1013].state == 0 then
    ADD_QUEST_BTN(qt[1013].id, qt[1013].name)
  end
  if qData[1014].state == 0 and qData[1013].state == 2 then
    ADD_QUEST_BTN(qt[1014].id, qt[1014].name)
  end
  if qData[1015].state == 0 then
    ADD_QUEST_BTN(qt[1015].id, qt[1015].name)
  end
  if qData[2569].state == 0 and qData[2568].state == 2 and GET_PLAYER_LEVEL() >= qt[2569].needLevel then
    ADD_QUEST_BTN(qt[2569].id, qt[2569].name)
  end
  if qData[2570].state == 0 and qData[2569].state == 2 and GET_PLAYER_LEVEL() >= qt[2570].needLevel then
    ADD_QUEST_BTN(qt[2570].id, qt[2570].name)
  end
  if qData[3676].state == 0 and GET_PLAYER_LEVEL() >= qt[3676].needLevel then
    ADD_QUEST_BTN(qt[3676].id, qt[3676].name)
  end
  if qData[3677].state == 0 and GET_PLAYER_LEVEL() >= qt[3677].needLevel then
    ADD_QUEST_BTN(qt[3677].id, qt[3677].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1012].state == 1 and GET_PLAYER_LEVEL() >= qt[1012].needLevel then
    QSTATE(id, 1)
  end
  if qData[1013].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1013].needLevel then
    if qData[1013].state == 1 then
      if CHECK_ITEM_CNT(qt[1013].goal.getItem[1].id) >= qt[1013].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1014].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1014].needLevel and qData[1013].state == 2 then
    if qData[1014].state == 1 then
      if CHECK_ITEM_CNT(qt[1014].goal.getItem[1].id) >= qt[1014].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1015].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1015].needLevel then
    if qData[1015].state == 1 then
      if qData[1015].killMonster[qt[1015].goal.killMonster[1].id] >= qt[1015].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2569].state ~= 2 and qData[2568].state == 2 and GET_PLAYER_LEVEL() >= qt[2569].needLevel then
    if qData[2569].state == 1 then
      if qData[2569].killMonster[qt[2569].goal.killMonster[1].id] >= qt[2569].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2570].state ~= 2 and qData[2569].state == 2 and GET_PLAYER_LEVEL() >= qt[2570].needLevel then
    if qData[2570].state == 1 then
      if qData[2570].killMonster[qt[2570].goal.killMonster[1].id] >= qt[2570].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3676].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3676].needLevel then
    if qData[3676].state == 1 then
      if qData[3676].killMonster[qt[3676].goal.killMonster[1].id] >= qt[3676].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3677].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3677].needLevel then
    if qData[3677].state == 1 then
      if qData[3677].killMonster[qt[3677].goal.killMonster[1].id] >= qt[3677].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
