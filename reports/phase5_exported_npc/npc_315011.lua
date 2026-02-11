-- DB_DRIVEN_EXPORT
-- source: npc_315011.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_315011"
  local refs = {}
  refs[108] = {
    name = "[ ???? ?? ???? ]",
    content0 = "?? ? ???. ?? ???…?..",
    reward0_count = 0,
    needLevel = 54,
    bQLoop = 0
  }
  refs[118] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[119] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[120] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[121] = {
    name = "[ 侠义之心1 ]",
    content0 = "什么？是正派人吗？都邀请了很久了，终于来了啊。现在因为到处都是怪物，别说是干活了，都受伤了。",
    reward0_count = 1,
    needLevel = 50,
    bQLoop = 0
  }
  refs[123] = {
    name = "[ 飞龙掌 ]",
    content0 = "正义就是力量。只有强者才有发言权，能引领时代。但是…要知道拳头的力量不是全部。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[124] = {
    name = "[ 飞龙掌 ]",
    content0 = "正义就是力量。只有强者才有发言权，能引领时代。但是…要知道拳头的力量不是全部。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[125] = {
    name = "[ 飞龙掌 ]",
    content0 = "正义就是力量。只有强者才有发言权，能引领时代。但是…要知道拳头的力量不是全部。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[126] = {
    name = "[ 愤怒的治理1 ]",
    content0 = "什么？是邪派人吗？虽然邀请了但没想到真回来。看着不是很厉害，邪派没有人了吗？",
    reward0_count = 1,
    needLevel = 50,
    bQLoop = 0
  }
  refs[156] = {
    name = "[ ???? ?? ]",
    content0 = "???? ??? ? ??? ???. ??…. ?? ? ??? ???? ???? ??! ??? ??? ??? ??????….",
    reward0_count = 0,
    needLevel = 66,
    bQLoop = 0
  }
  refs[381] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[382] = {
    name = "[ 飞龙掌 ]",
    content0 = "正义就是力量。只有强者才有发言权，能引领时代。但是…要知道拳头的力量不是全部。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[627] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[631] = {
    name = "[ 飞龙掌 ]",
    content0 = "正义就是力量。只有强者才有发言权，能引领时代。但是…要知道拳头的力量不是全部。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[1256] = {
    name = "[ 真正的理由2 ]",
    content0 = "我没想过你能帮她解决心事。再次感谢。",
    reward0_count = 0,
    needLevel = 53,
    bQLoop = 0
  }
  refs[1257] = {
    name = "[ 不能逃走的理由 ]",
    content0 = "来坐老板娘？是的，她是我的姐姐。",
    reward0_count = 0,
    needLevel = 54,
    bQLoop = 0
  }
  refs[1258] = {
    name = "[ 反复的噩梦 ]",
    content0 = "托少侠的福，暂时可以放心了。",
    reward0_count = 1,
    needLevel = 55,
    bQLoop = 0
  }
  refs[1259] = {
    name = "[ 确保脱离口 ]",
    content0 = "出事了，少侠。刚要逃出的工人因为横阻狭窄通路的大菜头不能出来。那火烫的热气能让人晕厥。",
    reward0_count = 0,
    needLevel = 56,
    bQLoop = 0
  }
  refs[1260] = {
    name = "[ 不断涌出的怪物 ]",
    content0 = "少侠刚击退了那么多怪物，现在又有很多怪物涌出来了。要想确保脱离口的通畅，还得再次帮我们击退怪物。",
    reward0_count = 0,
    needLevel = 57,
    bQLoop = 0
  }
  refs[1261] = {
    name = "[ 获得勇气的工人们 ]",
    content0 = "托少侠的福怪物数量减少了，获得勇气的工人正在营救还困在龙通路的同僚呢。",
    reward0_count = 20,
    needLevel = 58,
    bQLoop = 0
  }
  refs[1262] = {
    name = "[ 请求支援 ]",
    content0 = "救援工作差不多完成了，下面该向龙林城请求支援，正式的击退怪物了。",
    reward0_count = 1,
    needLevel = 59,
    bQLoop = 0
  }
  refs[2083] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  refs[2087] = {
    name = "[ 飞龙掌 ]",
    content0 = "所谓正义指的不完全是大义。守护并帮助被恶徒和怪物迫害的弱者也是正义的一种。",
    reward0_count = 0,
    needLevel = 50,
    bQLoop = 0
  }
  return refs
end
