-- DB_DRIVEN_EXPORT
-- source: npc_322012.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322012"
  local refs = {}
  refs[2661] = {
    name = "[ 竹统泛的对策 ]",
    content0 = "冬混汤在这附近修炼。秋叨鱼在{0xFFFFFF00}吕林城南{END}。",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2662] = {
    name = "[ 秋叨鱼的状态是？ ]",
    content0 = "现在是冷还是热啊…",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2667] = {
    name = "[ 急需的药材3-3 ]",
    content0 = "挺厉害啊，这么快就击退了太极蜈蚣…",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2668] = {
    name = "[ 秋叨鱼的大危机1 ]",
    content0 = "疼…好疼…",
    reward0_count = 0,
    needLevel = 162,
    bQLoop = 0
  }
  refs[2674] = {
    name = "[ 秋叨鱼的休息 ]",
    content0 = "药制作完成了。快给秋叨鱼送去吧。",
    reward0_count = 0,
    needLevel = 162,
    bQLoop = 0
  }
  refs[2688] = {
    name = "[ 秋叨鱼醒来 ]",
    content0 = "果然是师傅啊！我听说了你为了治疗我受了很多苦.。",
    reward0_count = 0,
    needLevel = 163,
    bQLoop = 0
  }
  refs[2689] = {
    name = "[ 秋叨鱼的判断 ]",
    content0 = "短时间内先在这里各自修炼才是上策。",
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
  refs[2695] = {
    name = "[ 以后的对策1 ]",
    content0 = "听说你在我睡着的时候来过了？",
    reward0_count = 0,
    needLevel = 164,
    bQLoop = 0
  }
  refs[2696] = {
    name = "[ 以后的对策2 ]",
    content0 = "菊花碴安全吗？",
    reward0_count = 0,
    needLevel = 164,
    bQLoop = 0
  }
  refs[2697] = {
    name = "[ 以后的对策3 ]",
    content0 = "...(秋叨鱼陷入了沉思。)",
    reward0_count = 0,
    needLevel = 164,
    bQLoop = 0
  }
  refs[2709] = {
    name = "[ 新的修炼 ]",
    content0 = "{0xFF99ff99}PLAYERNAME{END}，辛苦了！以后打算做什么啊？",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  refs[2710] = {
    name = "[ 报恩的秋叨鱼1 ]",
    content0 = "{0xFF99ff99}PLAYERNAME{END}，能帮帮我吗？",
    reward0_count = 0,
    needLevel = 163,
    bQLoop = 0
  }
  refs[2711] = {
    name = "[ 报恩的秋叨鱼2 ]",
    content0 = "能再拜托你一次吗？",
    reward0_count = 0,
    needLevel = 163,
    bQLoop = 0
  }
  refs[2730] = {
    name = "[ 秋叨鱼的内功检查[1] ]",
    content0 = "咳咳，好久不见。",
    reward0_count = 0,
    needLevel = 166,
    bQLoop = 0
  }
  refs[2731] = {
    name = "[ 秋叨鱼的内功检查[2] ]",
    content0 = "不...不应该这样的！我连这样的热度都忍受不了...",
    reward0_count = 0,
    needLevel = 166,
    bQLoop = 0
  }
  refs[2739] = {
    name = "[ 可疑的信 ]",
    content0 = "少侠，少侠，请等一等。",
    reward0_count = 0,
    needLevel = 167,
    bQLoop = 0
  }
  refs[2740] = {
    name = "[ 给秋叨鱼的信 ]",
    content0 = "所以那个信是从龙林派来的人给我的吗？",
    reward0_count = 0,
    needLevel = 167,
    bQLoop = 0
  }
  refs[2796] = {
    name = "[ 请离开村庄 ]",
    content0 = "{0xFFFFCCCC}(转达公主的意思。){END}调查？调查？！要调查那么危险的地方吗？",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2797] = {
    name = "[ 危机中的秋叨鱼 ]",
    content0 = "獐子潭的诅咒？因为这个让{0xFF99ff99}PLAYERNAME{END}和我离开村子？",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2799] = {
    name = "[ 吕林城老婆婆的条件 ]",
    content0 = "{0xFFFFFF00}清丽公主{END}还没有放弃吗？",
    reward0_count = 0,
    needLevel = 169,
    bQLoop = 0
  }
  refs[2812] = {
    name = "[ 再去獐子潭1 ]",
    content0 = "怎么样了？真的要离开吕林城吗？",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  return refs
end
