-- DB_DRIVEN_EXPORT
-- source: npc_222002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_222002"
  local refs = {}
  refs[1049] = {
    name = "[ 符咒的秘密 ]",
    content0 = "{0xFF99FF99}PLAYERNAME{END}，现在忙吗？如果有空闲能不能听我说句话啊？",
    reward0_count = 5,
    needLevel = 153,
    bQLoop = 0
  }
  refs[1056] = {
    name = "[ 消失的符咒 ]",
    content0 = "你好，{0xFF99FF99}PLAYERNAME{END}，现在很忙吗？",
    reward0_count = 5,
    needLevel = 154,
    bQLoop = 0
  }
  return refs
end
