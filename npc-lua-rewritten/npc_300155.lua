local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4300155 then
    return
  end
  clickNPCid = id
  NPC_SAY("呵呵，圣诞节快乐~")
  if qData[3711].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[3711].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢了。托你的福，能尽快给孩子们发礼物了。")
        SET_QUEST_STATE(3711, 2)
        return
      else
        NPC_SAY("行囊太沉！")
      end
    else
      NPC_SAY("{0xFFFFFF00}圣诞节书信{END}应该是混在{0xFFFFFF00}圣诞节庭院{END}的礼物箱子当中。你仔细找找应该能发现装有{0xFFFFFF00}圣诞节书信{END}的箱子的。")
    end
  end
  if qData[3711].state == 0 then
    ADD_QUEST_BTN(qt[3711].id, qt[3711].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3711].state ~= 2 then
    if qData[3711].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[3711].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
