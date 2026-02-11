-- DB_DRIVEN_EXPORT
-- source: npc_324003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_324003"
  local refs = {}
  refs[885] = {
    name = "[ 寻找魔教宝物！ ]",
    content0 = "PLAYERNAME好久不见",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1515] = {
    name = "[ 修拉-牟永健的遗言 ]",
    content0 = "听，听我说…当我第一眼看到被波浪带到这里的你，就感受到你体内惊人的潜在力。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1516] = {
    name = "[ 罗-牟永健的遗言 ]",
    content0 = "听，听我说…当我第一眼看到被波浪带到这里的你，就感受到你体内惊人的潜在力。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1517] = {
    name = "[ 生存教育-交换箱子（1） ]",
    content0 = "你受苦了，我的兄弟",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1518] = {
    name = "[ 生存教育-交换箱子（2） ]",
    content0 = "试着把奇缺武器箱子转换成魔教武器箱子吧，我的兄弟",
    reward0_count = 3,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1519] = {
    name = "[ 生存教育-学习武功 ]",
    content0 = "兄弟啊，你的任务是除了收集情报之外，还要给在中原的魔教兄弟提供各方面的帮助",
    reward0_count = 99,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1520] = {
    name = "[ 生存教育-泰华武功 ]",
    content0 = "既然你的力量被封印了，趁此机会学习新的武功怎么样？",
    reward0_count = 99,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1521] = {
    name = "[ 生存教育-属性和武功 ]",
    content0 = "受了内伤失去了一半的功力，应该很没有精神吧。兄弟",
    reward0_count = 99,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1522] = {
    name = "[ 生存教育-鬼魂者 ]",
    content0 = "不知道我看的对不对，感觉你内心有着强大的怪物的气息。我的兄弟啊",
    reward0_count = 99,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1523] = {
    name = "[ 生存教育-战斗 ]",
    content0 = "在中原活动时所需的知识你已经都学会了",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1524] = {
    name = "[ 生存教育-门派 ]",
    content0 = "比起正派和邪派，魔教还没有完全在中原扎下根。我的兄弟",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1525] = {
    name = "[ 生存教育-黄泉 ]",
    content0 = "我们这个地方叫做现世，相反，其他异界的空间称作黄泉",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1526] = {
    name = "[ 第一次任务 ]",
    content0 = "都准备好了。现在兄弟为了魔教正式担起重任的时候到了",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1912] = {
    name = "[ 兰德-大冲击! ]",
    content0 = "虽然不知道是谁，但听他在提到春水糖的名字时，总感觉有点不怀好意！希望春水糖那边别出什么事才好...",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1913] = {
    name = "[ 兰德-突如其来的旅途 ]",
    content0 = "看来你是偶然来到中原的啊！",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1918] = {
    name = "[ 力魔-大冲击！ ]",
    content0 = "虽然不知道是谁，但听他在提到春水糖的名字时，总感觉有点不怀好意！希望春水糖那边别出什么事才好...",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1919] = {
    name = "[ 力魔-突如其来的旅途 ]",
    content0 = "看来你是偶然来到中原的啊！",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2262] = {
    name = "[ 纳扎尔-去往中原 ]",
    content0 = "赶快把这解毒药吃了！",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2267] = {
    name = "[ 娜迪亚-去往中原 ]",
    content0 = "赶快把这解毒药吃了！",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2614] = {
    name = "[ 魔布加-去往中原 ]",
    content0 = "咳！！！你…你这家伙也拥有和牟永健弟子们相同力量的啊…啊…啊啊！",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2620] = {
    name = "[ 耶单-去往中原 ]",
    content0 = "咳！！！你…你这家伙也拥有和牟永健弟子们相同力量的啊…啊…啊啊！",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2768] = {
    name = "[ 狂战士(男)-最后的训练 ]",
    content0 = "(在这里举行祭祀是吧...烧香后鞠个躬吧。)",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2772] = {
    name = "[ 狂战士(女)-最后的训练 ]",
    content0 = "(在这里举行祭祀是吧...烧香后鞠个躬吧。)",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2777] = {
    name = "[ 狂战士(男)-师傅的信 ]",
    content0 = "来，请收下...这个。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  refs[2778] = {
    name = "[ 狂战士(女)-师傅的信 ]",
    content0 = "来，请收下...这个。",
    reward0_count = 1,
    needLevel = 60,
    bQLoop = 0
  }
  return refs
end
