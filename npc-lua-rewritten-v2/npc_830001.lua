function npcsay(id)
  if id ~= 6830001 then
    return
  end
  clickNPCid = id
  NPC_SAY("快点，快点强大起来拯救世界！")
  if qData[1920].state == 1 then
    if GET_PLAYER_LEVEL() >= 72 then
      NPC_SAY("我的力量变得更强大了！")
      SET_QUEST_STATE(1920, 2)
    else
      NPC_SAY("只要你的功力{0xFFFFFF00}再提升1级{END}，我就会有所变化。")
    end
  end
  if qData[1921].state == 1 then
    if GET_PLAYER_LEVEL() >= 84 then
      NPC_SAY("我的力量变得更强大了！")
      SET_QUEST_STATE(1921, 2)
    else
      NPC_SAY("只要你的功力{0xFFFFFF00}再提升1级{END}，我就会有所变化。")
    end
  end
  if qData[1922].state == 1 then
    if GET_PLAYER_LEVEL() >= 96 then
      NPC_SAY("我的力量变得更强大了！")
      SET_QUEST_STATE(1922, 2)
    else
      NPC_SAY("只要你的功力{0xFFFFFF00}再提升1级{END}，我就会有所变化。")
    end
  end
  if qData[1923].state == 1 then
    if GET_PLAYER_LEVEL() >= 108 then
      NPC_SAY("我的力量变得更强大了！")
      SET_QUEST_STATE(1923, 2)
    else
      NPC_SAY("只要你的功力{0xFFFFFF00}再提升1级{END}，我就会有所变化。")
    end
  end
  if qData[1924].state == 1 then
    if GET_PLAYER_LEVEL() >= 120 then
      NPC_SAY("这就是我以前力量的一部分！")
      SET_QUEST_STATE(1924, 2)
    else
      NPC_SAY("只要你的功力{0xFFFFFF00}再提升1级{END}，我就会有所变化。 这次有可能是比较大的变化。")
    end
  end
  if qData[1908].state == 1 then
    if qData[1908].killMonster[qt[1908].goal.killMonster[1].id] >= qt[1908].goal.killMonster[1].count then
      NPC_SAY("好厉害！好厉害！总算没有白白在{0xFFFFFF00}春水糖{END}手底下修行啊？")
      SET_QUEST_STATE(1908, 2)
    else
      NPC_SAY("先击退{0xFFFFFF00}3个[木棉怪]{END}活动一下筋骨吧！不要投机取巧，一次性解决掉。准备好了的话{0xFFFFFF00}就跟我对话，进入神殿里面就可以了。{END}")
    end
  end
  if qData[1909].state == 1 then
    if qData[1909].killMonster[qt[1909].goal.killMonster[1].id] >= qt[1909].goal.killMonster[1].count then
      NPC_SAY("看到了么？看清楚了没有？这下可以相信我的实力了吧？")
      SET_QUEST_STATE(1909, 2)
    else
      NPC_SAY("准备好了吗？听好了，需要击退{0xFFFFFF00}5个[光辉令]{END}，明白吗？准备好了{0xFFFFFF00}就跟我对话进入神殿的深处2！{END}")
    end
  end
  if qData[1910].state == 1 then
    if qData[1910].killMonster[qt[1910].goal.killMonster[1].id] >= qt[1910].goal.killMonster[1].count then
      NPC_SAY("总觉得哪里不对劲，不祥的气息不但没有消失，反而在逐渐增强！")
      SET_QUEST_STATE(1910, 2)
    else
      NPC_SAY("进入{0xFFFFFF00}沉默神殿的深处3{END}击退{0xFFFFFF00}5个[异教徒祭司长]{END}吧！")
    end
  end
  if qData[1911].state == 1 then
    NPC_SAY("我们先出去吧！通过沉默神殿祭坛过去，应该就可以找到出口了！")
  end
  if qData[1912].state == 1 then
    NPC_SAY("通过那个出口应该可以去{0xFFFFFF00}沉默神殿的入口{END}，具体情况等我们出去再说吧！")
  end
  if qData[1913].state == 1 then
    NPC_SAY("先听从魔教使徒的指示吧！")
  end
  if qData[1908].state == 1 then
    NPC_WARP_SILENCE_TEMPLE1(id)
  end
  if qData[1909].state == 1 then
    NPC_WARP_SILENCE_TEMPLE2(id)
  end
  if qData[1910].state == 1 then
    NPC_WARP_SILENCE_TEMPLE3(id)
  end
  if qData[1911].state == 1 then
    NPC_WARP_SILENCE_TEMPLE4(id)
  end
  if qData[1908].state == 0 and SET_PLAYER_SEX() == 1 and GET_PLAYER_JOB2() == 13 and 1 <= GET_PLAYER_EQUIPSEANCELEVEL() then
    ADD_QUEST_BTN(qt[1908].id, qt[1908].name)
  end
  if qData[1909].state == 0 and qData[1908].state == 2 then
    ADD_QUEST_BTN(qt[1909].id, qt[1909].name)
  end
  if qData[1910].state == 0 and qData[1909].state == 2 then
    ADD_QUEST_BTN(qt[1910].id, qt[1910].name)
  end
  if qData[1911].state == 0 and qData[1910].state == 2 then
    ADD_QUEST_BTN(qt[1911].id, qt[1911].name)
  end
  if qData[1912].state == 0 and qData[1911].state == 2 then
    ADD_QUEST_BTN(qt[1912].id, qt[1912].name)
  end
  if qData[1913].state == 0 and qData[1912].state == 2 then
    ADD_QUEST_BTN(qt[1913].id, qt[1913].name)
  end
  if qData[1920].state == 0 and GET_PLAYER_LEVEL() >= 71 and SET_PLAYER_SEX() == 1 and 1 <= GET_PLAYER_EQUIPSEANCELEVEL() then
    ADD_QUEST_BTN(qt[1920].id, qt[1920].name)
  end
  if qData[1921].state == 0 and GET_PLAYER_LEVEL() >= 83 and SET_PLAYER_SEX() == 1 and 2 <= GET_PLAYER_EQUIPSEANCELEVEL() then
    ADD_QUEST_BTN(qt[1921].id, qt[1921].name)
  end
  if qData[1922].state == 0 and GET_PLAYER_LEVEL() >= 95 and SET_PLAYER_SEX() == 1 and GET_PLAYER_EQUIPSEANCELEVEL() >= 3 then
    ADD_QUEST_BTN(qt[1922].id, qt[1922].name)
  end
  if qData[1923].state == 0 and GET_PLAYER_LEVEL() >= 107 and SET_PLAYER_SEX() == 1 and GET_PLAYER_EQUIPSEANCELEVEL() >= 4 then
    ADD_QUEST_BTN(qt[1923].id, qt[1923].name)
  end
  if qData[1924].state == 0 and GET_PLAYER_LEVEL() >= 119 and SET_PLAYER_SEX() == 1 and GET_PLAYER_EQUIPSEANCELEVEL() >= 5 then
    ADD_QUEST_BTN(qt[1924].id, qt[1924].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1908].state ~= 2 and SET_PLAYER_SEX() == 1 then
    if qData[1908].state == 1 then
      if qData[1908].killMonster[qt[1908].goal.killMonster[1].id] >= qt[1908].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1909].state ~= 2 and qData[1908].state == 2 then
    if qData[1909].state == 1 then
      if qData[1909].killMonster[qt[1909].goal.killMonster[1].id] >= qt[1909].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1910].state ~= 2 and qData[1909].state == 2 then
    if qData[1910].state == 1 then
      if qData[1910].killMonster[qt[1910].goal.killMonster[1].id] >= qt[1910].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1911].state ~= 2 and qData[1910].state == 2 then
    if qData[1911].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1912].state ~= 2 and qData[1911].state == 2 then
    if qData[1912].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1913].state ~= 2 and qData[1912].state == 2 then
    if qData[1913].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1920].state ~= 2 and GET_PLAYER_LEVEL() >= 71 and SET_PLAYER_SEX() == 1 and 1 <= GET_PLAYER_EQUIPSEANCELEVEL() then
    if qData[1920].state == 1 then
      if GET_PLAYER_LEVEL() >= 72 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1921].state ~= 2 and GET_PLAYER_LEVEL() >= 83 and SET_PLAYER_SEX() == 1 and 2 <= GET_PLAYER_EQUIPSEANCELEVEL() then
    if qData[1921].state == 1 then
      if GET_PLAYER_LEVEL() >= 84 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1922].state ~= 2 and GET_PLAYER_LEVEL() >= 95 and SET_PLAYER_SEX() == 1 and GET_PLAYER_EQUIPSEANCELEVEL() >= 3 then
    if qData[1922].state == 1 then
      if GET_PLAYER_LEVEL() >= 96 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1923].state ~= 2 and GET_PLAYER_LEVEL() >= 107 and SET_PLAYER_SEX() == 1 and GET_PLAYER_EQUIPSEANCELEVEL() >= 4 then
    if qData[1923].state == 1 then
      if GET_PLAYER_LEVEL() >= 108 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1924].state ~= 2 and GET_PLAYER_LEVEL() >= 119 and SET_PLAYER_SEX() == 1 and GET_PLAYER_EQUIPSEANCELEVEL() >= 5 then
    if qData[1924].state == 1 then
      if GET_PLAYER_LEVEL() >= 120 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
