local addon, ns = ...

local reactionColors = Dark.core.colors.reaction

local controller = {
	
	hook = function(model, view)

		local model, view = model, view

		model.nameFrame:Hide()
		model.barFrame:Hide()

		local setHealthColor = function()

			local r, g, b = model.healthbar:GetStatusBarColor()

			if	r ~= view.health.r or g ~= view.health.g or b ~= view.health.b then

				-- store the default colour
				view.health.r, view.health.g, view.health.b = r, g, b
								
				if g > .9 and r == 0 and b == 0 then

					-- friendly NPC
					r, g, b = unpack(reactionColors[5])

				elseif b > .9 and r == 0 and g == 0 then
					
					-- friendly player
					r, g, b = 0, .3, .6

				elseif r > .9 and g == 0 and b == 0 then
					
					-- enemy NPC
					r, g, b = unpack(reactionColors[1])

				elseif (r + g) > 1.8 and b == 0 then

					-- neutral NPC
					r, g, b = unpack(reactionColors[4])

				elseif (r + g) > 1.06 and b > .9 then

					-- tapped unit
					r, g, b = .5, .5, .5

				end
					-- enemy player, use default UI colour
				
				view.health:SetStatusBarColor(r, g, b)

			end
		
		end

		local setUnitText = function()
		
			view.name:SetText(model.name:GetText())

			if model.boss:IsVisible() then
				view.level:SetText("Boss")
			elseif model.dragon:IsVisible() then

				if model.dragon:GetTexture() == "Interface\\Tooltips\\EliteNameplateIcon" then
					view.level:SetText(model.level:GetText() .. " Elite")
				else
					view.level:SetText(model.level:GetText() .. " Rare")
				end
			else
				view.level:SetText(model.level:GetText())
			end	

		end

		local setUnitRaidMark = function()

			if model.raid:IsShown() then
				view.raid:Show()
				view.raid:SetTexCoord(model.raid:GetTexCoord())
			else
				view.raid:Hide()
			end

		end

		local onShow = function()
			setUnitText()
			setUnitRaidMark()
		end

		local onHealthChanged = function(self, value)

			local min, max	= model.healthbar:GetMinMaxValues()
			
			view.health:SetMinMaxValues(min, max)
			view.health:SetValue(value)

		end


		local elapsed = 1

		local onUpdate = function(self, e)

			elapsed = elapsed + e

			if elapsed > .1 then
				elapsed = 0

				setUnitText()
				setHealthColor()
				setUnitRaidMark()
			end

		end

		model.plate:SetScript("OnShow", onShow)
		model.healthbar:SetScript("OnValueChanged", onHealthChanged)

		model.plate:SetScript("OnUpdate", onUpdate)
	end,

}

ns.controller = controller