function npcsay(id)
  if id ~= 4391009 then
    return
  end
  clickNPCid = id
  NPC_SAY("要退出异界门吗？你从哪儿过来就把你送回哪里。想要移动到别的村就拜托云善道人吧。")
  BTN_HWANGCHUN_EXIT(id)
end
function chkQState(id)
  QSTATE(id, -1)
end
