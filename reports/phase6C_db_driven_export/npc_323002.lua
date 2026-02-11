-- DB_DRIVEN_EXPORT
-- source: npc_323002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_323002"
  local refs = {}
  refs[2597] = {
    name = "[ 危险的恶灵 ]",
    content0 = "你知道正有一群黑恶势力对我们的王国虎视眈眈吗？",
    reward0_count = 0,
    needLevel = 184,
    bQLoop = 0
  }
  refs[2890] = {
    name = "[ 降落伞的记忆3 ]",
    content0 = "这样，我受到了两次{0xFFFFFF00}春水糖{END}的帮助。可能是担心受伤的我，{0xFFFFFF00}春水糖{END}一直陪着我侦查。",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  refs[2891] = {
    name = "[ 安哥拉的名人 ]",
    content0 = "哦，刚好我也在找你呢。{0xFF99ff99}PLAYERNAME{END}!!",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  refs[2892] = {
    name = "[ 大世子的命令，调查吕墩平原1 ]",
    content0 = "你就是那个有名的{0xFF99ff99}PLAYERNAME{END}啊。见到你很高兴。",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  refs[2893] = {
    name = "[ 大世子的命令，调查吕墩平原2 ]",
    content0 = "{0xFFFFCCCC}(大世子认真听取关于甲山女鬼的说明并记录){END}。真厉害，拖亏了你，我知道了很多事情。",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  refs[2894] = {
    name = "[ 大世子的命令，调查吕墩平原3 ]",
    content0 = "{0xFFFFCCCC}(大世子认真听取关于甲山女鬼的说明并记录){END}。真厉害，拖亏了你，我知道了很多事情。",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  refs[2895] = {
    name = "[ 大世子的命令，调查吕墩平原4 ]",
    content0 = "{0xFFFFCCCC}(大世子认真听取关于咸兴魔灵的说明并记录){END}。真厉害，拖亏了你，我知道了很多事情。",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  refs[2896] = {
    name = "[ 大世子的下一个目标 ]",
    content0 = "{0xFFFFCCCC}(大世子认真听取关于马面人鬼的说明并记录){END}。真厉害，拖亏了你，我知道了很多事情。",
    reward0_count = 0,
    needLevel = 174,
    bQLoop = 0
  }
  return refs
end
