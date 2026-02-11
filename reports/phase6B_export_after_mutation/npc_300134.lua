function npcsay(id)
  if id ~= 4300134 then
    return
  end
  clickNPCid = id
  NPC_SAY("请帮忙收集8周年纪念币吧。8周年石像燃烧起来的话，{0xFFFFFF00}1小时内怪物伤害增加100%，鬼力消耗量减少50%{END}。")
  BTN_8YEAR_RETURN(id)
  BTN_8YEAR_SHOW(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
