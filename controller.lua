local addon, ns = ...

local colors = Dark.core.colors
local reactionColors = colors.reaction

local controller = {
	
	hook = function(model, view)

		local model, view = model, view

		local hideModelFrames = function()
			model.nameFrame:Hide()
			model.barFrame:Hide()
		end

		local setHealthColor = function()

			local r, g, b = model.healthBar:GetStatusBarColor()

			if	r ~= view.health.r or g ~= view.health.g or b ~= view.health.b then

				-- store the default colour
				view.health.r, view.health.g, view.health.b = r, g, b
								
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
				
				view.health:SetStatusBarColor(r, g, b)

			end
		
		end

		local setUnitThreat = function()

			if model.threat:IsShown() then

				local r, g, b = model.threat:GetVertexColor()

				if g + b == 0 then 			-- aggro
					
					view.threat:SetBackdropBorderColor(0.95, 0.2, 0.2)

				elseif b == 0 then			-- high threat
					
					view.threat:SetBackdropBorderColor(0.95, 0.95, 0.2)

				else 						-- low/none

					view.threat:SetBackdropBorderColor(unpack(colors.shadow))

				end

			else 							-- low/none

				view.threat:SetBackdropBorderColor(unpack(colors.shadow))

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
			hideModelFrames()
			setUnitText()
			setUnitRaidMark()
		end

		local onHealthChanged = function(self, value)

			local min, max	= model.healthBar:GetMinMaxValues()
			
			view.health:SetMinMaxValues(min, max)
			view.health:SetValue(value)

		end

		local onCastChange = function(self, value)

			view.cast:SetMinMaxValues(model.castBar:GetMinMaxValues())
			view.cast:SetValue(value)

			if model.castBarShield:IsShown() == 1 then
				view.cast:SetStatusBarColor(0.83, 0.14, 0.14)
			else
				view.cast:SetStatusBarColor(0.86, 0.71, 0.18)
			end

		end

		local elapsed = 1

		local onUpdate = function(self, e)

			elapsed = elapsed + e

			if elapsed > .1 then
				elapsed = 0

				hideModelFrames()
				setUnitText()
				setHealthColor()
				setUnitRaidMark()
				setUnitThreat()

				if model.castBar:IsShown() then
					view.cast:Show()
				else
					view.cast:Hide()
				end

			end

		end


		model.plate:SetScript("OnShow", onShow)
		model.healthBar:SetScript("OnValueChanged", onHealthChanged)

		model.plate:SetScript("OnUpdate", onUpdate)

		model.nameFrame:SetScript("OnShow", hideModelFrames)
		model.barFrame:SetScript("OnShow", hideModelFrames)

		model.castBar:SetScript("OnValueChanged", onCastChange)

	end,

}

ns.controller = controller