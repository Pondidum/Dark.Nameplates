local addon, ns = ...
local core = Dark.core
local styler = core.style

local getRegionsFor = function(f)

	local original = {}

	original.frame = f
	original.barFrame, original.nameFrame = f:GetChildren()
	original.nameFrame.name = original.nameFrame:GetRegions()

	original.barFrame.threat, original.barFrame.border, original.barFrame.highlight, original.barFrame.level, original.barFrame.boss, original.barFrame.raid, original.barFrame.dragon = original.barFrame:GetRegions()
	original.barFrame.healthbar, original.barFrame.castbar = original.barFrame:GetChildren()
	original.barFrame.healthbar.texture =  original.barFrame.healthbar:GetRegions()
	original.barFrame.castbar.texture, original.barFrame.castbar.border, original.barFrame.castbar.shield, original.barFrame.castbar.icon =  original.barFrame.castbar:GetRegions()

	return original

end

local config = {
	height = 12,
	reactionColors = Dark.core.colors.reaction,
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

		local name = core.ui.createFont(health, core.fonts.unitframes, 10)
		name:SetPoint("TOPLEFT")
		name:SetPoint("BOTTOMLEFT")
		name:SetPoint("RIGHT", parent, "CENTER", 0, 0)

		parent.name = name


		original.barFrame.healthbar:SetScript("OnValueChanged", function(self, value)

			local min, max	= self:GetMinMaxValues()
			
			health:SetMinMaxValues(min, max)
			health:SetValue(value)

		end)

		original.frame:SetScript("OnShow", function(self) 

			name:SetText(original.nameFrame.name:GetText())

			local r, g, b = original.barFrame.healthbar:GetStatusBarColor()

			if g > .9 and r == 0 and b == 0 then
				-- friendly NPC
				r, g, b = unpack(config.reactionColors[3])

			elseif b > .9 and r == 0 and g == 0 then
				-- friendly player
				r, g, b = 0, .3, .6

			elseif r > .9 and g == 0 and b == 0 then
				-- enemy NPC
				r, g, b = unpack(config.reactionColors[5])

			elseif (r + g) > 1.8 and b == 0 then
				-- neutral NPC
				r, g, b = unpack(config.reactionColors[4])

			end
			
			health:SetStatusBarColor(r, g, b)

		end)

	end,

}

ns.style = stylePlate
