-- DB_DRIVEN_EXPORT
-- source: npc_830001.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_830001"
  local refs = {}
  refs[1908] = {
    name = "[ 兰德-春水糖的失踪 ]",
    content0 = "还在担心春水糖吗？",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1909] = {
    name = "[兰德-堕落的英灵]",
    content0 = "[光辉令]原来是和我一样的英灵，但脱离了英灵界之后变成了堕落的怪物。",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1910] = {
    name = "[ 兰德-不详之感 ]",
    content0 = "慢着，这是什么？我感觉到一股强大的力量，而且非常熟悉！就好像和兰德你一样...不过却有一种不祥的预感！",
    reward0_count = 15,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1911] = {
    name = "[ 兰德-他人的痕迹 ]",
    content0 = "兰德！你怎么了？",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1912] = {
    name = "[ 兰德-大冲击! ]",
    content0 = "虽然不知道是谁，但听他在提到春水糖的名字时，总感觉有点不怀好意！希望春水糖那边别出什么事才好...",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1913] = {
    name = "[ 兰德-突如其来的旅途 ]",
    content0 = "看来你是偶然来到中原的啊！",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1920] = {
    name = "[ 苏醒的力量！-2级 ]",
    content0 = "随着你力量的增强，我也会跟着强大起来。",
    reward0_count = 0,
    needLevel = 71,
    bQLoop = 0
  }
  refs[1921] = {
    name = "[ 苏醒的力量！-3级 ]",
    content0 = "随着你力量的增强，我也会跟着强大起来。",
    reward0_count = 0,
    needLevel = 83,
    bQLoop = 0
  }
  refs[1922] = {
    name = "[ 苏醒的力量！-4级 ]",
    content0 = "随着你力量的增强，我也会跟着强大起来。",
    reward0_count = 0,
    needLevel = 95,
    bQLoop = 0
  }
  refs[1923] = {
    name = "[ 苏醒的力量！-5级 ]",
    content0 = "随着你力量的增强，我也会跟着强大起来。",
    reward0_count = 0,
    needLevel = 107,
    bQLoop = 0
  }
  refs[1924] = {
    name = "[ 古代英灵的觉醒！-6级 ]",
    content0 = "再修炼一段时间，我就能找回并使用我曾经消失的力量了。",
    reward0_count = 0,
    needLevel = 119,
    bQLoop = 0
  }
  return refs
end
