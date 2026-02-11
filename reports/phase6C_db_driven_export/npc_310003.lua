-- DB_DRIVEN_EXPORT
-- source: npc_310003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_310003"
  local refs = {}
  refs[560] = {
    name = "[ 对身体好的毒蘑菇 ]",
    content0 = "恩恩…我虽然挣了很多钱，也很富有…但最重要的不是健康吗？",
    reward0_count = 0,
    needLevel = 101,
    bQLoop = 0
  }
  refs[561] = {
    name = "[ 对身体好的骷髅鸟碎片 ]",
    content0 = "PLAYERNAME，上次给我送来的毒蘑菇是真的吗？",
    reward0_count = 0,
    needLevel = 102,
    bQLoop = 0
  }
  refs[1221] = {
    name = "[ 更积极地解决方案2 ]",
    content0 = "少侠，还剩下一件事情。",
    reward0_count = 0,
    needLevel = 43,
    bQLoop = 0
  }
  refs[1222] = {
    name = "[ 账簿的位置 ]",
    content0 = "嗯？想为我做事？",
    reward0_count = 1,
    needLevel = 43,
    bQLoop = 0
  }
  refs[1223] = {
    name = "[ 收账业务 ]",
    content0 = "知道了你是个可用之才。那就正式的帮我做事吧。如果能办成这件事你就成为指挥我手下高手们的指挥官，深得我的信任。",
    reward0_count = 0,
    needLevel = 44,
    bQLoop = 0
  }
  refs[1224] = {
    name = "[ 收账业务2 ]",
    content0 = "有什么事我也不能给他这个店！",
    reward0_count = 20,
    needLevel = 44,
    bQLoop = 0
  }
  refs[1225] = {
    name = "[ 收账业务3 ]",
    content0 = "托您的福顺利交货了。这个恩惠我不会忘记的。",
    reward0_count = 0,
    needLevel = 44,
    bQLoop = 0
  }
  refs[1226] = {
    name = "[ 最重要的 ]",
    content0 = "不管结果怎么样，我决定按照约定相信你。",
    reward0_count = 1,
    needLevel = 44,
    bQLoop = 0
  }
  return refs
end
