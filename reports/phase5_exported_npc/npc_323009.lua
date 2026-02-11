-- DB_DRIVEN_EXPORT
-- source: npc_323009.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_323009"
  local refs = {}
  refs[874] = {
    name = "[ 调查安哥拉市小胡同 ]",
    content0 = "击退癞蛤怪和屠杀怪、狐尾怪，各收集20个受诅咒的纪念币、20瓶屠杀鬼油瓶、1个凭依念珠回来吧",
    reward0_count = 1,
    needLevel = 160,
    bQLoop = 0
  }
  refs[875] = {
    name = "[ 调查安哥拉周边 ]",
    content0 = "击退银发木怪和银胡木怪、狐尾怪队长，各收集20个银发、20个古木年轮、1个鬼魂附着的圣珠回来吧。知道了吧？",
    reward0_count = 1,
    needLevel = 160,
    bQLoop = 0
  }
  refs[877] = {
    name = "[ 安哥拉暗黑路登场 ]",
    content0 = "你要去安哥拉暗黑路？那，那可不行！很危险的！也不知道近卫兵亚夫会什么时候来呢！",
    reward0_count = 1,
    needLevel = 160,
    bQLoop = 0
  }
  refs[878] = {
    name = "[ 安哥拉营地登场 ]",
    content0 = "啊啊！还有一件事！在你调查周边的时候，近卫兵可心传话说发现了怪物密集的营地",
    reward0_count = 1,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1482] = {
    name = "[ 痴迷的酒! ]",
    content0 = "现在疑点有两个。第一个是怪物是怎么得到情报的，第二个是怪物占领小胡同的原因是什么",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1483] = {
    name = "[ 短暂勘察 ]",
    content0 = "好，好的！只要给我女儿红就让你进去。但是！{0xFFFFFF00}近卫兵亚夫{END}一来，就要出来的！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1484] = {
    name = "[ 收集证据(1) ]",
    content0 = "果然不出所料啊！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1485] = {
    name = "[ 收集证据(2) ]",
    content0 = "嗯，{0xFFFFFF00}狐尾怪{END}？第一次听说啊，确实不是原来就在西部平原地带的怪物",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1498] = {
    name = "[ 可心的调查结果]",
    content0 = "啊啊！差点忘了。在你去调查小胡同的时候，近卫兵可心传话说好像知道了怪物突然出现在城市中央的理由",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2857] = {
    name = "[ 找到安哥拉王国的异乡人 ]",
    content0 = "已经很久没有异乡人来到此处了。",
    reward0_count = 0,
    needLevel = 171,
    bQLoop = 0
  }
  refs[2858] = {
    name = "[ 再次见到辛巴达 ]",
    content0 = "我是{0xFFFFFF00}银行员辛巴达{END}。",
    reward0_count = 0,
    needLevel = 171,
    bQLoop = 0
  }
  refs[2859] = {
    name = "[ 哈玛特品尝酒1 ]",
    content0 = "我以为是谁呢，原来是最近经常看到的异乡人啊~为什么总在我身边来回？",
    reward0_count = 0,
    needLevel = 171,
    bQLoop = 0
  }
  refs[2860] = {
    name = "[ 哈玛特品尝酒2 ]",
    content0 = "{0xFFFFCCCC}(哈玛特很认真的在品酒。){END}这是..第一次品尝的味道！",
    reward0_count = 0,
    needLevel = 171,
    bQLoop = 0
  }
  refs[2862] = {
    name = "[ 哈玛特醉酒 ]",
    content0 = "{0xFFFFCCCC}(哈玛特一脸认真的在品酒。){END} 我真的太幸运了，能喝到这么好的酒。{0xFFFFCCCC}(哈玛特的脸渐渐红了。){END}",
    reward0_count = 0,
    needLevel = 171,
    bQLoop = 0
  }
  refs[2863] = {
    name = "[ 哈玛特的解酒剂 ]",
    content0 = "有话就快说。",
    reward0_count = 1,
    needLevel = 171,
    bQLoop = 0
  }
  refs[2864] = {
    name = "[ 哈玛特的决心？ ]",
    content0 = "{0xFFFFCCCC}(哈玛特赶紧喝下解酒剂。){END}呼，终于活过来了~",
    reward0_count = 0,
    needLevel = 171,
    bQLoop = 0
  }
  return refs
end
