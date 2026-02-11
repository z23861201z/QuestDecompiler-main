-- DB_DRIVEN_EXPORT
-- source: npc_214005.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_214005"
  local refs = {}
  refs[1119] = {
    name = "[ 清阴关的友爱 ]",
    content0 = "现在都烦清阴关了！乡下也就算了，没有一个人帮我！",
    reward0_count = 0,
    needLevel = 13,
    bQLoop = 0
  }
  refs[1120] = {
    name = "[ 帮忙的代价 ]",
    content0 = "并不是完全相信你的话，但是既然你帮了我，我也会帮你。听说你为了找回自己的记忆，到处在找认识你的人？",
    reward0_count = 5,
    needLevel = 13,
    bQLoop = 0
  }
  refs[1121] = {
    name = "[ 名声(1) ]",
    content0 = "失去了记忆？可惜我也是第一次见到少侠。但是想推荐一个能找到认识少侠的人的方法。只要少侠出了名，不是自然就会有认识少侠的人出现了吗？",
    reward0_count = 1,
    needLevel = 14,
    bQLoop = 0
  }
  refs[1122] = {
    name = "[ 名声(2) ]",
    content0 = "他们应该不会给少侠事情做的。之前先证明少侠的实力为好。",
    reward0_count = 0,
    needLevel = 14,
    bQLoop = 0
  }
  refs[1123] = {
    name = "[ 名声(3) ]",
    content0 = "少侠独自击退5只螳螂勇勇的事迹已经传开来了。所以乌骨鸡大侠正在找您。",
    reward0_count = 1,
    needLevel = 14,
    bQLoop = 0
  }
  refs[1132] = {
    name = "[ 太和老君的第12个弟子 ]",
    content0 = "你知道吗？就是太和老君和他的弟子们的事。",
    reward0_count = 0,
    needLevel = 17,
    bQLoop = 0
  }
  refs[1181] = {
    name = "[ 银行员的愤怒 ]",
    content0 = "少侠，不对，现在应该称您为大侠。大侠的声名在清阴关流传开来。作为一个旁边者我都感到很自豪。",
    reward0_count = 0,
    needLevel = 35,
    bQLoop = 0
  }
  refs[1344] = {
    name = "[ 武功研究NPC的建议 ]",
    content0 = "首先，能知道你的人，就只有清阴关里社交面最广的清阴银行了。",
    reward0_count = 0,
    needLevel = 13,
    bQLoop = 0
  }
  refs[1505] = {
    name = "[ 灵游记期末考 ]",
    content0 = "在假期开始之前来个灵游记期末考。听好考官出的题目，自己去找正解之后接受下一题，继续去寻找正解的接力式考试。要开始吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
