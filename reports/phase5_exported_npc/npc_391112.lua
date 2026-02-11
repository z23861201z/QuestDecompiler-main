-- DB_DRIVEN_EXPORT
-- source: npc_391112.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391112"
  local refs = {}
  refs[2332] = {
    name = "[ 寻找新路 ]",
    content0 = "简单的说明一下情况吧",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2333] = {
    name = "[ 你还没有准备好1 ]",
    content0 = "…",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2334] = {
    name = "[ 与怪物的对话 ]",
    content0 = "快告诉我你在新的重林里看到的一切",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2335] = {
    name = "[ 我是巨木神 ]",
    content0 = "我就是巨木重林的巨木神，也是巨木守护者！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2336] = {
    name = "[ 你还没有准备好2 ]",
    content0 = "准备好了再过来吧，你还没有准备好~",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2337] = {
    name = "[ 你还没有准备好3 ]",
    content0 = "巨木神该说的都说了。快回去吧，等你准备好了我再见你",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2339] = {
    name = "[ 吕林城没有异常 ]",
    content0 = "那些怪物怎么样了？",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2555] = {
    name = "[ 芭格脚 ]",
    content0 = "吭绰啊? 芭格脚篮 扁措啊 农促.",
    reward0_count = 1,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2556] = {
    name = "[ 玄境-巨木神的委托1 ]",
    content0 = "巨木神正在等你",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2557] = {
    name = "[ 玄境-巨木神的委托2 ]",
    content0 = "巨木神再次强调。龟神已经列入了神仙班列，即使死了灵魂还活着",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2561] = {
    name = "[ 玄境-修理竹统泛的假肢2 ]",
    content0 = "托你的福，假肢修好了。你看，手指动的很灵活..",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2562] = {
    name = "[ 玄境-寻找龟神的灵魂1 ]",
    content0 = "巨木神生气了。巨木神很好奇为什么会这么晚",
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
  refs[2572] = {
    name = "[ 玄境-思念老朋友 ]",
    content0 = "巨木神很高兴（...）是的，巨木神很高兴（...）",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2573] = {
    name = "[ 玄境-再次推向玄境的境界 ]",
    content0 = "巨木神在介绍。打招呼吧，这是我朋友龟神，你以前应该见过",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2574] = {
    name = "[ 玄境-那年那时 ]",
    content0 = "巨木神在回忆。你是龟神介绍到此地的",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2575] = {
    name = "[ 玄境 ]",
    content0 = "巨木神很惊讶。你善良又强大",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2697] = {
    name = "[ 以后的对策3 ]",
    content0 = "...(秋叨鱼陷入了沉思。)",
    reward0_count = 0,
    needLevel = 164,
    bQLoop = 0
  }
  refs[2698] = {
    name = "[ 巨木神的新封印1 ]",
    content0 = "巨木神知道。是抑制超火车轮怪的封印损坏了。",
    reward0_count = 0,
    needLevel = 164,
    bQLoop = 0
  }
  refs[2699] = {
    name = "[ 巨木神的新封印2 ]",
    content0 = "巨木神在准备。还需要临浦怪的痕迹。",
    reward0_count = 0,
    needLevel = 164,
    bQLoop = 0
  }
  refs[2700] = {
    name = "[ 巨木神的新封印3 ]",
    content0 = "巨木神在想，{0xFF99ff99}PLAYERNAME{END}果然很厉害！",
    reward0_count = 0,
    needLevel = 164,
    bQLoop = 0
  }
  refs[2701] = {
    name = "[ 巨木神的新封印4 ]",
    content0 = "巨木神还有要求。这次是最后一次。",
    reward0_count = 0,
    needLevel = 164,
    bQLoop = 0
  }
  refs[2702] = {
    name = "[ 巨木神准备封印 ]",
    content0 = "巨木神告诉你。现在大怪物和超火车轮怪的怪物们掌控了干涸的沼泽和血魔深窟周围。",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  refs[2705] = {
    name = "[ 再次前往血魔深窟3 ]",
    content0 = "现在可以休息会儿了。巨木神说了封印什么时候完成了吗？",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  refs[2706] = {
    name = "[ 再次前往血魔深窟4 ]",
    content0 = "巨木神很高兴。现在就剩最后一件事了。击退超火车轮怪后封印就可以了。",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  refs[2732] = {
    name = "[ 秋叨鱼的内功检查[3] ]",
    content0 = "秋叨鱼晕倒了？",
    reward0_count = 0,
    needLevel = 166,
    bQLoop = 0
  }
  refs[2733] = {
    name = "[ 寻找传说中的药 ]",
    content0 = "巨木神问，想知道什么？",
    reward0_count = 0,
    needLevel = 166,
    bQLoop = 0
  }
  refs[2736] = {
    name = "[ 寻找獐子潭[3] ]",
    content0 = "那里面还有这种{0xFFFFFF00}水晶碎片{END}啊，之前集中修炼都没发现。",
    reward0_count = 0,
    needLevel = 166,
    bQLoop = 0
  }
  refs[2737] = {
    name = "[ 獐子潭特制治疗剂 ]",
    content0 = "巨木神确认。看你拿来了{0xFFFFFF00}水晶碎片{END}，应该是发现了{0xFFFFFF00}獐子潭{END}。",
    reward0_count = 0,
    needLevel = 166,
    bQLoop = 0
  }
  refs[2738] = {
    name = "[ 为秋叨鱼准备的特制药 ]",
    content0 = "巨木神高兴，终于制作出了治疗剂。",
    reward0_count = 0,
    needLevel = 166,
    bQLoop = 0
  }
  refs[3663] = {
    name = "[ 与巨木神的修炼 ]",
    content0 = "巨木神对你的力量赞叹不止！",
    reward0_count = 1,
    needLevel = 160,
    bQLoop = 0
  }
  return refs
end
