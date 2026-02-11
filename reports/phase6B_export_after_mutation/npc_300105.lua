function npcsay(id)
  if id ~= 4300105 then
    return
  end
  clickNPCid = id
  NPC_SAY("请帮我收集散落各处的大目仔的心吧。大目仔的心收集100%，{0xFFFFFF00}1小时内经验值变成双倍{END} ")
end
function chkQState(id)
  QSTATE(id, -1)
end
