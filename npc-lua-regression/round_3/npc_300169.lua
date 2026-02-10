function npcsay(id)
  if id ~= 4300169 then
    return
  end
  clickNPCid = id
  if qData[3747].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[3747].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("这就是巧克力啊~谢谢。{0xFFFFFF00}我要用这个重新制作巧克力{END}。")
        SET_QUEST_STATE(3747, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去{0xFFFFFF00}清阴平原{END}击退{0xFFFFFF00}小菜头{END}，收集{0xFFFFFF00}50个融化的巧克力{END}回来吧。我把原本要给大目仔的礼物给你。")
    end
  end
  if qData[3747].state == 0 then
    ADD_QUEST_BTN(qt[3747].id, qt[3747].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3747].state ~= 2 then
    if qData[3747].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[3747].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
