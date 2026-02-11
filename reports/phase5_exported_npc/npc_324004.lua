function npcsay(id)
  if id ~= 4324004 then
    return
  end
  clickNPCid = id
  NPC_SAY("被丢弃的皱皱巴巴的魔教命令书。")
  if qData[1911].state == 1 then
    NPC_SAY("(被丢弃的纸条中提到了{0xFFFFFF00}[太和老君的第5个弟子春水糖]{END}的名字)")
    SET_QUEST_STATE(1911, 2)
    return
  end
  if qData[1917].state == 1 then
    NPC_SAY("(被丢弃的纸条中提到了{0xFFFFFF00}[太和老君的第5个弟子春水糖]{END}的名字)")
    SET_QUEST_STATE(1917, 2)
    return
  end
  if qData[1528].state == 1 then
    NPC_SAY("（师傅可能还在沉默神殿的入口处。快点出去吧！）")
    return
  end
  if qData[1529].state == 1 then
    NPC_SAY("（父亲可能还在沉默神殿的入口处。快点出去吧！）")
    return
  end
  if qData[1511].state == 1 then
    NPC_SAY("（没见到师傅，只看到揉搓的不像样的命令书扔在一旁，上面写着急召师傅）")
    SET_QUEST_STATE(1511, 2)
  end
  if qData[1512].state == 1 then
    NPC_SAY("（没见到父亲，只看到揉搓的不像样的命令书扔在一旁，上面写着急召父亲）")
    SET_QUEST_STATE(1512, 2)
  end
  if qData[1528].state == 0 and qData[1511].state == 2 and SET_PLAYER_SEX() == 1 then
    ADD_QUEST_BTN(qt[1528].id, qt[1528].name)
  end
  if qData[1529].state == 0 and qData[1512].state == 2 and SET_PLAYER_SEX() == 2 then
    ADD_QUEST_BTN(qt[1529].id, qt[1529].name)
  end
end
function chkQState(id)
  QSTATE(id, -1)
  if qData[1911].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1917].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1511].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1512].state == 1 then
    QSTATE(id, 2)
  end
  if qData[1528].state ~= 2 and qData[1511].state == 2 then
    if qData[1528].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
  if qData[1529].state ~= 2 and qData[1512].state == 2 then
    if qData[1529].state == 1 then
      QSTATE(id, 1)
    else
      QSTATE(id, 0)
    end
  end
end
