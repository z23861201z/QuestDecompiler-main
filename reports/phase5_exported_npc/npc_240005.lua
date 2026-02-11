-- DB_DRIVEN_EXPORT
-- source: npc_240005.lua
function npcsay(msg)
  return msg
end

function chkQState(qData, qt)
  local npc = "npc_240005"
  local refs = {}
  refs[1477] = {
    name = "[ 旅行许可(2) ]",
    content0 = "很抱歉！但我已经联系了对獐子潭洞穴有所了解的人们！你被他们认可，我就将你介绍给{0xFFFFFF00}亲卫队长罗新{END}！",
    reward0_count = 0,
    needLevel = 160,
    bQLoop = 0
  }
  refs[1478] = {
    name = "[ 在清阴银行得到认证 ]",
    content0 = "欢迎光临，冒险家。近卫兵降落伞跟我说了你的事。你是通过獐子潭洞穴来到这里的？",
    reward0_count = 1,
    needLevel = 160,
    bQLoop = 0
  }
  refs[2857] = {
    name = "[ 找到安哥拉王国的异乡人 ]",
    content0 = "已经很久没有异乡人来到此处了。",
    reward0_count = 0,
    needLevel = 171,
    bQLoop = 0
  }
  refs[2858] = {
    name = "[ 再次见到辛巴达 ]",
    content0 = "我是{0xFFFFFF00}银行员辛巴达{END}。",
    reward0_count = 0,
    needLevel = 171,
    bQLoop = 0
  }
  return refs
end
