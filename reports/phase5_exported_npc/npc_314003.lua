-- DB_DRIVEN_EXPORT
-- source: npc_314003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_314003"
  local refs = {}
  refs[675] = {
    name = "[ 开启新的黄泉（1） ]",
    content0 = "呵呵。末日到了。兰霉匠终于动手了。啧啧。",
    reward0_count = 0,
    needLevel = 20,
    bQLoop = 0
  }
  refs[1002] = {
    name = "[ 兰霉匠的手下现身 ]",
    content0 = "你听说了吗？怪物进攻了韩野城，[ 高一燕 ]躲藏了一段时间后又重新夺回韩野城，并使韩野城竣工。",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1139] = {
    name = "[ 胡须张的召唤 ]",
    content0 = "{0xFF99ff99}PLAYERNAME{END}？清阴关的胡须张送来一封信说想马上见到您？",
    reward0_count = 1,
    needLevel = 18,
    bQLoop = 0
  }
  refs[1140] = {
    name = "[ 胡须张的召唤（2） ]",
    content0 = "快使用{0xFFFFFF00}清阴符{END}去找清阴镖局的{0xFFFFFF00}胡须张{END}吧。",
    reward0_count = 1,
    needLevel = 18,
    bQLoop = 0
  }
  refs[1141] = {
    name = "[ 胡须张的考验 ]",
    content0 = "你就是{0xFF99FF99}PLAYERNAME{END}吗？最近在这一带很有名啊。",
    reward0_count = 0,
    needLevel = 19,
    bQLoop = 0
  }
  refs[1182] = {
    name = "[ 为居民的心 ]",
    content0 = "欢迎光临。",
    reward0_count = 0,
    needLevel = 35,
    bQLoop = 0
  }
  refs[1208] = {
    name = "[ 为了清阴关！ ]",
    content0 = "推你的福现在可以再次进行贸易了。但是…。",
    reward0_count = 1,
    needLevel = 35,
    bQLoop = 0
  }
  refs[2023] = {
    name = "[ 军士 - 清阴关和佣兵团的关系1 ]",
    content0 = "我还没跟你说我们是怎么会来保护清阴关的，我简单说明一下",
    reward0_count = 0,
    needLevel = 13,
    bQLoop = 0
  }
  refs[2024] = {
    name = "[ 军士 - 清阴关和佣兵团的关系2 ]",
    content0 = "我听说过你的事，失去记忆了是吗？虽然我没办法让你恢复记忆，但只要你愿意的话，我可以让你在找回记忆之前一直留在清阴关",
    reward0_count = 0,
    needLevel = 14,
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
  refs[2027] = {
    name = "[ 军士 - 新的帮手2 ]",
    content0 = "北瓶押是太和老君的第12个弟子。很久以前怪物横行的时候太和老君领着12位弟子突然出现，经过3年的血战把怪物都击退了！",
    reward0_count = 0,
    needLevel = 16,
    bQLoop = 0
  }
  return refs
end
