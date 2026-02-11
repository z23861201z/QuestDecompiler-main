-- DB_DRIVEN_EXPORT
-- source: npc_322003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322003"
  local refs = {}
  refs[893] = {
    name = "[ 守护吕林的奖励 ]",
    content0 = "{0xFFFFFF00}击退80个[破戒僧]{END}之后回来就给你{0xFFFFFF00}1个吕林守护符{END}。记住了，这个任务是{0xFFFFFF00}一天只能完成一次{END}。",
    reward0_count = 1,
    needLevel = 160,
    bQLoop = 0
  }
  refs[977] = {
    name = "{0xFFFFB4B4}[ 吕林守护符 ]{END}",
    content0 = "过去镇压了妖怪们的不只是太和老君和他的12个弟子。也不能忘了没来得及留下名字就倒下的无数的英雄们。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[1047] = {
    name = "[ 和清丽公主会面 ]",
    content0 = "真是心情愉快的日子啊。谢谢你来拜访吕林城",
    reward0_count = 20,
    needLevel = 149,
    bQLoop = 0
  }
  refs[1902] = {
    name = "[ 背影杀手的幻听 ]",
    content0 = "{0xFF99ff99}PLAYERNAME{END}...呜呜...",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1904] = {
    name = "[ 背影杀手的素服 ]",
    content0 = "你是从最东边的村庄过来的吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2327] = {
    name = "[ 失踪的旅行家 ]",
    content0 = "你好！我有事要拜托你",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2331] = {
    name = "[ 旅行家的见闻 ]",
    content0 = "这，这是哪里啊？",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
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
  refs[2338] = {
    name = "[ 你还没有准备好4 ]",
    content0 = "巨木神很吃惊",
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
  refs[2677] = {
    name = "[ 为奶奶准备药 ]",
    content0 = "你好，少侠。我有个请求。.",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2792] = {
    name = "[ 来历不明的石板(6) ]",
    content0 = "是獐子潭的文字啊！这个怎么发现的？",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2793] = {
    name = "[ 石板的警告(1) ]",
    content0 = "{0xFFFFCCCC}(仔细听这段时间发生的事情。){END}太意外了，竟然能发现这个..",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2794] = {
    name = "[ 石板的警告(2) ]",
    content0 = "在哪里找到那个石板的！",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2795] = {
    name = "[ 石板的警告(3) ]",
    content0 = "突然说是诅咒，有点慌乱啊~",
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
  refs[2798] = {
    name = "[ 孤独的清丽公主 ]",
    content0 = "{0xFFFFFF00}吕林城老婆婆{END}为什么会这么强烈的反对呢？",
    reward0_count = 0,
    needLevel = 168,
    bQLoop = 0
  }
  refs[2812] = {
    name = "[ 再去獐子潭1 ]",
    content0 = "怎么样了？真的要离开吕林城吗？",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2813] = {
    name = "[ 再去獐子潭2 ]",
    content0 = "说服老婆婆了吗？",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2836] = {
    name = "[ 獐子潭诅咒的真相1 ]",
    content0 = "这么快就回来了啊！果然厉害~",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[2837] = {
    name = "[ 獐子潭诅咒的真相2 ]",
    content0 = "{0xFFFFCCCC}(听冒险家辛巴达处了解的事情。){END}",
    reward0_count = 0,
    needLevel = 170,
    bQLoop = 0
  }
  refs[3725] = {
    name = "[ 击退：击退嗜食怪（每日） ]",
    content0 = "我有很紧急的事情要拜托你。",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[3726] = {
    name = "[ 击退：击退临浦怪（每日） ]",
    content0 = "我有很紧急的事情要拜托你。",
    reward0_count = 0,
    needLevel = 162,
    bQLoop = 0
  }
  refs[3727] = {
    name = "[ 击退：击退志鬼心火（每日） ]",
    content0 = "我有很紧急的事情要拜托你。",
    reward0_count = 0,
    needLevel = 164,
    bQLoop = 0
  }
  refs[3728] = {
    name = "[ 击退：击退破戒僧（每日） ]",
    content0 = "我有很紧急的事情要拜托你。",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  return refs
end
