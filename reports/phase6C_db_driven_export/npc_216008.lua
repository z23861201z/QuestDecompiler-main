-- DB_DRIVEN_EXPORT
-- source: npc_216008.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_216008"
  local refs = {}
  refs[1011] = {
    name = "[西域贸易]",
    content0 = "你知道击退轴画妖女可以获得{0xFFFFFF00}破旧轴画{END}吗？",
    reward0_count = 0,
    needLevel = 134,
    bQLoop = 0
  }
  refs[1012] = {
    name = "[传递货郎的消息]",
    content0 = "我能再拜托你件事情吗？",
    reward0_count = 0,
    needLevel = 140,
    bQLoop = 0
  }
  refs[2354] = {
    name = "[ 困瘤荐 荐祸 ]",
    content0 = "辑困蛆邦栏肺 烹窍绰 辨捞 救沥登菌促匙. 葛滴 磊匙狼 傍捞 农匙.",
    reward0_count = 0,
    needLevel = 127,
    bQLoop = 0
  }
  refs[2419] = {
    name = "[ 趣矫 档框捞 鞘夸窍绞聪鳖? ]",
    content0 = "恐 磊操 林函阑 干档矫烈?",
    reward0_count = 0,
    needLevel = 134,
    bQLoop = 0
  }
  refs[2420] = {
    name = "[ 力啊 咯矾盒阑 档客靛府摆嚼聪促! ]",
    content0 = "给 舅酒杭环 沁焙夸. 历锅俊 困瘤荐丛阑 茫栏矾 坷脚 狼蛆丛捞矫焙夸. 弊贰, 困瘤荐丛篮 茫栏继唱夸?",
    reward0_count = 1,
    needLevel = 134,
    bQLoop = 0
  }
  refs[2422] = {
    name = "[ 捍栏肺 绊烹罐绰 荤傍2 ]",
    content0 = "狼蛆丛?",
    reward0_count = 0,
    needLevel = 135,
    bQLoop = 0
  }
  refs[2439] = {
    name = "[ 蓖林档狼 拱前1 ]",
    content0 = "狼蛆丛, 荤傍丛苞 窃膊 蓖林档甫 促赤坷继促绊夸?",
    reward0_count = 0,
    needLevel = 139,
    bQLoop = 0
  }
  refs[2440] = {
    name = "[ 蓖林档狼 拱前2 ]",
    content0 = "瘤抄锅俊 备秦林脚 巴甸 吝俊 孺窍悼滴俺榜篮 免亲狼 青款阑 扁盔窍绰 拱扒捞菌嚼聪促.",
    reward0_count = 0,
    needLevel = 139,
    bQLoop = 0
  }
  refs[2441] = {
    name = "[ 蓖林档狼 拱前3 ]",
    content0 = "狼蛆丛, 趣矫 瘤抄锅俊 备秦林脚 {0xFFFFFF00}盔屈焕炼阿{END}阑 扁撅窍矫绰瘤夸?",
    reward0_count = 0,
    needLevel = 139,
    bQLoop = 0
  }
  refs[2489] = {
    name = "[ 档客林寂辑 绊缚嚼聪促1 ]",
    content0 = "捞力 芭合级俊辑狼 老篮 场唱继唱夸?",
    reward0_count = 1,
    needLevel = 147,
    bQLoop = 0
  }
  refs[2490] = {
    name = "[ 档客林寂辑 绊缚嚼聪促2 ]",
    content0 = "狼蛆丛捞 付拱硼摹甫 磊林 秦林脚 傣俊 混父钦聪促. 弊贰, 公郊 老捞矫烈?",
    reward0_count = 1,
    needLevel = 147,
    bQLoop = 0
  }
  refs[2491] = {
    name = "[ 档客林寂辑 绊缚嚼聪促3 ]",
    content0 = "惑磊甫 绊摹绰 悼救 备鞭惑磊俊 持阑 距犁甸阑 备秦林技夸.",
    reward0_count = 1,
    needLevel = 147,
    bQLoop = 0
  }
  refs[2492] = {
    name = "[ 档客林寂辑 绊缚嚼聪促4 ]",
    content0 = "力啊 荤豪蓖刀魔阑 吝拳矫虐绰 悼救 促弗 巴甸阑 备秦林技夸.",
    reward0_count = 1,
    needLevel = 147,
    bQLoop = 0
  }
  refs[2493] = {
    name = "[ 档客林寂辑 绊缚嚼聪促5 ]",
    content0 = "捞力 付瘤阜栏肺 {0xFFFFFF00}荤锋荐堪{END}阑 35俺 备秦林矫搁 邓聪促.",
    reward0_count = 1,
    needLevel = 147,
    bQLoop = 0
  }
  refs[3666] = {
    name = "[ 采购商品：怪异的虎皮（每日） ]",
    content0 = "少侠，别人向我寻求帮助，你能帮一下吗？",
    reward0_count = 0,
    needLevel = 132,
    bQLoop = 0
  }
  refs[3667] = {
    name = "[ 采购商品：破旧轴画（每日） ]",
    content0 = "少侠，别人向我寻求帮助，你能帮一下吗？",
    reward0_count = 0,
    needLevel = 134,
    bQLoop = 0
  }
  return refs
end
