function npcsay(id)
  if id ~= 4322007 then
    return
  end
  clickNPCid = id
  if qData[1052].state == 1 then
    if qData[1052].killMonster[qt[1052].goal.killMonster[1].id] >= qt[1052].goal.killMonster[1].count then
      NPC_SAY("很好，那就一起努力，将怪物彻底击退吧！")
      SET_QUEST_STATE(1052, 2)
      return
    else
      NPC_SAY("还没收集到{0xFFFFFF00}100个食人花{END}吗？原来的自信都跑哪儿去了？")
    end
  end
  if qData[1062].state == 1 then
    if qData[1062].killMonster[qt[1062].goal.killMonster[1].id] >= qt[1062].goal.killMonster[1].count then
      NPC_SAY("很好，那就一起努力，将怪物彻底击退吧！")
      SET_QUEST_STATE(1062, 2)
      return
    else
      NPC_SAY("还没收集到{0xFFFFFF00}100个彩色虫{END}吗？原来的自信心都跑哪儿去了？")
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
