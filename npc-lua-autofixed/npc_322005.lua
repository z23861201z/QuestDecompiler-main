function npcsay(id)
  if id ~= 4322005 then
    return
  end
  clickNPCid = id
  if qData[1060].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1060].goal.getItem) then
      NPC_SAY("对，就是这个！稍等一下，我会赐予你祝福的")
      SET_QUEST_STATE(1060, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}巨木重林津液{END}可不是那么容易就能获得的，必须得努力击退怪物才行")
      return
    end
  end
  if qData[1061].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1061].goal.getItem) then
      NPC_SAY("对，就是这个！稍等一下，我会赐予你祝福的")
      SET_QUEST_STATE(1061, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}巨木重林津液{END}可不是那么容易就能获得的，必须得努力击退怪物才行")
      return
    end
  end
  if qData[2713].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2713].goal.getItem) then
      NPC_SAY("真的太感谢了！")
      SET_QUEST_STATE(2713, 2)
      return
    else
      NPC_SAY("去{0xFFFFFF00}干涸的沼泽{END}击退{0xFFFFFF00}破戒僧{END}，收集30个{0xFFFFFF00}咒术仗{END}回来吧。")
    end
  end
  if qData[1060].state == 0 then
    ADD_QUEST_BTN(qt[1060].id, qt[1060].name)
  end
  if qData[1061].state == 0 then
    ADD_QUEST_BTN(qt[1061].id, qt[1061].name)
  end
  if qData[2713].state == 0 and qData[2712].state == 2 and GET_PLAYER_LEVEL() >= qt[2713].needLevel then
    ADD_QUEST_BTN(qt[2713].id, qt[2713].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1060].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1060].needLevel then
    if qData[1060].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1060].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[1060].state)
      end
    else
      QSTATE(id, qData[1060].state)
    end
  end
  if qData[1061].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1061].needLevel then
    if qData[1061].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1061].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[1061].state)
      end
    else
      QSTATE(id, qData[1061].state)
    end
  end
  if qData[2713].state ~= 2 and qData[2712].state == 2 and GET_PLAYER_LEVEL() >= qt[2713].needLevel then
    if qData[2713].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[2713].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
