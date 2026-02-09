function npcsay(id)
  if id ~= 4314050 then
    return
  end
  clickNPCid = id
  NPC_SAY("举办婚礼需要恋人双方同时在线，且需要结婚戒指。准备好了就请按举办婚礼按钮。{0xFFFFFF00}(每月的第一、第三个星期三上午9点~10点是不适合结婚的时间。请避开这些时间。){END}")
  ADD_BTN_WEDDING(id)
  ADD_BTN_WEDDING_GIFT(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
