function npcsay(id)
  if id ~= 4391113 then
    return
  end
  clickNPCid = id
  if qData[2337].state == 1 then
    NPC_SAY("没有准备好就是这种状态？巨木神很吃惊")
    SET_QUEST_STATE(2337, 2)
    return
  end
  if qData[2338].state == 1 then
    NPC_SAY("回去吧，巨木神会等着你准备好~")
  end
  if qData[2574].state == 1 then
    NPC_SAY("巨木神认可。你有{0xFFFFFF00}资格登上玄境的境界！{END}来巨木重林中心吧")
    SET_QUEST_STATE(2574, 2)
    return
  end
  if qData[3663].state == 1 then
    NPC_SAY("今天就到为止吧，巨木神期待你的成长！")
    SET_QUEST_STATE(3663, 2)
    return
  end
  if qData[2338].state == 0 and qData[2337].state == 2 and GET_PLAYER_LEVEL() >= qt[2338].needLevel then
    ADD_QUEST_BTN(qt[2338].id, qt[2338].name)
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2337].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2338].state ~= 2 and qData[2337].state == 2 and GET_PLAYER_LEVEL() >= qt[2338].needLevel then
    if qData[2338].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2574].state == 1 then
    QSTATE(id, 2)
  end
  if qData[3663].state == 1 then
    QSTATE(id, 2)
  end
end
