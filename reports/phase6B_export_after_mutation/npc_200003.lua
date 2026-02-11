function npcsay(id)
  if id ~= 4200003 then
    return
  end
  clickNPCid = id
  NPC_SAY("所有物品仅在委托销售仓库保存7天，超时将被系统回收哟！")
  if qData[2035].state == 1 then
    SET_QUEST_STATE(2035, 2)
    NPC_SAY("（委托销售仓库旁边贴着小纸条）")
  end
  if qData[2036].state == 1 then
    NPC_SAY("（确认了巡视日记完成了任务，现在回到佣兵领袖处吧）")
  end
  ADD_AUCTION_OPEN(id)
  ADD_ITEMLOCK_20130723(id)
  if qData[2036].state == 0 and qData[2035].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2036].id, qt[2036].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2035].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2036].state ~= 2 and qData[2035].state == 2 and GET_PLAYER_LEVEL() >= qt[2036].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2036].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
