-- DB_DRIVEN_EXPORT
-- source: npc_320004.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_320004"
  local refs = {}
  refs[2477] = {
    name = "[ 广俊 蓖脚阑 焊疽嚼聪促 ]",
    content0 = "坷 付魔 肋 坷继嚼聪促. 变洒 靛副 何殴捞 乐嚼聪促.",
    reward0_count = 1,
    needLevel = 145,
    bQLoop = 0
  }
  refs[2478] = {
    name = "[ 荐访捞 何练窍坷 ]",
    content0 = "控瘤 掣捞 劳备妨.",
    reward0_count = 1,
    needLevel = 145,
    bQLoop = 0
  }
  refs[2479] = {
    name = "[ 荐访阑 档客林矫坷1 ]",
    content0 = "家牢, 狼蛆丛膊 何殴捞 乐家捞促.",
    reward0_count = 1,
    needLevel = 145,
    bQLoop = 0
  }
  refs[2480] = {
    name = "[ 荐访阑 档客林矫坷2 ]",
    content0 = "苞楷 家牢狼 传篮 撇府瘤 臼疽家. 狼蛆丛篮 措窜窍矫焙夸. 窍瘤父 捞锅浚 促甫 巴捞坷.",
    reward0_count = 1,
    needLevel = 145,
    bQLoop = 0
  }
  refs[2481] = {
    name = "[ 荐访阑 档客林矫坷3 ]",
    content0 = "亮家捞促. 捞锅俊绰 {0xFFFFFF00}荤锋{END}阑 硼摹钦矫促.",
    reward0_count = 1,
    needLevel = 145,
    bQLoop = 0
  }
  refs[2482] = {
    name = "[ 荐访阑 档客林矫坷4 ]",
    content0 = "绢辑 坷矫坷. 捞锅何磐绰 规过篮 粱 崔府 秦好栏搁 亮摆家捞促.",
    reward0_count = 1,
    needLevel = 146,
    bQLoop = 0
  }
  refs[2483] = {
    name = "[ 荐访阑 档客林矫坷5 ]",
    content0 = "瘤抄锅 铰何绰 肯傈茄 家牢狼 菩硅看家捞促. 窍瘤父 器扁窍瘤 臼摆家.",
    reward0_count = 1,
    needLevel = 146,
    bQLoop = 0
  }
  refs[2484] = {
    name = "[ 荐访阑 档客林矫坷6 ]",
    content0 = "歹宽 盒惯秦具摆家捞促.",
    reward0_count = 1,
    needLevel = 146,
    bQLoop = 0
  }
  refs[2485] = {
    name = "[ 鲍档狼 搬缴 ]",
    content0 = "狼蛆丛篮 沥富 碍窍矫焙夸.",
    reward0_count = 0,
    needLevel = 146,
    bQLoop = 0
  }
  refs[3679] = {
    name = "[ 与怪盗的对决：人蛇怪（每日） ]",
    content0 = "再跟我进行一次对决吗？",
    reward0_count = 0,
    needLevel = 148,
    bQLoop = 0
  }
  refs[3680] = {
    name = "[ 与怪盗的对决：吞舟鱼（每日） ]",
    content0 = "再跟我进行一次对决吗？",
    reward0_count = 0,
    needLevel = 149,
    bQLoop = 0
  }
  refs[3681] = {
    name = "[ 与怪盗的对决：邪龙（每日） ]",
    content0 = "再跟我进行一次对决吗？",
    reward0_count = 0,
    needLevel = 150,
    bQLoop = 0
  }
  return refs
end
