function npcsay(id)
  if id ~= 4391101 then
    return
  end
  clickNPCid = id
  NPC_SAY("谢谢。这样居民们也可以安心了。")
  if qData[1208].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("你现在就是清阴关的名流。提起清阴关最先想到的就是你。把无数个武林人士抛在后面以最出色的新秀出了名。哈哈哈！")
      SET_QUEST_STATE(1208, 2)
    else
      NPC_SAY("行囊空间不足。")
    end
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1208].state == 1 then
    QSTATE(id, 2)
  end
end
