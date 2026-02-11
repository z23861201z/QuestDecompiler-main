-- DB_DRIVEN_EXPORT
-- source: npc_216007.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_216007"
  local refs = {}
  refs[489] = {
    name = "[ 太乙仙女的原因 ]",
    content0 = "你可以破解咒术阵…嗯…咳咳…说一下你破译的内容吧",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[493] = {
    name = "[ 决战！千手妖女(1) ]",
    content0 = "就因为你鼓起勇气…咳咳…站出来，才找到了方法…还有，如果不是你说要去击退千手妖女…也就不会想到要找这种方法了吧…",
    reward0_count = 1,
    needLevel = 110,
    bQLoop = 0
  }
  refs[494] = {
    name = "[ 决战！千手妖女(2) ]",
    content0 = "现在要开始了吧…一定要注意安全…咳咳",
    reward0_count = 1,
    needLevel = 110,
    bQLoop = 0
  }
  refs[495] = {
    name = "[ 决战！千手妖女(3) ]",
    content0 = "击退了千手妖女啊。千手妖女终于要从这个世间消失了",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[533] = {
    name = "[ 脱胎换骨 ]",
    content0 = "咳咳…千手妖女是什么样的妖怪啊？",
    reward0_count = 0,
    needLevel = 110,
    bQLoop = 0
  }
  refs[2161] = {
    name = "[ 净化的千手妖女妖气 ]",
    content0 = "去击退千手妖女之前…咳咳…我有重要的话要说",
    reward0_count = 1,
    needLevel = 110,
    bQLoop = 0
  }
  refs[2162] = {
    name = "[ 四天王碑的精气 ]",
    content0 = "我已经跟四天王碑说好了。四天王碑说不知道为什么这附近的妖怪突然聚集到了他身边，如果有人能帮他的话就把自己的精气当成谢礼送出",
    reward0_count = 1,
    needLevel = 110,
    bQLoop = 0
  }
  return refs
end
