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

		frame.threat = frame.shadow

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

		local cast = CreateFrame("Statusbar", nil, frame)
		cast:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -5)
		cast:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -5)
		cast:SetHeight(ns.config.castHeight)
		cast:SetStatusBarTexture(core.textures.normal)

		styler.addBackground(cast)
		styler.addShadow(cast)

		local castIcon = CreateFrame("Frame", nil, cast)
		castIcon:SetPoint("RIGHT", cast, "LEFT", -3, 0)
		castIcon:SetSize(ns.config.castIconHeight, ns.config.castIconHeight)

		styler.addBackground(castIcon)
		styler.addShadow(castIcon)

		local icon = castIcon:CreateTexture(nil, "overlay")
		icon:SetTexCoord(.08, .92, .08, .92)
		icon:SetAllPoints(castIcon)

		local castName = core.ui.createFont(cast, nil, 9)
		castName:SetAllPoints(cast)

		frame.cast = cast
		frame.castIcon = icon
		frame.castName = castName

		cast:Hide()

		return frame

	end,
}

ns.view = view