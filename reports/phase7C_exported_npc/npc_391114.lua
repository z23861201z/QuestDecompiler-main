function npcsay(id)
  if id ~= 4391114 then
    return
  end
  NPC_SAY("古龙好像从洞窟出去了。只有龙尾香炉才能将古龙重新吸引到洞窟中去。")
  clickNPCid = id
  if qData[2651].state == 1 then
    NPC_SAY("首先，控制住古龙的洞窟。光做到这一点就可以得到奖励。")
  end
  if qData[3721].state == 1 then
    NPC_SAY("首先，控制住古龙的洞窟。光做到这一点就可以得到奖励。")
  end
  ADD_BTN_NEST_OF_ANCIENT_DRAGON(id)
  INDUN_NEST_OF_ANCIENT_DRAGON_RAID_RANKING(id)
  ADD_NEW_SHOP_BTN(id, 10085)
  if qData[2651].state == 0 then
    ADD_QUEST_BTN(qt[2651].id, qt[2651].name)
  end
  if qData[3721].state == 0 and qData[2651].state == 2 then
    ADD_QUEST_BTN(qt[3721].id, qt[3721].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2651].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2651].needLevel then
    if qData[2651].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2651].state == 2 and qData[3721].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3721].needLevel then
    if qData[3721].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
