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

			for i, frame in ipairs(WorldFrame:GetChildren()) do
			
				local id = frame:GetID()

				if not found[id] then

					found[id] = true
					onNewFrame(frame)

				end

			end

		end

		eventStore.register("", nil, onUpdate)

	end,	

}

ns.finder = plateFinder
