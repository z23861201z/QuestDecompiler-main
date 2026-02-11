-- DB_DRIVEN_EXPORT
-- source: npc_323006.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_323006"
  local refs = {}
  refs[1475] = {
    name = "[ 陌生的旅行者 ]",
    content0 = "嗯…暂停脚步。看来你不像是这里的人啊，你从哪里来啊？",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1476] = {
    name = "[ 旅行许可(1) ]",
    content0 = "是从吕林城过来的旅行者？那个地方和安哥拉王宫有缔交吗？断绝来往数百年了，我也不记得了！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1477] = {
    name = "[ 旅行许可(2) ]",
    content0 = "很抱歉！但我已经联系了对獐子潭洞穴有所了解的人们！你被他们认可，我就将你介绍给{0xFFFFFF00}亲卫队长罗新{END}！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1480] = {
    name = "[ 旅行许可(3) ]",
    content0 = "进到安哥拉王宫内部，能最先见到的人就是亲卫队长罗新！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2593] = {
    name = "[ 收集石块 ]",
    content0 = "你！如果现在有时间的话，能帮我个忙吗？",
    reward0_count = 0,
    needLevel = 182,
    bQLoop = 0
  }
  refs[2879] = {
    name = "[ 配送解毒剂 ]",
    content0 = "来，这是解毒剂。",
    reward0_count = 1,
    needLevel = 173,
    bQLoop = 0
  }
  refs[2880] = {
    name = "[ 降落伞的同僚可心也生病了 ]",
    content0 = "{0xFFFFCCCC}(痛苦的表情){END}站住。这里是安哥拉王国的王宫。咳咳",
    reward0_count = 0,
    needLevel = 173,
    bQLoop = 0
  }
  refs[2887] = {
    name = "[ 可心的报复2 ]",
    content0 = "好。这次是50个{0xFFFFFF00}马面人鬼{END}！",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  refs[2888] = {
    name = "[ 降落伞的记忆1 ]",
    content0 = "{0xFFFFCCCC}(盯着可心){END}嗯嗯，刚才突然喊了一下..",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  refs[2889] = {
    name = "[ 降落伞的记忆2 ]",
    content0 = "说到哪儿了？",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  refs[2890] = {
    name = "[ 降落伞的记忆3 ]",
    content0 = "这样，我受到了两次{0xFFFFFF00}春水糖{END}的帮助。可能是担心受伤的我，{0xFFFFFF00}春水糖{END}一直陪着我侦查。",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  return refs
end
