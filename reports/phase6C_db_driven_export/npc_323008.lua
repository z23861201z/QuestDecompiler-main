-- DB_DRIVEN_EXPORT
-- source: npc_323008.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_323008"
  local refs = {}
  refs[1475] = {
    name = "[ 陌生的旅行者 ]",
    content0 = "嗯…暂停脚步。看来你不像是这里的人啊，你从哪里来啊？",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2820] = {
    name = "[ 春水糖去哪儿了？ ]",
    content0 = "{0xFFFFCCCC}(大家一起集中精神看着那本书。){END}",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2821] = {
    name = "[ 去往安哥拉王国 ]",
    content0 = "想去安哥拉王国？",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2857] = {
    name = "[ 找到安哥拉王国的异乡人 ]",
    content0 = "已经很久没有异乡人来到此处了。",
    reward0_count = 0,
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
  refs[2865] = {
    name = "[ 亚夫担心哈玛特 ]",
    content0 = "嗯，是最近才来此的异乡人啊。",
    reward0_count = 0,
    needLevel = 171,
    bQLoop = 0
  }
  refs[2866] = {
    name = "[ 无止境的战斗1 ]",
    content0 = "{0xFFFFCCCC}(突然从吕墩平原传来吵闹的声音。){END}这是什么声音？",
    reward0_count = 0,
    needLevel = 171,
    bQLoop = 0
  }
  refs[2867] = {
    name = "[ 无止境的战斗2 ]",
    content0 = "你叫什么来着？是叫{0xFF99ff99}PLAYERNAME{END}吗？",
    reward0_count = 0,
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
  refs[2885] = {
    name = "[ 可心的药2 ]",
    content0 = "所以说，不让早退，给了这{0xFFFFFF00}腹痛药{END}是吗？",
    reward0_count = 0,
    needLevel = 173,
    bQLoop = 0
  }
  refs[2896] = {
    name = "[ 大世子的下一个目标 ]",
    content0 = "{0xFFFFCCCC}(大世子认真听取关于马面人鬼的说明并记录){END}。真厉害，拖亏了你，我知道了很多事情。",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  refs[3776] = {
    name = "[ 紧急讨伐：击退甲山女鬼 ]",
    content0 = "我们上次的战斗很成功。",
    reward0_count = 0,
    needLevel = 171,
    bQLoop = 0
  }
  refs[3777] = {
    name = "[ 紧急讨伐：击退狂豚魔人 ]",
    content0 = "我们上次的战斗很成功。",
    reward0_count = 0,
    needLevel = 172,
    bQLoop = 0
  }
  refs[3780] = {
    name = "[ 紧急讨伐：讨伐咸兴魔灵 ]",
    content0 = "我们上次的战斗很成功。",
    reward0_count = 0,
    needLevel = 173,
    bQLoop = 0
  }
  refs[3781] = {
    name = "[ 紧急讨伐：讨伐马面人鬼 ]",
    content0 = "我们上次的战斗很成功。",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  return refs
end
