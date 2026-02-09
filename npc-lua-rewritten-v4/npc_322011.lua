function npcsay(id)
  if id ~= 4322011 then
    return
  end
  clickNPCid = id
  NPC_SAY("此地是巨木重林的边界，可以到达遥远的仙游谷的天柱。怪物的邪气消失了不少，现在可以来回于仙游谷和西域两地了！")
  NPC_WARP_THEME_51_19(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
