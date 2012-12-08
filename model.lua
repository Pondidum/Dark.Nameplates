local addon, ns = ...

local model = {
	
	new = function(plate)

		local container = {}
		local bar, name	= plate:GetChildren()

		container.plate 	= plate
		container.barFrame 	= bar
		container.nameFrame = name
		container.name 		= name:GetRegions()

		local barRegions 	= container.barFrame:GetRegions()		

		container.threat 	= barRegions[1]
		container.border 	= barRegions[2]
		container.highlight = barRegions[3]
		container.level 	= barRegions[4]
		container.boss 		= barRegions[5]
		container.raid 		= barRegions[6]
		container.dragon 	= barRegions[7]

		local healthbar, castbar	= container.barFrame:GetChildren()

		container.healthbar 		= healthbar
		container.healthbarTexture 	= healthbar:GetRegions()
		container.castbar 			= castbar

		local castRegions 		 	= castbar:GetRegions()

		container.castbarTexture 	= castRegions[1]
		container.castbarBorder 	= castRegions[2]
		container.castbarShield 	= castRegions[3]
		container.castbarIcon 		= castRegions[4]

		return container

	end

}

ns.model = model