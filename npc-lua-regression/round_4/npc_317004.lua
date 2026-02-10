function npcsay(id)
  if id ~= 4317004 then
    return
  end
  clickNPCid = id
  if qData[1138].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1138].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢。现在可以完成新鲜的料理了。这是我的诚意，请收下。")
        SET_QUEST_STATE(1138, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("制作料理需要媚惑之花的10个[红果子]。媚惑之花在旁边的强悍巷道能见到。")
    end
  end
  if qData[1153].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("啊，来的正好。走了这么远的路，辛苦了。吃饭了吗？")
      SET_QUEST_STATE(1153, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1155].state == 1 then
    NPC_SAY("功力还没达31吗？先去找收获的农夫吧。")
  end
  if qData[1160].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1160].goal.getItem) then
      NPC_SAY("拿来了啊，太好了。稍等一下。啊！这… 料理失败了。那我给你这个吧。到底是哪里出了错啊？")
      SET_QUEST_STATE(1160, 2)
    else
      NPC_SAY("15个[车轮残片]。别忘了，没有那些也就没有料理。去强悍巷道击退车轮怪收集15个[车轮残片]回来吧。")
    end
  end
  if qData[1166].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1166].goal.getItem) then
      NPC_SAY("谢谢。料理做好了就叫你。")
      SET_QUEST_STATE(1166, 2)
    else
      NPC_SAY("还没去吗？需要15个[鼠须]。")
    end
  end
  if qData[1173].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1173].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("真的很快啊。确实知道了你攻击已经达31了。哈哈哈（看脸色）不是生气了吧？")
        SET_QUEST_STATE(1173, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去强悍巷道击退蓝色大菜头，收集20个[蓝色的灯油]回来吧。这样就可以制作料理了。")
    end
  end
  if qData[1175].state == 1 then
    if CHECK_ITEM_CNT(qt[1175].goal.getItem[1].id) >= qt[1175].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("辛苦了。这是邪派嘉奖你的，不要拒绝。")
        SET_QUEST_STATE(1175, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("去强悍巷道击退矿工僵尸收集20个[破烂的灯]回来吧。")
    end
  end
  if qData[1177].state == 1 then
    NPC_SAY("送10个[破旧的铲柄]给乌骨鸡大侠吧。鬼铲在强悍巷道里。")
  end
  if qData[1400].state == 1 then
    NPC_SAY("?????. ???… ??…")
    SET_QUEST_STATE(1400, 2)
  end
  if qData[1401].state == 1 then
    NPC_SAY("???? ??? ?? ??????? ??! ?? ??? ??? ????!")
  end
  if qData[1138].state == 0 then
    ADD_QUEST_BTN(qt[1138].id, qt[1138].name)
  end
  if qData[1153].state == 2 and qData[1155].state == 0 then
    ADD_QUEST_BTN(qt[1155].id, qt[1155].name)
  end
  if qData[1160].state == 0 then
    ADD_QUEST_BTN(qt[1160].id, qt[1160].name)
  end
  if qData[1166].state == 0 then
    ADD_QUEST_BTN(qt[1166].id, qt[1166].name)
  end
  if qData[1155].state == 2 and qData[1173].state == 0 then
    ADD_QUEST_BTN(qt[1173].id, qt[1173].name)
  end
  if qData[1173].state == 2 and qData[1175].state == 0 then
    ADD_QUEST_BTN(qt[1175].id, qt[1175].name)
  end
  if qData[1175].state == 2 and qData[1177].state == 0 then
    ADD_QUEST_BTN(qt[1177].id, qt[1177].name)
  end
  if qData[1401].state == 0 and qData[1400].state == 2 then
    ADD_QUEST_BTN(qt[1401].id, qt[1401].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1138].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1138].needLevel then
    if qData[1138].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1138].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1151].state == 2 and qData[1153].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1153].needLevel and qData[1153].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1153].state == 2 and qData[1155].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1155].needLevel then
    if qData[1155].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1160].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1160].needLevel then
    if qData[1160].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1160].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1166].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1166].needLevel then
    if qData[1166].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1166].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1155].state == 2 and qData[1173].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1173].needLevel then
    if qData[1173].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1173].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1173].state == 2 and qData[1175].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1175].needLevel then
    if qData[1175].state == 1 then
      if CHECK_ITEM_CNT(qt[1175].goal.getItem[1].id) >= qt[1175].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1175].state == 2 and qData[1177].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1177].needLevel then
    if qData[1177].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
