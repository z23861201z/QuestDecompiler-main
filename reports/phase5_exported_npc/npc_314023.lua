function npcsay(id)
  if id ~= 4314023 then
    return
  end
  clickNPCid = id
  NPC_SAY("你好，我是新手帮助。第一次来灵游记世界吗？那就去见见'武功研究NPC'吧。他会告诉你在灵游记世界生存下去的各种方法。")
  NPC_WARP_TO_DOK_PYO_GONG(id)
  ADD_NPC_CARTOON(id)
  ADD_NPC_WARP_WARRIOR(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
