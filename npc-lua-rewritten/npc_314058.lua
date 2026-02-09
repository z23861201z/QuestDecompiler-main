local function __QUEST_CHECK_ITEMS(goalItems)
  for i, v in ipairs(goalItems) do
    if CHECK_ITEM_CNT(v.id) < v.count then
      return false
    end
  end
  return true
end

function npcsay(id)
  if id ~= 4314058 then
    return
  end
  clickNPCid = id
  if qData[1100].state == 1 then
    SET_QUEST_STATE(1100, 2)
    NPC_SAY("欢迎你来到我们村子。经过村子的时候如果看到有{0xFFFFFF00}谁头上有感叹号（！）的话就说明有话对你说{END}，你可以过去和他对话。还有这个是你的，拿着吧。")
  end
  if qData[1101].state == 1 then
    if qData[1101].meetNpc[1] == qt[1101].goal.meetNpc[1] and __QUEST_CHECK_ITEMS(qt[1101].goal.getItem) then
      SET_QUEST_STATE(1101, 2)
      NPC_SAY("呼呼~~买来啦？谢谢你。我们继续说吧。")
    else
      NPC_SAY("从我的左边走过去就会遇到杂货商。请买1个蓝水。")
    end
  end
  if qData[1102].state == 1 then
    if GET_PLAYER_STATEPOINT() == 0 then
      SET_QUEST_STATE(1102, 2)
      NPC_SAY("没什么难的，尽量提升能力值吧。")
    else
      NPC_SAY("将能力值全部分配看看。")
    end
  end
  if qData[1103].state == 1 then
    if GET_PLAYER_SKILLPOINT() == 0 or GET_PLAYER_USESKILLPOINT_C() > 18 then
      SET_QUEST_STATE(1103, 2)
      NPC_SAY("都是有用的武功，尽情的提升等级吧。功力达10之后可以学习更多的武功。")
    else
      NPC_SAY("点击[D]键打开武功窗口，将所有武功全都放上去。可以感觉到自己变强。")
    end
  end
  if qData[1104].state == 1 then
    if 0 >= CHECK_ITEM_CNT(8820013) then
      SET_QUEST_STATE(1104, 2)
      NPC_SAY("呵呵呵。还不适应吧？很方便的功能，会习惯的。这是我给你的礼物，需要的时候用吧。")
    else
      NPC_SAY("先喝艾里药水吧。这样才有力气继续说。")
    end
  end
  if qData[1112].state == 1 then
    NPC_SAY("在[选择树林]学习职业武功之后，去找清阴关东边的宝芝林吧。使用[寻路]会很容易就能找到。")
  end
  if qData[1105].state == 1 then
    NPC_SAY("我现在要休息了，去找小甜甜妈妈吧。你在下面能见到[小甜甜妈妈]。按[Ctrl + ↓]键就能下去。")
  end
  if qData[1202].state == 1 then
    NPC_SAY("哦~你来了？叫你来是有话对你说。再和我对话吧。")
    SET_QUEST_STATE(1202, 2)
  end
  if qData[1112].state == 1 then
    NPC_SAY("在[选择树林]学习1次武功后去找清阴关东边的宝芝林吧。我会帮你寻路，跟着头顶上的箭头走吧。")
    ADD_AUTO_SEARCH_NPC(4214001)
  end
  if qData[1467].state == 1 then
    if 0 < CHECK_INVENTORY_CNT(3) then
      NPC_SAY("呼~好累啊。一定要为了这个世界，好好利用吧。")
      SET_QUEST_STATE(1467, 2)
    else
      NPC_SAY("行囊已满。")
    end
  end
  if qData[2018].state == 1 then
    NPC_SAY("还没回去吗？{0xFFFFFF00}[选择树林]{END}的{0xFFFFFF00}[佣兵领袖]{END}正在找你呢，快回去看看吧")
  end
  if qData[1100].state == 0 then
    ADD_QUEST_BTN(qt[1100].id, qt[1100].name)
  end
  if qData[1101].state == 0 and qData[1100].state == 2 then
    ADD_QUEST_BTN(qt[1101].id, qt[1101].name)
  end
  if qData[1102].state == 0 and qData[1101].state == 2 then
    ADD_QUEST_BTN(qt[1102].id, qt[1102].name)
  end
  if qData[1103].state == 0 and qData[1102].state == 2 then
    ADD_QUEST_BTN(qt[1103].id, qt[1103].name)
  end
  if qData[1104].state == 0 and qData[1103].state == 2 then
    ADD_QUEST_BTN(qt[1104].id, qt[1104].name)
  end
  if qData[1105].state == 0 and qData[1104].state == 2 then
    ADD_QUEST_BTN(qt[1105].id, qt[1105].name)
  end
  if qData[1202].state == 2 and qData[1112].state == 0 then
    ADD_QUEST_BTN(qt[1112].id, qt[1112].name)
  end
  if qData[2018].state == 0 and qData[1202].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2018].id, qt[2018].name)
  end
  if GET_PLAYER_LEVEL() >= qt[1467].needLevel and qData[1467].state == 0 then
    ADD_QUEST_BTN(qt[1467].id, qt[1467].name)
  end
  ADD_EVENT_GUIDE_ITEM_NEW(id)
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1100].state == 1 then
    QSTATE(id, 2)
  elseif qData[1100].state == 0 then
    QSTATE(id, 0)
  end
  if qData[1100].state == 2 and qData[1101].state ~= 2 then
    if qData[1101].state == 1 then
      if qData[1101].meetNpc[1] == qt[1101].goal.meetNpc[1] and __QUEST_CHECK_ITEMS(qt[1101].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1101].state == 2 and qData[1102].state ~= 2 then
    if qData[1102].state == 1 then
      if GET_PLAYER_STATEPOINT() == 0 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1102].state == 2 and qData[1103].state ~= 2 then
    if qData[1103].state == 1 then
      if GET_PLAYER_SKILLPOINT() == 0 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1103].state == 2 and qData[1104].state ~= 2 then
    if qData[1104].state == 1 then
      if 0 >= CHECK_ITEM_CNT(8820013) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1104].state == 2 and qData[1105].state ~= 2 then
    if qData[1105].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1202].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1202].state == 2 and 1 > qData[1112].state then
    QSTATE(id, 0)
  end
  if qData[1467].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1467].needLevel then
    if qData[1467].state == 2 then
      QSTATE(id, 2)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2018].state == 0 and qData[1202].state == 2 and GET_PLAYER_JOB1() == 11 then
    if qData[2018].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
