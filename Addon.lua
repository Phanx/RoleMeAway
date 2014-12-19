local function DoItLikeTheyDoOnTheDiscoveryChannel()
	local spec = GetSpecialization()
	if spec and not InCombatLockdown() then
		local _, _, _, _, _, role = GetSpecializationInfo(spec)
		if role ~= UnitGroupRolesAssigned("player") then
			UnitSetRole("player", role)
		end
		return true
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:SetScript("OnEvent", function(self, event, ...)
	if IsInGroup() then
		DoItLikeTheyDoOnTheDiscoveryChannel()
	end
end)

RolePollPopup:SetScript("OnEvent", function(self, event, ...)
	if event == "ROLE_POLL_BEGIN" and DoItLikeTheyDoOnTheDiscoveryChannel() then
		return
	end
	RolePollPopup_OnEvent(self, event, ...)
end)