function npcsay(id)
  if id ~= 4300165 then
    return
  end
  clickNPCid = id
  if qData[3745].state == 1 then
    if qData[3744].state ~= 2 then
      if __QUEST_HAS_ALL_ITEMS(qt[3745].goal.getItem) then
        if 1 <= CHECK_INVENTORY_CNT(2) then
          NPC_SAY("哇~太感谢了。我再说一下，跟我借了后，今天就不能再跟旁边的兔子借了。")
          SET_QUEST_STATE(3745, 2)
          return
        else
          NPC_SAY("行囊太沉")
        end
      else
        NPC_SAY("我把可以获得300%的额外经验值的腰带租给你12小时，你能给我15个8周年纪念币吗？对了，跟我借了就不能再跟旁边的兔子借了。")
      end
    else
      NPC_SAY("你已经跟兔子借过腰带了，所以今天不能再跟我借了。")
    end
  end
  if qData[3745].state == 0 and qData[3744].state ~= 2 then
    ADD_QUEST_BTN(qt[3745].id, qt[3745].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3745].state ~= 2 then
    if qData[3745].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3745].goal.getItem) and qData[3744].state ~= 2 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
