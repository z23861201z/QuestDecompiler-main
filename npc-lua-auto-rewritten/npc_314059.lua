function npcsay(id)
  if id ~= 4314059 then
    return
  end
  clickNPCid = id
  if qData[1106].state == 1 then
    if CHECK_INVENTORY_CNT(3) > 0 then
      NPC_SAY("额？之前还在垂死边缘，现在已经活蹦乱跳的了？太好了。自我介绍一下。如你所见，我就是可以让像你这样的弱者变强的…咳咳…训练所长广柱。")
      SET_QUEST_STATE(1106, 2)
    else
      NPC_SAY("行囊已满。")
    end
  end
  if qData[1107].state == 1 then
    if 1 <= GET_SEAL_BOX_SOUL_PERSENT(8510011) then
      SET_QUEST_STATE(1107, 2)
      NPC_SAY("封印箱从1级到10级。封印箱被填满后可以用在许多地方，所以打怪的时候别忘记收集魂魄，好好利用。咳…咳咳。这是奖励给你的礼物。")
    else
      NPC_SAY("击退小菜头和大目仔，在封印箱里装一个怪物的紫色魂回来。长得像火苗一样的叫小菜头，绿色独眼的就是大目仔。咳咳。")
    end
  end
  if qData[1108].state == 1 then
    NPC_SAY("代我向小甜甜妈妈说谢谢。不管你是鬼魂者还是什么，虽然可怕但还是想再见一面。")
  end
  if qData[1111].state == 1 then
    if CHECK_ITEM_CNT(qt[1111].goal.getItem[1].id) >= qt[1111].goal.getItem[1].count then
      NPC_SAY("干得好。只有我健康了才能保卫村子的和平。咳咳。")
      SET_QUEST_STATE(1111, 2)
    else
      NPC_SAY("从这儿上去就有毛毛了。使用凌空虚步可以很快上去。拿来1个药草。")
    end
  end
  if qData[1202].state == 1 then
    NPC_SAY("长老好像在找你…好像知道找回你记忆的方法了。咳咳。咳咳。")
  end
  if qData[1201].state == 1 then
    NPC_SAY("咳咳…等下，等我咳完再说，你先喝这个。")
    SET_QUEST_STATE(1201, 2)
  end
  if qData[1466].state == 1 then
    if CHECK_INVENTORY_CNT(3) > 0 then
      NPC_SAY("书的材质特殊，看了一次就会消失，所以多给你几本。")
      SET_QUEST_STATE(1466, 2)
    else
      NPC_SAY("行囊已满。")
    end
  end
  if qData[1106].state == 2 and qData[1107].state == 0 then
    ADD_QUEST_BTN(qt[1107].id, qt[1107].name)
  end
  if qData[1107].state == 2 and qData[1108].state == 0 then
    ADD_QUEST_BTN(qt[1108].id, qt[1108].name)
  end
  if qData[1201].state == 2 and qData[1111].state == 0 then
    ADD_QUEST_BTN(qt[1111].id, qt[1111].name)
  end
  if qData[1111].state == 2 and qData[1202].state == 0 then
    ADD_QUEST_BTN(qt[1202].id, qt[1202].name)
  end
  if GET_PLAYER_LEVEL() >= qt[1466].needLevel and qData[1466].state == 0 then
    ADD_QUEST_BTN(qt[1466].id, qt[1466].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1105].state == 2 and qData[1106].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1106].state == 2 and qData[1107].state ~= 2 then
    if qData[1107].state == 1 then
      if 1 <= GET_SEAL_BOX_SOUL_PERSENT(8510011) then
        QSTATE(id, 2)
      elseif 1 > GET_SEAL_BOX_SOUL_PERSENT(8510011) then
        QSTATE(id, 1)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1107].state == 2 and qData[1108].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1108].needLevel then
    if qData[1108].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1201].state == 2 and qData[1111].state ~= 2 then
    if qData[1111].state == 1 then
      if CHECK_ITEM_CNT(qt[1111].goal.getItem[1].id) >= qt[1111].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1201].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1110].state == 2 and qData[1202].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1202].needLevel then
    if qData[1202].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1466].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1466].needLevel then
    if qData[1466].state == 1 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
end
