function npcsay(id)
  if id ~= 4314021 then
    return
  end
  clickNPCid = id
  if qData[113].state == 1 and __QUEST_HAS_ALL_ITEMS(qt[113].goal.getItem) then
    NPC_SAY("吸收了无尽的土地精气的李无极的精气。可以好好地祭祀的。现在准备创建门派吧。准备好了吗？")
    SET_QUEST_STATE(113, 2)
    return
  end
  if qData[118].state == 1 then
    if CHECK_ITEM_CNT(qt[118].goal.getItem[1].id) >= qt[118].goal.getItem[1].count and CHECK_ITEM_CNT(qt[118].goal.getItem[2].id) >= qt[118].goal.getItem[2].count then
      NPC_SAY("你的义举为我们正派树立了形象。按照约定，我来教你{0xFFFFFF00}[ 飞龙掌 ]{END}。")
      SET_QUEST_STATE(118, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[ 受伤的工人 ]{END}在龙林谷入口，{0xFFFFFF00}[ 冥珠城宝芝林 ]{END}在冥珠城东。去帮助他们后获取证书和证明。")
    end
  end
  if qData[119].state == 1 then
    if CHECK_ITEM_CNT(qt[119].goal.getItem[1].id) >= qt[119].goal.getItem[1].count and CHECK_ITEM_CNT(qt[119].goal.getItem[2].id) >= qt[119].goal.getItem[2].count then
      NPC_SAY("你的义举为我们正派树立了形象。按照约定，我来教你{0xFFFFFF00}[ 飞龙掌 ]{END}。")
      SET_QUEST_STATE(119, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[ 受伤的工人 ]{END}在龙林谷入口，{0xFFFFFF00}[ 冥珠城宝芝林 ]{END}在冥珠城东。去帮助他们后获取证书和证明。")
    end
  end
  if qData[120].state == 1 then
    if CHECK_ITEM_CNT(qt[120].goal.getItem[1].id) >= qt[120].goal.getItem[1].count and CHECK_ITEM_CNT(qt[120].goal.getItem[2].id) >= qt[120].goal.getItem[2].count then
      NPC_SAY("你的义举为我们正派树立了形象。按照约定，我来教你{0xFFFFFF00}[ 飞龙掌 ]{END}。")
      SET_QUEST_STATE(120, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[ 受伤的工人 ]{END}在龙林谷入口，{0xFFFFFF00}[ 冥珠城宝芝林 ]{END}在冥珠城东。去帮助他们后获取证书和证明。")
    end
  end
  if qData[381].state == 1 then
    if CHECK_ITEM_CNT(qt[381].goal.getItem[1].id) >= qt[381].goal.getItem[1].count and CHECK_ITEM_CNT(qt[381].goal.getItem[2].id) >= qt[381].goal.getItem[2].count then
      NPC_SAY("你的义举为我们正派树立了形象。按照约定，我来教你{0xFFFFFF00}[ 飞龙掌 ]{END}。")
      SET_QUEST_STATE(381, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[ 受伤的工人 ]{END}在龙林谷入口，{0xFFFFFF00}[ 冥珠城宝芝林 ]{END}在冥珠城东。去帮助他们后获取证书和证明。")
    end
  end
  if qData[627].state == 1 then
    if CHECK_ITEM_CNT(qt[627].goal.getItem[1].id) >= qt[627].goal.getItem[1].count and CHECK_ITEM_CNT(qt[627].goal.getItem[2].id) >= qt[627].goal.getItem[2].count then
      NPC_SAY("你的义举为我们正派树立了形象。按照约定，我来教你{0xFFFFFF00}[ 飞龙掌 ]{END}。")
      SET_QUEST_STATE(627, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[ 受伤的工人 ]{END}在龙林谷入口，{0xFFFFFF00}[ 冥珠城宝芝林 ]{END}在冥珠城东。去帮助他们后获取证书和证明。")
    end
  end
  if qData[2083].state == 1 then
    if CHECK_ITEM_CNT(qt[2083].goal.getItem[1].id) >= qt[2083].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2083].goal.getItem[2].id) >= qt[2083].goal.getItem[2].count then
      NPC_SAY("你的义举为我们正派树立了形象。按照约定，我来教你{0xFFFFFF00}[ 飞龙掌 ]{END}。")
      SET_QUEST_STATE(2083, 2)
      return
    else
      NPC_SAY("{0xFFFFFF00}[ 受伤的工人 ]{END}在龙林谷入口，{0xFFFFFF00}[ 冥珠城宝芝林 ]{END}在冥珠城东。去帮助他们后获取证书和证明。")
    end
  end
  if qData[60].state == 1 then
    if __QUEST_HAS_ALL_ITEMS(qt[60].goal.getItem) then
      NPC_SAY("原来是冥珠城宝芝林的推荐书啊。你有资格成为正派人。以后万万不能偷盗和辱骂别人。要努力以正派的身份拯救这个混乱的世界。")
      SET_MEETNPC(60, 2, id)
      SET_QUEST_STATE(60, 2)
      return
    else
      NPC_SAY("在{0xFFFFFF00}冥珠城宝芝林那里拿推荐书。")
    end
  end
  if GET_PLAYER_FACTION() == 1 then
    NPC_SAY("这里不是{0xFFFFFF00}PLAYERNAME{END}能来的地方。")
  elseif CHECK_GUILD_MYUSER() == 1 then
    NPC_SAY("这里不是{0xFFFFFF00}PLAYERNAME{END}能来的地方。")
  elseif GET_PLAYER_JOB1() == 0 then
    NPC_SAY("没有职业不能选择派系。")
  elseif GET_PLAYER_FACTION() == -1 then
    if qData[60].state == 0 and qData[64].state == 0 then
      if GET_PLAYER_LEVEL() >= qt[60].needLevel then
        ADD_QUEST_BTN(qt[60].id, qt[60].name)
      else
        NPC_SAY("你现在功力还不够。继续提升功力之后再回来吧。")
      end
    elseif qData[60].state == 1 then
      NPC_SAY("去见{0xFFFFFF00}冥珠城宝芝林{END}了吗？")
    else
      NPC_SAY("这里不是{0xFFFFFF00}PLAYERNAME{END}能来的地方。")
    end
  elseif GET_PLAYER_FACTION() == -1 then
    NPC_SAY("所谓正派指的是尊敬长辈，遵守江湖秩序，胸怀大志，作风正直的武林人士。我相信只有正派人士才能拯救被恶鬼扰乱的世界。你也加入正派吧？")
  end
  if qData[167].state == 1 then
    if CHECK_ITEM_CNT(qt[167].goal.getItem[1].id) >= qt[167].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("你具备了击退怪物的能力。很好。那么我们正式进行考验吧。")
        SET_QUEST_STATE(167, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("修行时间的长短说明了你的实力。想转职的话拿{0xFFFFFF00}1张鸡冠呛符咒{END}来吧。")
    end
  end
  if qData[168].state == 1 then
    if qData[168].meetNpc[1] == qt[168].goal.meetNpc[1] then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("干得不错。其实我准备了很多考验，不过以你现在的水平应该没问题了。如果你再通过这个考验，我就帮你转职。")
        SET_QUEST_STATE(168, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("心不静的人钓不上来鱼。一边钓{0xFFFFFF00}真鲷{END}一边修心养性吧。还有记得钓{0xFFFF0000}1条交给偷笔怪盗{END}。")
    end
  end
  if qData[169].state == 1 then
    if GET_PLAYER_FAME() >= qt[169].goal.fame then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。你已经是侠客了。不要忘记自己的初衷，相信自己，时刻谨记自己为什么走上这条路。")
        SET_QUEST_STATE(169, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("还没完成吗？要{0xFFFFFF00}名声达到100{END}可不是容易的事情。再接再厉吧。")
    end
  end
  if qData[173].state == 1 then
    if CHECK_ITEM_CNT(qt[173].goal.getItem[1].id) >= qt[173].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("你具备了击退怪物的能力。很好。那么我们正式进行考验吧。")
        SET_QUEST_STATE(173, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("修行时间的长短说明了你的实力。想转职的话拿{0xFFFFFF00}1张鸡冠呛符咒{END}来吧。")
    end
  end
  if qData[174].state == 1 then
    if qData[174].meetNpc[1] == qt[174].goal.meetNpc[1] then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("干得不错。其实我准备了很多考验，不过以你现在的水平应该没问题了。如果你再通过这个考验，我就帮你转职。")
        SET_QUEST_STATE(174, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("心不静的人钓不上来鱼。一边钓{0xFFFFFF00}真鲷{END}一边修心养性吧。还有记得钓{0xFFFF0000}1条交给偷笔怪盗{END}。")
    end
  end
  if qData[175].state == 1 then
    if GET_PLAYER_FAME() >= qt[175].goal.fame then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。你已经是忍者了。不要忘记自己的初衷，相信自己，时刻谨记自己为什么走上这条路。")
        SET_QUEST_STATE(175, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("还没好吗？我还没从师兄处听到任何消息。{0xFFFFFF00}去见师兄得到认可之后再回来吧{END}。只有你的{0xFFFFFF00}名声达到100{END}以上，他才会认真听你说话的。")
    end
  end
  if qData[179].state == 1 then
    if CHECK_ITEM_CNT(qt[179].goal.getItem[1].id) >= qt[179].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("你具备足够的能力击退怪物。很好。那么我们正式进行考验吧。")
        SET_QUEST_STATE(179, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("修行时间的长短说明了你的实力。想转职的话拿{0xFFFFFF00}1张鸡冠呛符咒{END}来吧。")
    end
  end
  if qData[180].state == 1 then
    if qData[180].meetNpc[1] == qt[180].goal.meetNpc[1] then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("干得不错。其实我准备了很多考验，不过以你现在的水平应该没问题了。如果你再通过这个考验，我就帮你转职。")
        SET_QUEST_STATE(180, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("心不静的人钓不上来鱼。一边钓{0xFFFFFF00}真鲷{END}一边修心养性吧。还有记得钓{0xFFFF0000}1条交给偷笔怪盗{END}。")
    end
  end
  if qData[181].state == 1 then
    if GET_PLAYER_FAME() >= qt[181].goal.fame then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。你已经是白云道士了。不要忘记自己的初衷，相信自己，时刻谨记自己为什么走上这条路。")
        SET_QUEST_STATE(181, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("还没完成吗？要{0xFFFFFF00}名声达到100{END}可不是容易的事情。再接再厉吧。")
    end
  end
  if qData[383].state == 1 then
    if CHECK_ITEM_CNT(qt[383].goal.getItem[1].id) >= qt[383].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("这么快就收集回来了啊。我真的~很喜欢！那就正式的接受考验吧。")
        SET_QUEST_STATE(383, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("修行时间的长短说明了你的实力。想转职的话拿{0xFFFFFF00}1张鸡冠呛符咒{END}来吧。")
    end
  end
  if qData[384].state == 1 then
    if qData[384].meetNpc[1] == qt[384].goal.meetNpc[1] then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("干得不错。其实我准备了很多考验，不过以你现在的水平应该没问题了。如果你再通过这个考验，我就帮你转职。")
        SET_QUEST_STATE(384, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("心不静的人钓不上来鱼。一边钓{0xFFFFFF00}真鲷{END}一边修心养性吧。还有记得钓{0xFFFF0000}1条交给偷笔怪盗{END}。")
    end
  end
  if qData[385].state == 1 then
    if GET_PLAYER_FAME() >= qt[385].goal.fame then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。你已经是霸皇斗士了。不要忘记自己的初衷，相信自己，时刻谨记自己为什么走上这条路。")
        SET_QUEST_STATE(385, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("还没完成吗？要{0xFFFFFF00}名声达到100{END}可不是容易的事情。再接再厉吧。")
    end
  end
  if qData[633].state == 1 then
    if CHECK_ITEM_CNT(qt[633].goal.getItem[1].id) >= qt[633].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("你通过了第一次考验。但这仅仅是考验的开始。")
        SET_QUEST_STATE(633, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("拿来1张{0xFFFFFF00}鸡冠呛符咒{END}吧。这是为了考验你有没有充分的修炼到更上一层楼的能力。")
    end
  end
  if qData[634].state == 1 then
    if CHECK_ITEM_CNT(qt[634].goal.getItem[1].id) >= qt[634].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。你通过了第二次考验。现在还剩了第三次考验。")
        SET_QUEST_STATE(634, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("通过钓鱼给我钓来一条真鲷吧。")
    end
  end
  if qData[635].state == 1 then
    if GET_PLAYER_FAME() >= qt[635].goal.fame then
      if 1 <= CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了。你已经达到出击手的境界了，出击手的义务和射手的义务没什么差异。始终要谨记自己的初衷，尽到出击手的义务。")
        SET_QUEST_STATE(635, 2)
      else
        NPC_SAY("行囊太沉了。在行囊[装备2]空出一个栏吧。")
        return
      end
    else
      NPC_SAY("还没完成吗？要名声达到100可不是容易的事情。再接再厉吧。")
    end
  end
  if qData[2090].state == 1 then
    if CHECK_ITEM_CNT(qt[2090].goal.getItem[1].id) >= qt[2090].goal.getItem[1].count then
      if 1 < CHECK_INVENTORY_CNT(2) then
        NPC_SAY("具有击退怪物的能力啊。很好~现在就正式开始考试吧！")
        SET_QUEST_STATE(2090, 2)
      else
        NPC_SAY("行囊太沉。行囊[装备2]里留出1个空间吧")
        return
      end
    else
      NPC_SAY("拿来1张{0xFFFFFF00}鸡冠呛符咒{END}吧。这是为了考验你有没有充分的修炼到更上一层楼的能力。")
    end
  end
  if qData[2091].state == 1 then
    if qData[2091].meetNpc[1] == qt[2091].goal.meetNpc[1] then
      if 1 < CHECK_INVENTORY_CNT(2) then
        NPC_SAY("做得很好~其实我准备了很多考试，但是以你现在的实力应该没有问题。如果你能通过我下面准备的考试，就让你转职")
        SET_QUEST_STATE(2091, 2)
      else
        NPC_SAY("行囊太沉。行囊[装备2]里留出1个空间吧")
        return
      end
    else
      NPC_SAY("心太乱的人鱼也不会上钩的。钓{0xFFFFFF00}真鲷{END}的同时修身养性吧。还有，别忘了给{0xFFFFFF00}偷笔怪盗送去1个{END}")
    end
  end
  if qData[2092].state == 1 then
    if GET_PLAYER_FAME() >= qt[2092].goal.fame then
      if 1 < CHECK_INVENTORY_CNT(2) then
        NPC_SAY("辛苦了，现在你是真正的武人了。不要忘记最初的心，坚信自己，时刻想想为什么会走现在的路！")
        SET_QUEST_STATE(2092, 2)
      else
        NPC_SAY("行囊太沉。行囊[装备2]里留出1个空间吧")
        return
      end
    else
      NPC_SAY("还没达到吗？{0xFFFFFF00}名声达到100{END}是不容易的，再努力吧！")
    end
  end
  if qData[363].state == 1 or qData[364].state == 1 or qData[365].state == 1 or qData[366].state == 1 or qData[626].state == 1 or qData[2082].state == 1 then
    if qData[363].killMonster[qt[363].goal.killMonster[1].id] >= qt[363].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}狗骨头{END}可不是容易对付的，你竟然可以击退{0xFFFFFF00}2只{END}，我认可你了。希望你追随{0xFFFFFF00}[ 太和老君 ]{END}的旨意，尽力击退怪物…")
      SET_QUEST_STATE(363, 2)
      return
    elseif qData[364].killMonster[qt[364].goal.killMonster[1].id] >= qt[364].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}狗骨头{END}可不是容易对付的，你竟然可以击退{0xFFFFFF00}2只{END}，我认可你了。希望你追随{0xFFFFFF00}[ 太和老君 ]{END}的旨意，尽力击退怪物…")
      SET_QUEST_STATE(364, 2)
      return
    elseif qData[365].killMonster[qt[365].goal.killMonster[1].id] >= qt[365].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}狗骨头{END}可不是容易对付的，你竟然可以击退{0xFFFFFF00}2只{END}，我认可你了。希望你追随{0xFFFFFF00}[ 太和老君 ]{END}的旨意，尽力击退怪物…")
      SET_QUEST_STATE(365, 2)
      return
    elseif qData[366].killMonster[qt[366].goal.killMonster[1].id] >= qt[366].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}狗骨头{END}可不是容易对付的，你竟然可以击退{0xFFFFFF00}2只{END}，我认可你了。希望你追随{0xFFFFFF00}[ 太和老君 ]{END}的旨意，尽力击退怪物…")
      SET_QUEST_STATE(366, 2)
      return
    elseif qData[626].killMonster[qt[626].goal.killMonster[1].id] >= qt[626].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}狗骨头{END}可不是容易对付的，你竟然可以击退{0xFFFFFF00}2只{END}，我认可你了。希望你追随{0xFFFFFF00}[ 太和老君 ]{END}的旨意，尽力击退怪物…")
      SET_QUEST_STATE(626, 2)
      return
    elseif qData[2082].killMonster[qt[2082].goal.killMonster[1].id] >= qt[2082].goal.killMonster[1].count then
      NPC_SAY("{0xFFFFFF00}狗骨头{END}可不是容易对付的，你竟然可以击退{0xFFFFFF00}2只{END}，我认可你了。希望你追随{0xFFFFFF00}[ 太和老君 ]{END}的旨意，尽力击退怪物…")
      SET_QUEST_STATE(2082, 2)
      return
    else
      NPC_SAY("至少要具备击退{0xFFFFFF00}2只[ 狗骨头 ]{END}的能力。速去速回吧。")
    end
  end
  if qData[371].state == 1 or qData[372].state == 1 or qData[373].state == 1 or qData[374].state == 1 or qData[628].state == 1 or qData[2084].state == 1 then
    if qData[371].killMonster[qt[371].goal.killMonster[1].id] >= qt[371].goal.killMonster[1].count then
      NPC_SAY("你已经证明了实力。你拥有学习{0xFFFFFF00}[ 天然聚气 ]{END}的资格。补充自然之气，努力击退怪物吧。")
      SET_QUEST_STATE(371, 2)
      return
    elseif qData[372].killMonster[qt[372].goal.killMonster[1].id] >= qt[372].goal.killMonster[1].count then
      NPC_SAY("你已经证明了实力。你拥有学习{0xFFFFFF00}[ 天然聚气 ]{END}的资格。补充自然之气，努力击退怪物吧。")
      SET_QUEST_STATE(372, 2)
      return
    elseif qData[373].killMonster[qt[373].goal.killMonster[1].id] >= qt[373].goal.killMonster[1].count then
      NPC_SAY("你已经证明了实力。你拥有学习{0xFFFFFF00}[ 天然聚气 ]{END}的资格。补充自然之气，努力击退怪物吧。")
      SET_QUEST_STATE(373, 2)
      return
    elseif qData[374].killMonster[qt[374].goal.killMonster[1].id] >= qt[374].goal.killMonster[1].count then
      NPC_SAY("你已经证明了实力。你拥有学习{0xFFFFFF00}[ 天然聚气 ]{END}的资格。补充自然之气，努力击退怪物吧。")
      SET_QUEST_STATE(374, 2)
      return
    elseif qData[628].killMonster[qt[628].goal.killMonster[1].id] >= qt[628].goal.killMonster[1].count then
      NPC_SAY("你已经证明了实力。你拥有学习{0xFFFFFF00}[ 天然聚气 ]{END}的资格。补充自然之气，努力击退怪物吧。")
      SET_QUEST_STATE(628, 2)
      return
    elseif qData[2084].killMonster[qt[2084].goal.killMonster[1].id] >= qt[2084].goal.killMonster[1].count then
      NPC_SAY("你已经证明了实力。你拥有学习{0xFFFFFF00}[ 天然聚气 ]{END}的资格。补充自然之气，努力击退怪物吧。")
      SET_QUEST_STATE(2084, 2)
      return
    else
      NPC_SAY("能够击退{0xFFFFFF00}2只[ 鸡冠呛 ]{END}的话我就传授你{0xFFFFFF00}[ 天然聚气 ]{END}。")
    end
  end
  if qData[483].state == 1 then
    if qData[483].meetNpc[1] ~= id then
      SET_INFO(483, 1)
      SET_MEETNPC(483, 1, id)
      NPC_QSAY(483, 1)
      return
    else
      NPC_SAY("? ?? ?? ?? ?? ?????? ?? ???? ?? ???? ? ???? ?? ?? ?? ?? ???? ??? ???? ?????? ? ? ?? ??? ??????")
      return
    end
  end
  if qData[675].state == 1 then
    NPC_SAY("叮嘱过清阴胡须张无数次了，还拿这种事情来烦我。")
    SET_MEETNPC(675, 1, id)
    SET_QUEST_STATE(675, 2)
  end
  if qData[676].state == 1 then
    NPC_SAY("通过清阴关的黄泉结界高僧进入异界门吧。那里的汉谟拉比商人会告诉你接下来的事情的。")
    return
  end
  if qData[1072].state == 1 then
    if qData[1072].meetNpc[1] ~= qt[1072].goal.meetNpc[1] and qData[803].state == 2 then
      NPC_SAY("做到了啊，这个程度大侠也可以学习太和老君创建的武功了。…来，给你打通了任督二脉，功力达到一定等级的时候，会渐渐开发武功的。泰华武功的详细内容我会另行说明的。")
      SET_QUEST_STATE(1072, 2)
      return
    else
      NPC_SAY("没有在汉谟拉比商人处解决暗穴地狱相关的任务吗？还是已经过了一天了啊？快去解决之后回来吧。解决之后要马上回到我这边。")
    end
  end
  if qData[1121].state == 1 and qData[1121].meetNpc[1] ~= qt[1121].goal.meetNpc[1] then
    NPC_SAY("拿来了推荐书？想要提高名声，当然是要以正派侠客的名义提高了，以后有什么事情会找少侠的。（现在去乌骨鸡处）")
    SET_MEETNPC(1121, 1, id)
  end
  if qData[1126].state == 1 then
    NPC_SAY("哼！现在才来，怎么可以先去找邪派啊？")
    SET_QUEST_STATE(1126, 2)
  end
  if qData[1127].state == 1 then
    if CHECK_ITEM_CNT(qt[1127].goal.getItem[1].id) >= qt[1127].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("祝贺你。你现在才可以接受正当的评价了。")
        SET_QUEST_STATE(1127, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("快去清阴谷收集7个[ 勇勇的前脚 ]吧。我们正派的考验不可能比邪派容易的不是吗？")
    end
  end
  if qData[1128].state == 1 then
    if CHECK_ITEM_CNT(qt[1128].goal.getItem[1].id) >= qt[1128].goal.getItem[1].count then
      NPC_SAY("很好。我已经告诉清阴关的人们你是个乐于助人的正义的侠客，这就是你努力的结果。现在出去应该很多人争先恐后的请求你的帮助的。不用说谢谢。")
      SET_QUEST_STATE(1128, 2)
    else
      NPC_SAY("追求正义的正派人是没有时间磨蹭的。快去{0xFFFFFF00}北清阴平原击退雨伞标，收集15个[ 破烂的雨伞 ]回来吧。{END}")
    end
  end
  if qData[1145].state == 1 and qData[1145].meetNpc[1] ~= id then
    NPC_SAY("现在很忙。你做完事情之后过来找我吧。")
    SET_MEETNPC(1145, 1, id)
  end
  if qData[1146].state == 1 then
    if CHECK_ITEM_CNT(qt[1146].goal.getItem[1].id) >= qt[1146].goal.getItem[1].count then
      NPC_SAY("真是像个未来正派人的实力啊。以后也会经常拜托你的。")
      SET_QUEST_STATE(1146, 2)
    else
      NPC_SAY("你觉得我很闲吗？快点行动。是10个[ 怪老子的眼珠 ]。")
    end
  end
  if qData[1148].state == 1 then
    NPC_SAY("追求正义的正派人的任务是没有简单的。")
  end
  if qData[1152].state == 1 then
    NPC_SAY("有不好的预感。疲惫的矿工应该在清江村。")
  end
  if qData[1176].state == 1 and qData[1176].killMonster[qt[1176].goal.killMonster[1].id] >= qt[1176].goal.killMonster[1].count then
    NPC_SAY("嗯？鬼铲？我下了那样的命令了吗？没什么印象。不过奖励还是给你吧。")
    SET_QUEST_STATE(1176, 2)
  end
  if qData[1178].state == 1 then
    if CHECK_ITEM_CNT(qt[1178].goal.getItem[1].id) >= qt[1178].goal.getItem[1].count then
      NPC_SAY("很好。现在猪大长不能再像老鼠那样逃跑了。肯定会被抓住的吧？")
      SET_QUEST_STATE(1178, 2)
    else
      NPC_SAY("击退芦苇林的背影杀手抢回10个[ 背影杀手的镜 ]拿给我吧。")
    end
  end
  if qData[1395].state == 1 then
    NPC_SAY("??????? ???? ??? ????. ??????. ??? ????.")
  end
  if qData[1398].state == 1 then
    NPC_SAY("?????! ?? ?? ?????? ??????? ??????! ???? ?? ???? ??? ??? ???? ????! ???.")
    SET_QUEST_STATE(1398, 2)
  end
  if qData[1399].state == 1 then
    if CHECK_ITEM_CNT(qt[1399].goal.getItem[1].id) >= qt[1399].goal.getItem[1].count then
      if 1 <= CHECK_INVENTORY_CNT(3) then
        NPC_SAY("? ?? ????. ?? ? ?? ???! ???? ?5?? ?? ??? ???? 1?? ??? ??????.")
        SET_QUEST_STATE(1399, 2)
      else
        NPC_SAY("行囊太沉。")
      end
    else
      NPC_SAY("? 10?? ????1?? ???????! ?? ?? ? ??? ???!")
    end
  end
  if qData[2051].state == 1 then
    SET_QUEST_STATE(2051, 2)
    NPC_SAY("你是新加入的军士吗？听说了很多有关你的事情")
  end
  if qData[2052].state == 1 then
    NPC_SAY("谢谢你告诉我军士新营地的事情。我们会重新建立起该位置的新的情报网的。也请帮我告诉[佣兵领袖]吧")
  end
  if GET_PLAYER_FACTION() == 0 and CHECK_GUILD_MYUSER() == -1 and qData[113].state == 0 then
    ADD_QUEST_BTN(qt[113].id, qt[113].name)
  end
  if GET_PLAYER_FACTION() == 0 then
    if qData[118].state == 0 and GET_PLAYER_JOB1() == 1 then
      ADD_QUEST_BTN(qt[118].id, qt[118].name)
    end
    if qData[119].state == 0 and GET_PLAYER_JOB1() == 2 then
      ADD_QUEST_BTN(qt[119].id, qt[119].name)
    end
    if qData[120].state == 0 and GET_PLAYER_JOB1() == 3 then
      ADD_QUEST_BTN(qt[120].id, qt[120].name)
    end
    if qData[381].state == 0 and GET_PLAYER_JOB1() == 4 then
      ADD_QUEST_BTN(qt[381].id, qt[381].name)
    end
    if qData[627].state == 0 and GET_PLAYER_JOB1() == 5 then
      ADD_QUEST_BTN(qt[627].id, qt[627].name)
    end
    if qData[2083].state == 0 and GET_PLAYER_JOB1() == 11 then
      ADD_QUEST_BTN(qt[2083].id, qt[2083].name)
    end
    if qData[363].state == 0 and GET_PLAYER_JOB1() == 1 then
      ADD_QUEST_BTN(qt[363].id, qt[363].name)
    end
    if qData[364].state == 0 and GET_PLAYER_JOB1() == 2 then
      ADD_QUEST_BTN(qt[364].id, qt[364].name)
    end
    if qData[365].state == 0 and GET_PLAYER_JOB1() == 3 then
      ADD_QUEST_BTN(qt[365].id, qt[365].name)
    end
    if qData[366].state == 0 and GET_PLAYER_JOB1() == 4 then
      ADD_QUEST_BTN(qt[366].id, qt[366].name)
    end
    if qData[626].state == 0 and GET_PLAYER_JOB1() == 5 then
      ADD_QUEST_BTN(qt[626].id, qt[626].name)
    end
    if qData[2082].state == 0 and GET_PLAYER_JOB1() == 11 then
      ADD_QUEST_BTN(qt[2082].id, qt[2082].name)
    end
    if qData[371].state == 0 and GET_PLAYER_JOB1() == 1 then
      ADD_QUEST_BTN(qt[371].id, qt[371].name)
    end
    if qData[372].state == 0 and GET_PLAYER_JOB1() == 2 then
      ADD_QUEST_BTN(qt[372].id, qt[372].name)
    end
    if qData[373].state == 0 and GET_PLAYER_JOB1() == 3 then
      ADD_QUEST_BTN(qt[373].id, qt[373].name)
    end
    if qData[374].state == 0 and GET_PLAYER_JOB1() == 4 then
      ADD_QUEST_BTN(qt[374].id, qt[374].name)
    end
    if qData[628].state == 0 and GET_PLAYER_JOB1() == 5 then
      ADD_QUEST_BTN(qt[628].id, qt[628].name)
    end
    if qData[2084].state == 0 and GET_PLAYER_JOB1() == 11 then
      ADD_QUEST_BTN(qt[2084].id, qt[2084].name)
    end
    if qData[1326].state == 0 and GET_PLAYER_JOB1() == 1 then
      ADD_QUEST_BTN(qt[1326].id, qt[1326].name)
    end
    if qData[1327].state == 0 and GET_PLAYER_JOB1() == 2 then
      ADD_QUEST_BTN(qt[1327].id, qt[1327].name)
    end
    if qData[1328].state == 0 and GET_PLAYER_JOB1() == 3 then
      ADD_QUEST_BTN(qt[1328].id, qt[1328].name)
    end
    if qData[1329].state == 0 and GET_PLAYER_JOB1() == 4 then
      ADD_QUEST_BTN(qt[1329].id, qt[1329].name)
    end
    if qData[1330].state == 0 and GET_PLAYER_JOB1() == 5 then
      ADD_QUEST_BTN(qt[1330].id, qt[1330].name)
    end
    if qData[2085].state == 0 and GET_PLAYER_JOB1() == 11 then
      ADD_QUEST_BTN(qt[2085].id, qt[2085].name)
    end
    if GET_PLAYER_JOB1() == 1 then
      if qData[167].state == 0 then
        ADD_QUEST_BTN(qt[167].id, qt[167].name)
      end
      if qData[168].state == 0 and qData[167].state == 2 then
        ADD_QUEST_BTN(qt[168].id, qt[168].name)
      end
      if qData[169].state == 0 and qData[168].state == 2 then
        ADD_QUEST_BTN(qt[169].id, qt[169].name)
      end
    elseif GET_PLAYER_JOB1() == 2 then
      if qData[173].state == 0 then
        ADD_QUEST_BTN(qt[173].id, qt[173].name)
      end
      if qData[174].state == 0 and qData[173].state == 2 then
        ADD_QUEST_BTN(qt[174].id, qt[174].name)
      end
      if qData[175].state == 0 and qData[174].state == 2 then
        ADD_QUEST_BTN(qt[175].id, qt[175].name)
      end
    elseif GET_PLAYER_JOB1() == 3 then
      if qData[179].state == 0 then
        ADD_QUEST_BTN(qt[179].id, qt[179].name)
      end
      if qData[180].state == 0 and qData[179].state == 2 then
        ADD_QUEST_BTN(qt[180].id, qt[180].name)
      end
      if qData[181].state == 0 and qData[180].state == 2 then
        ADD_QUEST_BTN(qt[181].id, qt[181].name)
      end
    elseif GET_PLAYER_JOB1() == 4 then
      if qData[383].state == 0 then
        ADD_QUEST_BTN(qt[383].id, qt[383].name)
      end
      if qData[384].state == 0 and qData[383].state == 2 then
        ADD_QUEST_BTN(qt[384].id, qt[384].name)
      end
      if qData[385].state == 0 and qData[384].state == 2 then
        ADD_QUEST_BTN(qt[385].id, qt[385].name)
      end
    elseif GET_PLAYER_JOB1() == 5 then
      if qData[633].state == 0 then
        ADD_QUEST_BTN(qt[633].id, qt[633].name)
      end
      if qData[634].state == 0 and qData[633].state == 2 then
        ADD_QUEST_BTN(qt[634].id, qt[634].name)
      end
      if qData[635].state == 0 and qData[634].state == 2 then
        ADD_QUEST_BTN(qt[635].id, qt[635].name)
      end
    elseif GET_PLAYER_JOB1() == 11 then
      if qData[2090].state == 0 then
        ADD_QUEST_BTN(qt[2090].id, qt[2090].name)
      end
      if qData[2091].state == 0 and qData[2090].state == 2 then
        ADD_QUEST_BTN(qt[2091].id, qt[2091].name)
      end
      if qData[2092].state == 0 and qData[2091].state == 2 then
        ADD_QUEST_BTN(qt[2092].id, qt[2092].name)
      end
    end
  end
  if qData[113].state == 2 then
    ADD_NPC_GUILD_CREATE(id)
  end
  if qData[675].state == 2 and qData[676].state == 0 then
    ADD_QUEST_BTN(qt[676].id, qt[676].name)
  end
  if qData[1072].state == 0 and GET_PLAYER_FACTION() == 0 and 0 < GET_PLAYER_JOB2() then
    ADD_QUEST_BTN(qt[1072].id, qt[1072].name)
  end
  GET_NPC_GUILD_LIST(id)
  if qData[1126].state == 2 and qData[1127].state == 0 then
    ADD_QUEST_BTN(qt[1127].id, qt[1127].name)
  end
  if qData[1127].state == 2 and qData[1128].state == 0 then
    ADD_QUEST_BTN(qt[1128].id, qt[1128].name)
  end
  if qData[1145].state == 2 and qData[1146].state == 0 then
    ADD_QUEST_BTN(qt[1146].id, qt[1146].name)
  end
  if qData[1146].state == 2 and qData[1148].state == 0 then
    ADD_QUEST_BTN(qt[1148].id, qt[1148].name)
  end
  if qData[1150].state == 2 and qData[1152].state == 0 then
    ADD_QUEST_BTN(qt[1152].id, qt[1152].name)
  end
  if qData[1176].state == 2 and qData[1178].state == 0 then
    ADD_QUEST_BTN(qt[1178].id, qt[1178].name)
  end
  if qData[2052].state == 0 and qData[2051].state == 2 and GET_PLAYER_JOB1() == 11 then
    ADD_QUEST_BTN(qt[2052].id, qt[2052].name)
  end
  if qData[955].state == 0 and 0 < GET_PLAYER_JOB2() then
    ADD_QUEST_BTN(qt[955].id, qt[955].name)
  end
  if qData[956].state == 0 and GET_PLAYER_JOB2() == 1 then
    ADD_QUEST_BTN(qt[956].id, qt[956].name)
  end
  if qData[957].state == 0 and GET_PLAYER_JOB2() == 3 then
    ADD_QUEST_BTN(qt[957].id, qt[957].name)
  end
  if qData[958].state == 0 and GET_PLAYER_JOB2() == 5 then
    ADD_QUEST_BTN(qt[958].id, qt[958].name)
  end
  if qData[959].state == 0 and GET_PLAYER_JOB2() == 7 then
    ADD_QUEST_BTN(qt[959].id, qt[959].name)
  end
  if qData[960].state == 0 and GET_PLAYER_JOB2() == 9 then
    ADD_QUEST_BTN(qt[960].id, qt[960].name)
  end
  if qData[1395].state == 0 and GET_PLAYER_FACTION() == 0 then
    ADD_QUEST_BTN(qt[1395].id, qt[1395].name)
  end
  if qData[1399].state == 0 and qData[1398].state == 2 then
    ADD_QUEST_BTN(qt[1399].id, qt[1399].name)
  end
  if qData[1399].state == 2 then
    ADD_EVENT_RICE_ROLL1(id)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[60].state ~= 2 and GET_PLAYER_LEVEL() >= qt[60].needLevel and GET_PLAYER_FACTION() == 0 and CHECK_GUILD_MYUSER() == 0 and 0 < GET_PLAYER_JOB1() then
    if qData[60].state == 1 then
      if __QUEST_HAS_ALL_ITEMS(qt[60].goal.getItem) then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if GET_PLAYER_FACTION() == 0 then
    if qData[118].state ~= 2 and GET_PLAYER_JOB1() == 1 and GET_PLAYER_LEVEL() >= qt[118].needLevel then
      if qData[118].state == 1 then
        if CHECK_ITEM_CNT(qt[118].goal.getItem[1].id) >= qt[118].goal.getItem[1].count and CHECK_ITEM_CNT(qt[118].goal.getItem[2].id) >= qt[118].goal.getItem[2].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[119].state ~= 2 and GET_PLAYER_JOB1() == 2 and GET_PLAYER_LEVEL() >= qt[119].needLevel then
      if qData[119].state == 1 then
        if CHECK_ITEM_CNT(qt[119].goal.getItem[1].id) >= qt[119].goal.getItem[1].count and CHECK_ITEM_CNT(qt[119].goal.getItem[2].id) >= qt[119].goal.getItem[2].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[120].state ~= 2 and GET_PLAYER_JOB1() == 3 and GET_PLAYER_LEVEL() >= qt[120].needLevel then
      if qData[120].state == 1 then
        if CHECK_ITEM_CNT(qt[120].goal.getItem[1].id) >= qt[120].goal.getItem[1].count and CHECK_ITEM_CNT(qt[120].goal.getItem[2].id) >= qt[120].goal.getItem[2].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[381].state ~= 2 and GET_PLAYER_JOB1() == 3 and GET_PLAYER_LEVEL() >= qt[381].needLevel then
      if qData[381].state == 1 then
        if CHECK_ITEM_CNT(qt[381].goal.getItem[1].id) >= qt[381].goal.getItem[1].count and CHECK_ITEM_CNT(qt[381].goal.getItem[2].id) >= qt[381].goal.getItem[2].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[627].state ~= 2 and GET_PLAYER_JOB1() == 5 and GET_PLAYER_LEVEL() >= qt[627].needLevel then
      if qData[627].state == 1 then
        if CHECK_ITEM_CNT(qt[627].goal.getItem[1].id) >= qt[627].goal.getItem[1].count and CHECK_ITEM_CNT(qt[627].goal.getItem[2].id) >= qt[627].goal.getItem[2].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[2083].state ~= 2 and GET_PLAYER_JOB1() == 11 and GET_PLAYER_LEVEL() >= qt[2083].needLevel then
      if qData[2083].state == 1 then
        if CHECK_ITEM_CNT(qt[2083].goal.getItem[1].id) >= qt[2083].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2083].goal.getItem[2].id) >= qt[2083].goal.getItem[2].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[363].state ~= 2 and GET_PLAYER_JOB1() == 1 and GET_PLAYER_LEVEL() >= qt[363].needLevel then
      if qData[363].state == 1 then
        if qData[363].killMonster[qt[363].goal.killMonster[1].id] >= qt[363].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[364].state ~= 2 and GET_PLAYER_JOB1() == 2 and GET_PLAYER_LEVEL() >= qt[364].needLevel then
      if qData[364].state == 1 then
        if qData[364].killMonster[qt[364].goal.killMonster[1].id] >= qt[364].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[365].state ~= 2 and GET_PLAYER_JOB1() == 3 and GET_PLAYER_LEVEL() >= qt[365].needLevel then
      if qData[365].state == 1 then
        if qData[365].killMonster[qt[365].goal.killMonster[1].id] >= qt[365].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[366].state ~= 2 and GET_PLAYER_JOB1() == 4 and GET_PLAYER_LEVEL() >= qt[366].needLevel then
      if qData[366].state == 1 then
        if qData[366].killMonster[qt[366].goal.killMonster[1].id] >= qt[366].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[626].state ~= 2 and GET_PLAYER_JOB1() == 5 and GET_PLAYER_LEVEL() >= qt[626].needLevel then
      if qData[626].state == 1 then
        if qData[626].killMonster[qt[626].goal.killMonster[1].id] >= qt[626].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[2082].state ~= 2 and GET_PLAYER_JOB1() == 11 and GET_PLAYER_LEVEL() >= qt[2082].needLevel then
      if qData[2082].state == 1 then
        if qData[2082].killMonster[qt[2082].goal.killMonster[1].id] >= qt[2082].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[371].state ~= 2 and GET_PLAYER_JOB1() == 1 and GET_PLAYER_LEVEL() >= qt[371].needLevel then
      if qData[371].state == 1 then
        if qData[371].killMonster[qt[371].goal.killMonster[1].id] >= qt[371].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[372].state ~= 2 and GET_PLAYER_JOB1() == 2 and GET_PLAYER_LEVEL() >= qt[372].needLevel then
      if qData[372].state == 1 then
        if qData[372].killMonster[qt[372].goal.killMonster[1].id] >= qt[372].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[373].state ~= 2 and GET_PLAYER_JOB1() == 3 and GET_PLAYER_LEVEL() >= qt[373].needLevel then
      if qData[373].state == 1 then
        if qData[373].killMonster[qt[373].goal.killMonster[1].id] >= qt[373].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[374].state ~= 2 and GET_PLAYER_JOB1() == 4 and GET_PLAYER_LEVEL() >= qt[374].needLevel then
      if qData[374].state == 1 then
        if qData[374].killMonster[qt[374].goal.killMonster[1].id] >= qt[374].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[628].state ~= 2 and GET_PLAYER_JOB1() == 5 and GET_PLAYER_LEVEL() >= qt[628].needLevel then
      if qData[628].state == 1 then
        if qData[628].killMonster[qt[628].goal.killMonster[1].id] >= qt[628].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[2084].state ~= 2 and GET_PLAYER_JOB1() == 11 and GET_PLAYER_LEVEL() >= qt[2084].needLevel then
      if qData[2084].state == 1 then
        if qData[2084].killMonster[qt[2084].goal.killMonster[1].id] >= qt[2084].goal.killMonster[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
    if qData[1326].state ~= 2 and GET_PLAYER_JOB1() == 1 and GET_PLAYER_LEVEL() >= qt[1326].needLevel then
      if qData[1326].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
    if qData[1327].state ~= 2 and GET_PLAYER_JOB1() == 2 and GET_PLAYER_LEVEL() >= qt[1327].needLevel then
      if qData[1327].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
    if qData[1328].state ~= 2 and GET_PLAYER_JOB1() == 3 and GET_PLAYER_LEVEL() >= qt[1328].needLevel then
      if qData[1328].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
    if qData[1329].state ~= 2 and GET_PLAYER_JOB1() == 4 and GET_PLAYER_LEVEL() >= qt[1329].needLevel then
      if qData[1329].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
    if qData[1330].state ~= 2 and GET_PLAYER_JOB1() == 5 and GET_PLAYER_LEVEL() >= qt[1330].needLevel then
      if qData[1330].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
    if qData[2085].state ~= 2 and GET_PLAYER_JOB1() == 11 and GET_PLAYER_LEVEL() >= qt[2085].needLevel then
      if qData[2085].state == 1 then
        QSTATE(id, 1)
      else
        QSTATE(id, 0)
      end
    end
    if GET_PLAYER_JOB1() == 1 then
      if qData[167].state ~= 2 and GET_PLAYER_LEVEL() >= qt[167].needLevel then
        if qData[167].state == 1 then
          if CHECK_ITEM_CNT(qt[167].goal.getItem[1].id) >= qt[167].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[168].state ~= 2 and qData[167].state == 2 and GET_PLAYER_LEVEL() >= qt[168].needLevel then
        if qData[168].state == 1 then
          if qData[168].meetNpc[1] == qt[168].goal.meetNpc[1] then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[169].state ~= 2 and qData[168].state == 2 and GET_PLAYER_LEVEL() >= qt[169].needLevel then
        if qData[169].state == 1 then
          if GET_PLAYER_FAME() >= qt[169].goal.fame then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
    elseif GET_PLAYER_JOB1() == 2 then
      if qData[173].state ~= 2 and GET_PLAYER_LEVEL() >= qt[173].needLevel then
        if qData[173].state == 1 then
          if CHECK_ITEM_CNT(qt[173].goal.getItem[1].id) >= qt[173].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[174].state ~= 2 and qData[173].state == 2 and GET_PLAYER_LEVEL() >= qt[174].needLevel then
        if qData[174].state == 1 then
          if qData[174].meetNpc[1] == qt[174].goal.meetNpc[1] then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[175].state ~= 2 and qData[174].state == 2 and GET_PLAYER_LEVEL() >= qt[175].needLevel then
        if qData[175].state == 1 then
          if GET_PLAYER_FAME() >= qt[175].goal.fame then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
    elseif GET_PLAYER_JOB1() == 3 then
      if qData[179].state ~= 2 and GET_PLAYER_LEVEL() >= qt[179].needLevel then
        if qData[179].state == 1 then
          if CHECK_ITEM_CNT(qt[179].goal.getItem[1].id) >= qt[179].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[180].state ~= 2 and qData[179].state == 2 and GET_PLAYER_LEVEL() >= qt[180].needLevel then
        if qData[180].state == 1 then
          if qData[180].meetNpc[1] == qt[180].goal.meetNpc[1] then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[181].state ~= 2 and qData[180].state == 2 and GET_PLAYER_LEVEL() >= qt[181].needLevel then
        if qData[181].state == 1 then
          if GET_PLAYER_FAME() >= qt[181].goal.fame then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
    elseif GET_PLAYER_JOB1() == 4 then
      if qData[383].state ~= 2 and GET_PLAYER_LEVEL() >= qt[383].needLevel then
        if qData[383].state == 1 then
          if CHECK_ITEM_CNT(qt[383].goal.getItem[1].id) >= qt[383].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[384].state ~= 2 and qData[383].state == 2 and GET_PLAYER_LEVEL() >= qt[384].needLevel then
        if qData[384].state == 1 then
          if qData[384].meetNpc[1] == qt[384].goal.meetNpc[1] then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[385].state ~= 2 and qData[384].state == 2 and GET_PLAYER_LEVEL() >= qt[385].needLevel then
        if qData[385].state == 1 then
          if GET_PLAYER_FAME() >= qt[385].goal.fame then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
    elseif GET_PLAYER_JOB1() == 5 then
      if qData[633].state ~= 2 and GET_PLAYER_LEVEL() >= qt[633].needLevel then
        if qData[633].state == 1 then
          if CHECK_ITEM_CNT(qt[633].goal.getItem[1].id) >= qt[633].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[634].state ~= 2 and qData[633].state == 2 and GET_PLAYER_LEVEL() >= qt[634].needLevel then
        if qData[634].state == 1 then
          if CHECK_ITEM_CNT(qt[634].goal.getItem[1].id) >= qt[634].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[635].state ~= 2 and qData[634].state == 2 and GET_PLAYER_LEVEL() >= qt[635].needLevel then
        if qData[635].state == 1 then
          if GET_PLAYER_FAME() >= qt[635].goal.fame then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
    elseif GET_PLAYER_JOB1() == 11 then
      if qData[2090].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2090].needLevel then
        if qData[2090].state == 1 then
          if CHECK_ITEM_CNT(qt[2090].goal.getItem[1].id) >= qt[2090].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[2091].state ~= 2 and qData[2090].state == 2 and GET_PLAYER_LEVEL() >= qt[2091].needLevel then
        if qData[2091].state == 1 then
          if CHECK_ITEM_CNT(qt[2091].goal.getItem[1].id) >= qt[2091].goal.getItem[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        else
          QSTATE(id, 0)
        end
      end
      if qData[2092].state ~= 2 and qData[2091].state == 2 and GET_PLAYER_LEVEL() >= qt[2092].needLevel then
        if qData[2092].state == 1 then
          if GET_PLAYER_FAME() >= qt[2092].goal.fame then
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
  if qData[675].state == 1 then
    QSTATE(id, 2)
  end
  if qData[675].state == 2 and qData[676].state ~= 2 and GET_PLAYER_LEVEL() >= qt[676].needLevel then
    if qData[676].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1072].state ~= 2 and GET_PLAYER_FACTION() == 0 and 0 < GET_PLAYER_JOB2() then
    if qData[1072].state == 1 then
      if qData[1072].meetNpc[1] ~= qt[1072].goal.meetNpc[1] and qData[803].state == 2 then
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
  if qData[956].state == 0 and GET_PLAYER_JOB2() == 1 then
    QSTATE(id, true)
  end
  if qData[957].state == 0 and GET_PLAYER_JOB2() == 3 then
    QSTATE(id, true)
  end
  if qData[958].state == 0 and GET_PLAYER_JOB2() == 5 then
    QSTATE(id, true)
  end
  if qData[959].state == 0 and GET_PLAYER_JOB2() == 7 then
    QSTATE(id, true)
  end
  if qData[960].state == 0 and GET_PLAYER_JOB2() == 9 then
    QSTATE(id, true)
  end
  if qData[1120].state == 2 and qData[1121].state ~= 2 and qData[1121].state == 1 and qData[1121].meetNpc[1] ~= qt[1121].goal.meetNpc[1] then
    QSTATE(id, 1)
  end
  if qData[1125].state == 2 and qData[1126].state ~= 2 and qData[1126].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1126].state == 2 and qData[1127].state ~= 2 then
    if qData[1126].state == 1 then
      if CHECK_ITEM_CNT(qt[1127].goal.getItem[1].id) >= qt[1127].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1127].state == 2 and qData[1128].state ~= 2 then
    if qData[1128].state == 1 then
      if qData[1128].killMonster[qt[1128].goal.killMonster[1].id] >= qt[1128].goal.killMonster[1].count and qData[1128].killMonster[qt[1128].goal.killMonster[2].id] >= qt[1128].goal.killMonster[2].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1145].state == 1 and qData[1145].meetNpc[1] ~= id then
    QSTATE(id, 1)
  end
  if qData[1145].state == 2 and qData[1146].state ~= 2 then
    if qData[1146].state == 1 then
      if CHECK_ITEM_CNT(qt[1146].goal.getItem[1].id) >= qt[1146].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1146].state == 2 and qData[1148].state ~= 2 then
    if qData[1148].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1150].state == 2 and qData[1152].state ~= 2 then
    if qData[1152].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1174].state == 2 and qData[1176].state ~= 2 and qData[1176].state == 1 and qData[1176].killMonster[qt[1176].goal.killMonster[1].id] >= qt[1176].goal.killMonster[1].count then
    QSTATE(id, 2)
  end
  if qData[1176].state == 2 and qData[1178].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1178].needLevel then
    if qData[1178].state == 1 then
      if CHECK_ITEM_CNT(qt[1178].goal.getItem[1].id) >= qt[1178].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[2051].state == 1 then
    QSTATE(id, 2)
  end
  if qData[2052].state ~= 2 and qData[2051].state == 2 and GET_PLAYER_LEVEL() >= qt[2052].needLevel and GET_PLAYER_JOB1() == 11 then
    if qData[2052].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
