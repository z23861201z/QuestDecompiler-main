function npcsay(id)
  if id ~= 4218008 then
    return
  end
  clickNPCid = id
  if qData[1525].state == 1 then
    NPC_SAY("啊啊！见到你很高兴。同是汉谟拉比帝国人，能见面不容易啊！")
    SET_QUEST_STATE(1525, 2)
  end
  if qData[676].state == 1 then
    NPC_SAY("嘿嘿嘿。找我有事？去黄泉的方法？往我出售的这个灯火装满鬼魂，投放到封印里，路就会开启，嘿嘿。当然没有什么是免费的~")
    SET_MEETNPC(676, 1, id)
    SET_QUEST_STATE(676, 2)
  end
  if qData[802].state == 1 then
    NPC_SAY("拥有{0xFFFFFF00}低级灯火{END}才能进入。在哪里获得？我在出售啊。嘿嘿。拿着低级灯火去找承宪道僧吧。")
  end
  if qData[803].state == 1 then
    NPC_SAY("带着{0xFFFFFF00}[ 低级灯火 ]{END}去找{0xFFFFFF00}承宪道僧{END}，挑战一下{0xFFFFFF00}[ 暗血地狱 ]{END}吧。")
  end
  if qData[804].state == 1 then
    NPC_SAY("得买{0xFFFFFF00}[中级灯火]{END}。小伙子别想白嫖啊。来我这里支持一下购买 {0xFFFFFF00}[中级灯火]{END}去见冥珠都城的{0xFFFFFF00}[冥珠城父母官]{END}吧。")
  end
  if qData[806].state == 1 then
    NPC_SAY("快通过承宪道僧进入八豆妖地狱击退贪婪的猪大长吧。")
  end
  if qData[855].state == 1 then
    NPC_SAY("快通过承宪道僧进入霸主地狱击退逃亡者猪大长吧。")
  end
  if qData[856].state == 1 then
    NPC_SAY("现在通过承宪道僧进入杀气地狱击退邪恶恶魂天鬼吧。")
  end
  if qData[857].state == 1 then
    NPC_SAY("现在通过承宪道僧进入凶徒地狱击退邪恶魔王犬吧。")
  end
  if qData[870].state == 1 then
    NPC_SAY("通过皲裂地狱去见秋叨鱼")
  end
  if qData[872].state == 1 then
    NPC_SAY("击退超火车轮怪后去见菊花碴就可以领取奖励了")
  end
  if qData[1458].state == 1 then
    NPC_SAY("啊！烦死了！签这个协议真是损失大了！")
    SET_QUEST_STATE(1458, 2)
  end
  if qData[1459].state == 1 then
    if CHECK_ITEM_CNT(qt[1459].goal.getItem[1].id) >= qt[1459].goal.getItem[1].count then
      NPC_SAY("原来这个和那个一样，也没什么区别啊？难道是广告的效果？嘟嘟囔囔…随便了。按照约定你随便问吧")
      SET_QUEST_STATE(1459, 2)
    else
      NPC_SAY("在{0xFFFFFF00}冥珠城北{END}的{0xFFFFFF00}证明管理人{END}那里购买{0xFFFFFF00}1个高级灯火{END}交给我")
    end
  end
  if qData[1460].state == 1 then
    NPC_SAY("（首先把这消息转告给位于古老的渡头的装扮成疯癫的老人的秋叨鱼）")
  end
  if qData[2032].state == 1 then
    SET_QUEST_STATE(2032, 2)
    NPC_SAY("怎么又是乳臭未干的家伙啊~")
  end
  if qData[2033].state == 1 then
    NPC_SAY("还有什么疑问就问我吧，在这里呆久了太无聊了。你要经常来玩啊~  (得回到佣兵领袖处)")
  end
  if qData[2043].state == 1 then
    SET_QUEST_STATE(2043, 2)
    NPC_SAY("才来啊，怎么这么晚？")
  end
  if qData[2044].state == 1 then
    if qData[2044].killMonster[qt[2044].goal.killMonster[1].id] >= qt[2044].goal.killMonster[1].count then
      SET_QUEST_STATE(2044, 2)
      NPC_SAY("你解决的很好啊~猪大长的故乡就是地狱，所以怎么击退还是会再出现的。你问我该怎么办？只能是一直击退了。有的人想找人发泄的时候就来猪大长的，哈哈！")
    else
      NPC_SAY("还没走吗？领取我给的另一个任务[霸主地狱-逃亡者猪大长]后通过旁边的承宪道僧进入霸主地狱吧。去那儿击退猪大长就可以了，快去吧~")
    end
  end
  if qData[2045].state == 1 then
    NPC_SAY("[佣兵领袖]在找你呢，快去看看吧~")
  end
  if qData[3623].state == 1 then
    NPC_SAY("他可是我们家族的大恩人，你去帮我把他附近的妖怪清除吧")
  end
  if qData[3653].state == 1 then
    NPC_SAY("去土谷桃园击退兔女郎。期间我去找回我的东西")
  end
  ADD_NEW_SHOP_BTN(id, 10036)
  if qData[912].state == 0 then
    ADD_QUEST_BTN(qt[912].id, qt[912].name)
  end
  if qData[914].state == 0 then
    ADD_QUEST_BTN(qt[914].id, qt[914].name)
  end
  if qData[916].state == 0 then
    ADD_QUEST_BTN(qt[916].id, qt[916].name)
  end
  if qData[676].state == 2 and qData[802].state == 0 then
    ADD_QUEST_BTN(qt[802].id, qt[802].name)
  end
  if qData[676].state == 2 and qData[803].state == 0 then
    ADD_QUEST_BTN(qt[803].id, qt[803].name)
  end
  if qData[676].state == 2 and qData[804].state == 0 then
    ADD_QUEST_BTN(qt[804].id, qt[804].name)
  end
  if qData[676].state == 2 and qData[806].state == 0 then
    ADD_QUEST_BTN(qt[806].id, qt[806].name)
  end
  if qData[855].state == 0 and GET_PLAYER_LEVEL() >= qt[855].needLevel then
    ADD_QUEST_BTN(qt[855].id, qt[855].name)
  end
  if qData[856].state == 0 and GET_PLAYER_LEVEL() >= qt[856].needLevel then
    ADD_QUEST_BTN(qt[856].id, qt[856].name)
  end
  if qData[857].state == 0 and GET_PLAYER_LEVEL() >= qt[857].needLevel then
    ADD_QUEST_BTN(qt[857].id, qt[857].name)
  end
  if qData[870].state == 0 and GET_PLAYER_LEVEL() >= qt[870].needLevel then
    ADD_QUEST_BTN(qt[870].id, qt[870].name)
  end
  if qData[872].state == 0 and GET_PLAYER_LEVEL() >= qt[872].needLevel then
    ADD_QUEST_BTN(qt[872].id, qt[872].name)
  end
  if qData[1459].state == 0 and qData[1458].state == 2 then
    ADD_QUEST_BTN(qt[1459].id, qt[1459].name)
  end
  if qData[1460].state == 0 and qData[1459].state == 2 then
    ADD_QUEST_BTN(qt[1460].id, qt[1460].name)
  end
  if qData[2033].state == 0 and qData[2032].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2033].id, qt[2033].name)
  end
  if qData[2044].state == 0 and qData[2043].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2044].id, qt[2044].name)
  end
  if qData[2045].state == 0 and qData[2044].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2045].id, qt[2045].name)
  end
  if qData[3623].state == 0 and GET_PLAYER_LEVEL() >= qt[3623].needLevel then
    ADD_QUEST_BTN(qt[3623].id, qt[3623].name)
  end
  if qData[3653].state == 0 and GET_PLAYER_LEVEL() >= qt[3653].needLevel then
    ADD_QUEST_BTN(qt[3653].id, qt[3653].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1525].state == 1 then
    QSTATE(id, 2)
  end
  if qData[676].state == 2 and qData[802].state ~= 2 and GET_PLAYER_LEVEL() >= qt[110].needLevel then
    if qData[802].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[676].state == 2 and qData[803].state ~= 2 and GET_PLAYER_LEVEL() >= qt[110].needLevel then
    if qData[803].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[676].state == 2 and qData[804].state ~= 2 and GET_PLAYER_LEVEL() >= qt[110].needLevel then
    if qData[804].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[676].state == 2 and qData[806].state ~= 2 and GET_PLAYER_LEVEL() >= qt[110].needLevel then
    if qData[806].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[855].state ~= 2 and GET_PLAYER_LEVEL() >= qt[855].needLevel then
    if qData[855].state == 0 then
      QSTATE(id, 0)
    else
      QSTATE(id, 1)
    end
  end
  if qData[856].state ~= 2 and GET_PLAYER_LEVEL() >= qt[856].needLevel then
    if qData[856].state == 0 then
      QSTATE(id, 0)
    else
      QSTATE(id, 1)
    end
  end
  if qData[857].state ~= 2 and GET_PLAYER_LEVEL() >= qt[857].needLevel then
    if qData[857].state == 0 then
      QSTATE(id, 0)
    else
      QSTATE(id, 1)
    end
  end
  if qData[870].state ~= 2 and GET_PLAYER_LEVEL() >= qt[870].needLevel then
    if qData[870].state == 0 then
      QSTATE(id, 0)
    else
      QSTATE(id, 1)
    end
  end
  if qData[871].state ~= 2 and GET_PLAYER_LEVEL() >= qt[871].needLevel then
    if qData[871].state == 0 then
      QSTATE(id, 0)
    else
      QSTATE(id, 1)
    end
  end
  if qData[1458].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1459].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1459].needLevel and qData[1458].state == 2 then
    if qData[1459].state == 1 then
      if CHECK_ITEM_CNT(qt[1459].goal.getItem[1].id) >= qt[1459].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1460].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1460].needLevel and qData[1459].state == 2 then
    if qData[1460].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2032].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2033].state ~= 2 and qData[2032].state == 2 and GET_PLAYER_LEVEL() >= qt[2033].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2033].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[2043].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2044].state ~= 2 and qData[2043].state == 2 and GET_PLAYER_LEVEL() >= qt[2044].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2044].state == 1 then
      if qData[2044].killMonster[qt[2044].goal.killMonster[1].id] >= qt[2044].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2045].state ~= 2 and qData[2044].state == 2 and GET_PLAYER_LEVEL() >= qt[2045].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2045].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[676].state == 2 and qData[3623].state == 0 and GET_PLAYER_LEVEL() >= qt[3623].needLevel then
    if qData[3623].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3653].state == 0 and qData[676].state == 2 and GET_PLAYER_LEVEL() >= qt[3653].needLevel then
    if qData[3653].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
