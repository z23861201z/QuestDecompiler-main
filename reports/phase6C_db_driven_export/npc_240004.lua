-- DB_DRIVEN_EXPORT
-- source: npc_240004.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_240004"
  local refs = {}
  refs[1477] = {
    name = "[ 旅行许可(2) ]",
    content0 = "很抱歉！但我已经联系了对獐子潭洞穴有所了解的人们！你被他们认可，我就将你介绍给{0xFFFFFF00}亲卫队长罗新{END}！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1479] = {
    name = "[ 在宝芝林得到认证 ]",
    content0 = "又不是客人，来干嘛呀！什么？是{0xFFFFFF00}近卫兵降落伞{END}让你来的？呵呵，那你就是通过獐子潭洞穴的旅行者？",
    reward0_count = 1,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2184] = {
    name = "[ 世上最好的滋补强壮剂 ]",
    content0 = "不要左看右看的，要买就赶紧买，不买就走！",
    reward0_count = 0,
    needLevel = 178,
    bQLoop = 0
  }
  refs[2588] = {
    name = "[ 养生汤 ]",
    content0 = "到了这个年纪还在干活，身体大不如前了~",
    reward0_count = 0,
    needLevel = 181,
    bQLoop = 0
  }
  refs[2590] = {
    name = "[ 研究剧毒解毒剂 ]",
    content0 = "哎…因为{0xFFFFFF00}[白色阿佩普]{END}的剧毒，被抬过来或死亡的人太多了……",
    reward0_count = 0,
    needLevel = 181,
    bQLoop = 0
  }
  refs[2598] = {
    name = "[ 棘手的药材 ]",
    content0 = "你对{0xFFFFFF00}深渊的阿拉克涅心脏{END}有所了解吗？",
    reward0_count = 0,
    needLevel = 184,
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
  refs[2868] = {
    name = "[ 无止境的战斗3 ]",
    content0 = "已经达到{0xFFFFFF00}172功力{END}了啊~",
    reward0_count = 0,
    needLevel = 172,
    bQLoop = 0
  }
  refs[2869] = {
    name = "[ 亚夫的治疗剂 ]",
    content0 = "有话快说。",
    reward0_count = 0,
    needLevel = 172,
    bQLoop = 0
  }
  refs[2870] = {
    name = "[ 亚夫见到的春水糖 ]",
    content0 = "哎呀..",
    reward0_count = 0,
    needLevel = 172,
    bQLoop = 0
  }
  refs[2871] = {
    name = "[ 八字胡老头的要求事项1 ]",
    content0 = "所以，你是问我有没有见过{0xFFFFFF00}紫色头发的中原人，名字叫春水糖{END}的人是吧？",
    reward0_count = 0,
    needLevel = 172,
    bQLoop = 0
  }
  refs[2872] = {
    name = "[ 八字胡老头的要求事项2 ]",
    content0 = "你应该猜到了。接下来收集{0xFFFFFF00}咸兴魔灵{END}收集30个{0xFFFFFF00}仙人掌花{END}回来吧。",
    reward0_count = 0,
    needLevel = 172,
    bQLoop = 0
  }
  refs[2873] = {
    name = "[ 八字胡老头的要求事项3 ]",
    content0 = "最后一次了。",
    reward0_count = 0,
    needLevel = 172,
    bQLoop = 0
  }
  refs[2874] = {
    name = "[ 八字胡老头见到的外来人 ]",
    content0 = "现在来说说你想知道什么吧。",
    reward0_count = 0,
    needLevel = 172,
    bQLoop = 0
  }
  refs[2877] = {
    name = "[ 近卫兵降落伞生病了 ]",
    content0 = "你来得正好，我刚好要找你呢。",
    reward0_count = 0,
    needLevel = 173,
    bQLoop = 0
  }
  refs[2878] = {
    name = "[ 解毒剂的材料是仙人掌 ]",
    content0 = "嗯，嗯，嗯..{0xFFFFCCCC}(八字胡老头认真的检查指甲。){END}",
    reward0_count = 0,
    needLevel = 173,
    bQLoop = 0
  }
  refs[2879] = {
    name = "[ 配送解毒剂 ]",
    content0 = "来，这是解毒剂。",
    reward0_count = 1,
    needLevel = 173,
    bQLoop = 0
  }
  refs[2880] = {
    name = "[ 降落伞的同僚可心也生病了 ]",
    content0 = "{0xFFFFCCCC}(痛苦的表情){END}站住。这里是安哥拉王国的王宫。咳咳",
    reward0_count = 0,
    needLevel = 173,
    bQLoop = 0
  }
  refs[2881] = {
    name = "[ 可心的解毒剂1 ]",
    content0 = "你怎么又来了？",
    reward0_count = 0,
    needLevel = 173,
    bQLoop = 0
  }
  refs[2882] = {
    name = "[ 可心的解毒剂2 ]",
    content0 = "来，这是解毒剂。我以最快的速度制作的。",
    reward0_count = 0,
    needLevel = 173,
    bQLoop = 0
  }
  refs[3647] = {
    name = "[ 国王陛下的补药 ]",
    content0 = "来了啊~我们的{0xFF99ff99}PLAYERNAME{END}~",
    reward0_count = 0,
    needLevel = 178,
    bQLoop = 0
  }
  return refs
end
