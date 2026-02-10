function npcsay(id)
  if id ~= 4314051 then
    return
  end
  clickNPCid = id
  NPC_SAY("大家好。可以给这对新人祝福的客人都到齐了。要开始举办婚礼吗？{0xFFFFFF00}(婚礼结束之后自动移动到宴会厅。){END}")
  ADD_BTN_WEDDING_MESSGE(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
