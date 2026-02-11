function npcsay(id)
  if id ~= 4391108 then
    return
  end
  NPC_SAY("近卫兵亚夫过来了！你先从后面绕过去，一会儿再回来！")
  clickNPCid = id
  if qData[877].state == 1 then
    NPC_SAY("辛苦了，你要抓紧行动了，{0xFFFFFF00}近卫兵亚夫{END}正在过来呢！我们稍后再见")
    SET_QUEST_STATE(877, 2)
    return
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[877].state == 1 then
    QSTATE(id, 2)
  end
end
