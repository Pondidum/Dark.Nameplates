local addon, ns = ...
local styler = Dark.core.style

local initPlate = function(f)

	f.barFrame, f.nameFrame = f:GetChildren()
	f.nameFrame.name = f.nameFrame:GetRegions()

	f.barFrame.threat, f.barFrame.border, f.barFrame.highlight, f.barFrame.level, f.barFrame.boss, f.barFrame.raid, f.barFrame.dragon = f.barFrame:GetRegions()
	f.barFrame.healthbar, f.barFrame.castbar = f.barFrame:GetChildren()
	f.barFrame.healthbar.texture =  f.barFrame.healthbar:GetRegions()
	f.barFrame.castbar.texture, f.barFrame.castbar.border, f.barFrame.castbar.shield, f.barFrame.castbar.icon =  f.barFrame.castbar:GetRegions()

end

local config = {
	height = 12
}

local stylePlate = {
	
	plate = function(frame)

		if frame.styled then
			return
		end

		print(frame:GetName())
		initPlate(frame)

		local bg = styler.addBackground(frame)
		bg:ClearAllPoints()
		bg:SetPoint("LEFT")
		bg:SetPoint("RIGHT")
		bg:SetPoint("BOTTOM")
		bg:SetHeight(config.height)


	end,

}

ns.style = stylePlate

DarkPlate = ns.style