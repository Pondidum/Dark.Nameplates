local addon, ns = ...

local model = {
	
	new = function(plate)

		local container = {}
		local children 	= plate:GetChildren()

		conrainer.plate 	= plate
		container.barFrame 	= children[1]
		container.nameFrame = children[2]
		container.name 		= children[2]:GetRegions()

		local barRegions 	= container.barFrame:GetRegions()		

		container.threat 	= barRegions[1]
		container.border 	= barRegions[2]
		container.highlight = barRegions[3]
		container.level 	= barRegions[4]
		container.boss 		= barRegions[5]
		container.raid 		= barRegions[6]
		container.dragon 	= barRegions[7]

		local barChildren 	= container.barFrame:GetChildren()

		container.healthbar 		= barChildren[1]
		container.healthbarTexture 	= barChildren[1]:GetRegions()
		container.castbar 			= barChildren[2]

		local castRegions 		 	= barChildren[2]:GetRegions()

		container.castbarTexture 	= castRegions[1]
		container.castbarBorder 	= castRegions[2]
		container.castbarShield 	= castRegions[3]
		container.castbarIcon 		= castRegions[4]

		return container

	end

}

ns.model = model