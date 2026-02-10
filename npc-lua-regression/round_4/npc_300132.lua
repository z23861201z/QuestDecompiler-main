function npcsay(id)
  if id ~= 4300132 then
    return
  end
  clickNPCid = id
  NPC_SAY("请帮我收集散落各处的魔教令牌。集满100%时，1小时内经验值、掉率、金币掉率会变成双倍")
  ADD_MAGOO_DONATION_EVENT(id)
  ADD_MAGOO_DONATION_EVENT_SHOW(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
