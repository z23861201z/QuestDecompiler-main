function npcsay(id)
  if id ~= 4316010 then
    return
  end
  clickNPCid = id
  if qData[488].state == 1 then
    if qData[488].meetNpc[1] ~= id then
      NPC_QSAY(488, 1)
      SET_INFO(488, 1)
      SET_MEETNPC(488, 1, id)
    else
      NPC_SAY("住持问的时候，不要说是从我这儿听说的。我反而会无端挨骂…")
      return
    end
  end
  if qData[517].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[521].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[525].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[529].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[669].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[2096].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[519].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[523].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[527].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[531].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[671].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[2098].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[1530].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[1531].state == 1 and qData[1531].killMonster[qt[1531].goal.killMonster[1].id] >= qt[1531].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(1531, 2)
    return
  end
  if qData[1569].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[1570].state == 1 and qData[1570].killMonster[qt[1570].goal.killMonster[1].id] >= qt[1570].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(1570, 2)
    return
  end
  if qData[2268].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
    return
  end
  if qData[2269].state == 1 and qData[2269].killMonster[qt[2269].goal.killMonster[1].id] >= qt[2269].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(2269, 2)
    return
  end
  if qData[2621].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
  end
  if qData[2622].state == 1 and qData[2622].killMonster[qt[2622].goal.killMonster[1].id] >= qt[2622].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(2622, 2)
    return
  end
  if qData[2623].state == 1 then
    if qData[2623].killMonster[qt[2623].goal.killMonster[1].id] >= qt[2623].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(2623, 2)
      return
    else
      NPC_QSAY(2623, 1)
    end
  end
  if qData[2773].state == 1 then
    NPC_SAY("去龙林城哞读册处，说是我拜托的书就可以了。把那个书给我拿过来吧")
  end
  if qData[2774].state == 1 and qData[2774].killMonster[qt[2774].goal.killMonster[1].id] >= qt[2774].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(2774, 2)
    return
  end
  if qData[2775].state == 1 then
    if qData[2775].killMonster[qt[2775].goal.killMonster[1].id] >= qt[2775].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(2775, 2)
      return
    else
      NPC_QSAY(2775, 1)
    end
  end
  if qData[518].state == 1 and qData[518].killMonster[qt[518].goal.killMonster[1].id] >= qt[518].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(518, 2)
    return
  end
  if qData[522].state == 1 and qData[522].killMonster[qt[522].goal.killMonster[1].id] >= qt[522].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(522, 2)
    return
  end
  if qData[526].state == 1 and qData[526].killMonster[qt[526].goal.killMonster[1].id] >= qt[526].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(526, 2)
    return
  end
  if qData[530].state == 1 and qData[530].killMonster[qt[530].goal.killMonster[1].id] >= qt[530].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(530, 2)
    return
  end
  if qData[670].state == 1 and qData[670].killMonster[qt[670].goal.killMonster[1].id] >= qt[670].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(670, 2)
    return
  end
  if qData[2097].state == 1 and qData[2097].killMonster[qt[2097].goal.killMonster[1].id] >= qt[2097].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(2097, 2)
    return
  end
  if qData[520].state == 1 and qData[520].killMonster[qt[520].goal.killMonster[1].id] >= qt[520].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(520, 2)
    return
  end
  if qData[524].state == 1 and qData[524].killMonster[qt[524].goal.killMonster[1].id] >= qt[524].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(524, 2)
    return
  end
  if qData[528].state == 1 and qData[528].killMonster[qt[528].goal.killMonster[1].id] >= qt[528].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(528, 2)
    return
  end
  if qData[532].state == 1 and qData[532].killMonster[qt[532].goal.killMonster[1].id] >= qt[532].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(532, 2)
    return
  end
  if qData[672].state == 1 and qData[672].killMonster[qt[672].goal.killMonster[1].id] >= qt[672].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(672, 2)
    return
  end
  if qData[2099].state == 1 and qData[2099].killMonster[qt[2099].goal.killMonster[1].id] >= qt[2099].goal.killMonster[1].count then
    NPC_SAY("嗯，书没有找到，学习了书上的武功回来了是吗？好厉害的武功啊。把体内的真气缠绕在身上，就像是穿上了钢铁盔甲")
    SET_QUEST_STATE(2099, 2)
    return
  end
  if qData[534].state == 1 then
    if CHECK_ITEM_CNT(qt[534].goal.getItem[1].id) >= qt[534].goal.getItem[1].count then
      NPC_SAY("是50个小鼓啊。短时间内摇浪鼓童子不会在晚上吵得让人烦了。但是固落峰适合学习凌空后步吗？如果按我说的那样，施展凌空虚步在固落峰到处逛，应该就掌握的很熟练了…")
      SET_QUEST_STATE(534, 2)
      return
    else
      NPC_QSAY(534, 1)
      return
    end
  end
  if qData[535].state == 1 then
    if qData[535].killMonster[qt[535].goal.killMonster[1].id] >= qt[535].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(535, 2)
      return
    else
      NPC_QSAY(535, 1)
      return
    end
  end
  if qData[536].state == 1 then
    if qData[536].killMonster[qt[536].goal.killMonster[1].id] >= qt[536].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(536, 2)
      return
    else
      NPC_QSAY(536, 1)
      return
    end
  end
  if qData[537].state == 1 then
    if qData[537].killMonster[qt[537].goal.killMonster[1].id] >= qt[537].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(537, 2)
      return
    else
      NPC_QSAY(537, 1)
      return
    end
  end
  if qData[538].state == 1 then
    if qData[538].killMonster[qt[538].goal.killMonster[1].id] >= qt[538].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(538, 2)
      return
    else
      NPC_QSAY(538, 1)
      return
    end
  end
  if qData[539].state == 1 then
    if qData[539].killMonster[qt[539].goal.killMonster[1].id] >= qt[539].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(539, 2)
      return
    else
      NPC_QSAY(539, 1)
      return
    end
  end
  if qData[540].state == 1 then
    if qData[540].killMonster[qt[540].goal.killMonster[1].id] >= qt[540].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(540, 2)
      return
    else
      NPC_QSAY(540, 1)
      return
    end
  end
  if qData[541].state == 1 then
    if qData[541].killMonster[qt[541].goal.killMonster[1].id] >= qt[541].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(541, 2)
      return
    else
      NPC_QSAY(541, 1)
      return
    end
  end
  if qData[542].state == 1 then
    if qData[542].killMonster[qt[542].goal.killMonster[1].id] >= qt[542].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(542, 2)
      return
    else
      NPC_QSAY(542, 1)
      return
    end
  end
  if qData[673].state == 1 then
    if qData[673].killMonster[qt[673].goal.killMonster[1].id] >= qt[673].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(673, 2)
      return
    else
      NPC_QSAY(673, 1)
      return
    end
  end
  if qData[674].state == 1 then
    if qData[674].killMonster[qt[674].goal.killMonster[1].id] >= qt[674].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(674, 2)
      return
    else
      NPC_QSAY(674, 1)
      return
    end
  end
  if qData[1532].state == 1 then
    if qData[1532].killMonster[qt[1532].goal.killMonster[1].id] >= qt[1532].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(1532, 2)
      return
    else
      NPC_QSAY(1532, 1)
      return
    end
  end
  if qData[1571].state == 1 then
    if qData[1571].killMonster[qt[1571].goal.killMonster[1].id] >= qt[1571].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(1571, 2)
      return
    else
      NPC_QSAY(1571, 1)
      return
    end
  end
  if qData[2270].state == 1 then
    if qData[2270].killMonster[qt[2270].goal.killMonster[1].id] >= qt[2270].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(2270, 2)
      return
    else
      NPC_QSAY(2270, 1)
      return
    end
  end
  if qData[2100].state == 1 then
    if qData[2100].killMonster[qt[2100].goal.killMonster[1].id] >= qt[2100].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(2100, 2)
      return
    else
      NPC_QSAY(2100, 1)
    end
  end
  if qData[2101].state == 1 then
    if qData[2101].killMonster[qt[2101].goal.killMonster[1].id] >= qt[2101].goal.killMonster[1].count then
      NPC_SAY("怎么样？气的运用法领会到了吗？飞龙掌不要直接使用，把力量压缩到一个点来使用，就可以变成完全不同的武功。领悟到了气的运用法，就使用不同的飞龙掌吧")
      SET_QUEST_STATE(2101, 2)
      return
    else
      NPC_QSAY(2101, 1)
    end
  end
  if qData[563].state == 1 then
    if qData[563].killMonster[qt[563].goal.killMonster[1].id] >= qt[563].goal.killMonster[1].count then
      NPC_SAY("嗯，虽然都击退了，但没有任何变化。看来只击退雪魔女是没用的")
      SET_QUEST_STATE(563, 2)
      return
    else
      NPC_SAY("现在还是下雪，赶快去击退100个雪魔女吧")
      return
    end
  end
  if qData[564].state == 1 then
    if qData[564].killMonster[qt[564].goal.killMonster[1].id] >= qt[564].goal.killMonster[1].count then
      NPC_SAY("谢谢。从此，来到第一阶梯修行的人会舒服多了")
      SET_QUEST_STATE(564, 2)
      return
    else
      NPC_SAY("击退100个地狱狂牛吧。得这个程度，地狱狂牛才不会做出那么疯狂的事情")
      return
    end
  end
  if GET_PLAYER_TRANSFORMER() == 1 then
    if GET_PLAYER_FACTION() == 0 then
      if GET_PLAYER_JOB2() == 1 then
        if qData[517].state == 0 and GET_PLAYER_LEVEL() >= qt[517].needLevel then
          ADD_QUEST_BTN(qt[517].id, qt[517].name)
        end
        if qData[535].state == 0 and GET_PLAYER_LEVEL() >= qt[535].needLevel then
          ADD_QUEST_BTN(qt[535].id, qt[535].name)
        end
      elseif GET_PLAYER_JOB2() == 3 then
        if qData[521].state == 0 and GET_PLAYER_LEVEL() >= qt[521].needLevel then
          ADD_QUEST_BTN(qt[521].id, qt[521].name)
        end
        if qData[537].state == 0 and GET_PLAYER_LEVEL() >= qt[537].needLevel then
          ADD_QUEST_BTN(qt[537].id, qt[537].name)
        end
      elseif GET_PLAYER_JOB2() == 5 then
        if qData[525].state == 0 and GET_PLAYER_LEVEL() >= qt[525].needLevel then
          ADD_QUEST_BTN(qt[525].id, qt[525].name)
        end
        if qData[539].state == 0 and GET_PLAYER_LEVEL() >= qt[539].needLevel then
          ADD_QUEST_BTN(qt[539].id, qt[539].name)
        end
      elseif GET_PLAYER_JOB2() == 7 then
        if qData[529].state == 0 and GET_PLAYER_LEVEL() >= qt[529].needLevel then
          ADD_QUEST_BTN(qt[529].id, qt[529].name)
        end
        if qData[541].state == 0 and GET_PLAYER_LEVEL() >= qt[541].needLevel then
          ADD_QUEST_BTN(qt[541].id, qt[541].name)
        end
      elseif GET_PLAYER_JOB2() == 9 then
        if qData[669].state == 0 and GET_PLAYER_LEVEL() >= qt[669].needLevel then
          ADD_QUEST_BTN(qt[669].id, qt[669].name)
        end
        if qData[673].state == 0 and GET_PLAYER_LEVEL() >= qt[673].needLevel then
          ADD_QUEST_BTN(qt[673].id, qt[673].name)
        end
      elseif GET_PLAYER_JOB2() == 17 then
        if qData[2096].state == 0 and GET_PLAYER_LEVEL() >= qt[2096].needLevel then
          ADD_QUEST_BTN(qt[2096].id, qt[2096].name)
        end
        if qData[2100].state == 0 and GET_PLAYER_LEVEL() >= qt[2100].needLevel then
          ADD_QUEST_BTN(qt[2100].id, qt[2100].name)
        end
      end
    elseif GET_PLAYER_FACTION() == 1 then
      if GET_PLAYER_JOB2() == 2 then
        if qData[519].state == 0 and GET_PLAYER_LEVEL() >= qt[519].needLevel then
          ADD_QUEST_BTN(qt[519].id, qt[519].name)
        end
        if qData[536].state == 0 and GET_PLAYER_LEVEL() >= qt[536].needLevel then
          ADD_QUEST_BTN(qt[536].id, qt[536].name)
        end
      elseif GET_PLAYER_JOB2() == 4 then
        if qData[523].state == 0 and GET_PLAYER_LEVEL() >= qt[523].needLevel then
          ADD_QUEST_BTN(qt[523].id, qt[523].name)
        end
        if qData[538].state == 0 and GET_PLAYER_LEVEL() >= qt[538].needLevel then
          ADD_QUEST_BTN(qt[538].id, qt[538].name)
        end
      elseif GET_PLAYER_JOB2() == 6 then
        if qData[527].state == 0 and GET_PLAYER_LEVEL() >= qt[527].needLevel then
          ADD_QUEST_BTN(qt[527].id, qt[527].name)
        end
        if qData[540].state == 0 and GET_PLAYER_LEVEL() >= qt[540].needLevel then
          ADD_QUEST_BTN(qt[540].id, qt[540].name)
        end
      elseif GET_PLAYER_JOB2() == 8 then
        if qData[531].state == 0 and GET_PLAYER_LEVEL() >= qt[531].needLevel then
          ADD_QUEST_BTN(qt[531].id, qt[531].name)
        end
        if qData[542].state == 0 and GET_PLAYER_LEVEL() >= qt[542].needLevel then
          ADD_QUEST_BTN(qt[542].id, qt[542].name)
        end
      elseif GET_PLAYER_JOB2() == 10 then
        if qData[671].state == 0 and GET_PLAYER_LEVEL() >= qt[671].needLevel then
          ADD_QUEST_BTN(qt[671].id, qt[671].name)
        end
        if qData[674].state == 0 and GET_PLAYER_LEVEL() >= qt[674].needLevel then
          ADD_QUEST_BTN(qt[674].id, qt[674].name)
        end
      elseif GET_PLAYER_JOB2() == 18 then
        if qData[2098].state == 0 and GET_PLAYER_LEVEL() >= qt[2098].needLevel then
          ADD_QUEST_BTN(qt[2098].id, qt[2098].name)
        end
        if qData[2101].state == 0 and GET_PLAYER_LEVEL() >= qt[2101].needLevel then
          ADD_QUEST_BTN(qt[2101].id, qt[2101].name)
        end
      end
    elseif GET_PLAYER_FACTION() == 2 then
      if GET_PLAYER_JOB2() == 12 then
        if qData[1530].state == 0 and GET_PLAYER_LEVEL() >= qt[1530].needLevel then
          ADD_QUEST_BTN(qt[1530].id, qt[1530].name)
        end
        if qData[1532].state == 0 and GET_PLAYER_LEVEL() >= qt[1532].needLevel then
          ADD_QUEST_BTN(qt[1532].id, qt[1532].name)
        end
      elseif GET_PLAYER_JOB2() == 13 then
        if qData[1569].state == 0 and GET_PLAYER_LEVEL() >= qt[1569].needLevel then
          ADD_QUEST_BTN(qt[1569].id, qt[1569].name)
        end
        if qData[1571].state == 0 and GET_PLAYER_LEVEL() >= qt[1571].needLevel then
          ADD_QUEST_BTN(qt[1571].id, qt[1571].name)
        end
      elseif GET_PLAYER_JOB2() == 15 then
        if qData[2268].state == 0 and GET_PLAYER_LEVEL() >= qt[2268].needLevel then
          ADD_QUEST_BTN(qt[2268].id, qt[2268].name)
        end
        if qData[2270].state == 0 and GET_PLAYER_LEVEL() >= qt[2270].needLevel then
          ADD_QUEST_BTN(qt[2270].id, qt[2270].name)
        end
      elseif GET_PLAYER_JOB2() == 11 then
        if qData[2621].state == 0 and GET_PLAYER_LEVEL() >= qt[2621].needLevel then
          ADD_QUEST_BTN(qt[2621].id, qt[2621].name)
        end
        if qData[2623].state == 0 and GET_PLAYER_LEVEL() >= qt[2623].needLevel then
          ADD_QUEST_BTN(qt[2623].id, qt[2623].name)
        end
      elseif GET_PLAYER_JOB2() == 14 then
        if qData[2773].state == 0 and GET_PLAYER_LEVEL() >= qt[2773].needLevel then
          ADD_QUEST_BTN(qt[2773].id, qt[2773].name)
        end
        if qData[2775].state == 0 and GET_PLAYER_LEVEL() >= qt[2775].needLevel then
          ADD_QUEST_BTN(qt[2775].id, qt[2775].name)
        end
      end
    end
  end
  if qData[534].state == 0 and GET_PLAYER_TRANSFORMER() == 1 then
    ADD_QUEST_BTN(qt[534].id, qt[534].name)
  end
  if qData[563].state == 0 then
    ADD_QUEST_BTN(qt[563].id, qt[563].name)
  end
  if qData[564].state == 0 then
    ADD_QUEST_BTN(qt[564].id, qt[564].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if GET_PLAYER_TRANSFORMER() == 1 then
    if GET_PLAYER_FACTION() == 0 then
      if GET_PLAYER_JOB2() == 1 then
        if qData[517].state ~= 2 and GET_PLAYER_LEVEL() >= qt[517].needLevel then
          if qData[517].state == 1 then
            QSTATE(id, 1)
          end
          QSTATE(id, 0)
        end
        if qData[518].state == 1 then
          if qData[518].killMonster[qt[518].goal.killMonster[1].id] >= qt[518].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[535].state ~= 2 and GET_PLAYER_LEVEL() >= qt[535].needLevel then
          if qData[535].state == 1 then
            if qData[535].killMonster[qt[535].goal.killMonster[1].id] >= qt[535].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          end
          QSTATE(id, 0)
        end
      elseif GET_PLAYER_JOB2() == 3 then
        if qData[521].state ~= 2 and GET_PLAYER_LEVEL() >= qt[521].needLevel then
          if qData[521].state == 1 then
            QSTATE(id, 1)
          end
          QSTATE(id, 0)
        end
        if qData[522].state == 1 then
          if qData[522].killMonster[qt[522].goal.killMonster[1].id] >= qt[522].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[537].state ~= 2 and GET_PLAYER_LEVEL() >= qt[537].needLevel then
          if qData[537].state == 1 then
            if qData[537].killMonster[qt[537].goal.killMonster[1].id] >= qt[537].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          end
          QSTATE(id, 0)
        end
      elseif GET_PLAYER_JOB2() == 5 then
        if qData[525].state ~= 2 and GET_PLAYER_LEVEL() >= qt[525].needLevel then
          if qData[525].state == 1 then
            QSTATE(id, 1)
          end
          QSTATE(id, 0)
        end
        if qData[526].state == 1 then
          if qData[526].killMonster[qt[526].goal.killMonster[1].id] >= qt[526].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[539].state ~= 2 and GET_PLAYER_LEVEL() >= qt[539].needLevel then
          if qData[539].state == 1 then
            if qData[539].killMonster[qt[539].goal.killMonster[1].id] >= qt[539].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          end
          QSTATE(id, 0)
        end
      elseif GET_PLAYER_JOB2() == 7 then
        if qData[529].state ~= 2 and GET_PLAYER_LEVEL() >= qt[529].needLevel then
          if qData[529].state == 1 then
            QSTATE(id, 1)
          end
          QSTATE(id, 0)
        end
        if qData[530].state == 1 then
          if qData[530].killMonster[qt[530].goal.killMonster[1].id] >= qt[530].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[541].state ~= 2 and GET_PLAYER_LEVEL() >= qt[541].needLevel then
          if qData[541].state == 1 then
            if qData[541].killMonster[qt[541].goal.killMonster[1].id] >= qt[541].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          end
          QSTATE(id, 0)
        end
      elseif GET_PLAYER_JOB2() == 9 then
        if qData[669].state ~= 2 and GET_PLAYER_LEVEL() >= qt[669].needLevel then
          if qData[669].state == 1 then
            QSTATE(id, 1)
          end
          QSTATE(id, 0)
        end
        if qData[670].state == 1 then
          if qData[670].killMonster[qt[670].goal.killMonster[1].id] >= qt[670].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[673].state ~= 2 and GET_PLAYER_LEVEL() >= qt[673].needLevel then
          if qData[673].state == 1 then
            if qData[673].killMonster[qt[673].goal.killMonster[1].id] >= qt[673].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          end
          QSTATE(id, 0)
        end
      elseif GET_PLAYER_JOB2() == 17 then
        if qData[2096].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2096].needLevel then
          if qData[2096].state == 1 then
            QSTATE(id, 1)
          else
            QSTATE(id, 0)
          end
        end
        if qData[2097].state == 1 then
          if qData[2097].killMonster[qt[2097].goal.killMonster[1].id] >= qt[2097].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[2100].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2100].needLevel then
          if qData[2100].state == 1 then
            if qData[2100].killMonster[qt[2100].goal.killMonster[1].id] >= qt[2100].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          else
            QSTATE(id, 0)
          end
        end
      end
    elseif GET_PLAYER_FACTION() == 1 then
      if GET_PLAYER_JOB2() == 2 then
        if qData[519].state ~= 2 and GET_PLAYER_LEVEL() >= qt[519].needLevel then
          if qData[519].state == 1 then
            QSTATE(id, 1)
          else
            QSTATE(id, 0)
          end
        end
        if qData[520].state == 1 then
          if qData[520].killMonster[qt[520].goal.killMonster[1].id] >= qt[520].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[536].state ~= 2 and GET_PLAYER_LEVEL() >= qt[536].needLevel then
          if qData[536].state == 1 then
            if qData[536].killMonster[qt[536].goal.killMonster[1].id] >= qt[536].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          else
            QSTATE(id, 0)
          end
        end
      elseif GET_PLAYER_JOB2() == 4 then
        if qData[523].state ~= 2 and GET_PLAYER_LEVEL() >= qt[523].needLevel then
          if qData[523].state == 1 then
            QSTATE(id, 1)
          else
            QSTATE(id, 0)
          end
        end
        if qData[524].state == 1 then
          if qData[524].killMonster[qt[524].goal.killMonster[1].id] >= qt[524].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[538].state ~= 2 and GET_PLAYER_LEVEL() >= qt[538].needLevel then
          if qData[538].state == 1 then
            if qData[538].killMonster[qt[538].goal.killMonster[1].id] >= qt[538].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          else
            QSTATE(id, 0)
          end
        end
      elseif GET_PLAYER_JOB2() == 6 then
        if qData[527].state ~= 2 and GET_PLAYER_LEVEL() >= qt[527].needLevel then
          if qData[527].state == 1 then
            QSTATE(id, 1)
          else
            QSTATE(id, 0)
          end
        end
        if qData[528].state == 1 then
          if qData[528].killMonster[qt[528].goal.killMonster[1].id] >= qt[528].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[540].state ~= 2 and GET_PLAYER_LEVEL() >= qt[540].needLevel then
          if qData[540].state == 1 then
            if qData[540].killMonster[qt[540].goal.killMonster[1].id] >= qt[540].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          else
            QSTATE(id, 0)
          end
        end
      elseif GET_PLAYER_JOB2() == 8 then
        if qData[531].state ~= 2 and GET_PLAYER_LEVEL() >= qt[531].needLevel then
          if qData[531].state == 1 then
            QSTATE(id, 1)
          else
            QSTATE(id, 0)
          end
        end
        if qData[532].state == 1 then
          if qData[532].killMonster[qt[532].goal.killMonster[1].id] >= qt[532].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[542].state ~= 2 and GET_PLAYER_LEVEL() >= qt[542].needLevel then
          if qData[542].state == 1 then
            if qData[542].killMonster[qt[542].goal.killMonster[1].id] >= qt[542].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          else
            QSTATE(id, 0)
          end
        end
      elseif GET_PLAYER_JOB2() == 10 then
        if qData[671].state ~= 2 and GET_PLAYER_LEVEL() >= qt[671].needLevel then
          if qData[671].state == 1 then
            QSTATE(id, 1)
          else
            QSTATE(id, 0)
          end
        end
        if qData[672].state == 1 then
          if qData[672].killMonster[qt[672].goal.killMonster[1].id] >= qt[672].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[674].state ~= 2 and GET_PLAYER_LEVEL() >= qt[674].needLevel then
          if qData[674].state == 1 then
            if qData[674].killMonster[qt[674].goal.killMonster[1].id] >= qt[674].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          else
            QSTATE(id, 0)
          end
        end
      elseif GET_PLAYER_JOB2() == 18 then
        if qData[2098].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2098].needLevel then
          if qData[2098].state == 1 then
            QSTATE(id, 1)
          else
            QSTATE(id, 0)
          end
        end
        if qData[2099].state == 1 then
          if qData[2099].killMonster[qt[2099].goal.killMonster[1].id] >= qt[2099].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[2101].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2101].needLevel then
          if qData[2101].state == 1 then
            if qData[2101].killMonster[qt[2101].goal.killMonster[1].id] >= qt[2101].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          else
            QSTATE(id, 0)
          end
        end
      end
    elseif GET_PLAYER_FACTION() == 2 then
      if GET_PLAYER_JOB2() == 12 then
        if qData[1530].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1530].needLevel then
          if qData[1530].state == 1 then
            QSTATE(id, 1)
          else
            QSTATE(id, 0)
          end
        end
        if qData[1531].state == 1 then
          if qData[1531].killMonster[qt[1531].goal.killMonster[1].id] >= qt[1531].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[1532].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1532].needLevel then
          if qData[1532].state == 1 then
            if qData[1532].killMonster[qt[1532].goal.killMonster[1].id] >= qt[1532].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          else
            QSTATE(id, 0)
          end
        end
      elseif GET_PLAYER_JOB2() == 13 then
        if qData[1569].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1569].needLevel then
          if qData[1569].state == 1 then
            QSTATE(id, 1)
          else
            QSTATE(id, 0)
          end
        end
        if qData[1570].state == 1 then
          if qData[1570].killMonster[qt[1570].goal.killMonster[1].id] >= qt[1570].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[1571].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1571].needLevel then
          if qData[1571].state == 1 then
            if qData[1571].killMonster[qt[1571].goal.killMonster[1].id] >= qt[1571].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          else
            QSTATE(id, 0)
          end
        end
      elseif GET_PLAYER_JOB2() == 15 then
        if qData[2268].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2268].needLevel then
          if qData[2268].state == 1 then
            QSTATE(id, 1)
          else
            QSTATE(id, 0)
          end
        end
        if qData[2269].state == 1 then
          if qData[2269].killMonster[qt[2269].goal.killMonster[1].id] >= qt[2269].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[2270].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2270].needLevel then
          if qData[2270].state == 1 then
            if qData[2270].killMonster[qt[2270].goal.killMonster[1].id] >= qt[2270].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          else
            QSTATE(id, 0)
          end
        end
      elseif GET_PLAYER_JOB2() == 11 then
        if qData[2621].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2621].needLevel then
          if qData[2621].state == 1 then
            QSTATE(id, 1)
          else
            QSTATE(id, 0)
          end
        end
        if qData[2622].state == 1 then
          if qData[2622].killMonster[qt[2622].goal.killMonster[1].id] >= qt[2622].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[2623].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2623].needLevel then
          if qData[2623].state == 1 then
            if qData[2623].killMonster[qt[2623].goal.killMonster[1].id] >= qt[2623].goal.killMonster[1].count then
              QSTATE(id, 2)
            else
              QSTATE(id, 1)
            end
          else
            QSTATE(id, 0)
          end
        end
      elseif GET_PLAYER_JOB2() == 14 then
        if qData[2773].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2773].needLevel then
          if qData[2773].state == 1 then
            QSTATE(id, 1)
          else
            QSTATE(id, 0)
          end
        end
        if qData[2774].state == 1 then
          if qData[2774].killMonster[qt[2774].goal.killMonster[1].id] >= qt[2774].goal.killMonster[1].count then
            QSTATE(id, 2)
          else
            QSTATE(id, 1)
          end
        end
        if qData[2775].state ~= 2 and GET_PLAYER_LEVEL() >= qt[2775].needLevel then
          if qData[2775].state == 1 then
            if qData[2775].killMonster[qt[2775].goal.killMonster[1].id] >= qt[2775].goal.killMonster[1].count then
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
    if qData[534].state ~= 2 and 1 <= GET_PLAYER_JOB2() and GET_PLAYER_LEVEL() >= qt[534].needLevel then
      if qData[534].state == 1 then
        if CHECK_ITEM_CNT(qt[534].goal.getItem[1].id) >= qt[534].goal.getItem[1].count then
          QSTATE(id, 2)
        else
          QSTATE(id, 1)
        end
      else
        QSTATE(id, 0)
      end
    end
  end
  if qData[563].state ~= 2 and GET_PLAYER_LEVEL() >= qt[563].needLevel then
    if qData[563].state == 1 then
      if qData[563].killMonster[qt[563].goal.killMonster[1].id] >= qt[563].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[564].state ~= 2 and GET_PLAYER_LEVEL() >= qt[564].needLevel then
    if qData[564].state == 1 then
      if qData[564].killMonster[qt[564].goal.killMonster[1].id] >= qt[564].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
