-- DB_DRIVEN_EXPORT
-- source: npc_300109.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300109"
  local refs = {}
  refs[3757] = {
    name = "[ 给小朋友发礼物 ]",
    content0 = "啊，少侠，你好~",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3758] = {
    name = "[ 发礼物1 ]",
    content0 = "这是要送给艾里村的小甜甜的礼物。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3759] = {
    name = "[ 发礼物2 ]",
    content0 = "这是要送给冥珠城东边的哭泣美眉的礼物。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3760] = {
    name = "[ 发礼物3 ]",
    content0 = "这是要送给古乐村南的长老的外甥女的礼物。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3761] = {
    name = "[ 发礼物4 ]",
    content0 = "这是要送给第一寺入口的发疯的童子僧的礼物。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3762] = {
    name = "[ 发礼物5 ]",
    content0 = "这是要送给鬼谷村南的带花女的礼物。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3763] = {
    name = "[ 发礼物6 ]",
    content0 = "这是要送给韩野村南的莲花的礼物。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3764] = {
    name = "[ 发礼物7 ]",
    content0 = "这是要送给南丰馆桥的刺猬头的礼物。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3765] = {
    name = "[ 发礼物8 ]",
    content0 = "这是要送给吕林城西的可爱小女孩的礼物。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[3766] = {
    name = "[ 发礼物9 ]",
    content0 = "这是要送给安哥拉市广场的山茶的礼物。",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
