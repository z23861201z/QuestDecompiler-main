function npcsay(id)
  if id ~= 4300129 then
    return
  end
  clickNPCid = id
  if qData[2954].state == 1 then
    NPC_SAY("{0xFFFFFF00}艾里村长老{END}在{0xFFFFFF00}艾里村长老{END}。你去的话，他肯定很高兴。")
  end
  ADD_NEW_SHOP_BTN(id, 10071)
  ADD_NPC_YUT_EVENT(id)
  if qData[2954].state == 0 then
    ADD_QUEST_BTN(qt[2954].id, qt[2954].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2954].state ~= 2 then
    if qData[2954].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
