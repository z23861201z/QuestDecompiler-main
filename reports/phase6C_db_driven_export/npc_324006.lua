-- DB_DRIVEN_EXPORT
-- source: npc_324006.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_324006"
  local refs = {}
  refs[2258] = {
    name = "[ 纳扎尔-首次任务(1) ]",
    content0 = "大家注意！我们一起将藏在此处沉默的神殿的异教徒连根端起吧",
    reward0_count = 15,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2259] = {
    name = "[ 纳扎尔-首次任务(2) ]",
    content0 = "大家辛苦了。但是，还有很多异教徒等着我们去击退",
    reward0_count = 15,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2260] = {
    name = "[ 纳扎尔-首次任务(3) ]",
    content0 = "刚从侦察队处得知了怪物头目{0xFFFFFF00}[异教徒祭司长]{END}的位置",
    reward0_count = 15,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2261] = {
    name = "[ 纳扎尔-危机中的策士 ]",
    content0 = "大家辛苦了。应该口渴了吧，快喝水吧。我已经喝过了",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2263] = {
    name = "[ 娜迪亚-首次任务(1) ]",
    content0 = "大家注意！我们一起将藏在此处沉默的神殿的异教徒连根端起吧",
    reward0_count = 15,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2264] = {
    name = "[ 娜迪亚-首次任务(2) ]",
    content0 = "大家辛苦了。但是，还有很多异教徒等着我们去击退",
    reward0_count = 15,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2265] = {
    name = "[ 娜迪亚-首次任务(3) ]",
    content0 = "刚从侦察队处得知了怪物头目{0xFFFFFF00}[异教徒祭司长]{END}的位置",
    reward0_count = 15,
    needLevel = 1,
    bQLoop = 0
  }
  refs[2266] = {
    name = "[ 娜迪亚-危机中的策士 ]",
    content0 = "大家辛苦了。应该口渴了吧，快喝水吧。我已经喝过了",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
