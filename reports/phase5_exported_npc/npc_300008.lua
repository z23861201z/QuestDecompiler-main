function npcsay(id)
  if id ~= 4300008 then
    return
  end
  clickNPCid = id
  if qData[716].state == 1 then
    SET_MEETNPC(716, 1, id)
    NPC_SAY("这次就放过你。不能证明就当你是兰霉匠的手下，会严厉处置！(得去找{0xFFFFFF00}[住持]{END}帮忙。)")
  end
  if qData[718].state == 1 and CHECK_ITEM_CNT(qt[718].goal.getItem[1].id) >= qt[718].goal.getItem[1].count then
    NPC_SAY("你还回来？勇气可嘉啊。你小子说要证明的就是这个吗？")
    SET_QUEST_STATE(718, 2)
  end
  if qData[719].state == 1 then
    if CHECK_ITEM_CNT(qt[719].goal.getItem[1].id) >= qt[719].goal.getItem[1].count then
      NPC_SAY("真的拿来了啊…。那就是说生死之塔的封印解开了！")
      SET_QUEST_STATE(719, 2)
    else
      NPC_SAY("还没拿来吗？如果你的话不是假的，就去{0xFFFFFF00}[生死之塔]{END}击退红树妖，收集{0xFFFFFF00}30个[红树生死液]{END}回来吧。")
    end
  end
  if qData[720].state == 1 then
    NPC_SAY("怎么样了？{0xFFFFFF00}[第一寺]的[住持{END}有什么妙计吗？")
  end
  if qData[723].state == 1 then
    NPC_SAY("呵呵…。是你吗？刚才也有兰霉匠的手下入侵，给挡回去了。有消息了吗？")
    SET_QUEST_STATE(723, 2)
  end
  if qData[724].state == 1 then
    if CHECK_ITEM_CNT(qt[724].goal.getItem[1].id) >= qt[724].goal.getItem[1].count and CHECK_ITEM_CNT(qt[724].goal.getItem[2].id) >= qt[724].goal.getItem[2].count and CHECK_ITEM_CNT(qt[724].goal.getItem[3].id) >= qt[724].goal.getItem[3].count then
      NPC_SAY("实力很出众啊。只要这状况能结束，一定会好好报答的。")
      SET_QUEST_STATE(724, 2)
    else
      NPC_SAY("{0xFFFFFF00}[阎罗服(男)]{END}得在同僚处获得或者打怪获得。你能拿来 {0xFFFFFF00}[阎罗服(男)]和10个[竹叶青酒]，10个[牛肉脯]{END}，就会报答你的。")
    end
  end
  if qData[1457].state == 1 then
    NPC_SAY("找到秋叨鱼师兄了？万幸啊。万幸啊…。")
    SET_QUEST_STATE(1457, 2)
  end
  if qData[1458].state == 1 then
    NPC_SAY("汉谟拉比商人在异界门里。去找他听听详细的内容吧。")
    return
  end
  if qData[2189].state == 1 then
    NPC_SAY("吭绰啊. 磊匙啊 玫荐夸拳甫 硼摹沁促绰 家侥阑 佃绊 促矫茄锅 焊绊 酵绢辑 被捞 磊匙甫 阂范匙.")
    SET_QUEST_STATE(2189, 2)
    return
  end
  if qData[2190].state == 1 then
    if CHECK_ITEM_CNT(qt[2190].goal.getItem[1].id) >= qt[2190].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2190].goal.getItem[2].id) >= qt[2190].goal.getItem[2].count then
      NPC_SAY("荐绊沁匙. 辟单 促弗 何殴阑 粱 秦具摆绰单? 促矫 富阑 粱 吧绢林霸唱.")
      SET_QUEST_STATE(2190, 2)
      return
    else
      NPC_SAY("郴 瓜阑 荤恩篮 磊匙观俊 绝促匙. 老窜, 玫澜急背 率俊 {0xFFFFFF00}汲赤{END}客 {0xFFFFFF00}葫必牢{END}阑 硼摹窍绊 弊 刘钎肺 {0xFFFFFF00}葫拳{END}客 {0xFFFFFF00}绊靛抚{END}阑 {0xFFFFFF00}20俺究{END}啊瘤绊 坷霸.")
    end
  end
  if qData[2191].state == 1 then
    NPC_SAY("玫澜荤狼 林瘤胶丛膊 啊辑 舅酒毫林辨 官扼匙.")
  end
  if qData[2195].state == 1 then
    NPC_SAY("澜. 吭绰啊 磊匙. 绢勒. 倾..倾倾倾~ 酒聪 磊匙 捞霸 公郊窿牢啊?")
    SET_QUEST_STATE(2195, 2)
    return
  end
  if qData[2196].state == 1 then
    NPC_SAY("(款扁炼侥 吝捞促. 规秦窍瘤 富磊.)")
  end
  if qData[2197].state == 1 and CHECK_ITEM_CNT(qt[2197].goal.getItem[1].id) >= qt[2197].goal.getItem[1].count then
    NPC_SAY("卿 捞 晨货!! 捞巴捞 厚鲍绢帕捞扼绰 扒啊. (曹博曹博) 栏拦!!!")
    SET_QUEST_STATE(2197, 2)
    return
  end
  if qData[2198].state == 1 then
    if qData[2198].killMonster[qt[2198].goal.killMonster[1].id] >= qt[2198].goal.killMonster[1].count then
      NPC_SAY("捞力 粱 炼侩窍备父. 荐绊沁匙.")
      SET_QUEST_STATE(2198, 2)
      return
    else
      NPC_SAY("炼侩洒 款扁炼侥阑 且 荐 乐霸 弊 矫掺矾款 悼磊急 30付府 沥档父 硼摹 秦林霸唱.")
    end
  end
  if qData[2199].state == 1 then
    NPC_SAY("茄具己俊 啊辑 郴 家侥阑 绊捞楷俊霸 傈窍绊 粱 档客林绊 坷霸唱.")
  end
  if qData[2206].state == 1 then
    NPC_SAY("捞力 坷绰扒啊. 弊贰, 肋瘤郴绊 乐焙. 开矫 郴 颊林 翠焙.")
    SET_QUEST_STATE(2206, 2)
    return
  end
  if qData[2207].state == 1 then
    if qData[2207].killMonster[qt[2207].goal.killMonster[1].id] >= qt[2207].goal.killMonster[1].count then
      NPC_SAY("绞捞夸柳阑 惑措窍扁绰 酒流 鳖瘤 个捞 棵扼坷瘤 臼篮巴 鞍焙,")
      SET_QUEST_STATE(2207, 2)
      return
    else
      NPC_SAY("郴啊 弊 付拱阑 惑措且 荐 乐阑瘤 磊匙啊 绞捞夸柳阑 1付府 硼摹窍绊 坷霸唱.")
    end
  end
  if qData[2208].state == 1 then
    if CHECK_ITEM_CNT(qt[2208].goal.getItem[1].id) >= qt[2208].goal.getItem[1].count then
      NPC_SAY("绞捞夸柳何利 1厘, 2厘ˇ 5厘 澜. 嘎焙. 捞力 绕访阑 秦杭鳖. 捞惧!!!")
      SET_QUEST_STATE(2208, 2)
      return
    else
      NPC_SAY("绞捞夸柳狼 何利父 乐促搁 距拳等 绞捞夸柳阑 家券且 荐 乐匙. 磊匙啊 绞捞夸柳何利阑 5俺 沥档 备秦客林摆唱.")
    end
  end
  if qData[2209].state == 1 then
    NPC_SAY("捞力 绕访阑 矫累秦 杭鳖?")
    SET_QUEST_STATE(2209, 2)
    return
  end
  if qData[2210].state == 1 then
    if CHECK_ITEM_CNT(qt[2210].goal.getItem[1].id) >= qt[2210].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2210].goal.getItem[2].id) >= qt[2210].goal.getItem[2].count then
      NPC_SAY("亮酒. 荐绊沁匙. 磊, 促澜 窜拌肺 逞绢啊档废 窍瘤.")
      SET_QUEST_STATE(2210, 2)
      return
    else
      NPC_SAY("玫澜急背肺 啊辑 汲赤客 葫必牢阑 硼摹窍绊 葫拳客 绊靛抚阑 阿阿 50俺究 啊廉坷辨 官鄂促. 角矫!!!")
    end
  end
  if qData[2211].state == 1 then
    if CHECK_ITEM_CNT(qt[2211].goal.getItem[1].id) >= qt[2211].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2211].goal.getItem[2].id) >= qt[2211].goal.getItem[2].count then
      NPC_SAY("亮酒. 荐绊沁匙. 捞力 付瘤阜 窜拌肺 逞绢啊档废 窍瘤.")
      SET_QUEST_STATE(2211, 2)
      return
    else
      NPC_SAY("厚鲍绢客 悼磊急阑 硼摹窍绊 瘤蠢矾固客 家绊甫 阿阿 50俺揪 啊廉坷辨 官鄂促 角矫!!")
    end
  end
  if qData[2212].state == 1 then
    if CHECK_ITEM_CNT(qt[2212].goal.getItem[1].id) >= qt[2212].goal.getItem[1].count then
      NPC_SAY("亮酒. 荐绊沁匙. 郴啊 啊福媚 临 荐 乐绰扒 咯扁鳖瘤牢巴 鞍焙.")
      SET_QUEST_STATE(2212, 2)
      return
    else
      NPC_SAY("玫档脚阑 硼摹窍绊 玫档汗件酒 100俺甫 啊瘤绊 坷档废! 角矫!!")
    end
  end
  if qData[2213].state == 1 then
    if qData[2213].killMonster[qt[2213].goal.killMonster[1].id] >= qt[2213].goal.killMonster[1].count and CHECK_ITEM_CNT(qt[2213].goal.getItem[1].id) >= qt[2213].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2213].goal.getItem[2].id) >= qt[2213].goal.getItem[2].count and CHECK_ITEM_CNT(qt[2213].goal.getItem[3].id) >= qt[2213].goal.getItem[3].count and CHECK_ITEM_CNT(qt[2213].goal.getItem[4].id) >= qt[2213].goal.getItem[4].count and CHECK_ITEM_CNT(qt[2213].goal.getItem[5].id) >= qt[2213].goal.getItem[5].count then
      NPC_SAY("亮酒. 荐绊沁匙. 捞力 沥富 付瘤阜捞焙. 菊栏肺 唱酒啊绰 磊匙狼 菊俊 初牢 厘局拱阑 滴妨况窍瘤 富霸唱. 滴妨框捞具 富肺 磊脚狼 己厘阑 规秦窍绰 啊厘 奴 利老技.")
      SET_QUEST_STATE(2213, 2)
      return
    else
      NPC_SAY("绞捞夸柳阑 2付府 硼摹窍绊 葫拳, 绊靛抚, 瘤蠢矾固, 家绊, 玫档汗件酒 阿阿 30俺甫 啊瘤绊 倒酒坷档废.")
    end
  end
  if qData[2214].state == 1 then
    NPC_SAY("舅摆匙. 舅摆绢. 构啊 弊府 鞭茄啊?")
    SET_QUEST_STATE(2214, 2)
    return
  end
  if qData[2215].state == 1 then
    if qData[2215].killMonster[qt[2215].goal.killMonster[1].id] >= qt[2215].goal.killMonster[1].count then
      NPC_SAY("肋沁焙! 沥富 荐绊沁匙.")
      SET_QUEST_STATE(2215, 2)
      return
    else
      NPC_SAY("祈付蓖 50付府扼匙. 塞甸歹扼档 炼陛父 歹 畴仿秦林霸.")
    end
  end
  if qData[2216].state == 1 then
    if qData[2216].killMonster[qt[2216].goal.killMonster[1].id] >= qt[2216].goal.killMonster[1].count then
      NPC_SAY("磊匙 沥富 措窜窍焙! 荐绊沁匙.")
      SET_QUEST_STATE(2216, 2)
      return
    else
      NPC_SAY("阂樊件件阑 把葛嚼父 焊绊 乞啊窍瘤 富扼绊.")
    end
  end
  if qData[2217].state == 1 then
    NPC_SAY("酒流 免惯 救茄扒啊? 绢辑 玫澜荤狼 林瘤胶丛膊 啊焊扼绊.")
  end
  if qData[2222].state == 1 then
    NPC_SAY("档馒沁绰啊? 酒, 弊 渴捞 唱狼 困厘累傈阑 困茄 判渴捞焙. 绊缚焙.")
    SET_QUEST_STATE(2222, 2)
    return
  end
  if qData[2223].state == 1 then
    NPC_SAY("捞巴 曼 抄皑窍焙. 癌磊扁 恐 捞繁 老捞 积扁绰芭瘤?")
    SET_QUEST_STATE(2223, 2)
    return
  end
  if qData[2224].state == 1 then
    NPC_SAY("辑笛矾 免惯窍霸. 腹捞 鞭茄 葛剧捞歹扼绊. 唱档 鞭窍绊")
  end
  if qData[2228].state == 1 then
    NPC_SAY("弊贰. 趣矫扼档 粱 舅酒辰 巴篮 绝绰啊?")
    SET_QUEST_STATE(2228, 2)
    return
  end
  if qData[2229].state == 1 then
    if GET_PLAYER_LEVEL() >= 118 then
      NPC_SAY("肋沁焙! 惹涪秦! 开矫 磊匙啊 秦尘临 舅疽绢.")
      SET_QUEST_STATE(2229, 2)
      return
    else
      NPC_SAY("炼陛父 歹 畴仿窍搁 登摆焙. {0xFFFFFF00}118{END}傍仿捞 登搁 唱俊霸 促矫 富阑 吧绢林霸唱.")
    end
  end
  if qData[2230].state == 1 then
    NPC_SAY("弊绰 {0xFFFFFF00}绊遏锰 巢率{END}俊 魂促绊 甸菌匙. 绢辑 免惯窍霸唱.")
  end
  if qData[2234].state == 1 then
    NPC_SAY("坷罚父捞焙. 公郊老肺 茫酒吭绰啊? 澜? 炼固氢栏肺何磐 辑蔓捞扼绊?")
    SET_QUEST_STATE(2234, 2)
    return
  end
  if qData[2235].state == 1 then
    if qData[2235].killMonster[qt[2235].goal.killMonster[1].id] >= qt[2235].goal.killMonster[1].count then
      NPC_SAY("荐绊沁焙. 捞力 付拱仇甸档 歹 捞惑篮 窃何肺 给 框流老抛瘤.")
      SET_QUEST_STATE(2235, 2)
      return
    else
      NPC_SAY("炼陛父 歹 畴仿秦林霸. 夸悼摹带 付扁甫 泪犁匡 荤恩捞 磊匙挥捞扼匙.")
    end
  end
  if qData[2236].state == 1 then
    NPC_SAY("澜? 酒流 免惯窍瘤 臼疽绰啊?")
  end
  if qData[2245].state == 1 then
    NPC_SAY("捞繁 扁阜腮 快楷捞 乐唱ˇ 炼固氢 弊赤啊 付澜俊 甸绢秦林搁 亮摆焙.")
  end
  if qData[2249].state == 1 then
    NPC_SAY("恐 捞力辑具 坷绰 扒啊? 扁促府促 格 狐瘤绰 临 舅疽匙.")
    SET_QUEST_STATE(2249, 2)
    return
  end
  if qData[2250].state == 1 then
    if qData[2250].killMonster[qt[2250].goal.killMonster[1].id] >= qt[2250].goal.killMonster[1].count then
      NPC_SAY("弊贰. 绢痘霸 登菌唱?")
      SET_QUEST_STATE(2250, 2)
      return
    else
      NPC_SAY("辑滴福霸. 绞捞夸功啊 绢叼肺 朝酒啊滚副瘤 葛福匙.")
    end
  end
  if qData[2251].state == 1 then
    NPC_SAY("郴啊 捞固 荤恩甸阑 烹秦辑 绞捞夸功狼 夯芭瘤甫 绢叼牢瘤 舅酒陈瘤.")
    SET_QUEST_STATE(2251, 2)
    return
  end
  if qData[2252].state == 1 then
    NPC_SAY("酒流 免惯 救 沁唱?")
  end
  if qData[2253].state == 1 then
    NPC_SAY("弊成 林款 巴捞扼绊? 酒ˇ 搬惫篮 咯扁鳖柳啊?")
    SET_QUEST_STATE(2253, 2)
    return
  end
  if qData[2277].state == 1 then
    NPC_SAY("酒流 免惯 救 沁唱?")
  end
  if qData[2279].state == 1 then
    NPC_SAY("积阿焊促 坷贰吧啡焙. 弊贰, 幅碍捞 操固带 澜葛绰 公均捞带啊?")
    SET_QUEST_STATE(2279, 2)
    return
  end
  if qData[2280].state == 1 then
    NPC_SAY("刚 辨 坷蠢扼 绊积茄 巴篮 舅瘤父, 吝措茄 荤救捞聪 粱 辑笛矾林矫霸唱.")
  end
  if qData[2323].state == 1 then
    NPC_SAY("坷罚父捞焙. 公郊 老牢啊?")
    SET_QUEST_STATE(2323, 2)
    return
  end
  if qData[2324].state == 1 then
    if CHECK_ITEM_CNT(qt[2324].goal.getItem[1].id) >= qt[2324].goal.getItem[1].count and CHECK_ITEM_CNT(qt[2324].goal.getItem[2].id) >= qt[2324].goal.getItem[2].count then
      NPC_SAY("促 啊廉吭焙. 弊烦 郴 捞具扁甫 秦林瘤.")
      SET_QUEST_STATE(2324, 2)
      return
    else
      NPC_SAY("困瘤荐 荤屈ˇ")
    end
  end
  if qData[2325].state == 1 then
    NPC_SAY("芭扁辑 硅脚磊啊 唱棵 临篮ˇ")
    SET_QUEST_STATE(2325, 2)
    return
  end
  if qData[2326].state == 1 then
    NPC_SAY("泪矫 去磊 乐绊 酵焙.")
    SET_QUEST_STATE(2326, 2)
    return
  end
  if qData[2341].state == 1 then
    NPC_SAY("{0xFFFFFF00}滴困{END}绰 瘤陛 侩捍窜阑 父甸绢 沥眉甫 见扁绊 乐促绊 窍匙. 没澜包苞 局府锰 荤捞狼 {0xFFFFFF00}[急琶狼剑]{END}栏肺 啊焊霸唱.")
  end
  if qData[3650].state == 1 then
    if qData[3650].killMonster[qt[3650].goal.killMonster[1].id] >= qt[3650].goal.killMonster[1].count then
      NPC_SAY("世界和平不是白来的，是像今天这样一点点制造出来的")
      SET_QUEST_STATE(3650, 2)
      return
    else
      NPC_SAY("稍事休息也是种很好的修炼")
    end
  end
  if qData[3651].state == 1 then
    if qData[3651].killMonster[qt[3651].goal.killMonster[1].id] >= qt[3651].goal.killMonster[1].count then
      NPC_SAY("世界和平不是白来的，是像今天这样一点点制造出来的")
      SET_QUEST_STATE(3651, 2)
      return
    else
      NPC_SAY("会很累的，累的时候可以适当的休息")
    end
  end
  if qData[3652].state == 1 then
    if qData[3652].killMonster[qt[3652].goal.killMonster[1].id] >= qt[3652].goal.killMonster[1].count then
      NPC_SAY("改变这个世界的第一步，就是先改变自己的周围。辛苦了")
      SET_QUEST_STATE(3652, 2)
      return
    else
      NPC_SAY("稍事休息也是种很好的修炼")
    end
  end
  if qData[716].state == 0 and qData[715].state == 2 then
    ADD_QUEST_BTN(qt[716].id, qt[716].name)
  end
  if qData[719].state == 0 and qData[718].state == 2 then
    ADD_QUEST_BTN(qt[719].id, qt[719].name)
  end
  if qData[720].state == 0 and qData[719].state == 2 then
    ADD_QUEST_BTN(qt[720].id, qt[720].name)
  end
  if qData[724].state == 0 and qData[723].state == 2 then
    ADD_QUEST_BTN(qt[724].id, qt[724].name)
  end
  if qData[1458].state == 0 and qData[1457].state == 2 and GET_PLAYER_LEVEL() >= qt[1458].needLevel then
    ADD_QUEST_BTN(qt[1458].id, qt[1458].name)
  end
  if qData[3650].state == 0 and GET_PLAYER_LEVEL() >= qt[3650].needLevel then
    ADD_QUEST_BTN(qt[3650].id, qt[3650].name)
  end
  if qData[3651].state == 0 and GET_PLAYER_LEVEL() >= qt[3651].needLevel then
    ADD_QUEST_BTN(qt[3651].id, qt[3651].name)
  end
  if qData[3652].state == 0 and GET_PLAYER_LEVEL() >= qt[3652].needLevel then
    ADD_QUEST_BTN(qt[3652].id, qt[3652].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[716].state ~= 2 and GET_PLAYER_LEVEL() >= qt[716].needLevel and qData[715].state == 2 then
    if qData[716].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[718].state ~= 2 and GET_PLAYER_LEVEL() >= qt[718].needLevel and qData[717].state == 2 and qData[718].state == 1 then
    QSTATE(id, 2)
  end
  if qData[719].state ~= 2 and GET_PLAYER_LEVEL() >= qt[719].needLevel and qData[718].state == 2 then
    if qData[719].state == 1 then
      if CHECK_ITEM_CNT(qt[719].goal.getItem[1].id) >= qt[719].goal.getItem[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[720].state ~= 2 and GET_PLAYER_LEVEL() >= qt[720].needLevel and qData[719].state == 2 then
    if qData[720].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[723].state == 1 and GET_PLAYER_LEVEL() >= qt[723].needLevel then
    QSTATE(id, 2)
  end
  if qData[724].state ~= 2 and GET_PLAYER_LEVEL() >= qt[724].needLevel and qData[723].state == 2 then
    if qData[724].state == 1 then
      if CHECK_ITEM_CNT(qt[724].goal.getItem[1].id) >= qt[724].goal.getItem[1].count and CHECK_ITEM_CNT(qt[724].goal.getItem[2].id) >= qt[724].goal.getItem[2].count and CHECK_ITEM_CNT(qt[724].goal.getItem[3].id) >= qt[724].goal.getItem[3].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[1457].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1458].state ~= 2 and GET_PLAYER_LEVEL() >= qt[1458].needLevel and qData[1457].state == 2 then
    if qData[1458].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[3650].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3650].needLevel then
    if qData[3650].state == 1 then
      if qData[3650].killMonster[qt[3650].goal.killMonster[1].id] >= qt[3650].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3651].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3651].needLevel then
    if qData[3651].state == 1 then
      if qData[3651].killMonster[qt[3651].goal.killMonster[1].id] >= qt[3651].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
  if qData[3652].state ~= 2 and GET_PLAYER_LEVEL() >= qt[3652].needLevel then
    if qData[3652].state == 1 then
      if qData[3652].killMonster[qt[3652].goal.killMonster[1].id] >= qt[3652].goal.killMonster[1].count then
        QSTATE(id, 2)
      else
        QSTATE(id, 1)
      end
    else
      QSTATE(id, 0)
    end
  end
end
