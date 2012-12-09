local addon, ns = ...

ns.config = {
	height = 12,
	castheight = 8,
}
local initialise = function()

	local createNameplate = function(plate)

		local model = ns.model.new(plate)
		local view = ns.view.new(plate)

		ns.controller.hook(model, view)

	end	

	local finder = ns.finder.new(createNameplate)

end

initialise()

Dark.Nameplates = ns