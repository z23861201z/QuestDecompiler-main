-- DB_DRIVEN_EXPORT
-- source: npc_300111.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_300111"
  local refs = {}
  refs[1114] = {
    name = "[ 找回记忆的方法 ]",
    content0 = "针灸术好像对你没什么作用，那么就只能让你施展一下你的能力了。",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1338] = {
    name = "[ 为了加盟的考验 ]",
    content0 = "首先清阴关自警团可不能就靠着一张推荐书说进就进说出就出。只有通过考核才能入团。",
    reward0_count = 5,
    needLevel = 11,
    bQLoop = 0
  }
  refs[1339] = {
    name = "[ 为难民准备的救灾物品 ]",
    content0 = "自从怪物出现之后，受灾最严重地区之一就是清阴谷下面的南清阴平原地区。直到现在清阴关里还都是从南平原逃难出来的人。",
    reward0_count = 0,
    needLevel = 11,
    bQLoop = 0
  }
  refs[1340] = {
    name = "[ 重建的第一步 ]",
    content0 = "你知道三只手吗？",
    reward0_count = 5,
    needLevel = 12,
    bQLoop = 0
  }
  refs[1341] = {
    name = "[ 以防万一 ]",
    content0 = "最近怎么样？没有因为打怪受伤什么的吧？",
    reward0_count = 20,
    needLevel = 12,
    bQLoop = 0
  }
  refs[1342] = {
    name = "[ 定居支援 ]",
    content0 = "难民也基本上定居了…只不过耕种的时候农具好像不太够用。",
    reward0_count = 0,
    needLevel = 13,
    bQLoop = 0
  }
  refs[1343] = {
    name = "[ 退出的念头 ]",
    content0 = "这段时间辛苦了。但是记忆还是没有恢复吧？",
    reward0_count = 5,
    needLevel = 13,
    bQLoop = 0
  }
  refs[1344] = {
    name = "[ 武功研究NPC的建议 ]",
    content0 = "首先，能知道你的人，就只有清阴关里社交面最广的清阴银行了。",
    reward0_count = 0,
    needLevel = 13,
    bQLoop = 0
  }
  return refs
end
