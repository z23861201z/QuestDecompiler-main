function npcsay(id)
  if id ~= 4200004 then
    return
  end
  clickNPCid = id
  if qData[1578].state == 1 then
    if qData[1578].killMonster[qt[1578].goal.killMonster[1].id] >= qt[1578].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("是冰斗让你来的？那妖物没搞错吧？！我很喜欢这里，这里能将我的能力提升至极限。再说这里是我力量的领域，别想制服我！")
        SET_QUEST_STATE(1578, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("（看来这老婆婆现在还不想搭理我。就按异世小贩冰斗说的那样，先去击退梦幻的龙凤鸣后再回来吧）")
    end
  end
  if qData[1579].state == 1 and qData[1579].meetNpc[1] ~= qt[1579].goal.meetNpc[1] then
    NPC_SAY("你做好从梦境醒来的准备了吗？走好~")
  end
  if qData[895].state == 1 then
    if qData[895].killMonster[qt[895].goal.killMonster[1].id] >= qt[895].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("又来了啊~哈哈！收下碎片吧。最近提取工作不顺利，梦幻的碎片变得奇缺了。不过你击退了梦幻的龙凤鸣，还是要给等价奖励的。今天这些就够了，明天再来帮我吧，年轻人~嘻嘻嘻")
        SET_QUEST_STATE(895, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("快去击退梦幻的龙凤鸣后回来吧。去的方法问异界门的承宪道僧就可以了")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10072)
  ADD_NPC_WARP_INDUN_EXIT(id)
  if qData[1579].state == 0 and qData[1578].state == 2 and GET_PLAYER_LEVEL() >= qt[1579].needLevel then
    ADD_QUEST_BTN(qt[1579].id, qt[1579].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1578].state == 1 then
    if qData[1578].killMonster[qt[1578].goal.killMonster[1].id] >= qt[1578].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1579].state ~= 2 and qData[1578].state == 2 and GET_PLAYER_LEVEL() >= qt[1579].needLevel then
    if qData[1579].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1579].state == 2 and qData[895].state == 1 then
    if qData[895].killMonster[qt[895].goal.killMonster[1].id] >= qt[895].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
end
