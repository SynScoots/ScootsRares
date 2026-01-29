local ScootsRares = {
    ['version'] = '2.1.0',
    ['frame'] = CreateFrame('Frame', 'ScootsRaresFrame', UIParent)
}

function ScootsRares.parseChat(msg)
    if(string.find(msg, ' (Rare)', 1, true) and string.find(msg, 'is nearby.', 1, true)) then
        local npc = string.gsub(msg, '|cff99ffff', '')
        npc = string.gsub(npc, ' %(Rare%) |cffccccccis nearby.', '')
        
        local message = '\124HScootsRares:' .. npc .. '\124h[Click here to track ' .. npc .. ']\124h\124r'
        local printed = false
        
        for i = 1, NUM_CHAT_WINDOWS do
            local chatFrame = _G['ChatFrame' .. tostring(i)]
            if(chatFrame and chatFrame:IsEventRegistered('CHAT_MSG_SYSTEM')) then
                chatFrame:AddMessage(message)
                printed = true
            end
        end
        
        if(printed == false) then
            DEFAULT_CHAT_FRAME:AddMessage(message)
        end
    end
end

function ScootsRares.eventHandler(self, event, arg1)
    if(event == 'CHAT_MSG_SYSTEM') then
        ScootsRares.parseChat(arg1)
    end
end

function ScootsRares.handleLink(link)
    local _, npc = strsplit(':', link)
    SendChatMessage('.findnpc ' .. npc, 'SAY')
end

do
	local old = ItemRefTooltip.SetHyperlink
    
	function ItemRefTooltip:SetHyperlink(link, ...)
		if(link:match('^ScootsRares')) then
            ScootsRares.handleLink(link)
            return
        end
        
		return old(self, link, ...)
	end
end

ScootsRares.frame:SetScript('OnEvent', ScootsRares.eventHandler)

ScootsRares.frame:RegisterEvent('CHAT_MSG_SYSTEM')