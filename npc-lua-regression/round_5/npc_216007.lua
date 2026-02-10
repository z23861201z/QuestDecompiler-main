function npcsay(id)
  if id ~= 4216007 then
    return
  end
  clickNPCid = id
  if qData[489].state == 1 then
    if qData[489].meetNpc[1] ~= id then
      SET_INFO(489, 1)
      NPC_QSAY(489, 1)
      SET_MEETNPC(489, 1, id)
      return
    else
      NPC_SAY("对千手妖女有什么疑问，就向住持请教吧。第一寺的住持们历来都在研究着击退千手妖女的方法呢")
      return
    end
  end
  if qData[2162].state == 1 then
    NPC_SAY("是的，异界门的承宪道僧会帮你指路的")
  end
  if qData[493].state == 1 then
    if qData[493].meetNpc[1] ~= id then
      NPC_QSAY(493, 1)
      SET_INFO(493, 1)
      SET_MEETNPC(493, 1, id)
      return
    else
      NPC_SAY("准备好了就跟我说吧。从住持那儿拿到印章了吗？说过要拿着第一寺印章过来的…")
      return
    end
  end
  if qData[495].state == 1 then
    SET_INFO(495, 1)
    NPC_SAY("给住持传达击退了千手妖女的事情吧")
    return
  end
  if qData[533].state == 1 and qData[533].meetNpc[1] ~= id then
    if __QUEST_HAS_ALL_ITEMS(qt[533].goal.getItem) then
      SET_MEETNPC(533, 1, id)
      NPC_SAY("你一定要用现在获得的力量帮助善良的人啊。\n ※完成任务时获得全部还原符/全体武功还原符效果。附加获得能力值点数40和武功点数20")
      SET_QUEST_STATE(533, 2)
      return
    else
      NPC_SAY("你身上没有万年花种子啊。万年花种子放哪里了啊？万年花种子一定要时刻带在身上")
      return
    end
  end
  NPC_SAY("这里是第一寺内部。很长时间以来未对外开放的，现在是对外开放了。在第一寺内部不可以喧闹")
  ADD_NEW_SHOP_BTN(id, 10034)
  if qData[2161].state == 1 and qData[2162].state == 0 then
    ADD_QUEST_BTN(qt[2162].id, qt[2162].name)
  end
  if qData[494].state == 2 and qData[495].state == 0 then
    ADD_QUEST_BTN(qt[495].id, qt[495].name)
  end
  if qData[493].state == 2 and qData[533].state ~= 1 then
    NPC_SAY("可以移动到有千手妖女的房间。千手妖女的房间可以组队进入，组队进入时所有的队员都要在第一寺内部。\n {0xFFFFFF00}(进入千手妖女房间之后，30分钟之内，不能中途退出){END}")
    Warp1000suEnter(id)
    return
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[489].state == 1 and GET_PLAYER_LEVEL() >= qt[489].needLevel then
    QSTATE(id, 1)
  end
  if qData[493].state == 1 and GET_PLAYER_LEVEL() >= qt[493].needLevel then
    QSTATE(id, 1)
  end
  if qData[2162].state ~= 2 and qData[2161].state == 1 then
    if qData[2162].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[495].state == 1 and GET_PLAYER_LEVEL() >= qt[495].needLevel then
    QSTATE(id, 1)
  end
end
