-- DB_DRIVEN_EXPORT
-- source: npc_322013.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322013"
  local refs = {}
  refs[2670] = {
    name = "[ 不是走火入魔 ]",
    content0 = "看你表情，应该有什么急事吧？",
    reward0_count = 0,
    needLevel = 162,
    bQLoop = 0
  }
  refs[2671] = {
    name = "[ 治疗风土病的药1 ]",
    content0 = "师傅！请原谅我这个连师父的没有认出的无礼的弟子吧。",
    reward0_count = 0,
    needLevel = 162,
    bQLoop = 0
  }
  refs[2672] = {
    name = "[ 治疗风土病的药2 ]",
    content0 = "这么快！",
    reward0_count = 0,
    needLevel = 162,
    bQLoop = 0
  }
  refs[2673] = {
    name = "[ 治疗风土病的药3 ]",
    content0 = "我收拾太极蜈蚣的触须的功夫，帮我从{0xFFFFFF00}嗜食怪{END}和{0xFFFFFF00}临浦怪{END}身上收集回来剩下的材料吧。",
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
  refs[2689] = {
    name = "[ 秋叨鱼的判断 ]",
    content0 = "短时间内先在这里各自修炼才是上策。",
    reward0_count = 0,
    needLevel = 163,
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
  refs[2692] = {
    name = "[ 超火车轮怪的逆袭2 ]",
    content0 = "你能告诉我到底出了什么事了吗？",
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
  refs[2702] = {
    name = "[ 巨木神准备封印 ]",
    content0 = "巨木神告诉你。现在大怪物和超火车轮怪的怪物们掌控了干涸的沼泽和血魔深窟周围。",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  refs[2703] = {
    name = "[ 再次前往血魔深窟1 ]",
    content0 = "你这段时间去哪里了？有什么对策吗？以后要怎么做啊？",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  return refs
end
