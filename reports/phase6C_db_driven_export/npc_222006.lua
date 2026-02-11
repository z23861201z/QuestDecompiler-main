-- DB_DRIVEN_EXPORT
-- source: npc_222006.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_222006"
  local refs = {}
  refs[1055] = {
    name = "[ 神秘的种子 ]",
    content0 = "哈哈哈~欢迎光临~",
    reward0_count = 5,
    needLevel = 150,
    bQLoop = 0
  }
  refs[2713] = {
    name = "[ 照亮黑暗2 ]",
    content0 = "我有事要拜托你，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 164,
    bQLoop = 0
  }
  refs[2714] = {
    name = "[ 满腔的热血，炽热的火苗 ]",
    content0 = "喂，那边路过的那个谁。",
    reward0_count = 0,
    needLevel = 165,
    bQLoop = 0
  }
  refs[2799] = {
    name = "[ 吕林城老婆婆的条件 ]",
    content0 = "{0xFFFFFF00}清丽公主{END}还没有放弃吗？",
    reward0_count = 0,
    needLevel = 169,
    bQLoop = 0
  }
  refs[2800] = {
    name = "[ 吕林城厨师的认可(1) ]",
    content0 = "你就是怂恿清丽公主想去{0xFFFFFF00}獐子潭洞穴{END}的人吧！",
    reward0_count = 0,
    needLevel = 169,
    bQLoop = 0
  }
  refs[2801] = {
    name = "[ 吕林城厨师的认可(2) ]",
    content0 = "挺厉害啊。对我也有很大的帮助。",
    reward0_count = 0,
    needLevel = 169,
    bQLoop = 0
  }
  refs[2802] = {
    name = "[ 吕林城厨师的认可(3) ]",
    content0 = "最后一次！再帮我一次的话..就同意你去{0xFFFFFF00}獐子潭洞穴{END}。",
    reward0_count = 1,
    needLevel = 169,
    bQLoop = 0
  }
  return refs
end
