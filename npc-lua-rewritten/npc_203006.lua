local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4203006 then
    return
  end
  clickNPCid = id
  NPC_SAY("{0xFFFFFF00}[ 钓竿 ]{END}装备在武器装备窗里，用右键选择{0xFFFFFF00}[ 鱼饵 ]{END}。按 {0xFFFFFF00}[ 空格键 ]或 [ Alt ]{END}键就可以开始钓鱼。")
  if qData[1198].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[1198].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("哈哈。哪有什么秘诀啊？钓到鱼的快感就是可以快乐的钓鱼的秘诀。{0xFFFFFF00}钓到的鱼可以在冥珠城老当家处做成美味的料理。{END} 这是我给出入钓鱼世界的你的礼物。祝你能钓到一尺多大的鱼。")
        SET_QUEST_STATE(1198, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("你钓来一条鲫鱼，我就会告诉你我的钓鱼秘诀。趁钓鱼的人涌来之前快去吧。")
    end
  end
  if qData[3704].state == 1 then
    if __QUEST_CHECK_ITEMS(qt[3704].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢！我是我给你准备的小礼物~")
        SET_QUEST_STATE(3704, 2)
        return
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("找回怪物们偷走的20个{0xFFFFFF00}[蚊香]{END}就可以了。")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10010)
  if qData[1198].state == 0 then
    ADD_QUEST_BTN(qt[1198].id, qt[1198].name)
  end
  if qData[3704].state == 0 then
    ADD_QUEST_BTN(qt[3704].id, qt[3704].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1198].state ~= 2 then
    if qData[1198].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[1198].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3704].state ~= 2 then
    if qData[3704].state == 1 then
      if __QUEST_CHECK_ITEMS(qt[3704].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
