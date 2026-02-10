function npcsay(id)
  if id ~= 4314044 then
    return
  end
  clickNPCid = id
  NPC_SAY("不知道怎么回事，发现了黄泉的裂缝。好像是谁想要强行打开黄泉的门。不知道是谁干的..要尽快封印黄泉的裂缝。需要各位侠客的帮助。")
end
function chkQState(id)
  QSTATE(id, -1)
end
