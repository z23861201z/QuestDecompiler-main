function npcsay(id)
  if id ~= 4341021 then
    return
  end
  clickNPCid = id
  NPC_SAY("我是剪刀手莎罗拉，我会负责让你的发型焕然一新。")
  if qData[2722].state == 1 then
    if CHECK_ITEM_CNT(qt[2722].goal.getItem[1].id) >= qt[2722].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2722].goal.getItem[2].id) >= qt[2722].goal.getItem[2].count then
      NPC_SAY("好的。那接下来要制作梳子了。")
      SET_QUEST_STATE(2722, 2)
      return
    else
      NPC_SAY("10个锯齿飞鱼的断掉的锯齿和30个巨翅鸭嘴兽的巨翅鸭嘴兽的羽毛就能制作新的梳子了。")
    end
  end
  if qData[2724].state == 1 and qData[2724].meetNpc[1] ~= id then
    NPC_SAY("我的头发吗？你知道水灵儿的被水淋湿的石头吧？洗头发的时候用被水淋湿的石头搓一下会很好。收集10个被水淋湿的石头拿给酒店老板吧。")
    SET_INFO(2724, 1)
    SET_MEETNPC(2724, 1, id)
    return
  end
  if qData[3735].state == 1 then
    if CHECK_ITEM_CNT(qt[3735].goal.getItem[1].id) >= qt[3735].goal.getItem[1].count then
      NPC_SAY("哇！这么快...就回来了啊。速度太快了。那我来为你提供服务。")
      SET_QUEST_STATE(3735, 2)
      return
    else
      NPC_SAY("告诉秘诀的同时我作为美容师再提供一些服务，客人也会增多。所以想让你帮忙收集20个被水淋湿的石头。")
    end
  end
  if qData[3786].state == 1 then
    if CHECK_ITEM_CNT(qt[3786].goal.getItem[1].id) >= qt[3786].goal.getItem[1].count then
      NPC_SAY("我看看..{0xFFFFCCCC}(沙.. 沙..){END}这就足够了。不，没准更好用。这是答应你的谢礼。")
      SET_QUEST_STATE(3786, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}大瀑布{END}击退{0xFFFFFF00}晶石喙龟{END}，收集50个{0xFFFFFF00}晶石喙龟的喙{END}回来吧。能用的话我会给你谢礼。")
    end
  end
  if qData[2722].state == 0 and GET_PLAYER_LEVEL() >= qt[2722].needLevel then
    ADD_QUEST_BTN(qt[2722].id, qt[2722].name)
  end
  if qData[3735].state == 0 and qData[2724].state == 2 and GET_PLAYER_LEVEL() >= qt[3735].needLevel then
    ADD_QUEST_BTN(qt[3735].id, qt[3735].name)
  end
  if qData[3786].state == 0 and GET_PLAYER_LEVEL() >= qt[3786].needLevel then
    ADD_QUEST_BTN(qt[3786].id, qt[3786].name)
  end
  ADD_BEAUTYSHOP_BTN(id)
  ADD_PREMIUM_BEAUTYSHOP_BTN(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[2722].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2722].needLevel then
    if qData[2722].state == 1 then
      if CHECK_ITEM_CNT(qt[2722].goal.getItem[1].id) >= qt[2722].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2722].goal.getItem[2].id) >= qt[2722].goal.getItem[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2724].state == 1 and qData[2724].meetNpc[1] ~= id then
    QSTATE(id, 1)
  end
  if qData[3735].state ~= 2 and qData[2724].state == 2 and GET_PLAYER_LEVEL() >= qt[3735].needLevel then
    if qData[3735].state == 1 then
      if CHECK_ITEM_CNT(qt[3735].goal.getItem[1].id) >= qt[3735].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3786].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3786].needLevel then
    if qData[3786].state == 1 then
      if CHECK_ITEM_CNT(qt[3786].goal.getItem[1].id) >= qt[3786].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
