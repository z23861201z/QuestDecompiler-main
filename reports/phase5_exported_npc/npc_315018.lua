-- DB_DRIVEN_EXPORT
-- source: npc_315018.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_315018"
  local refs = {}
  refs[1043] = {
    name = "[ 支援皇宫武士 ]",
    content0 = "你这家伙是谁？",
    reward0_count = 0,
    needLevel = 41,
    bQLoop = 0
  }
  refs[1044] = {
    name = "[ 混沌的进攻 ]",
    content0 = "我在龙林城还有没完成的事情，你把我的话再次转达给柳江。",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1269] = {
    name = "[ 懒惰鬼的小聪明 ]",
    content0 = "希望不要太烦我。嘿嘿。",
    reward0_count = 0,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1270] = {
    name = "[ 完全不一样的感觉 ]",
    content0 = "如果我没有看错的话，比上次见到的时候能力强了一倍啊",
    reward0_count = 5,
    needLevel = 60,
    bQLoop = 0
  }
  refs[1271] = {
    name = "[ 不断的考验1 ]",
    content0 = "造船还需要很多的材料。这回得收集制造船帆的材料了。",
    reward0_count = 5,
    needLevel = 61,
    bQLoop = 0
  }
  refs[1272] = {
    name = "[ 不断的考验2 ]",
    content0 = "帮我们做船帆的防具店好像有什么困难。如果船帆不能按时做好的话会耽误计划。",
    reward0_count = 0,
    needLevel = 61,
    bQLoop = 0
  }
  refs[1275] = {
    name = "[ 新娘的悲伤 ]",
    content0 = "现在皇宫武士们为了与韩野城的战争正在征收军需品。再这样下去将无法举办婚礼。",
    reward0_count = 1,
    needLevel = 62,
    bQLoop = 0
  }
  refs[1276] = {
    name = "[ 双重间谍 ]",
    content0 = "我已经听过报告。多亏有你，一切都在顺利进行当中。辛苦了。",
    reward0_count = 0,
    needLevel = 63,
    bQLoop = 0
  }
  refs[1280] = {
    name = "[ 龙林派的自豪感 ]",
    content0 = "那，然后是…（这个师弟比我还强，我要派他做什么呢？）",
    reward0_count = 0,
    needLevel = 64,
    bQLoop = 0
  }
  refs[1285] = {
    name = "[ 暴风前夜 ]",
    content0 = "听说你在龙林派过得还可以。",
    reward0_count = 1,
    needLevel = 67,
    bQLoop = 0
  }
  refs[1294] = {
    name = "[ 团结力量 ]",
    content0 = "多亏PLAYERNAME，我们冬混汤一族和土著民们才能团结起来。感激之情无以言表…",
    reward0_count = 0,
    needLevel = 68,
    bQLoop = 0
  }
  refs[1295] = {
    name = "[ 连连不断 ]",
    content0 = "你不在的这段时间，清阴关和冥珠城一直流传着有关一位少侠的消息。",
    reward0_count = 0,
    needLevel = 68,
    bQLoop = 0
  }
  return refs
end
