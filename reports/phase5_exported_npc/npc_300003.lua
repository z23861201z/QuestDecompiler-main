-- DB_DRIVEN_EXPORT
-- source: npc_300003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300003"
  local refs = {}
  refs[1461] = {
    name = "[化境-感兴趣的情报]",
    content0 = "什么？黑暗的坑？你也找到黑暗的坑这个线索了？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1462] = {
    name = "[化境-突如其来的战争]",
    content0 = "你是谁？秋叨鱼？师弟平安无事是吗？其他师弟们也平安？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1464] = {
    name = "[化境-觉醒！化境的境界（2）]",
    content0 = "师傅？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1465] = {
    name = "[化境-觉醒！化境的境界（3）]",
    content0 = "你的意思是说你想要掩盖你是太和老君分身的事实吗？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[2413] = {
    name = "[ 扁撅颇祈炼阿9 ]",
    content0 = "酒, 胶铰丛 坷继嚼聪鳖?",
    reward0_count = 0,
    needLevel = 133,
    bQLoop = 0
  }
  refs[2414] = {
    name = "[ 扁撅颇祈炼阿10 ]",
    content0 = "公郊 老肺 茫酒坷继唱夸? 趣矫 胶铰丛, 怕拳畴焙狼 扁撅锭巩牢啊夸?",
    reward0_count = 0,
    needLevel = 133,
    bQLoop = 0
  }
  refs[2415] = {
    name = "[ 扁撅颇祈炼阿11 ]",
    content0 = "呈公 农霸 捌沥阑 窍聪鳖 奴 捌沥牢巴涝聪促. 弊成 何碟媚焊技夸.",
    reward0_count = 0,
    needLevel = 133,
    bQLoop = 0
  }
  refs[2557] = {
    name = "[ 玄境-巨木神的委托2 ]",
    content0 = "巨木神再次强调。龟神已经列入了神仙班列，即使死了灵魂还活着",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2558] = {
    name = "[ 玄境-超火车轮怪的逆袭 ]",
    content0 = "师，师傅！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2559] = {
    name = "[ 玄境-竹统泛负伤 ]",
    content0 = "托师傅的福，再次击退了超火车轮怪了。谢谢",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2560] = {
    name = "[ 玄境-修理竹统泛的假肢1 ]",
    content0 = "师傅！你还好吗？",
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
  refs[2575] = {
    name = "[ 玄境 ]",
    content0 = "巨木神很惊讶。你善良又强大",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2654] = {
    name = "[ 鬼魂者的真气 ]",
    content0 = "看你是加入了中原的派系啊。你应该很难完全运用鬼魂者之力啊。",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[2655] = {
    name = "[ 鬼魂者的真气 ]",
    content0 = "看你是加入了中原的派系啊。你应该很难完全运用鬼魂者之力啊。",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[2660] = {
    name = "[ 担心秋叨鱼 ]",
    content0 = "哇~看起来达到新的境界了啊，{0xFF99ff99}PLAYERNAME{END}！.",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2661] = {
    name = "[ 竹统泛的对策 ]",
    content0 = "冬混汤在这附近修炼。秋叨鱼在{0xFFFFFF00}吕林城南{END}。",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2669] = {
    name = "[ 秋叨鱼的大危机2 ]",
    content0 = "哎呀，你去哪儿了，怎么才来啊！秋叨鱼的病情突然恶化了…但是监护人都不在。",
    reward0_count = 0,
    needLevel = 162,
    bQLoop = 0
  }
  refs[2670] = {
    name = "[ 不是走火入魔 ]",
    content0 = "看你表情，应该有什么急事吧？",
    reward0_count = 0,
    needLevel = 162,
    bQLoop = 0
  }
  refs[2690] = {
    name = "[ 不寻常的怪物们 ]",
    content0 = "秋叨鱼好点了吗？",
    reward0_count = 0,
    needLevel = 163,
    bQLoop = 0
  }
  refs[2691] = {
    name = "[ 超火车轮怪的逆袭1 ]",
    content0 = "师傅，出大事了！",
    reward0_count = 0,
    needLevel = 163,
    bQLoop = 0
  }
  refs[2693] = {
    name = "[ 超火车轮怪的逆袭3 ]",
    content0 = "危机暂时解除了。你再去竹统泛处看看吧。",
    reward0_count = 0,
    needLevel = 163,
    bQLoop = 0
  }
  refs[2694] = {
    name = "[ 还在持续的战斗 ]",
    content0 = "冬混汤那边的情况怎么样了？",
    reward0_count = 0,
    needLevel = 163,
    bQLoop = 0
  }
  refs[2703] = {
    name = "[ 再次前往血魔深窟1 ]",
    content0 = "你这段时间去哪里了？有什么对策吗？以后要怎么做啊？",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  refs[2704] = {
    name = "[ 再次前往血魔深窟2 ]",
    content0 = "看来秋叨鱼师弟想到了对策啊。",
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
  refs[2707] = {
    name = "[ 击退超火车轮怪 ]",
    content0 = "那是巨木神给准备的封印吗？",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  refs[2708] = {
    name = "[ 封印！超火车轮怪 ]",
    content0 = "师傅！啊，是{0xFF99ff99}PLAYERNAME{END}是吧...",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  refs[2709] = {
    name = "[ 新的修炼 ]",
    content0 = "{0xFF99ff99}PLAYERNAME{END}，辛苦了！以后打算做什么啊？",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  return refs
end
