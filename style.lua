local addon, ns = ...
local core = Dark.core
local styler = core.style

local getRegionsFor = function(f)

	local original = {}

	original.barFrame, original.nameFrame = f:GetChildren()
	original.nameFrame.name = original.nameFrame:GetRegions()

	original.barFrame.threat, original.barFrame.border, original.barFrame.highlight, original.barFrame.level, original.barFrame.boss, original.barFrame.raid, original.barFrame.dragon = original.barFrame:GetRegions()
	original.barFrame.healthbar, original.barFrame.castbar = original.barFrame:GetChildren()
	original.barFrame.healthbar.texture =  original.barFrame.healthbar:GetRegions()
	original.barFrame.castbar.texture, original.barFrame.castbar.border, original.barFrame.castbar.shield, original.barFrame.castbar.icon =  original.barFrame.castbar:GetRegions()

	return original

end

local config = {
	height = 12
}

local stylePlate = {
	
	plate = function(frame)

		if frame.styled then
			return
		end

		local original = getRegionsFor(frame)

		local parent = CreateFrame("Frame", nil, frame)
		parent:SetPoint("LEFT")
		parent:SetPoint("RIGHT")
		parent:SetPoint("BOTTOM")
		parent:SetHeight(config.height)

		styler.addBackground(parent)
		styler.addShadow(parent)

		local health = CreateFrame("Statusbar", nil, parent)
		health:SetStatusBarTexture(core.textures.normal)
		health:SetAllPoints(parent)

		parent.health = health

		local name = core.ui.createFont(parent)
		name:SetPoint("TOPLEFT")
		name:SetPoint("BOTTOMLEFT")
		name:SetPoint("RIGHT", parent, "CENTER", 0, 0)

		parent.name = name

	end,

}

ns.style = stylePlate
