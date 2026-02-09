local function __QUEST_HAS_ALL_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

local function __QUEST_FIRST_ITEM_ID(goalItems)
  if goalItems == nil or goalItems[1] == nil then
    return 0
  end
  return goalItems[1].id
end

local function __QUEST_FIRST_ITEM_COUNT(goalItems)
  if goalItems == nil or goalItems[1] == nil then
    return 0
  end
  return goalItems[1].count
end

function npcsay(id)
  if id ~= 4300119 then
    return
  end
  clickNPCid = id
  if qData[1401].state == 1 then
    NPC_SAY("??, ??? ????. ??∼ ? ?????")
    SET_QUEST_STATE(1401, 2)
  end
  if qData[1402].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1402].goal.getItem) then
      NPC_SAY("????. ?? ?? ??? ??? ??? ??? ??. ??? ?? ??? ??? ???. ??∼ ? ?????")
      SET_QUEST_STATE(1402, 2)
    else
      NPC_SAY("??? ???? ????? 10?? ???? ??! ??? ?? ??? ??? ???. ??∼ ? ?????")
    end
  end
  if qData[1403].state == 1 then
    NPC_SAY("??? ????? ? ??? ???? ?? ??? ??? ?? ??. ??? ??? ???.  ??∼ ? ?????")
  end
  if qData[2007].state == 1 then
    NPC_SAY("킁킁, 수상한 냄새로군. 아니… 내 냄새인가?")
    SET_QUEST_STATE(2007, 2)
  end
  if qData[2008].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2008].goal.getItem) then
      NPC_SAY("수고했군. 이제 기가 막히게 맛있는 김밥이 태어날 걸세. 생각만 해도 맛있는 냄새가 나는군. 아니… 내 냄새인가?")
      SET_QUEST_STATE(2008, 2)
    else
      NPC_SAY("마물을 퇴치하고 김밥속재료 10개를 구해오는 거다! 생각만 해도 맛있는 냄새가 나는군. 아니… 내 냄새인가?")
    end
  end
  if qData[2009].state == 1 then
    NPC_SAY("서둘러 흑사풍에게 이 소식을 전달하게 그는 청음관에 있을 걸세. 그리운 냄새가 나는군.  아니… 내 냄새인가?")
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
