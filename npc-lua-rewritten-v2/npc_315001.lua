function npcsay(id)
  if id ~= 4315001 then
    return
  end
  clickNPCid = id
  NPC_SAY("现在韩野城岛地带的怪物力量变得强大，韩野城居民都撤离了。所以现在不能移动。高一燕得快点聚集力量找回韩野城才行啊..")
  ADD_NPC_WARP_HANYA(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
