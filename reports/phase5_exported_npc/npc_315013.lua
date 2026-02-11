-- DB_DRIVEN_EXPORT
-- source: npc_315013.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_315013"
  local refs = {}
  refs[1317] = {
    name = "[ 秘密浮出水面2 ]",
    content0 = "神檀树？十二妖怪的目标？原来如此。少侠已经知道了啊。",
    reward0_count = 0,
    needLevel = 77,
    bQLoop = 0
  }
  refs[1318] = {
    name = "[ 秘密浮出水面3 ]",
    content0 = "好久不见。",
    reward0_count = 0,
    needLevel = 77,
    bQLoop = 0
  }
  refs[1386] = {
    name = "[血玉髓的来历（2）]",
    content0 = "所有的事情都连在一起了。所有的事…。凶徒匪人把第一寺的视线引到这里来的，东泼肉施主冒着危险前往生死地狱的事等等…。",
    reward0_count = 1,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1387] = {
    name = "[要经过的顺序(1) ]",
    content0 = "东泼肉？凶徒匪人？那些人分明是在等着你呢吧。自己不知道在等的人是谁，但确实是你。",
    reward0_count = 3,
    needLevel = 99,
    bQLoop = 0
  }
  refs[1388] = {
    name = "[要经过的顺序(2) ]",
    content0 = "其实所有的方法武艺僧长经那孩子都知道。只是在担心可不可以击退像我子女一样的血玉髓，对我会不会有影响。",
    reward0_count = 0,
    needLevel = 99,
    bQLoop = 0
  }
  return refs
end
