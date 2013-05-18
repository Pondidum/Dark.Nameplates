local addon, ns = ...
local eventStore = Dark.core.events.new()

local plateFinder = {

	new = function(onNewFrame)

		local onNewFrame = onNewFrame or function() end
		local found = {}

		local isPlate = function(frame)

			local name = frame:GetName() or ''

			return name:find("NamePlate%d")

		end

		local onUpdate = function()

			local count = select("#", WorldFrame:GetChildren())

			for i = 1, count do
				
				local frame = select(i, WorldFrame:GetChildren())

				if isPlate(frame) and not found[frame] then

					found[frame] = true

					if isPlate(frame) then
						onNewFrame(frame)
					end

				end

			end

		end

		eventStore.registerOnUpdate(onUpdate)

	end,	

}

ns.finder = plateFinder
