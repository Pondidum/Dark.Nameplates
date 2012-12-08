local addon, ns = ...

local reactionColors = Dark.core.colors.reaction

local controller = {
	
	hook = function(model, view)

		local model, view = model, view

		local setHealthColor = function()

			local r, g, b = model.healthbar:GetStatusBarColor()

			if	r ~= view.health.r or g ~= view.health.g or b ~= view.health.b then

				-- store the default colour
				view.health.r, view.health.g, view.health.b = r, g, b
								
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

				elseif (r + g) > 1.06 and b > .9 then

					-- tapped unit
					r, g, b = unpack(reactionColors[4])

				end
					-- enemy player, use default UI colour
				
				view.health:SetStatusBarColor(r, g, b)

			end
		
		end

		local onShow = function()

			view.name:SetText(model.name:GetText())
			setHealthColor()

		end

		local onHealthChanged = function(self, value)

			local min, max	= model.healthbar:GetMinMaxValues()
			
			view.health:SetMinMaxValues(min, max)
			view.health:SetValue(value)

			setHealthColor()

		end


		local elapsed = 0 

		local onUpdate = function(self, e)

			elapsed = elapsed + e

			if elapsed > 1 then
				elapsed = 0
				onShow()
			end

		end

		model.plate:SetScript("OnShow", onShow)
		model.healthbar:SetScript("OnValueChanged", onHealthChanged)

		model.plate:SetScript("OnUpdate", onUpdate)
	end,

}

ns.controller = controller