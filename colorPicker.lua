local addon, ns = ...

local colors = Dark.core.colors
local reactionColors = colors.reaction

 local fixColor = function(r, g, b)
    r = floor(r * 100 + .5) / 100
    g = floor(g * 100 + .5) / 100
    b = floor(b * 100 + .5) / 100

    return r, g, b
end

local colorPicker = {
	
	fix = fixColor,

	fromUnitHealth = function(r, g, b)

		r, g, b = fixColor(r, g, b)

		if g > .9 and r == 0 and b == 0 then 		-- friendly NPC
			
			r, g, b = unpack(reactionColors[5])

		elseif b > .9 and r == 0 and g == 0 then 	-- friendly player
			
			r, g, b = 0, .3, .6

		elseif r > .9 and g == 0 and b == 0 then 	-- enemy NPC
								
			r, g, b = unpack(reactionColors[1])

		elseif (r + g) > 1.8 and b == 0 then 		-- neutral NPC

			r, g, b = unpack(reactionColors[4])

		elseif r == 0.53 and g == 0.53 and b == 1 then 		-- tapped unit

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