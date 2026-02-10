function npcsay(id)
  if id ~= 4314020 then
    return
  end
  clickNPCid = id
  if qData[112].state == 1 and CHECK_ITEM_CNT(qt[112].goal.getItem[1].id) >= qt[112].goal.getItem[1].count then
    NPC_SAY("是饱含大地之力的李无极的精气啊。这下可以好好的祭祀了。现在试着创建门派吧。准备好了吗？")
    SET_QUEST_STATE(112, 2)
    return
  end
  if qData[123].state == 1 then
    if CHECK_ITEM_CNT(qt[123].goal.getItem[1].id) >= qt[123].goal.getItem[1].count and CHECK_ITEM_CNT(qt[123].goal.getItem[2].id) >= qt[123].goal.getItem[2].count then
      NPC_SAY("你很好的掌控了弱者内心的愤怒。按照约定，我来教你飞龙掌。")
      SET_QUEST_STATE(123, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[ 受伤的工人 ]{END}在龙林谷入口，{0xFFFFFF00}[ 冥珠城宝芝林 ]{END}在冥珠城东。去帮助他们后获取证书和证明。记住要控制自己的愤怒。")
    end
  end
  if qData[124].state == 1 then
    if CHECK_ITEM_CNT(qt[124].goal.getItem[1].id) >= qt[124].goal.getItem[1].count and CHECK_ITEM_CNT(qt[124].goal.getItem[2].id) >= qt[124].goal.getItem[2].count then
      NPC_SAY("你很好的掌控了弱者内心的愤怒。按照约定，我来教你飞龙掌。")
      SET_QUEST_STATE(124, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[ 受伤的工人 ]{END}在龙林谷入口，{0xFFFFFF00}[ 冥珠城宝芝林 ]{END}在冥珠城东。去帮助他们后获取证书和证明。记住要控制自己的愤怒。")
    end
  end
  if qData[125].state == 1 then
    if CHECK_ITEM_CNT(qt[125].goal.getItem[1].id) >= qt[125].goal.getItem[1].count and CHECK_ITEM_CNT(qt[125].goal.getItem[2].id) >= qt[125].goal.getItem[2].count then
      NPC_SAY("你很好的掌控了弱者内心的愤怒。按照约定，我来教你飞龙掌。")
      SET_QUEST_STATE(125, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[ 受伤的工人 ]{END}在龙林谷入口，{0xFFFFFF00}[ 冥珠城宝芝林 ]{END}在冥珠城东。去帮助他们后获取证书和证明。记住要控制自己的愤怒。")
    end
  end
  if qData[382].state == 1 then
    if CHECK_ITEM_CNT(qt[382].goal.getItem[1].id) >= qt[382].goal.getItem[1].count and CHECK_ITEM_CNT(qt[382].goal.getItem[2].id) >= qt[382].goal.getItem[2].count then
      NPC_SAY("你很好的掌控了弱者内心的愤怒。按照约定，我来教你飞龙掌。")
      SET_QUEST_STATE(382, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[ 受伤的工人 ]{END}在龙林谷入口，{0xFFFFFF00}[ 冥珠城宝芝林 ]{END}在冥珠城东。去帮助他们后获取证书和证明。记住要控制自己的愤怒。")
    end
  end
  if qData[631].state == 1 then
    if CHECK_ITEM_CNT(qt[631].goal.getItem[1].id) >= qt[631].goal.getItem[1].count and CHECK_ITEM_CNT(qt[631].goal.getItem[2].id) >= qt[631].goal.getItem[2].count then
      NPC_SAY("你很好的掌控了弱者内心的愤怒。按照约定，我来教你飞龙掌。")
      SET_QUEST_STATE(631, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[ 受伤的工人 ]{END}在龙林谷入口，{0xFFFFFF00}[ 冥珠城宝芝林 ]{END}在冥珠城东。去帮助他们后获取证书和证明。记住要控制自己的愤怒。")
    end
  end
  if qData[2087].state == 1 then
    if CHECK_ITEM_CNT(qt[2087].goal.getItem[1].id) >= qt[2087].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2087].goal.getItem[2].id) >= qt[2087].goal.getItem[2].count then
      NPC_SAY("从弱者身上受到的愤怒控制的很好啊。按照约定，我现在教你飞龙掌")
      SET_QUEST_STATE(2087, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[受伤的工人]{END}在龙林谷入口处，{0xFFFFFF00}[冥珠城宝芝林]{END}在冥珠城东。帮助他们后拿来证书和证明吧。不要忘了控制愤怒的力量。")
    end
  end
  if qData[64].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[64].goal.getItem) then
      NPC_SAY("原来是冥珠城宝芝林的推荐书啊。不错，你有资格成为邪派人。以后身为邪派人要有自豪感，飘荡江湖，尽情享受吧。哈哈哈。")
      SET_MEETNPC(64, 2, id)
      SET_QUEST_STATE(64, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}冥珠城宝芝林那里拿推荐书{END}。")
    end
  end
  if GET_PLAYER_FACTION() == 0 then
    NPC_SAY("你看着很适合正派，去正派看看吧。")
  elseif CHECK_GUILD_MYUSER() == 0 then
    NPC_SAY("你看着很适合正派，去正派看看吧。")
  elseif GET_PLAYER_JOB1() == 0 then
    NPC_SAY("没有职业不能选择派系。")
  elseif GET_PLAYER_FACTION() == -1 then
    if qData[60].state == 0 and qData[64].state == 0 then
      if GET_PLAYER_LEVEL() >= qt[64].needLevel then
        ADD_QUEST_BTN(qt[64].id, qt[64].name)
      else
        NPC_SAY("呵。还是个毛小孩儿啊。这种程度的功力要加入邪派还早着呢。")
      end
    elseif qData[64].state == 1 then
      NPC_SAY("去见{0xFFFFFF00}冥珠城宝芝林{END}了吗？")
    else
      NPC_SAY("你看着很适合正派，去正派看看吧。")
    end
  elseif GET_PLAYER_FACTION() == -1 then
    NPC_SAY("唯有力量才是江湖的秩序。所谓力量也可以让我们获得我们想要的东西。可不要像看怪物一样看我。我们邪派在和怪物们的战争当中最为活跃。哈哈哈！")
  end
  if qData[170].state == 1 then
    if CHECK_ITEM_CNT(qt[170].goal.getItem[1].id) >= qt[170].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("你具备了击退怪物的能力。很好。那么我们正式进行考验吧。")
        SET_QUEST_STATE(170, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("修行时间的长短说明了你的实力。想转职的话拿{0xFFFFFF00}1张鸡冠呛符咒{END}来吧。")
    end
  end
  if qData[171].state == 1 then
    if qData[171].meetNpc[1] == qt[171].goal.meetNpc[1] then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("干得不错。其实我准备了很多考验，不过以你现在的水平应该没问题了。如果你再通过这个考验，我就帮你转职。")
        SET_QUEST_STATE(171, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("心不静的人钓不上来鱼。一边钓{0xFFFFFF00}真鲷{END}一边修心养性吧。还有记得钓{0xFFFF0000}1条{END}真鲷交给偷笔怪盗。")
    end
  end
  if qData[172].state == 1 then
    if GET_PLAYER_FAME() >= qt[172].goal.fame then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。现在你是黑客了。不要忘了自己的初衷，要相信自己，要不停的回想自己为什么选择了这条路。")
        SET_QUEST_STATE(172, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("还没完成吗？要{0xFFFFFF00}名声达到100{END}可不是容易的事情。再接再厉吧。")
    end
  end
  if qData[176].state == 1 then
    if CHECK_ITEM_CNT(qt[176].goal.getItem[1].id) >= qt[176].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("你具备了击退怪物的能力。很好。那么我们正式进行考验吧。")
        SET_QUEST_STATE(176, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("修行时间的长短说明了你的实力。想转职的话拿{0xFFFFFF00}1张鸡冠呛符咒{END}来吧。")
    end
  end
  if qData[177].state == 1 then
    if qData[177].meetNpc[1] == qt[177].goal.meetNpc[1] then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("干得不错。其实我准备了很多考验，不过以你现在的水平应该没问题了。如果你再通过这个考验，我就帮你转职。")
        SET_QUEST_STATE(177, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("心不静的人钓不上来鱼。一边钓{0xFFFFFF00}真鲷{END}一边修心养性吧。还有记得钓{0xFFFF0000}1条{END}真鲷交给偷笔怪盗。")
    end
  end
  if qData[178].state == 1 then
    if GET_PLAYER_FAME() >= qt[178].goal.fame then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。现在你是杀手了。不要忘了自己的初衷，要相信自己，要不停的回想自己为什么选择了这条路。")
        SET_QUEST_STATE(178, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("还没完成吗？要{0xFFFFFF00}名声达到100{END}可不是容易的事情。再接再厉吧。")
    end
  end
  if qData[182].state == 1 then
    if CHECK_ITEM_CNT(qt[182].goal.getItem[1].id) >= qt[182].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("你具备了击退怪物的能力。很好。那么我们正式进行考验吧。嗯。")
        SET_QUEST_STATE(182, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("修行时间的长短说明了你的实力。想转职的话拿{0xFFFFFF00}1张鸡冠呛符咒{END}来吧。")
    end
  end
  if qData[183].state == 1 then
    if qData[183].meetNpc[1] == qt[183].goal.meetNpc[1] then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("干得不错。其实我准备了很多考验，不过以你现在的水平应该没问题了。如果你再通过这个考验，我就帮你转职。")
        SET_QUEST_STATE(183, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("心不静的人钓不上来鱼。一边钓{0xFFFFFF00}真鲷{END}一边修心养性吧。还有记得钓{0xFFFF0000}1条交给偷笔怪盗{END}。")
    end
  end
  if qData[184].state == 1 then
    if GET_PLAYER_FAME() >= qt[184].goal.fame then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。现在你是{0xFF36B8C2}黑马道士{END}了。不要忘了自己的初衷，要相信自己，要不停的回想自己为什么选择了这条路。")
        SET_QUEST_STATE(184, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("还没完成吗？要{0xFFFFFF00}名声达到100{END}可不是容易的事情。再接再厉吧。")
    end
  end
  if qData[386].state == 1 then
    if CHECK_ITEM_CNT(qt[386].goal.getItem[1].id) >= qt[386].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("这么快就收集回来了啊。我很喜欢！那就正式的接受考验吧。")
        SET_QUEST_STATE(386, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("修行时间的长短说明了你的实力。想转职的话拿{0xFFFFFF00}1张鸡冠呛符咒{END}来吧。")
    end
  end
  if qData[387].state == 1 then
    if qData[387].meetNpc[1] == qt[387].goal.meetNpc[1] then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("干得不错。其实我准备了很多考验，不过以你现在的水平应该没问题了。如果你再通过这个考验，我就帮你转职。")
        SET_QUEST_STATE(387, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("心不静的人钓不上来鱼。一边钓{0xFFFFFF00}真鲷{END}一边修心养性吧。还有记得钓{0xFFFF0000}1条交给偷笔怪盗{END}。")
    end
  end
  if qData[388].state == 1 then
    if GET_PLAYER_FAME() >= qt[388].goal.fame then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。现在你是天马斗士了。不要忘了自己的初衷，要相信自己，要不停的回想自己为什么选择了这条路。")
        SET_QUEST_STATE(388, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("还没完成吗？要名声达到100可不是容易的事情。再接再厉吧。")
    end
  end
  if qData[636].state == 1 then
    if CHECK_ITEM_CNT(qt[636].goal.getItem[1].id) >= qt[636].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("你通过了第一次考验。但这仅仅是考验的开始。")
        SET_QUEST_STATE(636, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("拿来{0xFFFFFF00}1张鸡冠呛符咒{END}吧。这是为了考验你有没有充分的修炼到更上一层楼的能力。")
    end
  end
  if qData[637].state == 1 then
    if CHECK_ITEM_CNT(qt[637].goal.getItem[1].id) >= qt[637].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。你通过了第二次考验。现在还剩了第三次考验。")
        SET_QUEST_STATE(637, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("通过钓鱼给我钓来{0xFFFFFF00}一条真鲷{END}吧。")
    end
  end
  if qData[638].state == 1 then
    if GET_PLAYER_FAME() >= qt[638].goal.fame then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。你已经达到黑镖手的境界了，黑镖手的义务和射手的义务没什么差异。始终要谨记自己的初衷，尽到黑镖手的义务。")
        SET_QUEST_STATE(638, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("还没完成吗？要{0xFFFFFF00}名声达到100{END}可不是容易的事情。再接再厉吧。")
    end
  end
  if qData[2093].state == 1 then
    if CHECK_ITEM_CNT(qt[2093].goal.getItem[1].id) >= qt[2093].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("你通过了第一次考验。但这仅仅是考验的开始。")
        SET_QUEST_STATE(2093, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("拿来{0xFFFFFF00}1张鸡冠呛符咒{END}吧。这是为了考验你有没有充分的修炼到更上一层楼的能力。")
    end
  end
  if qData[2094].state == 1 then
    if qData[2094].meetNpc[1] == qt[2094].goal.meetNpc[1] then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。你通过了第二次考验。现在还剩了第三次考验。")
        SET_QUEST_STATE(2094, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("通过钓鱼给我钓来{0xFFFFFF00}一条真鲷{END}吧。")
    end
  end
  if qData[2095].state == 1 then
    if GET_PLAYER_FAME() >= qt[2095].goal.fame then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。你已经达到黑镖手的境界了，黑镖手的义务和射手的义务没什么差异。始终要谨记自己的初衷，尽到黑镖手的义务。")
        SET_QUEST_STATE(2095, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("还没完成吗？要{0xFFFFFF00}名声达到100{END}可不是容易的事情。再接再厉吧。")
    end
  end
  if qData[367].state == 1 or qData[368].state == 1 or qData[369].state == 1 or qData[370].state == 1 or qData[630].state == 1 or qData[2086].state == 1 then
    if qData[367].killMonster[qt[367].goal.killMonster[1].id] >= qt[367].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}[ 狗骨头 ]{END}可不是能小看的对手啊，你竟能击退 {0xFFFFFF00}2个{END}，真的很了不起啊。希望能按照 {0xFFFFFF00}[ 太和老君 ]{END}的意思，对击退妖怪有所帮助…。")
      SET_QUEST_STATE(367, 2)
      return
    elseif qData[368].killMonster[qt[368].goal.killMonster[1].id] >= qt[368].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}[ 狗骨头 ]{END}可不是能小看的对手啊，你竟能击退 {0xFFFFFF00}2个{END}，真的很了不起啊。希望能按照 {0xFFFFFF00}[ 太和老君 ]{END}的意思，对击退妖怪有所帮助…。")
      SET_QUEST_STATE(368, 2)
      return
    elseif qData[369].killMonster[qt[369].goal.killMonster[1].id] >= qt[369].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}[ 狗骨头 ]{END}可不是能小看的对手啊，你竟能击退 {0xFFFFFF00}2个{END}，真的很了不起啊。希望能按照 {0xFFFFFF00}[ 太和老君 ]{END}的意思，对击退妖怪有所帮助…。")
      SET_QUEST_STATE(369, 2)
      return
    elseif qData[370].killMonster[qt[370].goal.killMonster[1].id] >= qt[370].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}[ 狗骨头 ]{END}可不是能小看的对手啊，你竟能击退 {0xFFFFFF00}2个{END}，真的很了不起啊。希望能按照 {0xFFFFFF00}[ 太和老君 ]{END}的意思，对击退妖怪有所帮助…。")
      SET_QUEST_STATE(370, 2)
      return
    elseif qData[630].killMonster[qt[630].goal.killMonster[1].id] >= qt[630].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}[ 狗骨头 ]{END}可不是能小看的对手啊，你竟能击退 {0xFFFFFF00}2个{END}，真的很了不起啊。希望能按照 {0xFFFFFF00}[ 太和老君 ]{END}的意思，对击退妖怪有所帮助…。")
      SET_QUEST_STATE(630, 2)
      return
    elseif qData[2086].killMonster[qt[2086].goal.killMonster[1].id] >= qt[2086].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}[ 狗骨头 ]{END}可不是能小看的对手啊，你竟能击退 {0xFFFFFF00}2个{END}，真的很了不起啊。希望能按照 {0xFFFFFF00}[ 太和老君 ]{END}的意思，对击退妖怪有所帮助…。")
      SET_QUEST_STATE(2086, 2)
      return
    else
      NPC_SAY("至少要具备击退{0xFFFFFF00}2只[ 狗骨头 ]{END}的能力。速去速回吧。")
    end
  end
  if qData[375].state == 1 or qData[376].state == 1 or qData[377].state == 1 or qData[378].state == 1 or qData[632].state == 1 or qData[2088].state == 1 then
    if qData[375].killMonster[qt[375].goal.killMonster[1].id] >= qt[375].goal.killMonster[1].count then
      NPC_SAY("实力真的很出众啊。你有学习{0xFFFFFF00}[ 天然聚气 ]{END}的资格。好好利用这武功击退妖怪吧。")
      SET_QUEST_STATE(375, 2)
      return
    elseif qData[376].killMonster[qt[376].goal.killMonster[1].id] >= qt[376].goal.killMonster[1].count then
      NPC_SAY("实力真的很出众啊。你有学习{0xFFFFFF00}[ 天然聚气 ]{END}的资格。好好利用这武功击退妖怪吧。")
      SET_QUEST_STATE(376, 2)
      return
    elseif qData[377].killMonster[qt[377].goal.killMonster[1].id] >= qt[377].goal.killMonster[1].count then
      NPC_SAY("实力真的很出众啊。你有学习{0xFFFFFF00}[ 天然聚气 ]{END}的资格。好好利用这武功击退妖怪吧。")
      SET_QUEST_STATE(377, 2)
      return
    elseif qData[378].killMonster[qt[378].goal.killMonster[1].id] >= qt[378].goal.killMonster[1].count then
      NPC_SAY("实力真的很出众啊。你有学习{0xFFFFFF00}[ 天然聚气 ]{END}的资格。好好利用这武功击退妖怪吧。")
      SET_QUEST_STATE(378, 2)
      return
    elseif qData[632].killMonster[qt[632].goal.killMonster[1].id] >= qt[632].goal.killMonster[1].count then
      NPC_SAY("实力真的很出众啊。你有学习{0xFFFFFF00}[ 天然聚气 ]{END}的资格。好好利用这武功击退妖怪吧。")
      SET_QUEST_STATE(632, 2)
      return
    elseif qData[2088].killMonster[qt[2088].goal.killMonster[1].id] >= qt[2088].goal.killMonster[1].count then
      NPC_SAY("实力真的很出众啊。你有学习{0xFFFFFF00}[ 天然聚气 ]{END}的资格。好好利用这武功击退妖怪吧。")
      SET_QUEST_STATE(2088, 2)
      return
    else
      NPC_SAY("到了能击退{0xFFFFFF00}2个[ 鸡冠呛 ]{END}的实力，才可以学习{0xFFFFFF00}[ 天然聚气 ]{END}。")
    end
  end
  if qData[1073].state == 1 then
    if qData[1073].meetNpc[1] ~= qt[1073].goal.meetNpc[1] and qData[803].state == 2 then
      NPC_SAY("你做到了。这样你就能接收太和老君改进的武功了…你的气血已经打开，等到达合适的功力就可以逐一习得武功。关于泰和武功我会另外向你详细说明的 ")
      SET_QUEST_STATE(1073, 2)
      return
    else
      NPC_SAY("还没有完成汉谟拉比商人处的暗血地狱相关任务么？还是已经过去一天了？快去完成任务吧。完成后马上来我这里 ")
    end
  end
  if qData[1121].state == 1 and qData[1121].meetNpc[1] == qt[1121].goal.meetNpc[1] and qData[1121].meetNpc[2] ~= id then
    NPC_SAY("推荐书？那些有什么用啊！想要提高声望，只要证明实力不就可以了吗？总之以后有什么事情会联系你的。（现在回到清阴银行吧。）")
    SET_MEETNPC(1121, 2, id)
  end
  if qData[1123].state == 1 then
    NPC_SAY("来了？正在找你呢。")
    SET_QUEST_STATE(1123, 2)
  end
  if qData[1124].state == 1 then
    if CHECK_ITEM_CNT(qt[1124].goal.getItem[1].id) >= qt[1124].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("是真的啊。确实的证明的你的实力。")
        SET_QUEST_STATE(1124, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("是去击退清阴谷的螳螂勇勇收集5个[ 勇勇的前脚 ]。")
    end
  end
  if qData[1125].state == 1 then
    if CHECK_ITEM_CNT(qt[1125].goal.getItem[1].id) >= qt[1125].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("实力不错啊。我认可了。")
        SET_QUEST_STATE(1125, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("我分明说过让你去北清阴平原击退雨伞标收集{0xFFFFFF00}10个[ 破烂的雨伞 ]{END}的。")
    end
  end
  if qData[1126].state == 1 then
    NPC_SAY("还没去吗？白斩姬在清阴关南边的正派建筑里。")
  end
  if qData[1145].state == 1 and qData[1145].meetNpc[1] == qt[1145].goal.meetNpc[1] and qData[1145].meetNpc[2] ~= id then
    NPC_SAY("来的不是时候啊。在做的事情做完之后来找我吧。")
    SET_MEETNPC(1145, 2, id)
  end
  if qData[1147].state == 1 then
    if CHECK_ITEM_CNT(qt[1147].goal.getItem[1].id) >= qt[1147].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("谢谢了。虽然不多，还是收下吧。")
        SET_QUEST_STATE(1147, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("击退芦苇林的鸟人，收集10个左右的[ 鸟人的蛋 ]就可以了。")
    end
  end
  if qData[1149].state == 1 then
    NPC_SAY("路边摊喜欢到处炫耀，应该很容易知道弱点。")
  end
  if qData[1153].state == 1 then
    NPC_SAY("去见清江村的清江村厨师调查详细的情况吧。")
  end
  if qData[1177].state == 1 and CHECK_ITEM_CNT(qt[1177].goal.getItem[1].id) >= qt[1177].goal.getItem[1].count then
    if 1 <= CHECK_INVENTORY_CNT(3) then
      NPC_SAY("[ 破旧的铲柄 ]？看来是清江村厨师那家伙骗了你。他好像很喜欢你呢？哈哈哈！")
      SET_QUEST_STATE(1177, 2)
    else
      NPC_SAY("行囊太沉。")
    end
  end
  if qData[1179].state == 1 then
    if CHECK_ITEM_CNT(qt[1179].goal.getItem[1].id) >= qt[1179].goal.getItem[1].count then
      NPC_SAY("辛苦了。现在就剩下正式的击退猪大长的事情了。")
      SET_QUEST_STATE(1179, 2)
    else
      NPC_SAY("在芦苇林击退红毛龟，收集15个[ 红毛龟的壳 ]回来吧。就此猪大长的兵力也会消失大部分。")
    end
  end
  if qData[1400].state == 1 then
    NPC_SAY("??? ??? ?? ???????? ????? ? ??? ?? ??? ????? ??? ???!")
  end
  if qData[1403].state == 1 then
    NPC_SAY("????? ????! ? ?? ????? ?? ??????? ????? ???! ???? ????!")
    SET_QUEST_STATE(1403, 2)
  end
  if qData[1404].state == 1 then
    if CHECK_ITEM_CNT(qt[1404].goal.getItem[1].id) >= qt[1404].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("????. ??? ??  ????? 5?? ???? ???? 1?? ?? ? ???, ??? ??? ?? ???? ???.")
        SET_QUEST_STATE(1404, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("??? ????? 10?? ?????. ??? ?? ???? ????? ????.")
    end
  end
  if qData[2053].state == 1 then
    SET_QUEST_STATE(2053, 2)
    NPC_SAY("是你啊~比传闻看着弱了一点？")
  end
  if qData[2054].state == 1 then
    NPC_SAY("嗯..好吧..军事们有了新的营地？知道了。我会通知情报员重新建立情报网的。你回去告诉[佣兵领袖]吧")
  end
  if GET_PLAYER_FACTION() == 1 and CHECK_GUILD_MYUSER() == -1 and qData[112].state == 0 then
    ADD_QUEST_BTN(qt[112].id, qt[112].name)
  end
  if GET_PLAYER_FACTION() == 1 then
    if qData[123].state == 0 and GET_PLAYER_JOB1() == 1 then
      ADD_QUEST_BTN(qt[123].id, qt[123].name)
    end
    if qData[124].state == 0 and GET_PLAYER_JOB1() == 2 then
      ADD_QUEST_BTN(qt[124].id, qt[124].name)
    end
    if qData[125].state == 0 and GET_PLAYER_JOB1() == 3 then
      ADD_QUEST_BTN(qt[125].id, qt[125].name)
    end
    if qData[382].state == 0 and GET_PLAYER_JOB1() == 4 then
      ADD_QUEST_BTN(qt[382].id, qt[382].name)
    end
    if qData[631].state == 0 and GET_PLAYER_JOB1() == 5 then
      ADD_QUEST_BTN(qt[631].id, qt[631].name)
    end
    if qData[2087].state == 0 and GET_PLAYER_JOB1() == 11 then
      ADD_QUEST_BTN(qt[2087].id, qt[2087].name)
    end
    if qData[367].state == 0 and GET_PLAYER_JOB1() == 1 then
      ADD_QUEST_BTN(qt[367].id, qt[367].name)
    end
    if qData[368].state == 0 and GET_PLAYER_JOB1() == 2 then
      ADD_QUEST_BTN(qt[368].id, qt[368].name)
    end
    if qData[369].state == 0 and GET_PLAYER_JOB1() == 3 then
      ADD_QUEST_BTN(qt[369].id, qt[369].name)
    end
    if qData[370].state == 0 and GET_PLAYER_JOB1() == 4 then
      ADD_QUEST_BTN(qt[370].id, qt[370].name)
    end
    if qData[630].state == 0 and GET_PLAYER_JOB1() == 5 then
      ADD_QUEST_BTN(qt[630].id, qt[630].name)
    end
    if qData[375].state == 0 and GET_PLAYER_JOB1() == 1 then
      ADD_QUEST_BTN(qt[375].id, qt[375].name)
    end
    if qData[2086].state == 0 and GET_PLAYER_JOB1() == 11 then
      ADD_QUEST_BTN(qt[2086].id, qt[2086].name)
    end
    if qData[376].state == 0 and GET_PLAYER_JOB1() == 2 then
      ADD_QUEST_BTN(qt[376].id, qt[376].name)
    end
    if qData[377].state == 0 and GET_PLAYER_JOB1() == 3 then
      ADD_QUEST_BTN(qt[377].id, qt[377].name)
    end
    if qData[378].state == 0 and GET_PLAYER_JOB1() == 4 then
      ADD_QUEST_BTN(qt[378].id, qt[378].name)
    end
    if qData[632].state == 0 and GET_PLAYER_JOB1() == 5 then
      ADD_QUEST_BTN(qt[632].id, qt[632].name)
    end
    if qData[2088].state == 0 and GET_PLAYER_JOB1() == 11 then
      ADD_QUEST_BTN(qt[2088].id, qt[2088].name)
    end
    if qData[1331].state == 0 and GET_PLAYER_JOB1() == 1 then
      ADD_QUEST_BTN(qt[1331].id, qt[1331].name)
    end
    if qData[1332].state == 0 and GET_PLAYER_JOB1() == 2 then
      ADD_QUEST_BTN(qt[1332].id, qt[1332].name)
    end
    if qData[1333].state == 0 and GET_PLAYER_JOB1() == 3 then
      ADD_QUEST_BTN(qt[1333].id, qt[1333].name)
    end
    if qData[1334].state == 0 and GET_PLAYER_JOB1() == 4 then
      ADD_QUEST_BTN(qt[1334].id, qt[1334].name)
    end
    if qData[1335].state == 0 and GET_PLAYER_JOB1() == 5 then
      ADD_QUEST_BTN(qt[1335].id, qt[1335].name)
    end
    if qData[2089].state == 0 and GET_PLAYER_JOB1() == 11 then
      ADD_QUEST_BTN(qt[2089].id, qt[2089].name)
    end
    if GET_PLAYER_JOB1() == 1 then
      if qData[170].state == 0 then
        ADD_QUEST_BTN(qt[170].id, qt[170].name)
      end
      if qData[171].state == 0 and qData[170].state == 2 then
        ADD_QUEST_BTN(qt[171].id, qt[171].name)
      end
      if qData[172].state == 0 and qData[171].state == 2 then
        ADD_QUEST_BTN(qt[172].id, qt[172].name)
      end
    elseif GET_PLAYER_JOB1() == 2 then
      if qData[176].state == 0 then
        ADD_QUEST_BTN(qt[176].id, qt[176].name)
      end
      if qData[177].state == 0 and qData[176].state == 2 then
        ADD_QUEST_BTN(qt[177].id, qt[177].name)
      end
      if qData[178].state == 0 and qData[177].state == 2 then
        ADD_QUEST_BTN(qt[178].id, qt[178].name)
      end
    elseif GET_PLAYER_JOB1() == 3 then
      if qData[182].state == 0 then
        ADD_QUEST_BTN(qt[182].id, qt[182].name)
      end
      if qData[183].state == 0 and qData[182].state == 2 then
        ADD_QUEST_BTN(qt[183].id, qt[183].name)
      end
      if qData[184].state == 0 and qData[183].state == 2 then
        ADD_QUEST_BTN(qt[184].id, qt[184].name)
      end
    elseif GET_PLAYER_JOB1() == 4 then
      if qData[386].state == 0 then
        ADD_QUEST_BTN(qt[386].id, qt[386].name)
      end
      if qData[387].state == 0 and qData[386].state == 2 then
        ADD_QUEST_BTN(qt[387].id, qt[387].name)
      end
      if qData[388].state == 0 and qData[387].state == 2 then
        ADD_QUEST_BTN(qt[388].id, qt[388].name)
      end
    elseif GET_PLAYER_JOB1() == 5 then
      if qData[636].state == 0 then
        ADD_QUEST_BTN(qt[636].id, qt[636].name)
      end
      if qData[637].state == 0 and qData[636].state == 2 then
        ADD_QUEST_BTN(qt[637].id, qt[637].name)
      end
      if qData[638].state == 0 and qData[637].state == 2 then
        ADD_QUEST_BTN(qt[638].id, qt[638].name)
      end
    elseif GET_PLAYER_JOB1() == 11 then
      if qData[2093].state == 0 then
        ADD_QUEST_BTN(qt[2093].id, qt[2093].name)
      end
      if qData[2094].state == 0 and qData[2093].state == 2 then
        ADD_QUEST_BTN(qt[2094].id, qt[2094].name)
      end
      if qData[2095].state == 0 and qData[2094].state == 2 then
        ADD_QUEST_BTN(qt[2095].id, qt[2095].name)
      end
    end
  end
  if GET_PLAYER_JOB2() == 2 then
  end
  if qData[112].state == 2 then
    ADD_NPC_GUILD_CREATE(id)
  end
  if qData[1073].state == 0 and GET_PLAYER_FACTION() == 1 and 0 < GET_PLAYER_JOB2() then
    ADD_QUEST_BTN(qt[1073].id, qt[1073].name)
  end
  GET_NPC_GUILD_LIST(id)
  if qData[1123].state == 2 and qData[1124].state == 0 then
    ADD_QUEST_BTN(qt[1124].id, qt[1124].name)
  end
  if qData[1124].state == 2 and qData[1125].state == 0 then
    ADD_QUEST_BTN(qt[1125].id, qt[1125].name)
  end
  if qData[1125].state == 2 and qData[1126].state == 0 then
    ADD_QUEST_BTN(qt[1126].id, qt[1126].name)
  end
  if qData[1145].state == 2 and qData[1147].state == 0 then
    ADD_QUEST_BTN(qt[1147].id, qt[1147].name)
  end
  if qData[1147].state == 2 and qData[1149].state == 0 then
    ADD_QUEST_BTN(qt[1149].id, qt[1149].name)
  end
  if qData[1151].state == 2 and qData[1153].state == 0 then
    ADD_QUEST_BTN(qt[1153].id, qt[1153].name)
  end
  if qData[1177].state == 2 and qData[1179].state == 0 then
    ADD_QUEST_BTN(qt[1179].id, qt[1179].name)
  end
  if qData[2054].state == 0 and qData[2053].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2054].id, qt[2054].name)
  end
  if qData[955].state == 0 and 0 < GET_PLAYER_JOB2() then
    ADD_QUEST_BTN(qt[955].id, qt[955].name)
  end
  if qData[956].state == 0 and GET_PLAYER_JOB2() == 2 then
    ADD_QUEST_BTN(qt[956].id, qt[956].name)
  end
  if qData[957].state == 0 and GET_PLAYER_JOB2() == 4 then
    ADD_QUEST_BTN(qt[957].id, qt[957].name)
  end
  if qData[958].state == 0 and GET_PLAYER_JOB2() == 6 then
    ADD_QUEST_BTN(qt[958].id, qt[958].name)
  end
  if qData[959].state == 0 and GET_PLAYER_JOB2() == 8 then
    ADD_QUEST_BTN(qt[959].id, qt[959].name)
  end
  if qData[960].state == 0 and GET_PLAYER_JOB2() == 10 then
    ADD_QUEST_BTN(qt[960].id, qt[960].name)
  end
  if qData[1400].state == 0 and GET_PLAYER_FACTION() == 1 then
    ADD_QUEST_BTN(qt[1400].id, qt[1400].name)
  end
  if qData[1404].state == 0 and qData[1403].state == 2 then
    ADD_QUEST_BTN(qt[1404].id, qt[1404].name)
  end
  if qData[1404].state == 2 then
    ADD_EVENT_RICE_ROLL2(id)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[64].state ~= 2 and GET_PLAYER_LEVEL() >= qt[64].needLevel and GET_PLAYER_FACTION() == 1 and CHECK_GUILD_MYUSER() == 1 and GET_PLAYER_JOB1() > 0 then
    if qData[64].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[64].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if GET_PLAYER_FACTION() == 1 then
    if qData[123].state ~= 2 and GET_PLAYER_JOB1() == 1 and GET_PLAYER_LEVEL() >= qt[123].needLevel then
      if qData[123].state == 1 then
        if CHECK_ITEM_CNT(qt[123].goal.getItem[1].id) >= qt[123].goal.getItem[1].count and CHECK_ITEM_CNT(qt[123].goal.getItem[2].id) >= qt[123].goal.getItem[2].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[124].state ~= 2 and GET_PLAYER_JOB1() == 2 and GET_PLAYER_LEVEL() >= qt[124].needLevel then
      if qData[124].state == 1 then
        if CHECK_ITEM_CNT(qt[124].goal.getItem[1].id) >= qt[124].goal.getItem[1].count and CHECK_ITEM_CNT(qt[124].goal.getItem[2].id) >= qt[124].goal.getItem[2].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[125].state ~= 2 and GET_PLAYER_JOB1() == 3 and GET_PLAYER_LEVEL() >= qt[125].needLevel then
      if qData[125].state == 1 then
        if CHECK_ITEM_CNT(qt[125].goal.getItem[1].id) >= qt[125].goal.getItem[1].count and CHECK_ITEM_CNT(qt[125].goal.getItem[2].id) >= qt[125].goal.getItem[2].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[382].state ~= 2 and GET_PLAYER_JOB1() == 4 and GET_PLAYER_LEVEL() >= qt[382].needLevel then
      if qData[382].state == 1 then
        if CHECK_ITEM_CNT(qt[382].goal.getItem[1].id) >= qt[382].goal.getItem[1].count and CHECK_ITEM_CNT(qt[382].goal.getItem[2].id) >= qt[382].goal.getItem[2].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[631].state ~= 2 and GET_PLAYER_JOB1() == 5 and GET_PLAYER_LEVEL() >= qt[631].needLevel then
      if qData[631].state == 1 then
        if CHECK_ITEM_CNT(qt[631].goal.getItem[1].id) >= qt[631].goal.getItem[1].count and CHECK_ITEM_CNT(qt[631].goal.getItem[2].id) >= qt[631].goal.getItem[2].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[2087].state ~= 2 and GET_PLAYER_JOB1() == 11 and GET_PLAYER_LEVEL() >= qt[2087].needLevel then
      if qData[2087].state == 1 then
        if CHECK_ITEM_CNT(qt[2087].goal.getItem[1].id) >= qt[2087].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2087].goal.getItem[2].id) >= qt[2087].goal.getItem[2].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[1331].state ~= 2 and GET_PLAYER_JOB1() == 1 and GET_PLAYER_LEVEL() >= qt[1331].needLevel then
      if qData[1331].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
    if qData[1332].state ~= 2 and GET_PLAYER_JOB1() == 2 and GET_PLAYER_LEVEL() >= qt[1332].needLevel then
      if qData[1332].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
    if qData[1333].state ~= 2 and GET_PLAYER_JOB1() == 3 and GET_PLAYER_LEVEL() >= qt[1333].needLevel then
      if qData[1333].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
    if qData[1334].state ~= 2 and GET_PLAYER_JOB1() == 4 and GET_PLAYER_LEVEL() >= qt[1334].needLevel then
      if qData[1334].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
    if qData[1335].state ~= 2 and GET_PLAYER_JOB1() == 5 and GET_PLAYER_LEVEL() >= qt[1335].needLevel then
      if qData[1335].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
    if qData[2089].state ~= 2 and GET_PLAYER_JOB1() == 11 and GET_PLAYER_LEVEL() >= qt[2089].needLevel then
      if qData[2089].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
    if GET_PLAYER_JOB1() == 1 then
      if qData[170].state ~= 2 and GET_PLAYER_LEVEL() >= qt[170].needLevel then
        if qData[170].state == 1 then
          if CHECK_ITEM_CNT(qt[170].goal.getItem[1].id) >= qt[170].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[171].state ~= 2 and qData[170].state == 2 and GET_PLAYER_LEVEL() >= qt[171].needLevel then
        if qData[171].state == 1 then
          if qData[171].meetNpc[1] == qt[171].goal.meetNpc[1] then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[172].state ~= 2 and qData[171].state == 2 and GET_PLAYER_LEVEL() >= qt[172].needLevel then
        if qData[172].state == 1 then
          if GET_PLAYER_FAME() >= qt[172].goal.fame then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
    elseif GET_PLAYER_JOB1() == 2 then
      if qData[176].state ~= 2 and GET_PLAYER_LEVEL() >= qt[176].needLevel then
        if qData[176].state == 1 then
          if CHECK_ITEM_CNT(qt[176].goal.getItem[1].id) >= qt[176].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[177].state ~= 2 and qData[176].state == 2 and GET_PLAYER_LEVEL() >= qt[177].needLevel then
        if qData[177].state == 1 then
          if qData[177].meetNpc[1] == qt[177].goal.meetNpc[1] then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[178].state ~= 2 and qData[177].state == 2 and GET_PLAYER_LEVEL() >= qt[178].needLevel then
        if qData[178].state == 1 then
          if GET_PLAYER_FAME() >= qt[178].goal.fame then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
    elseif GET_PLAYER_JOB1() == 3 then
      if qData[182].state ~= 2 and GET_PLAYER_LEVEL() >= qt[182].needLevel then
        if qData[182].state == 1 then
          if CHECK_ITEM_CNT(qt[182].goal.getItem[1].id) >= qt[182].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[183].state ~= 2 and qData[182].state == 2 and GET_PLAYER_LEVEL() >= qt[183].needLevel then
        if qData[183].state == 1 then
          if qData[183].meetNpc[1] == qt[183].goal.meetNpc[1] then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[184].state ~= 2 and qData[183].state == 2 and GET_PLAYER_LEVEL() >= qt[184].needLevel then
        if qData[184].state == 1 then
          if GET_PLAYER_FAME() >= qt[184].goal.fame then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
    elseif GET_PLAYER_JOB1() == 4 then
      if qData[386].state ~= 2 and GET_PLAYER_LEVEL() >= qt[386].needLevel then
        if qData[386].state == 1 then
          if CHECK_ITEM_CNT(qt[386].goal.getItem[1].id) >= qt[386].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[387].state ~= 2 and qData[383].state == 2 and GET_PLAYER_LEVEL() >= qt[387].needLevel then
        if qData[387].state == 1 then
          if qData[387].meetNpc[1] == qt[387].goal.meetNpc[1] then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[388].state ~= 2 and qData[384].state == 2 and GET_PLAYER_LEVEL() >= qt[388].needLevel then
        if qData[388].state == 1 then
          if GET_PLAYER_FAME() >= qt[388].goal.fame then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
    elseif GET_PLAYER_JOB1() == 5 then
      if qData[636].state ~= 2 and GET_PLAYER_LEVEL() >= qt[636].needLevel then
        if qData[636].state == 1 then
          if CHECK_ITEM_CNT(qt[636].goal.getItem[1].id) >= qt[636].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[637].state ~= 2 and qData[636].state == 2 and GET_PLAYER_LEVEL() >= qt[637].needLevel then
        if qData[637].state == 1 then
          if CHECK_ITEM_CNT(qt[637].goal.getItem[1].id) >= qt[637].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[638].state ~= 2 and qData[637].state == 2 and GET_PLAYER_LEVEL() >= qt[638].needLevel then
        if qData[638].state == 1 then
          if GET_PLAYER_FAME() >= qt[638].goal.fame then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[2093].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2093].needLevel then
        if qData[2093].state == 1 then
          if CHECK_ITEM_CNT(qt[2093].goal.getItem[1].id) >= qt[2093].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[2094].state ~= 2 and qData[2093].state == 2 and GET_PLAYER_LEVEL() >= qt[2094].needLevel then
        if qData[2094].state == 1 then
          if CHECK_ITEM_CNT(qt[2094].goal.getItem[1].id) >= qt[2094].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[2095].state ~= 2 and qData[2094].state == 2 and GET_PLAYER_LEVEL() >= qt[2095].needLevel then
        if qData[2095].state == 1 then
          if GET_PLAYER_FAME() >= qt[2095].goal.fame then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
    end
  end
  if qData[1073].state ~= 2 and GET_PLAYER_FACTION() == 1 and 0 < GET_PLAYER_JOB2() then
    if qData[1073].state == 1 then
      if qData[1073].meetNpc[1] ~= qt[1073].goal.meetNpc[1] and qData[803].state == 2 then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[955].state == 0 and 0 < GET_PLAYER_JOB2() then
    QSTATE(id, true)
  end
  if qData[956].state == 0 and GET_PLAYER_JOB2() == 2 then
    QSTATE(id, true)
  end
  if qData[957].state == 0 and GET_PLAYER_JOB2() == 4 then
    QSTATE(id, true)
  end
  if qData[958].state == 0 and GET_PLAYER_JOB2() == 6 then
    QSTATE(id, true)
  end
  if qData[959].state == 0 and GET_PLAYER_JOB2() == 8 then
    QSTATE(id, true)
  end
  if qData[960].state == 0 and GET_PLAYER_JOB2() == 10 then
    QSTATE(id, true)
  end
  if qData[1120].state == 2 and qData[1121].state ~= 2 and qData[1121].state == 1 and qData[1121].meetNpc[1] == qt[1121].goal.meetNpc[1] and qData[1121].meetNpc[2] ~= id then
    QSTATE(id, 1)
  end
  if qData[1122].state == 2 and qData[1123].state ~= 2 and qData[1123].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1123].state == 2 and qData[1124].state ~= 2 then
    if qData[1124].state == 1 then
      if CHECK_ITEM_CNT(qt[1124].goal.getItem[1].id) >= qt[1124].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1124].state == 2 and qData[1125].state ~= 2 then
    if qData[1125].state == 1 then
      if CHECK_ITEM_CNT(qt[1125].goal.getItem[1].id) >= qt[1125].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1125].state == 2 and qData[1126].state ~= 2 then
    if qData[1126].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1145].state == 1 and qData[1145].meetNpc[1] == qt[1145].goal.meetNpc[1] and qData[1145].meetNpc[2] ~= id then
    QSTATE(id, 1)
  end
  if qData[1145].state == 2 and qData[1147].state ~= 2 then
    if qData[1147].state == 1 then
      if CHECK_ITEM_CNT(qt[1147].goal.getItem[1].id) >= qt[1147].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1147].state == 2 and qData[1149].state ~= 2 then
    if qData[1149].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1151].state == 2 and qData[1153].state ~= 2 then
    if qData[1153].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1175].state == 2 and qData[1177].state ~= 2 and qData[1177].state == 1 and CHECK_ITEM_CNT(qt[1177].goal.getItem[1].id) >= qt[1177].goal.getItem[1].count then
    QSTATE(id, 1)
  end
  if qData[1177].state == 2 and qData[1179].state ~= 2 then
    if qData[1179].state == 1 then
      if CHECK_ITEM_CNT(qt[1179].goal.getItem[1].id) >= qt[1179].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2053].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2054].state ~= 2 and qData[2053].state == 2 and GET_PLAYER_LEVEL() >= qt[2054].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2054].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
