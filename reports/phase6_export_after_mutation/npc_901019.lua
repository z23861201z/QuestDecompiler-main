function npcsay(id)
  if id ~= 4901019 then
    return
  end
  clickNPCid = id
  if qData[1091].state == 1 then
    if qData[1091].meetNpc[1] == qt[1091].goal.meetNpc[1] and qData[1091].meetNpc[2] ~= id then
      if CHECK_ITEM_CNT(8980109) > 0 then
        SET_INFO(1091, 2)
        NPC_QSAY(1091, 3)
        SET_MEETNPC(1091, 2, id)
        return
      end
    elseif qData[1091].meetNpc[2] == qt[1091].goal.meetNpc[2] then
      NPC_SAY("看看这个，漂亮吧？多拉B梦尾巴做成的围巾果然是最好的，这算是给你的辛苦费，请笑纳")
    end
  end
  if qData[1580].state == 1 then
    if qData[1580].meetNpc[1] == qt[1580].goal.meetNpc[1] and qData[1580].meetNpc[2] ~= id then
      if CHECK_ITEM_CNT(8980109) > 0 then
        SET_INFO(1580, 2)
        NPC_QSAY(1580, 3)
        SET_MEETNPC(1580, 2, id)
        return
      end
    elseif qData[1580].meetNpc[2] == qt[1580].goal.meetNpc[2] then
      NPC_SAY("快让我瞧瞧礼物里有什么呢，好开心！ ")
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1580].state == 1 then
    QSTATE(id, 1)
  end
end
