-- DB_DRIVEN_EXPORT
-- source: npc_320003.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_320003"
  local refs = {}
  refs[2471] = {
    name = "[ 唱绰 咯青磊, 厚汲捞扼绊 窍瘤 ]",
    content0 = "傍拜窍瘤 付矫坷! 唱绰 咯青磊 厚汲捞坷.",
    reward0_count = 1,
    needLevel = 143,
    bQLoop = 0
  }
  refs[2472] = {
    name = "[ 捞镑篮 蓖林档, 窍瘤父 苞芭浚 ]",
    content0 = "扁撅阑 茫绰促扼, 弊烦 倔付 救登瘤父 郴啊 舅霸等 荤角甸阑 舅妨林摆家. 荤角 捞 级篮 入捞唱 官困肺 等 级捞 酒聪坷. 捞 级狼 烤 捞抚篮 芭. 合. 级. 捞瘤夸.",
    reward0_count = 1,
    needLevel = 143,
    bQLoop = 0
  }
  refs[2473] = {
    name = "[ 蓖林档狼 积怕拌? ]",
    content0 = "力啊 咯青阑 腹捞 促聪搁辑 荤恩档 腹捞 父车嚼聪促. 力啊 焊扁俊 寸脚篮 公傍阑 劳腮 荤恩 鞍焙夸. 酒, 坷秦窍瘤 付技夸. 何殴且霸 乐嚼聪促.",
    reward0_count = 1,
    needLevel = 144,
    bQLoop = 0
  }
  refs[2474] = {
    name = "[ 蓖林档狼 积怕拌! ]",
    content0 = "切磊甸狼 富俊 狼窍搁 蓖林档, 弊矾聪鳖 芭合级捞烈. 捞 级狼 厚剐阑 楷备窍绰单绰 {0xFFFFFF00}蜡帮摸蓖{END}鄂 付拱捞 酒林 吝夸且 巴 捞扼绊 钦聪促.",
    reward0_count = 1,
    needLevel = 144,
    bQLoop = 0
  }
  refs[2475] = {
    name = "[ 蓖林档狼 积怕拌... ]",
    content0 = "历.. 何殴捞 乐嚼聪促. 促抚捞 酒聪绊 瘤抄锅俊 蜡帮摸蓖俊 措秦辑 肋 汲疙阑 秦林继绰单 粱 何练茄 何盒捞 乐嚼聪促. 弊巴阑 舅绊 酵嚼聪促.",
    reward0_count = 1,
    needLevel = 144,
    bQLoop = 0
  }
  refs[2476] = {
    name = "[ 鹤苞 辆捞甫 茫酒林技夸 ]",
    content0 = "绢, 捞繁! 奴老车嚼聪促.",
    reward0_count = 1,
    needLevel = 144,
    bQLoop = 0
  }
  refs[3678] = {
    name = "[ 保护飞雪：六眼怪（每日） ]",
    content0 = "少侠，不知道什么时候怪物就会攻过来",
    reward0_count = 0,
    needLevel = 147,
    bQLoop = 0
  }
  refs[3682] = {
    name = "[ 守护飞雪：东来赤色鬼（每日） ]",
    content0 = "少侠，不知道什么时候怪物就会攻过来",
    reward0_count = 0,
    needLevel = 146,
    bQLoop = 0
  }
  return refs
end
