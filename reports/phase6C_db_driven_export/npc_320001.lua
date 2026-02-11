-- DB_DRIVEN_EXPORT
-- source: npc_320001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_320001"
  local refs = {}
  refs[676] = {
    name = "[ 开启新的黄泉（2） ]",
    content0 = "邪派那些家伙不但不会告诉你，还会拿你逗乐子，不过我们正派就算再累也会秉持正义。因此清阴胡须张才让你来找我的吧。",
    reward0_count = 0,
    needLevel = 20,
    bQLoop = 0
  }
  refs[892] = {
    name = "[ 守护鬼觜的奖励 ]",
    content0 = "{0xFFFFFF00}击退70个[束缚老]{END}之后回来就给你{0xFFFFFF00}1个鬼觜守护符{END}。记住了，这个任务是{0xFFFFFF00}一天只能完成一次{END}。",
    reward0_count = 1,
    needLevel = 140,
    bQLoop = 0
  }
  refs[976] = {
    name = "{0xFFFFB4B4}[ 鬼觜守护符 ]{END}",
    content0 = "过去镇压了妖怪们的不只是太和老君和他的12个弟子。也不能忘了没来得及留下名字就倒下的无数的英雄们。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[1016] = {
    name = "[ 修理鬼觜客栈的天棚 ]",
    content0 = "出大事了。你能不能帮我啊？",
    reward0_count = 0,
    needLevel = 145,
    bQLoop = 0
  }
  refs[1017] = {
    name = "[ 半妖魔女的鳞 ]",
    content0 = "最近因为怪物很久没进水了，鱼鳞也伤了不少",
    reward0_count = 0,
    needLevel = 146,
    bQLoop = 0
  }
  refs[1018] = {
    name = "[ 半妖魔女的皮肤美容 ]",
    content0 = "上次你帮我收集了鳞，真的很感谢",
    reward0_count = 0,
    needLevel = 147,
    bQLoop = 0
  }
  refs[2459] = {
    name = "[ 歹 表篮 镑栏肺 ]",
    content0 = "粱 浆继唱夸?",
    reward0_count = 1,
    needLevel = 141,
    bQLoop = 0
  }
  refs[2460] = {
    name = "[ 蓖林按儡狼 林刮甸1 ]",
    content0 = "绢赣, 捞镑俊辑 荤恩阑 焊霸 瞪 临篮 隔耳匙夸. 馆啊况夸.",
    reward0_count = 1,
    needLevel = 141,
    bQLoop = 0
  }
  refs[2462] = {
    name = "[ 广捞 公挤嚼聪促 ]",
    content0 = "寸脚, 力过 碍秦焊捞绰单 朝 粱 档客临 荐 乐唱?",
    reward0_count = 1,
    needLevel = 141,
    bQLoop = 0
  }
  refs[2464] = {
    name = "[ 弊赤客 蓖林按儡1 ]",
    content0 = "弊繁单 寸脚, 咯扁辑 拌加 够 窍绰芭瘤? 瘤抄锅俊 唱客 历扁 历 鲍绢牢捞 何殴茄 付拱硼摹档 秦林绊?",
    reward0_count = 1,
    needLevel = 142,
    bQLoop = 0
  }
  refs[2465] = {
    name = "[ 弊赤客 蓖林按儡2 ]",
    content0 = "捞镑 蓖林按儡篮 盔贰绰 弊成 后笼捞菌烈. 林牢 绝绰 捞镑俊辑 弊成 去磊 瘤陈烈. 攫力何磐牢瘤绰 隔扼档 历 鲍绢牢档 咯扁 甸绢吭烈.",
    reward0_count = 1,
    needLevel = 142,
    bQLoop = 0
  }
  refs[2466] = {
    name = "[ 弊赤客 蓖林按儡3 ]",
    content0 = "酒鳖 绢叼鳖瘤 捞具扁沁烈?",
    reward0_count = 1,
    needLevel = 142,
    bQLoop = 0
  }
  refs[2467] = {
    name = "[ 弊赤客 蓖林按儡4 ]",
    content0 = "捞力 梆 促弗 镑栏肺 栋唱摆瘤夸?",
    reward0_count = 1,
    needLevel = 142,
    bQLoop = 0
  }
  refs[2468] = {
    name = "[ 弊赤客 蓖林按儡5 ]",
    content0 = "购啊 扁撅阑 茫栏继唱夸?",
    reward0_count = 1,
    needLevel = 142,
    bQLoop = 0
  }
  refs[2563] = {
    name = "[ 玄境-寻找龟神的灵魂2 ]",
    content0 = "哦，恩人！好久不见了~",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2564] = {
    name = "[ 玄境-寻找龟神的灵魂3 ]",
    content0 = "好久不见。走的时候感觉不会再回来似的..",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2565] = {
    name = "[ 玄境-寻找龟神的灵魂4 ]",
    content0 = "以前可没发现啊，你挺无耻的啊！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2566] = {
    name = "[ 玄境-寻找龟神的灵魂5 ]",
    content0 = "龟神是个很了不起的存在。虽然死了很久，但灵魂肯定还在的",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2567] = {
    name = "[ 玄境-寻找龟神的灵魂6 ]",
    content0 = "这次需要的材料是{0xFFFFFF00}50个奇妙的琵琶{END}",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2568] = {
    name = "[ 玄境-寻找龟神的灵魂7 ]",
    content0 = "这是最后一次了。收集{0xFFFFFF00}150个彩色虫符咒{END}和{0xFFFFFF00}150个燃烧的铠甲残片{END}回来吧",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2570] = {
    name = "[ 玄境-鼠偷盗 ]",
    content0 = "谢..谢..击退..了..邪龙..",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2571] = {
    name = "[ 玄境-龟神的灵魂 ]",
    content0 = "你在我进行仪式的时候做了件大事啊？！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[3673] = {
    name = "[ 不美好的：邪蜂怪（每日） ]",
    content0 = "我不喜欢不美好的事物",
    reward0_count = 0,
    needLevel = 142,
    bQLoop = 0
  }
  refs[3674] = {
    name = "[ 不美好的：鬼面蝎神（每日） ]",
    content0 = "我不喜欢不美好的事物",
    reward0_count = 0,
    needLevel = 143,
    bQLoop = 0
  }
  refs[3675] = {
    name = "[ 不美好的：束缚老（每日） ]",
    content0 = "我不喜欢不美好的事物",
    reward0_count = 0,
    needLevel = 144,
    bQLoop = 0
  }
  refs[3741] = {
    name = "[ 白鬼地狱-鬼觜客栈的危机 ]",
    content0 = "出大事了，大侠！",
    reward0_count = 1,
    needLevel = 140,
    bQLoop = 0
  }
  return refs
end
