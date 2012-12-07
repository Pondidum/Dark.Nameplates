local addon, ns = ...

local view = {
	
	new = function(parent)

		local frame = CreateFrame("Frame", nil, parent)
		frame:SetPoint("LEFT")
		frame:SetPoint("RIGHT")
		frame:SetPoint("BOTTOM")
		frame:SetHeight(config.height)

		styler.addBackground(frame)
		styler.addShadow(frame)

		local health = CreateFrame("Statusbar", nil, frame)
		health:SetStatusBarTexture(core.textures.normal)
		health:SetAllPoints(frame)

		frame.health = health

		local name = core.ui.createFont(health, core.fonts.unitframes, 10)
		name:SetPoint("TOPLEFT")
		name:SetPoint("BOTTOMLEFT")
		name:SetPoint("RIGHT", frame, "CENTER", 0, 0)

		frame.name = name

		return frame

	end,
}

ns.view = view