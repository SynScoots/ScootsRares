local SR = {}
SR.frame = CreateFrame('Frame', 'ScootsRaresFrame', UIParent)

function SR.parseChat(msg)
    if(string.find(msg, ' (Rare)', 1, true) and string.find(msg, 'is nearby.', 1, true)) then
        local npc = string.gsub(msg, '|cff99ffff', '')
        npc = string.gsub(npc, ' %(Rare%) |cffccccccis nearby.', '')
        DEFAULT_CHAT_FRAME:AddMessage('\124HScootsRares:' .. npc .. '\124h[Click here to track ' .. npc .. ']\124h\124r')
    end
end

function SR.eventHandler(self, event, arg1)
    if(event == 'CHAT_MSG_SYSTEM') then
        SR.parseChat(arg1)
    end
end

function SR.handleLink(link)
    local _, npc = strsplit(':', link)
    SendChatMessage('.findnpc ' .. npc, 'SAY')
end

do
	local old = ItemRefTooltip.SetHyperlink
    
	function ItemRefTooltip:SetHyperlink(link, ...)
		if(link:match('^ScootsRares')) then
            SR.handleLink(link)
            return
        end
        
		return old(self, link, ...)
	end
end


SR.frame:SetScript('OnEvent', SR.eventHandler)

SR.frame:RegisterEvent('CHAT_MSG_SYSTEM')