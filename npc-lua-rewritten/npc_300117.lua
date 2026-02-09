local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4300117 then
    return
  end
  clickNPCid = id
  if qData[1801].state == 1 and __QUEST_CHECK_ITEMS(qt[1801].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1801)
  end
  if qData[1802].state == 1 and __QUEST_CHECK_ITEMS(qt[1802].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1802)
  end
  if qData[1803].state == 1 and __QUEST_CHECK_ITEMS(qt[1803].goal.getItem) and qData[1803].killMonster[qt[1803].goal.killMonster[1].id] >= qt[1803].goal.killMonster[1].count then
    SET_QUEST_COMPLETE_USEQUESTITEM(1803)
  end
  if qData[1804].state == 1 and __QUEST_CHECK_ITEMS(qt[1804].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1804)
  end
  if qData[1805].state == 1 and __QUEST_CHECK_ITEMS(qt[1805].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1805)
  end
  if qData[1806].state == 1 and __QUEST_CHECK_ITEMS(qt[1806].goal.getItem) and qData[1806].killMonster[qt[1806].goal.killMonster[1].id] >= qt[1806].goal.killMonster[1].count then
    SET_QUEST_COMPLETE_USEQUESTITEM(1806)
  end
  if qData[1807].state == 1 and qData[1807].killMonster[qt[1807].goal.killMonster[1].id] >= qt[1807].goal.killMonster[1].count then
    SET_QUEST_COMPLETE_USEQUESTITEM(1807)
  end
  if qData[1808].state == 1 and qData[1808].killMonster[qt[1808].goal.killMonster[1].id] >= qt[1808].goal.killMonster[1].count then
    SET_QUEST_COMPLETE_USEQUESTITEM(1808)
  end
  if qData[1809].state == 1 and qData[1809].killMonster[qt[1809].goal.killMonster[1].id] >= qt[1809].goal.killMonster[1].count then
    SET_QUEST_COMPLETE_USEQUESTITEM(1809)
  end
  if qData[1810].state == 1 and __QUEST_CHECK_ITEMS(qt[1810].goal.getItem) and qData[1810].killMonster[qt[1810].goal.killMonster[1].id] >= qt[1810].goal.killMonster[1].count then
    SET_QUEST_COMPLETE_USEQUESTITEM(1810)
  end
  if qData[1811].state == 1 and __QUEST_CHECK_ITEMS(qt[1811].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1811)
  end
  if qData[1812].state == 1 and __QUEST_CHECK_ITEMS(qt[1812].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1812)
  end
  if qData[1813].state == 1 and __QUEST_CHECK_ITEMS(qt[1813].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1813)
  end
  if qData[1814].state == 1 and __QUEST_CHECK_ITEMS(qt[1814].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1814)
  end
  if qData[1815].state == 1 and __QUEST_CHECK_ITEMS(qt[1815].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1815)
  end
  if qData[1816].state == 1 and __QUEST_CHECK_ITEMS(qt[1816].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1816)
  end
  if qData[1817].state == 1 and __QUEST_CHECK_ITEMS(qt[1817].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1817)
  end
  if qData[1818].state == 1 and __QUEST_CHECK_ITEMS(qt[1818].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1818)
  end
  if qData[1819].state == 1 and __QUEST_CHECK_ITEMS(qt[1819].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1819)
  end
  if qData[1820].state == 1 and __QUEST_CHECK_ITEMS(qt[1820].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1820)
  end
  if qData[1821].state == 1 and qData[1821].meetNpc[1] == qt[1821].goal.meetNpc[1] then
    SET_QUEST_COMPLETE_USEQUESTITEM(1821)
  end
  if qData[1822].state == 1 and __QUEST_CHECK_ITEMS(qt[1822].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1822)
  end
  if qData[1823].state == 1 and qData[1823].meetNpc[1] == qt[1823].goal.meetNpc[1] then
    SET_QUEST_COMPLETE_USEQUESTITEM(1823)
  end
  if qData[1825].state == 1 and __QUEST_CHECK_ITEMS(qt[1825].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1825)
  end
  if qData[1826].state == 1 and __QUEST_CHECK_ITEMS(qt[1826].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1826)
  end
  if qData[1827].state == 1 and __QUEST_CHECK_ITEMS(qt[1827].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1827)
  end
  if qData[1828].state == 1 and __QUEST_CHECK_ITEMS(qt[1828].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1828)
  end
  if qData[1829].state == 1 and __QUEST_CHECK_ITEMS(qt[1829].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1829)
  end
  if qData[1830].state == 1 and __QUEST_CHECK_ITEMS(qt[1830].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1830)
  end
  if qData[1831].state == 1 and __QUEST_CHECK_ITEMS(qt[1831].goal.getItem) then
    SET_QUEST_COMPLETE_USEQUESTITEM(1831)
  end
end
function chkQState(id)
  QSTATE(id, -1)
end
