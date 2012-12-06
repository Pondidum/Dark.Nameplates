local addon, ns = ...
local eventStore = Dark.core.events

local plateFinder = {

	new = function(onNewFrame)

		local onNewFrame = onNewFrame or function() end
		local found = {}

		local isPlate = function(frame)
			return frame:GetName():find("NamePlate%d")
		end

		local onUpdate = function()

			for i, frame in ipairs({WorldFrame:GetChildren()}) do
			
				if isPlate(frame) and not found[frame] then

					found[frame] = true

					if isPlate(frame) then
						onNewFrame(frame)
					end

				end

			end

		end

		eventStore.registerOnUpdate("DarkNameplates", onUpdate)

	end,	

}

ns.finder = plateFinder
