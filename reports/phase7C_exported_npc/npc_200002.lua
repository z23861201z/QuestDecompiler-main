function npcsay(id)
  if id ~= 4200002 then
    return
  end
  clickNPCid = id
  if qData[1578].state == 1 then
    NPC_SAY("击退那老婆婆为了保护自己制作出的梦幻的龙凤鸣，并制服老婆婆吧。去那个地方的方法就去问承宪道僧吧，他会把你送到[梦幻的决战]的.")
  end
  if qData[1579].state == 1 then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("切~那个老太婆已经用传音传话了。既然能联系早点联系不就好了~哼！真是...还有，那个老太婆挺喜欢你的，让你再去玩呢")
      SET_QUEST_STATE(1579, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[895].state == 1 then
    NPC_SAY("[梦幻女白蛇]托人传话说，想让人通过承宪道僧进入[梦幻的决战]，击退梦幻的龙凤鸣。你快去看看吧")
  end
  ADD_NEW_SHOP_BTN(id, 10059)
  if qData[1578].state == 0 and GET_PLAYER_LEVEL() >= qt[1578].needLevel then
    ADD_QUEST_BTN(qt[1578].id, qt[1578].name)
  end
  if qData[895].state == 0 and qData[1579].state == 2 and GET_PLAYER_LEVEL() >= qt[895].needLevel then
    ADD_QUEST_BTN(qt[895].id, qt[895].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1578].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1578].needLevel then
    if qData[1578].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
    QSTATE(id, -1)
  end
  if qData[1579].state == 1 and qData[1578].state == 2 and qData[1579].meetNpc[1] ~= qt[1579].goal.meetNpc[1] then
    QSTATE(id, 2)
  end
  if qData[895].state ~= 2 and qData[1579].state == 2 and GET_PLAYER_LEVEL() >= qt[1579].needLevel then
    if qData[895].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
