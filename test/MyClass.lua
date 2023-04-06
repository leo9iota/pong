MyClass = {}

function MyClass.new()
	local obj = {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function MyClass:myMethod()
	print("Hello from myMethod!")
end