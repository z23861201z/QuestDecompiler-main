function npcsay(id)
  if id ~= 4222003 then
    return
  end
  clickNPCid = id
  NPC_SAY("你好。慢慢看完之后做好对付怪物的准备吧。")
  if qData[1050].state == 1 then
    if CHECK_ITEM_CNT(qt[1050].goal.getItem[1].id) >= qt[1050].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("{0xFFFFFF00}PLAYERNAME{END}，很感谢帮我收集了符咒。现在可以安心了")
        SET_QUEST_STATE(1050, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退{0xFFFFFF00}八脚魔怪{END}收集蜘蛛丝回来吧。做好了制作防具的准备。只要有{0xFFFFFF00}10个{END}应该就可以完成了")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10053)
  GIHON_MIXTURE(id)
  if qData[1050].state == 0 then
    ADD_QUEST_BTN(qt[1050].id, qt[1050].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1050].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1050].needLevel then
    if qData[1050].state == 1 then
      if CHECK_ITEM_CNT(qt[1050].goal.getItem[1].id) >= qt[1050].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
