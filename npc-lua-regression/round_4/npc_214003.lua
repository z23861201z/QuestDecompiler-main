function npcsay(id)
  if id ~= 4214003 then
    return
  end
  clickNPCid = id
  if qData[1115].state == 1 and qData[1115].meetNpc[1] == qt[1115].goal.meetNpc[1] and qData[1115].meetNpc[2] == qt[1115].goal.meetNpc[2] and qData[1115].meetNpc[3] == qt[1115].goal.meetNpc[3] and qData[1115].meetNpc[4] ~= id and CHECK_ITEM_CNT(8990012) > 0 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("怎么？派报员去哪儿了，怎么是少侠啊？这，这…不用再去了，正好我要去找派报员的，不用再去。你好像学了武功，我们谈谈吧。")
      SET_MEETNPC(1115, 4, id)
      SET_QUEST_STATE(1115, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1117].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1117].goal.getItem) then
      NPC_SAY("谢谢。会制作出华丽的衣服的。人们也会振作点吧。")
      SET_QUEST_STATE(1117, 2)
    else
      NPC_SAY("我在制作衣服呢。你也快点行动吧。{0xFFFFFF00}击退清阴谷的毛毛，收集5个[ 药草 ]回来吧。{END}")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10003)
  if qData[1115].state == 2 and qData[1117].state == 0 then
    ADD_QUEST_BTN(qt[1117].id, qt[1117].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1115].state == 1 then
    if qData[1115].meetNpc[1] == qt[1115].goal.meetNpc[1] and qData[1115].meetNpc[2] == qt[1115].goal.meetNpc[2] and qData[1115].meetNpc[3] == qt[1115].goal.meetNpc[3] and qData[1115].meetNpc[4] ~= qt[1115].goal.meetNpc[4] then
      QSTATE(id, 2)
    else
      QSTATE(id, -1)
    end
  end
  if qData[1115].state == 2 and qData[1117].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1117].needLevel then
    if qData[1117].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1117].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
