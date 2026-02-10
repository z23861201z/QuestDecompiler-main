function npcsay(id)
  if id ~= 4314014 then
    return
  end
  clickNPCid = id
  NPC_SAY("卡哈哈！！一看你就是个能拯救世界的人。就收你{0xFFFFFF00}占卜费10000钱{END}给你看运势吧。怎么样，要试试吗？机会{0xFFFFFF00}一天只有一次{END}。")
  ADD_NPC_CARD_DIVINE(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
