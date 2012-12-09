local addon, ns = ...

local model = {
	
	new = function(plate)

		local container = {}
		local bar, name	= plate:GetChildren()

		container.plate 	= plate
		container.barFrame 	= bar
		container.nameFrame = name
		container.name 		= name:GetRegions()

		local barRegions 	= {container.barFrame:GetRegions()}

		container.threat 	= barRegions[1]
		container.border 	= barRegions[2]
		container.highlight = barRegions[3]
		container.level 	= barRegions[4]
		container.boss 		= barRegions[5]
		container.raid 		= barRegions[6]
		container.dragon 	= barRegions[7]

		local healthBar, castBar	= container.barFrame:GetChildren()

		container.healthBar 		= healthBar
		container.healthBarTexture 	= healthBar:GetRegions()
		container.castBar 			= castBar

		local castRegions 		 	= {castBar:GetRegions()}

		container.castBarTexture 	= castRegions[1]
		container.castBarBorder 	= castRegions[2]
		container.castBarShield 	= castRegions[3]
		container.castBarIcon 		= castRegions[4]

		return container

	end

}

ns.model = model