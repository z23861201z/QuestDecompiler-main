-- DB_DRIVEN_EXPORT
-- source: npc_215004.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_215004"
  local refs = {}
  refs[160] = {
    name = "[ ???? ????? ]",
    content0 = "?????. ????? ??? ??? ???? ???? ? ??? ? ?? ???? ??????? ??? ????? ?? ????…. ????",
    reward0_count = 0,
    needLevel = 70,
    bQLoop = 0
  }
  refs[164] = {
    name = "[ ??? ???? ?? ]",
    content0 = "{0xFFFFFF00}?? ??? ??{END}. ?? ???? ?? ??? ?? ?? ? ??? ???. ??? ?? ???? ?? ? ??? ???!",
    reward0_count = 1,
    needLevel = 75,
    bQLoop = 0
  }
  refs[275] = {
    name = "[ ??? ? ??? ]",
    content0 = "??? ? ????…. ??? ?? ??? ??? ???? ?????? ???? ??? ??? ????? ????.",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[276] = {
    name = "[制作嘉和符咒（1）]",
    content0 = "怪盗托我秘密制作，几秒内能把一栋房子变成木炭的邪术符咒。但是那符咒的制作材料是很难收集道德。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[277] = {
    name = "[制作嘉和符咒（2）]",
    content0 = "现在符咒是完成了，就剩下给符咒注入鬼力让其能发挥真正的符咒的功能。这个事情我可做不了。",
    reward0_count = 0,
    needLevel = 80,
    bQLoop = 0
  }
  refs[451] = {
    name = "[ ? ??(2) ]",
    content0 = "?! ?? ??? {0xFF99FF99}PLAYERNAME{END}? ????.",
    reward0_count = 0,
    needLevel = 31,
    bQLoop = 0
  }
  refs[517] = {
    name = "[ 金刚石身(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[518] = {
    name = "[ 金刚石身(2) ]",
    content0 = "那本书的内容是关于武功的。把体内的真气凝聚起来薄薄的铺在全身，像是穿衣一样围在身体上的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[519] = {
    name = "[ 金刚石身(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[520] = {
    name = "[ 金刚石身(2) ]",
    content0 = "那本书的内容是关于武功的。把体内的真气凝聚起来薄薄的铺在全身，像是穿衣一样围在身体上的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[521] = {
    name = "[ 金刚石身(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[522] = {
    name = "[ 金刚石身(2) ]",
    content0 = "那本书的内容是关于武功的。把体内的真气凝聚起来薄薄的铺在全身，像是穿衣一样围在身体上的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[523] = {
    name = "[ 金刚石身(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[524] = {
    name = "[ 金刚石身(2) ]",
    content0 = "那本书的内容是关于武功的。把体内的真气凝聚起来薄薄的铺在全身，像是穿衣一样围在身体上的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[525] = {
    name = "[ 金刚石身(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[526] = {
    name = "[ 金刚石身(2) ]",
    content0 = "那本书的内容是关于武功的。把体内的真气凝聚起来薄薄的铺在全身，像是穿衣一样围在身体上的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[527] = {
    name = "[ 金刚石身(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[528] = {
    name = "[ 金刚石身(2) ]",
    content0 = "那本书的内容是关于武功的。把体内的真气凝聚起来薄薄的铺在全身，像是穿衣一样围在身体上的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[529] = {
    name = "[ 金刚石身(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[530] = {
    name = "[ 金刚石身(2) ]",
    content0 = "那本书的内容是关于武功的。把体内的真气凝聚起来薄薄的铺在全身，像是穿衣一样围在身体上的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[531] = {
    name = "[ 金刚石身(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[532] = {
    name = "[ 金刚石身(2) ]",
    content0 = "那本书的内容是关于武功的。把体内的真气凝聚起来薄薄的铺在全身，像是穿衣一样围在身体上的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[533] = {
    name = "[ 脱胎换骨 ]",
    content0 = "咳咳…千手妖女是什么样的妖怪啊？",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[556] = {
    name = "[ ??? ?? ]",
    content0 = "????? ? ??? ???? ??? ????. ??? ??? ??? ????.",
    reward0_count = 0,
    needLevel = 70,
    bQLoop = 0
  }
  refs[669] = {
    name = "[ 金刚石身(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[670] = {
    name = "[ 金刚石身(2) ]",
    content0 = "那本书的内容是关于武功的。把体内的真气凝聚起来薄薄的铺在全身，像是穿衣一样围在身体上的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[671] = {
    name = "[ 金刚石身(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[672] = {
    name = "[ 金刚石身(2) ]",
    content0 = "那本书的内容是关于武功的。把体内的真气凝聚起来薄薄的铺在全身，像是穿衣一样围在身体上的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[1283] = {
    name = "[ 女子的怨恨 ]",
    content0 = "哎呀，你听说过女子要是心怀怨恨的话六月也会飞霜的俗语吗？",
    reward0_count = 1,
    needLevel = 66,
    bQLoop = 0
  }
  refs[1305] = {
    name = "[ 神檀树的净化 ]",
    content0 = "少侠带来的羊逃之符咒好像让神檀树多少稳定了一些。",
    reward0_count = 0,
    needLevel = 72,
    bQLoop = 0
  }
  refs[1306] = {
    name = "[ 神檀树的真面目 ]",
    content0 = "哎呀，你来得正好。",
    reward0_count = 0,
    needLevel = 72,
    bQLoop = 0
  }
  refs[1307] = {
    name = "[ 神檀树的真面目2 ]",
    content0 = "神檀树本是为整个中部树林地带补充灵气的存在。但被羊逃之污染后，现在为怪物们提供力量了。",
    reward0_count = 5,
    needLevel = 72,
    bQLoop = 0
  }
  refs[1308] = {
    name = "[ 神檀树的真面目3 ]",
    content0 = "曾帮助过我的龙林城居民们被名为魔蛋的怪物传染了。",
    reward0_count = 0,
    needLevel = 73,
    bQLoop = 0
  }
  refs[1309] = {
    name = "[ 隐藏的威胁 ]",
    content0 = "大事不好！我们一直都被骗了。",
    reward0_count = 5,
    needLevel = 74,
    bQLoop = 0
  }
  refs[1310] = {
    name = "[ 隐藏的威胁2 ]",
    content0 = "只击退魔蛋的话效果太弱了吗？",
    reward0_count = 5,
    needLevel = 74,
    bQLoop = 0
  }
  refs[1311] = {
    name = "[ 隐藏的威胁3 ]",
    content0 = "少侠，大事不妙了。",
    reward0_count = 0,
    needLevel = 75,
    bQLoop = 0
  }
  refs[1312] = {
    name = "[ 死战的预感 ]",
    content0 = "首先通过少侠的帮助已经基本完成了神檀树的净化工作。",
    reward0_count = 0,
    needLevel = 75,
    bQLoop = 0
  }
  refs[1313] = {
    name = "[ 死战的预感2 ]",
    content0 = "龙林派师弟们正在找少侠呢。",
    reward0_count = 0,
    needLevel = 76,
    bQLoop = 0
  }
  refs[1530] = {
    name = "[ 强石延性(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[1531] = {
    name = "[ 强石延性(2) ]",
    content0 = "那本书的内容是关于西域武功的。是凝聚体内的真气像穿衣一样围在全身的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[1569] = {
    name = "[ 僵尸连城(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[1570] = {
    name = "[ 僵尸连城(2) ]",
    content0 = "那本书的内容是关于西域武功的，那是一种将体内的真气凝聚在身体周围的武功，就像穿衣服一样！",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[2096] = {
    name = "[ 金刚石身(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[2097] = {
    name = "[ 金刚石身(2) ]",
    content0 = "那本书的内容是关于武功的。把体内的真气凝聚起来薄薄的铺在全身，像是穿衣一样围在身体上的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[2098] = {
    name = "[ 金刚石身(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[2099] = {
    name = "[ 金刚石身(2) ]",
    content0 = "那本书的内容是关于武功的。把体内的真气凝聚起来薄薄的铺在全身，像是穿衣一样围在身体上的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[2268] = {
    name = "[强石延性(1)]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[2269] = {
    name = "[强石延性(2)]",
    content0 = "那本书的内容是关于西域武功的。是凝聚体内的真气像穿衣一样围在全身的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[2621] = {
    name = "[ 强石延性(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[2622] = {
    name = "[ 强石延性(2) ]",
    content0 = "那本书的内容是关于西域武功的。是凝聚体内的真气像穿衣一样围在全身的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[2773] = {
    name = "[ 强石延性(1) ]",
    content0 = "PLAYERNAME，你现在有时间吗？",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  refs[2774] = {
    name = "[ 强石延性(2) ]",
    content0 = "那本书的内容是关于西域武功的。是凝聚体内的真气像穿衣一样围在全身的武功",
    reward0_count = 0,
    needLevel = 115,
    bQLoop = 0
  }
  return refs
end
