local addon, ns = ...

local colorPicker = {
	
	fromUnitHealth = function(r, g, b)

		if g > .9 and r == 0 and b == 0 then 		-- friendly NPC
			
			r, g, b = unpack(reactionColors[5])

		elseif b > .9 and r == 0 and g == 0 then 	-- friendly player
			
			r, g, b = 0, .3, .6

		elseif r > .9 and g == 0 and b == 0 then 	-- enemy NPC
								
			r, g, b = unpack(reactionColors[1])

		elseif (r + g) > 1.8 and b == 0 then 		-- neutral NPC

			r, g, b = unpack(reactionColors[4])

		elseif (r + g) > 1.06 and b > .9 then 		-- tapped unit

			r, g, b = .5, .5, .5

		end											-- enemy player, use default UI colour
		
		return r, g, b

	end,

	fromUnitThreat = function(r, g, b)

		if g + b == 0 then 			-- aggro
			
			return 0.95, 0.2, 0.2

		elseif b == 0 then			-- high threat
			
			return 0.95, 0.95, 0.2

		else 						-- low/none

			return unpack(colors.shadow)

		end


	end,

}

ns.colorPicker = colorPicker