-- DB_DRIVEN_EXPORT
-- source: npc_200001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_200001"
  local refs = {}
  refs[966] = {
    name = "{0xFFFFB4B4}[ 斗争证明 ]？{END}",
    content0 = "通过灵游记游戏中的各种战斗，能力被认可时能得到相应水平的证明。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[967] = {
    name = "{0xFFFFB4B4}[ 斗争证明 ]在哪里可以获得？{END}",
    content0 = "通过在各城市进行的派系战和大怪物的低吟获得。此外角色间战斗的竞赛或活动中也会发放，如有兴趣，可以查看灵游记官网的动态。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[968] = {
    name = "{0xFFFFB4B4}[ 斗争证明 ]怎么使用？{END}",
    content0 = "我会给交换成皇宫的军需物品。原本这些军需物品是不会对普通人公开的，但是皇宫的天子兰霉匠俯察之后，只要有证明就可以购买。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[969] = {
    name = "{0xFFFFB4B4}证明最多可拥有多少呢？{END}",
    content0 = "最多可以拥有10000证明。超过10000时获得的证明都会消失，请事先来我这儿购买物品吧。",
    reward0_count = 0,
    needLevel = 0,
    bQLoop = 0
  }
  refs[1326] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1327] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1328] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1329] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1330] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1331] = {
    name = "[ 破天掌 ]",
    content0 = "我认为伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1332] = {
    name = "[ 破天掌 ]",
    content0 = "我认为伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1333] = {
    name = "[ 破天掌 ]",
    content0 = "我认为伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1334] = {
    name = "[ 破天掌 ]",
    content0 = "我认为伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1335] = {
    name = "[ 破天掌 ]",
    content0 = "我认为伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2069] = {
    name = "[ 军士 - 证明管理人 ]",
    content0 = "像派系战这种血腥的战斗背后有皇宫高级装备的诱惑。我想那个装备应该归我们所有才是",
    reward0_count = 0,
    needLevel = 52,
    bQLoop = 0
  }
  refs[2070] = {
    name = "[ 军士 - 到底做了什么事？ ]",
    content0 = "你现在是要回到那位身边吗？他住在哪里啊？年纪呢？你知道他的名字的吧？告诉我吧，好不好？",
    reward0_count = 0,
    needLevel = 52,
    bQLoop = 0
  }
  refs[2085] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2089] = {
    name = "[ 破天掌 ]",
    content0 = "伸张正义指的并不仅仅是击退凶恶的怪物。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
