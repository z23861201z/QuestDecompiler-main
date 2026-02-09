function npcsay(id)
  if id ~= 4322008 then
    return
  end
  clickNPCid = id
  if qData[1053].state == 1 then
    if qData[1053].killMonster[qt[1053].goal.killMonster[1].id] >= qt[1053].goal.killMonster[1].count then
      NPC_SAY("HOHO~了不起，了不起的实力啊！如果持续击退怪物的话，怪物就无处生存了")
      SET_QUEST_STATE(1053, 2)
      return
    else
      NPC_SAY("什么啊，就这程度？{0xFFFFFF00}100个百足神怪{END}啊，实力很一般啊！")
    end
  end
  if qData[1063].state == 1 then
    if qData[1063].killMonster[qt[1063].goal.killMonster[1].id] >= qt[1063].goal.killMonster[1].count then
      NPC_SAY("HOHO~了不起，了不起的实力啊！如果持续击退怪物的话，怪物就无处生存?")
      SET_QUEST_STATE(1063, 2)
      return
    else
      NPC_SAY("什么啊，就这程度？{0xFFFFFF00}100个八脚魔怪{END}啊，实力很一般啊！")
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
