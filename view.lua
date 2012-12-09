local addon, ns = ...

local core = Dark.core
local styler = core.style

local view = {
	
	new = function(parent)

		local frame = CreateFrame("Frame", nil, parent)
		frame:SetPoint("LEFT")
		frame:SetPoint("RIGHT")
		frame:SetPoint("BOTTOM")
		frame:SetHeight(ns.config.height)

		styler.addBackground(frame)
		styler.addShadow(frame)

		local health = CreateFrame("Statusbar", nil, frame)
		health:SetStatusBarTexture(core.textures.normal)
		health:SetAllPoints(frame)

		frame.health = health

		local name = core.ui.createFont(health, nil, 9)
		name:SetPoint("LEFT")
		name:SetPoint("RIGHT")
		name:SetPoint("BOTTOM", health, "TOP", 0, -5)

		frame.name = name

		local level = core.ui.createFont(health, nil, 9)
		level:SetPoint("LEFT")
		level:SetPoint("TOP", health, "BOTTOM", 0 , 5)

		frame.level = level

		local raid = frame:CreateTexture(nil, "overlay")
		raid:SetPoint("BOTTOM", health, "TOP")
		raid:SetSize(16, 16)
		raid:SetTexture(core.textures.raidmarks)

		frame.raid = raid

		return frame

	end,
}

ns.view = view