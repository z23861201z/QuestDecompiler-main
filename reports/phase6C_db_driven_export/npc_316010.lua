-- DB_DRIVEN_EXPORT
-- source: npc_316010.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_316010"
  local refs = {}
  refs[488] = {
    name = "[ 符咒阵的秘密 ]",
    content0 = "有了你的帮忙，可以安全的维持咒术阵了。不明来历的僧人说想报答你的辛劳。如果你没有什么急事，就去见见吧",
    reward0_count = 0,
    needLevel = 110,
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
  refs[534] = {
    name = "[ 凌空后步 ]",
    content0 = "人的身体是越锻炼越能发挥大的能力。你知道吗？",
    reward0_count = 0,
    needLevel = 120,
    bQLoop = 0
  }
  refs[535] = {
    name = "[ 气升龙 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
    bQLoop = 0
  }
  refs[536] = {
    name = "[ 气升龙 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
    bQLoop = 0
  }
  refs[537] = {
    name = "[ 气升龙 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
    bQLoop = 0
  }
  refs[538] = {
    name = "[ 气升龙 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
    bQLoop = 0
  }
  refs[539] = {
    name = "[ 气升龙 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
    bQLoop = 0
  }
  refs[540] = {
    name = "[ 气升龙 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
    bQLoop = 0
  }
  refs[541] = {
    name = "[ 气升龙 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
    bQLoop = 0
  }
  refs[542] = {
    name = "[ 气升龙 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
    bQLoop = 0
  }
  refs[563] = {
    name = "[ 击退雪魔女 ]",
    content0 = "这里一年四季都在下雪。你知道为什么吗？",
    reward0_count = 0,
    needLevel = 108,
    bQLoop = 0
  }
  refs[564] = {
    name = "[ 疯狂的地狱狂牛 ]",
    content0 = "PLAYERNAME，你知道最近成为热点话题的地狱狂牛的横暴吗？",
    reward0_count = 0,
    needLevel = 105,
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
  refs[673] = {
    name = "[ 气升龙 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
    bQLoop = 0
  }
  refs[674] = {
    name = "[ 气升龙 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
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
  refs[1532] = {
    name = "[ 魔灵掌 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
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
  refs[1571] = {
    name = "[ 魔灵掌 ]",
    content0 = "体内真气的运用方式都是不一样的，它可以时而温和也可以时而粗狂。就算是相同的武功，它的威力也会随着真气不同方式的运用而改变。",
    reward0_count = 0,
    needLevel = 125,
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
  refs[2100] = {
    name = "[ 气升龙 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
    bQLoop = 0
  }
  refs[2101] = {
    name = "[ 气升龙 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
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
  refs[2270] = {
    name = "[魔灵掌]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
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
  refs[2623] = {
    name = "[ 魔灵掌 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
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
  refs[2775] = {
    name = "[ 魔灵掌 ]",
    content0 = "体内的气根据运用上的不同，可以温和也可粗犷。即使是相同的武功，威力和范围也根据是把气扩散开来还是凝聚在一点而不同",
    reward0_count = 0,
    needLevel = 125,
    bQLoop = 0
  }
  return refs
end
