function npcsay(id)
  if id ~= 4324001 then
    return
  end
  clickNPCid = id
  NPC_SAY("魔教要不断的新生！")
  if qData[1507].state == 1 then
    if qData[1507].killMonster[qt[1507].goal.killMonster[1].id] >= qt[1507].goal.killMonster[1].count then
      NPC_SAY("辛苦了，很不错的手艺啊")
      SET_QUEST_STATE(1507, 2)
    else
      NPC_SAY("准备好了就去{0xFFFFFF00}沉默神殿的深处1{END}击退{0xFFFFFF00}3个木棉怪{END}后回来吧")
    end
  end
  if qData[1508].state == 1 then
    if qData[1508].killMonster[qt[1508].goal.killMonster[1].id] >= qt[1508].goal.killMonster[1].count then
      NPC_SAY("辛苦了，很不错的手艺啊")
      SET_QUEST_STATE(1508, 2)
    else
      NPC_SAY("准备好了就去{0xFFFFFF00}沉默神殿的深处1{END}击退{0xFFFFFF00}3个木棉怪{END}后回来吧")
    end
  end
  if qData[1509].state == 1 then
    if qData[1509].killMonster[qt[1509].goal.killMonster[1].id] >= qt[1509].goal.killMonster[1].count then
      NPC_SAY("你击退了多少光辉令，就会有多少灵魂得到安慰")
      SET_QUEST_STATE(1509, 2)
    else
      NPC_SAY("去沉默神殿的深处2确认异教徒的形态后回来吧")
    end
  end
  if qData[1510].state == 1 then
    if qData[1510].killMonster[qt[1510].goal.killMonster[1].id] >= qt[1510].goal.killMonster[1].count then
      NPC_SAY("你击退了多少光辉令，就会有多少灵魂得到安慰")
      SET_QUEST_STATE(1510, 2)
    else
      NPC_SAY("去沉默神殿的深处2确认异教徒的形态后回来吧")
    end
  end
  if qData[1511].state == 1 then
    NPC_SAY("在我潜入将宝物入手之前你去{0xFFFFFF00}沉默神殿的深处3{END}击退{0xFFFFFF00}5个异教徒祭司长{END}引起骚乱吧")
  end
  if qData[1512].state == 1 then
    NPC_SAY("在我潜入将宝物入手之前你去{0xFFFFFF00}沉默神殿的深处3{END}击退{0xFFFFFF00}5个异教徒祭司长{END}引起骚乱吧")
  end
  if qData[2609].state == 1 then
    if qData[2609].killMonster[qt[2609].goal.killMonster[1].id] >= qt[2609].goal.killMonster[1].count then
      NPC_SAY("异教徒比想象的还要多啊~")
      SET_QUEST_STATE(2609, 2)
    else
      NPC_SAY("进里面看看吧。")
    end
  end
  if qData[2610].state == 1 then
    NPC_SAY("去深处[2]吧。")
  end
  if qData[2611].state == 1 then
    NPC_SAY("去{0xFFFFFF00}沉默神殿的深处3{END}击退{0xFFFFFF00}5个异教徒祭司长{END}后回来吧。")
  end
  if qData[2615].state == 1 then
    if qData[2615].killMonster[qt[2615].goal.killMonster[1].id] >= qt[2615].goal.killMonster[1].count then
      NPC_SAY("异教徒比想象的还要多啊~")
      SET_QUEST_STATE(2615, 2)
    else
      NPC_SAY("进里面看看吧。")
    end
  end
  if qData[2616].state == 1 then
    NPC_SAY("去深处[2]吧。")
  end
  if qData[2617].state == 1 then
    NPC_SAY("去{0xFFFFFF00}沉默神殿的深处3{END}击退{0xFFFFFF00}5个异教徒祭司长{END}后回来吧。")
  end
  if qData[1507].state == 1 then
    NPC_WARP_SILENCE_TEMPLE1(id)
  end
  if qData[1509].state == 1 then
    NPC_WARP_SILENCE_TEMPLE2(id)
  end
  if qData[1511].state == 1 then
    NPC_WARP_SILENCE_TEMPLE3(id)
  end
  if qData[1508].state == 1 then
    NPC_WARP_SILENCE_TEMPLE1(id)
  end
  if qData[1510].state == 1 then
    NPC_WARP_SILENCE_TEMPLE2(id)
  end
  if qData[1512].state == 1 then
    NPC_WARP_SILENCE_TEMPLE3(id)
  end
  if qData[2609].state == 1 then
    NPC_WARP_SILENCE_TEMPLE1(id)
  end
  if qData[2610].state == 1 then
    NPC_WARP_SILENCE_TEMPLE2(id)
  end
  if qData[2611].state == 1 then
    NPC_WARP_SILENCE_TEMPLE3(id)
  end
  if qData[2615].state == 1 then
    NPC_WARP_SILENCE_TEMPLE1(id)
  end
  if qData[2616].state == 1 then
    NPC_WARP_SILENCE_TEMPLE2(id)
  end
  if qData[2617].state == 1 then
    NPC_WARP_SILENCE_TEMPLE3(id)
  end
  if qData[1507].state == 0 and SET_PLAYER_SEX() == 1 and GET_PLAYER_JOB1() == 7 then
    ADD_QUEST_BTN(qt[1507].id, qt[1507].name)
  end
  if qData[1508].state == 0 and SET_PLAYER_SEX() == 2 and GET_PLAYER_JOB1() == 7 then
    ADD_QUEST_BTN(qt[1508].id, qt[1508].name)
  end
  if qData[1509].state == 0 and qData[1507].state == 2 and SET_PLAYER_SEX() == 1 then
    ADD_QUEST_BTN(qt[1509].id, qt[1509].name)
  end
  if qData[1510].state == 0 and qData[1508].state == 2 and SET_PLAYER_SEX() == 2 then
    ADD_QUEST_BTN(qt[1510].id, qt[1510].name)
  end
  if qData[1511].state == 0 and qData[1509].state == 2 and SET_PLAYER_SEX() == 1 then
    ADD_QUEST_BTN(qt[1511].id, qt[1511].name)
  end
  if qData[1512].state == 0 and qData[1510].state == 2 and SET_PLAYER_SEX() == 2 then
    ADD_QUEST_BTN(qt[1512].id, qt[1512].name)
  end
  if GET_PLAYER_JOB1() == 6 then
    if SET_PLAYER_SEX() == 1 then
      if qData[2609].state == 0 then
        ADD_QUEST_BTN(qt[2609].id, qt[2609].name)
      end
      if qData[2610].state == 0 and qData[2609].state == 2 then
        ADD_QUEST_BTN(qt[2610].id, qt[2610].name)
      end
      if qData[2611].state == 0 and qData[2610].state == 2 then
        ADD_QUEST_BTN(qt[2611].id, qt[2611].name)
      end
    end
    if SET_PLAYER_SEX() == 2 then
      if qData[2615].state == 0 then
        ADD_QUEST_BTN(qt[2615].id, qt[2615].name)
      end
      if qData[2616].state == 0 and qData[2615].state == 2 then
        ADD_QUEST_BTN(qt[2616].id, qt[2616].name)
      end
      if qData[2617].state == 0 and qData[2616].state == 2 then
        ADD_QUEST_BTN(qt[2617].id, qt[2617].name)
      end
    end
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1507].state ~= 2 and SET_PLAYER_SEX() == 1 and GET_PLAYER_JOB1() == 7 then
    if qData[1507].state == 1 then
      if qData[1507].killMonster[qt[1507].goal.killMonster[1].id] >= qt[1507].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1508].state ~= 2 and SET_PLAYER_SEX() == 2 and GET_PLAYER_JOB1() == 7 then
    if qData[1508].state == 1 then
      if qData[1508].killMonster[qt[1508].goal.killMonster[1].id] >= qt[1508].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1509].state ~= 2 and qData[1507].state == 2 then
    if qData[1509].state == 1 then
      if qData[1509].killMonster[qt[1509].goal.killMonster[1].id] >= qt[1509].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1510].state ~= 2 and qData[1508].state == 2 then
    if qData[1510].state == 1 then
      if qData[1510].killMonster[qt[1510].goal.killMonster[1].id] >= qt[1510].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1511].state ~= 2 and qData[1509].state == 2 then
    if qData[1511].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1512].state ~= 2 and qData[1510].state == 2 then
    if qData[1512].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if GET_PLAYER_JOB1() == 6 then
    if SET_PLAYER_SEX() == 1 then
      if qData[2609].state ~= 2 then
        if qData[2609].state == 1 then
          if qData[2609].killMonster[qt[2609].goal.killMonster[1].id] >= qt[2609].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[2610].state ~= 2 and qData[2609].state == 2 then
        if qData[2610].state == 1 then
          QSTATE(id, 1)
        else
          QSTATE(id, 0)
        end
      end
      if qData[2611].state ~= 2 and qData[2610].state == 2 then
        if qData[2611].state == 1 then
          QSTATE(id, 1)
        else
          QSTATE(id, 0)
        end
      end
    end
    if SET_PLAYER_SEX() == 2 then
      if qData[2615].state ~= 2 then
        if qData[2615].state == 1 then
          if qData[2615].killMonster[qt[2615].goal.killMonster[1].id] >= qt[2615].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[2616].state ~= 2 and qData[2615].state == 2 then
        if qData[2616].state == 1 then
          QSTATE(id, 1)
        else
          QSTATE(id, 0)
        end
      end
      if qData[2617].state ~= 2 and qData[2616].state == 2 then
        if qData[2617].state == 1 then
          QSTATE(id, 1)
        else
          QSTATE(id, 0)
        end
      end
    end
  end
end
