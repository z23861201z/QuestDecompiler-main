function npcsay(id)
  if id ~= 4315022 then
    return
  end
  clickNPCid = id
  NPC_SAY("古代神秘文字璀璨发光. 带着石碑的气韵到外部去吗?")
  NPC_WARP_THEME_22(id)
  NPC_ANSWER_CANCEL(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
