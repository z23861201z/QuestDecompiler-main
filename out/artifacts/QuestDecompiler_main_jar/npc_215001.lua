function npcsay(id)
  if id ~= 4215001 then
    return
  end
  clickNPCid = id
  if qData[151].state == 1 then
    NPC_SAY("Have you met the Azure River Ferryman?")
  end
  if qData[1023].state == 1 then
    if CHECK_ITEM_CNT(qt[1023].goal.getItem[1].id) >= qt[1023].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1023, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}WhiteSpiritPiece{END} yet?")
    end
  end
  if qData[1024].state == 1 then
    if CHECK_ITEM_CNT(qt[1024].goal.getItem[1].id) >= qt[1024].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1024, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}WhiteSpiritPiece{END} yet?")
    end
  end
  if qData[1033].state == 1 then
    if CHECK_ITEM_CNT(qt[1033].goal.getItem[1].id) >= qt[1033].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1033, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}WhiteSpiritPiece{END} yet?")
    end
  end
  if qData[1034].state == 1 then
    if CHECK_ITEM_CNT(qt[1034].goal.getItem[1].id) >= qt[1034].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1034, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}WhiteSpiritPiece{END} yet?")
    end
  end
  if qData[1025].state == 1 then
    if CHECK_ITEM_CNT(qt[1025].goal.getItem[1].id) >= qt[1025].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1025, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BlackSpiritPiece{END} yet?")
    end
  end
  if qData[1026].state == 1 then
    if CHECK_ITEM_CNT(qt[1026].goal.getItem[1].id) >= qt[1026].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1026, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BlackSpiritPiece{END} yet?")
    end
  end
  if qData[1035].state == 1 then
    if CHECK_ITEM_CNT(qt[1035].goal.getItem[1].id) >= qt[1035].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1035, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BlackSpiritPiece{END} yet?")
    end
  end
  if qData[1036].state == 1 then
    if CHECK_ITEM_CNT(qt[1036].goal.getItem[1].id) >= qt[1036].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1036, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BlackSpiritPiece{END} yet?")
    end
  end
  if qData[1027].state == 1 then
    if CHECK_ITEM_CNT(qt[1027].goal.getItem[1].id) >= qt[1027].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1027, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BrownSpiritPiece{END} yet?")
    end
  end
  if qData[1028].state == 1 then
    if CHECK_ITEM_CNT(qt[1028].goal.getItem[1].id) >= qt[1028].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1028, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BrownSpiritPiece{END} yet?")
    end
  end
  if qData[1037].state == 1 then
    if CHECK_ITEM_CNT(qt[1037].goal.getItem[1].id) >= qt[1037].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1037, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BrownSpiritPiece{END} yet?")
    end
  end
  if qData[1038].state == 1 then
    if CHECK_ITEM_CNT(qt[1038].goal.getItem[1].id) >= qt[1038].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1038, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BrownSpiritPiece{END} yet?")
    end
  end
  if qData[1029].state == 1 then
    if CHECK_ITEM_CNT(qt[1029].goal.getItem[1].id) >= qt[1029].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1029, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GraySpiritPiece{END} yet?")
    end
  end
  if qData[1030].state == 1 then
    if CHECK_ITEM_CNT(qt[1030].goal.getItem[1].id) >= qt[1030].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1030, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GraySpiritPiece{END} yet?")
    end
  end
  if qData[1039].state == 1 then
    if CHECK_ITEM_CNT(qt[1039].goal.getItem[1].id) >= qt[1039].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1039, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GraySpiritPiece{END} yet?")
    end
  end
  if qData[1040].state == 1 then
    if CHECK_ITEM_CNT(qt[1040].goal.getItem[1].id) >= qt[1040].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1040, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GraySpiritPiece{END} yet?")
    end
  end
  if qData[1031].state == 1 then
    if CHECK_ITEM_CNT(qt[1031].goal.getItem[1].id) >= qt[1031].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1031, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GoldSpiritPiece{END} yet?")
    end
  end
  if qData[1032].state == 1 then
    if CHECK_ITEM_CNT(qt[1032].goal.getItem[1].id) >= qt[1032].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1032, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GoldSpiritPiece{END} yet?")
    end
  end
  if qData[1041].state == 1 then
    if CHECK_ITEM_CNT(qt[1041].goal.getItem[1].id) >= qt[1041].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1041, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GoldSpiritPiece{END} yet?")
    end
  end
  if qData[1042].state == 1 then
    if CHECK_ITEM_CNT(qt[1042].goal.getItem[1].id) >= qt[1042].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(1042, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GoldSpiritPiece{END} yet?")
    end
  end
  if qData[1274].state == 1 then
    if CHECK_ITEM_CNT(qt[1274].goal.getItem[1].id) >= qt[1274].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("Thank you. Now I can finish processing the carapaces more quickly than I anticipated.")
        SET_QUEST_STATE(1274, 2)
      else
        NPC_SAY("Inventory is full.")
      end
    else
      NPC_SAY("Please bring me 30 White Powders from Pale Face Ghosts in Rocky Mountains.")
    end
  end
  if qData[1282].state == 1 then
    if CHECK_ITEM_CNT(qt[1282].goal.getItem[1].id) >= qt[1282].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("Thank you. Now I don't have to worry about the ceiling falling on top of me while I'm asleep.")
        SET_QUEST_STATE(1282, 2)
      else
        NPC_SAY("Inventory is full.")
      end
    else
      NPC_SAY("Could you bring me 30 Slate Fragments from Stone Slates in Rocky Mountains?")
    end
  end
  if qData[1296].state == 1 then
    NPC_SAY("Oh, what took you so long?!")
    SET_QUEST_STATE(1296, 2)
  end
  if qData[1297].state == 1 then
    if CHECK_ITEM_CNT(qt[1297].goal.getItem[1].id) >= qt[1297].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("Thank you. The people will be happy to hear about this. Good job.")
        SET_QUEST_STATE(1297, 2)
      else
        NPC_SAY("Inventory is full.")
      end
    else
      NPC_SAY("Please bring me 30 Poison Pouches from Monkos in Rocky Mountains.")
    end
  end
  if qData[1298].state == 1 then
    if CHECK_ITEM_CNT(qt[1298].goal.getItem[1].id) >= qt[1298].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("Good job. Here's the Blue Kij Bullion I promised.")
        SET_QUEST_STATE(1298, 2)
      else
        NPC_SAY("Inventory is full.")
      end
    else
      NPC_SAY("I want you to go to the Stalactite Mine through the Dragon Castle Well and bring me 5 Blue Kij Ores. You'll have to pay for a pickax you need for the mining.")
    end
  end
  if qData[2383].state == 1 then
    if CHECK_ITEM_CNT(qt[2383].goal.getItem[1].id) >= qt[2383].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2383, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}WhiteSpiritPiece{END} yet?")
    end
  end
  if qData[2384].state == 1 then
    if CHECK_ITEM_CNT(qt[2384].goal.getItem[1].id) >= qt[2384].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2384, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}WhiteSpiritPiece{END} yet?")
    end
  end
  if qData[2393].state == 1 then
    if CHECK_ITEM_CNT(qt[2393].goal.getItem[1].id) >= qt[2393].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2393, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}WhiteSpiritPiece{END} yet?")
    end
  end
  if qData[2394].state == 1 then
    if CHECK_ITEM_CNT(qt[2394].goal.getItem[1].id) >= qt[2394].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2394, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}WhiteSpiritPiece{END} yet?")
    end
  end
  if qData[2385].state == 1 then
    if CHECK_ITEM_CNT(qt[2385].goal.getItem[1].id) >= qt[2385].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2385, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BlackSpiritPiece{END} yet?")
    end
  end
  if qData[2386].state == 1 then
    if CHECK_ITEM_CNT(qt[2386].goal.getItem[1].id) >= qt[2386].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2386, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BlackSpiritPiece{END} yet?")
    end
  end
  if qData[2395].state == 1 then
    if CHECK_ITEM_CNT(qt[2395].goal.getItem[1].id) >= qt[2395].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2395, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BlackSpiritPiece{END} yet?")
    end
  end
  if qData[2396].state == 1 then
    if CHECK_ITEM_CNT(qt[2396].goal.getItem[1].id) >= qt[2396].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2396, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BlackSpiritPiece{END} yet?")
    end
  end
  if qData[2387].state == 1 then
    if CHECK_ITEM_CNT(qt[2387].goal.getItem[1].id) >= qt[2387].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2387, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BrownSpiritPiece{END} yet?")
    end
  end
  if qData[2388].state == 1 then
    if CHECK_ITEM_CNT(qt[2388].goal.getItem[1].id) >= qt[2388].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2388, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BrownSpiritPiece{END} yet?")
    end
  end
  if qData[2397].state == 1 then
    if CHECK_ITEM_CNT(qt[2397].goal.getItem[1].id) >= qt[2397].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2397, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BrownSpiritPiece{END} yet?")
    end
  end
  if qData[2398].state == 1 then
    if CHECK_ITEM_CNT(qt[2398].goal.getItem[1].id) >= qt[2398].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2398, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}BrownSpiritPiece{END} yet?")
    end
  end
  if qData[2389].state == 1 then
    if CHECK_ITEM_CNT(qt[2389].goal.getItem[1].id) >= qt[2389].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2389, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GraySpiritPiece{END} yet?")
    end
  end
  if qData[2399].state == 1 then
    if CHECK_ITEM_CNT(qt[2399].goal.getItem[1].id) >= qt[2399].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2399, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GraySpiritPiece{END} yet?")
    end
  end
  if qData[2780].state == 1 then
    if CHECK_ITEM_CNT(qt[2780].goal.getItem[1].id) >= qt[2780].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2780, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GraySpiritPiece{END} yet?")
    end
  end
  if qData[2781].state == 1 then
    if CHECK_ITEM_CNT(qt[2781].goal.getItem[1].id) >= qt[2781].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2781, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GraySpiritPiece{END} yet?")
    end
  end
  if qData[2391].state == 1 then
    if CHECK_ITEM_CNT(qt[2391].goal.getItem[1].id) >= qt[2391].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2391, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GoldSpiritPiece{END} yet?")
    end
  end
  if qData[2392].state == 1 then
    if CHECK_ITEM_CNT(qt[2392].goal.getItem[1].id) >= qt[2392].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2392, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GoldSpiritPiece{END} yet?")
    end
  end
  if qData[2401].state == 1 then
    if CHECK_ITEM_CNT(qt[2401].goal.getItem[1].id) >= qt[2401].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2401, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GoldSpiritPiece{END} yet?")
    end
  end
  if qData[2402].state == 1 then
    if CHECK_ITEM_CNT(qt[2402].goal.getItem[1].id) >= qt[2402].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2402, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}GoldSpiritPiece{END} yet?")
    end
  end
  if qData[2403].state == 1 then
    if CHECK_ITEM_CNT(qt[2403].goal.getItem[1].id) >= qt[2403].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2403, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}PinkSpiritPiece{END} yet?")
    end
  end
  if qData[2404].state == 1 then
    if CHECK_ITEM_CNT(qt[2404].goal.getItem[1].id) >= qt[2404].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(1) then
        NPC_SAY("You brought it. Here's your weapon.")
        SET_QUEST_STATE(2404, 2)
      else
        NPC_SAY("Your inventory is full. Please make room in Bag 1.")
      end
    else
      NPC_SAY("Have you found 1 {0xFFFFFF00}PinkSpiritPiece{END} yet?")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10012)
  ADD_EQUIP_REFINE_BTN(id)
  ADD_REPAIR_EQUIPMENT(id)
  RARE_BOX_OPEN(id)
  RARE_BOX_MIXTURE(id)
  if qData[151].state == 0 and GET_PLAYER_FAME() >= 60 then
    ADD_QUEST_BTN(qt[151].id, qt[151].name)
  end
  if qData[1023].state == 0 and GET_PLAYER_JOB1() == 1 and CHECK_ITEM_CNT(qt[1023].goal.getItem[1].id) >= qt[1023].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1023].id, qt[1023].name)
  end
  if qData[1024].state == 0 and GET_PLAYER_JOB1() == 1 and CHECK_ITEM_CNT(qt[1024].goal.getItem[1].id) >= qt[1024].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1024].id, qt[1024].name)
  end
  if qData[1033].state == 0 and GET_PLAYER_JOB1() == 1 and CHECK_ITEM_CNT(qt[1033].goal.getItem[1].id) >= qt[1033].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1033].id, qt[1033].name)
  end
  if qData[1034].state == 0 and GET_PLAYER_JOB1() == 1 and CHECK_ITEM_CNT(qt[1034].goal.getItem[1].id) >= qt[1034].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1034].id, qt[1034].name)
  end
  if qData[1025].state == 0 and GET_PLAYER_JOB1() == 2 and CHECK_ITEM_CNT(qt[1025].goal.getItem[1].id) >= qt[1025].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1025].id, qt[1025].name)
  end
  if qData[1026].state == 0 and GET_PLAYER_JOB1() == 2 and CHECK_ITEM_CNT(qt[1026].goal.getItem[1].id) >= qt[1026].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1026].id, qt[1026].name)
  end
  if qData[1035].state == 0 and GET_PLAYER_JOB1() == 2 and CHECK_ITEM_CNT(qt[1035].goal.getItem[1].id) >= qt[1035].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1035].id, qt[1035].name)
  end
  if qData[1036].state == 0 and GET_PLAYER_JOB1() == 2 and CHECK_ITEM_CNT(qt[1036].goal.getItem[1].id) >= qt[1036].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1036].id, qt[1036].name)
  end
  if qData[1027].state == 0 and GET_PLAYER_JOB1() == 3 and CHECK_ITEM_CNT(qt[1027].goal.getItem[1].id) >= qt[1027].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1027].id, qt[1027].name)
  end
  if qData[1028].state == 0 and GET_PLAYER_JOB1() == 3 and CHECK_ITEM_CNT(qt[1028].goal.getItem[1].id) >= qt[1028].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1028].id, qt[1028].name)
  end
  if qData[1037].state == 0 and GET_PLAYER_JOB1() == 3 and CHECK_ITEM_CNT(qt[1037].goal.getItem[1].id) >= qt[1037].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1037].id, qt[1037].name)
  end
  if qData[1038].state == 0 and GET_PLAYER_JOB1() == 3 and CHECK_ITEM_CNT(qt[1038].goal.getItem[1].id) >= qt[1038].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1038].id, qt[1038].name)
  end
  if qData[1029].state == 0 and GET_PLAYER_JOB1() == 4 and CHECK_ITEM_CNT(qt[1029].goal.getItem[1].id) >= qt[1029].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1029].id, qt[1029].name)
  end
  if qData[1030].state == 0 and GET_PLAYER_JOB1() == 4 and CHECK_ITEM_CNT(qt[1030].goal.getItem[1].id) >= qt[1030].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1030].id, qt[1030].name)
  end
  if qData[1039].state == 0 and GET_PLAYER_JOB1() == 4 and CHECK_ITEM_CNT(qt[1039].goal.getItem[1].id) >= qt[1039].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1039].id, qt[1039].name)
  end
  if qData[1040].state == 0 and GET_PLAYER_JOB1() == 4 and CHECK_ITEM_CNT(qt[1040].goal.getItem[1].id) >= qt[1040].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1040].id, qt[1040].name)
  end
  if qData[1031].state == 0 and GET_PLAYER_JOB1() == 5 and CHECK_ITEM_CNT(qt[1031].goal.getItem[1].id) >= qt[1031].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1031].id, qt[1031].name)
  end
  if qData[1032].state == 0 and GET_PLAYER_JOB1() == 5 and CHECK_ITEM_CNT(qt[1032].goal.getItem[1].id) >= qt[1032].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1032].id, qt[1032].name)
  end
  if qData[1041].state == 0 and GET_PLAYER_JOB1() == 5 and CHECK_ITEM_CNT(qt[1041].goal.getItem[1].id) >= qt[1041].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1041].id, qt[1041].name)
  end
  if qData[1042].state == 0 and GET_PLAYER_JOB1() == 5 and CHECK_ITEM_CNT(qt[1042].goal.getItem[1].id) >= qt[1042].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[1042].id, qt[1042].name)
  end
  if qData[1274].state == 0 and qData[1273].state == 2 and GET_PLAYER_LEVEL() >= qt[1274].needLevel then
    ADD_QUEST_BTN(qt[1274].id, qt[1274].name)
  end
  if qData[1282].state == 0 and GET_PLAYER_LEVEL() >= qt[1282].needLevel then
    ADD_QUEST_BTN(qt[1282].id, qt[1282].name)
  end
  if qData[1297].state == 0 and qData[1296].state == 2 and GET_PLAYER_LEVEL() >= qt[1297].needLevel then
    ADD_QUEST_BTN(qt[1297].id, qt[1297].name)
  end
  if qData[1298].state == 0 and qData[1297].state == 2 and GET_PLAYER_LEVEL() >= qt[1298].needLevel then
    ADD_QUEST_BTN(qt[1298].id, qt[1298].name)
  end
  if qData[2383].state == 0 and GET_PLAYER_JOB1() == 6 and CHECK_ITEM_CNT(qt[2383].goal.getItem[1].id) >= qt[2383].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2383].id, qt[2383].name)
  end
  if qData[2384].state == 0 and GET_PLAYER_JOB1() == 6 and CHECK_ITEM_CNT(qt[2384].goal.getItem[1].id) >= qt[2384].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2384].id, qt[2384].name)
  end
  if qData[2393].state == 0 and GET_PLAYER_JOB1() == 6 and CHECK_ITEM_CNT(qt[2393].goal.getItem[1].id) >= qt[2393].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2393].id, qt[2393].name)
  end
  if qData[2394].state == 0 and GET_PLAYER_JOB1() == 6 and CHECK_ITEM_CNT(qt[2394].goal.getItem[1].id) >= qt[2394].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2394].id, qt[2394].name)
  end
  if qData[2385].state == 0 and GET_PLAYER_JOB1() == 7 and CHECK_ITEM_CNT(qt[2385].goal.getItem[1].id) >= qt[2385].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2385].id, qt[2385].name)
  end
  if qData[2386].state == 0 and GET_PLAYER_JOB1() == 7 and CHECK_ITEM_CNT(qt[2386].goal.getItem[1].id) >= qt[2386].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2386].id, qt[2386].name)
  end
  if qData[2395].state == 0 and GET_PLAYER_JOB1() == 7 and CHECK_ITEM_CNT(qt[2395].goal.getItem[1].id) >= qt[2395].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2395].id, qt[2395].name)
  end
  if qData[2396].state == 0 and GET_PLAYER_JOB1() == 7 and CHECK_ITEM_CNT(qt[2396].goal.getItem[1].id) >= qt[2396].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2396].id, qt[2396].name)
  end
  if qData[2387].state == 0 and GET_PLAYER_JOB1() == 8 and CHECK_ITEM_CNT(qt[2387].goal.getItem[1].id) >= qt[2387].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2387].id, qt[2387].name)
  end
  if qData[2388].state == 0 and GET_PLAYER_JOB1() == 8 and CHECK_ITEM_CNT(qt[2388].goal.getItem[1].id) >= qt[2388].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2388].id, qt[2388].name)
  end
  if qData[2397].state == 0 and GET_PLAYER_JOB1() == 8 and CHECK_ITEM_CNT(qt[2397].goal.getItem[1].id) >= qt[2397].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2397].id, qt[2397].name)
  end
  if qData[2398].state == 0 and GET_PLAYER_JOB1() == 8 and CHECK_ITEM_CNT(qt[2398].goal.getItem[1].id) >= qt[2398].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2398].id, qt[2398].name)
  end
  if qData[2389].state == 0 and GET_PLAYER_JOB1() == 9 and CHECK_ITEM_CNT(qt[2389].goal.getItem[1].id) >= qt[2389].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2389].id, qt[2389].name)
  end
  if qData[2399].state == 0 and GET_PLAYER_JOB1() == 9 and CHECK_ITEM_CNT(qt[2399].goal.getItem[1].id) >= qt[2399].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2399].id, qt[2399].name)
  end
  if qData[2780].state == 0 and GET_PLAYER_JOB1() == 9 and CHECK_ITEM_CNT(qt[2780].goal.getItem[1].id) >= qt[2780].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2780].id, qt[2780].name)
  end
  if qData[2781].state == 0 and GET_PLAYER_JOB1() == 9 and CHECK_ITEM_CNT(qt[2781].goal.getItem[1].id) >= qt[2781].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2781].id, qt[2781].name)
  end
  if qData[2391].state == 0 and GET_PLAYER_JOB1() == 10 and CHECK_ITEM_CNT(qt[2391].goal.getItem[1].id) >= qt[2391].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2391].id, qt[2391].name)
  end
  if qData[2392].state == 0 and GET_PLAYER_JOB1() == 10 and CHECK_ITEM_CNT(qt[2392].goal.getItem[1].id) >= qt[2392].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2392].id, qt[2392].name)
  end
  if qData[2401].state == 0 and GET_PLAYER_JOB1() == 10 and CHECK_ITEM_CNT(qt[2401].goal.getItem[1].id) >= qt[2401].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2401].id, qt[2401].name)
  end
  if qData[2402].state == 0 and GET_PLAYER_JOB1() == 10 and CHECK_ITEM_CNT(qt[2402].goal.getItem[1].id) >= qt[2402].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2402].id, qt[2402].name)
  end
  if qData[2403].state == 0 and GET_PLAYER_JOB1() == 11 and CHECK_ITEM_CNT(qt[2403].goal.getItem[1].id) >= qt[2403].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2403].id, qt[2403].name)
  end
  if qData[2404].state == 0 and GET_PLAYER_JOB1() == 11 and CHECK_ITEM_CNT(qt[2404].goal.getItem[1].id) >= qt[2404].goal.getItem[1].count then
    ADD_QUEST_BTN(qt[2404].id, qt[2404].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if (qData[1023].state ~= 2 or qData[1024].state ~= 2 or qData[1033].state ~= 2 or qData[1034].state ~= 2) and GET_PLAYER_JOB1() == 1 and (CHECK_ITEM_CNT(qt[1023].goal.getItem[1].id) >= qt[1023].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1024].goal.getItem[1].id) >= qt[1024].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1033].goal.getItem[1].id) >= qt[1033].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1034].goal.getItem[1].id) >= qt[1034].goal.getItem[1].count) then
    if qData[1023].state == 1 or qData[1024].state == 1 or qData[1033].state == 1 or qData[1034].state == 1 then
      if CHECK_ITEM_CNT(qt[1023].goal.getItem[1].id) >= qt[1023].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1024].goal.getItem[1].id) >= qt[1024].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1033].goal.getItem[1].id) >= qt[1033].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1034].goal.getItem[1].id) >= qt[1034].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[1025].state ~= 2 or qData[1026].state ~= 2 or qData[1035].state ~= 2 or qData[1036].state ~= 2) and GET_PLAYER_JOB1() == 2 and (CHECK_ITEM_CNT(qt[1025].goal.getItem[1].id) >= qt[1025].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1026].goal.getItem[1].id) >= qt[1026].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1035].goal.getItem[1].id) >= qt[1035].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1036].goal.getItem[1].id) >= qt[1036].goal.getItem[1].count) then
    if qData[1025].state == 1 or qData[1026].state == 1 or qData[1035].state == 1 or qData[1036].state == 1 then
      if CHECK_ITEM_CNT(qt[1025].goal.getItem[1].id) >= qt[1025].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1026].goal.getItem[1].id) >= qt[1026].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1035].goal.getItem[1].id) >= qt[1035].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1036].goal.getItem[1].id) >= qt[1036].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[1027].state ~= 2 or qData[1028].state ~= 2 or qData[1037].state ~= 2 or qData[1038].state ~= 2) and GET_PLAYER_JOB1() == 3 and (CHECK_ITEM_CNT(qt[1027].goal.getItem[1].id) >= qt[1027].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1028].goal.getItem[1].id) >= qt[1028].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1037].goal.getItem[1].id) >= qt[1037].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1038].goal.getItem[1].id) >= qt[1038].goal.getItem[1].count) then
    if qData[1027].state == 1 or qData[1028].state == 1 or qData[1037].state == 1 or qData[1038].state == 1 then
      if CHECK_ITEM_CNT(qt[1027].goal.getItem[1].id) >= qt[1027].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1028].goal.getItem[1].id) >= qt[1028].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1037].goal.getItem[1].id) >= qt[1037].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1038].goal.getItem[1].id) >= qt[1038].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[1029].state ~= 2 or qData[1030].state ~= 2 or qData[1039].state ~= 2 or qData[1040].state ~= 2) and GET_PLAYER_JOB1() == 4 and (CHECK_ITEM_CNT(qt[1029].goal.getItem[1].id) >= qt[1029].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1030].goal.getItem[1].id) >= qt[1030].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1039].goal.getItem[1].id) >= qt[1039].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1040].goal.getItem[1].id) >= qt[1040].goal.getItem[1].count) then
    if qData[1029].state == 1 or qData[1030].state == 1 or qData[1039].state == 1 or qData[1040].state == 1 then
      if CHECK_ITEM_CNT(qt[1029].goal.getItem[1].id) >= qt[1029].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1030].goal.getItem[1].id) >= qt[1030].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1039].goal.getItem[1].id) >= qt[1039].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1040].goal.getItem[1].id) >= qt[1040].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[1031].state ~= 2 or qData[1032].state ~= 2 or qData[1041].state ~= 2 or qData[1042].state ~= 2) and GET_PLAYER_JOB1() == 5 and (CHECK_ITEM_CNT(qt[1031].goal.getItem[1].id) >= qt[1031].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1032].goal.getItem[1].id) >= qt[1032].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1041].goal.getItem[1].id) >= qt[1041].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1042].goal.getItem[1].id) >= qt[1042].goal.getItem[1].count) then
    if qData[1031].state == 1 or qData[1032].state == 1 or qData[1041].state == 1 or qData[1042].state == 1 then
      if CHECK_ITEM_CNT(qt[1031].goal.getItem[1].id) >= qt[1031].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1032].goal.getItem[1].id) >= qt[1032].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1041].goal.getItem[1].id) >= qt[1041].goal.getItem[1].count or CHECK_ITEM_CNT(qt[1042].goal.getItem[1].id) >= qt[1042].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1274].state ~= 2 and qData[1273].state == 2 and GET_PLAYER_LEVEL() >= qt[1274].needLevel then
    if qData[1274].state == 1 then
      if CHECK_ITEM_CNT(qt[1274].goal.getItem[1].id) >= qt[1274].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1282].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1282].needLevel then
    if qData[1282].state == 1 then
      if CHECK_ITEM_CNT(qt[1282].goal.getItem[1].id) >= qt[1282].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1296].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1297].state ~= 2 and qData[1296].state == 2 and GET_PLAYER_LEVEL() >= qt[1297].needLevel then
    if qData[1297].state == 1 then
      if CHECK_ITEM_CNT(qt[1297].goal.getItem[1].id) >= qt[1297].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1298].state ~= 2 and qData[1297].state == 2 and GET_PLAYER_LEVEL() >= qt[1298].needLevel then
    if qData[1298].state == 1 then
      if CHECK_ITEM_CNT(qt[1298].goal.getItem[1].id) >= qt[1298].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[2383].state ~= 2 or qData[2384].state ~= 2 or qData[2393].state ~= 2 or qData[2394].state ~= 2) and GET_PLAYER_JOB1() == 6 and (CHECK_ITEM_CNT(qt[2383].goal.getItem[1].id) >= qt[2383].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2384].goal.getItem[1].id) >= qt[2384].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2393].goal.getItem[1].id) >= qt[2393].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2394].goal.getItem[1].id) >= qt[2394].goal.getItem[1].count) then
    if qData[2383].state == 1 or qData[2384].state == 1 or qData[2393].state == 1 or qData[2394].state == 1 then
      if CHECK_ITEM_CNT(qt[2383].goal.getItem[1].id) >= qt[2383].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2384].goal.getItem[1].id) >= qt[2384].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2393].goal.getItem[1].id) >= qt[2393].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2394].goal.getItem[1].id) >= qt[2394].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[2385].state ~= 2 or qData[2386].state ~= 2 or qData[2395].state ~= 2 or qData[2396].state ~= 2) and GET_PLAYER_JOB1() == 7 and (CHECK_ITEM_CNT(qt[2385].goal.getItem[1].id) >= qt[2385].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2386].goal.getItem[1].id) >= qt[2386].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2395].goal.getItem[1].id) >= qt[2395].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2396].goal.getItem[1].id) >= qt[2396].goal.getItem[1].count) then
    if qData[2385].state == 1 or qData[2386].state == 1 or qData[2395].state == 1 or qData[2396].state == 1 then
      if CHECK_ITEM_CNT(qt[2385].goal.getItem[1].id) >= qt[2385].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2386].goal.getItem[1].id) >= qt[2386].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2395].goal.getItem[1].id) >= qt[2395].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2396].goal.getItem[1].id) >= qt[2396].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[2387].state ~= 2 or qData[2388].state ~= 2 or qData[2397].state ~= 2 or qData[2398].state ~= 2) and GET_PLAYER_JOB1() == 8 and (CHECK_ITEM_CNT(qt[2387].goal.getItem[1].id) >= qt[2387].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2388].goal.getItem[1].id) >= qt[2388].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2397].goal.getItem[1].id) >= qt[2397].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2398].goal.getItem[1].id) >= qt[2398].goal.getItem[1].count) then
    if qData[2387].state == 1 or qData[2388].state == 1 or qData[2397].state == 1 or qData[2398].state == 1 then
      if CHECK_ITEM_CNT(qt[2387].goal.getItem[1].id) >= qt[2387].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2388].goal.getItem[1].id) >= qt[2388].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2397].goal.getItem[1].id) >= qt[2397].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2398].goal.getItem[1].id) >= qt[2398].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[2389].state ~= 2 or qData[2399].state ~= 2 or qData[2780].state ~= 2 or qData[2781].state ~= 2) and GET_PLAYER_JOB1() == 9 and (CHECK_ITEM_CNT(qt[2389].goal.getItem[1].id) >= qt[2389].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2399].goal.getItem[1].id) >= qt[2399].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2780].goal.getItem[1].id) >= qt[2780].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2781].goal.getItem[1].id) >= qt[2781].goal.getItem[1].count) then
    if qData[2389].state == 1 or qData[2399].state == 1 or qData[2780].state == 1 or qData[2781].state == 1 then
      if CHECK_ITEM_CNT(qt[2389].goal.getItem[1].id) >= qt[2389].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2399].goal.getItem[1].id) >= qt[2399].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2780].goal.getItem[1].id) >= qt[2780].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2781].goal.getItem[1].id) >= qt[2781].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[2391].state ~= 2 or qData[2392].state ~= 2 or qData[2401].state ~= 2 or qData[2402].state ~= 2) and GET_PLAYER_JOB1() == 10 and (CHECK_ITEM_CNT(qt[2391].goal.getItem[1].id) >= qt[2391].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2392].goal.getItem[1].id) >= qt[2392].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2401].goal.getItem[1].id) >= qt[2401].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2402].goal.getItem[1].id) >= qt[2402].goal.getItem[1].count) then
    if qData[2391].state == 1 or qData[2392].state == 1 or qData[2401].state == 1 or qData[2402].state == 1 then
      if CHECK_ITEM_CNT(qt[2391].goal.getItem[1].id) >= qt[2391].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2392].goal.getItem[1].id) >= qt[2392].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2401].goal.getItem[1].id) >= qt[2401].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2402].goal.getItem[1].id) >= qt[2402].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if (qData[2403].state ~= 2 or qData[2404].state ~= 2) and GET_PLAYER_JOB1() == 11 and (CHECK_ITEM_CNT(qt[2403].goal.getItem[1].id) >= qt[2403].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2404].goal.getItem[1].id) >= qt[2404].goal.getItem[1].count) then
    if qData[2403].state == 1 or qData[2404].state == 1 then
      if CHECK_ITEM_CNT(qt[2403].goal.getItem[1].id) >= qt[2403].goal.getItem[1].count or CHECK_ITEM_CNT(qt[2404].goal.getItem[1].id) >= qt[2404].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
