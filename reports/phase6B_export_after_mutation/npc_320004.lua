function npcsay(id)
  if id ~= 4320004 then
    return
  end
  clickNPCid = id
  NPC_SAY("现在虽然弱小，但是我必定会变得强大起来的")
  if qData[2477].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("寸脚, 唱甫 绢痘霸 茫疽瘤?")
      SET_QUEST_STATE(2477, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2478].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("扳颊窍角 鞘夸 绝嚼聪促. 狼蛆丛捞 措窜窍脚 疤聪促.")
      SET_QUEST_STATE(2478, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2479].state == 1 then
    if qData[2479].killMonster[qt[2479].goal.killMonster[1].id] >= qt[2479].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("国结 130付府甫 硼摹窍脚芭夸? 家牢捞 脸备妨.")
        SET_QUEST_STATE(2479, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}孺蓖趋肺{END}俊 免隔窍绰 {0xFFFFFF00}荐陛酒{END} 130付府甫 穿啊 刚历 硼摹窍绰瘤 版里秦壕矫促.")
    end
  end
  if qData[2480].state == 1 then
    if qData[2480].killMonster[qt[2480].goal.killMonster[1].id] >= qt[2480].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("捞锅俊绰 家牢捞 捞板家捞促. 窍瘤父 沥富 埃惯狼 瞒捞看家.")
        SET_QUEST_STATE(2480, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}孺蓖趋肺{END}俊 免隔窍绰 {0xFFFFFF00}藕林绢{END} 150付府甫 穿啊 刚历 硼摹窍绰瘤 版里秦壕矫促.")
    end
  end
  if qData[2481].state == 1 then
    if qData[2481].killMonster[qt[2481].goal.killMonster[1].id] >= qt[2481].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("国结 促 硼摹窍继家捞鳖? 澜.. 老窜 粱 浆菌促 促矫 父吵矫促. {0xFFFFFF00}146傍仿{END}捞 登搁 促矫 焊档废 窍烈.")
        SET_QUEST_STATE(2481, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}孺蓖趋肺{END}俊 免隔窍绰 {0xFFFFFF00}荤锋{END} 120付府甫 穿啊 刚历 硼摹窍绰瘤 版里秦壕矫促.")
    end
  end
  if qData[2482].state == 1 then
    if CHECK_ITEM_CNT(qt[2482].goal.getItem[1].id) >= qt[2482].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("缚家荤, 国结 促 备窍继促绊夸?")
        SET_QUEST_STATE(2482, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}孺蓖趋肺{END}俊 啊辑 {0xFFFFFF00}[荐陛酒]{END}甫 硼摹窍绊 {0xFFFFFF00}漠朝部府{END}甫 100俺甫 刚历 备秦坷搁 捞扁绰 疤聪促.")
    end
  end
  if qData[2483].state == 1 then
    if CHECK_ITEM_CNT(qt[2483].goal.getItem[1].id) >= qt[2483].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("酒聪, 捞凡荐啊! 捞锅俊档 家牢捞 瘤促聪..")
        SET_QUEST_STATE(2483, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}孺蓖趋肺{END}俊 啊辑 {0xFFFFFF00}[藕林绢]{END}甫 硼摹窍绊 {0xFFFFFF00}藕林绢弧魄{END}阑 100俺甫 刚历 备秦坷搁 捞扁绰 疤聪促.")
    end
  end
  if qData[2484].state == 1 then
    if CHECK_ITEM_CNT(qt[2484].goal.getItem[1].id) >= qt[2484].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("沥富捞瘤... 措窜窍绞聪促. 捞锅俊档 脸嚼聪促.")
        SET_QUEST_STATE(2484, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}孺蓖趋肺{END}俊 啊辑 {0xFFFFFF00}[荤锋]{END}甫 硼摹窍绊 {0xFFFFFF00}荤锋荐堪{END}阑 100俺甫 刚历 备秦坷搁 捞扁绰 疤聪促.")
    end
  end
  if qData[2485].state == 1 then
    NPC_SAY("舵窍脚 官甫 捞风矫扁甫 扁盔钦聪促.")
    SET_QUEST_STATE(2485, 2)
    return
  end
  if qData[3679].state == 1 then
    if qData[3679].killMonster[qt[3679].goal.killMonster[1].id] >= qt[3679].goal.killMonster[1].count then
      NPC_SAY("怎么会这样！我输了~")
      SET_QUEST_STATE(3679, 2)
      return
    else
      NPC_SAY("是看谁更快的击退{0xFFFFFF00}50个黑鬼血路的人蛇怪{END}的对决")
    end
  end
  if qData[3680].state == 1 then
    if qData[3680].killMonster[qt[3680].goal.killMonster[1].id] >= qt[3680].goal.killMonster[1].count then
      NPC_SAY("怎么会这样！我输了~")
      SET_QUEST_STATE(3680, 2)
      return
    else
      NPC_SAY("是看谁更快的击退{0xFFFFFF00}50个黑鬼血路的吞舟鱼{END}的对决")
    end
  end
  if qData[3681].state == 1 then
    if qData[3681].killMonster[qt[3681].goal.killMonster[1].id] >= qt[3681].goal.killMonster[1].count then
      NPC_SAY("怎么会这样！我输了~")
      SET_QUEST_STATE(3681, 2)
      return
    else
      NPC_SAY("是看谁更快的击退{0xFFFFFF00}50个黑鬼血路的邪龙{END}的对决")
    end
  end
  if qData[3679].state == 0 and GET_PLAYER_LEVEL() >= qt[3679].needLevel then
    ADD_QUEST_BTN(qt[3679].id, qt[3679].name)
  end
  if qData[3680].state == 0 and GET_PLAYER_LEVEL() >= qt[3680].needLevel then
    ADD_QUEST_BTN(qt[3680].id, qt[3680].name)
  end
  if qData[3681].state == 0 and GET_PLAYER_LEVEL() >= qt[3681].needLevel then
    ADD_QUEST_BTN(qt[3681].id, qt[3681].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3679].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3679].needLevel then
    if qData[3679].state == 1 then
      if qData[3679].killMonster[qt[3679].goal.killMonster[1].id] >= qt[3679].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3680].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3680].needLevel then
    if qData[3680].state == 1 then
      if qData[3680].killMonster[qt[3680].goal.killMonster[1].id] >= qt[3680].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3681].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3681].needLevel then
    if qData[3681].state == 1 then
      if qData[3681].killMonster[qt[3681].goal.killMonster[1].id] >= qt[3681].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
