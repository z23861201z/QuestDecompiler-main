function npcsay(id)
  if id ~= 4320003 then
    return
  end
  clickNPCid = id
  NPC_SAY("你知道吗？鬼觜岛有很多故事的")
  if qData[2471].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("酪绢滚赴 扁撅捞扼, 曼 浇锹 老捞焙夸.")
      SET_QUEST_STATE(2471, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2472].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("历绰 唱吝俊 咯青茄 捞具扁甫 氓栏肺 父甸 积阿涝聪促. 弊锭 寸脚狼 捞具扁甫 氓俊 持绢档 瞪鳖夸?(富捞 辨绢龙 巴 鞍促. 144傍仿捞 等 促澜俊 促矫 坷磊.)")
      SET_QUEST_STATE(2472, 2)
      return
    else
      NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
    end
  end
  if qData[2473].state == 1 then
    if CHECK_ITEM_CNT(qt[2473].goal.getItem[1].id) >= qt[2473].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("皑荤钦聪促. 亮篮 磊丰啊 瞪 巴涝聪促.")
        SET_QUEST_STATE(2473, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}孺蓖林盔{END}栏肺 啊辑 {0xFFFFFF00}[伙碍悼傈]{END}阑 硼摹窍绊 {0xFFFFFF00}伙碍悼傈殿辉{END}阑 85俺备秦林技夸.")
    end
  end
  if qData[2474].state == 1 then
    if qData[2474].killMonster[qt[2474].goal.killMonster[1].id] >= qt[2474].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("蜡帮摸蓖狼 漂隆阑 粱 舅妨林技夸.")
        SET_QUEST_STATE(2474, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}孺蓖林盔{END}栏肺 啊辑 {0xFFFFFF00}[蜡帮摸蓖]{END}甫 140付府 硼摹窍绊 弊甸狼 漂隆阑 舅妨林技夸.")
    end
  end
  if qData[2475].state == 1 then
    if CHECK_ITEM_CNT(qt[2475].goal.getItem[1].id) >= qt[2475].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("皑荤钦聪促. 亮篮 磊丰啊 瞪 巴涝聪促.")
        SET_QUEST_STATE(2475, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}孺蓖林盔{END}栏肺 啊辑 {0xFFFFFF00}[蜡帮摸蓖]{END}甫 硼摹窍绊 {0xFFFFFF00}何胶矾柳颇祈{END}阑 70俺备秦林技夸.")
    end
  end
  if qData[2476].state == 1 then
    if qData[2476].killMonster[qt[2476].goal.killMonster[1].id] >= qt[2476].goal.killMonster[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("绊缚嚼聪促. 捞力 赤籍甸档 歹 捞惑篮..")
        SET_QUEST_STATE(2476, 2)
        return
      else
        NPC_SAY("青扯捞 呈公 公疤嚼聪促.")
      end
    else
      NPC_SAY("{0xFFFFFF00}孺蓖林盔{END}栏肺 啊辑 {0xFFFFFF00}[腊救蓖]{END}甫 150付府 硼摹秦林技夸. 弊 沥档搁 面盒钦聪促.")
    end
  end
  if qData[3678].state == 1 then
    if qData[3678].killMonster[qt[3678].goal.killMonster[1].id] >= qt[3678].goal.killMonster[1].count then
      NPC_SAY("太感谢了")
      SET_QUEST_STATE(3678, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}50个黑鬼觜源的六眼怪{END}吧")
    end
  end
  if qData[3682].state == 1 then
    if qData[3682].killMonster[qt[3682].goal.killMonster[1].id] >= qt[3682].goal.killMonster[1].count then
      NPC_SAY("太感谢了")
      SET_QUEST_STATE(3682, 2)
      return
    else
      NPC_SAY("击退{0xFFFFFF00}50个黑鬼觜源的东来赤色鬼{END}吧")
    end
  end
  if qData[3678].state == 0 and GET_PLAYER_LEVEL() >= qt[3678].needLevel then
    ADD_QUEST_BTN(qt[3678].id, qt[3678].name)
  end
  if qData[3682].state == 0 and GET_PLAYER_LEVEL() >= qt[3682].needLevel then
    ADD_QUEST_BTN(qt[3682].id, qt[3682].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[3678].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3678].needLevel then
    if qData[3678].state == 1 then
      if qData[3678].killMonster[qt[3678].goal.killMonster[1].id] >= qt[3678].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3682].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3682].needLevel then
    if qData[3682].state == 1 then
      if qData[3682].killMonster[qt[3682].goal.killMonster[1].id] >= qt[3682].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
