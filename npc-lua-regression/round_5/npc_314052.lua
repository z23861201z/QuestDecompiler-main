function npcsay(id)
  if id ~= 4314052 then
    return
  end
  clickNPCid = id
  NPC_SAY("可以给今天的主人公送礼金。请点击[ 送礼金 ]按钮。（最少1钱~最多10亿钱）")
  ADD_BTN_WEDDING_MONEY(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
