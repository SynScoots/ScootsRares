local SR = {}
SR.frame = CreateFrame('Frame', 'ScootsRaresFrame', UIParent)

function SR.parseChat(msg)
    if(string.find(msg, ' (Rare)', 1, true) and string.find(msg, 'is nearby.', 1, true)) then
        local npc = string.gsub(msg, '|cff99ffff', '')
        npc = string.gsub(npc, ' %(Rare%) |cffccccccis nearby.', '')
        SendChatMessage('.findnpc ' .. npc, 'SAY')
    end
end

function SR.eventHandler(self, event, arg1)
    if(event == 'CHAT_MSG_SYSTEM') then
        SR.parseChat(arg1)
    end
end

SR.frame:SetScript('OnEvent', SR.eventHandler)

SR.frame:RegisterEvent('CHAT_MSG_SYSTEM')