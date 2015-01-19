local addon, ns = ...

local class = ns.lib.class
local updates = ns.lib.mixins.updates

local finder = class:extend({

	ctor = function(self, onNewFrame)
		self:include(updates)

		self.onNewFrame = onNewFrame
		self.found = {}
	end,

	isPlate = function(self, frame)

		local name = frame:GetName()

		if name then
			return name:find("NamePlate%d")
		end

		return false

	end,

	onUpdate = function(self, elapsed)

		local count = select("#", WorldFrame:GetChildren())

		for i = 1, count do

			local frame = select(i, WorldFrame:GetChildren())

			if self:isPlate(frame) and not self.found[frame] then

				self.found[frame] = true
				self.onNewFrame(frame)

			end

		end

	end,

})

ns.finder = finder
