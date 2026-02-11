-- DB_DRIVEN_EXPORT
-- source: npc_391107.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_391107"
  local refs = {}
  refs[872] = {
    name = "[ 击退超火车轮怪! ]",
    content0 = "你知道吗？血魔深窟的皲裂导致超火车轮怪又出现了。竹统泛和菊花碴正在找你呢",
    reward0_count = 1,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1462] = {
    name = "[化境-突如其来的战争]",
    content0 = "你是谁？秋叨鱼？师弟平安无事是吗？其他师弟们也平安？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1463] = {
    name = "[化境-觉醒！化境的境界（1）]",
    content0 = "你怎么了，少侠？哪里受伤了么？",
    reward0_count = 1,
    needLevel = 130,
    bQLoop = 0
  }
  refs[1464] = {
    name = "[化境-觉醒！化境的境界（2）]",
    content0 = "师傅？",
    reward0_count = 0,
    needLevel = 130,
    bQLoop = 0
  }
  refs[2558] = {
    name = "[ 玄境-超火车轮怪的逆袭 ]",
    content0 = "师，师傅！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2559] = {
    name = "[ 玄境-竹统泛负伤 ]",
    content0 = "托师傅的福，再次击退了超火车轮怪了。谢谢",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2707] = {
    name = "[ 击退超火车轮怪 ]",
    content0 = "那是巨木神给准备的封印吗？",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  refs[2708] = {
    name = "[ 封印！超火车轮怪 ]",
    content0 = "师傅！啊，是{0xFF99ff99}PLAYERNAME{END}是吧...",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  return refs
end
