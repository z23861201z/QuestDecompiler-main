function npcsay(id)
  if id ~= 4391107 then
    return
  end
  clickNPCid = id
  NPC_SAY("一定要找到师傅，平息这乱世才行啊…")
  if qData[872].state == 1 then
    NPC_SAY("辛苦了。师傅...不是，少侠。希望能快点领悟到潜在于内心的力量")
    SET_QUEST_STATE(872, 2)
    return
  end
  ADD_NPC_WARP_INDUN_EXIT(id)
  if qData[1462].state == 1 then
    NPC_SAY("真不敢相信啊，竟然能击退超火车轮怪...")
    SET_QUEST_STATE(1462, 2)
  end
  if qData[1463].state == 1 then
    if 2 <= CHECK_INVENTORY_CNT(2) then
      NPC_SAY("天，天啊...真，真的是师傅吗？({0xFFFFFF00}完成了化境转职，所有的能力值和武功值被初始化的同时，额外获得了40点数。之外，还能多佩戴一个武器。){END}")
      SET_QUEST_STATE(1463, 2)
      return
    else
      NPC_SAY("行囊太沉。")
    end
    NPC_SAY()
    SET_QUEST_STATE(1463, 2)
  end
  if qData[1464].state == 1 then
    NPC_SAY("如果是关于武功的内容，你就去找我的兄长谈谈吧。去见见{0xFFFFFF00}血魔神窟{END}的{0xFFFFFF00}竹统泛{END}吧")
  end
  if qData[2558].state == 1 then
    NPC_SAY("师傅！")
    SET_QUEST_STATE(2558, 2)
  end
  if qData[2559].state == 1 then
    NPC_SAY("我会重新修复结界的。竹统泛就拜托你了")
    SET_QUEST_STATE(2559, 2)
  end
  if qData[2707].state == 1 then
    NPC_SAY("师傅！")
    SET_QUEST_STATE(2707, 2)
    return
  end
  if qData[2708].state == 1 then
    NPC_SAY("出去啊...能见到久违的太阳了！")
    SET_QUEST_STATE(2708, 2)
    return
  end
  if qData[1463].state == 0 and qData[1462].state == 2 then
    ADD_QUEST_BTN(qt[1463].id, qt[1463].name)
  end
  if qData[1464].state == 0 and qData[1463].state == 2 then
    ADD_QUEST_BTN(qt[1464].id, qt[1464].name)
  end
  if qData[2559].state == 0 and qData[2558].state == 2 and GET_PLAYER_LEVEL() >= qt[2559].needLevel then
    ADD_QUEST_BTN(qt[2559].id, qt[2559].name)
  end
  if qData[2708].state == 0 and qData[2707].state == 2 and GET_PLAYER_LEVEL() >= qt[2708].needLevel then
    ADD_QUEST_BTN(qt[2708].id, qt[2708].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[872].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1462].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1463].state ~= 2 and qData[1462].state == 2 and GET_PLAYER_LEVEL() >= qt[1463].needLevel then
    if qData[1463].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1464].state ~= 2 and qData[1463].state == 2 and GET_PLAYER_LEVEL() >= qt[1464].needLevel then
    if qData[1464].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2558].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2559].state ~= 2 and qData[2558].state == 2 and GET_PLAYER_LEVEL() >= qt[2559].needLevel then
    if qData[2559].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2707].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2708].state ~= 2 and qData[2707].state == 2 and GET_PLAYER_LEVEL() >= qt[2708].needLevel then
    if qData[2708].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
end
