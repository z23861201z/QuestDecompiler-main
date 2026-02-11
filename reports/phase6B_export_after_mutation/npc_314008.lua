function npcsay(id)
  if id ~= 4314008 then
    return
  end
  clickNPCid = id
  if qData[1115].state == 1 and (qData[1115].meetNpc[1] ~= qt[1115].goal.meetNpc[1] or qData[1115].meetNpc[2] ~= qt[1115].goal.meetNpc[2] or qData[1115].meetNpc[3] ~= qt[1115].goal.meetNpc[3] or qData[1115].meetNpc[4] ~= qt[1115].goal.meetNpc[4]) then
    NPC_SAY("还没有把简讯转达完吗？按哞读册，金系系武器店，宝芝林，害了了防具店的顺序传就可以了。")
  end
  if qData[1137].state == 1 and (qData[1137].meetNpc[1] ~= qt[1137].goal.meetNpc[1] or qData[1137].meetNpc[2] ~= qt[1137].goal.meetNpc[2] or qData[1137].meetNpc[3] ~= qt[1137].goal.meetNpc[3] or qData[1137].meetNpc[4] ~= qt[1137].goal.meetNpc[4]) then
    NPC_SAY("请把简讯按清江村祈祷的婆婆，雕刻师，疲惫的矿工，收获的农夫的顺序传给他们吧。通过清野江导游可以去清江村。")
  end
  if qData[1142].state == 1 then
    if CHECK_ITEM_CNT(qt[1142].goal.getItem[1].id) >= qt[1142].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("这么快就拿过来了啊。拿着吧，这是饰品。啊，看着跟幸运无关？奇怪啊，我戴着时能给我带来好运的啊。")
        SET_QUEST_STATE(1142, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退北清阴平原的姜丝男收集10个[ 姜丝男的牙齿 ]回来就给你制作幸运饰品。")
    end
  end
  if qData[1115].state == 0 and qData[1114].state == 2 then
    ADD_QUEST_BTN(qt[1115].id, qt[1115].name)
  end
  if qData[1137].state == 0 then
    ADD_QUEST_BTN(qt[1137].id, qt[1137].name)
  end
  if qData[1142].state == 0 then
    ADD_QUEST_BTN(qt[1142].id, qt[1142].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1115].state ~= 2 and qData[1114].state == 2 and GET_PLAYER_LEVEL() >= qt[1115].needLevel then
    if qData[1115].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1137].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1137].needLevel then
    if qData[1137].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1142].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1142].needLevel then
    if qData[1142].state == 1 then
      if CHECK_ITEM_CNT(qt[1142].goal.getItem[1].id) >= qt[1142].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
