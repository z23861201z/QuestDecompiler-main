-- DB_DRIVEN_EXPORT
-- source: npc_322006.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_322006"
  local refs = {}
  refs[1048] = {
    name = "[ 拐杖的主人 ]",
    content0 = "那个，你现在很闲是吧？",
    reward0_count = 5,
    needLevel = 152,
    bQLoop = 0
  }
  refs[2678] = {
    name = "[ 为妈妈准备药 ]",
    content0 = "你来的正好。我有事要请你帮忙？",
    reward0_count = 0,
    needLevel = 161,
    bQLoop = 0
  }
  refs[2679] = {
    name = "[ 为孙女和女儿准备的礼物 ]",
    content0 = "你好，年轻人。",
    reward0_count = 0,
    needLevel = 162,
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
  refs[2796] = {
    name = "[ 请离开村庄 ]",
    content0 = "{0xFFFFCCCC}(转达公主的意思。){END}调查？调查？！要调查那么危险的地方吗？",
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
  refs[2799] = {
    name = "[ 吕林城老婆婆的条件 ]",
    content0 = "{0xFFFFFF00}清丽公主{END}还没有放弃吗？",
    reward0_count = 0,
    needLevel = 169,
    bQLoop = 0
  }
  return refs
end
