local Packages = script.Parent.Parent

local React = require(Packages.React)
local Flipper = require(Packages.Flipper)

local AssignedBinding = require(script.Parent.AssignedBinding)

local function getBinding(motor)
	assert(motor, "Missing argument #1: motor")
	
	local isMotor = Flipper.isMotor(motor)
	if not isMotor then
		error("Provided value is not a motor!", 2)
	end

	if motor[AssignedBinding] then
		return motor[AssignedBinding]
	end

	local binding, setBindingValue = Roact.useState(motor:getValue())
	motor:onStep(setBindingValue)

	motor[AssignedBinding] = binding
	return binding
end

return getBinding