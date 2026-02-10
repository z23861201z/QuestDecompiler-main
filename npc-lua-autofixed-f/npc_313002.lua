function npcsay(id)
  if id ~= 4313002 then
    return
  end
  clickNPCid = id
  NPC_SAY("欢迎光临！这是鱼类料理菜单。只要拿来鱼就免费给制作料理。来，选选看吧。")
  if qData[76].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[76].goal.getItem) then
      NPC_SAY("收集回来山参了啊！这是谢礼")
      SET_QUEST_STATE(76, 2)
      return
    else
      NPC_SAY("收集回来{0xFFFFFF00}10个[山参]{END}就可以了，美丽人参经常在竹林出没，击退就可以获得山参")
    end
  end
  if qData[95].state == 1 and qData[95].meetNpc[1] == qt[95].goal.meetNpc[1] then
    if qData[95].meetNpc[2] ~= qt[95].goal.meetNpc[2] then
      SET_MEETNPC(95, 2, id)
      NPC_QSAY(95, 5)
      return
    else
      NPC_SAY("{0xFFFFFF00}小狗{END}由我来送，请转告{0xFFFFFF00}[名田瞧]{END}，一定要按时喂饭")
    end
  end
  if qData[106].state == 1 then
    if qData[106].meetNpc[1] == qt[106].goal.meetNpc[1] then
      if __QUEST_HAS_ALL_ITEMS(qt[106].goal.getItem) then
        NPC_SAY("如果用熊胆还赊账的钱，那我就不要了。但是，像他那样的人，帮也是白帮，他是不会感谢你的")
        SET_QUEST_STATE(106, 2)
      else
        NPC_SAY("{0xFFFFFF00}赊账的钱{END}还没还吗？")
      end
    else
      NPC_SAY("{0xFFFFFF00}赊账的钱{END}还没还吗？龙林客栈的醉客中的一人就是他")
    end
  end
  if qData[198].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[198].goal.getItem) then
      if 2 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("请收下天下第一的饼吧。吃了这个会有无穷无尽的力量的。")
        SET_QUEST_STATE(198, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("{0xFFFFFF00}[ 蓝蜗牛的壳 ]{END}拿来了吗？拿来{0xFFFFFF00}15个{END}，我会帮忙制作天下第一的饼的。")
    end
  end
  if qData[200].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[200].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("HOHO…这就是那个很难得到的变异毛毛的卵啊！果然看起来很好吃的样子。请稍等~好了~这是糖醋里脊盖饭")
        SET_QUEST_STATE(200, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("我想快点制作糖醋里脊盖饭，当然会让PLAYERNAME最先尝尝。快去收集{0xFFFFFF00}25个[变异毛毛的卵]{END}吧！")
    end
  end
  if qData[1213].state == 1 and GET_PLAYER_FACTION() == 0 then
    NPC_SAY("要帮我？天啊，从武林人士口中听到这么亲切的话都不知道是什么年代的事情了。")
    SET_QUEST_STATE(1213, 2)
  end
  if qData[1264].state == 1 and GET_PLAYER_FACTION() == 1 then
    NPC_SAY("要帮我？天啊，从武林人士口中听到这么亲切的话都不知道是什么年代的事情了。")
    SET_QUEST_STATE(1264, 2)
  end
  if qData[1214].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1214].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("哎呀，谢谢了。托少侠的福，短时间内是可以坚持一下了。之前觉得武林人士都很坏，今天真是眼前一亮啊。")
        SET_QUEST_STATE(1214, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("先去竹林击退美丽人参收集20个山参回来吧。")
    end
  end
  if qData[1215].state == 1 then
    NPC_SAY("去找冥珠城武器店帮帮他吧。武器店在冥珠城北边。")
  end
  if qData[1396].state == 1 then
    NPC_SAY("哎呦，少侠，好久不见了，最近也不怎么过来了啊！")
    SET_QUEST_STATE(1396, 2)
  end
  if qData[1397].state == 1 then
    NPC_SAY("击退怪物获得10个紫菜后，替我交给韩野村南的韩野村厨房长！")
  end
  if qData[1415].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[1415].goal.getItem) then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢，谢谢！来，请选择自己想要的包子吧！")
        SET_QUEST_STATE(1415, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("收集3个小菜头的力量回来，就可以交换恢复原状的包子")
    end
  end
  ADD_NEW_SHOP_BTN(id, 10029)
  ADD_EVENT_BTN_E(id)
  ADD_EVENT_BTN_F(id)
  ADD_EVENT_BTN_G(id)
  if qData[198].state == 0 then
    ADD_QUEST_BTN(qt[198].id, qt[198].name)
  end
  if qData[1214].state == 0 and qData[1212].state == 2 and GET_PLAYER_LEVEL() >= qt[1214].needLevel then
    ADD_QUEST_BTN(qt[1214].id, qt[1214].name)
  end
  if qData[1215].state == 0 and qData[1214].state == 2 and GET_PLAYER_LEVEL() >= qt[1215].needLevel then
    ADD_QUEST_BTN(qt[1215].id, qt[1215].name)
  end
  if qData[1397].state == 0 and qData[1396].state == 2 then
    ADD_QUEST_BTN(qt[1397].id, qt[1397].name)
  end
  if qData[1415].state == 0 then
    ADD_QUEST_BTN(qt[1415].id, qt[1415].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[198].state ~= 2 and GET_PLAYER_LEVEL() >= qt[198].needLevel then
    if qData[198].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[198].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1214].state == 0 and qData[1212].state == 2 and GET_PLAYER_LEVEL() >= qt[1214].needLevel then
    if qData[1214].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[1214].goal.getItem) then
        if 1 <= CHECK_INVENTORY_CNT(2) then
          QSTATE(id, 2)
        end
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1215].state == 0 and qData[1214].state == 2 and GET_PLAYER_LEVEL() >= qt[1215].needLevel then
    QSTATE(id, 0)
  end
  if qData[1215].state == 1 then
    QSTATE(id, 1)
  end
end
