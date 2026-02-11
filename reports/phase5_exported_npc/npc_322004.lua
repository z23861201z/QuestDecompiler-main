function npcsay(id)
  if id ~= 4322004 then
    return
  end
  clickNPCid = id
  if qData[1058].state == 1 then
    if CHECK_ITEM_CNT(qt[1058].goal.getItem[1].id) >= qt[1058].goal.getItem[1].count then
      NPC_SAY("谢谢，我会好好使用津液的，现在就赐予你祝福吧！")
      SET_QUEST_STATE(1058, 2)
      return
    else
      NPC_SAY("据我所知，击退巨木重林的怪物就能获得{0xFFFFFF00}巨木重林津液{END}！收集{0xFFFFFF00}5个{END}交给我吧！")
      return
    end
  end
  if qData[1059].state == 1 then
    if CHECK_ITEM_CNT(qt[1059].goal.getItem[1].id) >= qt[1059].goal.getItem[1].count then
      NPC_SAY("谢谢，我会好好使用津液的，现在就赐予你关怀吧！")
      SET_QUEST_STATE(1059, 2)
      return
    else
      NPC_SAY("据我所知，击退巨木重林的怪物就能获得{0xFFFFFF00}巨木重林津液{END}！收集{0xFFFFFF00}5个{END}交给我吧！")
      return
    end
  end
  if qData[2712].state == 1 then
    if CHECK_ITEM_CNT(qt[2712].goal.getItem[1].id) >= qt[2712].goal.getItem[1].count then
      NPC_SAY("这么快，太感谢了！")
      SET_QUEST_STATE(2712, 2)
      return
    else
      NPC_SAY("去{0xFFFFFF00}干涸的沼泽{END}击退{0xFFFFFF00}志鬼心火{END}收集30个{0xFFFFFF00}志鬼心火火焰{END} 回来吧。")
    end
  end
  if qData[1058].state == 0 then
    ADD_QUEST_BTN(qt[1058].id, qt[1058].name)
  end
  if qData[1059].state == 0 then
    ADD_QUEST_BTN(qt[1059].id, qt[1059].name)
  end
  if qData[2712].state == 0 and GET_PLAYER_LEVEL() >= qt[2712].needLevel then
    ADD_QUEST_BTN(qt[2712].id, qt[2712].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1058].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1058].needLevel then
    if qData[1058].state == 1 then
      if CHECK_ITEM_CNT(qt[1058].goal.getItem[1].id) >= qt[1058].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[1058].state)
      end
    else
      QSTATE(id, qData[1058].state)
    end
  end
  if qData[1059].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1059].needLevel then
    if qData[1059].state == 1 then
      if CHECK_ITEM_CNT(qt[1059].goal.getItem[1].id) >= qt[1059].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, qData[1059].state)
      end
    else
      QSTATE(id, qData[1059].state)
    end
  end
  if qData[2712].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2712].needLevel then
    if qData[2712].state == 1 then
      if CHECK_ITEM_CNT(qt[2712].goal.getItem[1].id) >= qt[2712].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
