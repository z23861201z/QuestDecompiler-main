-- DB_DRIVEN_EXPORT
-- source: npc_222001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_222001"
  local refs = {}
  refs[2328] = {
    name = "[ 发现旅行家 ]",
    content0 = "帮，帮帮我吧",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2329] = {
    name = "[ 解毒药的材料 ]",
    content0 = "看你不像是生病的样子啊...什么事啊？",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2330] = {
    name = "[ 解毒药和粮食 ]",
    content0 = "稍等，稍等",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2662] = {
    name = "[ 秋叨鱼的状态是？ ]",
    content0 = "现在是冷还是热啊…",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2663] = {
    name = "[ 急需的药材1 ]",
    content0 = "秋叨鱼的身体状态越来越差了。",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2664] = {
    name = "[ 急需的药材2 ]",
    content0 = "这次需要的是{0xFFFFFF00}临浦怪的眼睛{END}。",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2665] = {
    name = "[ 急需的药材3-1 ]",
    content0 = "现在需要最后的药材。但是那个药材我这儿没有。",
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
  refs[2669] = {
    name = "[ 秋叨鱼的大危机2 ]",
    content0 = "哎呀，你去哪儿了，怎么才来啊！秋叨鱼的病情突然恶化了…但是监护人都不在。",
    reward0_count = 0,
    needLevel = 162,
    bQLoop = 0
  }
  refs[2677] = {
    name = "[ 为奶奶准备药 ]",
    content0 = "你好，少侠。我有个请求。.",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2678] = {
    name = "[ 为妈妈准备药 ]",
    content0 = "你来的正好。我有事要请你帮忙？",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2694] = {
    name = "[ 还在持续的战斗 ]",
    content0 = "冬混汤那边的情况怎么样了？",
    reward0_count = 0,
    needLevel = 163,
    bQLoop = 0
  }
  refs[2731] = {
    name = "[ 秋叨鱼的内功检查[2] ]",
    content0 = "不...不应该这样的！我连这样的热度都忍受不了...",
    reward0_count = 0,
    needLevel = 166,
    bQLoop = 0
  }
  refs[2732] = {
    name = "[ 秋叨鱼的内功检查[3] ]",
    content0 = "秋叨鱼晕倒了？",
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
  refs[2739] = {
    name = "[ 可疑的信 ]",
    content0 = "少侠，少侠，请等一等。",
    reward0_count = 0,
    needLevel = 167,
    bQLoop = 0
  }
  refs[2799] = {
    name = "[ 吕林城老婆婆的条件 ]",
    content0 = "{0xFFFFFF00}清丽公主{END}还没有放弃吗？",
    reward0_count = 0,
    needLevel = 169,
    bQLoop = 0
  }
  refs[2803] = {
    name = "[ 吕林城宝芝林的认可(1) ]",
    content0 = "你有什么事吗？不会是为了{0xFFFFFF00}獐子潭洞穴{END}吧？",
    reward0_count = 0,
    needLevel = 169,
    bQLoop = 0
  }
  refs[2804] = {
    name = "[ 吕林城宝芝林的认可(2) ]",
    content0 = "治疗秋叨鱼的特效药是各方面都很好的药。想要研究那个药就要更多的材料。",
    reward0_count = 0,
    needLevel = 169,
    bQLoop = 0
  }
  refs[2805] = {
    name = "[ 吕林城宝芝林的认可(3) ]",
    content0 = "现在研究接近尾声了。应该可以制作新的药了。太感谢了。",
    reward0_count = 1,
    needLevel = 169,
    bQLoop = 0
  }
  refs[3742] = {
    name = "[ 为秋叨鱼准备的特制药（每日） ]",
    content0 = "今天得准备给秋叨鱼的特制药。",
    reward0_count = 0,
    needLevel = 166,
    bQLoop = 0
  }
  return refs
end
