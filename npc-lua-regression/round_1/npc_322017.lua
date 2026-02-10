function npcsay(id)
  if id ~= 4322017 then
    return
  end
  clickNPCid = id
  if qData[2709].state == 2 then
    NPC_SAY("我是跟刘备结拜的三弟张飞，辛苦你了。")
  else
    NPC_SAY("只要是兄长们想走的路，我会追随到底。")
  end
  if qData[2787].state == 1 and qData[2787].killMonster[qt[2787].goal.killMonster[1].id] >= qt[2787].goal.killMonster[1].count then
    NPC_SAY("这个，这个！怎么回事啊？什么啊？这脏兮兮的东西是？{0xFFFFCCCC}(龙林派张飞一边拿走石板一边问。){END}")
    SET_QUEST_STATE(2787, 2)
    return
  end
  if qData[2788].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2788].goal.getItem) then
      NPC_SAY("来，把酒这样倒下去...咦？怎么不行啊！{0xFFFFCCCC}(在一旁看着这一切的龙林派关羽脸色越来越难看。去找龙林派关羽吧。){END}")
      SET_QUEST_STATE(2788, 2)
    else
      NPC_SAY("去{0xFFFFFF00}干涸的沼泽{END}击退{0xFFFFFF00}破戒僧{END}，收集40个{0xFFFFFF00}破戒僧的酒{END}回来我就帮你解决。")
    end
  end
  if qData[2861].state == 1 then
    if CHECK_ITEM_CNT(qt[2861].goal.getItem[1].id) >= qt[2861].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("真的收集回来了啊。按照约定给你{0xFFFFFF00}张家烈酒{END}。")
        SET_QUEST_STATE(2861, 2)
        return
      else
        NPC_SAY("行囊太沉！")
      end
    else
      NPC_SAY("如果把{0xFFFFFF00}曲怪人的手指甲END}拿给刘备和关羽两位兄长的话，他们也会对我刮目相看的。")
    end
  end
  if qData[2788].state == 0 and qData[2787].state == 2 and GET_PLAYER_LEVEL() >= qt[2788].needLevel then
    ADD_QUEST_BTN(qt[2788].id, qt[2788].name)
  end
  if qData[2861].state == 0 and qData[2860].state == 1 and GET_PLAYER_LEVEL() >= qt[2861].needLevel then
    ADD_QUEST_BTN(qt[2861].id, qt[2861].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2787].state == 1 and qData[2787].killMonster[qt[2787].goal.killMonster[1].id] >= qt[2787].goal.killMonster[1].count then
    QSTATE(id, 2)
  end
  if qData[2788].state ~= 2 and qData[2787].state == 2 and GET_PLAYER_LEVEL() >= qt[2788].needLevel then
    if qData[2788].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2788].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2861].state ~= 2 and qData[2860].state == 1 and GET_PLAYER_LEVEL() >= qt[2861].needLevel then
    if qData[2861].state == 1 then
      if CHECK_ITEM_CNT(qt[2861].goal.getItem[1].id) >= qt[2861].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
