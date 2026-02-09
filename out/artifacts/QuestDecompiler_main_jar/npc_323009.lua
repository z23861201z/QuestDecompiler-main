function npcsay(id)
  if id ~= 4323009 then
    return
  end
  NPC_SAY("I did not drink! Well, it just happened to be... Huh? You are not GuardApu! \n{0xFFFF3333}¡ØAngora Outer is available from level 160 or more, and 'Arak' is a required item when entering.{END}")
  clickNPCid = id
  if qData[1482].state == 1 then
    NPC_SAY("Stop there! Wait. What's this smell? It's Arak.")
    SET_QUEST_STATE(1482, 2)
    return
  end
  if qData[1483].state == 1 then
    if CHECK_ITEM_CNT(qt[1483].goal.getItem[1].id) >= qt[1483].goal.getItem[1].count then
      NPC_SAY("Well done. Well done! I almost got caught by GuardApu, but all is good!")
      SET_QUEST_STATE(1483, 2)
      return
    else
      NPC_SAY("Anyway, if you bring me 50 CursedCoins from CursedCamelion at AngoraTownAlley, I'll give you some information.")
    end
  end
  if qData[1484].state == 1 then
    NPC_SAY("Huh? You still haven't gone? (Let's go back to GuardCaesam at AngoraPalace.)")
    return
  end
  if qData[1485].state == 1 then
    NPC_SAY("You're here again? I've heard story from GuardCaesam, but I feel like I'm going to lose something.")
    SET_QUEST_STATE(1485, 2)
    return
  end
  if qData[1498].state == 1 then
    NPC_SAY("So what are you going to do now?")
    SET_QUEST_STATE(1498, 2)
    return
  end
  if qData[874].state == 1 then
    if CHECK_ITEM_CNT(qt[874].goal.getItem[1].id) >= qt[874].goal.getItem[1].count and CHECK_ITEM_CNT(qt[874].goal.getItem[2].id) >= qt[874].goal.getItem[2].count and CHECK_ITEM_CNT(qt[874].goal.getItem[3].id) >= qt[874].goal.getItem[3].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("Well done. Here's a reward from GuardApu. See you tomorrow!")
        SET_QUEST_STATE(874, 2)
        return
      else
        NPC_SAY("Inventory is full.")
      end
    else
      NPC_SAY("Bring me 20 CursedCoins, 20 SlaughterFiend'sOilbottle, and 1 PossessedRosary. You can obtain them from CursedCamelion, SlaughterFiends, and NohoSpiritApostle.")
    end
  end
  if qData[875].state == 1 then
    if CHECK_ITEM_CNT(qt[875].goal.getItem[1].id) >= qt[875].goal.getItem[1].count and CHECK_ITEM_CNT(qt[875].goal.getItem[2].id) >= qt[875].goal.getItem[2].count and CHECK_ITEM_CNT(qt[875].goal.getItem[3].id) >= qt[875].goal.getItem[3].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("Well done. Here's a reward from GuardApu. See you tomorrow!")
        SET_QUEST_STATE(875, 2)
        return
      else
        NPC_SAY("Inventory is full.")
      end
    else
      NPC_SAY("Bring me 20 Silverfoot, 20 AncientAnnualring, and 1 GhostlypossessiveRosarium. You can obtain them from WoodenBigFoot, WoodenInfernoFoot, and NohoSpiritCaptain.")
    end
  end
  if qData[877].state == 1 then
    NPC_SAY("Eliminate monsters what you see and monitor the whole situation until GuardApu comes.")
  end
  if qData[878].state == 1 then
    NPC_SAY("Eliminate monsters what you see and monitor the whole situation until GuardApu comes.")
  end
  if qData[1498].state == 0 and qData[874].state == 2 then
    ADD_QUEST_BTN(qt[1498].id, qt[1498].name)
  end
  if qData[1483].state == 0 and qData[1482].state == 2 then
    ADD_QUEST_BTN(qt[1483].id, qt[1483].name)
  end
  if qData[1484].state == 0 and qData[1483].state == 2 then
    ADD_QUEST_BTN(qt[1484].id, qt[1484].name)
  end
  if qData[874].state == 0 and qData[1485].state == 2 then
    ADD_QUEST_BTN(qt[874].id, qt[874].name)
  end
  if qData[875].state == 0 and qData[1485].state == 2 then
    ADD_QUEST_BTN(qt[875].id, qt[875].name)
  end
  if qData[877].state == 0 and qData[1498].state == 2 then
    ADD_QUEST_BTN(qt[877].id, qt[877].name)
  end
  if qData[878].state == 0 and qData[1498].state == 2 then
    ADD_QUEST_BTN(qt[878].id, qt[878].name)
  end
  if qData[1482].state == 2 then
    ADD_BTN_HELL_BACKSTREET(id)
  end
  if qData[1482].state == 2 then
    ADD_BTN_HELL_OUTSKIRTS(id)
  end
  if qData[1482].state == 2 then
    ADD_BTN_HELL_DARKROAD(id)
  end
  if qData[1482].state == 2 then
    ADD_BTN_HELL_TOWN_WAR(id)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[874].state == 2 and qData[1498].state ~= 2 then
    if qData[1498].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1482].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1483].state ~= 2 and qData[1482].state == 2 then
    if qData[1483].state == 1 then
      if CHECK_ITEM_CNT(qt[1483].goal.getItem[1].id) >= qt[1483].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1484].state ~= 2 and qData[1483].state == 2 then
    if qData[1484].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1485].state == 1 then
    QSTATE(id, 2)
  end
  if qData[874].state ~= 2 and qData[1485].state == 2 then
    if qData[874].state == 1 then
      if CHECK_ITEM_CNT(qt[874].goal.getItem[1].id) >= qt[874].goal.getItem[1].count and CHECK_ITEM_CNT(qt[874].goal.getItem[2].id) >= qt[874].goal.getItem[2].count and CHECK_ITEM_CNT(qt[874].goal.getItem[3].id) >= qt[874].goal.getItem[3].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[875].state ~= 2 and qData[1485].state == 2 then
    if qData[875].state == 1 then
      if CHECK_ITEM_CNT(qt[875].goal.getItem[1].id) >= qt[875].goal.getItem[1].count and CHECK_ITEM_CNT(qt[875].goal.getItem[2].id) >= qt[875].goal.getItem[2].count and CHECK_ITEM_CNT(qt[875].goal.getItem[3].id) >= qt[875].goal.getItem[3].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[877].state ~= 2 and qData[1498].state == 2 then
    if qData[877].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[878].state ~= 2 and qData[1498].state == 2 then
    if qData[878].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
