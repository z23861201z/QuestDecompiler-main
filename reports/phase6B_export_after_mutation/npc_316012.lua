function npcsay(id)
  if id ~= 4316012 then
    return
  end
  clickNPCid = id
  if qData[494].state == 1 then
    if qData[494].meetNpc[1] ~= id then
      NPC_QSAY(494, 1)
      SET_MEETNPC(494, 1, id)
      return
    elseif qData[494].meetNpc[1] == qt[494].goal.meetNpc[1] and qData[494].meetNpc[2] ~= id then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("把这个种子交给太乙仙女吧。想回到太乙仙女处，就随时和我对话吧。我可以把你送到太乙仙女那儿的")
        SET_MEETNPC(494, 2, id)
        SET_QUEST_STATE(494, 2)
        return
      else
        NPC_SAY("行囊太沉。")
        return
      end
    else
      NPC_SAY("想回到太乙仙女处，就随时和我对话吧。我可以把你送到太乙仙女那儿的")
      WarpTaeULMove(id)
      return
    end
  end
  if qData[3631].state == 1 and qData[3631].killMonster[qt[3631].goal.killMonster[1].id] >= qt[3631].goal.killMonster[1].count then
    if 1 <= CHECK_INVENTORY_CNT(4) then
      NPC_SAY("辛苦了~对了！这是我获得的千手妖女的结晶，现在送给你。希望对你有帮助.")
      SET_QUEST_STATE(3631, 2)
    else
      NPC_SAY("行囊太沉")
      return
    end
  end
  NPC_SAY("准备好回到太乙仙女处了吗？")
  WarpTaeULMove(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[494].state == 1 and GET_PLAYER_LEVEL() >= qt[494].needLevel then
    if qData[494].meetNpc[1] == qt[494].goal.meetNpc[1] and qData[494].meetNpc[2] ~= id then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
  if qData[3631].state == 1 and GET_PLAYER_LEVEL() >= qt[3631].needLevel then
    if qData[3631].killMonster[qt[3631].goal.killMonster[1].id] >= qt[3631].goal.killMonster[1].count then
      QSTATE(id, 2)
    else
      QSTATE(id, 1)
    end
  end
end
