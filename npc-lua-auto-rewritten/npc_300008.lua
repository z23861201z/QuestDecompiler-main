function npcsay(id)
  if id ~= 4300008 then
    return
  end
  clickNPCid = id
  if qData[716].state == 1 then
    SET_MEETNPC(716, 1, id)
    NPC_SAY("Õâ´Î¾Í·Å¹ýÄã¡£²»ÄÜÖ¤Ã÷¾Íµ±ÄãÊÇÀ¼Ã¹½³µÄÊÖÏÂ£¬»áÑÏÀ÷´¦ÖÃ£¡(µÃÈ¥ÕÒ{0xFFFFFF00}[×¡³Ö]{END}°ïÃ¦¡£)")
  end
  if qData[718].state == 1 and CHECK_ITEM_CNT(qt[718].goal.getItem[1].id) >= qt[718].goal.getItem[1].count then
    NPC_SAY("Äã»¹»ØÀ´£¿ÓÂÆø¿É¼Î°¡¡£ÄãÐ¡×ÓËµÒªÖ¤Ã÷µÄ¾ÍÊÇÕâ¸öÂð£¿")
    SET_QUEST_STATE(718, 2)
  end
  if qData[719].state == 1 then
    if CHECK_ITEM_CNT(qt[719].goal.getItem[1].id) >= qt[719].goal.getItem[1].count then
      NPC_SAY("ÕæµÄÄÃÀ´ÁË°¡¡­¡£ÄÇ¾ÍÊÇËµÉúËÀÖ®ËþµÄ·âÓ¡½â¿ªÁË£¡")
      SET_QUEST_STATE(719, 2)
    else
      NPC_SAY("»¹Ã»ÄÃÀ´Âð£¿Èç¹ûÄãµÄ»°²»ÊÇ¼ÙµÄ£¬¾ÍÈ¥{0xFFFFFF00}[ÉúËÀÖ®Ëþ]{END}»÷ÍËºìÊ÷Ñý£¬ÊÕ¼¯{0xFFFFFF00}30¸ö[ºìÊ÷ÉúËÀÒº]{END}»ØÀ´°É¡£")
    end
  end
  if qData[720].state == 1 then
    NPC_SAY("ÔõÃ´ÑùÁË£¿{0xFFFFFF00}[µÚÒ»ËÂ]µÄ[×¡³Ö{END}ÓÐÊ²Ã´Ãî¼ÆÂð£¿")
  end
  if qData[723].state == 1 then
    NPC_SAY("ºÇºÇ¡­¡£ÊÇÄãÂð£¿¸Õ²ÅÒ²ÓÐÀ¼Ã¹½³µÄÊÖÏÂÈëÇÖ£¬¸øµ²»ØÈ¥ÁË¡£ÓÐÏûÏ¢ÁËÂð£¿")
    SET_QUEST_STATE(723, 2)
  end
  if qData[724].state == 1 then
    if CHECK_ITEM_CNT(qt[724].goal.getItem[1].id) >= qt[724].goal.getItem[1].count and CHECK_ITEM_CNT(qt[724].goal.getItem[2].id) >= qt[724].goal.getItem[2].count and CHECK_ITEM_CNT(qt[724].goal.getItem[3].id) >= qt[724].goal.getItem[3].count then
      NPC_SAY("ÊµÁ¦ºÜ³öÖÚ°¡¡£Ö»ÒªÕâ×´¿öÄÜ½áÊø£¬Ò»¶¨»áºÃºÃ±¨´ðµÄ¡£")
      SET_QUEST_STATE(724, 2)
    else
      NPC_SAY("{0xFFFFFF00}[ÑÖÂÞ·þ(ÄÐ)]{END}µÃÔÚÍ¬ÁÅ´¦»ñµÃ»òÕß´ò¹Ö»ñµÃ¡£ÄãÄÜÄÃÀ´ {0xFFFFFF00}[ÑÖÂÞ·þ(ÄÐ)]ºÍ10¸ö[ÖñÒ¶Çà¾Æ]£¬10¸ö[Å£Èâ¸¬]{END}£¬¾Í»á±¨´ðÄãµÄ¡£")
    end
  end
  if qData[1457].state == 1 then
    NPC_SAY("ÕÒµ½Çïß¶ÓãÊ¦ÐÖÁË£¿ÍòÐÒ°¡¡£ÍòÐÒ°¡¡­¡£")
    SET_QUEST_STATE(1457, 2)
  end
  if qData[1458].state == 1 then
    NPC_SAY("ººÚÓÀ­±ÈÉÌÈËÔÚÒì½çÃÅÀï¡£È¥ÕÒËûÌýÌýÏêÏ¸µÄÄÚÈÝ°É¡£")
    return
  end
  if qData[2189].state == 1 then
    NPC_SAY("¿Ô´Â°¡. ÀÚ³×°¡ Ãµ¼ö¿äÈ­¸¦ ÅðÄ¡Çß´Ù´Â ¼Ò½ÄÀ» µè°í ´Ù½ÃÇÑ¹ø º¸°í ½Í¾î¼­ ±»ÀÌ ÀÚ³×¸¦ ºÒ·¶³×.")
    SET_QUEST_STATE(2189, 2)
    return
  end
  if qData[2190].state == 1 then
    if CHECK_ITEM_CNT(qt[2190].goal.getItem[1].id) >= qt[2190].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2190].goal.getItem[2].id) >= qt[2190].goal.getItem[2].count then
      NPC_SAY("¼ö°íÇß³×. ±Ùµ¥ ´Ù¸¥ ºÎÅ¹À» Á» ÇØ¾ß°Ú´Âµ¥? ´Ù½Ã ¸»À» Á» °É¾îÁÖ°Ô³ª.")
      SET_QUEST_STATE(2190, 2)
      return
    else
      NPC_SAY("³» ¹ÏÀ» »ç¶÷Àº ÀÚ³×¹Û¿¡ ¾ø´Ù³×. ÀÏ´Ü, ÃµÀ½¼±±³ ÂÊ¿¡ {0xFFFFFF00}¼³³à{END}¿Í {0xFFFFFF00}ºù±ØÀÎ{END}À» ÅðÄ¡ÇÏ°í ±× ÁõÇ¥·Î {0xFFFFFF00}ºùÈ­{END}¿Í {0xFFFFFF00}°íµå¸§{END}À» {0xFFFFFF00}20°³¾¿{END}°¡Áö°í ¿À°Ô.")
    end
  end
  if qData[2191].state == 1 then
    NPC_SAY("ÃµÀ½»çÀÇ ÁÖÁö½º´Ô²² °¡¼­ ¾Ë¾ÆºÁÁÖ±æ ¹Ù¶ó³×.")
  end
  if qData[2195].state == 1 then
    NPC_SAY("À½. ¿Ô´Â°¡ ÀÚ³×. ¾îÀÕ. Çã..ÇãÇãÇã~ ¾Æ´Ï ÀÚ³× ÀÌ°Ô ¹«½¼ÁþÀÎ°¡?")
    SET_QUEST_STATE(2195, 2)
    return
  end
  if qData[2196].state == 1 then
    NPC_SAY("(¿î±âÁ¶½Ä ÁßÀÌ´Ù. ¹æÇØÇÏÁö ¸»ÀÚ.)")
  end
  if qData[2197].state == 1 and CHECK_ITEM_CNT(qt[2197].goal.getItem[1].id) >= qt[2197].goal.getItem[1].count then
    NPC_SAY("Çä ÀÌ ³¿»õ!! ÀÌ°ÍÀÌ ºñ±«¾îÅÁÀÌ¶ó´Â °Ç°¡. (²Ü²©²Ü²©) À¸À¹!!!")
    SET_QUEST_STATE(2197, 2)
    return
  end
  if qData[2198].state == 1 then
    if qData[2198].killMonster[qt[2198].goal.killMonster[1].id] >= qt[2198].goal.killMonster[1].count then
      NPC_SAY("ÀÌÁ¦ Á» Á¶¿ëÇÏ±¸¸¸. ¼ö°íÇß³×.")
      SET_QUEST_STATE(2198, 2)
      return
    else
      NPC_SAY("Á¶¿ëÈ÷ ¿î±âÁ¶½ÄÀ» ÇÒ ¼ö ÀÖ°Ô ±× ½Ã²ô·¯¿î µ¿ÀÚ¼± 30¸¶¸® Á¤µµ¸¸ ÅðÄ¡ ÇØÁÖ°Ô³ª.")
    end
  end
  if qData[2199].state == 1 then
    NPC_SAY("ÇÑ¾ß¼º¿¡ °¡¼­ ³» ¼Ò½ÄÀ» °íÀÌ¿¬¿¡°Ô ÀüÇÏ°í Á» µµ¿ÍÁÖ°í ¿À°Ô³ª.")
  end
  if qData[2206].state == 1 then
    NPC_SAY("ÀÌÁ¦ ¿À´Â°Ç°¡. ±×·¡, ÀßÁö³»°í ÀÖ±º. ¿ª½Ã ³» ¼ÕÁÖ ´ä±º.")
    SET_QUEST_STATE(2206, 2)
    return
  end
  if qData[2207].state == 1 then
    if qData[2207].killMonster[qt[2207].goal.killMonster[1].id] >= qt[2207].goal.killMonster[1].count then
      NPC_SAY("½ÊÀÌ¿äÁøÀ» »ó´ëÇÏ±â´Â ¾ÆÁ÷ ±îÁö ¸öÀÌ ¿Ã¶ó¿ÀÁö ¾ÊÀº°Í °°±º,")
      SET_QUEST_STATE(2207, 2)
      return
    else
      NPC_SAY("³»°¡ ±× ¸¶¹°À» »ó´ëÇÒ ¼ö ÀÖÀ»Áö ÀÚ³×°¡ ½ÊÀÌ¿äÁøÀ» 1¸¶¸® ÅðÄ¡ÇÏ°í ¿À°Ô³ª.")
    end
  end
  if qData[2208].state == 1 then
    if CHECK_ITEM_CNT(qt[2208].goal.getItem[1].id) >= qt[2208].goal.getItem[1].count then
      NPC_SAY("½ÊÀÌ¿äÁøºÎÀû 1Àå, 2Àå¡¦ 5Àå À½. ¸Â±º. ÀÌÁ¦ ÈÆ·ÃÀ» ÇØº¼±î. ÀÌ¾å!!!")
      SET_QUEST_STATE(2208, 2)
      return
    else
      NPC_SAY("½ÊÀÌ¿äÁøÀÇ ºÎÀû¸¸ ÀÖ´Ù¸é ¾àÈ­µÈ ½ÊÀÌ¿äÁøÀ» ¼ÒÈ¯ÇÒ ¼ö ÀÖ³×. ÀÚ³×°¡ ½ÊÀÌ¿äÁøºÎÀûÀ» 5°³ Á¤µµ ±¸ÇØ¿ÍÁÖ°Ú³ª.")
    end
  end
  if qData[2209].state == 1 then
    NPC_SAY("ÀÌÁ¦ ÈÆ·ÃÀ» ½ÃÀÛÇØ º¼±î?")
    SET_QUEST_STATE(2209, 2)
    return
  end
  if qData[2210].state == 1 then
    if CHECK_ITEM_CNT(qt[2210].goal.getItem[1].id) >= qt[2210].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2210].goal.getItem[2].id) >= qt[2210].goal.getItem[2].count then
      NPC_SAY("ÁÁ¾Æ. ¼ö°íÇß³×. ÀÚ, ´ÙÀ½ ´Ü°è·Î ³Ñ¾î°¡µµ·Ï ÇÏÁö.")
      SET_QUEST_STATE(2210, 2)
      return
    else
      NPC_SAY("ÃµÀ½¼±±³·Î °¡¼­ ¼³³à¿Í ºù±ØÀÎÀ» ÅðÄ¡ÇÏ°í ºùÈ­¿Í °íµå¸§À» °¢°¢ 50°³¾¿ °¡Á®¿À±æ ¹Ù¶õ´Ù. ½Ç½Ã!!!")
    end
  end
  if qData[2211].state == 1 then
    if CHECK_ITEM_CNT(qt[2211].goal.getItem[1].id) >= qt[2211].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2211].goal.getItem[2].id) >= qt[2211].goal.getItem[2].count then
      NPC_SAY("ÁÁ¾Æ. ¼ö°íÇß³×. ÀÌÁ¦ ¸¶Áö¸· ´Ü°è·Î ³Ñ¾î°¡µµ·Ï ÇÏÁö.")
      SET_QUEST_STATE(2211, 2)
      return
    else
      NPC_SAY("ºñ±«¾î¿Í µ¿ÀÚ¼±À» ÅðÄ¡ÇÏ°í Áö´À·¯¹Ì¿Í ¼Ò°í¸¦ °¢°¢ 50°³¾¾ °¡Á®¿À±æ ¹Ù¶õ´Ù ½Ç½Ã!!")
    end
  end
  if qData[2212].state == 1 then
    if CHECK_ITEM_CNT(qt[2212].goal.getItem[1].id) >= qt[2212].goal.getItem[1].count then
      NPC_SAY("ÁÁ¾Æ. ¼ö°íÇß³×. ³»°¡ °¡¸£ÃÄ ÁÙ ¼ö ÀÖ´Â°Ç ¿©±â±îÁöÀÎ°Í °°±º.")
      SET_QUEST_STATE(2212, 2)
      return
    else
      NPC_SAY("Ãµµµ½ÅÀ» ÅðÄ¡ÇÏ°í Ãµµµº¹¼þ¾Æ 100°³¸¦ °¡Áö°í ¿Àµµ·Ï! ½Ç½Ã!!")
    end
  end
  if qData[2213].state == 1 then
    if qData[2213].killMonster[qt[2213].goal.killMonster[1].id] >= qt[2213].goal.killMonster[1].count and CHECK_ITEM_CNT(qt[2213].goal.getItem[1].id) >= qt[2213].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2213].goal.getItem[2].id) >= qt[2213].goal.getItem[2].count and CHECK_ITEM_CNT(qt[2213].goal.getItem[3].id) >= qt[2213].goal.getItem[3].count and CHECK_ITEM_CNT(qt[2213].goal.getItem[4].id) >= qt[2213].goal.getItem[4].count and CHECK_ITEM_CNT(qt[2213].goal.getItem[5].id) >= qt[2213].goal.getItem[5].count then
      NPC_SAY("ÁÁ¾Æ. ¼ö°íÇß³×. ÀÌÁ¦ Á¤¸» ¸¶Áö¸·ÀÌ±º. ¾ÕÀ¸·Î ³ª¾Æ°¡´Â ÀÚ³×ÀÇ ¾Õ¿¡ ³õÀÎ Àå¾Ö¹°À» µÎ·Á¿öÇÏÁö ¸»°Ô³ª. µÎ·Á¿òÀÌ¾ß ¸»·Î ÀÚ½ÅÀÇ ¼ºÀåÀ» ¹æÇØÇÏ´Â °¡Àå Å« ÀûÀÏ¼¼.")
      SET_QUEST_STATE(2213, 2)
      return
    else
      NPC_SAY("½ÊÀÌ¿äÁøÀ» 2¸¶¸® ÅðÄ¡ÇÏ°í ºùÈ­, °íµå¸§, Áö´À·¯¹Ì, ¼Ò°í, Ãµµµº¹¼þ¾Æ °¢°¢ 30°³¸¦ °¡Áö°í µ¹¾Æ¿Àµµ·Ï.")
    end
  end
  if qData[2214].state == 1 then
    NPC_SAY("¾Ë°Ú³×. ¾Ë°Ú¾î. ¹¹°¡ ±×¸® ±ÞÇÑ°¡?")
    SET_QUEST_STATE(2214, 2)
    return
  end
  if qData[2215].state == 1 then
    if qData[2215].killMonster[qt[2215].goal.killMonster[1].id] >= qt[2215].goal.killMonster[1].count then
      NPC_SAY("ÀßÇß±º! Á¤¸» ¼ö°íÇß³×.")
      SET_QUEST_STATE(2215, 2)
      return
    else
      NPC_SAY("Æí¸¶±Í 50¸¶¸®¶ó³×. Èûµé´õ¶óµµ Á¶±Ý¸¸ ´õ ³ë·ÂÇØÁÖ°Ô.")
    end
  end
  if qData[2216].state == 1 then
    if qData[2216].killMonster[qt[2216].goal.killMonster[1].id] >= qt[2216].goal.killMonster[1].count then
      NPC_SAY("ÀÚ³× Á¤¸» ´ë´ÜÇÏ±º! ¼ö°íÇß³×.")
      SET_QUEST_STATE(2216, 2)
      return
    else
      NPC_SAY("ºÒ·®¼þ¼þÀ» °Ñ¸ð½À¸¸ º¸°í Æò°¡ÇÏÁö ¸»¶ó°í.")
    end
  end
  if qData[2217].state == 1 then
    NPC_SAY("¾ÆÁ÷ Ãâ¹ß ¾ÈÇÑ°Ç°¡? ¾î¼­ ÃµÀ½»çÀÇ ÁÖÁö½º´Ô²² °¡º¸¶ó°í.")
  end
  if qData[2222].state == 1 then
    NPC_SAY("µµÂøÇß´Â°¡? ¾Æ, ±× ¿ÊÀÌ ³ªÀÇ À§ÀåÀÛÀüÀ» À§ÇÑ ÅÐ¿ÊÀÌ±º. °í¸¿±º.")
    SET_QUEST_STATE(2222, 2)
    return
  end
  if qData[2223].state == 1 then
    NPC_SAY("ÀÌ°Í Âü ³­°¨ÇÏ±º. °©ÀÚ±â ¿Ö ÀÌ·± ÀÏÀÌ »ý±â´Â°ÅÁö?")
    SET_QUEST_STATE(2223, 2)
    return
  end
  if qData[2224].state == 1 then
    NPC_SAY("¼­µÑ·¯ Ãâ¹ßÇÏ°Ô. ¸¹ÀÌ ±ÞÇÑ ¸ð¾çÀÌ´õ¶ó°í. ³ªµµ ±ÞÇÏ°í")
  end
  if qData[2228].state == 1 then
    NPC_SAY("±×·¡. È¤½Ã¶óµµ Á» ¾Ë¾Æ³½ °ÍÀº ¾ø´Â°¡?")
    SET_QUEST_STATE(2228, 2)
    return
  end
  if qData[2229].state == 1 then
    if GET_PLAYER_LEVEL() >= 118 then
      NPC_SAY("ÀßÇß±º! ÈÇ¸¢ÇØ! ¿ª½Ã ÀÚ³×°¡ ÇØ³¾ÁÙ ¾Ë¾Ò¾î.")
      SET_QUEST_STATE(2229, 2)
      return
    else
      NPC_SAY("Á¶±Ý¸¸ ´õ ³ë·ÂÇÏ¸é µÇ°Ú±º. {0xFFFFFF00}118{END}°ø·ÂÀÌ µÇ¸é ³ª¿¡°Ô ´Ù½Ã ¸»À» °É¾îÁÖ°Ô³ª.")
    end
  end
  if qData[2230].state == 1 then
    NPC_SAY("±×´Â {0xFFFFFF00}°í¶ôÃÌ ³²ÂÊ{END}¿¡ »ê´Ù°í µé¾ú³×. ¾î¼­ Ãâ¹ßÇÏ°Ô³ª.")
  end
  if qData[2234].state == 1 then
    NPC_SAY("¿À·£¸¸ÀÌ±º. ¹«½¼ÀÏ·Î Ã£¾Æ¿Ô´Â°¡? À½? Á¶¹ÌÇâÀ¸·ÎºÎÅÍ ¼­ÂûÀÌ¶ó°í?")
    SET_QUEST_STATE(2234, 2)
    return
  end
  if qData[2235].state == 1 then
    if qData[2235].killMonster[qt[2235].goal.killMonster[1].id] >= qt[2235].goal.killMonster[1].count then
      NPC_SAY("¼ö°íÇß±º. ÀÌÁ¦ ¸¶¹°³ðµéµµ ´õ ÀÌ»óÀº ÇÔºÎ·Î ¸ø ¿òÁ÷ÀÏÅ×Áö.")
      SET_QUEST_STATE(2235, 2)
      return
    else
      NPC_SAY("Á¶±Ý¸¸ ´õ ³ë·ÂÇØÁÖ°Ô. ¿äµ¿Ä¡´ø ¸¶±â¸¦ ÀáÀç¿ï »ç¶÷ÀÌ ÀÚ³×»ÓÀÌ¶ó³×.")
    end
  end
  if qData[2236].state == 1 then
    NPC_SAY("À½? ¾ÆÁ÷ Ãâ¹ßÇÏÁö ¾Ê¾Ò´Â°¡?")
  end
  if qData[2245].state == 1 then
    NPC_SAY("ÀÌ·± ±â¸·Èù ¿ì¿¬ÀÌ ÀÖ³ª¡¦ Á¶¹ÌÇâ ±×³à°¡ ¸¶À½¿¡ µé¾îÇØÁÖ¸é ÁÁ°Ú±º.")
  end
  if qData[2249].state == 1 then
    NPC_SAY("¿Ö ÀÌÁ¦¼­¾ß ¿À´Â °Ç°¡? ±â´Ù¸®´Ù ¸ñ ºüÁö´Â ÁÙ ¾Ë¾Ò³×.")
    SET_QUEST_STATE(2249, 2)
    return
  end
  if qData[2250].state == 1 then
    if qData[2250].killMonster[qt[2250].goal.killMonster[1].id] >= qt[2250].goal.killMonster[1].count then
      NPC_SAY("±×·¡. ¾î¶»°Ô µÇ¾ú³ª?")
      SET_QUEST_STATE(2250, 2)
      return
    else
      NPC_SAY("¼­µÎ¸£°Ô. ½ÊÀÌ¿ä¹¦°¡ ¾îµð·Î ³¯¾Æ°¡¹ö¸±Áö ¸ð¸£³×.")
    end
  end
  if qData[2251].state == 1 then
    NPC_SAY("³»°¡ ÀÌ¹Ì »ç¶÷µéÀ» ÅëÇØ¼­ ½ÊÀÌ¿ä¹¦ÀÇ º»°ÅÁö¸¦ ¾îµðÀÎÁö ¾Ë¾Æ³ÂÁö.")
    SET_QUEST_STATE(2251, 2)
    return
  end
  if qData[2252].state == 1 then
    NPC_SAY("¾ÆÁ÷ Ãâ¹ß ¾È Çß³ª?")
  end
  if qData[2253].state == 1 then
    NPC_SAY("±×³É ÁÖ¿î °ÍÀÌ¶ó°í? ¾Æ¡¦ °á±¹Àº ¿©±â±îÁø°¡?")
    SET_QUEST_STATE(2253, 2)
    return
  end
  if qData[2277].state == 1 then
    NPC_SAY("¾ÆÁ÷ Ãâ¹ß ¾È Çß³ª?")
  end
  if qData[2279].state == 1 then
    NPC_SAY("»ý°¢º¸´Ù ¿À·¡°É·È±º. ±×·¡, ·ù°­ÀÌ ²Ù¹Ì´ø À½¸ð´Â ¹«¾ùÀÌ´ø°¡?")
    SET_QUEST_STATE(2279, 2)
    return
  end
  if qData[2280].state == 1 then
    NPC_SAY("¸Õ ±æ ¿À´À¶ó °í»ýÇÑ °ÍÀº ¾ËÁö¸¸, Áß´ëÇÑ »ç¾ÈÀÌ´Ï Á» ¼­µÑ·¯ÁÖ½Ã°Ô³ª.")
  end
  if qData[2323].state == 1 then
    NPC_SAY("¿À·£¸¸ÀÌ±º. ¹«½¼ ÀÏÀÎ°¡?")
    SET_QUEST_STATE(2323, 2)
    return
  end
  if qData[2324].state == 1 then
    if CHECK_ITEM_CNT(qt[2324].goal.getItem[1].id) >= qt[2324].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2324].goal.getItem[2].id) >= qt[2324].goal.getItem[2].count then
      NPC_SAY("´Ù °¡Á®¿Ô±º. ±×·³ ³» ÀÌ¾ß±â¸¦ ÇØÁÖÁö.")
      SET_QUEST_STATE(2324, 2)
      return
    else
      NPC_SAY("À§Áö¼ö »çÇü¡¦")
    end
  end
  if qData[2325].state == 1 then
    NPC_SAY("°Å±â¼­ ¹è½ÅÀÚ°¡ ³ª¿Ã ÁÙÀº¡¦")
    SET_QUEST_STATE(2325, 2)
    return
  end
  if qData[2326].state == 1 then
    NPC_SAY("Àá½Ã È¥ÀÚ ÀÖ°í ½Í±º.")
    SET_QUEST_STATE(2326, 2)
    return
  end
  if qData[2341].state == 1 then
    NPC_SAY("{0xFFFFFF00}µÎÀ§{END}´Â Áö±Ý ¿ëº´´ÜÀ» ¸¸µé¾î Á¤Ã¼¸¦ ¼û±â°í ÀÖ´Ù°í ÇÏ³×. Ã»À½°ü°ú ¾Ö¸®ÃÌ »çÀÌÀÇ {0xFFFFFF00}[¼±ÅÃÀÇ½£]{END}À¸·Î °¡º¸°Ô³ª.")
  end
  if qData[3650].state == 1 then
    if qData[3650].killMonster[qt[3650].goal.killMonster[1].id] >= qt[3650].goal.killMonster[1].count then
      NPC_SAY("ÊÀ½çºÍÆ½²»ÊÇ°×À´µÄ£¬ÊÇÏñ½ñÌìÕâÑùÒ»µãµãÖÆÔì³öÀ´µÄ")
      SET_QUEST_STATE(3650, 2)
      return
    else
      NPC_SAY("ÉÔÊÂÐÝÏ¢Ò²ÊÇÖÖºÜºÃµÄÐÞÁ¶")
    end
  end
  if qData[3651].state == 1 then
    if qData[3651].killMonster[qt[3651].goal.killMonster[1].id] >= qt[3651].goal.killMonster[1].count then
      NPC_SAY("ÊÀ½çºÍÆ½²»ÊÇ°×À´µÄ£¬ÊÇÏñ½ñÌìÕâÑùÒ»µãµãÖÆÔì³öÀ´µÄ")
      SET_QUEST_STATE(3651, 2)
      return
    else
      NPC_SAY("»áºÜÀÛµÄ£¬ÀÛµÄÊ±ºò¿ÉÒÔÊÊµ±µÄÐÝÏ¢")
    end
  end
  if qData[3652].state == 1 then
    if qData[3652].killMonster[qt[3652].goal.killMonster[1].id] >= qt[3652].goal.killMonster[1].count then
      NPC_SAY("¸Ä±äÕâ¸öÊÀ½çµÄµÚÒ»²½£¬¾ÍÊÇÏÈ¸Ä±ä×Ô¼ºµÄÖÜÎ§¡£ÐÁ¿àÁË")
      SET_QUEST_STATE(3652, 2)
      return
    else
      NPC_SAY("ÉÔÊÂÐÝÏ¢Ò²ÊÇÖÖºÜºÃµÄÐÞÁ¶")
    end
  end
  if qData[716].state == 0 and qData[715].state == 2 then
    ADD_QUEST_BTN(qt[716].id, qt[716].name)
  end
  if qData[719].state == 0 and qData[718].state == 2 then
    ADD_QUEST_BTN(qt[719].id, qt[719].name)
  end
  if qData[720].state == 0 and qData[719].state == 2 then
    ADD_QUEST_BTN(qt[720].id, qt[720].name)
  end
  if qData[724].state == 0 and qData[723].state == 2 then
    ADD_QUEST_BTN(qt[724].id, qt[724].name)
  end
  if qData[1458].state == 0 and qData[1457].state == 2 and GET_PLAYER_LEVEL() >= qt[1458].needLevel then
    ADD_QUEST_BTN(qt[1458].id, qt[1458].name)
  end
  if qData[3650].state == 0 and GET_PLAYER_LEVEL() >= qt[3650].needLevel then
    ADD_QUEST_BTN(qt[3650].id, qt[3650].name)
  end
  if qData[3651].state == 0 and GET_PLAYER_LEVEL() >= qt[3651].needLevel then
    ADD_QUEST_BTN(qt[3651].id, qt[3651].name)
  end
  if qData[3652].state == 0 and GET_PLAYER_LEVEL() >= qt[3652].needLevel then
    ADD_QUEST_BTN(qt[3652].id, qt[3652].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[716].state ~= 2 and GET_PLAYER_LEVEL() >= qt[716].needLevel and qData[715].state == 2 then
    if qData[716].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[718].state ~= 2 and GET_PLAYER_LEVEL() >= qt[718].needLevel and qData[717].state == 2 and qData[718].state == 1 then
    QSTATE(id, 2)
  end
  if qData[719].state ~= 2 and GET_PLAYER_LEVEL() >= qt[719].needLevel and qData[718].state == 2 then
    if qData[719].state == 1 then
      if CHECK_ITEM_CNT(qt[719].goal.getItem[1].id) >= qt[719].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[720].state ~= 2 and GET_PLAYER_LEVEL() >= qt[720].needLevel and qData[719].state == 2 then
    if qData[720].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[723].state == 1 and GET_PLAYER_LEVEL() >= qt[723].needLevel then
    QSTATE(id, 2)
  end
  if qData[724].state ~= 2 and GET_PLAYER_LEVEL() >= qt[724].needLevel and qData[723].state == 2 then
    if qData[724].state == 1 then
      if CHECK_ITEM_CNT(qt[724].goal.getItem[1].id) >= qt[724].goal.getItem[1].count and CHECK_ITEM_CNT(qt[724].goal.getItem[2].id) >= qt[724].goal.getItem[2].count and CHECK_ITEM_CNT(qt[724].goal.getItem[3].id) >= qt[724].goal.getItem[3].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1457].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1458].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1458].needLevel and qData[1457].state == 2 then
    if qData[1458].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3650].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3650].needLevel then
    if qData[3650].state == 1 then
      if qData[3650].killMonster[qt[3650].goal.killMonster[1].id] >= qt[3650].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3651].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3651].needLevel then
    if qData[3651].state == 1 then
      if qData[3651].killMonster[qt[3651].goal.killMonster[1].id] >= qt[3651].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3652].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3652].needLevel then
    if qData[3652].state == 1 then
      if qData[3652].killMonster[qt[3652].goal.killMonster[1].id] >= qt[3652].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
