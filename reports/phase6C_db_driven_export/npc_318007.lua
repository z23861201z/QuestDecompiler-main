-- DB_DRIVEN_EXPORT
-- source: npc_318007.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_318007"
  local refs = {}
  refs[16] = {
    name = "[ 武士转职 ]",
    content0 = "??? ?? ????",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[19] = {
    name = "[ 刺客转职 ]",
    content0 = "??? ?? ?????",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[21] = {
    name = "[ 道士转职 ]",
    content0 = "??? ?? ?????",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[351] = {
    name = "[ 力士转职 ]",
    content0 = "??? ?? ??!?",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[612] = {
    name = "[ 射手转职 ]",
    content0 = "??? ?? ??????",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[613] = {
    name = "[ 弓-韩野格弓 ]",
    content0 = "{0xFFFFFF00}韩野格弓，可以自由使用弓，使用弓时物理攻击力得到上升的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[614] = {
    name = "[ 炮-崩天炮 ]",
    content0 = "{0xFFFFFF00}崩天炮，可以自由使用大炮，使用大炮时物理攻击力得到上升的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[615] = {
    name = "[ 弓-虎三弓 ]",
    content0 = "虎三弓是利用手的灵活，同时发射两支箭的武功。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[616] = {
    name = "[ 炮-火光弹 ]",
    content0 = "{0xFFFFFF00}火光弹是利用身体的灵活，在前方引爆炸药以攻击前方对手的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 1,
    bQLoop = 0
  }
  refs[617] = {
    name = "[ 弓-鹰爪飞弓 ]",
    content0 = "{0xFFFFFF00}鹰爪飞弓是将弓箭弯曲成鹰爪形状进行攻击的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 18,
    bQLoop = 0
  }
  refs[618] = {
    name = "[ 大炮-轴环飞击 ]",
    content0 = "{0xFFFFFF00}轴环飞击是两次旋转身体，并连续攻击的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 18,
    bQLoop = 0
  }
  refs[619] = {
    name = "[ 共同-津液弹 ]",
    content0 = "{0xFFFFFF00}津液弹是可以使对手行动缓慢的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 23,
    bQLoop = 0
  }
  refs[620] = {
    name = "[ 共同-光速真眼 ]",
    content0 = "{0xFFFFFF00}光速真眼是可以在一定时间内清楚怪物位置的武功{END}。要学吗？",
    reward0_count = 0,
    needLevel = 28,
    bQLoop = 0
  }
  refs[621] = {
    name = "[ 共同-无影退 ]",
    content0 = "{0xFFFFFF00}无影退是可以快速后退的武功，在远距离攻击中比较容易{END}。是生存下去非常有用的武功。要学吗？",
    reward0_count = 0,
    needLevel = 33,
    bQLoop = 0
  }
  refs[622] = {
    name = "[ 共同-鹰庇佑 ]",
    content0 = "{0xFFFFFF00}鹰庇佑，在一定时间内可以让回避率和防御力同时上升的武功{END}。是生存下去非常有用的武功。要学吗？",
    reward0_count = 0,
    needLevel = 38,
    bQLoop = 0
  }
  refs[623] = {
    name = "[ 弓-鸦力妖弓 ]",
    content0 = "{0xFFFFFF00}鸦力妖弓用弓之人最高等级的武功{END}。是攻击对手眼睛的武功，要求有高难度的技术。要学吗？",
    reward0_count = 0,
    needLevel = 43,
    bQLoop = 0
  }
  refs[624] = {
    name = "[ 炮-远程弹 ]",
    content0 = "{0xFFFFFF00}远程弹是使用大炮之人最高等级的武功{END}。是向敌人发射炮弹的武功。要学吗？",
    reward0_count = 0,
    needLevel = 43,
    bQLoop = 0
  }
  return refs
end
