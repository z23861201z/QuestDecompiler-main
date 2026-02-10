function npcsay(id)
  if id ~= 4217001 then
    return
  end
  clickNPCid = id
  NPC_SAY("欢迎光临。全都是我亲手做的药啊。大可安心服用。哦对了!如果受了内伤一定要治疗一下。")
  if qData[1159].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1159].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("嗯~比我想的要快很多啊。谢谢。")
        SET_QUEST_STATE(1159, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("嗯~需要10个[ 红色胶皮鞋 ]。吸血鬼在强悍巷道里。")
    end
  end
  if qData[1162].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1162].goal.getItem) then
      NPC_SAY("嗯~辛苦了。有了这些少年会提起精神的。")
      SET_QUEST_STATE(1162, 2)
    else
      NPC_SAY("嗯~要制成补药，需要10个[ 鼠须 ]。去强悍巷道击退土拨鼠收集10个[ 鼠须 ]拿来给我吧。")
    end
  end
  if qData[1159].state == 0 then
    ADD_QUEST_BTN(qt[1159].id, qt[1159].name)
  end
  if qData[1162].state == 0 then
    ADD_QUEST_BTN(qt[1162].id, qt[1162].name)
  end
  ADD_NEW_SHOP_BTN(id, 10030)
  GIVE_DONATION_BUFF(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1159].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1159].needLevel then
    if qData[1159].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1159].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1162].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1162].needLevel then
    if qData[1162].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1162].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
