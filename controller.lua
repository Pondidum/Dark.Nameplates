local addon, ns = ...

local reactionColors = Dark.core.colors.reaction

local controller = {
	
	hook = function(model, view)

		local model, view = model, view


		local getColor = function(r, g, b)

			if g > .9 and r == 0 and b == 0 then
				-- friendly NPC
				r, g, b = unpack(reactionColors[3])

			elseif b > .9 and r == 0 and g == 0 then
				-- friendly player
				r, g, b = 0, .3, .6

			elseif r > .9 and g == 0 and b == 0 then
				-- enemy NPC
				r, g, b = unpack(reactionColors[5])

			elseif (r + g) > 1.8 and b == 0 then
				-- neutral NPC
				r, g, b = unpack(reactionColors[4])

			end
			
			return r, g, b

		end

		local onShow = function()

			view.name:SetText(model.name:GetText())

		end

		local onHealthChanged = function(self, value)

			local min, max	= model.healthbar:GetMinMaxValues()
			
			view.health:SetMinMaxValues(min, max)
			view.health:SetValue(value)

			view.health:SetStatusBarColor(model.healthbar:GetStatusBarColor())

		end



		model.frame:SetScript("OnShow", onShow)
		model.healthbar:SetScript("OnValueChanged", onHealthChanged)

	end,

}

ns.controller = controller