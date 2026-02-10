function npcsay(id)
  if id ~= 4214001 then
    return
  end
  clickNPCid = id
  if qData[1112].state == 1 then
    if GET_PLAYER_JOB1() > 0 then
      NPC_SAY("你就是艾里村长老说的失去记忆的{0xFF99ff99}PLAYERNAME{END}啊。来的路上辛苦了。稍作休息之后，准备好了就跟我说吧。")
      SET_QUEST_STATE(1112, 2)
    else
      NPC_SAY("在{0xFFFFFF00}[ 选择树林 ]{END}里转职后再来比较好。内功未整理，无法了解内力。")
    end
  end
  if qData[1113].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1113].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。请先到这边来。怎么样？想起来了吗？")
        SET_QUEST_STATE(1113, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退清阴谷的{0xFFFFFF00}蝎角亭{END}，收集{0xFFFFFF00}3个蝎角亭的尾巴{END}给我的话，我将给你施针的。")
    end
  end
  if qData[1114].state == 1 then
    NPC_SAY("希望你能将推荐书交给清阴谷的武功研究NPC。")
  end
  if qData[1115].state == 1 and qData[1115].meetNpc[1] == qt[1115].goal.meetNpc[1] and qData[1115].meetNpc[2] == qt[1115].goal.meetNpc[2] and qData[1115].meetNpc[3] ~= id and 0 < CHECK_ITEM_CNT(8990012) then
    NPC_SAY("啊！是简讯。谢谢。")
    SET_MEETNPC(1115, 3, id)
  end
  if qData[1341].state == 1 and CHECK_ITEM_CNT(qt[1341].goal.getItem[1].id) >= qt[1341].goal.getItem[1].count then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("我一直在等你。这里有两种，挑一个你需要的拿走吧。")
      SET_QUEST_STATE(1341, 2)
      return
    else
      NPC_SAY("行囊太沉。")
      return
    end
  end
  ADD_NEW_SHOP_BTN(id, 10001)
  GIVE_DONATION_BUFF(id)
  if qData[1113].state == 0 then
    ADD_QUEST_BTN(qt[1113].id, qt[1113].name)
  end
  if qData[1114].state == 0 and qData[1113].state == 2 then
    ADD_QUEST_BTN(qt[1114].id, qt[1114].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1111].state == 2 and qData[1112].state == 1 then
    if GET_PLAYER_JOB1() > 0 then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1113].state ~= 2 then
    if qData[1113].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1113].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1114].state ~= 2 and qData[1113].state == 2 then
    if qData[1114].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1115].state ~= 2 and qData[1115].state == 1 and qData[1115].meetNpc[1] == qt[1115].goal.meetNpc[1] and qData[1115].meetNpc[2] == qt[1115].goal.meetNpc[2] and qData[1115].meetNpc[3] ~= id then
    QSTATE(id, 1)
  end
  if qData[1341].state == 1 then
    if CHECK_ITEM_CNT(qt[1341].goal.getItem[1].id) >= qt[1341].goal.getItem[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
end
