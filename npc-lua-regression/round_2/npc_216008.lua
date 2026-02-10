function npcsay(id)
  if id ~= 4216008 then
    return
  end
  clickNPCid = id
  NPC_SAY("œ÷‘⁄Œ“÷ª”–’‚–©¡À£¨œÎ¬ÚæÕ¬Ú∞…°£")
  if qData[1011].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1011].goal.getItem) then
      NPC_SAY("’ÊÃ´∏––ªƒ˙µƒ∞Ô√¶¡À°£Œ“ƒ‹±®¥µƒæÕ÷ª”–’‚–©¡À")
      SET_QUEST_STATE(1011, 2)
      return
    else
      NPC_SAY("ªπ≤ªπª{0xFFFFFF00}50∏ˆ∆∆æ…÷·ª≠{END}√¥£ø")
      return
    end
  end
  if qData[1012].state == 1 then
    NPC_SAY("√ª ±º‰¡À°£øÏ“ªµ„∂˘")
    return
  end
  if qData[2354].state == 1 and qData[2354].meetNpc[1] ~= id then
    NPC_SAY("¿ß¡ˆºˆ¥‘¿ª √£¥¬¥Ÿ∞Ìø‰? ±€ΩÍø‰. ∫∏Ω√¥¬ πŸøÕ ∞∞¿Ã ø©±‚¥¬ ¿˙∏¶ ∆˜«‘«ÿº≠ ººªÁ∂˜ª”¿‘¥œ¥Ÿ.")
    SET_MEETNPC(2354, 1, id)
  end
  if qData[2419].state == 1 then
    NPC_SAY("¿Ã ø‹¡¯ ∞˜ø° æÓ¬Ó ªÁ∂˜¿Ã ¥Ÿ √£æ∆ø‘¥¬∞Ì?")
    SET_QUEST_STATE(2419, 2)
    return
  end
  if qData[2420].state == 1 then
    NPC_SAY("πË∏¶ ∞Ì√ƒæﬂ µÀ¥œ¥Ÿ. »≠¬˜∑˚¿ª ≈ƒ°«œ∞Ì {0xFFFFFF00}±◊¿ª∏∞≥™π´¡∂∞¢ 30∞≥{END}∏¶ ±∏«ÿº≠ ªÁ∞¯¥‘≤≤ ¿¸«ÿµÂ∏Æººø‰.")
  end
  if qData[2422].state == 1 then
    NPC_SAY("∞°¿Â ∞°±ÓøÓ ∞˜¿∫ {0xFFFFFF00}∞Ì∂Ù√Ã¿«ø¯¥‘¿Ã ∞ËΩ√¥¬ ∞Ì∂Ù√Ã¿‘¥œ¥Ÿ.{END}")
  end
  if qData[2439].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[2439].goal.getItem) then
      NPC_SAY("∞®ªÁ«’¥œ¥Ÿ.")
      SET_QUEST_STATE(2439, 2)
      return
    else
      NPC_SAY("±Õ¡÷µµø°º≠∏∏ ≥™¥¬ π∞∞«µÈ¿‘¥œ¥Ÿ. {0xFFFFFF00}»Ê«œµøµŒ∞≥∞Ò∞˙ ø¯«¸ª¿¡∂∞¢¿ª 10∞≥æø{END} ±∏«ÿ¡÷Ω√∏È µÀ¥œ¥Ÿ. »Ê«œµøµŒ∞≥∞Ò¿∫ »Ê«œµø¿ª, ø¯«¸ª¿¡∂∞¢¿∫ √À¿Ω¿ª ≈ƒ°«œ∞Ì æÚ¿ª ºˆ ¿÷Ω¿¥œ¥Ÿ.")
    end
  end
  if qData[2440].state == 1 then
    if CHECK_ITEM_CNT(qt[2440].goal.getItem[1].id) >= qt[2440].goal.getItem[1].count then
      NPC_SAY("∞®ªÁ«’¥œ¥Ÿ.")
      SET_QUEST_STATE(2440, 2)
      return
    else
      NPC_SAY("±Õ¡÷µµø° ∞°º≈º≠ {0xFFFFFF00}»Ê«œµøµŒ∞≥∞Ò¿ª 70∞≥{END}∏∏ ±∏«ÿ¡÷ººø‰. »Ê«œµøµŒ∞≥∞Ò¿∫ »Ê«œµø¿ª ≈ƒ°«œ∞Ì æÚ¿ª ºˆ ¿÷Ω¿¥œ¥Ÿ.")
    end
  end
  if qData[2441].state == 1 then
    if CHECK_ITEM_CNT(qt[2441].goal.getItem[1].id) >= qt[2441].goal.getItem[1].count then
      NPC_SAY("∞®ªÁ«’¥œ¥Ÿ. ±∏«ÿ¡÷Ω≈ ±Õ¡÷µµ¿« π∞∞«µÈ¿∫ ¿ﬂ æ≤∞⁄Ω¿¥œ¥Ÿ.")
      SET_QUEST_STATE(2441, 2)
      return
    else
      NPC_SAY("±Õ¡÷µµø° ∞°º≈º≠ √À¿Ω¿ª ≈ƒ°«œ∞Ì {0xFFFFFF00}ø¯«¸ª¿¡∂∞¢ 70∞≥{END}∏∏ ±∏«ÿ¡÷ººø‰.")
    end
  end
  if qData[2489].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("ø¿∑£∏∏ø° ∫ÀΩ¿¥œ¥Ÿ. π´Ωº ¿œ∑Œ ø¿ºÃ≥™ø‰?")
      SET_QUEST_STATE(2489, 2)
      return
    else
      NPC_SAY("«‡≥∂¿Ã ≥ π´ π´∞ÃΩ¿¥œ¥Ÿ!")
    end
  end
  if qData[2490].state == 1 then
    if CHECK_ITEM_CNT(qt[2490].goal.getItem[1].id) >= qt[2490].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("¡¡Ω¿¥œ¥Ÿ. πŸ∑Œ ªÛ¿⁄∏¶ ºˆ∏Æ«œ∞⁄Ω¿¥œ¥Ÿ.")
        SET_QUEST_STATE(2490, 2)
        return
      else
        NPC_SAY("«‡≥∂¿Ã ≥ π´ π´∞ÃΩ¿¥œ¥Ÿ!")
      end
    else
      NPC_SAY("{0xFFFFFF00}ªÔ∞≠µø¿¸µÓª‘¿∫ »Ê±Õ¡÷ø¯ø°º≠ ªÔ∞≠µø¿¸¿ª ≈ƒ°«œ∏È{END} ±∏«“ ºˆ ¿÷Ω¿¥œ¥Ÿ. {0xFFFFFF00}ªÔ∞≠µø¿¸µÓª‘ 50∞≥{END}∏¶ ±∏«ÿ¡÷ººø‰.")
    end
  end
  if qData[2491].state == 1 then
    if CHECK_ITEM_CNT(qt[2491].goal.getItem[1].id) >= qt[2491].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("æÓµ.. ∏¬±∫ø‰. ¡¶∞° ¡ﬂ»≠Ω√≈∞∞⁄Ω¿¥œ¥Ÿ.")
        SET_QUEST_STATE(2491, 2)
        return
      else
        NPC_SAY("«‡≥∂¿Ã ≥ π´ π´∞ÃΩ¿¥œ¥Ÿ!")
      end
    else
      NPC_SAY("{0xFFFFFF00}ªÁ∫¿±Õµ∂ƒß¿∫ πÈ±Õ¡÷ø¯ø°º≠ ªÁ∫¿±Õ∏¶ ≈ƒ°«œ∏È{END} ±∏«“ ºˆ ¿÷Ω¿¥œ¥Ÿ. {0xFFFFFF00}ªÁ∫¿±Õµ∂ƒß 70∞≥{END}∏¶ ±∏«ÿ¡÷ººø‰.")
    end
  end
  if qData[2492].state == 1 then
    if CHECK_ITEM_CNT(qt[2492].goal.getItem[1].id) >= qt[2492].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2492].goal.getItem[2].id) >= qt[2492].goal.getItem[2].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("æÓµ.. ∏¬±∫ø‰.")
        SET_QUEST_STATE(2492, 2)
        return
      else
        NPC_SAY("«‡≥∂¿Ã ≥ π´ π´∞ÃΩ¿¥œ¥Ÿ!")
      end
    else
      NPC_SAY("{0xFFFFFF00}»Ê±Õ¡÷ø¯ø°º≠ ¿∞æ»±Õ{END}∏¶ ≈ƒ°«œ∞Ì {0xFFFFFF00}¿∞æ»±Õºˆæ◊ 50∞≥{END}∏¶, {0xFFFFFF00}»Ê±Õ«˜∑Œø°º≠ ≈∫¡÷æÓ{END}∏¶ ≈ƒ°«œ∞Ì {0xFFFFFF00}≈∫¡÷æÓª°∆« 50∞≥{END}∏¶ ±∏«ÿ¡÷ººø‰.")
    end
  end
  if qData[2493].state == 1 then
    if CHECK_ITEM_CNT(qt[2493].goal.getItem[1].id) >= qt[2493].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(4) then
        NPC_SAY("¡¡Ω¿¥œ¥Ÿ. ¿Ã¡¶ ∏µÁ ¡ÿ∫Ò∞° ≥°≥µΩ¿¥œ¥Ÿ. ø©±‚ {0xFFFFFF00}±∏±ﬁæ‡ªÛ¿⁄{END}¿‘¥œ¥Ÿ.")
        SET_QUEST_STATE(2493, 2)
      else
        NPC_SAY("«‡≥∂¿Ã ≥ π´ π´∞ÃΩ¿¥œ¥Ÿ!")
      end
    else
      NPC_SAY("{0xFFFFFF00}»Ê±Õ«˜∑Œø°º≠ ªÁ∑Ê{END}¿ª ≈ƒ°«œΩ√∞Ì {0xFFFFFF00}ªÁ∑Êºˆø∞{END}¿ª 35∞≥∏¶ ±∏«ÿø¿Ω√∏È µÀ¥œ¥Ÿ.")
    end
  end
  if qData[3666].state == 1 then
    if CHECK_ITEM_CNT(qt[3666].goal.getItem[1].id) >= qt[3666].goal.getItem[1].count then
      NPC_SAY("–ª–ª£°")
      SET_QUEST_STATE(3666, 2)
      return
    else
      NPC_SAY("∞Ô√¶ ’ºØ{0xFFFFFF00}ª¢Õ∑…ﬂπ÷{END}µƒ{0xFFFFFF00}60∏ˆπ÷“Ïµƒª¢∆§{END}ªÿ¿¥∞…")
    end
  end
  if qData[3667].state == 1 then
    if CHECK_ITEM_CNT(qt[3667].goal.getItem[1].id) >= qt[3667].goal.getItem[1].count then
      NPC_SAY("–ª–ª£°")
      SET_QUEST_STATE(3667, 2)
      return
    else
      NPC_SAY("∞Ô√¶ ’ºØ{0xFFFFFF00}÷·ª≠—˝≈Æ{END}µƒ{0xFFFFFF00}60∏ˆ∆∆æ…÷·ª≠{END}ªÿ¿¥∞…")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10035)
  if qData[1011].state == 0 then
    ADD_QUEST_BTN(qt[1011].id, qt[1011].name)
  end
  if qData[1012].state == 0 then
    ADD_QUEST_BTN(qt[1012].id, qt[1012].name)
  end
  if qData[3666].state == 0 and GET_PLAYER_LEVEL() >= qt[3666].needLevel then
    ADD_QUEST_BTN(qt[3666].id, qt[3666].name)
  end
  if qData[3667].state == 0 and GET_PLAYER_LEVEL() >= qt[3667].needLevel then
    ADD_QUEST_BTN(qt[3667].id, qt[3667].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1011].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1011].needLevel then
    if qData[1011].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1011].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1012].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1012].needLevel then
    if qData[1012].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3666].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3666].needLevel then
    if qData[3666].state == 1 then
      if CHECK_ITEM_CNT(qt[3666].goal.getItem[1].id) >= qt[3666].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3667].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3667].needLevel then
    if qData[3667].state == 1 then
      if CHECK_ITEM_CNT(qt[3667].goal.getItem[1].id) >= qt[3667].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
