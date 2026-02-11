-- DB_DRIVEN_EXPORT
-- source: npc_214002.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_214002"
  local refs = {}
  refs[861] = {
    name = "[ 灵游记的回忆 ]",
    content0 = "大侠，你好。哞读册协会为了迎接新春佳节，准备制作灵游记纪念册，正在收集回忆呢。将这‘{0xFFFFFF00}回忆星{END}’保存1小时，等变成‘{0xFFFFFF00}我的记忆{END}’后拿来给我吧",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1115] = {
    name = "[ 派报员的小聪明 ]",
    content0 = "刚好我有要给商人转达的简讯，一边送简讯一边见到人，没准能遇到少侠记得的人或记得少侠的人，不是吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  refs[1116] = {
    name = "[ 哞读册的友情？ ]",
    content0 = "少侠就是宝芝林说的那个人啊。可以帮下我吗？",
    reward0_count = 5,
    needLevel = 12,
    bQLoop = 0
  }
  refs[1199] = {
    name = "[ 封印装备的活用 ]",
    content0 = "知道收集100%鬼魂的封印装备可以用来做什么吗？",
    reward0_count = 1,
    needLevel = 1,
    bQLoop = 0
  }
  return refs
end
