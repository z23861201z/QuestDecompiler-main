-- DB_DRIVEN_EXPORT
-- source: npc_316013.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_316013"
  local refs = {}
  refs[1009] = {
    name = "[火车轮怪的热气]",
    content0 = "哎呦…怎么搞的",
    reward0_count = 0,
    needLevel = 127,
    bQLoop = 0
  }
  refs[1426] = {
    name = "[化境-渡头变故]",
    content0 = "施主，听说西危?谷另一边的古老的渡头出现了时空皲裂",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1427] = {
    name = "[化境-雾和热气]",
    content0 = "最近不一样的地方？也就是出现了名为火车轮怪的怪物，使得周边全是雾气和热气",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1428] = {
    name = "[化境-散不去的雾气]",
    content0 = "击退火车轮怪也没有什么变化啊。到底问题出在哪儿呢？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1430] = {
    name = "[化境-独门结界]",
    content0 = "皲裂也是出现雾气和热气的原因…不过原因不止这些",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1431] = {
    name = "[化境-疯癫的老人]",
    content0 = "秋叨鱼？皇室军士？太和老君的弟子？这样的人物怎么会在这穷乡僻壤啊？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[2354] = {
    name = "[ 困瘤荐 荐祸 ]",
    content0 = "辑困蛆邦栏肺 烹窍绰 辨捞 救沥登菌促匙. 葛滴 磊匙狼 傍捞 农匙.",
    reward0_count = 0,
    needLevel = 127,
    bQLoop = 0
  }
  refs[2378] = {
    name = "[ 促矫 困瘤荐甫 茫酒辑 ]",
    content0 = "捞力 促矫 困瘤荐丛阑 茫酒毫具钦聪促.",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[2379] = {
    name = "[ 诡荤傍狼 刘攫 ]",
    content0 = "弊锭 弊 荤恩捞备刚. 肚 公郊 老捞夸?",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[2418] = {
    name = "[ 霉锅掳扁撅颇祈炼阿 ]",
    content0 = "狼蛆丛, 坷罚父俊 核嚼聪促. 弊埃 喊绊 绝栏继唱夸?",
    reward0_count = 1,
    needLevel = 134,
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
  refs[2421] = {
    name = "[ 捍栏肺 绊烹罐绰 荤傍1 ]",
    content0 = "酒捞绊... 酒捞绊....",
    reward0_count = 1,
    needLevel = 135,
    bQLoop = 0
  }
  refs[2423] = {
    name = "[ 捍栏肺 绊烹罐绰 荤傍3 ]",
    content0 = "扒碍秦焊捞矫绰焙夸. 趣矫 焊距捞 鞘夸窍绞聪鳖?",
    reward0_count = 1,
    needLevel = 135,
    bQLoop = 0
  }
  refs[2424] = {
    name = "[ 捍栏肺 绊烹罐绰 荤傍4 ]",
    content0 = "酒酒... 捞力 粱 混巴 鞍嚼聪促.",
    reward0_count = 0,
    needLevel = 135,
    bQLoop = 0
  }
  refs[2425] = {
    name = "[ 捍栏肺 绊烹罐绰 荤傍5 ]",
    content0 = "弊烦 力啊 瘤陛 寸厘 鞘夸茄 巴阑 富靖靛府烈.",
    reward0_count = 1,
    needLevel = 135,
    bQLoop = 0
  }
  refs[2426] = {
    name = "[ 蓖林档狼 烤 捞抚 ]",
    content0 = "傣盒俊 硅甫 促 绊闷嚼聪促. 狼蛆丛.",
    reward0_count = 0,
    needLevel = 136,
    bQLoop = 0
  }
  refs[2436] = {
    name = "[ 蓖券 ]",
    content0 = "促矫 混酒辑 倒酒吭嚼聪促.",
    reward0_count = 0,
    needLevel = 137,
    bQLoop = 0
  }
  refs[2442] = {
    name = "[ 急冠 焊碍 棺 荐府1 ]",
    content0 = "历, 狼蛆丛. 趣矫 历甫 粱...",
    reward0_count = 0,
    needLevel = 140,
    bQLoop = 0
  }
  refs[2443] = {
    name = "[ 急冠 焊碍 棺 荐府2 ]",
    content0 = "历, 狼蛆丛. 角肥啊 救登搁 历甫 茄锅父 歹 档客林角 荐 乐栏脚瘤夸?",
    reward0_count = 0,
    needLevel = 140,
    bQLoop = 0
  }
  refs[2444] = {
    name = "[ 急冠 焊碍 棺 荐府3 ]",
    content0 = "历...",
    reward0_count = 0,
    needLevel = 140,
    bQLoop = 0
  }
  refs[2445] = {
    name = "[ 促矫 芭合级栏肺1 ]",
    content0 = "狼蛆丛, 瘤抄锅俊 蓖林档 酒聪 芭合级俊辑 公攫啊 档框捞 瞪父茄 扁撅阑 茫栏继唱夸?",
    reward0_count = 0,
    needLevel = 138,
    bQLoop = 0
  }
  refs[2450] = {
    name = "[ 促矫 芭合级栏肺6 ]",
    content0 = "狼蛆丛, 拌加 付拱阑 硼摹窍搁辑 扁撅阑 茫栏角 积阿捞矫烈?",
    reward0_count = 0,
    needLevel = 138,
    bQLoop = 0
  }
  refs[2451] = {
    name = "[ 免亲霖厚1 ]",
    content0 = "促矫 免亲阑 窍扁 困秦辑 咯矾啊瘤肺 霖厚且霸 腹嚼聪促.",
    reward0_count = 0,
    needLevel = 139,
    bQLoop = 0
  }
  refs[2452] = {
    name = "[ 免亲霖厚2 ]",
    content0 = "快急篮 坷阀悼救 焊包且 荐 乐绰 侥樊甸肺 霖厚秦具摆嚼聪促.",
    reward0_count = 0,
    needLevel = 139,
    bQLoop = 0
  }
  refs[2453] = {
    name = "[ 免亲霖厚3 ]",
    content0 = "捞锅俊绰 {0xFFFFFF00}祈付蓖内客 绊靛抚{END}阑 备秦林技夸.",
    reward0_count = 0,
    needLevel = 139,
    bQLoop = 0
  }
  refs[2454] = {
    name = "[ 免亲霖厚4 ]",
    content0 = "付瘤阜栏肺 侥荐 措侩前甸涝聪促. 蓖林档俊辑 柄昌茄 拱阑 备窍绰 巴捞 芭狼 阂啊瓷窍聪鳖夸.",
    reward0_count = 0,
    needLevel = 139,
    bQLoop = 0
  }
  refs[2455] = {
    name = "[ 促矫 芭合级栏肺7 ]",
    content0 = "肋 坷继嚼聪促. 免亲霖厚啊 倔付 傈俊 场车嚼聪促.",
    reward0_count = 1,
    needLevel = 140,
    bQLoop = 0
  }
  refs[2489] = {
    name = "[ 档客林寂辑 绊缚嚼聪促1 ]",
    content0 = "捞力 芭合级俊辑狼 老篮 场唱继唱夸?",
    reward0_count = 1,
    needLevel = 147,
    bQLoop = 0
  }
  refs[2494] = {
    name = "[ 档客林寂辑 绊缚嚼聪促6 ]",
    content0 = "公郊 老捞绞聪鳖? 狼蛆丛.",
    reward0_count = 1,
    needLevel = 147,
    bQLoop = 0
  }
  refs[3664] = {
    name = "[ 维修导游的船舶所需材料：熏黑的木块（每日） ]",
    content0 = "现在要修船只，但是材料不够了",
    reward0_count = 0,
    needLevel = 127,
    bQLoop = 0
  }
  refs[3665] = {
    name = "[ 维修导游的船舶所需材料：鬼毛笔（每日） ]",
    content0 = "现在要修船只，但是材料不够了",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  return refs
end
