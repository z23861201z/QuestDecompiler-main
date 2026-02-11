-- DB_DRIVEN_EXPORT
-- source: npc_300012.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300012"
  local refs = {}
  refs[1002] = {
    name = "[ 兰霉匠的手下现身 ]",
    content0 = "你听说了吗？怪物进攻了韩野城，[ 高一燕 ]躲藏了一段时间后又重新夺回韩野城，并使韩野城竣工。",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1003] = {
    name = "[ 敌人的动态 ]",
    content0 = "高级手下们出现在韩野城附近意味着兰霉匠要进攻韩野城了。如果是这样就糟糕了。",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1132] = {
    name = "[ 太和老君的第12个弟子 ]",
    content0 = "你知道吗？就是太和老君和他的弟子们的事。",
    reward0_count = 0,
    needLevel = 17,
    bQLoop = 0
  }
  refs[1133] = {
    name = "[ 北瓶押的考验 ]",
    content0 = "不简单啊，能找到这儿来。如果是兰霉匠的走狗就马上消失。",
    reward0_count = 1,
    needLevel = 17,
    bQLoop = 0
  }
  refs[1134] = {
    name = "[ 北瓶押的考验（2） ]",
    content0 = "知道了你是个值得信任的人。但现在你好像没有能承受得了我信任的实力。",
    reward0_count = 0,
    needLevel = 17,
    bQLoop = 0
  }
  refs[1135] = {
    name = "[ 战报任务的开始 ]",
    content0 = "功力达18了？现在知道方法了吧？同时完成从NPC处领取的任务和{0xFFFFFF00}战报任务{END}，一下就能提升功力。",
    reward0_count = 30,
    needLevel = 18,
    bQLoop = 0
  }
  refs[1180] = {
    name = "[ 回到北瓶押处 ]",
    content0 = "真是以惊人的速度成长了啊。到现在没见过像你这样的人。不知道你是不是正在找回自己失去的力量啊。",
    reward0_count = 20,
    needLevel = 35,
    bQLoop = 0
  }
  refs[2025] = {
    name = "[ 军士 - 村子的结构和主要人物 ]",
    content0 = "什么？你问清阴镖局的胡须张怎么能治理清阴关？在外人看来是会有些奇怪的。其实这里原来不是村子",
    reward0_count = 0,
    needLevel = 15,
    bQLoop = 0
  }
  refs[2026] = {
    name = "[ 军士 - 新的帮手1 ]",
    content0 = "为什么不回去，而是在此徘徊啊！",
    reward0_count = 0,
    needLevel = 16,
    bQLoop = 0
  }
  refs[2028] = {
    name = "[ 军士 - 北瓶押 ]",
    content0 = "刚刚胡须张派人传话说北瓶押在找你呢",
    reward0_count = 0,
    needLevel = 16,
    bQLoop = 0
  }
  refs[2029] = {
    name = "[ 军士 - 战报任务 ]",
    content0 = "嗯..失去记忆了？治愈武功我倒是懂一些，但是治疗失忆我也没办法。不过，有一个人应该可以治疗失忆，但是很久之前去了西域",
    reward0_count = 0,
    needLevel = 17,
    bQLoop = 0
  }
  refs[2065] = {
    name = "[ 军士 - 寻找太和老君 ]",
    content0 = "先把韩野城的事情放一放，现在中原需要的是可以管治兰霉匠的[太和老君]。不仅仅是中原，连皇宫也是.. 如果能见到他的话，有很多问题要请教的",
    reward0_count = 0,
    needLevel = 48,
    bQLoop = 0
  }
  refs[2066] = {
    name = "[ 军士 - 为了西米路 ]",
    content0 = "为了找到太和老君到处打听过，但是一个人悄悄离开后谁都没有见过了。雪上加霜的是，兰霉匠派出了手下在找剩下的弟子",
    reward0_count = 0,
    needLevel = 49,
    bQLoop = 0
  }
  return refs
end
