-- DB_DRIVEN_EXPORT
-- source: npc_315020.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_315020"
  local refs = {}
  refs[1003] = {
    name = "[ 敌人的动态 ]",
    content0 = "高级手下们出现在韩野城附近意味着兰霉匠要进攻韩野城了。如果是这样就糟糕了。",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1004] = {
    name = "[ 察觉危险! ]",
    content0 = "你是谁啊，竟然出现在我面前！",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1005] = {
    name = "[ 通报危险！ ]",
    content0 = "[ 皇宫武士魏朗 ]吗…。不用担心。我换了一张脸，他们没办法认出我。只希望不要有怪物的伤害…",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1006] = {
    name = "[ 捉弄兰霉匠的手下！ ]",
    content0 = "这是什么？看着好像山参一样…",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1007] = {
    name = "[ 兰霉匠手下的供词！ ]",
    content0 = "这是哪里…哎呦好晕啊。你…你是谁？",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1008] = {
    name = "[ 冒牌部队成员 ]",
    content0 = "兰霉匠您又来了。我还没找到西米路呢…",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1230] = {
    name = "[ 皇宫的阴谋 ]",
    content0 = "冥珠城银行跟少侠说了那样的话吗？是的。我也是这么想的。虽然说是拿着皇宫的俸禄，但我也是为这卑劣的阴谋很气愤啊。",
    reward0_count = 0,
    needLevel = 46,
    bQLoop = 0
  }
  refs[1231] = {
    name = "[ 快嘴 ]",
    content0 = "你对我有什么所求吗？",
    reward0_count = 0,
    needLevel = 46,
    bQLoop = 0
  }
  return refs
end
