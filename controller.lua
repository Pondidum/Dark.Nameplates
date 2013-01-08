local addon, ns = ...

local colors = Dark.core.colors
local colorPicker = ns.colorPicker

local controller = {
	
	hook = function(model, view)

		local model, view = model, view

		local setHealthColor = function()

			local r, g, b = model.healthBar:GetStatusBarColor()

			if	r ~= view.health.r or g ~= view.health.g or b ~= view.health.b then

				view.health.r, view.health.g, view.health.b = r, g, b

				view.health:SetStatusBarColor(colorPicker.fromUnitHealth(r, g, b))

			end
		
		end

		local setUnitThreat = function()

			local r, g, b

			if model.threat:IsShown() then
				r, g, b = colorPicker.fromUnitThreat(model.threat:GetVertexColor())
			else
				r, g, b = unpack(colors.shadow)
			end

			view.threat:SetBackdropBorderColor(r, g, b)
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

		local hideModelFrames = function()
			model.nameFrame:Hide()
			model.barFrame:Hide()
			model.level:Hide()
		end
		
		local hideTextures = function()
			model.border:SetTexture("")
		end

		local onShow = function()
			hideModelFrames()
			hideTextures()
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

			view.castIcon:SetTexture(model.castBarIcon:GetTexture())

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