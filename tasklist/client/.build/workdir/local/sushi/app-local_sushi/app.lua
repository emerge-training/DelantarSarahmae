jk = jk or {}

jk.lang = jk.lang or {}

jk.lang.Iterateable = {}

jk.lang.DoubleObject = {}

jk.lang.CharacterObject = {}

jk.lang.BufferDataReceiver = {}

jk.lang.Reflection = {}
jk.lang.Reflection.__index = jk.lang.Reflection
_vm:set_metatable(jk.lang.Reflection, {})

function jk.lang.Reflection._create()
	local v = _vm:set_metatable({}, jk.lang.Reflection)
	return v
end

function jk.lang.Reflection:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Reflection'
	self['_isType.jk.lang.Reflection'] = true
end

function jk.lang.Reflection:_construct0()
	jk.lang.Reflection._init(self)
	return self
end

function jk.lang.Reflection:createClassInstanceByName(qualifiedName)
	if not _g.jk.lang.String:isNotEmpty(qualifiedName) then
		do return nil end
	end
	do
		local code = " return _g." .. _g.jk.lang.String:safeString(qualifiedName) .. "._construct0(_g." .. _g.jk.lang.String:safeString(qualifiedName) .. "._create())"
		local ff = _vm:parse_to_function(code)
		if not (ff ~= nil) then
			do return nil end
		end
		do return ff() end
	end
end

function jk.lang.Reflection:createClassInstanceByTypeinfo(type)
	local typename = type
	if not _g.jk.lang.String:startsWith(typename, "class:", 0) then
		do return nil end
	end
	typename = _g.jk.lang.String:getEndOfString(typename, 6)
	do return _g.jk.lang.Reflection:createClassInstanceByName(typename) end
end

function jk.lang.Reflection:callMethod(objectInstance, methodName, arguments)
	local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	do sb:appendString("return function(object, arguments) return object:") end
	do sb:appendString(methodName) end
	do sb:appendString("(") end
	do
		local sz = #arguments
		do
			local n = 0
			while n < sz do
				if n > 0 then
					do sb:appendString(",") end
				end
				do sb:appendString("arguments[") end
				do sb:appendInteger(n + 1) end
				do sb:appendString("]") end
				do n = n + 1 end
			end
		end
		do sb:appendString(") end") end
		do
			local code = sb:toString()
			local ff = _vm:parse_to_function(code)
			if not (ff ~= nil) then
				do return nil end
			end
			do
				local ffx = ff()
				if not (ffx ~= nil) then
					do return nil end
				end
				do return ffx(objectInstance, arguments) end
			end
		end
	end
end

function jk.lang.Reflection:getDataTypeInfo(variable)
	do return _vm:get_datatype_info(variable) end
end

function jk.lang.Reflection:isSameType(primary, other)
	if primary == nil and other == nil then
		do return true end
	end
	if primary == nil or other == nil then
		do return false end
	end
	do
		local ta = _vm:get_datatype_info(primary)
		local tb = _vm:get_datatype_info(other)
		if ta == tb then
			do return true end
		end
		do return false end
	end
end

function jk.lang.Reflection:isInstanceOf(objectInstance, type)
	if not (objectInstance ~= nil) then
		do return false end
	end
	do return _vm:is_instance_of(objectInstance, type) end
end

jk.lang.TimeValue = {}
jk.lang.TimeValue.__index = jk.lang.TimeValue
_vm:set_metatable(jk.lang.TimeValue, {})

function jk.lang.TimeValue._create()
	local v = _vm:set_metatable({}, jk.lang.TimeValue)
	return v
end

function jk.lang.TimeValue:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.TimeValue'
	self['_isType.jk.lang.TimeValue'] = true
	self.seconds = 0
	self.microSeconds = 0
end

function jk.lang.TimeValue:_construct0()
	jk.lang.TimeValue._init(self)
	return self
end

function jk.lang.TimeValue:forSeconds(seconds)
	local v = _g.jk.lang.TimeValue._construct0(_g.jk.lang.TimeValue._create())
	v.seconds = seconds
	do return v end
end

function jk.lang.TimeValue:toString()
	local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	do sb:appendString(_g.jk.lang.String:forLongInteger(self.seconds)) end
	do sb:appendCharacter(46) end
	do sb:appendString(_g.jk.lang.String:forLongInteger(self.microSeconds)) end
	do return sb:toString() end
end

function jk.lang.TimeValue:dup()
	local v = _g.jk.lang.TimeValue._construct0(_g.jk.lang.TimeValue._create())
	do v:copyFrom(self) end
	do return v end
end

function jk.lang.TimeValue:reset()
	self.seconds = 0
	self.microSeconds = 0
end

function jk.lang.TimeValue:copyFrom(tv)
	self.seconds = tv.seconds
	self.microSeconds = tv.microSeconds
end

function jk.lang.TimeValue:set(tv)
	self.seconds = tv:getSeconds()
	self.microSeconds = tv:getMicroSeconds()
end

function jk.lang.TimeValue:setSeconds(value)
	self.seconds = value
end

function jk.lang.TimeValue:setMilliSeconds(value)
	self.microSeconds = value * 1000
end

function jk.lang.TimeValue:setMicroSeconds(value)
	self.microSeconds = value
end

function jk.lang.TimeValue:add(s, us)
	local ts = self:getSeconds() + s
	local tus = self:getMicroSeconds() + us
	if tus > 1000000 then
		ts = ts + _util:convert_to_integer(tus / 1000000)
		tus = _util:convert_to_integer(tus % 1000000)
	end
	while tus < 0 do
		do ts = ts - 1 end
		tus = tus + 1000000
	end
	do
		local v = _g.jk.lang.TimeValue._construct0(_g.jk.lang.TimeValue._create())
		v.seconds = ts
		v.microSeconds = tus
		do return v end
	end
end

function jk.lang.TimeValue:addTimeValue(tv)
	if tv == nil then
		do return self end
	end
	do return self:add(tv:getSeconds(), tv:getMicroSeconds()) end
end

function jk.lang.TimeValue:subtract(tv)
	if tv == nil then
		do return self end
	end
	do return self:add(-tv:getSeconds(), -tv:getMicroSeconds()) end
end

function jk.lang.TimeValue:asMicroSeconds()
	do return self:getSeconds() * 1000000 + self:getMicroSeconds() end
end

function jk.lang.TimeValue:diff(a, b)
	if a == nil and b == nil then
		do return 0 end
	end
	if a == nil then
		do return b:asMicroSeconds() end
	end
	if b == nil then
		do return a:asMicroSeconds() end
	end
	do
		local r = (a.seconds - b.seconds) * 1000000 + (a.microSeconds - b.microSeconds)
		do return r end
	end
end

function jk.lang.TimeValue:diffDouble(a, b)
	do return _g.jk.lang.TimeValue:diff(a, b) / 1000000.0 end
end

function jk.lang.TimeValue:getSeconds()
	do return self.seconds end
end

function jk.lang.TimeValue:getMicroSeconds()
	do return self.microSeconds end
end

jk.lang.KeyValuePair = {}
jk.lang.KeyValuePair.__index = jk.lang.KeyValuePair
_vm:set_metatable(jk.lang.KeyValuePair, {})

function jk.lang.KeyValuePair._create()
	local v = _vm:set_metatable({}, jk.lang.KeyValuePair)
	return v
end

function jk.lang.KeyValuePair:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.KeyValuePair'
	self['_isType.jk.lang.KeyValuePair'] = true
	self.key = nil
	self.value = nil
end

function jk.lang.KeyValuePair:_construct0()
	jk.lang.KeyValuePair._init(self)
	return self
end

function jk.lang.KeyValuePair:_construct2(key, value)
	jk.lang.KeyValuePair._init(self)
	self.key = key
	self.value = value
	return self
end

jk.lang.ObjectWithSize = {}

jk.lang.Exception = {}
jk.lang.Exception.__index = jk.lang.Exception
_vm:set_metatable(jk.lang.Exception, {})

function jk.lang.Exception._create()
	local v = _vm:set_metatable({}, jk.lang.Exception)
	return v
end

function jk.lang.Exception:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Exception'
	self['_isType.jk.lang.Exception'] = true
end

function jk.lang.Exception:_construct0()
	jk.lang.Exception._init(self)
	return self
end

jk.lang.BitOp = {}
jk.lang.BitOp.__index = jk.lang.BitOp
_vm:set_metatable(jk.lang.BitOp, {})

function jk.lang.BitOp._create()
	local v = _vm:set_metatable({}, jk.lang.BitOp)
	return v
end

function jk.lang.BitOp:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.BitOp'
	self['_isType.jk.lang.BitOp'] = true
end

function jk.lang.BitOp:_construct0()
	jk.lang.BitOp._init(self)
	return self
end

function jk.lang.BitOp:_or(v1, v2)
	do return _vm:bitwise_or(v1, v2) end
end

function jk.lang.BitOp:_and(v1, v2)
	do return _vm:bitwise_and(v1, v2) end
end

function jk.lang.BitOp:xor(v1, v2)
	do return _vm:bitwise_xor(v1, v2) end
end

function jk.lang.BitOp:_not(v)
	do return _vm:bitwise_not(v) end
end

jk.lang.Character = {}
jk.lang.Character.__index = jk.lang.Character
_vm:set_metatable(jk.lang.Character, {})

function jk.lang.Character._create()
	local v = _vm:set_metatable({}, jk.lang.Character)
	return v
end

function jk.lang.Character:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Character'
	self['_isType.jk.lang.Character'] = true
	self['_isType.jk.lang.CharacterObject'] = true
	self.character = 0
end

function jk.lang.Character:_construct0()
	jk.lang.Character._init(self)
	return self
end

function jk.lang.Character:asObject(character)
	local v = _g.jk.lang.Character._construct0(_g.jk.lang.Character._create())
	do v:setCharacter(character) end
	do return v end
end

function jk.lang.Character:toUppercase(c)
	if c >= 97 and c <= 122 then
		do return c - 97 + 65 end
	end
	do return c end
end

function jk.lang.Character:toLowercase(c)
	if c >= 65 and c <= 90 then
		do return c - 65 + 97 end
	end
	do return c end
end

function jk.lang.Character:isDigit(c)
	do return c >= 48 and c <= 57 end
end

function jk.lang.Character:isLowercaseAlpha(c)
	do return c >= 97 and c <= 122 end
end

function jk.lang.Character:isUppercaseAlpha(c)
	do return c >= 65 and c <= 90 end
end

function jk.lang.Character:isHexDigit(c)
	local v = c >= 97 and c <= 102 or (c >= 65 and c <= 70) or (c >= 48 and c <= 57)
	do return v end
end

function jk.lang.Character:isAlnum(c)
	local v = c >= 97 and c <= 122 or (c >= 65 and c <= 90) or (c >= 48 and c <= 57)
	do return v end
end

function jk.lang.Character:isAlpha(c)
	local v = c >= 97 and c <= 122 or (c >= 65 and c <= 90)
	do return v end
end

function jk.lang.Character:isAlphaNumeric(c)
	local v = c >= 97 and c <= 122 or (c >= 65 and c <= 90) or (c >= 48 and c <= 57)
	do return v end
end

function jk.lang.Character:isLowercaseAlphaNumeric(c)
	local v = c >= 97 and c <= 122 or (c >= 48 and c <= 57)
	do return v end
end

function jk.lang.Character:isUppercaseAlphaNumeric(c)
	local v = c >= 65 and c <= 90 or (c >= 48 and c <= 57)
	do return v end
end

function jk.lang.Character:toCharacter()
	do return self.character end
end

function jk.lang.Character:isEOF(c)
	do return c == 0 or c == -1 end
end

function jk.lang.Character:getHexDigit(c)
	local v = 0
	if c >= 48 and c <= 57 then
		v = _util:convert_to_integer(c - 48)
	elseif c >= 97 and c <= 102 then
		v = 10 + c - 97
	elseif c >= 65 and c <= 70 then
		v = 10 + c - 65
	else
		do return 0 end
	end
	do return v end
end

function jk.lang.Character:getCharacter()
	do return self.character end
end

function jk.lang.Character:setCharacter(v)
	self.character = v
	do return self end
end

jk.lang.BufferObject = {}

jk.lang.StringObject = {}

jk.lang.StringIterator = {}

jk.lang.Stack = {}
jk.lang.Stack.__index = jk.lang.Stack
_vm:set_metatable(jk.lang.Stack, {})

function jk.lang.Stack._create()
	local v = _vm:set_metatable({}, jk.lang.Stack)
	return v
end

function jk.lang.Stack:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Stack'
	self['_isType.jk.lang.Stack'] = true
	self.data = nil
end

function jk.lang.Stack:_construct0()
	jk.lang.Stack._init(self)
	self.data = {}
	return self
end

function jk.lang.Stack:push(o)
	do _g.jk.lang.Vector:append(self.data, o) end
end

function jk.lang.Stack:pop()
	local sz = _g.jk.lang.Vector:getSize(self.data)
	if sz < 1 then
		do return nil end
	end
	do
		local v = _g.jk.lang.Vector:getAt(self.data, sz - 1)
		do _g.jk.lang.Vector:remove(self.data, sz - 1) end
		do return v end
	end
end

function jk.lang.Stack:peek()
	local sz = _g.jk.lang.Vector:getSize(self.data)
	if sz < 1 then
		do return nil end
	end
	do return _g.jk.lang.Vector:getAt(self.data, sz - 1) end
end

function jk.lang.Stack:isEmpty()
	do return self:getSize() < 1 end
end

function jk.lang.Stack:getSize()
	do return _g.jk.lang.Vector:getSize(self.data) end
end

function jk.lang.Stack:dupData()
	local v = {}
	if self.data ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(self.data)
		do
			n = 0
			while n < m do
				local o = self.data[n + 1]
				if o ~= nil then
					do _g.jk.lang.Vector:append(v, o) end
				end
				do n = n + 1 end
			end
		end
	end
	do return v end
end

function jk.lang.Stack:dup()
	local v = _g.jk.lang.Stack._construct0(_g.jk.lang.Stack._create())
	do v:setData(self:dupData()) end
	do return v end
end

function jk.lang.Stack:getData()
	do return self.data end
end

function jk.lang.Stack:setData(v)
	self.data = v
	do return self end
end

jk.lang.Iterator = {}

jk.lang.Runnable = {}

jk.lang.CharacterIterator = {}

jk.lang.MapObject = {}

jk.lang.IntegerObject = {}

jk.lang.EventLoop = {}

jk.lang.Queue = {}
jk.lang.Queue.__index = jk.lang.Queue
_vm:set_metatable(jk.lang.Queue, {})

function jk.lang.Queue._create()
	local v = _vm:set_metatable({}, jk.lang.Queue)
	return v
end

function jk.lang.Queue:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Queue'
	self['_isType.jk.lang.Queue'] = true
	self.data = nil
end

function jk.lang.Queue:_construct0()
	jk.lang.Queue._init(self)
	self.data = {}
	return self
end

function jk.lang.Queue:clear()
	self.data = {}
end

function jk.lang.Queue:push(o)
	do _g.jk.lang.Vector:append(self.data, o) end
end

function jk.lang.Queue:pop()
	local sz = _g.jk.lang.Vector:getSize(self.data)
	if sz < 1 then
		do return nil end
	end
	do
		local v = _g.jk.lang.Vector:getAt(self.data, 0)
		do _g.jk.lang.Vector:remove(self.data, 0) end
		do return v end
	end
end

function jk.lang.Queue:peek()
	local sz = _g.jk.lang.Vector:getSize(self.data)
	if sz < 1 then
		do return nil end
	end
	do return _g.jk.lang.Vector:getAt(self.data, 0) end
end

function jk.lang.Queue:isEmpty()
	do return self:getSize() < 1 end
end

function jk.lang.Queue:getSize()
	do return _g.jk.lang.Vector:getSize(self.data) end
end

function jk.lang.Queue:getData()
	do return self.data end
end

function jk.lang.Queue:setData(v)
	self.data = v
	do return self end
end

jk.lang.VariableReference = {}
jk.lang.VariableReference.__index = jk.lang.VariableReference
_vm:set_metatable(jk.lang.VariableReference, {})

function jk.lang.VariableReference._create()
	local v = _vm:set_metatable({}, jk.lang.VariableReference)
	return v
end

function jk.lang.VariableReference:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.VariableReference'
	self['_isType.jk.lang.VariableReference'] = true
	self.setter = nil
	self.getter = nil
end

function jk.lang.VariableReference:_construct0()
	jk.lang.VariableReference._init(self)
	return self
end

function jk.lang.VariableReference:_construct2(setter, getter)
	jk.lang.VariableReference._init(self)
	self.setter = setter
	self.getter = getter
	return self
end

function jk.lang.VariableReference:set(value)
	do self.setter(value) end
	do return self end
end

function jk.lang.VariableReference:get()
	do return self.getter() end
end

jk.lang.StackTrace = {}
jk.lang.StackTrace.__index = jk.lang.StackTrace
_vm:set_metatable(jk.lang.StackTrace, {})

function jk.lang.StackTrace._create()
	local v = _vm:set_metatable({}, jk.lang.StackTrace)
	return v
end

function jk.lang.StackTrace:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.StackTrace'
	self['_isType.jk.lang.StackTrace'] = true
end

function jk.lang.StackTrace:_construct0()
	jk.lang.StackTrace._init(self)
	return self
end

function jk.lang.StackTrace:generate()
	do return _vm:get_stack_trace() end
end

jk.lang.Range = {}
jk.lang.Range.__index = jk.lang.Range
_vm:set_metatable(jk.lang.Range, {})

jk.lang.Range.TYPE_NONE = 0
jk.lang.Range.TYPE_EXCLUDE_UPPER_BOUND = 1
jk.lang.Range.TYPE_EXCLUDE_LOWER_BOUND = 2
jk.lang.Range.TYPE_EXCLUDE_BOTH_BOUNDS = 3

function jk.lang.Range._create()
	local v = _vm:set_metatable({}, jk.lang.Range)
	return v
end

function jk.lang.Range:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Range'
	self['_isType.jk.lang.Range'] = true
	self['_isType.jk.lang.Iterateable'] = true
	self.lowerBound = 0.0
	self.upperBound = 0.0
	self.exclusionType = 0
end

function jk.lang.Range:forIntegerValues(lowerBound, upperBound, exclusionType)
	local v = _g.jk.lang.Range._construct0(_g.jk.lang.Range._create())
	do v:setLowerBound(lowerBound) end
	do v:setUpperBound(upperBound) end
	do v:setExclusionType(exclusionType) end
	do return v end
end

function jk.lang.Range:forDoubleValues(lowerBound, upperBound, exclusionType)
	local v = _g.jk.lang.Range._construct0(_g.jk.lang.Range._create())
	do v:setLowerBound(lowerBound) end
	do v:setUpperBound(upperBound) end
	do v:setExclusionType(exclusionType) end
	do return v end
end

function jk.lang.Range:forValues(lowerBound, upperBound, exclusionType)
	if (_vm:get_variable_type(lowerBound) == 'number') and (_vm:get_variable_type(upperBound) == 'number') then
		do return _g.jk.lang.Range:forDoubleValues(lowerBound, upperBound, exclusionType) end
	end
	if (_vm:get_variable_type(lowerBound) == 'number') and (_vm:get_variable_type(upperBound) == 'number') then
		do return _g.jk.lang.Range:forIntegerValues(_util:convert_to_integer(lowerBound), _util:convert_to_integer(upperBound), exclusionType) end
	end
	do return nil end
end

function jk.lang.Range:_construct0()
	jk.lang.Range._init(self)
	return self
end

function jk.lang.Range:setLowerBound(lowerBound)
	self.lowerBound = lowerBound
end

function jk.lang.Range:setUpperBound(upperBound)
	self.upperBound = upperBound
end

function jk.lang.Range:setExclusionType(exclusionType)
	self.exclusionType = exclusionType
end

function jk.lang.Range:getLowerBoundAsInteger()
	do return _util:convert_to_integer(self.lowerBound) end
end

function jk.lang.Range:getLowerBoundAsDouble()
	do return self.lowerBound end
end

function jk.lang.Range:getUpperBoundAsInteger()
	do return _util:convert_to_integer(self.upperBound) end
end

function jk.lang.Range:getUpperBoundAsDouble()
	do return self.upperBound end
end

function jk.lang.Range:containsIntegerValue(value)
	do return self:containsDoubleValue(value) end
end

function jk.lang.Range:containsDoubleValue(value)
	if self.exclusionType == _g.jk.lang.Range.TYPE_NONE then
		do return value >= self.lowerBound and value <= self.upperBound end
	elseif self.exclusionType == _g.jk.lang.Range.TYPE_EXCLUDE_UPPER_BOUND then
		do return value >= self.lowerBound and value < self.upperBound end
	elseif self.exclusionType == _g.jk.lang.Range.TYPE_EXCLUDE_LOWER_BOUND then
		do return value > self.lowerBound and value <= self.upperBound end
	elseif self.exclusionType == _g.jk.lang.Range.TYPE_EXCLUDE_BOTH_BOUNDS then
		do return value > self.lowerBound and value < self.upperBound end
	end
	do return false end
end

jk.lang.Range.RangeIterator = {}
jk.lang.Range.RangeIterator.__index = jk.lang.Range.RangeIterator
_vm:set_metatable(jk.lang.Range.RangeIterator, {})

function jk.lang.Range.RangeIterator._create()
	local v = _vm:set_metatable({}, jk.lang.Range.RangeIterator)
	return v
end

function jk.lang.Range.RangeIterator:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Range.RangeIterator'
	self['_isType.jk.lang.Range.RangeIterator'] = true
	self['_isType.jk.lang.Iterator'] = true
	self.lowerBound = 0
	self.upperBound = 0
	self.increment = 0
	self.current = nil
end

function jk.lang.Range.RangeIterator:_construct0()
	jk.lang.Range.RangeIterator._init(self)
	return self
end

function jk.lang.Range.RangeIterator:_construct2(lowerBound, upperBound)
	jk.lang.Range.RangeIterator._init(self)
	self.lowerBound = lowerBound
	self.upperBound = upperBound
	if lowerBound <= upperBound then
		self.increment = 1
	else
		self.increment = -1
	end
	return self
end

function jk.lang.Range.RangeIterator:next()
	if not (self.current ~= nil) then
		self.current = _g.jk.lang.Integer:forValue(self.lowerBound)
	else
		do self.current:add(self.increment) end
	end
	do return self.current:getValue() end
end

function jk.lang.Range.RangeIterator:hasNext()
	if not (self.current ~= nil) then
		do return true end
	end
	if self.increment > 0 then
		do return self.current:getValue() < self.upperBound end
	end
	do return self.current:getValue() > self.upperBound end
end

function jk.lang.Range:iterate()
	local lv = _util:convert_to_integer(self.lowerBound)
	local uv = _util:convert_to_integer(self.upperBound)
	if self.exclusionType == _g.jk.lang.Range.TYPE_NONE then
	end
	if self.exclusionType == _g.jk.lang.Range.TYPE_EXCLUDE_UPPER_BOUND then
		uv = uv - 1
	elseif self.exclusionType == _g.jk.lang.Range.TYPE_EXCLUDE_LOWER_BOUND then
		lv = lv + 1
	elseif self.exclusionType == _g.jk.lang.Range.TYPE_EXCLUDE_BOTH_BOUNDS then
		uv = uv - 1
		lv = lv + 1
	end
	do return _g.jk.lang.Range.RangeIterator._construct2(_g.jk.lang.Range.RangeIterator._create(), lv, uv) end
end

jk.lang.StringObjectWithDebug = {}

jk.lang.Duplicateable = {}

jk.lang.DateTime = {}
jk.lang.DateTime.__index = jk.lang.DateTime
_vm:set_metatable(jk.lang.DateTime, {})

function jk.lang.DateTime._create()
	local v = _vm:set_metatable({}, jk.lang.DateTime)
	return v
end

function jk.lang.DateTime:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.DateTime'
	self['_isType.jk.lang.DateTime'] = true
	self['_isType.jk.lang.StringObject'] = true
	self.timezoneOffset = 0
	self.weekDay = 0
	self.dayOfMonth = 0
	self.month = 0
	self.year = 0
	self.hours = 0
	self.minutes = 0
	self.seconds = 0
end

function jk.lang.DateTime:_construct0()
	jk.lang.DateTime._init(self)
	return self
end

function jk.lang.DateTime:forSeconds(seconds)
	local v = _g.jk.lang.DateTime._construct0(_g.jk.lang.DateTime._create())
	do v:updateFromTimestamp(seconds) end
	do return v end
end

function jk.lang.DateTime:forTimeValue(tv)
	if not (tv ~= nil) then
		do return nil end
	end
	do
		local v = _g.jk.lang.DateTime._construct0(_g.jk.lang.DateTime._create())
		do v:updateFromTimestamp(tv:getSeconds()) end
		do return v end
	end
end

function jk.lang.DateTime:forString(value)
	if not (value ~= nil) then
		do return nil end
	end
	do
		local comps = _g.jk.lang.String:split(value, 32, 2)
		if not (comps ~= nil) then
			do return nil end
		end
		do
			local c0 = _g.jk.lang.Vector:get(comps, 0)
			local c1 = _g.jk.lang.Vector:get(comps, 1)
			if not _g.jk.lang.String:isNotEmpty(c0) then
				do return nil end
			end
			do
				local comps2 = _g.jk.lang.String:split(c0, 45, 3)
				if not (comps2 ~= nil) then
					do return nil end
				end
				if not (_g.jk.lang.Vector:getSize(comps2) == 3) then
					do return nil end
				end
				do
					local v = _g.jk.lang.DateTime._construct0(_g.jk.lang.DateTime._create())
					do v:setYear(_g.jk.lang.String:toInteger(_g.jk.lang.Vector:get(comps2, 0))) end
					do v:setMonth(_g.jk.lang.String:toInteger(_g.jk.lang.Vector:get(comps2, 1))) end
					do v:setDayOfMonth(_g.jk.lang.String:toInteger(_g.jk.lang.Vector:get(comps2, 2))) end
					if _g.jk.lang.String:isNotEmpty(c1) then
						local tcs = _g.jk.lang.String:split(c1, 58, 3)
						if _g.jk.lang.Vector:getSize(tcs) == 3 then
							do v:setHours(_g.jk.lang.String:toInteger(_g.jk.lang.Vector:get(tcs, 0))) end
							do v:setMinutes(_g.jk.lang.String:toInteger(_g.jk.lang.Vector:get(tcs, 1))) end
							do v:setSeconds(_g.jk.lang.String:toInteger(_g.jk.lang.Vector:get(tcs, 2))) end
						end
					end
					do return v end
				end
			end
		end
	end
end

function jk.lang.DateTime:updateFromTimestamp(seconds)
	local o = self
	do o.weekDay, o.dayOfMonth, o.month, o.year, o.hours, o.minutes, o.seconds = _os:get_timestamp_details_utc(seconds) end
end

function jk.lang.DateTime:toStringDate(delim)
	local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	do sb:appendString(_g.jk.lang.String:forIntegerWithPadding(self:getYear(), 4, nil)) end
	if delim > 0 then
		do sb:appendCharacter(delim) end
	end
	do sb:appendString(_g.jk.lang.String:forIntegerWithPadding(self:getMonth(), 2, nil)) end
	if delim > 0 then
		do sb:appendCharacter(delim) end
	end
	do sb:appendString(_g.jk.lang.String:forIntegerWithPadding(self:getDayOfMonth(), 2, nil)) end
	do return sb:toString() end
end

function jk.lang.DateTime:toStringTime(delim)
	local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	do sb:appendString(_g.jk.lang.String:forIntegerWithPadding(self:getHours(), 2, nil)) end
	if delim > 0 then
		do sb:appendCharacter(delim) end
	end
	do sb:appendString(_g.jk.lang.String:forIntegerWithPadding(self:getMinutes(), 2, nil)) end
	if delim > 0 then
		do sb:appendCharacter(delim) end
	end
	do sb:appendString(_g.jk.lang.String:forIntegerWithPadding(self:getSeconds(), 2, nil)) end
	do return sb:toString() end
end

function jk.lang.DateTime:toStringDateTime()
	local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	do sb:appendString(self:toStringDate(45)) end
	do sb:appendString(" ") end
	do sb:appendString(self:toStringTime(58)) end
	do return sb:toString() end
end

function jk.lang.DateTime:toString()
	do return self:toStringDateTime() end
end

function jk.lang.DateTime:getTimezoneOffset()
	do return self.timezoneOffset end
end

function jk.lang.DateTime:setTimezoneOffset(v)
	self.timezoneOffset = v
	do return self end
end

function jk.lang.DateTime:getWeekDay()
	do return self.weekDay end
end

function jk.lang.DateTime:setWeekDay(v)
	self.weekDay = v
	do return self end
end

function jk.lang.DateTime:getDayOfMonth()
	do return self.dayOfMonth end
end

function jk.lang.DateTime:setDayOfMonth(v)
	self.dayOfMonth = v
	do return self end
end

function jk.lang.DateTime:getMonth()
	do return self.month end
end

function jk.lang.DateTime:setMonth(v)
	self.month = v
	do return self end
end

function jk.lang.DateTime:getYear()
	do return self.year end
end

function jk.lang.DateTime:setYear(v)
	self.year = v
	do return self end
end

function jk.lang.DateTime:getHours()
	do return self.hours end
end

function jk.lang.DateTime:setHours(v)
	self.hours = v
	do return self end
end

function jk.lang.DateTime:getMinutes()
	do return self.minutes end
end

function jk.lang.DateTime:setMinutes(v)
	self.minutes = v
	do return self end
end

function jk.lang.DateTime:getSeconds()
	do return self.seconds end
end

function jk.lang.DateTime:setSeconds(v)
	self.seconds = v
	do return self end
end

jk.lang.ObjectWrapper = {}
jk.lang.ObjectWrapper.__index = jk.lang.ObjectWrapper
_vm:set_metatable(jk.lang.ObjectWrapper, {})

function jk.lang.ObjectWrapper._create()
	local v = _vm:set_metatable({}, jk.lang.ObjectWrapper)
	return v
end

function jk.lang.ObjectWrapper:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.ObjectWrapper'
	self['_isType.jk.lang.ObjectWrapper'] = true
	self.value = nil
end

function jk.lang.ObjectWrapper:_construct0()
	jk.lang.ObjectWrapper._init(self)
	return self
end

function jk.lang.ObjectWrapper:getValue()
	do return self.value end
end

function jk.lang.ObjectWrapper:setValue(v)
	self.value = v
	do return self end
end

jk.lang.KeyValueList = {}
jk.lang.KeyValueList.__index = jk.lang.KeyValueList
_vm:set_metatable(jk.lang.KeyValueList, {})

function jk.lang.KeyValueList._create()
	local v = _vm:set_metatable({}, jk.lang.KeyValueList)
	return v
end

function jk.lang.KeyValueList:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.KeyValueList'
	self['_isType.jk.lang.KeyValueList'] = true
	self.values = nil
end

function jk.lang.KeyValueList:_construct0()
	jk.lang.KeyValueList._init(self)
	return self
end

function jk.lang.KeyValueList:add(key, val)
	if self.values == nil then
		self.values = {}
	end
	do
		local kvp = _g.jk.lang.KeyValuePair._construct0(_g.jk.lang.KeyValuePair._create())
		kvp.key = key
		kvp.value = val
		do _g.jk.lang.Vector:append(self.values, kvp) end
	end
end

function jk.lang.KeyValueList:addPair(pair)
	if self.values == nil then
		self.values = {}
	end
	do _g.jk.lang.Vector:append(self.values, pair) end
end

function jk.lang.KeyValueList:prepend(key, val)
	if self.values == nil then
		self.values = {}
	end
	do
		local kvp = _g.jk.lang.KeyValuePair._construct0(_g.jk.lang.KeyValuePair._create())
		kvp.key = key
		kvp.value = val
		do _g.jk.lang.Vector:prepend(self.values, kvp) end
	end
end

function jk.lang.KeyValueList:prependPair(pair)
	if self.values == nil then
		self.values = {}
	end
	do _g.jk.lang.Vector:prepend(self.values, pair) end
end

function jk.lang.KeyValueList:iterate()
	local v = _g.jk.lang.Vector:iterate(self.values)
	do return v end
end

function jk.lang.KeyValueList:asVector()
	do return self.values end
end

function jk.lang.KeyValueList:dup()
	local v = _g.jk.lang.KeyValueList._construct0(_g.jk.lang.KeyValueList._create())
	local it = self:iterate()
	while true do
		local kvp = it:next()
		if kvp == nil then
			do break end
		end
		do v:add(kvp.key, kvp.value) end
	end
	do return v end
end

function jk.lang.KeyValueList:getKey(index)
	if self.values == nil then
		do return nil end
	end
	do
		local kvp = _g.jk.lang.Vector:get(self.values, index)
		if kvp == nil then
			do return nil end
		end
		do return kvp.key end
	end
end

function jk.lang.KeyValueList:getValue(index)
	if self.values == nil then
		do return nil end
	end
	do
		local kvp = _g.jk.lang.Vector:get(self.values, index)
		if kvp == nil then
			do return nil end
		end
		do return kvp.value end
	end
end

function jk.lang.KeyValueList:count()
	if self.values == nil then
		do return 0 end
	end
	do return _g.jk.lang.Vector:getSize(self.values) end
end

function jk.lang.KeyValueList:remove(index)
	do _g.jk.lang.Vector:remove(self.values, index) end
end

function jk.lang.KeyValueList:clear()
	self.values = nil
end

jk.lang.CharacterDecoder = {}
jk.lang.CharacterDecoder.__index = jk.lang.CharacterDecoder
_vm:set_metatable(jk.lang.CharacterDecoder, {})

jk.lang.CharacterDecoder.UTF8 = 0
jk.lang.CharacterDecoder.ASCII = 1
jk.lang.CharacterDecoder.UCS2 = 2

function jk.lang.CharacterDecoder._create()
	local v = _vm:set_metatable({}, jk.lang.CharacterDecoder)
	return v
end

function jk.lang.CharacterDecoder:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.CharacterDecoder'
	self['_isType.jk.lang.CharacterDecoder'] = true
	self['_isType.jk.lang.CharacterIterator'] = true
	self.encoding = 0
	self.current = 0
	self.surrogatePair = nil
	self.counter = 0
	self.currentSize = 0
	self.ended = false
end

function jk.lang.CharacterDecoder:_construct0()
	jk.lang.CharacterDecoder._init(self)
	return self
end

function jk.lang.CharacterDecoder:resetDecoder()
	self.current = 0
	self.surrogatePair = nil
	self.counter = 0
	self.currentSize = 0
	self.ended = false
end

function jk.lang.CharacterDecoder:copyTo(o)
	o.encoding = self.encoding
	o.current = self.current
	o.currentSize = self.currentSize
	o.ended = self.ended
end

function jk.lang.CharacterDecoder:moveToPreviousByte()
	do return false end
end

function jk.lang.CharacterDecoder:moveToNextByte()
	do return false end
end

function jk.lang.CharacterDecoder:getCurrentByte()
	do return 0 end
end

function jk.lang.CharacterDecoder:setEncoding(ee)
	if _g.jk.lang.String:equalsIgnoreCase(ee, "UTF8") or _g.jk.lang.String:equalsIgnoreCase(ee, "UTF-8") then
		self.encoding = _g.jk.lang.CharacterDecoder.UTF8
		self.currentSize = 1
		do return self end
	end
	if _g.jk.lang.String:equalsIgnoreCase(ee, "ASCII") then
		self.encoding = _g.jk.lang.CharacterDecoder.ASCII
		self.currentSize = 1
		do return self end
	end
	if _g.jk.lang.String:equalsIgnoreCase(ee, "UCS2") or _g.jk.lang.String:equalsIgnoreCase(ee, "UCS-2") then
		self.encoding = _g.jk.lang.CharacterDecoder.UCS2
		self.currentSize = 2
		do return self end
	end
	do return nil end
end

function jk.lang.CharacterDecoder:getEncoding()
	do return self.encoding end
end

function jk.lang.CharacterDecoder:moveToPreviousChar()
	local op = self:getCurrentPosition()
	local cs = self.currentSize
	if cs > 1 then
		local n = 0
		do
			n = 0
			while n < cs - 1 do
				if not self:moveToPreviousByte() then
					do return false end
				end
				do n = n + 1 end
			end
		end
	end
	do
		local v = self:doMoveToPreviousChar()
		if not v then
			do self:setCurrentPosition(op) end
		end
		if v and self.ended then
			self.ended = false
		end
		do return v end
	end
end

function jk.lang.CharacterDecoder:convertToChar(v)
	do return v end
end

function jk.lang.CharacterDecoder:getSurrogatePair()
	if not (self.surrogatePair ~= nil) then
		do return 0 end
	end
	do
		local c = self.surrogatePair[self.counter + 1]
		do self.counter = self.counter + 1 end
		if self.counter == 2 then
			self.counter = 0
			self.surrogatePair = nil
		end
		do return c end
	end
end

function jk.lang.CharacterDecoder:doMoveToPreviousChar()
	if self.encoding == _g.jk.lang.CharacterDecoder.UTF8 then
		if not self:moveToPreviousByte() then
			do return false end
		end
		do
			local c2 = self:getCurrentByte()
			if c2 <= 127 then
				self.current = c2
				self.currentSize = 1
				do return true end
			end
			if not self:moveToPreviousByte() then
				do return false end
			end
			do
				local c1 = self:getCurrentByte()
				if _vm:bitwise_and(c1, 192) == 192 then
					if not self:moveToNextByte() then
						do return false end
					end
					do
						local v = _vm:bitwise_left_shift(_vm:bitwise_and(c1, 31), 6)
						v = v + _vm:bitwise_and(c2, 63)
						self.current = self:convertToChar(v)
						self.currentSize = 2
						do return true end
					end
				end
				if not self:moveToPreviousByte() then
					do return false end
				end
				do
					local c0 = self:getCurrentByte()
					if _vm:bitwise_and(c0, 224) == 224 then
						if not self:moveToNextByte() then
							do return false end
						end
						if not self:moveToNextByte() then
							do return false end
						end
						do
							local v = _vm:bitwise_left_shift(_vm:bitwise_and(c0, 15), 12)
							v = v + _vm:bitwise_left_shift(_vm:bitwise_and(c1, 63), 6)
							v = v + _vm:bitwise_and(c2, 63)
							self.current = self:convertToChar(v)
							self.currentSize = 3
							do return true end
						end
					end
					if not self:moveToPreviousByte() then
						do return false end
					end
					do
						local cm1 = self:getCurrentByte()
						if _vm:bitwise_and(cm1, 240) == 240 then
							if not self:moveToNextByte() then
								do return false end
							end
							if not self:moveToNextByte() then
								do return false end
							end
							if not self:moveToNextByte() then
								do return false end
							end
							do
								local v = _vm:bitwise_left_shift(_vm:bitwise_and(cm1, 7), 18)
								v = v + _vm:bitwise_left_shift(_vm:bitwise_and(c0, 63), 12)
								v = v + _vm:bitwise_left_shift(_vm:bitwise_and(c1, 63), 6)
								v = v + _vm:bitwise_and(c2, 63)
								self.current = self:convertToChar(v)
								self.currentSize = 4
								do return true end
							end
						end
						do self:moveToNextByte() end
						do self:moveToNextByte() end
						do self:moveToNextByte() end
						self.current = 63
						self.currentSize = 1
						do return true end
					end
				end
			end
		end
	end
	if self.encoding == _g.jk.lang.CharacterDecoder.ASCII then
		if not self:moveToPreviousByte() then
			do return false end
		end
		self.current = self:getCurrentByte()
		do return true end
	end
	if self.encoding == _g.jk.lang.CharacterDecoder.UCS2 then
		if not self:moveToPreviousByte() then
			do return false end
		end
		do
			local c1 = self:getCurrentByte()
			if not self:moveToPreviousByte() then
				do return false end
			end
			do
				local c0 = self:getCurrentByte()
				if not self:moveToNextByte() then
					do return false end
				end
				self.current = _vm:bitwise_and(_vm:bitwise_left_shift(c0, 8), c1)
				do return true end
			end
		end
	end
	_io:write_to_stdout("Unsupported encoding in CharacterDecoder: " .. _g.jk.lang.String:safeString(_g.jk.lang.String:forInteger(self.encoding)) .. "\n")
	do return false end
end

function jk.lang.CharacterDecoder:moveToNextChar()
	local v = self:doMoveToNextChar()
	if v == false then
		self.current = 0
		self.ended = true
	end
	do return v end
end

function jk.lang.CharacterDecoder:doMoveToNextChar()
	if self.encoding == _g.jk.lang.CharacterDecoder.UTF8 then
		if self.surrogatePair ~= nil then
			self.current = self:getSurrogatePair()
			do return true end
		end
		if not self:moveToNextByte() then
			do return false end
		end
		do
			local b1 = self:getCurrentByte()
			local v = -1
			if b1 <= 127 then
				v = b1
				self.currentSize = 1
			elseif b1 >= 240 then
				v = _vm:bitwise_left_shift(_vm:bitwise_and(b1, 7), 18)
				if not self:moveToNextByte() then
					do return false end
				end
				do
					local b2 = self:getCurrentByte()
					v = v + _vm:bitwise_left_shift(_vm:bitwise_and(b2, 63), 12)
					if not self:moveToNextByte() then
						do return false end
					end
					do
						local b3 = self:getCurrentByte()
						v = v + _vm:bitwise_left_shift(_vm:bitwise_and(b3, 63), 6)
						if not self:moveToNextByte() then
							do return false end
						end
						do
							local b4 = self:getCurrentByte()
							v = v + _vm:bitwise_and(b4, 63)
							self.currentSize = 4
						end
					end
				end
			elseif b1 >= 224 then
				v = _vm:bitwise_left_shift(_vm:bitwise_and(b1, 15), 12)
				if not self:moveToNextByte() then
					do return false end
				end
				do
					local b2 = self:getCurrentByte()
					v = v + _vm:bitwise_left_shift(_vm:bitwise_and(b2, 63), 6)
					if not self:moveToNextByte() then
						do return false end
					end
					do
						local b3 = self:getCurrentByte()
						v = v + _vm:bitwise_and(b3, 63)
						self.currentSize = 3
					end
				end
			elseif b1 >= 192 then
				v = _vm:bitwise_left_shift(_vm:bitwise_and(b1, 31), 6)
				if not self:moveToNextByte() then
					do return false end
				end
				do
					local b2 = self:getCurrentByte()
					v = v + _vm:bitwise_and(b2, 63)
					self.currentSize = 2
				end
			else
				v = _util:convert_to_integer(63)
				self.currentSize = 1
			end
			self.current = self:convertToChar(v)
			do return true end
		end
	end
	if self.encoding == _g.jk.lang.CharacterDecoder.ASCII then
		if not self:moveToNextByte() then
			do return false end
		end
		self.current = self:getCurrentByte()
		do return true end
	end
	if self.encoding == _g.jk.lang.CharacterDecoder.UCS2 then
		if not self:moveToNextByte() then
			do return false end
		end
		do
			local c0 = self:getCurrentByte()
			if not self:moveToNextByte() then
				do return false end
			end
			do
				local c1 = self:getCurrentByte()
				self.current = _vm:bitwise_and(_vm:bitwise_left_shift(c0, 8), c1)
				do return true end
			end
		end
	end
	_io:write_to_stdout("Unsupported encoding in CharacterDecoder: " .. _g.jk.lang.String:safeString(_g.jk.lang.String:forInteger(self.encoding)) .. "\n")
	do return false end
end

function jk.lang.CharacterDecoder:getCurrentChar()
	do return self.current end
end

function jk.lang.CharacterDecoder:getNextChar()
	if self:moveToNextChar() == false then
		do return 0 end
	end
	do return self.current end
end

function jk.lang.CharacterDecoder:hasEnded()
	do return self.ended end
end

function jk.lang.CharacterDecoder:getCurrentPosition()
end

function jk.lang.CharacterDecoder:setCurrentPosition(position)
end

jk.lang.Map = {}
jk.lang.Map.__index = jk.lang.Map
_vm:set_metatable(jk.lang.Map, {})

function jk.lang.Map._create()
	local v = _vm:set_metatable({}, jk.lang.Map)
	return v
end

function jk.lang.Map:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Map'
	self['_isType.jk.lang.Map'] = true
end

function jk.lang.Map:_construct0()
	jk.lang.Map._init(self)
	return self
end

jk.lang.Map.MyMapObject = {}
jk.lang.Map.MyMapObject.__index = jk.lang.Map.MyMapObject
_vm:set_metatable(jk.lang.Map.MyMapObject, {})

function jk.lang.Map.MyMapObject._create()
	local v = _vm:set_metatable({}, jk.lang.Map.MyMapObject)
	return v
end

function jk.lang.Map.MyMapObject:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Map.MyMapObject'
	self['_isType.jk.lang.Map.MyMapObject'] = true
	self['_isType.jk.lang.MapObject'] = true
	self.map = nil
end

function jk.lang.Map.MyMapObject:_construct0()
	jk.lang.Map.MyMapObject._init(self)
	return self
end

function jk.lang.Map.MyMapObject:toMap()
	do return self.map end
end

function jk.lang.Map.MyMapObject:getMap()
	do return self.map end
end

function jk.lang.Map.MyMapObject:setMap(v)
	self.map = v
	do return self end
end

function jk.lang.Map:asObject(map)
	if not (map ~= nil) then
		do return nil end
	end
	do
		local v = _g.jk.lang.Map.MyMapObject._construct0(_g.jk.lang.Map.MyMapObject._create())
		do v:setMap(map) end
		do return v end
	end
end

function jk.lang.Map:asMap(o)
	if not (o ~= nil) then
		do return nil end
	end
	do return nil end
end

function jk.lang.Map:getWithDefault(map, key, ddf)
	if map == nil or key == nil then
		do return ddf end
	end
	if _g.jk.lang.Map:containsKey(map, key) == false then
		do return ddf end
	end
	do return _g.jk.lang.Map:getValue(map, key) end
end

function jk.lang.Map:get(map, key)
	do return _g.jk.lang.Map:getValue(map, key) end
end

function jk.lang.Map:getValue(map, key)
	if map == nil or key == nil then
		do return nil end
	end
	do return map[key] end
end

function jk.lang.Map:set(data, key, val)
	if not (data ~= nil) then
		do return false end
	end
	if not (key ~= nil) then
		do return false end
	end
	data[key] = val
	do return true end
end

function jk.lang.Map:setValue(data, key, val)
	do return _g.jk.lang.Map:set(data, key, val) end
end

function jk.lang.Map:remove(data, key)
	if not (data ~= nil) then
		do return end
	end
	if not (key ~= nil) then
		do return end
	end
	do data[key] = nil end
end

function jk.lang.Map:count(data)
	if data == nil then
		do return 0 end
	end
	do return _g.jk.lang.Vector:getSize(_g.jk.lang.Map:getKeys(data)) end
end

function jk.lang.Map:containsKey(data, key)
	if not (data ~= nil) then
		do return false end
	end
	if not (key ~= nil) then
		do return false end
	end
	do
		local array = _g.jk.lang.Map:getKeys(data)
		if array ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(array)
			do
				n = 0
				while n < m do
					local kk = array[n + 1]
					if kk ~= nil then
						if key == kk then
							do return true end
						end
					end
					do n = n + 1 end
				end
			end
		end
		do return false end
	end
end

function jk.lang.Map:containsValue(data, val)
	if not (data ~= nil) then
		do return false end
	end
	if not (val ~= nil) then
		do return false end
	end
	do
		local array = _g.jk.lang.Map:getValues(data)
		if array ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(array)
			do
				n = 0
				while n < m do
					local vv = array[n + 1]
					if vv ~= nil then
						if val == vv then
							do return true end
						end
					end
					do n = n + 1 end
				end
			end
		end
		do return false end
	end
end

function jk.lang.Map:clear(data)
	if not (data ~= nil) then
		do return end
	end
	do _vm:clear_table(data) end
end

function jk.lang.Map:dup(data)
	if not (data ~= nil) then
		do return nil end
	end
	_io:write_to_stdout("[jk.lang.Map.dup] (Map.sling:371:3): Not implemented" .. "\n")
	do return nil end
end

function jk.lang.Map:getKeys(data)
	if not (data ~= nil) then
		do return nil end
	end
	do
		local v = nil
		do v = _vm:get_table_keys(data) end
		do return v end
	end
end

function jk.lang.Map:getValues(data)
	if not (data ~= nil) then
		do return nil end
	end
	do
		local v = nil
		do v = _vm:get_table_values(data) end
		do return v end
	end
end

function jk.lang.Map:iterateKeys(data)
	do return _g.jk.lang.Vector:iterate(_g.jk.lang.Map:getKeys(data)) end
end

function jk.lang.Map:iterateValues(data)
	do return _g.jk.lang.Vector:iterate(_g.jk.lang.Map:getValues(data)) end
end

jk.lang.VectorObject = {}

jk.lang.Serializer = {}
jk.lang.Serializer.__index = jk.lang.Serializer
_vm:set_metatable(jk.lang.Serializer, {})

function jk.lang.Serializer._create()
	local v = _vm:set_metatable({}, jk.lang.Serializer)
	return v
end

function jk.lang.Serializer:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Serializer'
	self['_isType.jk.lang.Serializer'] = true
end

function jk.lang.Serializer:_construct0()
	jk.lang.Serializer._init(self)
	return self
end

function jk.lang.Serializer:toBuffer(value)
	if not (value ~= nil) then
		do return nil end
	end
	do return _vm:serialize_object(value) end
end

function jk.lang.Serializer:fromBuffer(buffer)
	if not (buffer ~= nil) then
		do return nil end
	end
	do
		local oo = nil
		do oo = _vm:unserialize_object(buffer) end
		if not (oo ~= nil) then
			do return nil end
		end
		do _vm:set_metatable(oo, _vm:get_global(oo._qualifiedClassName)) end
		do return oo end
	end
end

jk.lang.BufferBuilder = {}
jk.lang.BufferBuilder.__index = jk.lang.BufferBuilder
_vm:set_metatable(jk.lang.BufferBuilder, {})

function jk.lang.BufferBuilder._create()
	local v = _vm:set_metatable({}, jk.lang.BufferBuilder)
	return v
end

function jk.lang.BufferBuilder:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.BufferBuilder'
	self['_isType.jk.lang.BufferBuilder'] = true
	self.buffer = nil
	self.pointer = 0
end

function jk.lang.BufferBuilder:_construct0()
	jk.lang.BufferBuilder._init(self)
	return self
end

function jk.lang.BufferBuilder:allocate(sz)
	if self.buffer == nil then
		self.buffer = _util:allocate_buffer(8192)
		do return end
	end
	do
		local needed = self.pointer + sz
		local csz = _g.jk.lang.Buffer:getSize(self.buffer)
		if csz >= needed then
			do return end
		end
		do
			local nsz = csz
			while nsz < needed do
				nsz = nsz + 1024
			end
			self.buffer = _g.jk.lang.Buffer:resize(self.buffer, nsz)
		end
	end
end

function jk.lang.BufferBuilder:getSize()
	do return self.pointer end
end

function jk.lang.BufferBuilder:appendInteger(value)
	do self:allocate(self.pointer + 1) end
	do _g.jk.lang.Buffer:setByte(self.buffer, self.pointer, value) end
	do self.pointer = self.pointer + 1 end
end

function jk.lang.BufferBuilder:appendBuffer(sbuffer)
	do self:appendSubBuffer(sbuffer, 0, _g.jk.lang.Buffer:getSize(sbuffer)) end
end

function jk.lang.BufferBuilder:appendSubBuffer(sbuffer, offset, size)
	if not (sbuffer ~= nil) then
		do return end
	end
	if not (offset >= 0) then
		do return end
	end
	if not (size >= 0) then
		do return end
	end
	do self:allocate(self.pointer + size) end
	do _g.jk.lang.Buffer:copyFrom(self.buffer, sbuffer, offset, self.pointer, size) end
	self.pointer = self.pointer + size
end

function jk.lang.BufferBuilder:toBuffer()
	do return _g.jk.lang.Buffer:getSubBuffer(self.buffer, 0, self.pointer, false) end
end

jk.lang.Buffer = {}
jk.lang.Buffer.__index = jk.lang.Buffer
_vm:set_metatable(jk.lang.Buffer, {})

function jk.lang.Buffer._create()
	local v = _vm:set_metatable({}, jk.lang.Buffer)
	return v
end

function jk.lang.Buffer:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Buffer'
	self['_isType.jk.lang.Buffer'] = true
end

function jk.lang.Buffer:_construct0()
	jk.lang.Buffer._init(self)
	return self
end

jk.lang.Buffer.MyBufferObject = {}
jk.lang.Buffer.MyBufferObject.__index = jk.lang.Buffer.MyBufferObject
_vm:set_metatable(jk.lang.Buffer.MyBufferObject, {})

function jk.lang.Buffer.MyBufferObject._create()
	local v = _vm:set_metatable({}, jk.lang.Buffer.MyBufferObject)
	return v
end

function jk.lang.Buffer.MyBufferObject:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Buffer.MyBufferObject'
	self['_isType.jk.lang.Buffer.MyBufferObject'] = true
	self['_isType.jk.lang.BufferObject'] = true
	self.buffer = nil
end

function jk.lang.Buffer.MyBufferObject:_construct0()
	jk.lang.Buffer.MyBufferObject._init(self)
	return self
end

function jk.lang.Buffer.MyBufferObject:toBuffer()
	do return self.buffer end
end

function jk.lang.Buffer.MyBufferObject:getBuffer()
	do return self.buffer end
end

function jk.lang.Buffer.MyBufferObject:setBuffer(v)
	self.buffer = v
	do return self end
end

function jk.lang.Buffer:asObject(buffer)
	local v = _g.jk.lang.Buffer.MyBufferObject._construct0(_g.jk.lang.Buffer.MyBufferObject._create())
	do v:setBuffer(buffer) end
	do return v end
end

function jk.lang.Buffer:asBuffer(obj)
	if not (obj ~= nil) then
		do return nil end
	end
	if _util:is_buffer(obj) then
		do return obj end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.BufferObject') ~= nil) then
		local bo = obj
		do return bo:toBuffer() end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		do return _g.jk.lang.Buffer:forInt32BE(_util:convert_to_integer(obj)) end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		do return _g.jk.lang.Buffer:forInt64BE(_util:convert_to_integer(obj)) end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		do return _g.jk.lang.Buffer:forDouble64BE(obj) end
	end
	do return nil end
end

function jk.lang.Buffer:forInt8Array(buf)
	if not (buf ~= nil) then
		do return nil end
	end
	do
		local sz = #buf
		local v = _util:allocate_buffer(sz)
		do
			local n = 0
			while n < sz do
				v[n + 1] = buf[n + 1]
				do n = n + 1 end
			end
		end
		do return v end
	end
end

function jk.lang.Buffer:toInt8Array(buf)
	if not (buf ~= nil) then
		do return nil end
	end
	do
		local sz = #buf
		local v = _vm:allocate_array(sz)
		do
			local n = 0
			while n < sz do
				v[n + 1] = buf[n + 1]
				do n = n + 1 end
			end
		end
		do return v end
	end
end

function jk.lang.Buffer:getSubBuffer(buffer, offset, size, alwaysNewBuffer)
	if alwaysNewBuffer == false and offset == 0 and size < 0 then
		do return buffer end
	end
	do
		local bsz = _g.jk.lang.Buffer:getSize(buffer)
		local sz = size
		if sz < 0 then
			sz = bsz - offset
		end
		if alwaysNewBuffer == false and offset == 0 and sz == bsz then
			do return buffer end
		end
		if sz < 1 then
			do return nil end
		end
		do
			local v = _util:allocate_buffer(sz)
			do _g.jk.lang.Buffer:copyFrom(v, buffer, offset, 0, sz) end
			do return v end
		end
	end
end

function jk.lang.Buffer:getInt8(buffer, offset)
	if not (buffer ~= nil) then
		do return 0 end
	end
	do return buffer[offset+1] end
end

function jk.lang.Buffer:copyFrom(array, src, soffset, doffset, size)
	if not (array ~= nil) then
		do return end
	end
	if not (src ~= nil) then
		do return end
	end
	do _util:copy_buffer_bytes(src, array, soffset, doffset, size) end
end

function jk.lang.Buffer:getInt16LE(buffer, offset)
	if not (buffer ~= nil) then
		do return 0 end
	end
	do
		local b1 = buffer[offset + 1]
		local b2 = buffer[offset + 1 + 1]
		do return _util:network_bytes_to_host16(b2, b1) end
	end
end

function jk.lang.Buffer:getInt16BE(buffer, offset)
	if not (buffer ~= nil) then
		do return 0 end
	end
	do
		local b1 = buffer[offset + 1]
		local b2 = buffer[offset + 1 + 1]
		do return _util:network_bytes_to_host16(b1, b2) end
	end
end

function jk.lang.Buffer:getInt32LE(buffer, offset)
	local b1 = buffer[offset + 1]
	local b2 = buffer[offset + 1 + 1]
	local b3 = buffer[offset + 2 + 1]
	local b4 = buffer[offset + 3 + 1]
	do return _util:network_bytes_to_host32(b4, b3, b2, b1) end
end

function jk.lang.Buffer:getInt32BE(buffer, offset)
	local b1 = buffer[offset + 1]
	local b2 = buffer[offset + 1 + 1]
	local b3 = buffer[offset + 2 + 1]
	local b4 = buffer[offset + 3 + 1]
	do return _util:network_bytes_to_host32(b1, b2, b3, b4) end
end

function jk.lang.Buffer:getInt64LE(buffer, offset)
	local b1 = buffer[offset + 1]
	local b2 = buffer[offset + 1 + 1]
	local b3 = buffer[offset + 2 + 1]
	local b4 = buffer[offset + 3 + 1]
	local b5 = buffer[offset + 4 + 1]
	local b6 = buffer[offset + 5 + 1]
	local b7 = buffer[offset + 6 + 1]
	local b8 = buffer[offset + 7 + 1]
	do return _util:network_bytes_to_host64(b8, b7, b6, b5, b4, b3, b2, b1) end
end

function jk.lang.Buffer:getInt64BE(buffer, offset)
	_io:write_to_stdout("[jk.lang.Buffer.getInt64BE] (Buffer.sling:513:2): Not implemented" .. "\n")
	do return 0 end
end

function jk.lang.Buffer:getFloatLE(buffer, offset)
	_io:write_to_stdout("[jk.lang.Buffer.getFloatLE] (Buffer.sling:520:2): Not implemented" .. "\n")
	do return 0.0 end
end

function jk.lang.Buffer:getFloatBE(buffer, offset)
	_io:write_to_stdout("[jk.lang.Buffer.getFloatBE] (Buffer.sling:527:2): Not implemented" .. "\n")
	do return 0.0 end
end

function jk.lang.Buffer:getDoubleLE(buffer, offset)
	_io:write_to_stdout("[jk.lang.Buffer.getDoubleLE] (Buffer.sling:534:2): Not implemented" .. "\n")
	do return 0.0 end
end

function jk.lang.Buffer:getDoubleBE(buffer, offset)
	_io:write_to_stdout("[jk.lang.Buffer.getDoubleBE] (Buffer.sling:541:2): Not implemented" .. "\n")
	do return 0.0 end
end

function jk.lang.Buffer:forInt8(number)
	local v = _util:allocate_buffer(1)
	v[0 + 1] = _vm:bitwise_and(number, 255)
	do return v end
end

function jk.lang.Buffer:forInt16BE(number)
	do return _util:integer_to_buffer16(number, 0) end
end

function jk.lang.Buffer:forInt16LE(number)
	do return _util:integer_to_buffer16(number, 1) end
end

function jk.lang.Buffer:forInt32BE(number)
	do return _util:integer_to_buffer32(number, 0) end
end

function jk.lang.Buffer:forInt32LE(number)
	do return _util:integer_to_buffer32(number, 1) end
end

function jk.lang.Buffer:forInt64BE(number)
	do return _util:integer_to_buffer64(number, 0) end
end

function jk.lang.Buffer:forInt64LE(number)
	do return _util:integer_to_buffer64(number, 1) end
end

function jk.lang.Buffer:forFloat32BE(number)
	do return _util:float_to_buffer32(number, 0) end
end

function jk.lang.Buffer:forFloat32LE(number)
	do return _util:float_to_buffer32(number, 1) end
end

function jk.lang.Buffer:forDouble64BE(number)
	do return _util:double_to_buffer64(number, 0) end
end

function jk.lang.Buffer:forDouble64LE(number)
	do return _util:double_to_buffer64(number, 1) end
end

function jk.lang.Buffer:getSize(buffer)
	if buffer == nil then
		do return 0 end
	end
	do return #buffer end
end

function jk.lang.Buffer:getByte(buffer, offset)
	do return _g.jk.lang.Buffer:getInt8(buffer, offset) end
end

function jk.lang.Buffer:setByte(buffer, offset, value)
	if not (buffer ~= nil) then
		do return end
	end
	do buffer[offset+1] = value end
end

function jk.lang.Buffer:allocate(size)
	do return _util:allocate_buffer(size) end
end

function jk.lang.Buffer:fill(buffer, value)
	local s = _g.jk.lang.Buffer:getSize(buffer)
	do
		local i = 0
		while i < s do
			do _g.jk.lang.Buffer:setByte(buffer, i, value) end
			do i = i + 1 end
		end
	end
end

function jk.lang.Buffer:resize(buffer, newSize)
	if newSize < 1 then
		do return nil end
	end
	if not (buffer ~= nil) then
		do return _g.jk.lang.Buffer:allocate(newSize) end
	end
	if #buffer == newSize then
		do return buffer end
	end
	do
		local oldSize = 0
		if buffer ~= nil then
			oldSize = #buffer
		end
		do
			local v = _util:allocate_buffer(newSize)
			if newSize >= oldSize then
				if oldSize > 0 then
					do _g.jk.lang.Buffer:copyFrom(v, buffer, 0, 0, oldSize) end
				end
			else
				do _g.jk.lang.Buffer:copyFrom(v, buffer, 0, 0, newSize) end
			end
			do return v end
		end
	end
end

function jk.lang.Buffer:append(original, toAppend, size)
	if toAppend == nil or size == 0 then
		do return original end
	end
	do
		local sz = size
		local os = _g.jk.lang.Buffer:getSize(original)
		local oas = _g.jk.lang.Buffer:getSize(toAppend)
		if sz >= 0 then
			oas = sz
		end
		do
			local nl = os + oas
			local nb = _g.jk.lang.Buffer:resize(original, nl)
			do _g.jk.lang.Buffer:copyFrom(nb, toAppend, 0, os, oas) end
			do return nb end
		end
	end
end

function jk.lang.Buffer:forHexString(str)
	if str == nil or _util:convert_to_integer(_g.jk.lang.String:getLength(str) % 2) ~= 0 then
		do return nil end
	end
	do
		local sb = nil
		local b = _g.jk.lang.Buffer:allocate(_util:convert_to_integer(_g.jk.lang.String:getLength(str) / 2))
		local n = 0
		local it = _g.jk.lang.String:iterate(str)
		while it ~= nil do
			local c = it:getNextChar()
			if c < 1 then
				do break end
			end
			if sb == nil then
				sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
			end
			if c >= 97 and c <= 102 or (c >= 65 and c <= 70) or (c >= 48 and c <= 57) then
				do sb:appendCharacter(c) end
				if sb:count() == 2 then
					do _g.jk.lang.Buffer:setByte(b, (function() local v = n n = n + 1 return v end)(), _g.jk.lang.String:toIntegerFromHex(sb:toString())) end
					do sb:clear() end
				end
			else
				do return nil end
			end
		end
		do return b end
	end
end

jk.lang.StringDataReceiver = {}

jk.lang.LongIntegerObject = {}

jk.lang.StringSet = {}
jk.lang.StringSet.__index = jk.lang.StringSet
_vm:set_metatable(jk.lang.StringSet, {})

function jk.lang.StringSet._create()
	local v = _vm:set_metatable({}, jk.lang.StringSet)
	return v
end

function jk.lang.StringSet:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.StringSet'
	self['_isType.jk.lang.StringSet'] = true
	self.data = nil
end

function jk.lang.StringSet:_construct0()
	jk.lang.StringSet._init(self)
	self.data = {}
	return self
end

function jk.lang.StringSet:add(value)
	do _g.jk.lang.Map:setValue(self.data, value, _g.jk.lang.Boolean:asObject(true)) end
end

function jk.lang.StringSet:remove(value)
	do _g.jk.lang.Map:remove(self.data, value) end
end

function jk.lang.StringSet:count()
	do return _g.jk.lang.Map:count(self.data) end
end

function jk.lang.StringSet:contains(value)
	if _g.jk.lang.Map:getValue(self.data, value) ~= nil then
		do return true end
	end
	do return false end
end

function jk.lang.StringSet:getAll()
	local v = _g.jk.lang.Map:getKeys(self.data)
	do return v end
end

function jk.lang.StringSet:clear()
	do _g.jk.lang.Map:clear(self.data) end
end

jk.lang.Task = {}

jk.lang.DynamicObject = {}
jk.lang.DynamicObject.__index = jk.lang.DynamicObject
_vm:set_metatable(jk.lang.DynamicObject, {})

function jk.lang.DynamicObject._create()
	local v = _vm:set_metatable({}, jk.lang.DynamicObject)
	return v
end

function jk.lang.DynamicObject:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.DynamicObject'
	self['_isType.jk.lang.DynamicObject'] = true
end

function jk.lang.DynamicObject:_construct0()
	jk.lang.DynamicObject._init(self)
	return self
end

jk.lang.DynamicObject.StringIteratorWrapper = {}
jk.lang.DynamicObject.StringIteratorWrapper.__index = jk.lang.DynamicObject.StringIteratorWrapper
_vm:set_metatable(jk.lang.DynamicObject.StringIteratorWrapper, {})

function jk.lang.DynamicObject.StringIteratorWrapper._create()
	local v = _vm:set_metatable({}, jk.lang.DynamicObject.StringIteratorWrapper)
	return v
end

function jk.lang.DynamicObject.StringIteratorWrapper:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.DynamicObject.StringIteratorWrapper'
	self['_isType.jk.lang.DynamicObject.StringIteratorWrapper'] = true
	self['_isType.jk.lang.Iterator'] = true
	self.iterator = nil
end

function jk.lang.DynamicObject.StringIteratorWrapper:_construct0()
	jk.lang.DynamicObject.StringIteratorWrapper._init(self)
	return self
end

function jk.lang.DynamicObject.StringIteratorWrapper:next()
	if not (self.iterator ~= nil) then
		do return nil end
	end
	do
		local c = self.iterator:getNextChar()
		if _g.jk.lang.Character:isEOF(c) then
			self.iterator = nil
			do return nil end
		end
		do return c end
	end
end

function jk.lang.DynamicObject.StringIteratorWrapper:hasNext()
	if not (self.iterator ~= nil) then
		do return false end
	end
	do return not self.iterator:hasEnded() end
end

function jk.lang.DynamicObject.StringIteratorWrapper:getIterator()
	do return self.iterator end
end

function jk.lang.DynamicObject.StringIteratorWrapper:setIterator(v)
	self.iterator = v
	do return self end
end

jk.lang.DynamicObject.BufferIteratorWrapper = {}
jk.lang.DynamicObject.BufferIteratorWrapper.__index = jk.lang.DynamicObject.BufferIteratorWrapper
_vm:set_metatable(jk.lang.DynamicObject.BufferIteratorWrapper, {})

function jk.lang.DynamicObject.BufferIteratorWrapper._create()
	local v = _vm:set_metatable({}, jk.lang.DynamicObject.BufferIteratorWrapper)
	return v
end

function jk.lang.DynamicObject.BufferIteratorWrapper:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.DynamicObject.BufferIteratorWrapper'
	self['_isType.jk.lang.DynamicObject.BufferIteratorWrapper'] = true
	self['_isType.jk.lang.Iterator'] = true
	self.buffer = nil
	self.size = 0
	self.position = 0
end

function jk.lang.DynamicObject.BufferIteratorWrapper:_construct0()
	jk.lang.DynamicObject.BufferIteratorWrapper._init(self)
	return self
end

function jk.lang.DynamicObject.BufferIteratorWrapper:next()
	if not (self.buffer ~= nil) then
		do return nil end
	end
	if self.position >= self.size then
		do return nil end
	end
	do
		local v = self.buffer[self.position + 1]
		do self.position = self.position + 1 end
		do return v end
	end
end

function jk.lang.DynamicObject.BufferIteratorWrapper:hasNext()
	if not (self.buffer ~= nil) then
		do return false end
	end
	if not (self.position < self.size - 1) then
		do return false end
	end
	do return true end
end

function jk.lang.DynamicObject.BufferIteratorWrapper:getBuffer()
	do return self.buffer end
end

function jk.lang.DynamicObject.BufferIteratorWrapper:setBuffer(v)
	self.buffer = v
	do return self end
end

function jk.lang.DynamicObject.BufferIteratorWrapper:getSize()
	do return self.size end
end

function jk.lang.DynamicObject.BufferIteratorWrapper:setSize(v)
	self.size = v
	do return self end
end

jk.lang.DynamicObject.ArrayIteratorWrapper = {}
jk.lang.DynamicObject.ArrayIteratorWrapper.__index = jk.lang.DynamicObject.ArrayIteratorWrapper
_vm:set_metatable(jk.lang.DynamicObject.ArrayIteratorWrapper, {})

function jk.lang.DynamicObject.ArrayIteratorWrapper._create()
	local v = _vm:set_metatable({}, jk.lang.DynamicObject.ArrayIteratorWrapper)
	return v
end

function jk.lang.DynamicObject.ArrayIteratorWrapper:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.DynamicObject.ArrayIteratorWrapper'
	self['_isType.jk.lang.DynamicObject.ArrayIteratorWrapper'] = true
	self['_isType.jk.lang.Iterator'] = true
	self.array = nil
	self.size = 0
	self.position = 0
end

function jk.lang.DynamicObject.ArrayIteratorWrapper:_construct0()
	jk.lang.DynamicObject.ArrayIteratorWrapper._init(self)
	return self
end

function jk.lang.DynamicObject.ArrayIteratorWrapper:next()
	if not (self.array ~= nil) then
		do return nil end
	end
	if self.position >= self.size then
		do return nil end
	end
	do
		local v = self.array[self.position + 1]
		do self.position = self.position + 1 end
		do return v end
	end
end

function jk.lang.DynamicObject.ArrayIteratorWrapper:hasNext()
	if not (self.array ~= nil) then
		do return false end
	end
	if not (self.position < self.size - 1) then
		do return false end
	end
	do return true end
end

function jk.lang.DynamicObject.ArrayIteratorWrapper:getArray()
	do return self.array end
end

function jk.lang.DynamicObject.ArrayIteratorWrapper:setArray(v)
	self.array = v
	do return self end
end

function jk.lang.DynamicObject.ArrayIteratorWrapper:getSize()
	do return self.size end
end

function jk.lang.DynamicObject.ArrayIteratorWrapper:setSize(v)
	self.size = v
	do return self end
end

jk.lang.DynamicObject.VectorIteratorWrapper = {}
jk.lang.DynamicObject.VectorIteratorWrapper.__index = jk.lang.DynamicObject.VectorIteratorWrapper
_vm:set_metatable(jk.lang.DynamicObject.VectorIteratorWrapper, {})

function jk.lang.DynamicObject.VectorIteratorWrapper._create()
	local v = _vm:set_metatable({}, jk.lang.DynamicObject.VectorIteratorWrapper)
	return v
end

function jk.lang.DynamicObject.VectorIteratorWrapper:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.DynamicObject.VectorIteratorWrapper'
	self['_isType.jk.lang.DynamicObject.VectorIteratorWrapper'] = true
	self['_isType.jk.lang.Iterator'] = true
	self.vector = nil
	self.size = 0
	self.position = 0
end

function jk.lang.DynamicObject.VectorIteratorWrapper:_construct0()
	jk.lang.DynamicObject.VectorIteratorWrapper._init(self)
	return self
end

function jk.lang.DynamicObject.VectorIteratorWrapper:next()
	if not (self.vector ~= nil) then
		do return nil end
	end
	if self.position >= self.size then
		do return nil end
	end
	do
		local v = self.vector[self.position + 1]
		do self.position = self.position + 1 end
		do return v end
	end
end

function jk.lang.DynamicObject.VectorIteratorWrapper:hasNext()
	if not (self.vector ~= nil) then
		do return false end
	end
	if not (self.position < self.size - 1) then
		do return false end
	end
	do return true end
end

function jk.lang.DynamicObject.VectorIteratorWrapper:getVector()
	do return self.vector end
end

function jk.lang.DynamicObject.VectorIteratorWrapper:setVector(v)
	self.vector = v
	do return self end
end

function jk.lang.DynamicObject.VectorIteratorWrapper:getSize()
	do return self.size end
end

function jk.lang.DynamicObject.VectorIteratorWrapper:setSize(v)
	self.size = v
	do return self end
end

function jk.lang.DynamicObject:iterate(value)
	if (_vm:get_variable_type(value) == 'string') then
		local v = _g.jk.lang.DynamicObject.StringIteratorWrapper._construct0(_g.jk.lang.DynamicObject.StringIteratorWrapper._create())
		do v:setIterator(_g.jk.lang.String:iterate(value)) end
		do return v end
	end
	if _util:is_buffer(value) then
		local v = _g.jk.lang.DynamicObject.BufferIteratorWrapper._construct0(_g.jk.lang.DynamicObject.BufferIteratorWrapper._create())
		do v:setBuffer(value) end
		do v:setSize(#value) end
		do return v end
	end
	if (function(x) return x ~= nil and _vm:get_variable_type(x) == 'table' and not x._isClassInstance == true and #x > 0 end)(value) then
		local v = _g.jk.lang.DynamicObject.ArrayIteratorWrapper._construct0(_g.jk.lang.DynamicObject.ArrayIteratorWrapper._create())
		do v:setArray(value) end
		do v:setSize(#value) end
		do return v end
	end
	if (function(x) return x ~= nil and _vm:get_variable_type(x) == 'table' and not x._isClassInstance == true and #x > 0 end)(value) then
		local v = _g.jk.lang.DynamicObject.VectorIteratorWrapper._construct0(_g.jk.lang.DynamicObject.VectorIteratorWrapper._create())
		do v:setVector(value) end
		do v:setSize(_g.jk.lang.Vector:getSize(value)) end
		do return v end
	end
	if (function(x) return x ~= nil and _vm:get_variable_type(x) == 'table' and not x._isClassInstance == true and #x < 1 end)(value) then
		do return _g.jk.lang.DynamicObject:iterate(_g.jk.lang.Map:getValues(value)) end
	end
	do return nil end
end

jk.lang.Error = {}
jk.lang.Error.__index = jk.lang.Error
_vm:set_metatable(jk.lang.Error, {})

function jk.lang.Error._create()
	local v = _vm:set_metatable({}, jk.lang.Error)
	return v
end

function jk.lang.Error:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Error'
	self['_isType.jk.lang.Error'] = true
	self['_isType.jk.lang.StringObject'] = true
	self['_isType.jk.lang.StringObjectWithDebug'] = true
	self.code = nil
	self.detail = nil
end

function jk.lang.Error:_construct0()
	jk.lang.Error._init(self)
	return self
end

function jk.lang.Error:throw(code, detail)
	_vm:throw_error(_g.jk.lang.ExceptionWithError:forError(_g.jk.lang.Error:forCode(code, detail)))
end

function jk.lang.Error:forCode(code, detail)
	do return _g.jk.lang.Error._construct0(_g.jk.lang.Error._create()):setCode(code):setDetail(detail) end
end

function jk.lang.Error:asString(error)
	if not (error ~= nil) then
		do return "error" end
	end
	do return error:toString() end
end

function jk.lang.Error:set(error, code, detail)
	if not (error ~= nil) then
		do return nil end
	end
	do error:setCode(code) end
	do error:setDetail(detail) end
	do return error end
end

function jk.lang.Error:setErrorCode(error, code)
	do return _g.jk.lang.Error:set(error, code, nil) end
end

function jk.lang.Error:setErrorDetail(error, detail)
	do return _g.jk.lang.Error:set(error, nil, detail) end
end

function jk.lang.Error:isError(o)
	if not (o ~= nil) then
		do return false end
	end
	if not (_vm:to_table_with_key(o, '_isType.jk.lang.Error') ~= nil) then
		do return false end
	end
	do
		local e = o
		if _g.jk.lang.String:isEmpty(e:getCode()) then
			do return false end
		end
		do return true end
	end
end

function jk.lang.Error:clear()
	self.code = nil
	self.detail = nil
	do return self end
end

function jk.lang.Error:toStringWithDefault(debug, defaultError)
	local details = nil
	if (_vm:to_table_with_key(self.detail, '_isType.jk.lang.StringObjectWithDebug') ~= nil) then
		details = self.detail:toStringWithDebug(debug)
	else
		details = _g.jk.lang.String:asString(self.detail)
	end
	if _g.jk.lang.String:isEmpty(self.code) == false then
		if _g.jk.lang.String:isEmpty(details) == false then
			do return _g.jk.lang.String:safeString(self.code) .. ":" .. _g.jk.lang.String:safeString(details) end
		end
		do return self.code end
	end
	if _g.jk.lang.String:isEmpty(details) == false then
		do return "errorWithDetail:" .. _g.jk.lang.String:safeString(details) end
	end
	do return defaultError end
end

function jk.lang.Error:toStringWithDebug(debug)
	do return self:toStringWithDefault(debug, "unknownError") end
end

function jk.lang.Error:toString()
	do return self:toStringWithDebug(false) end
end

function jk.lang.Error:getCode()
	do return self.code end
end

function jk.lang.Error:setCode(v)
	self.code = v
	do return self end
end

function jk.lang.Error:getDetail()
	do return self.detail end
end

function jk.lang.Error:setDetail(v)
	self.detail = v
	do return self end
end

jk.lang.ExceptionWithError = _g.jk.lang.Exception._create()
jk.lang.ExceptionWithError.__index = jk.lang.ExceptionWithError
_vm:set_metatable(jk.lang.ExceptionWithError, {
	__index = _g.jk.lang.Exception
})

function jk.lang.ExceptionWithError._create()
	local v = _vm:set_metatable({}, jk.lang.ExceptionWithError)
	return v
end

function jk.lang.ExceptionWithError:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.ExceptionWithError'
	self['_isType.jk.lang.ExceptionWithError'] = true
	self['_isType.jk.lang.StringObject'] = true
	self.error = nil
end

function jk.lang.ExceptionWithError:_construct0()
	jk.lang.ExceptionWithError._init(self)
	do _g.jk.lang.Exception._construct0(self) end
	return self
end

function jk.lang.ExceptionWithError:forError(error)
	local v = _g.jk.lang.ExceptionWithError._construct0(_g.jk.lang.ExceptionWithError._create())
	do v:setError(error) end
	do return v end
end

function jk.lang.ExceptionWithError:forCode(code, detail)
	do return _g.jk.lang.ExceptionWithError:forError(_g.jk.lang.Error:forCode(code, detail)) end
end

function jk.lang.ExceptionWithError:getErrorCode()
	if not (self.error ~= nil) then
		do return nil end
	end
	do return self.error:getCode() end
end

function jk.lang.ExceptionWithError:getErrorDetail()
	if not (self.error ~= nil) then
		do return nil end
	end
	do return self.error:getDetail() end
end

function jk.lang.ExceptionWithError:toString()
	do return _g.jk.lang.Error:asString(self.error) end
end

function jk.lang.ExceptionWithError:getError()
	do return self.error end
end

function jk.lang.ExceptionWithError:setError(v)
	self.error = v
	do return self end
end

jk.lang.ExceptionWithString = _g.jk.lang.Exception._create()
jk.lang.ExceptionWithString.__index = jk.lang.ExceptionWithString
_vm:set_metatable(jk.lang.ExceptionWithString, {
	__index = _g.jk.lang.Exception
})

function jk.lang.ExceptionWithString._create()
	local v = _vm:set_metatable({}, jk.lang.ExceptionWithString)
	return v
end

function jk.lang.ExceptionWithString:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.ExceptionWithString'
	self['_isType.jk.lang.ExceptionWithString'] = true
	self['_isType.jk.lang.StringObject'] = true
	self.exceptionMessage = nil
	self.stackTraceString = nil
end

function jk.lang.ExceptionWithString:_construct0()
	jk.lang.ExceptionWithString._init(self)
	do _g.jk.lang.Exception._construct0(self) end
	return self
end

function jk.lang.ExceptionWithString:forString(value, allowStackTrace)
	local v = _g.jk.lang.ExceptionWithString._construct0(_g.jk.lang.ExceptionWithString._create())
	do v:setExceptionMessage(value) end
	if allowStackTrace then
		do v:updateStackTrace() end
	end
	do return v end
end

function jk.lang.ExceptionWithString:updateStackTrace()
	do self:setStackTraceString(_g.jk.lang.StackTrace:generate()) end
end

function jk.lang.ExceptionWithString:toString()
	if not (self.stackTraceString ~= nil) then
		do return self.exceptionMessage end
	end
	do
		local v = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		do v:appendString(self.exceptionMessage) end
		do
			local ss = self.stackTraceString
			if _g.jk.lang.String:getLength(ss) > 0 then
				if v:count() > 0 then
					do v:appendCharacter(10) end
				end
				do v:appendString(ss) end
			end
			do return v:toString() end
		end
	end
end

function jk.lang.ExceptionWithString:getExceptionMessage()
	do return self.exceptionMessage end
end

function jk.lang.ExceptionWithString:setExceptionMessage(v)
	self.exceptionMessage = v
	do return self end
end

function jk.lang.ExceptionWithString:getStackTraceString()
	do return self.stackTraceString end
end

function jk.lang.ExceptionWithString:setStackTraceString(v)
	self.stackTraceString = v
	do return self end
end

jk.lang.LogicOp = {}
jk.lang.LogicOp.__index = jk.lang.LogicOp
_vm:set_metatable(jk.lang.LogicOp, {})

function jk.lang.LogicOp._create()
	local v = _vm:set_metatable({}, jk.lang.LogicOp)
	return v
end

function jk.lang.LogicOp:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.LogicOp'
	self['_isType.jk.lang.LogicOp'] = true
end

function jk.lang.LogicOp:_construct0()
	jk.lang.LogicOp._init(self)
	return self
end

function jk.lang.LogicOp:_or(v1, v2)
	do return v1 or v2 end
end

function jk.lang.LogicOp:_and(v1, v2)
	do return v1 and v2 end
end

function jk.lang.LogicOp:_not(v)
	do return not v end
end

jk.lang.CharacterIteratorForBuffer = _g.jk.lang.CharacterDecoder._create()
jk.lang.CharacterIteratorForBuffer.__index = jk.lang.CharacterIteratorForBuffer
_vm:set_metatable(jk.lang.CharacterIteratorForBuffer, {
	__index = _g.jk.lang.CharacterDecoder
})

function jk.lang.CharacterIteratorForBuffer._create()
	local v = _vm:set_metatable({}, jk.lang.CharacterIteratorForBuffer)
	return v
end

function jk.lang.CharacterIteratorForBuffer:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.CharacterIteratorForBuffer'
	self['_isType.jk.lang.CharacterIteratorForBuffer'] = true
	self['_isType.jk.lang.Duplicateable'] = true
	self.buffer = nil
	self.bufferSize = 0
	self.currentPosition = -1
end

function jk.lang.CharacterIteratorForBuffer:_construct0()
	jk.lang.CharacterIteratorForBuffer._init(self)
	do _g.jk.lang.CharacterDecoder._construct0(self) end
	return self
end

function jk.lang.CharacterIteratorForBuffer:forBuffer(buffer)
	local v = _g.jk.lang.CharacterIteratorForBuffer._construct0(_g.jk.lang.CharacterIteratorForBuffer._create())
	do v:setBuffer(buffer) end
	do return v end
end

function jk.lang.CharacterIteratorForBuffer:setBuffer(buffer)
	do self:resetDecoder() end
	self.buffer = buffer
	self.bufferSize = _g.jk.lang.Buffer:getSize(buffer)
	self.currentPosition = -1
end

function jk.lang.CharacterIteratorForBuffer:moveToPreviousByte()
	if self.currentPosition < 1 then
		do return false end
	end
	do self.currentPosition = self.currentPosition - 1 end
	do return true end
end

function jk.lang.CharacterIteratorForBuffer:moveToNextByte()
	local n = self.currentPosition + 1
	if n >= self.bufferSize then
		do return false end
	end
	self.currentPosition = n
	do return true end
end

function jk.lang.CharacterIteratorForBuffer:getCurrentByte()
	local v = _vm:bitwise_and(self.buffer[self.currentPosition + 1], 255)
	do return v end
end

function jk.lang.CharacterIteratorForBuffer:getCurrentPosition()
	do return self.currentPosition end
end

function jk.lang.CharacterIteratorForBuffer:setCurrentPosition(position)
	if position < 0 then
		self.current = 0
		self.currentPosition = -1
	else
		self.currentPosition = position + 1
		do self:doMoveToPreviousChar() end
	end
end

function jk.lang.CharacterIteratorForBuffer:duplicate()
	local v = _g.jk.lang.CharacterIteratorForBuffer._construct0(_g.jk.lang.CharacterIteratorForBuffer._create())
	do _g.jk.lang.CharacterDecoder.copyTo(self, v) end
	v.buffer = self.buffer
	v.bufferSize = self.bufferSize
	v.currentPosition = self.currentPosition
	do return v end
end

jk.lang.Integer = {}
jk.lang.Integer.__index = jk.lang.Integer
_vm:set_metatable(jk.lang.Integer, {})

function jk.lang.Integer._create()
	local v = _vm:set_metatable({}, jk.lang.Integer)
	return v
end

function jk.lang.Integer:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Integer'
	self['_isType.jk.lang.Integer'] = true
	self['_isType.jk.lang.IntegerObject'] = true
	self.value = 0
end

function jk.lang.Integer:_construct0()
	jk.lang.Integer._init(self)
	return self
end

function jk.lang.Integer:forValue(value)
	do return _g.jk.lang.Integer:asObject(value) end
end

function jk.lang.Integer:asObject(integer)
	local v = _g.jk.lang.Integer._construct0(_g.jk.lang.Integer._create())
	do v:setValue(integer) end
	do return v end
end

function jk.lang.Integer:asInteger(obj)
	if not (obj ~= nil) then
		do return 0 end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		do return _util:convert_to_integer(obj) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.IntegerObject') ~= nil) then
		local oi = obj
		do return oi:toInteger() end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		local v = _util:convert_to_integer(obj)
		do return v end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.LongIntegerObject') ~= nil) then
		local oi = obj
		do return oi:toLong() end
	end
	if (_vm:get_variable_type(obj) == 'string') then
		do return _g.jk.lang.String:toInteger(obj) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.StringObject') ~= nil) then
		do return _g.jk.lang.String:toInteger(obj:toString()) end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		local v = obj
		do return _util:convert_to_integer(v) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.DoubleObject') ~= nil) then
		local od = obj
		do return _util:convert_to_integer(od:toDouble()) end
	end
	if (_vm:get_variable_type(obj) == 'boolean') then
		if obj == true then
			do return 1 end
		end
		do return 0 end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.BooleanObject') ~= nil) then
		if obj:toBoolean() then
			do return 1 end
		end
		do return 0 end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		local v = obj
		do return _util:convert_to_integer(v) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.CharacterObject') ~= nil) then
		local oc = obj
		do return _util:convert_to_integer(oc:toCharacter()) end
	end
	do return 0 end
end

function jk.lang.Integer:add(amount)
	self.value = self.value + amount
end

function jk.lang.Integer:toInteger()
	do return self.value end
end

function jk.lang.Integer:getValue()
	do return self.value end
end

function jk.lang.Integer:setValue(v)
	self.value = v
	do return self end
end

jk.lang.RunnableFunction = {}
jk.lang.RunnableFunction.__index = jk.lang.RunnableFunction
_vm:set_metatable(jk.lang.RunnableFunction, {})

function jk.lang.RunnableFunction._create()
	local v = _vm:set_metatable({}, jk.lang.RunnableFunction)
	return v
end

function jk.lang.RunnableFunction:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.RunnableFunction'
	self['_isType.jk.lang.RunnableFunction'] = true
	self['_isType.jk.lang.Runnable'] = true
	self._function = nil
end

function jk.lang.RunnableFunction:_construct0()
	jk.lang.RunnableFunction._init(self)
	return self
end

function jk.lang.RunnableFunction:forFunction(_function)
	local v = _g.jk.lang.RunnableFunction._construct0(_g.jk.lang.RunnableFunction._create())
	do v:setFunction(_function) end
	do return v end
end

function jk.lang.RunnableFunction:run()
	if self._function ~= nil then
		do self._function() end
	end
end

function jk.lang.RunnableFunction:getFunction()
	do return self._function end
end

function jk.lang.RunnableFunction:setFunction(v)
	self._function = v
	do return self end
end

jk.lang.ArrayObject = {}

jk.lang.DoubleIterator = {}

jk.lang.IntegerIterator = {}

jk.lang.LongInteger = {}
jk.lang.LongInteger.__index = jk.lang.LongInteger
_vm:set_metatable(jk.lang.LongInteger, {})

function jk.lang.LongInteger._create()
	local v = _vm:set_metatable({}, jk.lang.LongInteger)
	return v
end

function jk.lang.LongInteger:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.LongInteger'
	self['_isType.jk.lang.LongInteger'] = true
	self['_isType.jk.lang.LongIntegerObject'] = true
	self.value = 0
end

function jk.lang.LongInteger:_construct0()
	jk.lang.LongInteger._init(self)
	return self
end

function jk.lang.LongInteger:forValue(value)
	do return _g.jk.lang.LongInteger:asObject(value) end
end

function jk.lang.LongInteger:asObject(value)
	local v = _g.jk.lang.LongInteger._construct0(_g.jk.lang.LongInteger._create())
	do v:setValue(value) end
	do return v end
end

function jk.lang.LongInteger:asLong(obj)
	if not (obj ~= nil) then
		do return 0 end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		do return _util:convert_to_integer(obj) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.LongIntegerObject') ~= nil) then
		local oi = obj
		do return oi:toLong() end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		local v = _util:convert_to_integer(obj)
		do return v end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.IntegerObject') ~= nil) then
		local oi = obj
		do return oi:toInteger() end
	end
	if (_vm:get_variable_type(obj) == 'string') then
		do return _g.jk.lang.String:toLong(obj) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.StringObject') ~= nil) then
		do return _g.jk.lang.String:toLong(obj:toString()) end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		local v = obj
		do return _util:convert_to_integer(v) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.DoubleObject') ~= nil) then
		local od = obj
		do return _util:convert_to_integer(od:toDouble()) end
	end
	if (_vm:get_variable_type(obj) == 'boolean') then
		if obj == true then
			do return 1 end
		end
		do return 0 end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.BooleanObject') ~= nil) then
		if obj:toBoolean() then
			do return 1 end
		end
		do return 0 end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		local v = obj
		do return _util:convert_to_integer(v) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.CharacterObject') ~= nil) then
		local oc = obj
		do return _util:convert_to_integer(oc:toCharacter()) end
	end
	do return 0 end
end

function jk.lang.LongInteger:add(amount)
	self.value = self.value + amount
end

function jk.lang.LongInteger:toLong()
	do return self.value end
end

function jk.lang.LongInteger:getValue()
	do return self.value end
end

function jk.lang.LongInteger:setValue(v)
	self.value = v
	do return self end
end

jk.lang.DynamicMap = {}
jk.lang.DynamicMap.__index = jk.lang.DynamicMap
_vm:set_metatable(jk.lang.DynamicMap, {})

jk.lang.DynamicMap.nullObject = "null"

function jk.lang.DynamicMap._create()
	local v = _vm:set_metatable({}, jk.lang.DynamicMap)
	return v
end

function jk.lang.DynamicMap:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.DynamicMap'
	self['_isType.jk.lang.DynamicMap'] = true
	self['_isType.jk.lang.Duplicateable'] = true
	self['_isType.jk.lang.Iterateable'] = true
	self.map = nil
end

function jk.lang.DynamicMap:asDynamicMap(value)
	if not (value ~= nil) then
		do return nil end
	end
	if (_vm:to_table_with_key(value, '_isType.jk.lang.DynamicMap') ~= nil) then
		do return value end
	end
	if (function(x) return x ~= nil and _vm:get_variable_type(x) == 'table' and not x._isClassInstance == true and #x < 1 end)(value) then
		do return _g.jk.lang.DynamicMap:forObjectMap(value) end
	end
	do return nil end
end

function jk.lang.DynamicMap:forObjectMap(map)
	local v = _g.jk.lang.DynamicMap._construct0(_g.jk.lang.DynamicMap._create())
	if map ~= nil then
		local it = _g.jk.lang.Map:iterateKeys(map)
		while it ~= nil do
			local key = it:next()
			if key == nil then
				do break end
			end
			if (_vm:get_variable_type(key) == 'string') == false then
				goto _continue1
			end
			do v:setObject(key, _g.jk.lang.Map:getValue(map, key)) end
			::_continue1::
		end
	end
	do return v end
end

function jk.lang.DynamicMap:forStringMap(map)
	local v = _g.jk.lang.DynamicMap._construct0(_g.jk.lang.DynamicMap._create())
	if map ~= nil then
		local it = _g.jk.lang.Map:iterateKeys(map)
		while it ~= nil do
			local key = it:next()
			if key == nil then
				do break end
			end
			do v:setString(key, _g.jk.lang.Map:getValue(map, key)) end
		end
	end
	do return v end
end

function jk.lang.DynamicMap:forDynamicMaps(map1, map2)
	local v = _g.jk.lang.DynamicMap._construct0(_g.jk.lang.DynamicMap._create())
	do v:mergeFrom(map1) end
	do v:mergeFrom(map2) end
	do return v end
end

function jk.lang.DynamicMap:forDynamicMap(map)
	if not (map ~= nil) then
		do return nil end
	end
	do return map:duplicateMap() end
end

function jk.lang.DynamicMap:_construct0()
	jk.lang.DynamicMap._init(self)
	self.map = {}
	return self
end

function jk.lang.DynamicMap:asMap()
	local v = {}
	local it = self:iterateKeys()
	while it ~= nil do
		local key = it:next()
		if not (key ~= nil) then
			do break end
		end
		do _g.jk.lang.Map:set(v, key, self:get(key)) end
	end
	do return v end
end

function jk.lang.DynamicMap:asStringMap()
	do return self:toStringMap() end
end

function jk.lang.DynamicMap:toStringMap()
	local v = {}
	local it = self:iterateKeys()
	while it ~= nil do
		local key = it:next()
		if not (key ~= nil) then
			do break end
		end
		do _g.jk.lang.Map:set(v, key, self:getString(key, nil)) end
	end
	do return v end
end

function jk.lang.DynamicMap:toObjectMap()
	local v = {}
	local it = self:iterateKeys()
	while it ~= nil do
		local key = it:next()
		if not (key ~= nil) then
			do break end
		end
		do _g.jk.lang.Map:set(v, key, self:getString(key, nil)) end
	end
	do return v end
end

function jk.lang.DynamicMap:duplicate()
	do return self:duplicateMap() end
end

function jk.lang.DynamicMap:duplicateMap()
	local v = _g.jk.lang.DynamicMap._construct0(_g.jk.lang.DynamicMap._create())
	local it = self:iterateKeys()
	while it ~= nil do
		local key = it:next()
		if key == nil then
			do break end
		end
		do v:setObject(key, self:get(key)) end
	end
	do return v end
end

function jk.lang.DynamicMap:mergeFrom(other)
	if other == nil then
		do return self end
	end
	do
		local it = other:iterateKeys()
		while it ~= nil do
			local key = it:next()
			if key == nil then
				do break end
			end
			do self:setObject(key, other:get(key)) end
		end
		do return self end
	end
end

function jk.lang.DynamicMap:setObject(key, value)
	if key ~= nil then
		if value == nil then
			self.map[key] = _g.jk.lang.DynamicMap.nullObject
		else
			self.map[key] = value
		end
	end
	do return self end
end

function jk.lang.DynamicMap:setString(key, value)
	if key ~= nil then
		if value == nil then
			self.map[key] = _g.jk.lang.DynamicMap.nullObject
		else
			self.map[key] = value
		end
	end
	do return self end
end

function jk.lang.DynamicMap:setBuffer(key, value)
	if not (key == nil) and value == nil then
		self.map[key] = _g.jk.lang.DynamicMap.nullObject
		do return self end
	end
	do return self:setObject(key, _g.jk.lang.Buffer:asObject(value)) end
end

function jk.lang.DynamicMap:setInteger(key, value)
	do return self:setObject(key, _g.jk.lang.Integer:asObject(value)) end
end

function jk.lang.DynamicMap:setLong(key, value)
	do return self:setObject(key, _g.jk.lang.LongInteger:asObject(value)) end
end

function jk.lang.DynamicMap:setLongInteger(key, value)
	do return self:setObject(key, _g.jk.lang.LongInteger:asObject(value)) end
end

function jk.lang.DynamicMap:setBoolean(key, value)
	do return self:setObject(key, _g.jk.lang.Boolean:asObject(value)) end
end

function jk.lang.DynamicMap:setDouble(key, value)
	do return self:setObject(key, _g.jk.lang.Double:asObject(value)) end
end

function jk.lang.DynamicMap:get(key)
	local v = _g.jk.lang.Map:getValue(self.map, key)
	if v == _g.jk.lang.DynamicMap.nullObject then
		v = nil
	end
	do return v end
end

function jk.lang.DynamicMap:getString(key, defval)
	local v = _g.jk.lang.String:asString(self:get(key))
	if v == nil then
		do return defval end
	end
	do return v end
end

function jk.lang.DynamicMap:getInteger(key, defval)
	local vv = self:get(key)
	if vv == nil then
		do return defval end
	end
	do return _g.jk.lang.Integer:asInteger(vv) end
end

function jk.lang.DynamicMap:getLongInteger(key, defval)
	local vv = self:get(key)
	if vv == nil then
		do return defval end
	end
	do return _g.jk.lang.LongInteger:asLong(vv) end
end

function jk.lang.DynamicMap:getBoolean(key, defval)
	local vv = self:get(key)
	if vv == nil then
		do return defval end
	end
	do return _g.jk.lang.Boolean:asBoolean(vv, false) end
end

function jk.lang.DynamicMap:getDouble(key, defval)
	local vv = self:get(key)
	if vv == nil then
		do return defval end
	end
	do return _g.jk.lang.Double:asDouble(vv) end
end

function jk.lang.DynamicMap:getBuffer(key)
	local vv = self:get(key)
	if not (vv ~= nil) then
		do return nil end
	end
	do return _g.jk.lang.Buffer:asBuffer(vv) end
end

function jk.lang.DynamicMap:getDynamicVector(key)
	local vv = _vm:to_table_with_key(self:get(key), '_isType.jk.lang.DynamicVector')
	if vv ~= nil then
		do return vv end
	end
	do
		local v = self:getVector(key)
		if v ~= nil then
			do return _g.jk.lang.DynamicVector:forObjectVector(v) end
		end
		do return nil end
	end
end

function jk.lang.DynamicMap:getVector(key)
	local val = self:get(key)
	if not (val ~= nil) then
		do return nil end
	end
	if (function(x) return x ~= nil and _vm:get_variable_type(x) == 'table' and not x._isClassInstance == true and #x > 0 end)(val) then
		do return val end
	end
	if (_vm:to_table_with_key(val, '_isType.jk.lang.VectorObject') ~= nil) then
		local vo = val
		local vv = vo:toVector()
		do return vv end
	end
	do return nil end
end

function jk.lang.DynamicMap:getDynamicMap(key)
	do return _vm:to_table_with_key(self:get(key), '_isType.jk.lang.DynamicMap') end
end

function jk.lang.DynamicMap:getKeys()
	local v = _g.jk.lang.Map:getKeys(self.map)
	do return v end
end

function jk.lang.DynamicMap:getValues()
	local v = _g.jk.lang.Map:getValues(self.map)
	local v2 = {}
	if v ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(v)
		do
			n = 0
			while n < m do
				local o = v[n + 1]
				if o ~= nil then
					if o ~= _g.jk.lang.DynamicMap.nullObject then
						do _g.jk.lang.Vector:append(v2, o) end
					end
				end
				do n = n + 1 end
			end
		end
	end
	v = v2
	do return v end
end

function jk.lang.DynamicMap:iterate()
	local v = _g.jk.lang.Map:iterateKeys(self.map)
	do return v end
end

function jk.lang.DynamicMap:iterateKeys()
	local v = _g.jk.lang.Map:iterateKeys(self.map)
	do return v end
end

function jk.lang.DynamicMap:iterateValues()
	do return _g.jk.lang.Vector:iterate(self:getValues()) end
end

function jk.lang.DynamicMap:remove(key)
	do _g.jk.lang.Map:remove(self.map, key) end
end

function jk.lang.DynamicMap:clear()
	do _g.jk.lang.Map:clear(self.map) end
end

function jk.lang.DynamicMap:getCount()
	do return _g.jk.lang.Map:count(self.map) end
end

function jk.lang.DynamicMap:containsKey(key)
	do return _g.jk.lang.Map:containsKey(self.map, key) end
end

function jk.lang.DynamicMap:removeNullValues()
	local keys = self:getKeys()
	if keys ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(keys)
		do
			n = 0
			while n < m do
				local key = keys[n + 1]
				if key ~= nil then
					local value = self:get(key)
					if value == nil then
						do self:remove(key) end
					end
				end
				do n = n + 1 end
			end
		end
	end
	do return self end
end

jk.lang.DynamicMapObject = {}

jk.lang.LongIntegerIterator = {}

jk.lang.StringBuilder = {}
jk.lang.StringBuilder.__index = jk.lang.StringBuilder
_vm:set_metatable(jk.lang.StringBuilder, {})

function jk.lang.StringBuilder._create()
	local v = _vm:set_metatable({}, jk.lang.StringBuilder)
	return v
end

function jk.lang.StringBuilder:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.StringBuilder'
	self['_isType.jk.lang.StringBuilder'] = true
	self['_isType.jk.lang.StringObject'] = true
	self.buffer = nil
	self.position = 0
end

function jk.lang.StringBuilder:forString(initial)
	local v = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	do v:appendString(initial) end
	do return v end
end

function jk.lang.StringBuilder:dup(initial)
	local v = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	if initial ~= nil then
		do v:appendString(initial:toString()) end
	end
	do return v end
end

function jk.lang.StringBuilder:resizeTo(size)
	local osz = #self.buffer
	if osz < size then
		while osz < size do
			osz = osz + 1024
		end
		self.buffer = _g.jk.lang.Buffer:resize(self.buffer, osz)
	end
end

function jk.lang.StringBuilder:_construct0()
	jk.lang.StringBuilder._init(self)
	do self:initialize() end
	return self
end

function jk.lang.StringBuilder:initialize()
	self.buffer = _util:allocate_buffer(1024)
end

function jk.lang.StringBuilder:clear()
	self.buffer = _util:allocate_buffer(1024)
	self.position = 0
end

function jk.lang.StringBuilder:count()
	do return self.position end
end

function jk.lang.StringBuilder:appendLong(c)
	do return self:appendString(_g.jk.lang.String:forLongInteger(c)) end
end

function jk.lang.StringBuilder:appendInteger(c)
	do return self:appendString(_g.jk.lang.String:forInteger(c)) end
end

function jk.lang.StringBuilder:appendDouble(c)
	do return self:appendString(_g.jk.lang.String:forDouble(c)) end
end

function jk.lang.StringBuilder:appendFloat(c)
	do return self:appendString(_g.jk.lang.String:forFloat(c)) end
end

function jk.lang.StringBuilder:appendCharacter(c)
	if c == 0 or c == -1 then
		do return self end
	end
	if c <= 127 then
		do self:resizeTo(self.position + 1) end
		self.buffer[self.position + 1] = _util:convert_to_integer(c)
		do self.position = self.position + 1 end
	else
		do self:appendString(_g.jk.lang.String:forCharacter(c)) end
	end
	do return self end
end

function jk.lang.StringBuilder:appendString(str)
	if str == nil then
		do return self end
	end
	do
		local nbuf = _g.jk.lang.String:toUTF8Buffer(str)
		if nbuf ~= nil then
			local nsz = #nbuf
			do self:resizeTo(self.position + nsz) end
			do _g.jk.lang.Buffer:copyFrom(self.buffer, nbuf, 0, self.position, nsz) end
			self.position = self.position + nsz
		end
		do return self end
	end
end

function jk.lang.StringBuilder:insertInteger(index, c)
	do return self:insertString(index, _g.jk.lang.String:forInteger(c)) end
end

function jk.lang.StringBuilder:insertCharacter(index, c)
	if c == 0 then
		do return self end
	end
	do return self:insertString(index, _g.jk.lang.String:forCharacter(c)) end
end

function jk.lang.StringBuilder:insertDouble(index, c)
	do return self:insertString(index, _g.jk.lang.String:forDouble(c)) end
end

function jk.lang.StringBuilder:insertFloat(index, c)
	do return self:insertString(index, _g.jk.lang.String:forFloat(c)) end
end

function jk.lang.StringBuilder:insertString(index, str)
	if str == nil then
		do return self end
	end
	do
		local nbuf = _g.jk.lang.String:toUTF8Buffer(str)
		if nbuf ~= nil then
			local nsz = #nbuf
			do self:resizeTo(self.position + nsz) end
			do _g.jk.lang.Buffer:copyFrom(self.buffer, self.buffer, index, index + nsz, self.position - index) end
			do _g.jk.lang.Buffer:copyFrom(self.buffer, nbuf, 0, index, nsz) end
			self.position = self.position + nsz
		end
		do return self end
	end
end

function jk.lang.StringBuilder:remove(index, length)
	if length < 1 then
		do return self end
	end
	if index < self.position then
		local ll = length
		local limit = self.position - index
		if ll > limit then
			ll = limit
		end
		do _g.jk.lang.Buffer:copyFrom(self.buffer, self.buffer, index + ll, index, self.position - index - ll) end
		self.position = self.position - ll
	end
	do return self end
end

function jk.lang.StringBuilder:removeLastCharacter()
	local c = self:count()
	if c > 0 then
		do self:remove(c - 1, 1) end
	end
	do return self end
end

function jk.lang.StringBuilder:toString()
	if not (self.buffer ~= nil) or self.position < 1 then
		do return "" end
	end
	do
		local bb = self.buffer
		if self.position < #bb then
			bb = _g.jk.lang.Buffer:getSubBuffer(bb, 0, self.position, false)
		end
		do return _g.jk.lang.String:forUTF8Buffer(bb) end
	end
end

jk.lang.Set = {}
jk.lang.Set.__index = jk.lang.Set
_vm:set_metatable(jk.lang.Set, {})

function jk.lang.Set._create()
	local v = _vm:set_metatable({}, jk.lang.Set)
	return v
end

function jk.lang.Set:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Set'
	self['_isType.jk.lang.Set'] = true
end

function jk.lang.Set:_construct0()
	jk.lang.Set._init(self)
	return self
end

function jk.lang.Set:add(set, value)
	if not (set ~= nil) then
		do return end
	end
	_io:write_to_stdout("[jk.lang.Set.add] (Set.sling:49:3): Not implemented" .. "\n")
end

function jk.lang.Set:remove(set, value)
	if not (set ~= nil) then
		do return end
	end
	_io:write_to_stdout("[jk.lang.Set.remove] (Set.sling:75:3): Not implemented" .. "\n")
end

function jk.lang.Set:clear(set)
	if not (set ~= nil) then
		do return end
	end
	_io:write_to_stdout("[jk.lang.Set.clear] (Set.sling:101:3): Not implemented" .. "\n")
end

function jk.lang.Set:getSize(set)
	if not (set ~= nil) then
		do return 0 end
	end
	_io:write_to_stdout("[jk.lang.Set.getSize] (Set.sling:127:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.lang.Set:contains(set, value)
	if not (set ~= nil) then
		do return false end
	end
	_io:write_to_stdout("[jk.lang.Set.contains] (Set.sling:154:3): Not implemented" .. "\n")
	do return false end
end

function jk.lang.Set:getValues(set)
	if not (set ~= nil) then
		do return nil end
	end
	_io:write_to_stdout("[jk.lang.Set.getValues] (Set.sling:213:3): Not implemented" .. "\n")
	do return nil end
end

jk.lang.DynamicVector = {}
jk.lang.DynamicVector.__index = jk.lang.DynamicVector
_vm:set_metatable(jk.lang.DynamicVector, {})

function jk.lang.DynamicVector._create()
	local v = _vm:set_metatable({}, jk.lang.DynamicVector)
	return v
end

function jk.lang.DynamicVector:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.DynamicVector'
	self['_isType.jk.lang.DynamicVector'] = true
	self['_isType.jk.lang.Duplicateable'] = true
	self['_isType.jk.lang.Iterateable'] = true
	self['_isType.jk.lang.VectorObject'] = true
	self['_isType.jk.lang.ObjectWithSize'] = true
	self.vector = nil
end

function jk.lang.DynamicVector:asDynamicVector(value)
	if not (value ~= nil) then
		do return nil end
	end
	if (_vm:to_table_with_key(value, '_isType.jk.lang.DynamicVector') ~= nil) then
		do return value end
	end
	if (function(x) return x ~= nil and _vm:get_variable_type(x) == 'table' and not x._isClassInstance == true and #x > 0 end)(value) then
		do return _g.jk.lang.DynamicVector:forArray(value) end
	end
	if (function(x) return x ~= nil and _vm:get_variable_type(x) == 'table' and not x._isClassInstance == true and #x > 0 end)(value) then
		do return _g.jk.lang.DynamicVector:forObjectVector(value) end
	end
	do return nil end
end

function jk.lang.DynamicVector:forStringVector(vector)
	local v = _g.jk.lang.DynamicVector._construct0(_g.jk.lang.DynamicVector._create())
	if vector ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(vector)
		do
			n = 0
			while n < m do
				local item = vector[n + 1]
				if item ~= nil then
					do v:appendObject(item) end
				end
				do n = n + 1 end
			end
		end
	end
	do return v end
end

function jk.lang.DynamicVector:forObjectVector(vector)
	local v = _g.jk.lang.DynamicVector._construct0(_g.jk.lang.DynamicVector._create())
	if vector ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(vector)
		do
			n = 0
			while n < m do
				local item = vector[n + 1]
				if item ~= nil then
					do v:appendObject(item) end
				end
				do n = n + 1 end
			end
		end
	end
	do return v end
end

function jk.lang.DynamicVector:forArray(array)
	local v = _g.jk.lang.DynamicVector._construct0(_g.jk.lang.DynamicVector._create())
	if array ~= nil then
		local n = 0
		local m = #array
		do
			n = 0
			while n < m do
				local item = array[n + 1]
				if item ~= nil then
					do v:appendObject(item) end
				end
				do n = n + 1 end
			end
		end
	end
	do return v end
end

function jk.lang.DynamicVector:_construct0()
	jk.lang.DynamicVector._init(self)
	self.vector = {}
	return self
end

function jk.lang.DynamicVector:toVector()
	do return self.vector end
end

function jk.lang.DynamicVector:toVectorOfStrings()
	local v = {}
	if self.vector ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(self.vector)
		do
			n = 0
			while n < m do
				local o = self.vector[n + 1]
				if o ~= nil then
					local s = _g.jk.lang.String:asString(o)
					if s ~= nil then
						do _g.jk.lang.Vector:append(v, s) end
					end
				end
				do n = n + 1 end
			end
		end
	end
	do return v end
end

function jk.lang.DynamicVector:toVectorOfDynamicMaps()
	local v = {}
	if self.vector ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(self.vector)
		do
			n = 0
			while n < m do
				local o = _vm:to_table_with_key(self.vector[n + 1], '_isType.jk.lang.DynamicMap')
				if o ~= nil then
					do _g.jk.lang.Vector:append(v, o) end
				end
				do n = n + 1 end
			end
		end
	end
	do return v end
end

function jk.lang.DynamicVector:duplicate()
	local v = _g.jk.lang.DynamicVector._construct0(_g.jk.lang.DynamicVector._create())
	local it = self:iterate()
	while it ~= nil do
		local o = it:next()
		if o == nil then
			do break end
		end
		do v:appendObject(o) end
	end
	do return v end
end

function jk.lang.DynamicVector:mergeDynamicVector(dynamicVector)
	if not (dynamicVector ~= nil) or dynamicVector:getSize() < 1 then
		do return self end
	end
	do return self:mergeVector(dynamicVector:toVector()) end
end

function jk.lang.DynamicVector:mergeVector(vector)
	if vector ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(vector)
		do
			n = 0
			while n < m do
				local item = vector[n + 1]
				if item ~= nil then
					do self:appendObject(item) end
				end
				do n = n + 1 end
			end
		end
	end
	do return self end
end

function jk.lang.DynamicVector:appendObject(value)
	do _g.jk.lang.Vector:append(self.vector, value) end
	do return self end
end

function jk.lang.DynamicVector:appendString(value)
	do _g.jk.lang.Vector:append(self.vector, value) end
	do return self end
end

function jk.lang.DynamicVector:appendInteger(value)
	do _g.jk.lang.Vector:append(self.vector, _g.jk.lang.Integer:asObject(value)) end
	do return self end
end

function jk.lang.DynamicVector:appendLong(value)
	do _g.jk.lang.Vector:append(self.vector, _g.jk.lang.LongInteger:asObject(value)) end
	do return self end
end

function jk.lang.DynamicVector:appendBoolean(value)
	do _g.jk.lang.Vector:append(self.vector, _g.jk.lang.Boolean:asObject(value)) end
	do return self end
end

function jk.lang.DynamicVector:appendDouble(value)
	do _g.jk.lang.Vector:append(self.vector, _g.jk.lang.Double:asObject(value)) end
	do return self end
end

function jk.lang.DynamicVector:setObject(index, value)
	do _g.jk.lang.Vector:set(self.vector, index, value) end
	do return self end
end

function jk.lang.DynamicVector:setInteger(index, value)
	do _g.jk.lang.Vector:set(self.vector, index, _g.jk.lang.Integer:asObject(value)) end
	do return self end
end

function jk.lang.DynamicVector:setLong(index, value)
	do _g.jk.lang.Vector:set(self.vector, index, _g.jk.lang.LongInteger:asObject(value)) end
	do return self end
end

function jk.lang.DynamicVector:setBoolean(index, value)
	do _g.jk.lang.Vector:set(self.vector, index, _g.jk.lang.Boolean:asObject(value)) end
	do return self end
end

function jk.lang.DynamicVector:setDouble(index, value)
	do _g.jk.lang.Vector:set(self.vector, index, _g.jk.lang.Double:asObject(value)) end
	do return self end
end

function jk.lang.DynamicVector:get(index)
	do return _g.jk.lang.Vector:getAt(self.vector, index) end
end

function jk.lang.DynamicVector:getString(index, defval)
	local v = _g.jk.lang.String:asString(self:get(index))
	if v == nil then
		do return defval end
	end
	do return v end
end

function jk.lang.DynamicVector:getInteger(index, defval)
	local vv = self:get(index)
	if vv == nil then
		do return defval end
	end
	do return _g.jk.lang.Integer:asInteger(vv) end
end

function jk.lang.DynamicVector:getLongInteger(index, defval)
	local vv = self:get(index)
	if vv == nil then
		do return defval end
	end
	do return _g.jk.lang.LongInteger:asLong(vv) end
end

function jk.lang.DynamicVector:getBoolean(index, defval)
	local vv = self:get(index)
	if vv == nil then
		do return defval end
	end
	do return _g.jk.lang.Boolean:asBoolean(vv, false) end
end

function jk.lang.DynamicVector:getDouble(index, defval)
	local vv = self:get(index)
	if vv == nil then
		do return defval end
	end
	do return _g.jk.lang.Double:asDouble(vv) end
end

function jk.lang.DynamicVector:getMap(index)
	do return _vm:to_table_with_key(self:get(index), '_isType.jk.lang.DynamicMap') end
end

function jk.lang.DynamicVector:getVector(index)
	do return _vm:to_table_with_key(self:get(index), '_isType.jk.lang.DynamicVector') end
end

function jk.lang.DynamicVector:iterate()
	local v = _g.jk.lang.Vector:iterate(self.vector)
	do return v end
end

function jk.lang.DynamicVector:iterateReverse()
	local v = _g.jk.lang.Vector:iterateReverse(self.vector)
	do return v end
end

function jk.lang.DynamicVector:remove(index)
	do _g.jk.lang.Vector:remove(self.vector, index) end
end

function jk.lang.DynamicVector:removeValue(value)
	do _g.jk.lang.Vector:removeValue(self.vector, value) end
end

function jk.lang.DynamicVector:clear()
	do _g.jk.lang.Vector:clear(self.vector) end
end

function jk.lang.DynamicVector:contains(value)
	do return _g.jk.lang.Vector:contains(self.vector, value) end
end

function jk.lang.DynamicVector:getSize()
	do return _g.jk.lang.Vector:getSize(self.vector) end
end

function jk.lang.DynamicVector:setCapacity(capacity)
	do _g.jk.lang.Vector:setCapacity(self.vector, capacity) end
end

function jk.lang.DynamicVector:sort()
	do _g.jk.lang.Vector:sort(self.vector, function(a, b)
		do return _g.jk.lang.String:compare(_g.jk.lang.String:asString(a), _g.jk.lang.String:asString(b)) end
	end) end
end

function jk.lang.DynamicVector:sortWithComparer(comparer)
	if comparer == nil then
		do self:sort() end
		do return end
	end
	do _g.jk.lang.Vector:sort(self.vector, comparer) end
end

function jk.lang.DynamicVector:sortReverse()
	do _g.jk.lang.Vector:sortReverse(self.vector, function(a, b)
		do return _g.jk.lang.String:compare(_g.jk.lang.String:asString(a), _g.jk.lang.String:asString(b)) end
	end) end
end

function jk.lang.DynamicVector:sortReverseWithComparer(comparer)
	if comparer == nil then
		do self:sortReverse() end
		do return end
	end
	do _g.jk.lang.Vector:sortReverse(self.vector, comparer) end
end

jk.lang.Closable = {}

jk.lang.BooleanObject = {}

jk.lang.Vector = {}
jk.lang.Vector.__index = jk.lang.Vector
_vm:set_metatable(jk.lang.Vector, {})

function jk.lang.Vector._create()
	local v = _vm:set_metatable({}, jk.lang.Vector)
	return v
end

function jk.lang.Vector:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Vector'
	self['_isType.jk.lang.Vector'] = true
end

function jk.lang.Vector:_construct0()
	jk.lang.Vector._init(self)
	return self
end

function jk.lang.Vector:asVector(obj)
	local vo = _vm:to_table_with_key(obj, '_isType.jk.lang.VectorObject')
	if not (vo ~= nil) then
		do return nil end
	end
	do return vo:toVector() end
end

function jk.lang.Vector:asObjectVector(o)
	local it = _g.jk.lang.DynamicObject:iterate(o)
	if not (it ~= nil) then
		do return nil end
	end
	do
		local v = {}
		while true do
			local oo = it:next()
			if not (oo ~= nil) then
				do break end
			end
			do _g.jk.lang.Vector:append(v, oo) end
		end
		do return v end
	end
end

function jk.lang.Vector:forIterator(iterator)
	if not (iterator ~= nil) then
		do return nil end
	end
	do
		local v = {}
		while true do
			local o = iterator:next()
			if o == nil then
				do break end
			end
			do _g.jk.lang.Vector:append(v, o) end
		end
		do return v end
	end
end

function jk.lang.Vector:forArray(array)
	if not (array ~= nil) then
		do return nil end
	end
	do
		local v = {}
		do
			local n = 0
			while n < #array do
				do _g.jk.lang.Vector:append(v, array[n + 1]) end
				do n = n + 1 end
			end
		end
		do return v end
	end
end

function jk.lang.Vector:toVectorOfObject(collection)
	if not (collection ~= nil) then
		do return nil end
	end
	do
		local nvec = {}
		if collection ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(collection)
			do
				n = 0
				while n < m do
					local item = collection[n + 1]
					if item ~= nil then
						do _g.jk.lang.Vector:append(nvec, item) end
					end
					do n = n + 1 end
				end
			end
		end
		do return nvec end
	end
end

function jk.lang.Vector:dupObjectVector(vector)
	if not (vector ~= nil) then
		do return nil end
	end
	do
		local v = {}
		if vector ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(vector)
			do
				n = 0
				while n < m do
					local o = vector[n + 1]
					if o ~= nil then
						do _g.jk.lang.Vector:append(v, o) end
					end
					do n = n + 1 end
				end
			end
		end
		do return v end
	end
end

function jk.lang.Vector:contains(vector, item)
	if not (vector ~= nil) then
		do return false end
	end
	if vector ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(vector)
		do
			n = 0
			while n < m do
				local oo = vector[n + 1]
				if oo ~= nil then
					if item == oo then
						do return true end
					end
				end
				do n = n + 1 end
			end
		end
	end
	do return false end
end

function jk.lang.Vector:append(vector, item)
	do local sz = vector["n"] or 0 vector[sz + 1] = item vector["n"] = sz + 1 end
end

function jk.lang.Vector:prepend(vector, item)
	do _g.jk.lang.Vector:insert(vector, item, 0) end
end

function jk.lang.Vector:insert(vector, item, index)
	do local sz = vector["n"] or 0 _vm:insert_to_indexed_table(vector, index + 1, item) vector["n"] = sz + 1 end
end

function jk.lang.Vector:setCapacity(vector, capacity)
	if not (vector ~= nil) then
		do return end
	end
end

function jk.lang.Vector:setSize(vector, newSize)
	if not (vector ~= nil) then
		do return nil end
	end
	do
		local sz = newSize
		if sz < 0 then
			sz = 0
		end
		do
			local osz = _g.jk.lang.Vector:getSize(vector)
			if sz == osz then
				do return vector end
			end
			if sz < osz then
				do
					local n = osz - 1
					while n >= sz do
						do _g.jk.lang.Vector:remove(vector, n) end
						do n = n - 1 end
					end
				end
			else
				do
					local n = osz
					while n < sz do
						do _g.jk.lang.Vector:append(vector, nil) end
						do n = n + 1 end
					end
				end
			end
			do return vector end
		end
	end
end

function jk.lang.Vector:getSize(vector)
	if vector == nil then
		do return 0 end
	end
	do return vector["n"] or 0 end
end

function jk.lang.Vector:getAt(vector, index)
	do return _g.jk.lang.Vector:get(vector, index) end
end

function jk.lang.Vector:get(vector, index)
	if index < 0 or index >= _g.jk.lang.Vector:getSize(vector) then
		do return nil end
	end
	do return vector[index + 1] end
end

function jk.lang.Vector:getFirst(vector)
	do return _g.jk.lang.Vector:get(vector, 0) end
end

function jk.lang.Vector:getLast(vector)
	do return _g.jk.lang.Vector:get(vector, _g.jk.lang.Vector:getSize(vector) - 1) end
end

function jk.lang.Vector:set(vector, index, val)
	if index < 0 or index >= _g.jk.lang.Vector:getSize(vector) then
		do return end
	end
	do vector[index + 1]  = val end
end

function jk.lang.Vector:remove(vector, index)
	local sz = _g.jk.lang.Vector:getSize(vector)
	if index < 0 or index >= sz then
		do return nil end
	end
	do _vm:remove_from_indexed_table(vector, index+1) vector["n"] = sz - 1 end
end

function jk.lang.Vector:popFirst(vector)
	if vector == nil or _g.jk.lang.Vector:getSize(vector) < 1 then
		do return nil end
	end
	do
		local v = _g.jk.lang.Vector:get(vector, 0)
		do _g.jk.lang.Vector:removeFirst(vector) end
		do return v end
	end
end

function jk.lang.Vector:removeFirst(vector)
	if vector == nil or _g.jk.lang.Vector:getSize(vector) < 1 then
		do return end
	end
	do _g.jk.lang.Vector:remove(vector, 0) end
end

function jk.lang.Vector:popLast(vector)
	local sz = _g.jk.lang.Vector:getSize(vector)
	if vector == nil or sz < 1 then
		do return nil end
	end
	do
		local v = _g.jk.lang.Vector:get(vector, sz - 1)
		do _g.jk.lang.Vector:removeLast(vector) end
		do return v end
	end
end

function jk.lang.Vector:removeLast(vector)
	if vector == nil then
		do return end
	end
	do
		local sz = _g.jk.lang.Vector:getSize(vector)
		if sz < 1 then
			do return end
		end
		do _g.jk.lang.Vector:remove(vector, sz - 1) end
	end
end

function jk.lang.Vector:removeValue(vector, value)
	local n = 0
	do
		n = 0
		while n < _g.jk.lang.Vector:getSize(vector) do
			if vector[n + 1] == value then
				do _g.jk.lang.Vector:remove(vector, n) end
				do return n end
			end
			do n = n + 1 end
		end
	end
	do return -1 end
end

function jk.lang.Vector:clear(vector)
	do _vm:clear_table(vector) vector["n"] = 0 end
end

function jk.lang.Vector:isEmpty(vector)
	if vector == nil then
		do return true end
	end
	do
		local v = false
		do local sz = vector["n"] if sz == nil or sz < 1 then v = true end end
		do return v end
	end
end

function jk.lang.Vector:isNotEmpty(vector)
	do return not _g.jk.lang.Vector:isEmpty(vector) end
end

function jk.lang.Vector:removeRange(vector, index, count)
	do
		local n = 0
		while n < count do
			do _g.jk.lang.Vector:remove(vector, index) end
			do n = n + 1 end
		end
	end
end

jk.lang.Vector.VectorIterator = {}
jk.lang.Vector.VectorIterator.__index = jk.lang.Vector.VectorIterator
_vm:set_metatable(jk.lang.Vector.VectorIterator, {})

function jk.lang.Vector.VectorIterator._create()
	local v = _vm:set_metatable({}, jk.lang.Vector.VectorIterator)
	return v
end

function jk.lang.Vector.VectorIterator:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Vector.VectorIterator'
	self['_isType.jk.lang.Vector.VectorIterator'] = true
	self['_isType.jk.lang.Iterator'] = true
	self.vector = nil
	self.index = 0
	self.increment = 1
end

function jk.lang.Vector.VectorIterator:_construct0()
	jk.lang.Vector.VectorIterator._init(self)
	return self
end

function jk.lang.Vector.VectorIterator:_construct2(vector, increment)
	jk.lang.Vector.VectorIterator._init(self)
	self.vector = vector
	self.increment = increment
	if increment < 0 and vector ~= nil then
		self.index = _g.jk.lang.Vector:getSize(vector) - 1
	end
	return self
end

function jk.lang.Vector.VectorIterator:next()
	if self.vector == nil then
		do return nil end
	end
	if self.index < 0 or self.index >= _g.jk.lang.Vector:getSize(self.vector) then
		do return nil end
	end
	do
		local v = self.vector[self.index + 1]
		self.index = self.index + self.increment
		do return v end
	end
end

function jk.lang.Vector.VectorIterator:hasNext()
	if not (self.vector ~= nil) then
		do return false end
	end
	if not (self.index < _g.jk.lang.Vector:getSize(self.vector)) then
		do return false end
	end
	do return true end
end

function jk.lang.Vector:iterate(vector)
	do return _g.jk.lang.Vector.VectorIterator._construct2(_g.jk.lang.Vector.VectorIterator._create(), vector, 1) end
end

function jk.lang.Vector:iterateReverse(vector)
	do return _g.jk.lang.Vector.VectorIterator._construct2(_g.jk.lang.Vector.VectorIterator._create(), vector, -1) end
end

function jk.lang.Vector:sort(vector, comparer)
	if not (vector ~= nil) then
		do return end
	end
	do _vm:sort_table(vector, comparer) end
end

function jk.lang.Vector:sortReverse(vector, comparer)
	local cc = comparer
	do _g.jk.lang.Vector:sort(vector, function(a, b)
		do return -cc(a, b) end
	end) end
end

function jk.lang.Vector:sortAsStrings(vector)
	do _g.jk.lang.Vector:sort(vector, function(a, b)
		do return _g.jk.lang.String:compare(_g.jk.lang.String:asString(a), _g.jk.lang.String:asString(b)) end
	end) end
end

function jk.lang.Vector:sortAsStringsReverse(vector)
	do _g.jk.lang.Vector:sortReverse(vector, function(a, b)
		do return _g.jk.lang.String:compare(_g.jk.lang.String:asString(a), _g.jk.lang.String:asString(b)) end
	end) end
end

function jk.lang.Vector:reverse(vector)
	if not (vector ~= nil) then
		do return end
	end
	do
		local a = 0
		local b = _g.jk.lang.Vector:getSize(vector) - 1
		while a < b do
			local t = _g.jk.lang.Vector:getAt(vector, b)
			do _g.jk.lang.Vector:set(vector, b, _g.jk.lang.Vector:getAt(vector, a)) end
			do _g.jk.lang.Vector:set(vector, a, t) end
			do a = a + 1 end
			do b = b - 1 end
		end
	end
end

jk.lang.BooleanIterator = {}

jk.lang.KeyValueListForStrings = _g.jk.lang.KeyValueList._create()
jk.lang.KeyValueListForStrings.__index = jk.lang.KeyValueListForStrings
_vm:set_metatable(jk.lang.KeyValueListForStrings, {
	__index = _g.jk.lang.KeyValueList
})

function jk.lang.KeyValueListForStrings._create()
	local v = _vm:set_metatable({}, jk.lang.KeyValueListForStrings)
	return v
end

function jk.lang.KeyValueListForStrings:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.KeyValueListForStrings'
	self['_isType.jk.lang.KeyValueListForStrings'] = true
end

function jk.lang.KeyValueListForStrings:_construct0()
	jk.lang.KeyValueListForStrings._init(self)
	do _g.jk.lang.KeyValueList._construct0(self) end
	return self
end

jk.lang.Double = {}
jk.lang.Double.__index = jk.lang.Double
_vm:set_metatable(jk.lang.Double, {})

function jk.lang.Double._create()
	local v = _vm:set_metatable({}, jk.lang.Double)
	return v
end

function jk.lang.Double:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Double'
	self['_isType.jk.lang.Double'] = true
	self['_isType.jk.lang.DoubleObject'] = true
	self.value = 0.0
end

function jk.lang.Double:_construct0()
	jk.lang.Double._init(self)
	return self
end

function jk.lang.Double:forValue(value)
	do return _g.jk.lang.Double:asObject(value) end
end

function jk.lang.Double:asObject(value)
	local v = _g.jk.lang.Double._construct0(_g.jk.lang.Double._create())
	do v:setValue(value) end
	do return v end
end

function jk.lang.Double:asDouble(obj)
	if not (obj ~= nil) then
		do return 0.0 end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		do return obj end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.DoubleObject') ~= nil) then
		local od = obj
		do return od:toDouble() end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		local v = _util:convert_to_integer(obj)
		do return v end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.IntegerObject') ~= nil) then
		local oi = obj
		do return oi:toInteger() end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		local v = _util:convert_to_integer(obj)
		do return v end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.LongIntegerObject') ~= nil) then
		local oi = obj
		do return oi:toLong() end
	end
	if (_vm:get_variable_type(obj) == 'string') then
		do return _g.jk.lang.String:toDouble(obj) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.StringObject') ~= nil) then
		do return _g.jk.lang.String:toDouble(obj:toString()) end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		local v = obj
		do return v end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.CharacterObject') ~= nil) then
		local oc = obj
		do return oc:toCharacter() end
	end
	if (_vm:get_variable_type(obj) == 'boolean') then
		if obj == true then
			do return 1.0 end
		end
		do return 0.0 end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.BooleanObject') ~= nil) then
		if obj:toBoolean() then
			do return 1.0 end
		end
		do return 0.0 end
	end
	do return 0.0 end
end

function jk.lang.Double:longBitsToDouble(vv)
	_io:write_to_stdout("[jk.lang.Double.longBitsToDouble] (Double.sling:97:3): Not implemented" .. "\n")
	do return 0.0 end
end

function jk.lang.Double:doubleToLongBits(vv)
	_io:write_to_stdout("[jk.lang.Double.doubleToLongBits] (Double.sling:111:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.lang.Double:add(amount)
	self.value = self.value + amount
end

function jk.lang.Double:toDouble()
	do return self.value end
end

function jk.lang.Double:getValue()
	do return self.value end
end

function jk.lang.Double:setValue(v)
	self.value = v
	do return self end
end

jk.lang.Array = {}
jk.lang.Array.__index = jk.lang.Array
_vm:set_metatable(jk.lang.Array, {})

function jk.lang.Array._create()
	local v = _vm:set_metatable({}, jk.lang.Array)
	return v
end

function jk.lang.Array:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Array'
	self['_isType.jk.lang.Array'] = true
end

function jk.lang.Array:_construct0()
	jk.lang.Array._init(self)
	return self
end

jk.lang.Array.MyArrayObject = {}
jk.lang.Array.MyArrayObject.__index = jk.lang.Array.MyArrayObject
_vm:set_metatable(jk.lang.Array.MyArrayObject, {})

function jk.lang.Array.MyArrayObject._create()
	local v = _vm:set_metatable({}, jk.lang.Array.MyArrayObject)
	return v
end

function jk.lang.Array.MyArrayObject:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Array.MyArrayObject'
	self['_isType.jk.lang.Array.MyArrayObject'] = true
	self['_isType.jk.lang.ArrayObject'] = true
	self['_isType.jk.lang.ObjectWithSize'] = true
	self.array = nil
end

function jk.lang.Array.MyArrayObject:_construct0()
	jk.lang.Array.MyArrayObject._init(self)
	return self
end

function jk.lang.Array.MyArrayObject:toArray()
	do return self.array end
end

function jk.lang.Array.MyArrayObject:getSize()
	do return #self.array end
end

function jk.lang.Array.MyArrayObject:getArray()
	do return self.array end
end

function jk.lang.Array.MyArrayObject:setArray(v)
	self.array = v
	do return self end
end

function jk.lang.Array:asObject(array)
	local v = _g.jk.lang.Array.MyArrayObject._construct0(_g.jk.lang.Array.MyArrayObject._create())
	do v:setArray(array) end
	do return v end
end

function jk.lang.Array:isEmpty(array)
	if array == nil then
		do return true end
	end
	if #array < 1 then
		do return true end
	end
	do return false end
end

function jk.lang.Array:isNotEmpty(array)
	do return not _g.jk.lang.Array:isEmpty(array) end
end

function jk.lang.Array:contains(array, element)
	if not (array ~= nil) then
		do return false end
	end
	if array ~= nil then
		local n = 0
		local m = #array
		do
			n = 0
			while n < m do
				local oo = array[n + 1]
				if oo ~= nil then
					if element == oo then
						do return true end
					end
				end
				do n = n + 1 end
			end
		end
	end
	do return false end
end

function jk.lang.Array:toVector(array)
	do return _g.jk.lang.Vector:forArray(array) end
end

function jk.lang.Array:copyFrom(array, src, soffset, doffset, size)
	if not (array ~= nil) then
		do return end
	end
	if not (src ~= nil) then
		do return end
	end
	do
		local n = 0
		while n < size do
			array[doffset + n + 1] = src[soffset + n + 1]
			do n = n + 1 end
		end
	end
end

jk.lang.Matrix = {}
jk.lang.Matrix.__index = jk.lang.Matrix
_vm:set_metatable(jk.lang.Matrix, {})

function jk.lang.Matrix._create()
	local v = _vm:set_metatable({}, jk.lang.Matrix)
	return v
end

function jk.lang.Matrix:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Matrix'
	self['_isType.jk.lang.Matrix'] = true
	self.vector = nil
	self.columnCount = 0
end

function jk.lang.Matrix:_construct0()
	jk.lang.Matrix._init(self)
	return self
end

function jk.lang.Matrix:_construct2(rowSize, columnSize)
	jk.lang.Matrix._init(self)
	self.vector = {}
	do self:setSize(rowSize, columnSize) end
	return self
end

function jk.lang.Matrix:set(row, column, val)
	if not (self.vector ~= nil) then
		do return end
	end
	if not (row >= 0 or column >= 0) then
		do return end
	end
	do
		local size = row * self.columnCount + column
		if not (_g.jk.lang.Vector:getSize(self.vector) > size) then
			do return end
		end
		do _g.jk.lang.Vector:set(self.vector, size, val) end
	end
end

function jk.lang.Matrix:get(row, column)
	if not (self.vector ~= nil) then
		do return nil end
	end
	if not (row >= 0 or column >= 0) then
		do return nil end
	end
	do
		local size = row * self.columnCount + column
		if not (_g.jk.lang.Vector:getSize(self.vector) > size) then
			do return nil end
		end
		do return _g.jk.lang.Vector:get(self.vector, size) end
	end
end

function jk.lang.Matrix:setSize(rowSize, colSize)
	if not (self.vector ~= nil) then
		do return nil end
	end
	self.columnCount = colSize
	do _g.jk.lang.Vector:setSize(self.vector, rowSize * colSize) end
	do return self end
end

function jk.lang.Matrix:getRowCount()
	if not (self.vector ~= nil) then
		do return 0 end
	end
	do return _g.jk.lang.Vector:getSize(self.vector) / self.columnCount end
end

function jk.lang.Matrix:getColumnCount()
	if not (self.vector ~= nil) then
		do return 0 end
	end
	do return self.columnCount end
end

jk.lang.Boolean = {}
jk.lang.Boolean.__index = jk.lang.Boolean
_vm:set_metatable(jk.lang.Boolean, {})

function jk.lang.Boolean._create()
	local v = _vm:set_metatable({}, jk.lang.Boolean)
	return v
end

function jk.lang.Boolean:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.Boolean'
	self['_isType.jk.lang.Boolean'] = true
	self['_isType.jk.lang.BooleanObject'] = true
	self.value = false
end

function jk.lang.Boolean:_construct0()
	jk.lang.Boolean._init(self)
	return self
end

function jk.lang.Boolean:asObject(value)
	local v = _g.jk.lang.Boolean._construct0(_g.jk.lang.Boolean._create())
	do v:setValue(value) end
	do return v end
end

function jk.lang.Boolean:asBoolean(obj, defaultValue)
	if obj == nil then
		do return false end
	end
	if (_vm:get_variable_type(obj) == 'boolean') then
		do return obj end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.BooleanObject') ~= nil) then
		local bo = obj
		do return bo:toBoolean() end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		if _util:convert_to_integer(obj) == 0 then
			do return false end
		end
		do return true end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.IntegerObject') ~= nil) then
		if obj:toInteger() == 0 then
			do return false end
		end
		do return true end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		if _util:convert_to_integer(obj) == 0 then
			do return false end
		end
		do return true end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.LongIntegerObject') ~= nil) then
		if obj:toLong() == 0 then
			do return false end
		end
		do return true end
	end
	if (_vm:get_variable_type(obj) == 'string') then
		local str = _g.jk.lang.String:toLowerCase(obj)
		if str == "yes" or str == "true" or str == "1" then
			do return true end
		end
		if str == "no" or str == "false" or str == "0" then
			do return false end
		end
		do return defaultValue end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.StringObject') ~= nil) then
		local str = obj:toString()
		if str ~= nil then
			str = _g.jk.lang.String:toLowerCase(str)
			if str == "yes" or str == "true" or str == "1" then
				do return true end
			end
			if str == "no" or str == "false" or str == "0" then
				do return false end
			end
		end
		do return defaultValue end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		if obj == 0.0 then
			do return false end
		end
		do return true end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.DoubleObject') ~= nil) then
		if obj:toDouble() == 0.0 then
			do return false end
		end
		do return true end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		if _util:convert_to_integer(obj) == 0 then
			do return false end
		end
		do return true end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.CharacterObject') ~= nil) then
		if _util:convert_to_integer(obj:toCharacter()) == 0 then
			do return false end
		end
		do return true end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.ObjectWithSize') ~= nil) then
		local sz = obj:getSize()
		if sz == 0 then
			do return false end
		end
		do return true end
	end
	do return defaultValue end
end

function jk.lang.Boolean:toBoolean()
	do return self.value end
end

function jk.lang.Boolean:getValue()
	do return self.value end
end

function jk.lang.Boolean:setValue(v)
	self.value = v
	do return self end
end

jk.lang.CharacterIteratorForString = _g.jk.lang.CharacterDecoder._create()
jk.lang.CharacterIteratorForString.__index = jk.lang.CharacterIteratorForString
_vm:set_metatable(jk.lang.CharacterIteratorForString, {
	__index = _g.jk.lang.CharacterDecoder
})

function jk.lang.CharacterIteratorForString._create()
	local v = _vm:set_metatable({}, jk.lang.CharacterIteratorForString)
	return v
end

function jk.lang.CharacterIteratorForString:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.CharacterIteratorForString'
	self['_isType.jk.lang.CharacterIteratorForString'] = true
	self['_isType.jk.lang.Duplicateable'] = true
	self.string = nil
	self.stringSize = 0
	self.currentPosition = -1
end

function jk.lang.CharacterIteratorForString:_construct0()
	jk.lang.CharacterIteratorForString._init(self)
	do _g.jk.lang.CharacterDecoder._construct0(self) end
	return self
end

function jk.lang.CharacterIteratorForString:forString(value)
	local v = _g.jk.lang.CharacterIteratorForString._construct0(_g.jk.lang.CharacterIteratorForString._create())
	do v:setString(value) end
	do return v end
end

function jk.lang.CharacterIteratorForString:moveToPreviousByte()
	if self.currentPosition < 1 then
		do return false end
	end
	do self.currentPosition = self.currentPosition - 1 end
	do return true end
end

function jk.lang.CharacterIteratorForString:moveToNextByte()
	local n = self.currentPosition + 1
	self.currentPosition = n
	if n >= self.stringSize then
		do return false end
	end
	do return true end
end

function jk.lang.CharacterIteratorForString:getCurrentByte()
	do return _util:get_byte_from_string(self.string, self.currentPosition) end
end

function jk.lang.CharacterIteratorForString:getCurrentPosition()
	do return self.currentPosition end
end

function jk.lang.CharacterIteratorForString:setCurrentPosition(position)
	if position < 0 then
		self.current = 0
		self.currentPosition = -1
	else
		self.currentPosition = position + 1
		do self:doMoveToPreviousChar() end
	end
end

function jk.lang.CharacterIteratorForString:duplicate()
	local v = _g.jk.lang.CharacterIteratorForString._construct0(_g.jk.lang.CharacterIteratorForString._create())
	do _g.jk.lang.CharacterDecoder.copyTo(self, v) end
	v.string = self.string
	v.stringSize = self.stringSize
	v.currentPosition = self.currentPosition
	do return v end
end

function jk.lang.CharacterIteratorForString:setString(value)
	do self:resetDecoder() end
	self.string = value
	self.stringSize = _util:get_string_length(value)
	self.currentPosition = -1
end

jk.lang.String = {}
jk.lang.String.__index = jk.lang.String
_vm:set_metatable(jk.lang.String, {})

function jk.lang.String._create()
	local v = _vm:set_metatable({}, jk.lang.String)
	return v
end

function jk.lang.String:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.lang.String'
	self['_isType.jk.lang.String'] = true
end

function jk.lang.String:_construct0()
	jk.lang.String._init(self)
	return self
end

function jk.lang.String:asString(obj)
	if not (obj ~= nil) then
		do return nil end
	end
	if (_vm:get_variable_type(obj) == 'string') then
		do return obj end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.StringObject') ~= nil) then
		local os = obj
		do return os:toString() end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		do return _g.jk.lang.String:forInteger(_util:convert_to_integer(obj)) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.IntegerObject') ~= nil) then
		do return _g.jk.lang.String:forInteger(obj:toInteger()) end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		do return _g.jk.lang.String:forLongInteger(_util:convert_to_integer(obj)) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.LongIntegerObject') ~= nil) then
		do return _g.jk.lang.String:forLongInteger(obj:toLong()) end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		do return _g.jk.lang.String:forDouble(obj) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.DoubleObject') ~= nil) then
		do return _g.jk.lang.String:forDouble(obj:toDouble()) end
	end
	if (_vm:get_variable_type(obj) == 'boolean') then
		do return _g.jk.lang.String:forBoolean(obj) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.BooleanObject') ~= nil) then
		do return _g.jk.lang.String:forBoolean(obj:toBoolean()) end
	end
	if (_vm:get_variable_type(obj) == 'number') then
		do return _g.jk.lang.String:forCharacter(obj) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.CharacterObject') ~= nil) then
		do return _g.jk.lang.String:forCharacter(obj:toCharacter()) end
	end
	if _util:is_buffer(obj) then
		do return _g.jk.lang.String:forBufferHex(obj) end
	end
	if (_vm:to_table_with_key(obj, '_isType.jk.lang.BufferObject') ~= nil) then
		local v = obj:toBuffer()
		if not (v ~= nil) then
			do return "" end
		end
		do return _g.jk.lang.String:forBufferHex(v) end
	end
	do return nil end
end

function jk.lang.String:forObject(obj)
	do return _g.jk.lang.String:asString(obj) end
end

function jk.lang.String:safeString(str)
	if not (str ~= nil) then
		do return "" end
	end
	do return str end
end

function jk.lang.String:isEmpty(str)
	if not (str ~= nil) then
		do return true end
	end
	if _util:get_string_length(str) < 1 then
		do return true end
	end
	do return false end
end

function jk.lang.String:isNotEmpty(str)
	do return not _g.jk.lang.String:isEmpty(str) end
end

function jk.lang.String:forBuffer(data, encoding)
	if not (data ~= nil) then
		do return nil end
	end
	if _g.jk.lang.String:equalsIgnoreCase("UTF8", encoding) or _g.jk.lang.String:equalsIgnoreCase("UTF-8", encoding) then
		do return _g.jk.lang.String:forUTF8Buffer(data) end
	end
	if _g.jk.lang.String:equalsIgnoreCase("UCS2", encoding) or _g.jk.lang.String:equalsIgnoreCase("UCS-2", encoding) then
		do return _g.jk.lang.String:forUCS2Buffer(data) end
	end
	if _g.jk.lang.String:equalsIgnoreCase("ASCII", encoding) then
		do return _g.jk.lang.String:forASCIIBuffer(data) end
	end
	do return nil end
end

function jk.lang.String:forASCIIBuffer(data)
	if not (data ~= nil) then
		do return nil end
	end
	do return _util:convert_buffer_ascii_to_string(data) end
end

function jk.lang.String:forUTF8Buffer(data)
	if not (data ~= nil) then
		do return nil end
	end
	do return _util:convert_buffer_to_string(data) end
end

function jk.lang.String:forUCS2Buffer(data)
	if data == nil then
		do return nil end
	end
	_io:write_to_stdout("[jk.lang.String.forUCS2Buffer] (String.sling:311:3): Not implemented." .. "\n")
	do return nil end
end

function jk.lang.String:forCharArray(chars, offset, count)
	if not (chars ~= nil) then
		do return nil end
	end
	do
		local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		local sz = #chars
		do
			local n = 0
			while n < count and n + offset < sz do
				do sb:appendCharacter(chars[n + offset + 1]) end
				do n = n + 1 end
			end
		end
		do return sb:toString() end
	end
end

function jk.lang.String:forBoolean(vv)
	if vv == true then
		do return "true" end
	end
	do return "false" end
end

function jk.lang.String:forInteger(vv)
	do return _util:create_decimal_string_for_integer(vv) end
end

function jk.lang.String:forLongInteger(vv)
	do return _util:create_decimal_string_for_integer(vv) end
end

function jk.lang.String:forIntegerWithPadding(vv, length, paddingString)
	local r = _g.jk.lang.String:forInteger(vv)
	if not (r ~= nil) then
		do return nil end
	end
	do
		local ll = _g.jk.lang.String:getLength(r)
		if ll >= length then
			do return r end
		end
		do
			local ps = paddingString
			if ps == nil then
				ps = "0"
			end
			do
				local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
				local n = 0
				do
					n = 0
					while n < length - ll do
						do sb:appendString(ps) end
						do n = n + 1 end
					end
				end
				do sb:appendString(r) end
				do return sb:toString() end
			end
		end
	end
end

function jk.lang.String:forIntegerHex(vv, minlength)
	local v = nil
	v = _util:create_hex_string_for_integer(vv)
	if not (v ~= nil) then
		do return nil end
	end
	if minlength > 0 then
		while _g.jk.lang.String:getLength(v) < minlength do
			v = "0" .. _g.jk.lang.String:safeString(v)
		end
	end
	do return v end
end

function jk.lang.String:forLongIntegerHex(vv, minlength)
	local v = nil
	v = _util:create_hex_string_for_integer(vv)
	if not (v ~= nil) then
		do return nil end
	end
	if minlength > 0 then
		while _g.jk.lang.String:getLength(v) < minlength do
			v = "0" .. _g.jk.lang.String:safeString(v)
		end
	end
	do return v end
end

function jk.lang.String:forIntegerOctal(vv)
	local v = nil
	v = _util:create_octal_string_for_integer(vv)
	do return v end
end

function jk.lang.String:forIntegerBinary(vv)
	local v = nil
	_io:write_to_stdout("[jk.lang.String.forIntegerBinary] (String.sling:605:3): Not implemented" .. "\n")
	do return nil end
end

function jk.lang.String:forBufferHex(buffer)
	local size = _g.jk.lang.Buffer:getSize(buffer)
	if not (size ~= 0) then
		do return nil end
	end
	do
		local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		local p = 0
		while p < size do
			local s = _g.jk.lang.String:forIntegerHex(_g.jk.lang.Buffer:getByte(buffer, p), 0)
			if _g.jk.lang.String:getLength(s) < 2 then
				do sb:appendCharacter(48) end
			end
			do sb:appendString(s) end
			do p = p + 1 end
		end
		do return sb:toString() end
	end
end

function jk.lang.String:forCharacter(vv)
	if vv < 128 then
		do return _util:create_string_for_byte(vv) end
	end
	if vv < 2048 then
		local v1 = _vm:bitwise_or(192, _vm:bitwise_right_shift(vv, 6))
		local v2 = _vm:bitwise_or(128, _vm:bitwise_and(vv, 63))
		do return _util:create_string_for_byte(v1) .. _util:create_string_for_byte(v2) end
	end
	if vv < 65536 then
		local v1 = _vm:bitwise_or(224, _vm:bitwise_right_shift(vv, 12))
		local v2 = _vm:bitwise_or(128, _vm:bitwise_and(_vm:bitwise_right_shift(vv, 6), 63))
		local v3 = _vm:bitwise_or(128, _vm:bitwise_and(vv, 63))
		do return _util:create_string_for_byte(v1) .. _util:create_string_for_byte(v2) .. _util:create_string_for_byte(v3) end
	end
	do
		local v1 = _vm:bitwise_or(240, _vm:bitwise_right_shift(vv, 18))
		local v2 = _vm:bitwise_or(128, _vm:bitwise_and(_vm:bitwise_right_shift(vv, 12), 63))
		local v3 = _vm:bitwise_or(128, _vm:bitwise_and(_vm:bitwise_right_shift(vv, 6), 63))
		local v4 = _vm:bitwise_or(128, _vm:bitwise_and(vv, 63))
		do return _util:create_string_for_byte(v1) .. _util:create_string_for_byte(v2) .. _util:create_string_for_byte(v3) .. _util:create_string_for_byte(v4) end
	end
end

function jk.lang.String:forFloat(vv)
	do return _util:create_string_for_float(vv) end
end

function jk.lang.String:forDouble(vv)
	do return _util:create_string_for_float(vv) end
end

function jk.lang.String:toUTF8Buffer(str)
	if not (str ~= nil) then
		do return nil end
	end
	do return _util:convert_string_to_buffer(str) end
end

function jk.lang.String:toBuffer(str, charset)
	if not (str ~= nil) then
		do return nil end
	end
	if not (charset ~= nil) then
		do return nil end
	end
	if _g.jk.lang.String:equalsIgnoreCase("UTF8", charset) or _g.jk.lang.String:equalsIgnoreCase("UTF-8", charset) then
		do return _g.jk.lang.String:toUTF8Buffer(str) end
	end
	do
		local bytes = _g.jk.lang.String:getBytesUnsigned(str, charset)
		if not (bytes ~= nil) then
			do return nil end
		end
		do
			local c = #bytes
			local bb = _util:allocate_buffer(c)
			local n = 0
			do
				n = 0
				while n < c do
					do _g.jk.lang.Buffer:setByte(bb, n, bytes[n + 1]) end
					do n = n + 1 end
				end
			end
			do return bb end
		end
	end
end

function jk.lang.String:getBytesUnsignedUTF8(str)
	do return _g.jk.lang.String:getBytesUnsigned(str, "UTF-8") end
end

function jk.lang.String:getBytesUnsigned(str, charset)
	if not (str ~= nil) then
		do return nil end
	end
	if not (charset ~= nil) then
		do return nil end
	end
	_io:write_to_stdout("[jk.lang.String.getBytesUnsigned] (String.sling:937:3): Not implemented" .. "\n")
	do return nil end
end

function jk.lang.String:getBytesSignedUTF8(str)
	do return _g.jk.lang.String:getBytesSigned(str, "UTF-8") end
end

function jk.lang.String:getBytesSigned(str, charset)
	if str == nil or charset == nil then
		do return nil end
	end
	_io:write_to_stdout("[jk.lang.String.getBytesSigned] (String.sling:987:3): Not implemented" .. "\n")
	do return nil end
end

function jk.lang.String:getLength(str)
	if str == nil then
		do return 0 end
	end
	do return _util:get_utf8_character_count(str) end
end

function jk.lang.String:appendString(str1, str2)
	if str1 == nil then
		do return str2 end
	end
	if str2 == nil then
		do return str1 end
	end
	do return str1 .. str2 end
end

function jk.lang.String:appendInteger(str, intvalue)
	do return _g.jk.lang.String:appendString(str, _g.jk.lang.String:forInteger(intvalue)) end
end

function jk.lang.String:appendCharacter(str, charvalue)
	do return _g.jk.lang.String:appendString(str, _g.jk.lang.String:forCharacter(charvalue)) end
end

function jk.lang.String:appendFloat(str, floatvalue)
	do return _g.jk.lang.String:appendString(str, _g.jk.lang.String:forFloat(floatvalue)) end
end

function jk.lang.String:appendDouble(str, doublevalue)
	do return _g.jk.lang.String:appendString(str, _g.jk.lang.String:forDouble(doublevalue)) end
end

function jk.lang.String:appendBoolean(str, boolvalue)
	do return _g.jk.lang.String:appendString(str, _g.jk.lang.String:forBoolean(boolvalue)) end
end

function jk.lang.String:toLowerCase(str)
	if not (str ~= nil) then
		do return nil end
	end
	do return _util:change_string_to_lowercase(str) end
end

function jk.lang.String:toUpperCase(str)
	if not (str ~= nil) then
		do return nil end
	end
	do return _util:change_string_to_uppercase(str) end
end

function jk.lang.String:capitalize(str)
	if not (str ~= nil) then
		do return nil end
	end
	do
		local c = _g.jk.lang.String:getChar(str, 0)
		if _g.jk.lang.Character:isLowercaseAlpha(c) == false then
			do return str end
		end
		do return _g.jk.lang.String:safeString(_g.jk.lang.String:forCharacter(_g.jk.lang.Character:toUppercase(c))) .. _g.jk.lang.String:safeString(_g.jk.lang.String:getEndOfString(str, 1)) end
	end
end

function jk.lang.String:getChar(str, index)
	if str == nil or index < 0 then
		do return 0 end
	end
	do
		local it = _g.jk.lang.String:iterate(str)
		local n = 0
		while it ~= nil do
			local c = it:getNextChar()
			if _g.jk.lang.Character:isEOF(c) then
				do break end
			end
			if n == index then
				do return c end
			end
			do n = n + 1 end
		end
		do return 0 end
	end
end

function jk.lang.String:equals(str1, str2)
	if str1 == nil and str2 == nil then
		do return true end
	end
	if not (str1 ~= nil and str2 ~= nil) then
		do return false end
	end
	do return str1 == str2 end
end

function jk.lang.String:isNotEqual(str1, str2)
	do return not _g.jk.lang.String:equals(str1, str2) end
end

function jk.lang.String:equalsIgnoreCase(str1, str2)
	if str1 == nil and str2 == nil then
		do return true end
	end
	if not (str1 ~= nil and str2 ~= nil) then
		do return false end
	end
	do return 0 == _util:compare_string_ignore_case(str1, str2) end
end

function jk.lang.String:compare(str1, str2)
	if str1 == nil or str2 == nil then
		do return 0 end
	end
	do
		local it1 = _g.jk.lang.String:iterate(str1)
		local it2 = _g.jk.lang.String:iterate(str2)
		if it1 == nil or it2 == nil then
			do return 0 end
		end
		while true do
			if it1:hasEnded() and it2:hasEnded() then
				do break end
			end
			if it1:hasEnded() then
				do return -1 end
			end
			if it2:hasEnded() then
				do return 1 end
			end
			do
				local c1 = it1:getNextChar()
				local c2 = it2:getNextChar()
				if c1 < c2 then
					do return -1 end
				end
				if c1 > c2 then
					do return 1 end
				end
			end
		end
		do return 0 end
	end
end

function jk.lang.String:compareToIgnoreCase(str1, str2)
	if str1 == nil or str2 == nil then
		do return 0 end
	end
	do
		local it1 = _g.jk.lang.String:iterate(str1)
		local it2 = _g.jk.lang.String:iterate(str2)
		if it1 == nil or it2 == nil then
			do return 0 end
		end
		while true do
			if it1:hasEnded() and it2:hasEnded() then
				do break end
			end
			if it1:hasEnded() then
				do return -1 end
			end
			if it2:hasEnded() then
				do return 1 end
			end
			do
				local c1 = _g.jk.lang.Character:toLowercase(it1:getNextChar())
				local c2 = _g.jk.lang.Character:toLowercase(it2:getNextChar())
				if c1 < c2 then
					do return -1 end
				end
				if c1 > c2 then
					do return 1 end
				end
			end
		end
		do return 0 end
	end
end

function jk.lang.String:getHashCode(str)
	if str == nil then
		do return 0 end
	end
	do
		local hash = 0
		local it = _g.jk.lang.String:iterate(str)
		while it ~= nil do
			local ch = it:getNextChar()
			if _g.jk.lang.Character:isEOF(ch) then
				do break end
			end
			hash = _vm:bitwise_left_shift(hash, 5) - hash + ch
			hash = _vm:bitwise_and(hash, hash)
		end
		do return hash end
	end
end

function jk.lang.String:getIndexOfCharacter(str, c, start)
	if str == nil or c == 0 then
		do return -1 end
	end
	do return _util:get_index_of_character(str, c, start) end
end

function jk.lang.String:getIndexOfString(str, s, start)
	if str == nil or s == nil then
		do return -1 end
	end
	if _g.jk.lang.String:isEmpty(s) then
		do return 0 end
	end
	do return _util:get_index_of_substring(str, s, start) end
end

function jk.lang.String:getLastIndexOfCharacter(str, c, start)
	if str == nil then
		do return -1 end
	end
	do
		local ss = start
		if ss < 0 then
			ss = 0
		end
		do
			local ii = _g.jk.lang.String:getIndexOfCharacter(str, c, ss)
			if ii >= 0 then
				while true do
					local ix = _g.jk.lang.String:getIndexOfCharacter(str, c, ii + 1)
					if ix < 0 then
						do break end
					end
					ii = ix
				end
			end
			do return ii end
		end
	end
end

function jk.lang.String:getLastIndexOfString(str, s, start)
	if str == nil then
		do return -1 end
	end
	do
		local ss = start
		if ss < 0 then
			ss = 0
		end
		do
			local ii = _g.jk.lang.String:getIndexOfString(str, s, ss)
			if ii >= 0 then
				while true do
					local ix = _g.jk.lang.String:getIndexOfString(str, s, ii + 1)
					if ix < 0 then
						do break end
					end
					ii = ix
				end
			end
			do return ii end
		end
	end
end

function jk.lang.String:getEndOfString(str, start)
	if not (str ~= nil) then
		do return nil end
	end
	do
		local ss = start
		if ss < 0 then
			ss = 0
		end
		do return _util:get_substring(str, ss, #str) end
	end
end

function jk.lang.String:getSubString(str, start, length)
	if not (str ~= nil) then
		do return nil end
	end
	do
		local ss = start
		if ss < 0 then
			ss = 0
		end
		do
			local v = _util:get_substring(str, ss, ss+length)
			if not (v ~= nil) then
				v = ""
			end
			do return v end
		end
	end
end

function jk.lang.String:contains(str1, str2)
	if not (str1 ~= nil) then
		do return false end
	end
	if not (str2 ~= nil) then
		do return false end
	end
	if _g.jk.lang.String:getIndexOfString(str1, str2, 0) >= 0 then
		do return true end
	end
	do return false end
end

function jk.lang.String:startsWith(str1, str2, offset)
	if not (str1 ~= nil) then
		do return false end
	end
	if not (str2 ~= nil) then
		do return false end
	end
	do
		local nstr = nil
		if offset > 0 then
			nstr = _g.jk.lang.String:getEndOfString(str1, offset)
		else
			nstr = str1
		end
		do return _util:string_starts_with(str1, str2, offset) end
	end
end

function jk.lang.String:startsWithAny(str, strings)
	if strings ~= nil then
		local n = 0
		local m = #strings
		do
			n = 0
			while n < m do
				local str2 = (function(o)
					if (_vm:get_variable_type(o) == 'string') then
						do return o end
					end
					do return nil end
				end)(strings[n + 1])
				if str2 ~= nil then
					if _g.jk.lang.String:startsWith(str, str2, 0) then
						do return str2 end
					end
				end
				do n = n + 1 end
			end
		end
	end
	do return nil end
end

function jk.lang.String:startsWithIgnoreCase(str1, str2, offset)
	do return _g.jk.lang.String:startsWith(_g.jk.lang.String:toLowerCase(str1), _g.jk.lang.String:toLowerCase(str2), offset) end
end

function jk.lang.String:startsWithAnyIgnoreCase(str, strings)
	local ostr = _g.jk.lang.String:toLowerCase(str)
	if strings ~= nil then
		local n = 0
		local m = #strings
		do
			n = 0
			while n < m do
				local str2 = (function(o)
					if (_vm:get_variable_type(o) == 'string') then
						do return o end
					end
					do return nil end
				end)(strings[n + 1])
				if str2 ~= nil then
					if _g.jk.lang.String:startsWith(ostr, _g.jk.lang.String:toLowerCase(str2), 0) then
						do return str2 end
					end
				end
				do n = n + 1 end
			end
		end
	end
	do return nil end
end

function jk.lang.String:endsWith(str1, str2)
	if not (str1 ~= nil) then
		do return false end
	end
	if not (str2 ~= nil) then
		do return false end
	end
	do
		local s1 = _util:get_utf8_character_count(str1)
		do return _util:get_substring(str1, s1 -_util:get_utf8_character_count(str2), s1) == str2 end
	end
end

function jk.lang.String:endsWithAny(str, strings)
	if strings ~= nil then
		local n = 0
		local m = #strings
		do
			n = 0
			while n < m do
				local str2 = (function(o)
					if (_vm:get_variable_type(o) == 'string') then
						do return o end
					end
					do return nil end
				end)(strings[n + 1])
				if str2 ~= nil then
					if _g.jk.lang.String:endsWith(str, str2) then
						do return str2 end
					end
				end
				do n = n + 1 end
			end
		end
	end
	do return nil end
end

function jk.lang.String:endsWithIgnoreCase(str1, str2)
	do return _g.jk.lang.String:endsWith(_g.jk.lang.String:toLowerCase(str1), _g.jk.lang.String:toLowerCase(str2)) end
end

function jk.lang.String:endsWithAnyIgnoreCase(str, strings)
	local ostr = _g.jk.lang.String:toLowerCase(str)
	if strings ~= nil then
		local n = 0
		local m = #strings
		do
			n = 0
			while n < m do
				local str2 = (function(o)
					if (_vm:get_variable_type(o) == 'string') then
						do return o end
					end
					do return nil end
				end)(strings[n + 1])
				if str2 ~= nil then
					if _g.jk.lang.String:endsWith(ostr, _g.jk.lang.String:toLowerCase(str2)) then
						do return str2 end
					end
				end
				do n = n + 1 end
			end
		end
	end
	do return nil end
end

function jk.lang.String:strip(str)
	if not (str ~= nil) then
		do return nil end
	end
	do return _g.jk.lang.String:stripFromStart(_g.jk.lang.String:stripFromEnd(str)) end
end

function jk.lang.String:stripFromEnd(str)
	if not (str ~= nil) then
		do return nil end
	end
	do
		local ll = _g.jk.lang.String:getLength(str)
		if ll < 1 then
			do return str end
		end
		do
			local n = 0
			while true do
				local c = _g.jk.lang.String:getChar(str, ll - 1 - n)
				if c == 32 or c == 9 or c == 13 or c == 10 then
					do n = n + 1 end
				else
					do break end
				end
			end
			if n < 1 then
				do return str end
			end
			do return _g.jk.lang.String:getSubString(str, 0, ll - n) end
		end
	end
end

function jk.lang.String:stripFromStart(str)
	if not (str ~= nil) then
		do return nil end
	end
	do
		local n = 0
		while true do
			local c = _g.jk.lang.String:getChar(str, n)
			if c == 32 or c == 9 or c == 13 or c == 10 then
				do n = n + 1 end
			else
				do break end
			end
		end
		if n < 1 then
			do return str end
		end
		do return _g.jk.lang.String:getEndOfString(str, n) end
	end
end

function jk.lang.String:replaceCharacter(str, oldChar, newChar)
	if not (str ~= nil) then
		do return nil end
	end
	do return _g.jk.lang.String:replaceString(str, _g.jk.lang.String:forCharacter(oldChar), _g.jk.lang.String:forCharacter(newChar)) end
end

function jk.lang.String:replaceString(str, target, replacement)
	if not (str ~= nil) then
		do return nil end
	end
	if _g.jk.lang.String:isEmpty(target) then
		do return str end
	end
	do
		local rr = replacement
		if not (rr ~= nil) then
			rr = ""
		end
		do
			local v = str
			while true do
				local p = _g.jk.lang.String:getIndexOfString(v, target, 0)
				if p < 0 then
					do break end
				end
				do
					local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
					do sb:appendString(_g.jk.lang.String:getSubString(v, 0, p)) end
					do sb:appendString(rr) end
					do sb:appendString(_g.jk.lang.String:getEndOfString(v, p + _g.jk.lang.String:getLength(target))) end
					v = sb:toString()
				end
			end
			do return v end
		end
	end
end

function jk.lang.String:toCharArray(str)
	if not (str ~= nil) then
		do return nil end
	end
	do
		local it = _g.jk.lang.String:iterate(str)
		local v = nil
		do v = {} end
		do
			local n = 0
			while it ~= nil do
				local c = it:getNextChar()
				if _g.jk.lang.Character:isEOF(c) then
					do break end
				end
				do v[n + 1] = c end
				do n = n + 1 end
			end
			do return v end
		end
	end
end

function jk.lang.String:split(str, delim, max)
	local v = {}
	if str == nil then
		do return v end
	end
	do
		local it = _g.jk.lang.String:iterate(str)
		local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		local n = 0
		while true do
			local c = it:getNextChar()
			if _g.jk.lang.Character:isEOF(c) then
				do break end
			end
			if c == delim and (max < 1 or n < max - 1) then
				local s = sb:toString()
				if not (s ~= nil) then
					s = ""
				end
				do _g.jk.lang.Vector:append(v, s) end
				do sb:clear() end
				do n = n + 1 end
			else
				do sb:appendCharacter(c) end
			end
		end
		do
			local s = sb:toString()
			if not (s ~= nil) then
				s = ""
			end
			do _g.jk.lang.Vector:append(v, s) end
			do return v end
		end
	end
end

function jk.lang.String:isInteger(str)
	if not (str ~= nil) then
		do return false end
	end
	do
		local it = _g.jk.lang.String:iterate(str)
		if not (it ~= nil) then
			do return false end
		end
		while true do
			local c = it:getNextChar()
			if c < 1 then
				do break end
			end
			if c < 48 or c > 57 then
				do return false end
			end
		end
		do return true end
	end
end

function jk.lang.String:toInteger(str)
	if _g.jk.lang.String:isEmpty(str) then
		do return 0 end
	end
	do
		local iter = _g.jk.lang.String:iterate(str)
		if not (iter ~= nil) then
			do return 0 end
		end
		do
			local v = 0
			local first = true
			local negative = false
			while true do
				local c = iter:getNextChar()
				if first and c == 45 then
					negative = true
					first = false
					goto _continue2
				end
				if c >= 48 and c <= 57 then
					v = v * 10
					v = v + _util:convert_to_integer(c - 48)
				else
					do break end
				end
				first = false
				::_continue2::
			end
			if negative then
				v = v * -1
			end
			do return v end
		end
	end
end

function jk.lang.String:toLong(str)
	if _g.jk.lang.String:isEmpty(str) then
		do return 0 end
	end
	do
		local iter = _g.jk.lang.String:iterate(str)
		if not (iter ~= nil) then
			do return 0 end
		end
		do
			local v = 0
			local first = true
			local negative = false
			while true do
				local c = iter:getNextChar()
				if first and c == 45 then
					negative = true
					first = false
					goto _continue3
				end
				if c >= 48 and c <= 57 then
					v = v * 10
					v = v + _util:convert_to_integer(c - 48)
				else
					do break end
				end
				first = false
				::_continue3::
			end
			if negative then
				v = v * -1
			end
			do return v end
		end
	end
end

function jk.lang.String:toIntegerFromHex(str)
	if _g.jk.lang.String:isEmpty(str) then
		do return 0 end
	end
	do
		local iter = _g.jk.lang.String:iterate(str)
		if not (iter ~= nil) then
			do return 0 end
		end
		do
			local v = 0
			while true do
				local c = iter:getNextChar()
				if c >= 48 and c <= 57 then
					v = v * 16
					v = v + _util:convert_to_integer(c - 48)
				elseif c >= 97 and c <= 102 then
					v = v * 16
					v = v + (10 + c - 97)
				elseif c >= 65 and c <= 70 then
					v = v * 16
					v = v + (10 + c - 65)
				else
					do break end
				end
			end
			do return v end
		end
	end
end

function jk.lang.String:toLongIntegerFromHex(str)
	if _g.jk.lang.String:isEmpty(str) then
		do return 0 end
	end
	do
		local iter = _g.jk.lang.String:iterate(str)
		if not (iter ~= nil) then
			do return 0 end
		end
		do
			local v = 0
			while true do
				local c = iter:getNextChar()
				if c >= 48 and c <= 57 then
					v = v * 16
					v = v + _util:convert_to_integer(c - 48)
				elseif c >= 97 and c <= 102 then
					v = v * 16
					v = v + (10 + c - 97)
				elseif c >= 65 and c <= 70 then
					v = v * 16
					v = v + (10 + c - 65)
				else
					do break end
				end
			end
			do return v end
		end
	end
end

function jk.lang.String:toIntegerFromOctal(str)
	if _g.jk.lang.String:isEmpty(str) then
		do return 0 end
	end
	do
		local iter = _g.jk.lang.String:iterate(str)
		if not (iter ~= nil) then
			do return 0 end
		end
		do
			local v = 0
			while true do
				local c = iter:getNextChar()
				if c >= 48 and c <= 55 then
					v = v * 8
					v = v + _util:convert_to_integer(c - 48)
				else
					do break end
				end
			end
			do return v end
		end
	end
end

function jk.lang.String:toIntegerFromBinary(str)
	if _g.jk.lang.String:isEmpty(str) then
		do return 0 end
	end
	do
		local iter = _g.jk.lang.String:iterate(str)
		if not (iter ~= nil) then
			do return 0 end
		end
		do
			local v = 0
			while true do
				local c = iter:getNextChar()
				if c >= 48 and c <= 49 then
					v = v * 2
					v = v + _util:convert_to_integer(c - 48)
				else
					do break end
				end
			end
			do return v end
		end
	end
end

function jk.lang.String:toDouble(str)
	if str == nil then
		do return 0.0 end
	end
	do return _util:to_number(str) end
end

function jk.lang.String:iterate(value)
	do return _g.jk.lang.CharacterIteratorForString:forString(value) end
end

function jk.lang.String:reverse(value)
	if not (value ~= nil) then
		do return nil end
	end
	do
		local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		local it = _g.jk.lang.String:iterate(value)
		local c = 0
		while (function()
			c = it:getNextChar()
			do return c end
		end)() > 0 do
			do sb:insertCharacter(0, c) end
		end
		do return sb:toString() end
	end
end

function jk.lang.String:iterateReverse(value)
	do return _g.jk.lang.String:iterate(_g.jk.lang.String:reverse(value)) end
end

jk.lang.DynamicIterator = {}
jk = jk or {}

jk.url = jk.url or {}

jk.url.URLEncoder = {}
jk.url.URLEncoder.__index = jk.url.URLEncoder
_vm:set_metatable(jk.url.URLEncoder, {})

function jk.url.URLEncoder._create()
	local v = _vm:set_metatable({}, jk.url.URLEncoder)
	return v
end

function jk.url.URLEncoder:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.url.URLEncoder'
	self['_isType.jk.url.URLEncoder'] = true
end

function jk.url.URLEncoder:_construct0()
	jk.url.URLEncoder._init(self)
	return self
end

function jk.url.URLEncoder:encode(str, percentOnly, encodeUnreservedChars)
	if not (str ~= nil) then
		do return nil end
	end
	do
		local buffer = _g.jk.lang.String:toUTF8Buffer(str)
		local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		do
			local i = 0
			while i < #buffer do
				local c = _g.jk.lang.Buffer:getByte(buffer, i)
				if c < 1 then
					do break end
				end
				if c >= 97 and c <= 122 or (c >= 65 and c <= 90) or (c >= 48 and c <= 57) then
					do sb:appendCharacter(c) end
				elseif c == 45 or c == 46 or c == 95 or c == 126 and encodeUnreservedChars == false then
					do sb:appendCharacter(c) end
				elseif c == 32 and percentOnly == false then
					do sb:appendCharacter(43) end
				else
					do sb:appendCharacter(37) end
					do sb:appendString(_g.jk.lang.String:forIntegerHex(_vm:bitwise_and(_util:convert_to_integer(c), 255), 0)) end
				end
				do i = i + 1 end
			end
		end
		do return sb:toString() end
	end
end

jk.url.URL = {}
jk.url.URL.__index = jk.url.URL
_vm:set_metatable(jk.url.URL, {})

function jk.url.URL._create()
	local v = _vm:set_metatable({}, jk.url.URL)
	return v
end

function jk.url.URL:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.url.URL'
	self['_isType.jk.url.URL'] = true
	self['_isType.jk.lang.StringObject'] = true
	self.scheme = nil
	self.username = nil
	self.password = nil
	self.host = nil
	self.port = nil
	self.path = nil
	self.fragment = nil
	self.rawQueryParameters = nil
	self.queryParameters = nil
	self.original = nil
	self.percentOnly = false
	self.encodeUnreservedChars = true
end

function jk.url.URL:_construct0()
	jk.url.URL._init(self)
	return self
end

function jk.url.URL:forString(str, normalizePath)
	local v = _g.jk.url.URL._construct0(_g.jk.url.URL._create())
	do v:parse(str, normalizePath) end
	do return v end
end

function jk.url.URL:dup()
	local v = _g.jk.url.URL._construct0(_g.jk.url.URL._create())
	do v:setScheme(self.scheme) end
	do v:setUsername(self.username) end
	do v:setPassword(self.password) end
	do v:setHost(self.host) end
	do v:setPort(self.port) end
	do v:setPath(self.path) end
	do v:setFragment(self.fragment) end
	if self.rawQueryParameters ~= nil then
		do v:setRawQueryParameters(self.rawQueryParameters:dup()) end
	end
	if self.queryParameters ~= nil then
		do v:setQueryParameters(_g.jk.lang.Map:dup(self.queryParameters)) end
	end
	do return v end
end

function jk.url.URL:toString()
	do return self:toStringDo(true) end
end

function jk.url.URL:toStringNohost()
	do return self:toStringDo(false) end
end

function jk.url.URL:toStringDo(userhost)
	local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	if userhost then
		if self.scheme ~= nil then
			do sb:appendString(self.scheme) end
			do sb:appendString("://") end
		end
		if self.username ~= nil then
			do sb:appendString(_g.jk.url.URLEncoder:encode(self.username, false, true)) end
			if self.password ~= nil then
				do sb:appendCharacter(58) end
				do sb:appendString(_g.jk.url.URLEncoder:encode(self.password, false, true)) end
			end
			do sb:appendCharacter(64) end
		end
		if self.host ~= nil then
			do sb:appendString(self.host) end
			if self.port ~= nil then
				do sb:appendCharacter(58) end
				do sb:appendString(self.port) end
			end
		end
	end
	if self.path ~= nil then
		do sb:appendString(_g.jk.lang.String:replaceCharacter(self.path, 32, 43)) end
	end
	if self.rawQueryParameters ~= nil and self.rawQueryParameters:count() > 0 then
		local first = true
		local it = _g.jk.lang.Map:iterateKeys(self.queryParameters)
		while it ~= nil do
			local key = (function(o)
				if (_vm:get_variable_type(o) == 'string') then
					do return o end
				end
				do return nil end
			end)(it:next())
			if key == nil then
				do break end
			end
			if first then
				do sb:appendCharacter(63) end
				first = false
			else
				do sb:appendCharacter(38) end
			end
			do sb:appendString(key) end
			do
				local val = _g.jk.lang.Map:get(self.queryParameters, key)
				if val ~= nil then
					do sb:appendCharacter(61) end
					do sb:appendString(_g.jk.url.URLEncoder:encode(val, self.percentOnly, self.encodeUnreservedChars)) end
				end
			end
		end
	end
	if self.fragment ~= nil then
		do sb:appendCharacter(35) end
		do sb:appendString(self.fragment) end
	end
	do return sb:toString() end
end

function jk.url.URL:clearQueryParameters()
	self.rawQueryParameters = nil
	self.queryParameters = nil
end

function jk.url.URL:normalizePath(path)
	if not (path ~= nil) then
		do return nil end
	end
	do
		local v = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		local comps = _g.jk.lang.String:split(path, 47, 0)
		if comps ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(comps)
			do
				n = 0
				while n < m do
					local comp = comps[n + 1]
					if comp ~= nil then
						if _g.jk.lang.String:isEmpty(comp) then
						elseif comp == "." then
						elseif comp == ".." then
							local str = v:toString()
							do v:clear() end
							if str ~= nil then
								local slash = _g.jk.lang.String:getLastIndexOfCharacter(str, 47, -1)
								if slash > 0 then
									do v:appendString(_g.jk.lang.String:getSubString(str, 0, slash)) end
								end
							end
						else
							do v:appendCharacter(47) end
							do v:appendString(comp) end
						end
					end
					do n = n + 1 end
				end
			end
		end
		if v:count() < 2 then
			do return "/" end
		end
		if _g.jk.lang.String:endsWith(path, "/") then
			do v:appendCharacter(47) end
		end
		do return v:toString() end
	end
end

function jk.url.URL:parse(astr, doNormalizePath)
	do self:setOriginal(astr) end
	if not (astr ~= nil) then
		do return end
	end
	do
		local fsp = _g.jk.lang.String:split(astr, 35, 2)
		local str = _g.jk.lang.Vector:get(fsp, 0)
		self.fragment = _g.jk.lang.Vector:get(fsp, 1)
		do
			local qsplit = _g.jk.lang.String:split(str, 63, 2)
			str = _g.jk.lang.Vector:get(qsplit, 0)
			do
				local queryString = _g.jk.lang.Vector:get(qsplit, 1)
				if _g.jk.lang.String:isEmpty(queryString) == false then
					local qss = _g.jk.lang.String:split(queryString, 38, 0)
					if qss ~= nil then
						local n = 0
						local m = _g.jk.lang.Vector:getSize(qss)
						do
							n = 0
							while n < m do
								local qs = qss[n + 1]
								if qs ~= nil then
									if not (self.rawQueryParameters ~= nil) then
										self.rawQueryParameters = _g.jk.lang.KeyValueList._construct0(_g.jk.lang.KeyValueList._create())
									end
									if not (self.queryParameters ~= nil) then
										self.queryParameters = {}
									end
									if _g.jk.lang.String:getIndexOfCharacter(qs, 61, 0) < 0 then
										do _g.jk.lang.Map:set(self.queryParameters, qs, nil) end
										do self.rawQueryParameters:add(qs, nil) end
										goto _continue1
									end
									do
										local qsps = _g.jk.lang.String:split(qs, 61, 2)
										local key = _g.jk.lang.Vector:get(qsps, 0)
										local val = _g.jk.lang.Vector:get(qsps, 1)
										if _g.jk.lang.String:isEmpty(key) == false then
											if not (val ~= nil) then
												val = ""
											end
											do
												local udv = _g.jk.url.URLDecoder:decode(val)
												do _g.jk.lang.Map:set(self.queryParameters, key, udv) end
												do self.rawQueryParameters:add(key, udv) end
											end
										end
									end
								end
								::_continue1::
								do n = n + 1 end
							end
						end
					end
				end
				do
					local css = _g.jk.lang.String:getIndexOfString(str, "://", 0)
					if css >= 0 then
						self.scheme = _g.jk.lang.String:getSubString(str, 0, css)
						if _g.jk.lang.String:getIndexOfCharacter(self.scheme, 58, 0) >= 0 or _g.jk.lang.String:getIndexOfCharacter(self.scheme, 47, 0) >= 0 then
							self.scheme = nil
						else
							str = _g.jk.lang.String:getEndOfString(str, css + 3)
						end
					end
					do
						local pp = nil
						if _g.jk.lang.String:getChar(str, 0) == 47 then
							pp = str
						else
							if _g.jk.lang.String:getIndexOfCharacter(str, 47, 0) >= 0 then
								local sssplit = _g.jk.lang.String:split(str, 47, 2)
								str = _g.jk.lang.Vector:get(sssplit, 0)
								pp = _g.jk.lang.Vector:get(sssplit, 1)
								if not (pp ~= nil) then
									pp = ""
								end
								if _g.jk.lang.String:getChar(pp, 0) ~= 47 then
									pp = _g.jk.lang.String:appendString("/", pp)
								end
							end
							if _g.jk.lang.String:getIndexOfCharacter(str, 64, 0) >= 0 then
								local asplit = _g.jk.lang.String:split(str, 64, 2)
								local auth = _g.jk.lang.Vector:get(asplit, 0)
								str = _g.jk.lang.Vector:get(asplit, 1)
								if _g.jk.lang.String:getIndexOfCharacter(auth, 58, 0) >= 0 then
									local acsplit = _g.jk.lang.String:split(auth, 58, 2)
									self.username = _g.jk.url.URLDecoder:decode(_g.jk.lang.Vector:get(acsplit, 0))
									self.password = _g.jk.url.URLDecoder:decode(_g.jk.lang.Vector:get(acsplit, 1))
								else
									self.username = auth
								end
							end
							if _g.jk.lang.String:getIndexOfCharacter(str, 58, 0) >= 0 then
								local hcsplit = _g.jk.lang.String:split(str, 58, 2)
								str = _g.jk.lang.Vector:get(hcsplit, 0)
								self.port = _g.jk.lang.Vector:get(hcsplit, 1)
							end
							self.host = str
						end
						if doNormalizePath then
							self.path = self:normalizePath(pp)
						else
							self.path = pp
						end
						if not (self.port ~= nil) and _g.jk.lang.String:equals("https", self.scheme) or _g.jk.lang.String:equals("wss", self.scheme) then
							self.port = "443"
						end
					end
				end
			end
		end
	end
end

function jk.url.URL:getPortInt()
	if not (self.port ~= nil) then
		do return 0 end
	end
	do return _g.jk.lang.String:toInteger(self.port) end
end

function jk.url.URL:getQueryParameter(key)
	if not (self.queryParameters ~= nil) then
		do return nil end
	end
	do return _g.jk.lang.Map:get(self.queryParameters, key) end
end

function jk.url.URL:addQueryParameter(key, value)
	if not (self.rawQueryParameters ~= nil) then
		self.rawQueryParameters = _g.jk.lang.KeyValueList._construct0(_g.jk.lang.KeyValueList._create())
	end
	if not (self.queryParameters ~= nil) then
		self.queryParameters = {}
	end
	do _g.jk.lang.Map:set(self.queryParameters, key, value) end
	do self.rawQueryParameters:add(key, value) end
end

function jk.url.URL:getScheme()
	do return self.scheme end
end

function jk.url.URL:setScheme(v)
	self.scheme = v
	do return self end
end

function jk.url.URL:getUsername()
	do return self.username end
end

function jk.url.URL:setUsername(v)
	self.username = v
	do return self end
end

function jk.url.URL:getPassword()
	do return self.password end
end

function jk.url.URL:setPassword(v)
	self.password = v
	do return self end
end

function jk.url.URL:getHost()
	do return self.host end
end

function jk.url.URL:setHost(v)
	self.host = v
	do return self end
end

function jk.url.URL:getPort()
	do return self.port end
end

function jk.url.URL:setPort(v)
	self.port = v
	do return self end
end

function jk.url.URL:getPath()
	do return self.path end
end

function jk.url.URL:setPath(v)
	self.path = v
	do return self end
end

function jk.url.URL:getFragment()
	do return self.fragment end
end

function jk.url.URL:setFragment(v)
	self.fragment = v
	do return self end
end

function jk.url.URL:getRawQueryParameters()
	do return self.rawQueryParameters end
end

function jk.url.URL:setRawQueryParameters(v)
	self.rawQueryParameters = v
	do return self end
end

function jk.url.URL:getQueryParameters()
	do return self.queryParameters end
end

function jk.url.URL:setQueryParameters(v)
	self.queryParameters = v
	do return self end
end

function jk.url.URL:getOriginal()
	do return self.original end
end

function jk.url.URL:setOriginal(v)
	self.original = v
	do return self end
end

function jk.url.URL:getPercentOnly()
	do return self.percentOnly end
end

function jk.url.URL:setPercentOnly(v)
	self.percentOnly = v
	do return self end
end

function jk.url.URL:getEncodeUnreservedChars()
	do return self.encodeUnreservedChars end
end

function jk.url.URL:setEncodeUnreservedChars(v)
	self.encodeUnreservedChars = v
	do return self end
end

jk.url.URLDecoder = {}
jk.url.URLDecoder.__index = jk.url.URLDecoder
_vm:set_metatable(jk.url.URLDecoder, {})

function jk.url.URLDecoder._create()
	local v = _vm:set_metatable({}, jk.url.URLDecoder)
	return v
end

function jk.url.URLDecoder:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.url.URLDecoder'
	self['_isType.jk.url.URLDecoder'] = true
end

function jk.url.URLDecoder:_construct0()
	jk.url.URLDecoder._init(self)
	return self
end

function jk.url.URLDecoder:xcharToInteger(c)
	if c >= 48 and c <= 57 then
		local ci = _util:convert_to_integer(c)
		do return ci - 48 end
	elseif c >= 97 and c <= 102 then
		do return 10 + c - 97 end
	elseif c >= 65 and c <= 70 then
		do return 10 + c - 65 end
	end
	do return 0 end
end

function jk.url.URLDecoder:decode(astr)
	if not (astr ~= nil) then
		do return nil end
	end
	do
		local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		local str = _g.jk.lang.String:strip(astr)
		local it = _g.jk.lang.String:iterate(str)
		while it ~= nil do
			local x = it:getNextChar()
			if x < 1 then
				do break end
			end
			if x == 37 then
				local x1 = it:getNextChar()
				local x2 = it:getNextChar()
				if x1 > 0 and x2 > 0 then
					do sb:appendCharacter(_g.jk.url.URLDecoder:xcharToInteger(x1) * 16 + _g.jk.url.URLDecoder:xcharToInteger(x2)) end
				else
					do break end
				end
			elseif x == 43 then
				do sb:appendCharacter(32) end
			else
				do sb:appendCharacter(x) end
			end
		end
		do return sb:toString() end
	end
end

jk.url.QueryString = {}
jk.url.QueryString.__index = jk.url.QueryString
_vm:set_metatable(jk.url.QueryString, {})

function jk.url.QueryString._create()
	local v = _vm:set_metatable({}, jk.url.QueryString)
	return v
end

function jk.url.QueryString:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.url.QueryString'
	self['_isType.jk.url.QueryString'] = true
end

function jk.url.QueryString:_construct0()
	jk.url.QueryString._init(self)
	return self
end

function jk.url.QueryString:parse(queryString)
	local v = {}
	if _g.jk.lang.String:isEmpty(queryString) then
		do return v end
	end
	do
		local array = _g.jk.lang.String:split(queryString, 38, 0)
		if array ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(array)
			do
				n = 0
				while n < m do
					local qs = array[n + 1]
					if qs ~= nil then
						if _g.jk.lang.String:isEmpty(qs) then
							goto _continue2
						end
						if _g.jk.lang.String:getIndexOfCharacter(qs, 61, 0) < 0 then
							do _g.jk.lang.Map:set(v, qs, nil) end
							goto _continue2
						end
						do
							local qsps = _g.jk.lang.String:split(qs, 61, 2)
							local key = qsps[0 + 1]
							local val = qsps[1 + 1]
							if val == nil then
								val = ""
							end
							if _g.jk.lang.String:isEmpty(key) == false then
								do _g.jk.lang.Map:set(v, _g.jk.url.URLDecoder:decode(key), _g.jk.url.URLDecoder:decode(val)) end
							end
						end
					end
					::_continue2::
					do n = n + 1 end
				end
			end
		end
		do return v end
	end
end

function jk.url.QueryString:encode(queryString)
	local str = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	local first = true
	local keys = _g.jk.lang.Map:getKeys(queryString)
	if keys ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(keys)
		do
			n = 0
			while n < m do
				local key = keys[n + 1]
				if key ~= nil then
					if _g.jk.lang.String:isEmpty(key) then
						goto _continue3
					end
					do
						local val = _g.jk.lang.Map:getValue(queryString, key)
						if not first then
							do str:appendString("&") end
						end
						do str:appendString(_g.jk.url.URLEncoder:encode(key, false, true)) end
						do str:appendCharacter(61) end
						do str:appendString(_g.jk.url.URLEncoder:encode(val, false, true)) end
						first = false
					end
				end
				::_continue3::
				do n = n + 1 end
			end
		end
	end
	do return str:toString() end
end
jk = jk or {}

jk.time = jk.time or {}

jk.time.SystemClock = {}
jk.time.SystemClock.__index = jk.time.SystemClock
_vm:set_metatable(jk.time.SystemClock, {})

function jk.time.SystemClock._create()
	local v = _vm:set_metatable({}, jk.time.SystemClock)
	return v
end

function jk.time.SystemClock:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.time.SystemClock'
	self['_isType.jk.time.SystemClock'] = true
end

function jk.time.SystemClock:_construct0()
	jk.time.SystemClock._init(self)
	return self
end

function jk.time.SystemClock:asDateTimeUTC()
	do return _g.jk.lang.DateTime:forSeconds(_g.jk.time.SystemClock:asUTCSeconds()) end
end

function jk.time.SystemClock:asDateTimeLocal()
	local v = _g.jk.lang.DateTime:forSeconds(_g.jk.time.SystemClock:asSeconds())
	do v:setTimezoneOffset(_g.jk.time.SystemClock:getTimezoneOffsetAsSeconds()) end
	do return v end
end

function jk.time.SystemClock:getTimezoneOffsetAsSeconds()
	do return _os:get_system_timezone_seconds() end
end

function jk.time.SystemClock:asUTCSeconds()
	do return _g.jk.time.SystemClock:asSeconds() + _g.jk.time.SystemClock:getTimezoneOffsetAsSeconds() end
end

function jk.time.SystemClock:asSeconds()
	do return _os:get_system_time_seconds() end
end

function jk.time.SystemClock:asTimeValue()
	local v = _g.jk.lang.TimeValue._construct0(_g.jk.lang.TimeValue._create())
	do _g.jk.time.SystemClock:update(v) end
	do return v end
end

function jk.time.SystemClock:update(v)
	if not (v ~= nil) then
		do return end
	end
	do
		local millis = _os:get_system_time_milliseconds()
		local secs = _util:convert_to_integer(millis / 1000)
		local micros = (millis - secs * 1000) * 1000
		do v:setSeconds(secs) end
		do v:setMicroSeconds(micros) end
	end
end
jk = jk or {}

jk.os = jk.os or {}

jk.os.OS = {}
jk.os.OS.__index = jk.os.OS
_vm:set_metatable(jk.os.OS, {})

jk.os.OS.isWindowsFlag = nil
jk.os.OS.isLinuxFlag = nil
jk.os.OS.isMacOSFlag = nil
jk.os.OS.isAndroidFlag = nil
jk.os.OS.isIOSFlag = nil

function jk.os.OS._create()
	local v = _vm:set_metatable({}, jk.os.OS)
	return v
end

function jk.os.OS:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.os.OS'
	self['_isType.jk.os.OS'] = true
end

function jk.os.OS:_construct0()
	jk.os.OS._init(self)
	return self
end

function jk.os.OS:getCurrentPlatformName()
	do return "Sushi" end
end

function jk.os.OS:is32Bit()
	local cpu = _g.jk.os.OS:getProcessorType()
	if cpu == "x86" or cpu == "arm" then
		do return true end
	end
	do return false end
end

function jk.os.OS:is64Bit()
	local cpu = _g.jk.os.OS:getProcessorType()
	if cpu == "x64" or cpu == "arm64" then
		do return true end
	end
	do return false end
end

function jk.os.OS:getProcessorType()
	do return nil end
end

function jk.os.OS:isWindows()
	if _g.jk.os.OS.isWindowsFlag ~= nil then
		do return _g.jk.os.OS.isWindowsFlag:toBoolean() end
	end
	do
		local v = _g.jk.os.OS:isSystemType("windows")
		_g.jk.os.OS.isWindowsFlag = _g.jk.lang.Boolean:asObject(v)
		do return v end
	end
end

function jk.os.OS:isLinux()
	if _g.jk.os.OS.isLinuxFlag ~= nil then
		do return _g.jk.os.OS.isLinuxFlag:toBoolean() end
	end
	do
		local v = _g.jk.os.OS:isSystemType("linux")
		_g.jk.os.OS.isLinuxFlag = _g.jk.lang.Boolean:asObject(v)
		do return v end
	end
end

function jk.os.OS:isMacOS()
	if _g.jk.os.OS.isMacOSFlag ~= nil then
		do return _g.jk.os.OS.isMacOSFlag:toBoolean() end
	end
	do
		local v = _g.jk.os.OS:isSystemType("macos")
		_g.jk.os.OS.isMacOSFlag = _g.jk.lang.Boolean:asObject(v)
		do return v end
	end
end

function jk.os.OS:isOSX()
	do return _g.jk.os.OS:isMacOS() end
end

function jk.os.OS:isAndroid()
	if _g.jk.os.OS.isAndroidFlag ~= nil then
		do return _g.jk.os.OS.isAndroidFlag:toBoolean() end
	end
	do
		local v = _g.jk.os.OS:isSystemType("android")
		_g.jk.os.OS.isAndroidFlag = _g.jk.lang.Boolean:asObject(v)
		do return v end
	end
end

function jk.os.OS:isIOS()
	if _g.jk.os.OS.isIOSFlag ~= nil then
		do return _g.jk.os.OS.isIOSFlag:toBoolean() end
	end
	do
		local v = _g.jk.os.OS:isSystemType("ios")
		_g.jk.os.OS.isIOSFlag = _g.jk.lang.Boolean:asObject(v)
		do return v end
	end
end

function jk.os.OS:isSystemType(ida)
	local id = ida
	if id == "osx" then
		id = "macos"
	end
	do
		local type = _os:get_system_type()
		do return type == id end
	end
end

function jk.os.OS:isDirectory(path)
	if not _g.jk.lang.String:isNotEmpty(path) then
		do return false end
	end
	_io:write_to_stdout("[jk.os.OS.isDirectory] (OS.sling:385:3): Not implemented" .. "\n")
	do return false end
end

function jk.os.OS:isFile(path)
	if not _g.jk.lang.String:isNotEmpty(path) then
		do return false end
	end
	_io:write_to_stdout("[jk.os.OS.isFile] (OS.sling:423:3): Not implemented" .. "\n")
	do return false end
end
jk = jk or {}

jk.log = jk.log or {}

jk.log.Log = {}
jk.log.Log.__index = jk.log.Log
_vm:set_metatable(jk.log.Log, {})

function jk.log.Log._create()
	local v = _vm:set_metatable({}, jk.log.Log)
	return v
end

function jk.log.Log:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.log.Log'
	self['_isType.jk.log.Log'] = true
end

function jk.log.Log:_construct0()
	jk.log.Log._init(self)
	return self
end

function jk.log.Log:asString(context, value)
	if context ~= nil and (_vm:to_table_with_key(value, '_isType.jk.lang.StringObjectWithDebug') ~= nil) then
		do return value:toStringWithDebug(context:isInDebugMode()) end
	end
	do return _g.jk.lang.String:asString(value) end
end

function jk.log.Log:error(context, message)
	if context ~= nil then
		do context:logError(message) end
	end
end

function jk.log.Log:warning(context, message)
	if context ~= nil then
		do context:logWarning(message) end
	end
end

function jk.log.Log:info(context, message)
	if context ~= nil then
		do context:logInfo(message) end
	end
end

function jk.log.Log:debug(context, message)
	if context ~= nil then
		do context:logDebug(message) end
	end
end

function jk.log.Log:status(context, message)
	if context ~= nil then
		do context:logStatus(message) end
	end
end

jk.log.LoggingContext = {}
jk = jk or {}

jk.io = jk.io or {}

jk.io.Reader = {}

jk.io.Writer = {}

jk.io.ByteReader = {}

jk.io.PrintWriter = {}

jk.io.FileDescriptor = {}

jk.io.DataStreamSource = {}

jk.io.LineReader = {}

jk.io.SeekableReader = {}

jk.io.FileDescriptorWriter = {}
jk.io.FileDescriptorWriter.__index = jk.io.FileDescriptorWriter
_vm:set_metatable(jk.io.FileDescriptorWriter, {})

function jk.io.FileDescriptorWriter._create()
	local v = _vm:set_metatable({}, jk.io.FileDescriptorWriter)
	return v
end

function jk.io.FileDescriptorWriter:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.io.FileDescriptorWriter'
	self['_isType.jk.io.FileDescriptorWriter'] = true
	self['_isType.jk.io.Writer'] = true
	self['_isType.jk.lang.Closable'] = true
	self['_isType.jk.io.FileDescriptor'] = true
	self.fd = -1
	self.owned = true
	self._destructWrapper = _vm:create_destructor(function() self:_destruct() end)
end

function jk.io.FileDescriptorWriter:_construct0()
	jk.io.FileDescriptorWriter._init(self)
	return self
end

function jk.io.FileDescriptorWriter:forFileDescriptor(fd)
	local v = _g.jk.io.FileDescriptorWriter._construct0(_g.jk.io.FileDescriptorWriter._create())
	do v:setFd(fd) end
	do return v end
end

function jk.io.FileDescriptorWriter:forUnownedFileDescriptor(fd)
	local v = _g.jk.io.FileDescriptorWriter._construct0(_g.jk.io.FileDescriptorWriter._create())
	do v:setFd(fd) end
	do v:setOwned(false) end
	do return v end
end

function jk.io.FileDescriptorWriter:_destruct()
	do self:close() end
end

function jk.io.FileDescriptorWriter:getFileDescriptor()
	do return self.fd end
end

function jk.io.FileDescriptorWriter:write(buf, size)
	local v = -1
	local handle = self.fd
	if handle >= 0 then
		do v = _io:write_to_handle(handle, buf, size) end
	end
	do return v end
end

function jk.io.FileDescriptorWriter:close()
	if not self.owned then
		do return end
	end
	do
		local handle = self.fd
		if handle >= 0 then
			do _io:close_handle(handle) end
			self.fd = -1
		end
	end
end

function jk.io.FileDescriptorWriter:getFd()
	do return self.fd end
end

function jk.io.FileDescriptorWriter:setFd(v)
	self.fd = v
	do return self end
end

function jk.io.FileDescriptorWriter:getOwned()
	do return self.owned end
end

function jk.io.FileDescriptorWriter:setOwned(v)
	self.owned = v
	do return self end
end

jk.io.PrintReader = {}
jk.io.PrintReader.__index = jk.io.PrintReader
_vm:set_metatable(jk.io.PrintReader, {})

function jk.io.PrintReader._create()
	local v = _vm:set_metatable({}, jk.io.PrintReader)
	return v
end

function jk.io.PrintReader:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.io.PrintReader'
	self['_isType.jk.io.PrintReader'] = true
	self['_isType.jk.io.Reader'] = true
	self['_isType.jk.io.LineReader'] = true
	self['_isType.jk.lang.Closable'] = true
	self.reader = nil
	self.iterator = nil
end

function jk.io.PrintReader:_construct0()
	jk.io.PrintReader._init(self)
	return self
end

function jk.io.PrintReader:forReader(reader)
	if not (reader ~= nil) then
		do return nil end
	end
	if (_vm:to_table_with_key(reader, '_isType.jk.io.PrintReader') ~= nil) then
		do return reader end
	end
	do
		local v = _g.jk.io.PrintReader._construct0(_g.jk.io.PrintReader._create())
		do v:setReader(reader, nil) end
		do return v end
	end
end

function jk.io.PrintReader:forReaderAndEncoding(reader, encoding)
	if not (reader ~= nil) then
		do return nil end
	end
	if (_vm:to_table_with_key(reader, '_isType.jk.io.PrintReader') ~= nil) then
		do return reader end
	end
	do
		local v = _g.jk.io.PrintReader._construct0(_g.jk.io.PrintReader._create())
		do v:setReader(reader, encoding) end
		do return v end
	end
end

function jk.io.PrintReader:setReader(reader, encoding)
	self.reader = reader
	if reader == nil then
		self.iterator = nil
	else
		self.iterator = _g.jk.io.CharacterIteratorForReader:forReader(reader)
		if encoding ~= nil then
			do self.iterator:setEncoding(encoding) end
		end
	end
end

function jk.io.PrintReader:readLine()
	if not (self.iterator ~= nil) then
		do return nil end
	end
	do
		local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		while true do
			local c = self.iterator:getNextChar()
			if _g.jk.lang.Character:isEOF(c) then
				if sb:count() < 1 then
					do return nil end
				end
				do break end
			end
			if c == 13 then
				goto _continue1
			end
			if c == 10 then
				do break end
			end
			do sb:appendCharacter(c) end
			::_continue1::
		end
		if sb:count() < 1 then
			do return "" end
		end
		do return sb:toString() end
	end
end

function jk.io.PrintReader:readAll()
	if not (self.iterator ~= nil) then
		do return nil end
	end
	do
		local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		while true do
			local c = self.iterator:getNextChar()
			if _g.jk.lang.Character:isEOF(c) then
				do break end
			end
			do sb:appendCharacter(c) end
		end
		if sb:count() < 1 then
			do return nil end
		end
		do return sb:toString() end
	end
end

function jk.io.PrintReader:hasEnded()
	if not (self.iterator ~= nil) then
		do return true end
	end
	do return self.iterator:hasEnded() end
end

function jk.io.PrintReader:read(buffer)
	if self.reader == nil then
		do return -1 end
	end
	do return self.reader:read(buffer) end
end

function jk.io.PrintReader:close()
	local rc = _vm:to_table_with_key(self.reader, '_isType.jk.lang.Closable')
	if rc ~= nil then
		do rc:close() end
	end
end

jk.io.FlushableWriter = {}

jk.io.SeekableWriter = {}

jk.io.CharacterIteratorForReader = _g.jk.lang.CharacterDecoder._create()
jk.io.CharacterIteratorForReader.__index = jk.io.CharacterIteratorForReader
_vm:set_metatable(jk.io.CharacterIteratorForReader, {
	__index = _g.jk.lang.CharacterDecoder
})

function jk.io.CharacterIteratorForReader._create()
	local v = _vm:set_metatable({}, jk.io.CharacterIteratorForReader)
	return v
end

function jk.io.CharacterIteratorForReader:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.io.CharacterIteratorForReader'
	self['_isType.jk.io.CharacterIteratorForReader'] = true
	self.reader = nil
	self.buffer = nil
	self.bufferStart = -1
	self.bufferSize = 0
	self.bufferDataSize = 0
	self.currentPos = -1
	self.readPos = 0
end

function jk.io.CharacterIteratorForReader:_construct0()
	jk.io.CharacterIteratorForReader._init(self)
	do _g.jk.lang.CharacterDecoder._construct0(self) end
	return self
end

function jk.io.CharacterIteratorForReader:forReader(reader)
	do return _g.jk.io.CharacterIteratorForReader._construct1(_g.jk.io.CharacterIteratorForReader._create(), reader) end
end

function jk.io.CharacterIteratorForReader:forReaderWithBufferSize(reader, bufferSize)
	do return _g.jk.io.CharacterIteratorForReader._construct2(_g.jk.io.CharacterIteratorForReader._create(), reader, bufferSize) end
end

function jk.io.CharacterIteratorForReader:_construct1(reader)
	jk.io.CharacterIteratorForReader._init(self)
	do _g.jk.lang.CharacterDecoder._construct0(self) end
	self.reader = reader
	self.buffer = _util:allocate_buffer(1024)
	self.bufferSize = 1024
	return self
end

function jk.io.CharacterIteratorForReader:_construct2(reader, bufferSize)
	jk.io.CharacterIteratorForReader._init(self)
	do _g.jk.lang.CharacterDecoder._construct0(self) end
	self.reader = reader
	self.buffer = _util:allocate_buffer(bufferSize)
	self.bufferSize = bufferSize
	return self
end

function jk.io.CharacterIteratorForReader:makeDataAvailable(n)
	if n >= self.bufferStart and n < self.bufferStart + self.bufferDataSize then
		do return true end
	end
	if (_vm:to_table_with_key(self.reader, '_isType.jk.io.SeekableReader') ~= nil) then
		local rs = self.reader
		local block = _util:convert_to_integer(n / self.bufferSize)
		local blockPos = block * self.bufferSize
		if self.readPos ~= blockPos then
			if not rs:setCurrentPosition(blockPos) then
				do return false end
			end
			self.readPos = blockPos
		end
	end
	self.bufferDataSize = self.reader:read(self.buffer)
	self.bufferStart = self.readPos
	self.readPos = self.readPos + self.bufferDataSize
	if n >= self.bufferStart and n < self.bufferStart + self.bufferDataSize then
		do return true end
	end
	do return false end
end

function jk.io.CharacterIteratorForReader:moveToPreviousByte()
	if not self:makeDataAvailable(self.currentPos - 1) then
		do return false end
	end
	do self.currentPos = self.currentPos - 1 end
	do return true end
end

function jk.io.CharacterIteratorForReader:moveToNextByte()
	if not self:makeDataAvailable(self.currentPos + 1) then
		do return false end
	end
	do self.currentPos = self.currentPos + 1 end
	do return true end
end

function jk.io.CharacterIteratorForReader:getCurrentByte()
	do return _g.jk.lang.Buffer:getByte(self.buffer, self.currentPos - self.bufferStart) end
end

function jk.io.CharacterIteratorForReader:getCurrentPosition()
	do return self.currentPos end
end

function jk.io.CharacterIteratorForReader:setCurrentPosition(position)
	self.currentPos = position
end

jk.io.BufferWriter = {}
jk.io.BufferWriter.__index = jk.io.BufferWriter
_vm:set_metatable(jk.io.BufferWriter, {})

function jk.io.BufferWriter._create()
	local v = _vm:set_metatable({}, jk.io.BufferWriter)
	return v
end

function jk.io.BufferWriter:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.io.BufferWriter'
	self['_isType.jk.io.BufferWriter'] = true
	self['_isType.jk.io.Writer'] = true
	self.buffer = nil
	self.pos = 0
end

function jk.io.BufferWriter:_construct0()
	jk.io.BufferWriter._init(self)
	return self
end

function jk.io.BufferWriter:forBuffer(buf)
	local v = _g.jk.io.BufferWriter._construct0(_g.jk.io.BufferWriter._create())
	v.buffer = buf
	do return v end
end

function jk.io.BufferWriter:getBufferSize()
	do return _g.jk.lang.Buffer:getSize(self.buffer) end
end

function jk.io.BufferWriter:getBufferPos()
	do return 0 end
end

function jk.io.BufferWriter:getBuffer()
	do return self.buffer end
end

function jk.io.BufferWriter:write(src, ssize)
	if src == nil then
		do return 0 end
	end
	do
		local size = ssize
		if size < 0 then
			size = _g.jk.lang.Buffer:getSize(src)
		end
		if size < 1 then
			do return 0 end
		end
		if self.buffer == nil then
			self.buffer = _util:allocate_buffer(size)
			if self.buffer == nil then
				do return 0 end
			end
			do _g.jk.lang.Buffer:copyFrom(self.buffer, src, 0, 0, size) end
			self.pos = size
		elseif self.pos + size <= _g.jk.lang.Buffer:getSize(self.buffer) then
			do _g.jk.lang.Buffer:copyFrom(self.buffer, src, 0, self.pos, size) end
			self.pos = self.pos + size
		else
			local nb = _g.jk.lang.Buffer:resize(self.buffer, self.pos + size)
			if nb == nil then
				do return 0 end
			end
			self.buffer = nb
			do _g.jk.lang.Buffer:copyFrom(self.buffer, src, 0, self.pos, size) end
			self.pos = self.pos + size
		end
		do return size end
	end
end

jk.io.BinaryReader = {}
jk.io.BinaryReader.__index = jk.io.BinaryReader
_vm:set_metatable(jk.io.BinaryReader, {})

function jk.io.BinaryReader._create()
	local v = _vm:set_metatable({}, jk.io.BinaryReader)
	return v
end

function jk.io.BinaryReader:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.io.BinaryReader'
	self['_isType.jk.io.BinaryReader'] = true
	self['_isType.jk.lang.Closable'] = true
	self.reader = nil
	self.buffer1 = nil
	self.buffer2 = nil
	self.buffer4 = nil
end

function jk.io.BinaryReader:_construct0()
	jk.io.BinaryReader._init(self)
	return self
end

function jk.io.BinaryReader:forReader(reader)
	local v = _g.jk.io.BinaryReader._construct0(_g.jk.io.BinaryReader._create())
	do v:setReader(reader) end
	do return v end
end

function jk.io.BinaryReader:isOK()
	if not (self.reader ~= nil) then
		do return false end
	end
	do return true end
end

function jk.io.BinaryReader:close()
	local rc = _vm:to_table_with_key(self.reader, '_isType.jk.lang.Closable')
	if rc ~= nil then
		do rc:close() end
	end
	self.reader = nil
end

function jk.io.BinaryReader:seek(position)
	local sr = _vm:to_table_with_key(self.reader, '_isType.jk.io.SeekableReader')
	if not (sr ~= nil) then
		do return false end
	end
	do return sr:setCurrentPosition(position) end
end

function jk.io.BinaryReader:read1()
	if not (self.reader ~= nil) then
		do return nil end
	end
	if not (self.buffer1 ~= nil) then
		self.buffer1 = _util:allocate_buffer(1)
	end
	do
		local r = self.reader:read(self.buffer1)
		if not (r == 1) then
			do self:close() end
			do return nil end
		end
		do return self.buffer1 end
	end
end

function jk.io.BinaryReader:read2()
	if not (self.reader ~= nil) then
		do return nil end
	end
	if not (self.buffer2 ~= nil) then
		self.buffer2 = _util:allocate_buffer(2)
	end
	do
		local r = self.reader:read(self.buffer2)
		if not (r == 2) then
			do self:close() end
			do return nil end
		end
		do return self.buffer2 end
	end
end

function jk.io.BinaryReader:read4()
	if not (self.reader ~= nil) then
		do return nil end
	end
	if not (self.buffer4 ~= nil) then
		self.buffer4 = _util:allocate_buffer(4)
	end
	do
		local r = self.reader:read(self.buffer4)
		if not (r == 4) then
			do self:close() end
			do return nil end
		end
		do return self.buffer4 end
	end
end

function jk.io.BinaryReader:readBuffer(size)
	if not (self.reader ~= nil) then
		do return nil end
	end
	if not (size > 0) then
		do return nil end
	end
	do
		local b = _util:allocate_buffer(size)
		local r = self.reader:read(b)
		if not (r == size) then
			do self:close() end
			do return nil end
		end
		do return b end
	end
end

function jk.io.BinaryReader:readInt8()
	local b = self:read1()
	if not (b ~= nil) then
		do return 0 end
	end
	do return _g.jk.lang.Buffer:getInt8(b, 0) end
end

function jk.io.BinaryReader:readInt16LE()
	local b = self:read2()
	if not (b ~= nil) then
		do return 0 end
	end
	do return _g.jk.lang.Buffer:getInt16LE(b, 0) end
end

function jk.io.BinaryReader:readInt16BE()
	local b = self:read2()
	if not (b ~= nil) then
		do return 0 end
	end
	do return _g.jk.lang.Buffer:getInt16BE(b, 0) end
end

function jk.io.BinaryReader:readInt32LE()
	local b = self:read4()
	if not (b ~= nil) then
		do return 0 end
	end
	do return _g.jk.lang.Buffer:getInt32LE(b, 0) end
end

function jk.io.BinaryReader:readInt32BE()
	local b = self:read4()
	if not (b ~= nil) then
		do return 0 end
	end
	do return _g.jk.lang.Buffer:getInt32BE(b, 0) end
end

function jk.io.BinaryReader:getReader()
	do return self.reader end
end

function jk.io.BinaryReader:setReader(v)
	self.reader = v
	do return self end
end

jk.io.StaticFileDescriptor = {}
jk.io.StaticFileDescriptor.__index = jk.io.StaticFileDescriptor
_vm:set_metatable(jk.io.StaticFileDescriptor, {})

function jk.io.StaticFileDescriptor._create()
	local v = _vm:set_metatable({}, jk.io.StaticFileDescriptor)
	return v
end

function jk.io.StaticFileDescriptor:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.io.StaticFileDescriptor'
	self['_isType.jk.io.StaticFileDescriptor'] = true
	self['_isType.jk.io.FileDescriptor'] = true
	self.fileDescriptor = 0
end

function jk.io.StaticFileDescriptor:_construct0()
	jk.io.StaticFileDescriptor._init(self)
	return self
end

function jk.io.StaticFileDescriptor:forFileDescriptor(fd)
	do return _g.jk.io.StaticFileDescriptor._construct0(_g.jk.io.StaticFileDescriptor._create()):setFileDescriptor(fd) end
end

function jk.io.StaticFileDescriptor:getFileDescriptor()
	do return self.fileDescriptor end
end

function jk.io.StaticFileDescriptor:setFileDescriptor(v)
	self.fileDescriptor = v
	do return self end
end

jk.io.DataStream = {}

jk.io.PrintWriterWrapper = {}
jk.io.PrintWriterWrapper.__index = jk.io.PrintWriterWrapper
_vm:set_metatable(jk.io.PrintWriterWrapper, {})

function jk.io.PrintWriterWrapper._create()
	local v = _vm:set_metatable({}, jk.io.PrintWriterWrapper)
	return v
end

function jk.io.PrintWriterWrapper:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.io.PrintWriterWrapper'
	self['_isType.jk.io.PrintWriterWrapper'] = true
	self['_isType.jk.io.Writer'] = true
	self['_isType.jk.io.PrintWriter'] = true
	self['_isType.jk.lang.Closable'] = true
	self['_isType.jk.io.FlushableWriter'] = true
	self.writer = nil
end

function jk.io.PrintWriterWrapper:_construct0()
	jk.io.PrintWriterWrapper._init(self)
	return self
end

function jk.io.PrintWriterWrapper:forWriter(writer)
	if writer == nil then
		do return nil end
	end
	if (_vm:to_table_with_key(writer, '_isType.jk.io.PrintWriter') ~= nil) then
		do return writer end
	end
	do
		local v = _g.jk.io.PrintWriterWrapper._construct0(_g.jk.io.PrintWriterWrapper._create())
		do v:setWriter(writer) end
		do return v end
	end
end

function jk.io.PrintWriterWrapper:closeWriter(writer)
	local wc = _vm:to_table_with_key(writer, '_isType.jk.lang.Closable')
	if not (wc ~= nil) then
		do return nil end
	end
	do wc:close() end
	do return nil end
end

function jk.io.PrintWriterWrapper:print(str)
	if str == nil then
		do return false end
	end
	do
		local buffer = _g.jk.lang.String:toUTF8Buffer(str)
		if buffer == nil then
			do return false end
		end
		do
			local sz = _g.jk.lang.Buffer:getSize(buffer)
			if self.writer:write(buffer, -1) ~= sz then
				do return false end
			end
			do return true end
		end
	end
end

function jk.io.PrintWriterWrapper:println(str)
	do return self:print(_g.jk.lang.String:safeString(str) .. "\n") end
end

function jk.io.PrintWriterWrapper:writeWholeBuffer(buf)
	do return self:write(buf, -1) end
end

function jk.io.PrintWriterWrapper:write(buf, size)
	if self.writer == nil then
		do return -1 end
	end
	do return self.writer:write(buf, size) end
end

function jk.io.PrintWriterWrapper:close()
	local cw = _vm:to_table_with_key(self.writer, '_isType.jk.lang.Closable')
	if cw ~= nil then
		do cw:close() end
	end
end

function jk.io.PrintWriterWrapper:flush()
	local cw = _vm:to_table_with_key(self.writer, '_isType.jk.io.FlushableWriter')
	if cw ~= nil then
		do cw:flush() end
	end
end

function jk.io.PrintWriterWrapper:getWriter()
	do return self.writer end
end

function jk.io.PrintWriterWrapper:setWriter(v)
	self.writer = v
	do return self end
end

jk.io.StringLineReader = {}
jk.io.StringLineReader.__index = jk.io.StringLineReader
_vm:set_metatable(jk.io.StringLineReader, {})

function jk.io.StringLineReader._create()
	local v = _vm:set_metatable({}, jk.io.StringLineReader)
	return v
end

function jk.io.StringLineReader:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.io.StringLineReader'
	self['_isType.jk.io.StringLineReader'] = true
	self['_isType.jk.io.LineReader'] = true
	self.iterator = nil
end

function jk.io.StringLineReader:_construct0()
	jk.io.StringLineReader._init(self)
	return self
end

function jk.io.StringLineReader:_construct1(str)
	jk.io.StringLineReader._init(self)
	self.iterator = _g.jk.lang.CharacterIteratorForString:forString(str)
	return self
end

function jk.io.StringLineReader:readLine()
	if not (self.iterator ~= nil) then
		do return nil end
	end
	do
		local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		while true do
			local c = self.iterator:getNextChar()
			if c < 1 then
				if sb:count() < 1 then
					do return nil end
				end
				do break end
			end
			if c == 13 then
				goto _continue2
			end
			if c == 10 then
				do break end
			end
			do sb:appendCharacter(c) end
			::_continue2::
		end
		if sb:count() < 1 then
			do return "" end
		end
		do return sb:toString() end
	end
end

jk.io.FileDescriptorReader = {}
jk.io.FileDescriptorReader.__index = jk.io.FileDescriptorReader
_vm:set_metatable(jk.io.FileDescriptorReader, {})

function jk.io.FileDescriptorReader._create()
	local v = _vm:set_metatable({}, jk.io.FileDescriptorReader)
	return v
end

function jk.io.FileDescriptorReader:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.io.FileDescriptorReader'
	self['_isType.jk.io.FileDescriptorReader'] = true
	self['_isType.jk.io.Reader'] = true
	self['_isType.jk.lang.Closable'] = true
	self['_isType.jk.io.FileDescriptor'] = true
	self.fd = -1
	self._destructWrapper = _vm:create_destructor(function() self:_destruct() end)
end

function jk.io.FileDescriptorReader:_construct0()
	jk.io.FileDescriptorReader._init(self)
	return self
end

function jk.io.FileDescriptorReader:forFileDescriptor(fd)
	local v = _g.jk.io.FileDescriptorReader._construct0(_g.jk.io.FileDescriptorReader._create())
	do v:setFd(fd) end
	do return v end
end

function jk.io.FileDescriptorReader:_destruct()
	do self:close() end
end

function jk.io.FileDescriptorReader:getFileDescriptor()
	do return self.fd end
end

function jk.io.FileDescriptorReader:read(buffer)
	local v = -1
	local handle = self.fd
	if handle >= 0 then
		do v = _io:read_from_handle(handle, buffer) end
	end
	do return v end
end

function jk.io.FileDescriptorReader:close()
	local handle = self.fd
	if handle >= 0 then
		do _io:close_handle(handle) end
		self.fd = -1
	end
end

function jk.io.FileDescriptorReader:getFd()
	do return self.fd end
end

function jk.io.FileDescriptorReader:setFd(v)
	self.fd = v
	do return self end
end

jk.io.SizedReader = {}

jk.io.BufferReader = {}
jk.io.BufferReader.__index = jk.io.BufferReader
_vm:set_metatable(jk.io.BufferReader, {})

function jk.io.BufferReader._create()
	local v = _vm:set_metatable({}, jk.io.BufferReader)
	return v
end

function jk.io.BufferReader:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.io.BufferReader'
	self['_isType.jk.io.BufferReader'] = true
	self['_isType.jk.io.Reader'] = true
	self['_isType.jk.io.SizedReader'] = true
	self['_isType.jk.io.SeekableReader'] = true
	self.buffer = nil
	self.pos = 0
end

function jk.io.BufferReader:_construct0()
	jk.io.BufferReader._init(self)
	return self
end

function jk.io.BufferReader:readFrom(reader)
	if not (reader ~= nil) then
		do return nil end
	end
	do
		local v = nil
		local tmp = _util:allocate_buffer(1024)
		while true do
			local r = reader:read(tmp)
			if r < 1 then
				do break end
			end
			v = _g.jk.lang.Buffer:append(v, tmp, r)
			if v == nil then
				do break end
			end
		end
		do return v end
	end
end

function jk.io.BufferReader:forBuffer(buf)
	do return _g.jk.io.BufferReader._construct0(_g.jk.io.BufferReader._create()):setBuffer(buf) end
end

function jk.io.BufferReader:setCurrentPosition(n)
	self.pos = n
	do return true end
end

function jk.io.BufferReader:getCurrentPosition()
	do return self.pos end
end

function jk.io.BufferReader:getBuffer()
	do return self.buffer end
end

function jk.io.BufferReader:setBuffer(buf)
	self.buffer = buf
	self.pos = 0
	do return self end
end

function jk.io.BufferReader:rewind()
	self.pos = 0
end

function jk.io.BufferReader:getSize()
	if self.buffer == nil then
		do return 0 end
	end
	do return #self.buffer end
end

function jk.io.BufferReader:read(buf)
	if buf == nil or self.buffer == nil then
		do return 0 end
	end
	do
		local buffersz = #self.buffer
		if self.pos >= buffersz then
			do return 0 end
		end
		do
			local size = #buf
			if size > buffersz - self.pos then
				size = buffersz - self.pos
			end
			do _g.jk.lang.Buffer:copyFrom(buf, self.buffer, self.pos, 0, size) end
			self.pos = self.pos + size
			do return size end
		end
	end
end

function jk.io.BufferReader:getPos()
	do return self.pos end
end

function jk.io.BufferReader:setPos(v)
	self.pos = v
	do return self end
end
jk = jk or {}

jk.fs = jk.fs or {}

jk.fs.File = {}
jk.fs.File.__index = jk.fs.File
_vm:set_metatable(jk.fs.File, {})

function jk.fs.File._create()
	local v = _vm:set_metatable({}, jk.fs.File)
	return v
end

function jk.fs.File:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.fs.File'
	self['_isType.jk.fs.File'] = true
	self['_isType.jk.lang.StringObject'] = true
	self.lastErrorDescription = nil
end

function jk.fs.File:_construct0()
	jk.fs.File._init(self)
	return self
end

function jk.fs.File:asFile(o)
	if not (o ~= nil) then
		do return nil end
	end
	if (_vm:to_table_with_key(o, '_isType.jk.fs.File') ~= nil) then
		do return o end
	end
	do
		local ss = _g.jk.lang.String:asString(o)
		if ss ~= nil then
			do return _g.jk.fs.File:forPath(ss) end
		end
		do return nil end
	end
end

function jk.fs.File:asFileVector(o)
	local it = _g.jk.lang.DynamicObject:iterate(o)
	if not (it ~= nil) then
		do return nil end
	end
	do
		local v = {}
		while true do
			local oo = it:next()
			if not (oo ~= nil) then
				do break end
			end
			do
				local ff = _g.jk.fs.File:asFile(oo)
				if ff ~= nil then
					do _g.jk.lang.Vector:append(v, ff) end
				end
			end
		end
		do return v end
	end
end

function jk.fs.File:forPath(path)
	if path == nil or _g.jk.lang.String:getLength(path) < 1 then
		do return _g.jk.fs.FileInvalid._construct0(_g.jk.fs.FileInvalid._create()) end
	end
	do return _g.jk.fs.FileForSushi:forPath(path) end
end

function jk.fs.File:forRawPath(path)
	do return _g.jk.fs.FileForSushi:forRawPath(path) end
end

function jk.fs.File:forRelativePath(path, relativeTo, alwaysSupportWindowsPathnames)
	if relativeTo == nil then
		do return _g.jk.fs.File:forPath(path) end
	end
	if path == nil then
		do return _g.jk.fs.FileInvalid._construct0(_g.jk.fs.FileInvalid._create()) end
	end
	if _g.jk.fs.PathInfo:isAbsolutePath(path) then
		do return _g.jk.fs.File:forPath(path) end
	end
	do
		local sep = _g.jk.fs.PathInfo:getPathSeparator()
		if sep ~= 47 then
			if _g.jk.lang.String:getIndexOfCharacter(path, sep, 0) < 0 and _g.jk.lang.String:getIndexOfCharacter(path, 47, 0) >= 0 then
				sep = 47
			end
		elseif alwaysSupportWindowsPathnames then
			if _g.jk.lang.String:getIndexOfCharacter(path, sep, 0) < 0 and _g.jk.lang.String:getIndexOfCharacter(path, 92, 0) >= 0 then
				sep = 92
			end
		end
		do
			local f = relativeTo
			local comps = _g.jk.lang.String:split(path, sep, 0)
			if comps ~= nil then
				local n = 0
				local m = _g.jk.lang.Vector:getSize(comps)
				do
					n = 0
					while n < m do
						local comp = comps[n + 1]
						if comp ~= nil then
							if _g.jk.lang.String:isEmpty(comp) then
								goto _continue1
							end
							f = f:entry(comp)
						end
						::_continue1::
						do n = n + 1 end
					end
				end
			end
			do return f end
		end
	end
end

function jk.fs.File:entry(name)
end

function jk.fs.File:rawEntry(name)
	do return self:entry(name) end
end

function jk.fs.File:entries()
end

function jk.fs.File:move(dest, replace)
end

function jk.fs.File:touch()
end

function jk.fs.File:read()
end

function jk.fs.File:write()
end

function jk.fs.File:append()
end

function jk.fs.File:stat()
end

function jk.fs.File:createDirectory()
end

function jk.fs.File:createDirectoryRecursive()
end

function jk.fs.File:removeDirectory()
end

function jk.fs.File:getPath()
end

function jk.fs.File:remove()
end

function jk.fs.File:makeExecutable()
end

function jk.fs.File:getRelativePath(baseFile, prefix)
	if not (baseFile ~= nil) then
		do return nil end
	end
	do
		local vp = self:getPath()
		local bp = baseFile:getPath()
		while _g.jk.lang.String:endsWith(bp, "/") or _g.jk.lang.String:endsWith(bp, "\\") do
			bp = _g.jk.lang.String:getSubString(bp, 0, _g.jk.lang.String:getLength(bp) - 1)
		end
		if _g.jk.lang.String:startsWith(vp, _g.jk.lang.String:safeString(bp) .. "/", 0) or _g.jk.lang.String:startsWith(vp, _g.jk.lang.String:safeString(bp) .. "\\", 0) then
			if prefix ~= nil then
				do return _g.jk.lang.String:safeString(prefix) .. _g.jk.lang.String:safeString(_g.jk.lang.String:getEndOfString(vp, _g.jk.lang.String:getLength(bp))) end
			end
			do return _g.jk.lang.String:getEndOfString(vp, _g.jk.lang.String:getLength(bp) + 1) end
		end
		do return nil end
	end
end

function jk.fs.File:getRelativePathOrBasename(baseFile, prefix)
	local v = self:getRelativePath(baseFile, prefix)
	if v ~= nil then
		do return v end
	end
	do return self:getBasename() end
end

function jk.fs.File:rename(newname, replace)
	do return self:move(_g.jk.fs.File:forRelativePath(newname, self:getParent(), false), replace) end
end

function jk.fs.File:writeFromReader(reader, doAppend)
	do self:onError(nil) end
	if not (reader ~= nil) then
		do return false end
	end
	do
		local buffer = _util:allocate_buffer(1024)
		if not (buffer ~= nil) then
			do return false end
		end
		do
			local writer = nil
			if doAppend then
				writer = self:append()
			else
				writer = self:write()
			end
			if not (writer ~= nil) then
				do return false end
			end
			do
				local v = true
				while true do
					local r = reader:read(buffer)
					if r < 1 then
						do break end
					end
					do
						local w = writer:write(buffer, r)
						if w < r then
							v = false
							do break end
						end
					end
				end
				do writer:close() end
				do return v end
			end
		end
	end
end

function jk.fs.File:createFifo()
	do self:onError("Not supported") end
	do return false end
end

function jk.fs.File:isExecutable()
	if _g.jk.os.OS:isWindows() then
		do return self:hasExtension("exe") or self:hasExtension("bat") or self:hasExtension("cmd") or self:hasExtension("com") end
	end
	do return self:stat():getExecutable() end
end

function jk.fs.File:exists()
	do self:onError(nil) end
	do
		local fi = self:stat()
		do return fi:getType() ~= _g.jk.fs.FileInfo.FILE_TYPE_UNKNOWN end
	end
end

function jk.fs.File:isIdentical(file)
	if not (file ~= nil) then
		do return false end
	end
	do
		local myrd = self:read()
		if not (myrd ~= nil) then
			do return false end
		end
		do
			local oord = file:read()
			if not (oord ~= nil) then
				do return false end
			end
			do
				local mybuf = _util:allocate_buffer(1024)
				if not (mybuf ~= nil) then
					do return false end
				end
				do
					local oobuf = _util:allocate_buffer(1024)
					if not (oobuf ~= nil) then
						do return false end
					end
					do
						local v = true
						while v do
							local myr = myrd:read(mybuf)
							local oor = oord:read(oobuf)
							if myr ~= oor then
								v = false
							else
								if myr < 1 then
									do break end
								end
								do
									local n = 0
									while n < myr do
										if mybuf[n + 1] ~= oobuf[n + 1] then
											v = false
										end
										do n = n + 1 end
									end
								end
							end
						end
						do myrd:close() end
						do oord:close() end
						do return v end
					end
				end
			end
		end
	end
end

jk.fs.File.ReadLineIterator = {}
jk.fs.File.ReadLineIterator.__index = jk.fs.File.ReadLineIterator
_vm:set_metatable(jk.fs.File.ReadLineIterator, {})

function jk.fs.File.ReadLineIterator._create()
	local v = _vm:set_metatable({}, jk.fs.File.ReadLineIterator)
	return v
end

function jk.fs.File.ReadLineIterator:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.fs.File.ReadLineIterator'
	self['_isType.jk.fs.File.ReadLineIterator'] = true
	self['_isType.jk.lang.Iterator'] = true
	self.reader = nil
end

function jk.fs.File.ReadLineIterator:_construct0()
	jk.fs.File.ReadLineIterator._init(self)
	return self
end

function jk.fs.File.ReadLineIterator:next()
	if not (self.reader ~= nil) then
		do return nil end
	end
	do
		local v = self.reader:readLine()
		if v == nil then
			do self.reader:close() end
			self.reader = nil
		end
		do return v end
	end
end

function jk.fs.File.ReadLineIterator:hasNext()
	if not (self.reader ~= nil) then
		do return false end
	end
	do return not self.reader:hasEnded() end
end

function jk.fs.File.ReadLineIterator:getReader()
	do return self.reader end
end

function jk.fs.File.ReadLineIterator:setReader(v)
	self.reader = v
	do return self end
end

function jk.fs.File:getLastErrorDescription()
	do return self.lastErrorDescription end
end

function jk.fs.File:onError(v)
	local pp = self:getPath()
	if not (v ~= nil) then
		self.lastErrorDescription = nil
	elseif pp ~= nil then
		self.lastErrorDescription = _g.jk.lang.String:safeString(pp) .. ": " .. _g.jk.lang.String:safeString(v)
	else
		self.lastErrorDescription = v
	end
end

function jk.fs.File:readLines()
	local rd = _g.jk.io.PrintReader:forReader(self:read())
	if not (rd ~= nil) then
		do return nil end
	end
	do return _g.jk.fs.File.ReadLineIterator._construct0(_g.jk.fs.File.ReadLineIterator._create()):setReader(rd) end
end

function jk.fs.File:readLinesVector()
	local it = self:readLines()
	if not (it ~= nil) then
		do return nil end
	end
	do
		local v = {}
		while true do
			local line = it:next()
			if not (line ~= nil) then
				do break end
			end
			do _g.jk.lang.Vector:append(v, line) end
		end
		do return v end
	end
end

function jk.fs.File:hasChangedSince(originalTimeStamp)
	local nts = self:getLastModifiedTimeStamp()
	if nts > originalTimeStamp then
		do return true end
	end
	do return false end
end

function jk.fs.File:getLastModifiedTimeStamp()
	if self:isFile() == false then
		do return 0 end
	end
	do
		local st = self:stat()
		if st == nil then
			do return 0 end
		end
		do return st:getModifyTime() end
	end
end

function jk.fs.File:compareModificationTime(bf)
	if bf == nil then
		do return 1 end
	end
	do
		local myts = self:getLastModifiedTimeStamp()
		local bfts = bf:getLastModifiedTimeStamp()
		if myts < bfts then
			do return -1 end
		end
		if myts > bfts then
			do return 1 end
		end
		do return 0 end
	end
end

function jk.fs.File:isNewerThan(bf)
	do return self:compareModificationTime(bf) > 0 end
end

function jk.fs.File:isOlderThan(bf)
	do return self:compareModificationTime(bf) < 0 end
end

function jk.fs.File:isSame(file)
	do self:onError(nil) end
	if not (file ~= nil) then
		do return false end
	end
	do
		local path = self:getPath()
		if path ~= nil and path == file:getPath() then
			do return true end
		end
		do return false end
	end
end

function jk.fs.File:removeRecursive()
	do self:onError(nil) end
	do
		local finfo = self:stat()
		if not (finfo ~= nil) then
			do return true end
		end
		if finfo:isDirectory() == false or finfo:isLink() == true then
			do return self:remove() end
		end
		do
			local it = self:entries()
			if not (it ~= nil) then
				do return false end
			end
			while it ~= nil do
				local f = it:next()
				if not (f ~= nil) then
					do break end
				end
				if not f:removeRecursive() then
					do self:onError(f:getLastErrorDescription()) end
					do return false end
				end
			end
			do return self:removeDirectory() end
		end
	end
end

function jk.fs.File:isFile()
	local st = self:stat()
	if not (st ~= nil) then
		do return false end
	end
	do return st:isFile() end
end

function jk.fs.File:isDirectory()
	local st = self:stat()
	if not (st ~= nil) then
		do return false end
	end
	do return st:isDirectory() end
end

function jk.fs.File:isLink()
	local st = self:stat()
	if not (st ~= nil) then
		do return false end
	end
	do return st:isLink() end
end

function jk.fs.File:getSize()
	local st = self:stat()
	if st == nil then
		do return 0 end
	end
	do return st:getSize() end
end

function jk.fs.File:setMode(mode)
	do self:onError("Not supported") end
	do return false end
end

function jk.fs.File:setOwnerUser(uid)
	do self:onError("Not supported") end
	do return false end
end

function jk.fs.File:setOwnerGroup(gid)
	do self:onError("Not supported") end
	do return false end
end

function jk.fs.File:withExtension(ext)
	if not (ext ~= nil) then
		do return self end
	end
	do
		local bn = self:getBasename()
		do return self:getSibling(_g.jk.lang.String:safeString(bn) .. "." .. _g.jk.lang.String:safeString(ext)) end
	end
end

function jk.fs.File:asExecutable()
	if _g.jk.os.OS:isWindows() then
		if self:hasExtension("exe") == false and self:hasExtension("bat") == false and self:hasExtension("cmd") == false and self:hasExtension("com") == false then
			local exe = self:withExtension("exe")
			if exe:isFile() then
				do return exe end
			end
			do
				local bat = self:withExtension("bat")
				if bat:isFile() then
					do return bat end
				end
				do
					local cmd = self:withExtension("cmd")
					if cmd:isFile() then
						do return cmd end
					end
					do
						local com = self:withExtension("com")
						if com:isFile() then
							do return com end
						end
						do return exe end
					end
				end
			end
		end
	end
	do return self end
end

function jk.fs.File:getParent()
	do self:onError(nil) end
	do
		local path = self:directoryName()
		if path == nil then
			do return _g.jk.fs.FileInvalid._construct0(_g.jk.fs.FileInvalid._create()) end
		end
		do return _g.jk.fs.File:forPath(path) end
	end
end

function jk.fs.File:getSibling(name)
	local pp = self:getParent()
	if not (pp ~= nil) then
		do return nil end
	end
	if name == nil then
		do return pp end
	end
	do return pp:entry(name) end
end

function jk.fs.File:hasExtension(ext)
	local xx = self:extension()
	if not (xx ~= nil) then
		do return false end
	end
	do return _g.jk.lang.String:equalsIgnoreCase(xx, ext) end
end

function jk.fs.File:extension()
	local bn = self:getBasename()
	if not (bn ~= nil) then
		do return nil end
	end
	do
		local dot = _g.jk.lang.String:getLastIndexOfCharacter(bn, 46, -1)
		if dot < 0 then
			do return nil end
		end
		do return _g.jk.lang.String:getEndOfString(bn, dot + 1) end
	end
end

function jk.fs.File:directoryName()
	local path = self:getPath()
	if not (path ~= nil) then
		do return nil end
	end
	do
		local delim = _g.jk.fs.PathInfo:getPathSeparator()
		local dp = _g.jk.lang.String:getLastIndexOfCharacter(path, delim, -1)
		if delim ~= 47 then
			local sdp = _g.jk.lang.String:getLastIndexOfCharacter(path, 47, -1)
			if sdp > dp then
				dp = sdp
			end
		end
		if dp < 0 then
			do return "." end
		end
		do return _g.jk.lang.String:getSubString(path, 0, dp) end
	end
end

function jk.fs.File:getBasename()
	local path = self:getPath()
	if not (path ~= nil) then
		do return nil end
	end
	do
		local delim = _g.jk.fs.PathInfo:getPathSeparator()
		if _g.jk.lang.String:endsWith(path, _g.jk.lang.String:forCharacter(delim)) then
			path = _g.jk.lang.String:getSubString(path, 0, _g.jk.lang.String:getLength(path) - 1)
		end
		if delim ~= 47 and _g.jk.lang.String:endsWith(path, "/") then
			path = _g.jk.lang.String:getSubString(path, 0, _g.jk.lang.String:getLength(path) - 1)
		end
		do
			local dp = _g.jk.lang.String:getLastIndexOfCharacter(path, delim, -1)
			if delim ~= 47 then
				local sdp = _g.jk.lang.String:getLastIndexOfCharacter(path, 47, -1)
				if sdp > dp then
					dp = sdp
				end
			end
			if dp < 0 then
				do return path end
			end
			do return _g.jk.lang.String:getEndOfString(path, dp + 1) end
		end
	end
end

function jk.fs.File:getBasenameWithoutExtension()
	local bn = self:getBasename()
	if not (bn ~= nil) then
		do return nil end
	end
	do
		local dot = _g.jk.lang.String:getLastIndexOfCharacter(bn, 46, -1)
		if dot < 0 then
			do return bn end
		end
		do return _g.jk.lang.String:getSubString(bn, 0, dot) end
	end
end

function jk.fs.File:baseName()
	do return self:getBasename() end
end

function jk.fs.File:baseNameWithoutExtension()
	do return self:getBasenameWithoutExtension() end
end

function jk.fs.File:copyFileTo(dest)
	do self:onError(nil) end
	if not (dest ~= nil) then
		do return false end
	end
	if self:isSame(dest) then
		do return true end
	end
	do
		local buf = _util:allocate_buffer(4096 * 4)
		if not (buf ~= nil) then
			do return false end
		end
		do
			local reader = self:read()
			if not (reader ~= nil) then
				do return false end
			end
			do
				local writer = dest:write()
				if not (writer ~= nil) then
					if (_vm:to_table_with_key(reader, '_isType.jk.lang.Closable') ~= nil) then
						do reader:close() end
					end
					do self:onError(dest:getLastErrorDescription()) end
					do return false end
				end
				do
					local v = true
					local n = 0
					while (function()
						n = reader:read(buf)
						do return n end
					end)() > 0 do
						local nr = writer:write(buf, n)
						if nr ~= n then
							v = false
							do break end
						end
					end
					if v then
						local fi = self:stat()
						if fi ~= nil then
							local mode = fi:getMode()
							if mode ~= 0 then
								do dest:setMode(mode) end
							end
						end
					else
						do dest:remove() end
					end
					if reader ~= nil and (_vm:to_table_with_key(reader, '_isType.jk.lang.Closable') ~= nil) then
						do reader:close() end
					end
					if writer ~= nil and (_vm:to_table_with_key(writer, '_isType.jk.lang.Closable') ~= nil) then
						do writer:close() end
					end
					do return v end
				end
			end
		end
	end
end

function jk.fs.File:copyFileOrDirectoryTo(dest)
	if not (dest ~= nil) then
		do return false end
	end
	if self:isFile() then
		do return self:copyFileTo(dest) end
	end
	if not self:isDirectory() then
		do return false end
	end
	if not dest:createDirectoryRecursive() then
		do return false end
	end
	do
		local it = self:entries()
		if not (it ~= nil) then
			do return false end
		end
		while true do
			local nsrc = it:next()
			if not (nsrc ~= nil) then
				do break end
			end
			do
				local ndest = dest:entry(nsrc:getBasename())
				if not nsrc:copyFileOrDirectoryTo(ndest) then
					do return false end
				end
			end
		end
		do return true end
	end
end

function jk.fs.File:setContentsString(str, encoding)
	if _g.jk.lang.String:isEmpty(encoding) then
		do return false end
	end
	do return self:setContentsBuffer(_g.jk.lang.String:toBuffer(str, encoding)) end
end

function jk.fs.File:setContentsUTF8(str)
	do return self:setContentsBuffer(_g.jk.lang.String:toUTF8Buffer(str)) end
end

function jk.fs.File:setContentsBuffer(buffer)
	do self:onError(nil) end
	if not (buffer ~= nil) then
		do return false end
	end
	do
		local writer = self:write()
		if not (writer ~= nil) then
			do return false end
		end
		if writer:write(buffer, #buffer) < 0 then
			do return false end
		end
		do writer:close() end
		do return true end
	end
end

function jk.fs.File:getContentsString(encoding)
	if _g.jk.lang.String:isEmpty(encoding) then
		do return nil end
	end
	do
		local b = self:getContentsBuffer()
		if not (b ~= nil) then
			if self:isFile() and self:getSize() == 0 then
				do return "" end
			end
			do return nil end
		end
		do return _g.jk.lang.String:forBuffer(b, encoding) end
	end
end

function jk.fs.File:getContentsUTF8()
	local b = self:getContentsBuffer()
	if not (b ~= nil) then
		if self:isFile() and self:getSize() == 0 then
			do return "" end
		end
		do return nil end
	end
	do return _g.jk.lang.String:forUTF8Buffer(b) end
end

function jk.fs.File:getContentsBuffer()
	do self:onError(nil) end
	do
		local reader = self:read()
		if not (reader ~= nil) then
			do return nil end
		end
		do
			local sz = reader:getSize()
			if sz < 1 then
				do reader:close() end
				do return nil end
			end
			do
				local b = _util:allocate_buffer(sz)
				local rsz = reader:read(b)
				do reader:close() end
				if rsz < sz then
					do return nil end
				end
				do return b end
			end
		end
	end
end

function jk.fs.File:toString()
	do return self:getPath() end
end

jk.fs.FileFinder = {}
jk.fs.FileFinder.__index = jk.fs.FileFinder
_vm:set_metatable(jk.fs.FileFinder, {})

function jk.fs.FileFinder._create()
	local v = _vm:set_metatable({}, jk.fs.FileFinder)
	return v
end

function jk.fs.FileFinder:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.fs.FileFinder'
	self['_isType.jk.fs.FileFinder'] = true
	self['_isType.jk.lang.Iterator'] = true
	self.root = nil
	self.patterns = nil
	self.excludePatterns = nil
	self.stack = nil
	self.includeMatchingDirectories = false
	self.includeDirectories = false
end

function jk.fs.FileFinder:forRoot(root)
	do return _g.jk.fs.FileFinder._construct0(_g.jk.fs.FileFinder._create()):setRoot(root) end
end

jk.fs.FileFinder.Pattern = {}
jk.fs.FileFinder.Pattern.__index = jk.fs.FileFinder.Pattern
_vm:set_metatable(jk.fs.FileFinder.Pattern, {})

function jk.fs.FileFinder.Pattern._create()
	local v = _vm:set_metatable({}, jk.fs.FileFinder.Pattern)
	return v
end

function jk.fs.FileFinder.Pattern:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.fs.FileFinder.Pattern'
	self['_isType.jk.fs.FileFinder.Pattern'] = true
	self.pattern = nil
	self.suffix = nil
	self.prefix = nil
end

function jk.fs.FileFinder.Pattern:_construct0()
	jk.fs.FileFinder.Pattern._init(self)
	return self
end

function jk.fs.FileFinder.Pattern:setPattern(pattern)
	self.pattern = pattern
	if pattern ~= nil then
		if _g.jk.lang.String:startsWith(pattern, "*", 0) then
			self.suffix = _g.jk.lang.String:getEndOfString(pattern, 1)
		end
		if _g.jk.lang.String:endsWith(pattern, "*") then
			self.prefix = _g.jk.lang.String:getSubString(pattern, 0, _g.jk.lang.String:getLength(pattern) - 1)
		end
	end
	do return self end
end

function jk.fs.FileFinder.Pattern:match(check)
	if not (check ~= nil) then
		do return false end
	end
	if self.pattern == check then
		do return true end
	end
	if self.suffix ~= nil and _g.jk.lang.String:endsWith(check, self.suffix) then
		do return true end
	end
	if self.prefix ~= nil and _g.jk.lang.String:startsWith(check, self.prefix, 0) then
		do return true end
	end
	do return false end
end

function jk.fs.FileFinder:_construct0()
	jk.fs.FileFinder._init(self)
	self.patterns = {}
	self.excludePatterns = {}
	return self
end

function jk.fs.FileFinder:setRoot(root)
	self.root = root
	self.stack = nil
	do return self end
end

function jk.fs.FileFinder:addPattern(pattern)
	do _g.jk.lang.Vector:append(self.patterns, _g.jk.fs.FileFinder.Pattern._construct0(_g.jk.fs.FileFinder.Pattern._create()):setPattern(pattern)) end
	do return self end
end

function jk.fs.FileFinder:addExcludePattern(pattern)
	do _g.jk.lang.Vector:append(self.excludePatterns, _g.jk.fs.FileFinder.Pattern._construct0(_g.jk.fs.FileFinder.Pattern._create()):setPattern(pattern)) end
	do return self end
end

function jk.fs.FileFinder:matchPattern(file)
	if not (file ~= nil) then
		do return false end
	end
	if _g.jk.lang.Vector:getSize(self.patterns) < 1 then
		do return true end
	end
	do
		local filename = file:getBasename()
		if self.patterns ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(self.patterns)
			do
				n = 0
				while n < m do
					local pattern = self.patterns[n + 1]
					if pattern ~= nil then
						if pattern:match(filename) then
							do return true end
						end
					end
					do n = n + 1 end
				end
			end
		end
		do return false end
	end
end

function jk.fs.FileFinder:matchExcludePattern(file)
	if not (file ~= nil) then
		do return false end
	end
	if _g.jk.lang.Vector:getSize(self.excludePatterns) < 1 then
		do return false end
	end
	do
		local filename = file:getBasename()
		if self.excludePatterns ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(self.excludePatterns)
			do
				n = 0
				while n < m do
					local pattern = self.excludePatterns[n + 1]
					if pattern ~= nil then
						if pattern:match(filename) then
							do return true end
						end
					end
					do n = n + 1 end
				end
			end
		end
		do return false end
	end
end

function jk.fs.FileFinder:next()
	while true do
		if not (self.stack ~= nil) then
			if not (self.root ~= nil) then
				do break end
			end
			do
				local es = self.root:entries()
				self.root = nil
				if not (es ~= nil) then
					do break end
				end
				self.stack = _g.jk.lang.Stack._construct0(_g.jk.lang.Stack._create())
				do self.stack:push(es) end
			end
		end
		do
			local entries = self.stack:peek()
			if not (entries ~= nil) then
				self.stack = nil
				do break end
			end
			do
				local e = entries:next()
				if not (e ~= nil) then
					do self.stack:pop() end
				elseif self:matchExcludePattern(e) then
				elseif e:isFile() then
					if self:matchPattern(e) then
						do return e end
					end
				elseif self.includeMatchingDirectories and e:isDirectory() and self:matchPattern(e) then
					do return e end
				elseif e:isDirectory() and e:isLink() == false then
					local ees = e:entries()
					if ees ~= nil then
						do self.stack:push(ees) end
					end
					if self.includeDirectories then
						do return e end
					end
				end
			end
		end
	end
	do return nil end
end

function jk.fs.FileFinder:hasNext()
	if not (self.stack ~= nil) then
		do return false end
	end
	do
		local it = self.stack:peek()
		if not (it ~= nil) then
			do return false end
		end
		do return it:hasNext() end
	end
end

function jk.fs.FileFinder:getIncludeMatchingDirectories()
	do return self.includeMatchingDirectories end
end

function jk.fs.FileFinder:setIncludeMatchingDirectories(v)
	self.includeMatchingDirectories = v
	do return self end
end

function jk.fs.FileFinder:getIncludeDirectories()
	do return self.includeDirectories end
end

function jk.fs.FileFinder:setIncludeDirectories(v)
	self.includeDirectories = v
	do return self end
end

jk.fs.FileInvalid = _g.jk.fs.File._create()
jk.fs.FileInvalid.__index = jk.fs.FileInvalid
_vm:set_metatable(jk.fs.FileInvalid, {
	__index = _g.jk.fs.File
})

function jk.fs.FileInvalid._create()
	local v = _vm:set_metatable({}, jk.fs.FileInvalid)
	return v
end

function jk.fs.FileInvalid:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.fs.FileInvalid'
	self['_isType.jk.fs.FileInvalid'] = true
end

function jk.fs.FileInvalid:_construct0()
	jk.fs.FileInvalid._init(self)
	do _g.jk.fs.File._construct0(self) end
	return self
end

function jk.fs.FileInvalid:entry(name)
	do return _g.jk.fs.FileInvalid._construct0(_g.jk.fs.FileInvalid._create()) end
end

function jk.fs.FileInvalid:makeExecutable()
	do return false end
end

function jk.fs.FileInvalid:move(dest, replace)
	do return false end
end

function jk.fs.FileInvalid:touch()
	do return false end
end

function jk.fs.FileInvalid:read()
	do return nil end
end

function jk.fs.FileInvalid:write()
	do return nil end
end

function jk.fs.FileInvalid:append()
	do return nil end
end

function jk.fs.FileInvalid:stat()
	do return nil end
end

function jk.fs.FileInvalid:exists()
	do return false end
end

function jk.fs.FileInvalid:isExecutable()
	do return false end
end

function jk.fs.FileInvalid:createFifo()
	do return false end
end

function jk.fs.FileInvalid:createDirectory()
	do return false end
end

function jk.fs.FileInvalid:createDirectoryRecursive()
	do return false end
end

function jk.fs.FileInvalid:removeDirectory()
	do return false end
end

function jk.fs.FileInvalid:getPath()
	do return nil end
end

function jk.fs.FileInvalid:isSame(file)
	do return false end
end

function jk.fs.FileInvalid:remove()
	do return false end
end

function jk.fs.FileInvalid:removeRecursive()
	do return false end
end

function jk.fs.FileInvalid:getBasename()
	do return nil end
end

function jk.fs.FileInvalid:isIdentical(file)
	do return false end
end

function jk.fs.FileInvalid:getContentsBuffer()
	do return nil end
end

function jk.fs.FileInvalid:getContentsString(encoding)
	do return nil end
end

function jk.fs.FileInvalid:setContentsBuffer(buffer)
	do return false end
end

function jk.fs.FileInvalid:setContentsString(str, encoding)
	do return false end
end

function jk.fs.FileInvalid:entries()
	do return nil end
end

jk.fs.FileKit = {}
jk.fs.FileKit.__index = jk.fs.FileKit
_vm:set_metatable(jk.fs.FileKit, {})

function jk.fs.FileKit._create()
	local v = _vm:set_metatable({}, jk.fs.FileKit)
	return v
end

function jk.fs.FileKit:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.fs.FileKit'
	self['_isType.jk.fs.FileKit'] = true
	self.ctx = nil
end

function jk.fs.FileKit:_construct0()
	jk.fs.FileKit._init(self)
	return self
end

function jk.fs.FileKit:_construct1(ctx)
	jk.fs.FileKit._init(self)
	self.ctx = ctx
	return self
end

function jk.fs.FileKit:asFile(file)
	local fo = _g.jk.fs.File:asFile(file)
	if not (fo ~= nil) then
		do _g.jk.lang.Error:throw("invalidParameter", _g.jk.lang.String:asString(file)) end
	end
	do return fo end
end

function jk.fs.FileKit:copy(src, dst)
	local srcf = self:asFile(src)
	local dstf = self:asFile(dst)
	if dstf:isDirectory() then
		dstf = dstf:entry(srcf:getBasename())
	end
	if not srcf:copyFileOrDirectoryTo(dstf) then
		do _g.jk.lang.Error:throw("failedToCopy", srcf:getPath()) end
	end
	do return dstf end
end

function jk.fs.FileKit:remove(file)
	local fo = self:asFile(file)
	if not fo:removeRecursive() then
		do _g.jk.lang.Error:throw("failedToRemove", fo:getPath()) end
	end
end

function jk.fs.FileKit:readAsBuffer(file)
	local fo = self:asFile(file)
	local v = fo:getContentsBuffer()
	if not (v ~= nil) then
		do _g.jk.lang.Error:throw("failedToRead", fo:getPath()) end
	end
	do return v end
end

function jk.fs.FileKit:readAsString(file)
	local fo = self:asFile(file)
	local v = fo:getContentsUTF8()
	if not (v ~= nil) then
		do _g.jk.lang.Error:throw("failedToRead", fo:getPath()) end
	end
	do return v end
end

function jk.fs.FileKit:writeBuffer(file, data)
	local fo = self:asFile(file)
	if not fo:setContentsBuffer(data) then
		do _g.jk.lang.Error:throw("failedToWrite", fo:getPath()) end
	end
end

function jk.fs.FileKit:writeString(file, data)
	local fo = self:asFile(file)
	if not fo:setContentsUTF8(_g.jk.lang.String:asString(data)) then
		do _g.jk.lang.Error:throw("failedToWrite", fo:getPath()) end
	end
end

jk.fs.FileReader = {}

jk.fs.CurrentDirectory = {}
jk.fs.CurrentDirectory.__index = jk.fs.CurrentDirectory
_vm:set_metatable(jk.fs.CurrentDirectory, {})

function jk.fs.CurrentDirectory._create()
	local v = _vm:set_metatable({}, jk.fs.CurrentDirectory)
	return v
end

function jk.fs.CurrentDirectory:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.fs.CurrentDirectory'
	self['_isType.jk.fs.CurrentDirectory'] = true
end

function jk.fs.CurrentDirectory:_construct0()
	jk.fs.CurrentDirectory._init(self)
	return self
end

function jk.fs.CurrentDirectory:set(dir)
	if not (dir ~= nil) then
		do return end
	end
	do _io:set_current_directory(dir:getPath()) end
end

function jk.fs.CurrentDirectory:get()
	do return _g.jk.fs.File:forPath(_io:get_current_directory()) end
end

jk.fs.FileWriter = {}

jk.fs.FileInfo = {}
jk.fs.FileInfo.__index = jk.fs.FileInfo
_vm:set_metatable(jk.fs.FileInfo, {})

jk.fs.FileInfo.FILE_TYPE_UNKNOWN = 0
jk.fs.FileInfo.FILE_TYPE_FILE = 1
jk.fs.FileInfo.FILE_TYPE_DIR = 2

function jk.fs.FileInfo._create()
	local v = _vm:set_metatable({}, jk.fs.FileInfo)
	return v
end

function jk.fs.FileInfo:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.fs.FileInfo'
	self['_isType.jk.fs.FileInfo'] = true
	self.file = nil
	self.size = 0
	self.createTime = 0
	self.accessTime = 0
	self.modifyTime = 0
	self.ownerUser = 0
	self.ownerGroup = 0
	self.mode = 0
	self.executable = false
	self.type = 0
	self.link = false
end

function jk.fs.FileInfo:_construct0()
	jk.fs.FileInfo._init(self)
	return self
end

function jk.fs.FileInfo:forFile(file)
	if file == nil then
		do return _g.jk.fs.FileInfo._construct0(_g.jk.fs.FileInfo._create()) end
	end
	do return file:stat() end
end

function jk.fs.FileInfo:setFile(v)
	self.file = v
end

function jk.fs.FileInfo:setSize(v)
	self.size = v
end

function jk.fs.FileInfo:setCreateTime(v)
	self.createTime = v
end

function jk.fs.FileInfo:setAccessTime(v)
	self.accessTime = v
end

function jk.fs.FileInfo:setModifyTime(v)
	self.modifyTime = v
end

function jk.fs.FileInfo:setOwnerUser(v)
	self.ownerUser = v
end

function jk.fs.FileInfo:setOwnerGroup(v)
	self.ownerGroup = v
end

function jk.fs.FileInfo:setMode(v)
	self.mode = v
end

function jk.fs.FileInfo:setExecutable(v)
	self.executable = v
end

function jk.fs.FileInfo:setType(v)
	self.type = v
end

function jk.fs.FileInfo:setLink(v)
	self.link = v
end

function jk.fs.FileInfo:getFile()
	do return self.file end
end

function jk.fs.FileInfo:getSize()
	do return self.size end
end

function jk.fs.FileInfo:getCreateTime()
	do return self.createTime end
end

function jk.fs.FileInfo:getCreateTimeUTC()
	do return self.createTime + _g.jk.time.SystemClock:getTimezoneOffsetAsSeconds() end
end

function jk.fs.FileInfo:getAccessTime()
	do return self.accessTime end
end

function jk.fs.FileInfo:getAccessTimeUTC()
	do return self.accessTime + _g.jk.time.SystemClock:getTimezoneOffsetAsSeconds() end
end

function jk.fs.FileInfo:getModifyTime()
	do return self.modifyTime end
end

function jk.fs.FileInfo:getModifyTimeUTC()
	do return self.modifyTime + _g.jk.time.SystemClock:getTimezoneOffsetAsSeconds() end
end

function jk.fs.FileInfo:getOwnerUser()
	do return self.ownerUser end
end

function jk.fs.FileInfo:getOwnerGroup()
	do return self.ownerGroup end
end

function jk.fs.FileInfo:getMode()
	do return self.mode end
end

function jk.fs.FileInfo:getExecutable()
	do return self.executable end
end

function jk.fs.FileInfo:getType()
	do return self.type end
end

function jk.fs.FileInfo:getLink()
	do return self.link end
end

function jk.fs.FileInfo:isFile()
	if self.type == _g.jk.fs.FileInfo.FILE_TYPE_FILE then
		do return true end
	end
	do return false end
end

function jk.fs.FileInfo:isLink()
	do return self.link end
end

function jk.fs.FileInfo:isDirectory()
	if self.type == _g.jk.fs.FileInfo.FILE_TYPE_DIR then
		do return true end
	end
	do return false end
end

function jk.fs.FileInfo:exists()
	do return self:isFile() or self:isDirectory() or self:isLink() end
end

jk.fs.PathInfo = {}
jk.fs.PathInfo.__index = jk.fs.PathInfo
_vm:set_metatable(jk.fs.PathInfo, {})

function jk.fs.PathInfo._create()
	local v = _vm:set_metatable({}, jk.fs.PathInfo)
	return v
end

function jk.fs.PathInfo:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.fs.PathInfo'
	self['_isType.jk.fs.PathInfo'] = true
end

function jk.fs.PathInfo:_construct0()
	jk.fs.PathInfo._init(self)
	return self
end

function jk.fs.PathInfo:getPathSeparator()
	if _g.jk.os.OS:isWindows() then
		do return 92 end
	end
	do return 47 end
end

function jk.fs.PathInfo:isAbsolutePath(path)
	if not (path ~= nil) then
		do return false end
	end
	do
		local c0 = _g.jk.lang.String:getChar(path, 0)
		if c0 == 47 then
			do return true end
		end
		if _g.jk.os.OS:isWindows() then
			if c0 == 92 then
				do return true end
			end
			if _g.jk.lang.Character:isAlpha(c0) and _g.jk.lang.String:getChar(path, 1) == 58 then
				local d = _g.jk.lang.String:getChar(path, 2)
				if d == 92 or d == 47 then
					do return true end
				end
			end
		end
		do return false end
	end
end

jk.fs.FileForSushi = _g.jk.fs.File._create()
jk.fs.FileForSushi.__index = jk.fs.FileForSushi
_vm:set_metatable(jk.fs.FileForSushi, {
	__index = _g.jk.fs.File
})

function jk.fs.FileForSushi._create()
	local v = _vm:set_metatable({}, jk.fs.FileForSushi)
	return v
end

function jk.fs.FileForSushi:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.fs.FileForSushi'
	self['_isType.jk.fs.FileForSushi'] = true
	self.path = nil
end

function jk.fs.FileForSushi:_construct0()
	jk.fs.FileForSushi._init(self)
	do _g.jk.fs.File._construct0(self) end
	return self
end

jk.fs.FileForSushi.MyFileReader = {}
jk.fs.FileForSushi.MyFileReader.__index = jk.fs.FileForSushi.MyFileReader
_vm:set_metatable(jk.fs.FileForSushi.MyFileReader, {})

function jk.fs.FileForSushi.MyFileReader._create()
	local v = _vm:set_metatable({}, jk.fs.FileForSushi.MyFileReader)
	return v
end

function jk.fs.FileForSushi.MyFileReader:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.fs.FileForSushi.MyFileReader'
	self['_isType.jk.fs.FileForSushi.MyFileReader'] = true
	self['_isType.jk.fs.FileReader'] = true
	self['_isType.jk.io.SizedReader'] = true
	self['_isType.jk.io.Reader'] = true
	self['_isType.jk.lang.Closable'] = true
	self['_isType.jk.io.SeekableReader'] = true
	self.handle = -1
	self.file = nil
	self._destructWrapper = _vm:create_destructor(function() self:_destruct() end)
end

function jk.fs.FileForSushi.MyFileReader:_construct0()
	jk.fs.FileForSushi.MyFileReader._init(self)
	return self
end

function jk.fs.FileForSushi.MyFileReader:_destruct()
	do self:close() end
end

function jk.fs.FileForSushi.MyFileReader:read(buffer)
	local v = -1
	local handle = self.handle
	if handle >= 0 then
		do v = _io:read_from_handle(handle, buffer) end
	end
	do return v end
end

function jk.fs.FileForSushi.MyFileReader:getSize()
	local v = -1
	local handle = self.handle
	if handle >= 0 then
		do v = _io:get_size_for_handle(handle) end
	end
	do return v end
end

function jk.fs.FileForSushi.MyFileReader:close()
	local handle = self.handle
	if handle >= 0 then
		do _io:close_handle(handle) end
		self.handle = -1
	end
end

function jk.fs.FileForSushi.MyFileReader:setCurrentPosition(n)
	local handle = self.handle
	if handle < 0 then
		do return false end
	end
	if _io:set_current_position(handle, n) < 0 then
		do return false end
	end
	do return true end
end

function jk.fs.FileForSushi.MyFileReader:getCurrentPosition()
	local handle = self.handle
	if handle < 0 then
		do return 0 end
	end
	do return _io:get_current_position(handle) end
end

function jk.fs.FileForSushi.MyFileReader:getHandle()
	do return self.handle end
end

function jk.fs.FileForSushi.MyFileReader:setHandle(v)
	self.handle = v
	do return self end
end

function jk.fs.FileForSushi.MyFileReader:getFile()
	do return self.file end
end

function jk.fs.FileForSushi.MyFileReader:setFile(v)
	self.file = v
	do return self end
end

jk.fs.FileForSushi.MyFileWriter = {}
jk.fs.FileForSushi.MyFileWriter.__index = jk.fs.FileForSushi.MyFileWriter
_vm:set_metatable(jk.fs.FileForSushi.MyFileWriter, {})

function jk.fs.FileForSushi.MyFileWriter._create()
	local v = _vm:set_metatable({}, jk.fs.FileForSushi.MyFileWriter)
	return v
end

function jk.fs.FileForSushi.MyFileWriter:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.fs.FileForSushi.MyFileWriter'
	self['_isType.jk.fs.FileForSushi.MyFileWriter'] = true
	self['_isType.jk.fs.FileWriter'] = true
	self['_isType.jk.io.Writer'] = true
	self['_isType.jk.lang.Closable'] = true
	self['_isType.jk.io.SeekableWriter'] = true
	self.handle = -1
	self.file = nil
	self._destructWrapper = _vm:create_destructor(function() self:_destruct() end)
end

function jk.fs.FileForSushi.MyFileWriter:_construct0()
	jk.fs.FileForSushi.MyFileWriter._init(self)
	return self
end

function jk.fs.FileForSushi.MyFileWriter:_destruct()
	do self:close() end
end

function jk.fs.FileForSushi.MyFileWriter:write(buf, size)
	local v = -1
	local handle = self.handle
	if handle >= 0 then
		do v = _io:write_to_handle(handle, buf, size) end
	end
	do return v end
end

function jk.fs.FileForSushi.MyFileWriter:close()
	local handle = self.handle
	if handle >= 0 then
		do _io:close_handle(handle) end
		self.handle = -1
	end
end

function jk.fs.FileForSushi.MyFileWriter:setCurrentPosition(n)
	local handle = self.handle
	if handle < 0 then
		do return false end
	end
	if _io:set_current_position(handle, n) < 0 then
		do return false end
	end
	do return true end
end

function jk.fs.FileForSushi.MyFileWriter:getCurrentPosition()
	local handle = self.handle
	if handle < 0 then
		do return 0 end
	end
	do return _io:get_current_position(handle) end
end

function jk.fs.FileForSushi.MyFileWriter:getHandle()
	do return self.handle end
end

function jk.fs.FileForSushi.MyFileWriter:setHandle(v)
	self.handle = v
	do return self end
end

function jk.fs.FileForSushi.MyFileWriter:getFile()
	do return self.file end
end

function jk.fs.FileForSushi.MyFileWriter:setFile(v)
	self.file = v
	do return self end
end

function jk.fs.FileForSushi:forPath(path)
	local v = _g.jk.fs.FileForSushi._construct0(_g.jk.fs.FileForSushi._create())
	do v:setPath(path, true) end
	do return v end
end

function jk.fs.FileForSushi:forRawPath(path)
	local v = _g.jk.fs.FileForSushi._construct0(_g.jk.fs.FileForSushi._create())
	do v:setPath(path, false) end
	do return v end
end

function jk.fs.FileForSushi:entry(name)
	local pp = self.path
	if _g.jk.lang.String:isNotEmpty(name) then
		if pp ~= nil then
			pp = _g.jk.lang.String:safeString(pp) .. "/" .. _g.jk.lang.String:safeString(name)
		else
			pp = name
		end
	end
	do return _g.jk.fs.FileForSushi:forPath(pp) end
end

function jk.fs.FileForSushi:rawEntry(name)
	local pp = self.path
	if _g.jk.lang.String:isNotEmpty(name) then
		if pp ~= nil then
			pp = _g.jk.lang.String:safeString(pp) .. "/" .. _g.jk.lang.String:safeString(name)
		else
			pp = name
		end
	end
	do return _g.jk.fs.FileForSushi:forRawPath(pp) end
end

function jk.fs.FileForSushi:move(dest, replace)
	local dthis = _vm:to_table_with_key(dest, '_isType.jk.fs.FileForSushi')
	if not (dthis ~= nil) then
		do return false end
	end
	do
		local opath = self.path
		local npath = dthis:getPath()
		if not _g.jk.lang.String:isNotEmpty(opath) then
			do return false end
		end
		if not _g.jk.lang.String:isNotEmpty(npath) then
			do return false end
		end
		if replace then
			do dthis:removeRecursive() end
		elseif dthis:exists() then
			do return false end
		end
		do
			local r = _io:rename_path(opath, npath)
			if r ~= 1 then
				do return false end
			end
			do return true end
		end
	end
end

function jk.fs.FileForSushi:touch()
	local path = self.path
	local r = _io:touch_file(path)
	if r == 1 then
		do return true end
	end
	do return false end
end

function jk.fs.FileForSushi:read()
	local handle = 0
	local path = self.path
	do handle = _io:open_file_for_reading(path) end
	if not (handle >= 0) then
		do return nil end
	end
	do
		local v = _g.jk.fs.FileForSushi.MyFileReader._construct0(_g.jk.fs.FileForSushi.MyFileReader._create())
		do v:setFile(self) end
		do v:setHandle(handle) end
		do return v end
	end
end

function jk.fs.FileForSushi:write()
	local handle = 0
	local path = self.path
	do handle = _io:open_file_for_writing(path) end
	if not (handle >= 0) then
		do return nil end
	end
	do
		local v = _g.jk.fs.FileForSushi.MyFileWriter._construct0(_g.jk.fs.FileForSushi.MyFileWriter._create())
		do v:setFile(self) end
		do v:setHandle(handle) end
		do return v end
	end
end

function jk.fs.FileForSushi:append()
	local handle = 0
	local path = self.path
	do handle = _io:open_file_for_appending(path) end
	if not (handle >= 0) then
		do return nil end
	end
	do
		local v = _g.jk.fs.FileForSushi.MyFileWriter._construct0(_g.jk.fs.FileForSushi.MyFileWriter._create())
		do v:setFile(self) end
		do v:setHandle(handle) end
		do return v end
	end
end

function jk.fs.FileForSushi:stat()
	local path = self.path
	local valid = true
	local size = 0
	local ctim = 0
	local atim = 0
	local mtim = 0
	local uid = 0
	local gid = 0
	local mode = 0
	do size, ctim, atim, mtim, uid, gid, mode = _io:get_file_info(path) if size == nil then valid = false end end
	do
		local v = _g.jk.fs.FileInfo._construct0(_g.jk.fs.FileInfo._create())
		do v:setFile(self) end
		if not valid then
			do v:setType(_g.jk.fs.FileInfo.FILE_TYPE_UNKNOWN) end
			do return v end
		end
		do v:setSize(size) end
		do v:setCreateTime(ctim) end
		do v:setAccessTime(ctim) end
		do v:setModifyTime(mtim) end
		do v:setOwnerUser(uid) end
		do v:setOwnerGroup(gid) end
		do v:setMode(_vm:bitwise_and(mode, 511)) end
		if _vm:bitwise_and(mode, 32768) ~= 0 then
			do v:setType(_g.jk.fs.FileInfo.FILE_TYPE_FILE) end
		elseif _vm:bitwise_and(mode, 16384) ~= 0 then
			do v:setType(_g.jk.fs.FileInfo.FILE_TYPE_DIR) end
		else
			do v:setType(_g.jk.fs.FileInfo.FILE_TYPE_UNKNOWN) end
		end
		if _vm:bitwise_and(mode, 40960) ~= 0 then
			do v:setLink(true) end
		end
		if _vm:bitwise_and(mode, 64) ~= 0 or _vm:bitwise_and(mode, 8) ~= 0 or _vm:bitwise_and(mode, 1) ~= 0 then
			do v:setExecutable(true) end
		end
		do return v end
	end
end

function jk.fs.FileForSushi:createDirectory()
	local path = self.path
	local r = _io:create_directory(path)
	if r == 1 then
		do return true end
	end
	do return false end
end

function jk.fs.FileForSushi:createDirectoryRecursive()
	if self:isDirectory() then
		do return true end
	end
	do
		local parent = self:getParent()
		if parent ~= nil then
			if not parent:createDirectoryRecursive() then
				do return false end
			end
		end
		do return self:createDirectory() end
	end
end

function jk.fs.FileForSushi:removeDirectory()
	local path = self.path
	local r = _io:remove_directory(path)
	if r == 1 then
		do return true end
	end
	do return false end
end

function jk.fs.FileForSushi:normalizePath(apath)
	local path = apath
	if not (path ~= nil) then
		do return nil end
	end
	if _g.jk.os.OS:isWindows() then
		path = _g.jk.lang.String:replaceCharacter(path, 92, 47)
	end
	do
		local v = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		local comps = _g.jk.lang.String:split(path, 47, 0)
		if comps ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(comps)
			do
				n = 0
				while n < m do
					local comp = comps[n + 1]
					if comp ~= nil then
						if _g.jk.lang.String:isEmpty(comp) then
						elseif comp == "." then
						elseif comp == ".." then
							local str = v:toString()
							do v:clear() end
							if str ~= nil then
								local slash = _g.jk.lang.String:getLastIndexOfCharacter(str, 47, -1)
								if slash > 0 then
									do v:appendString(_g.jk.lang.String:getSubString(str, 0, slash)) end
								end
							end
						else
							if v:count() > 0 then
								do v:appendCharacter(47) end
							end
							do v:appendString(comp) end
						end
					end
					do n = n + 1 end
				end
			end
		end
		if _g.jk.lang.String:startsWith(path, "/", 0) then
			do return "/" .. _g.jk.lang.String:safeString(v:toString()) end
		end
		do return v:toString() end
	end
end

function jk.fs.FileForSushi:setPath(v, useRealPath)
	if _g.jk.lang.String:isEmpty(v) then
		self.path = nil
		do return end
	end
	if _g.jk.os.OS:isWindows() then
		local l = _g.jk.lang.String:getLength(v)
		local c1 = _g.jk.lang.String:getChar(v, 1)
		if l == 2 and c1 == 58 then
			self.path = _g.jk.lang.String:safeString(v) .. "/"
			do return end
		end
		do
			local c2 = _g.jk.lang.String:getChar(v, 2)
			if l == 3 and c1 == 58 and (c2 == 92 or c2 == 47) then
				local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
				do sb:appendCharacter(_g.jk.lang.String:getChar(v, 0)) end
				do sb:appendCharacter(58) end
				do sb:appendCharacter(47) end
				self.path = sb:toString()
				do return end
			end
		end
	end
	if useRealPath then
		local realpath = nil
		do realpath = _io:get_real_path(v) end
		if _g.jk.lang.String:isNotEmpty(realpath) then
			self.path = realpath
			if _g.jk.os.OS:isWindows() then
				self.path = _g.jk.lang.String:replaceCharacter(self.path, 92, 47)
			end
			do return end
		end
	end
	if _g.jk.fs.PathInfo:isAbsolutePath(v) then
		self.path = self:normalizePath(v)
	else
		self.path = self:normalizePath(_g.jk.lang.String:safeString(_io:get_current_directory()) .. "/" .. _g.jk.lang.String:safeString(v))
	end
end

function jk.fs.FileForSushi:getPath()
	do return self.path end
end

function jk.fs.FileForSushi:remove()
	local path = self.path
	if _io:remove_file(path) == 1 then
		do return true end
	end
	do return false end
end

function jk.fs.FileForSushi:makeExecutable()
	local path = self.path
	local mode = _vm:bitwise_or(_vm:bitwise_or(_vm:bitwise_or(_vm:bitwise_or(_vm:bitwise_or(_vm:bitwise_or(1, 4), 8), 32), 64), 128), 256)
	do return _io:set_file_mode(path, mode ) end
end

function jk.fs.FileForSushi:setMode(mode)
	local path = self.path
	do return _io:set_file_mode(path, mode ) end
end

jk.fs.FileForSushi.MyDirectoryIterator = {}
jk.fs.FileForSushi.MyDirectoryIterator.__index = jk.fs.FileForSushi.MyDirectoryIterator
_vm:set_metatable(jk.fs.FileForSushi.MyDirectoryIterator, {})

function jk.fs.FileForSushi.MyDirectoryIterator._create()
	local v = _vm:set_metatable({}, jk.fs.FileForSushi.MyDirectoryIterator)
	return v
end

function jk.fs.FileForSushi.MyDirectoryIterator:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.fs.FileForSushi.MyDirectoryIterator'
	self['_isType.jk.fs.FileForSushi.MyDirectoryIterator'] = true
	self['_isType.jk.lang.Iterator'] = true
	self['_isType.jk.lang.Closable'] = true
	self.parent = nil
	self.handle = nil
	self.current = nil
	self._destructWrapper = _vm:create_destructor(function() self:_destruct() end)
end

function jk.fs.FileForSushi.MyDirectoryIterator:_construct0()
	jk.fs.FileForSushi.MyDirectoryIterator._init(self)
	return self
end

function jk.fs.FileForSushi.MyDirectoryIterator:_destruct()
	do self:close() end
end

function jk.fs.FileForSushi.MyDirectoryIterator:close()
	local handle = self.handle
	if handle ~= nil then
		do _io:close_directory(handle) end
		self.handle = nil
	end
end

function jk.fs.FileForSushi.MyDirectoryIterator:doNext()
	local handle = self.handle
	if not (handle ~= nil) then
		do return nil end
	end
	do
		local name = _io:read_directory(handle)
		if not (name ~= nil) then
			do self:close() end
			do return nil end
		end
		do return _g.jk.fs.File:forRelativePath(name, self.parent, false) end
	end
end

function jk.fs.FileForSushi.MyDirectoryIterator:next()
	if self.current ~= nil then
		local vv = self.current
		self.current = nil
		do return vv end
	end
	do return self:doNext() end
end

function jk.fs.FileForSushi.MyDirectoryIterator:hasNext()
	if self.current ~= nil then
		do return true end
	end
	do
		local v = self:doNext()
		if v ~= nil then
			self.current = v
			do return true end
		end
		do return false end
	end
end

function jk.fs.FileForSushi.MyDirectoryIterator:getParent()
	do return self.parent end
end

function jk.fs.FileForSushi.MyDirectoryIterator:setParent(v)
	self.parent = v
	do return self end
end

function jk.fs.FileForSushi.MyDirectoryIterator:getHandle()
	do return self.handle end
end

function jk.fs.FileForSushi.MyDirectoryIterator:setHandle(v)
	self.handle = v
	do return self end
end

function jk.fs.FileForSushi:entries()
	local pp = self.path
	if not _g.jk.lang.String:isNotEmpty(pp) then
		do return nil end
	end
	do
		local handle = _io:open_directory(pp)
		if not (handle ~= nil) then
			do return nil end
		end
		do
			local v = _g.jk.fs.FileForSushi.MyDirectoryIterator._construct0(_g.jk.fs.FileForSushi.MyDirectoryIterator._create())
			do v:setParent(self) end
			do v:setHandle(handle) end
			do return v end
		end
	end
end
jk = jk or {}

jk.base64 = jk.base64 or {}

jk.base64.Base64Encoder = {}
jk.base64.Base64Encoder.__index = jk.base64.Base64Encoder
_vm:set_metatable(jk.base64.Base64Encoder, {})

function jk.base64.Base64Encoder._create()
	local v = _vm:set_metatable({}, jk.base64.Base64Encoder)
	return v
end

function jk.base64.Base64Encoder:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.base64.Base64Encoder'
	self['_isType.jk.base64.Base64Encoder'] = true
end

function jk.base64.Base64Encoder:_construct0()
	jk.base64.Base64Encoder._init(self)
	return self
end

function jk.base64.Base64Encoder:toUrlSafeFormat(str)
	local v = str
	if not (v ~= nil) then
		do return nil end
	end
	v = _g.jk.lang.String:replaceString(v, "=", "")
	v = _g.jk.lang.String:replaceCharacter(v, 43, 45)
	v = _g.jk.lang.String:replaceCharacter(v, 47, 95)
	do return v end
end

function jk.base64.Base64Encoder:encodeString(str)
	if not (str ~= nil) then
		do return nil end
	end
	do return _g.jk.base64.Base64Encoder:encode(_g.jk.lang.String:toUTF8Buffer(str)) end
end

function jk.base64.Base64Encoder:encode(buffer)
	if not (buffer ~= nil) then
		do return nil end
	end
	do
		local length = _g.jk.lang.Buffer:getSize(buffer)
		local dst = _g.jk.lang.Buffer:allocate(_util:convert_to_integer((length + 2) / 3) * 4)
		local x = 0
		local dstIndex = 0
		local state = 0
		local old = 0
		do
			local srcIndex = 0
			while srcIndex < length do
				x = buffer[srcIndex + 1]
				do
					local v = (function() state = state + 1 return state end)()
					if v == 1 then
						dst[(function() local v = dstIndex dstIndex = dstIndex + 1 return v end)() + 1] = _util:convert_to_integer(_g.jk.base64.Base64Encoder:toASCIIChar(_vm:bitwise_and(_vm:bitwise_right_shift(x, 2), 63)))
					elseif v == 2 then
						dst[(function() local v = dstIndex dstIndex = dstIndex + 1 return v end)() + 1] = _util:convert_to_integer(_g.jk.base64.Base64Encoder:toASCIIChar(_vm:bitwise_or(_vm:bitwise_and(_vm:bitwise_left_shift(old, 4), 48), _vm:bitwise_and(_vm:bitwise_right_shift(x, 4), 15))))
					elseif v == 3 then
						dst[(function() local v = dstIndex dstIndex = dstIndex + 1 return v end)() + 1] = _util:convert_to_integer(_g.jk.base64.Base64Encoder:toASCIIChar(_vm:bitwise_or(_vm:bitwise_and(_vm:bitwise_left_shift(old, 2), 60), _vm:bitwise_and(_vm:bitwise_right_shift(x, 6), 3))))
						dst[(function() local v = dstIndex dstIndex = dstIndex + 1 return v end)() + 1] = _util:convert_to_integer(_g.jk.base64.Base64Encoder:toASCIIChar(_vm:bitwise_and(x, 63)))
						state = 0
					end
				end
				old = x
				do srcIndex = srcIndex + 1 end
			end
		end
		do
			local v2 = state
			if v2 == 1 then
				dst[(function() local v = dstIndex dstIndex = dstIndex + 1 return v end)() + 1] = _util:convert_to_integer(_g.jk.base64.Base64Encoder:toASCIIChar(_vm:bitwise_and(_vm:bitwise_left_shift(old, 4), 48)))
				dst[(function() local v = dstIndex dstIndex = dstIndex + 1 return v end)() + 1] = _util:convert_to_integer(61)
				dst[(function() local v = dstIndex dstIndex = dstIndex + 1 return v end)() + 1] = _util:convert_to_integer(61)
			elseif v2 == 2 then
				dst[(function() local v = dstIndex dstIndex = dstIndex + 1 return v end)() + 1] = _util:convert_to_integer(_g.jk.base64.Base64Encoder:toASCIIChar(_vm:bitwise_and(_vm:bitwise_left_shift(old, 2), 60)))
				dst[(function() local v = dstIndex dstIndex = dstIndex + 1 return v end)() + 1] = _util:convert_to_integer(61)
			end
		end
		do return _g.jk.lang.String:forBuffer(dst, "ASCII") end
	end
end

function jk.base64.Base64Encoder:toASCIIChar(lookup)
	local c = 0
	if lookup < 0 or lookup > 63 then
		do return c end
	end
	if lookup <= 25 then
		c = lookup + 65
	elseif lookup <= 51 then
		c = lookup + 71
	elseif lookup <= 61 then
		c = lookup - 4
	elseif lookup == 62 then
		c = _util:convert_to_integer(43)
	elseif lookup == 63 then
		c = _util:convert_to_integer(47)
	end
	do return c end
end

jk.base64.Base64Decoder = {}
jk.base64.Base64Decoder.__index = jk.base64.Base64Decoder
_vm:set_metatable(jk.base64.Base64Decoder, {})

function jk.base64.Base64Decoder._create()
	local v = _vm:set_metatable({}, jk.base64.Base64Decoder)
	return v
end

function jk.base64.Base64Decoder:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.base64.Base64Decoder'
	self['_isType.jk.base64.Base64Decoder'] = true
end

function jk.base64.Base64Decoder:_construct0()
	jk.base64.Base64Decoder._init(self)
	return self
end

function jk.base64.Base64Decoder:fromUrlSafeFormat(str)
	local v = str
	if not (v ~= nil) then
		do return nil end
	end
	v = _g.jk.lang.String:replaceCharacter(v, 45, 43)
	v = _g.jk.lang.String:replaceCharacter(v, 95, 47)
	do
		local mod = _util:convert_to_integer(_g.jk.lang.String:getLength(v) % 4)
		if mod == 1 then
			v = _g.jk.lang.String:safeString(v) .. "==="
		elseif mod == 2 then
			v = _g.jk.lang.String:safeString(v) .. "=="
		elseif mod == 3 then
			v = _g.jk.lang.String:safeString(v) .. "="
		end
		do return v end
	end
end

function jk.base64.Base64Decoder:appendByte(buffer, byte)
	local nbyte = _g.jk.lang.Buffer:allocate(1)
	do _g.jk.lang.Buffer:setByte(nbyte, 0, byte) end
	do return _g.jk.lang.Buffer:append(buffer, nbyte, _g.jk.lang.Buffer:getSize(nbyte)) end
end

function jk.base64.Base64Decoder:fromLookupChar(ascii)
	local c = 0
	if ascii == 43 then
		c = 62
	elseif ascii == 47 then
		c = 63
	elseif ascii >= 48 and ascii <= 57 then
		c = ascii + 4
	elseif ascii >= 65 and ascii <= 90 then
		c = ascii - 65
	elseif ascii >= 97 and ascii <= 122 then
		c = ascii - 71
	end
	do return c end
end

function jk.base64.Base64Decoder:decode(text)
	if not (text ~= nil) then
		do return nil end
	end
	do
		local data = _util:allocate_buffer(0)
		local iter = _g.jk.lang.String:iterate(text)
		if iter ~= nil then
			local ch = 0
			while (function()
				ch = iter:getNextChar()
				do return ch end
			end)() > 0 do
				local c1 = 0
				local c2 = 0
				local c3 = 0
				local c4 = 0
				local byte1 = 0
				local byte2 = 0
				local byte3 = 0
				c1 = _g.jk.base64.Base64Decoder:fromLookupChar(ch)
				c2 = _g.jk.base64.Base64Decoder:fromLookupChar((function()
					ch = iter:getNextChar()
					do return ch end
				end)())
				byte1 = _vm:bitwise_left_shift(c1, 2) + _vm:bitwise_right_shift(c2, 4)
				data = _g.jk.base64.Base64Decoder:appendByte(data, byte1)
				ch = iter:getNextChar()
				if ch == 61 then
					do break end
				else
					c3 = _g.jk.base64.Base64Decoder:fromLookupChar(ch)
				end
				byte2 = _vm:bitwise_left_shift(_vm:bitwise_and(c2, 15), 4) + _vm:bitwise_right_shift(c3, 2)
				data = _g.jk.base64.Base64Decoder:appendByte(data, byte2)
				ch = iter:getNextChar()
				if ch == 61 then
					do break end
				else
					c4 = _g.jk.base64.Base64Decoder:fromLookupChar(ch)
				end
				byte3 = _vm:bitwise_left_shift(_vm:bitwise_and(c3, 3), 6) + c4
				data = _g.jk.base64.Base64Decoder:appendByte(data, byte3)
			end
		end
		do return data end
	end
end
jk = jk or {}

jk.json = jk.json or {}

jk.json.JSONParser = {}
jk.json.JSONParser.__index = jk.json.JSONParser
_vm:set_metatable(jk.json.JSONParser, {})

function jk.json.JSONParser._create()
	local v = _vm:set_metatable({}, jk.json.JSONParser)
	return v
end

function jk.json.JSONParser:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.json.JSONParser'
	self['_isType.jk.json.JSONParser'] = true
	self.iterator = nil
end

function jk.json.JSONParser:_construct0()
	jk.json.JSONParser._init(self)
	return self
end

jk.json.JSONParser.NullObject = {}
jk.json.JSONParser.NullObject.__index = jk.json.JSONParser.NullObject
_vm:set_metatable(jk.json.JSONParser.NullObject, {})

function jk.json.JSONParser.NullObject._create()
	local v = _vm:set_metatable({}, jk.json.JSONParser.NullObject)
	return v
end

function jk.json.JSONParser.NullObject:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.json.JSONParser.NullObject'
	self['_isType.jk.json.JSONParser.NullObject'] = true
end

function jk.json.JSONParser.NullObject:_construct0()
	jk.json.JSONParser.NullObject._init(self)
	return self
end

function jk.json.JSONParser:parse(data)
	if not (data ~= nil) then
		do return nil end
	end
	if _util:is_buffer(data) then
		do return _g.jk.json.JSONParser:parseBuffer(data) end
	end
	if (_vm:get_variable_type(data) == 'string') then
		do return _g.jk.json.JSONParser:parseString(data) end
	end
	if (_vm:to_table_with_key(data, '_isType.jk.fs.File') ~= nil) then
		do return _g.jk.json.JSONParser:parseFile(data) end
	end
	do return nil end
end

function jk.json.JSONParser:parseBuffer(buffer)
	if buffer == nil then
		do return nil end
	end
	do return _g.jk.json.JSONParser:forBuffer(buffer):acceptObject() end
end

function jk.json.JSONParser:parseString(str)
	if _g.jk.lang.String:isEmpty(str) then
		do return nil end
	end
	do return _g.jk.json.JSONParser:forString(str):acceptObject() end
end

function jk.json.JSONParser:parseFile(file)
	if file == nil then
		do return nil end
	end
	do return _g.jk.json.JSONParser:parseString(file:getContentsUTF8()) end
end

function jk.json.JSONParser:forString(str)
	local v = _g.jk.json.JSONParser._construct0(_g.jk.json.JSONParser._create())
	do v:setDataString(str) end
	do return v end
end

function jk.json.JSONParser:forBuffer(buffer)
	local v = _g.jk.json.JSONParser._construct0(_g.jk.json.JSONParser._create())
	do v:setDataBuffer(buffer) end
	do return v end
end

function jk.json.JSONParser:setDataString(str)
	self.iterator = _g.jk.lang.CharacterIteratorForString:forString(str)
	do self.iterator:moveToNextChar() end
end

function jk.json.JSONParser:setDataBuffer(buffer)
	self.iterator = _g.jk.lang.CharacterIteratorForBuffer:forBuffer(buffer)
	do self.iterator:moveToNextChar() end
end

function jk.json.JSONParser:skipSpaces()
	while true do
		if self.iterator:hasEnded() then
			do break end
		end
		do
			local c = self.iterator:getCurrentChar()
			if c == 32 or c == 9 or c == 13 or c == 10 then
				do self.iterator:moveToNextChar() end
				goto _continue1
			end
			do break end
		end
		::_continue1::
	end
end

function jk.json.JSONParser:acceptChar(c)
	do self:skipSpaces() end
	if self.iterator:getCurrentChar() == c then
		do self.iterator:moveToNextChar() end
		do return true end
	end
	do return false end
end

function jk.json.JSONParser:acceptString()
	do self:skipSpaces() end
	do
		local ss = self.iterator:getCurrentChar()
		if ss ~= 39 and ss ~= 34 then
			do return nil end
		end
		do
			local i = 0
			local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
			while true do
				local c = self.iterator:getNextChar()
				do i = i + 1 end
				if _g.jk.lang.Character:isEOF(c) then
					do
						local n = 0
						while n < i do
							do self.iterator:moveToPreviousChar() end
							do n = n + 1 end
						end
					end
					do return nil end
				end
				if c == ss then
					do self.iterator:moveToNextChar() end
					do break end
				end
				if c == 92 then
					c = self.iterator:getNextChar()
					if c == 117 then
						local v = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
						local x = 0
						while x < 4 do
							if self.iterator:hasEnded() then
								do break end
							end
							do v:appendCharacter(self.iterator:getNextChar()) end
							do x = x + 1 end
						end
						c = _g.jk.lang.String:toIntegerFromHex(v:toString())
					elseif c == 116 then
						c = 9
					elseif c == 114 then
						c = 13
					elseif c == 110 then
						c = 10
					elseif c == 98 then
						c = 8
					elseif c == 102 then
						c = 12
					end
				end
				do sb:appendCharacter(c) end
			end
			do return sb:toString() end
		end
	end
end

function jk.json.JSONParser:acceptBoolean()
	do self:skipSpaces() end
	do
		local ss = self.iterator:getCurrentChar()
		if ss ~= 116 and ss ~= 102 then
			do return nil end
		end
		do
			local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
			do sb:appendCharacter(ss) end
			do
				local li = 5
				if ss == 116 then
					li = 4
				end
				do
					local btc = 0
					while true do
						local c = self.iterator:getNextChar()
						do btc = btc + 1 end
						if c ~= 97 and c ~= 108 and c ~= 115 and c ~= 101 and c ~= 114 and c ~= 117 then
							do self.iterator:moveToNextChar() end
							do btc = btc + 1 end
							do break end
						end
						do sb:appendCharacter(c) end
						if sb:count() == li then
							do self.iterator:moveToNextChar() end
							do btc = btc + 1 end
							do break end
						end
					end
					do
						local v = sb:toString()
						if li == 4 and "true" == v then
							do return _g.jk.lang.Boolean:asObject(true) end
						end
						if li == 5 and "false" == v then
							do return _g.jk.lang.Boolean:asObject(false) end
						end
						do
							local i = 0
							while i < btc do
								do self.iterator:moveToPreviousChar() end
								do i = i + 1 end
							end
							do return nil end
						end
					end
				end
			end
		end
	end
end

function jk.json.JSONParser:acceptNumber()
	do self:skipSpaces() end
	do
		local ss = self.iterator:getCurrentChar()
		if ss ~= 45 and ss ~= 43 and ss ~= 46 and (ss < 48 or ss > 57) then
			do return nil end
		end
		do
			local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
			do sb:appendCharacter(ss) end
			while true do
				local c = self.iterator:getNextChar()
				if c ~= 46 and c ~= 101 and c ~= 69 and c ~= 45 and (c < 48 or c > 57) then
					do break end
				end
				do sb:appendCharacter(c) end
			end
			do
				local s = sb:toString()
				if _g.jk.lang.String:getIndexOfCharacter(s, 46, 0) > -1 then
					do return _g.jk.lang.Double:asObject(_g.jk.lang.Double:asDouble(s)) end
				end
				do
					local value = _g.jk.lang.String:toLong(s)
					if value >= -2147483648 and value <= 2147483647 then
						do return _g.jk.lang.Integer:asObject(value) end
					end
					do return _g.jk.lang.LongInteger:asObject(value) end
				end
			end
		end
	end
end

function jk.json.JSONParser:acceptNull()
	do self:skipSpaces() end
	do
		local ss = self.iterator:getCurrentChar()
		if ss ~= 110 then
			do return nil end
		end
		do
			local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
			do sb:appendCharacter(ss) end
			do
				local btc = 0
				while true do
					local c = self.iterator:getNextChar()
					do btc = btc + 1 end
					if c ~= 117 and c ~= 108 then
						do self.iterator:moveToNextChar() end
						do btc = btc + 1 end
						do break end
					end
					do sb:appendCharacter(c) end
					if sb:count() == 4 then
						do self.iterator:moveToNextChar() end
						do btc = btc + 1 end
						do break end
					end
				end
				if "null" == sb:toString() then
					do return _g.jk.json.JSONParser.NullObject._construct0(_g.jk.json.JSONParser.NullObject._create()) end
				end
				do
					local i = 0
					while i < btc do
						do self.iterator:moveToPreviousChar() end
						do i = i + 1 end
					end
					do return nil end
				end
			end
		end
	end
end

function jk.json.JSONParser:acceptObject()
	if self:acceptChar(91) then
		local v = _g.jk.lang.DynamicVector._construct0(_g.jk.lang.DynamicVector._create())
		while true do
			if self:acceptChar(93) then
				do break end
			end
			do
				local o = self:acceptObject()
				if o == nil then
					do return nil end
				end
				do v:appendObject(o) end
				do self:acceptChar(44) end
			end
		end
		do return v end
	end
	if self:acceptChar(123) then
		local v = _g.jk.lang.DynamicMap._construct0(_g.jk.lang.DynamicMap._create())
		while true do
			if self:acceptChar(125) then
				do break end
			end
			do
				local key = self:acceptString()
				if key == nil then
					do return nil end
				end
				if self:acceptChar(58) == false then
					do return nil end
				end
				do
					local val = self:acceptObject()
					if val == nil then
						do return nil end
					end
					if (_vm:to_table_with_key(val, '_isType.jk.json.JSONParser.NullObject') ~= nil) then
						do v:setObject(key, nil) end
					else
						do v:setObject(key, val) end
					end
					do self:acceptChar(44) end
				end
			end
		end
		do return v end
	end
	do
		local s = self:acceptString()
		if s ~= nil then
			do return s end
		end
		do
			local b = self:acceptBoolean()
			if b ~= nil then
				do return b end
			end
			do
				local n = self:acceptNull()
				if n ~= nil then
					do return n end
				end
				do
					local v = self:acceptNumber()
					if v ~= nil then
						do return v end
					end
					do return nil end
				end
			end
		end
	end
end

function jk.json.JSONParser:getNextToken()
	if self:acceptChar(91) then
		do return "[" end
	end
	if self:acceptChar(93) then
		do return "]" end
	end
	if self:acceptChar(123) then
		do return "{" end
	end
	if self:acceptChar(125) then
		do return "}" end
	end
	if self:acceptChar(44) then
		do return "," end
	end
	do
		local s = self:acceptString()
		if s ~= nil then
			do return s end
		end
		do
			local b = self:acceptBoolean()
			if b ~= nil then
				do return b end
			end
			do
				local n = self:acceptNull()
				if n ~= nil then
					do return n end
				end
				do
					local v = self:acceptNumber()
					if v ~= nil then
						do return v end
					end
					do return nil end
				end
			end
		end
	end
end

function jk.json.JSONParser:pushData(string)
	if not (string ~= nil) then
		do return end
	end
	if self.iterator == nil then
		do self:setDataString(string) end
		do return end
	end
	do
		local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		while true do
			local c = self.iterator:getNextChar()
			if _g.jk.lang.Character:isEOF(c) then
				do break end
			end
			do sb:appendCharacter(c) end
		end
		do sb:appendString(string) end
		do self:setDataString(sb:toString()) end
	end
end

jk.json.JSONObject = {}

jk.json.JSONEncoder = {}
jk.json.JSONEncoder.__index = jk.json.JSONEncoder
_vm:set_metatable(jk.json.JSONEncoder, {})

function jk.json.JSONEncoder._create()
	local v = _vm:set_metatable({}, jk.json.JSONEncoder)
	return v
end

function jk.json.JSONEncoder:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.json.JSONEncoder'
	self['_isType.jk.json.JSONEncoder'] = true
	self.niceFormatting = true
	self.stringFormattedBoolean = false
	self.stringFormattedNumber = false
	self.newJSONFormat = true
	self.encodeNullAsNull = false
	self.isNewLine = true
	self.mysb = nil
end

function jk.json.JSONEncoder:_construct0()
	jk.json.JSONEncoder._init(self)
	return self
end

function jk.json.JSONEncoder:print(line, indent, startline, endline, sb)
	if startline and self.isNewLine == false then
		if self.niceFormatting then
			do sb:appendCharacter(10) end
		end
		self.isNewLine = true
	end
	if self.isNewLine and self.niceFormatting then
		do
			local n = 0
			while n < indent do
				do sb:appendCharacter(9) end
				do n = n + 1 end
			end
		end
	end
	do sb:appendString(line) end
	if endline then
		if self.niceFormatting then
			do sb:appendCharacter(10) end
		end
		self.isNewLine = true
	else
		self.isNewLine = false
	end
end

function jk.json.JSONEncoder:encodeArray(cc, indent, sb)
	do self:print("[", indent, false, true, sb) end
	do
		local first = true
		if cc ~= nil then
			local n = 0
			local m = #cc
			do
				n = 0
				while n < m do
					local o = cc[n + 1]
					if o ~= nil then
						if first == false then
							do self:print(",", indent, false, true, sb) end
						end
						do self:encodeObject(o, indent + 1, sb) end
						first = false
					end
					do n = n + 1 end
				end
			end
		end
		do self:print("]", indent, true, false, sb) end
	end
end

function jk.json.JSONEncoder:encodeDynamicVector(cc, indent, sb)
	do self:print("[", indent, false, true, sb) end
	do
		local first = true
		local array = cc:toVector()
		if array ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(array)
			do
				n = 0
				while n < m do
					local o = array[n + 1]
					if o ~= nil then
						if first == false then
							do self:print(",", indent, false, true, sb) end
						end
						do self:encodeObject(o, indent + 1, sb) end
						first = false
					end
					do n = n + 1 end
				end
			end
		end
		do self:print("]", indent, true, false, sb) end
	end
end

function jk.json.JSONEncoder:encodeVector(cc, indent, sb)
	do self:print("[", indent, false, true, sb) end
	do
		local first = true
		if cc ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(cc)
			do
				n = 0
				while n < m do
					local o = cc[n + 1]
					if o ~= nil then
						if first == false then
							do self:print(",", indent, false, true, sb) end
						end
						do self:encodeObject(o, indent + 1, sb) end
						first = false
					end
					do n = n + 1 end
				end
			end
		end
		do self:print("]", indent, true, false, sb) end
	end
end

function jk.json.JSONEncoder:encodeMap(map, indent, sb)
	do self:print("{", indent, false, true, sb) end
	do
		local first = true
		local it = _g.jk.lang.Map:iterateKeys(map)
		while it ~= nil do
			local keyo = it:next()
			if not (keyo ~= nil) then
				do break end
			end
			do
				local key = _g.jk.lang.String:asString(keyo)
				if not (key ~= nil) then
					goto _continue2
				end
				if not first then
					do self:print(",", indent, false, true, sb) end
				end
				do self:encodeString(key, indent + 1, sb) end
				if self.niceFormatting then
					do sb:appendString(" : ") end
				else
					do sb:appendCharacter(58) end
				end
				do self:encodeObject(map[keyo], indent + 1, sb) end
				first = false
			end
			::_continue2::
		end
		do self:print("}", indent, true, false, sb) end
	end
end

function jk.json.JSONEncoder:encodeDynamicMap(map, indent, sb)
	do self:print("{", indent, false, true, sb) end
	do
		local first = true
		local it = map:iterateKeys()
		while it ~= nil do
			local key = it:next()
			if not (key ~= nil) then
				do break end
			end
			if first == false then
				do self:print(",", indent, false, true, sb) end
			end
			do self:encodeString(key, indent + 1, sb) end
			if self.niceFormatting then
				do sb:appendString(" : ") end
			else
				do sb:appendCharacter(58) end
			end
			do self:encodeObject(map:get(key), indent + 1, sb) end
			first = false
		end
		do self:print("}", indent, true, false, sb) end
	end
end

function jk.json.JSONEncoder:encodeKeyValueList(list, indent, sb)
	do self:print("{", indent, false, true, sb) end
	do
		local first = true
		local it = list:iterate()
		while it ~= nil do
			local pair = it:next()
			if pair == nil then
				do break end
			end
			if first == false then
				do self:print(",", indent, false, true, sb) end
			end
			do self:encodeString(pair.key, indent + 1, sb) end
			if self.niceFormatting then
				do sb:appendString(" : ") end
			else
				do sb:appendCharacter(58) end
			end
			do self:encodeString(pair.value, indent + 1, sb) end
			first = false
		end
		do self:print("}", indent, true, false, sb) end
	end
end

function jk.json.JSONEncoder:encodeString(s, indent, sb)
	if self.mysb == nil then
		self.mysb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	else
		do self.mysb:clear() end
	end
	do self.mysb:appendCharacter(34) end
	do
		local it = _g.jk.lang.String:iterate(s)
		while true do
			local c = it:getNextChar()
			if _g.jk.lang.Character:isEOF(c) then
				do break end
			end
			if self.newJSONFormat then
				if c == 9 then
					do self.mysb:appendString("\\t") end
					goto _continue3
				end
				if c == 10 then
					do self.mysb:appendString("\\n") end
					goto _continue3
				end
				if c == 13 then
					do self.mysb:appendString("\\r") end
					goto _continue3
				end
				if c == 8 then
					do self.mysb:appendString("\\b") end
					goto _continue3
				end
				if c == 12 then
					do self.mysb:appendString("\\f") end
					goto _continue3
				end
			end
			if c == 34 then
				do self.mysb:appendCharacter(92) end
			elseif c == 92 then
				do self.mysb:appendCharacter(92) end
			end
			do self.mysb:appendCharacter(c) end
			::_continue3::
		end
		do self.mysb:appendCharacter(34) end
		do self:print(self.mysb:toString(), indent, false, false, sb) end
	end
end

function jk.json.JSONEncoder:encodeBoolean(b, indent, sb)
	if self.mysb == nil then
		self.mysb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	else
		do self.mysb:clear() end
	end
	if self.stringFormattedBoolean then
		do self.mysb:appendCharacter(34) end
		do self.mysb:appendString(_g.jk.lang.String:forBoolean(b)) end
		do self.mysb:appendCharacter(34) end
	else
		do self.mysb:appendString(_g.jk.lang.String:forBoolean(b)) end
	end
	do self:print(self.mysb:toString(), indent, false, false, sb) end
end

function jk.json.JSONEncoder:encodeNumber(o, indent, sb)
	if self.mysb == nil then
		self.mysb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	else
		do self.mysb:clear() end
	end
	if self.stringFormattedNumber then
		do self.mysb:appendCharacter(34) end
		do self.mysb:appendString(_g.jk.lang.String:asString(o)) end
		do self.mysb:appendCharacter(34) end
	elseif (_vm:to_table_with_key(o, '_isType.jk.lang.IntegerObject') ~= nil) then
		do self.mysb:appendInteger(_g.jk.lang.Integer:asInteger(o)) end
	elseif _vm:to_table_with_key(o, '_isType.jk.lang.LongIntegerObject') ~= nil then
		do self.mysb:appendLong(_g.jk.lang.LongInteger:asLong(o)) end
	elseif _vm:to_table_with_key(o, '_isType.jk.lang.DoubleObject') ~= nil then
		do self.mysb:appendDouble(_g.jk.lang.Double:asDouble(o)) end
	else
		do self.mysb:appendString("") end
	end
	do self:print(self.mysb:toString(), indent, false, false, sb) end
end

function jk.json.JSONEncoder:encodeObject(o, indent, sb)
	if not (o ~= nil) then
		if self.encodeNullAsNull then
			do self:print("null", indent, false, false, sb) end
		else
			do self:encodeString("", indent, sb) end
		end
	elseif (_vm:to_table_with_key(o, '_isType.jk.json.JSONObject') ~= nil) then
		do self:encodeObject(o:toJsonObject(), indent, sb) end
	elseif (function(x) return x ~= nil and _vm:get_variable_type(x) == 'table' and not x._isClassInstance == true and #x > 0 end)(o) then
		do self:encodeArray(o, indent, sb) end
	elseif (function(x) return x ~= nil and _vm:get_variable_type(x) == 'table' and not x._isClassInstance == true and #x > 0 end)(o) then
		do self:encodeVector(o, indent, sb) end
	elseif (function(x) return x ~= nil and _vm:get_variable_type(x) == 'table' and not x._isClassInstance == true and #x < 1 end)(o) then
		do self:encodeMap(o, indent, sb) end
	elseif _util:is_buffer(o) then
		do self:encodeString(_g.jk.base64.Base64Encoder:encode(o), indent, sb) end
	elseif (_vm:get_variable_type(o) == 'string') then
		do self:encodeString(o, indent, sb) end
	elseif (_vm:to_table_with_key(o, '_isType.jk.lang.DynamicMap') ~= nil) then
		do self:encodeDynamicMap(o, indent, sb) end
	elseif (_vm:to_table_with_key(o, '_isType.jk.lang.DynamicVector') ~= nil) then
		do self:encodeDynamicVector(o, indent, sb) end
	elseif (_vm:to_table_with_key(o, '_isType.jk.lang.KeyValueListForStrings') ~= nil) then
		do self:encodeKeyValueList(o, indent, sb) end
	elseif (_vm:to_table_with_key(o, '_isType.jk.lang.StringObject') ~= nil) then
		do self:encodeString(o:toString(), indent, sb) end
	elseif (_vm:to_table_with_key(o, '_isType.jk.lang.BufferObject') ~= nil) then
		do self:encodeString(_g.jk.base64.Base64Encoder:encode(o:toBuffer()), indent, sb) end
	elseif (_vm:to_table_with_key(o, '_isType.jk.lang.ArrayObject') ~= nil) then
		local aa = o:toArray()
		do self:encodeArray(aa, indent, sb) end
	elseif (_vm:to_table_with_key(o, '_isType.jk.lang.VectorObject') ~= nil) then
		local vv = o:toVector()
		do self:encodeVector(vv, indent, sb) end
	elseif (_vm:to_table_with_key(o, '_isType.jk.lang.IntegerObject') ~= nil) or (_vm:to_table_with_key(o, '_isType.jk.lang.LongIntegerObject') ~= nil) or (_vm:to_table_with_key(o, '_isType.jk.lang.DoubleObject') ~= nil) then
		do self:encodeNumber(o, indent, sb) end
	elseif (_vm:to_table_with_key(o, '_isType.jk.lang.CharacterObject') ~= nil) then
		do self:encodeString(_g.jk.lang.String:asString(o), indent, sb) end
	elseif (_vm:to_table_with_key(o, '_isType.jk.lang.BooleanObject') ~= nil) then
		do self:encodeBoolean(_g.jk.lang.Boolean:asBoolean(o, false), indent, sb) end
	else
		do self:encodeString("", indent, sb) end
	end
end

function jk.json.JSONEncoder:encode(o, niceFormatting, stringFormattedNumber)
	local v = _g.jk.json.JSONEncoder._construct0(_g.jk.json.JSONEncoder._create())
	do v:setStringFormattedBoolean(true) end
	do v:setStringFormattedNumber(stringFormattedNumber) end
	do v:setNiceFormatting(niceFormatting) end
	do return v:execute(o) end
end

function jk.json.JSONEncoder:execute(o)
	local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	do self:encodeObject(o, 0, sb) end
	do return sb:toString() end
end

function jk.json.JSONEncoder:encodeToBuilder(o, sb)
	if not (sb ~= nil) then
		do return end
	end
	do
		local str = _g.jk.json.JSONEncoder._construct0(_g.jk.json.JSONEncoder._create()):setEncodeNullAsNull(true):execute(o)
		if str ~= nil then
			do sb:appendString(str) end
		end
	end
end

function jk.json.JSONEncoder:toString(o)
	local v = _g.jk.json.JSONEncoder._construct0(_g.jk.json.JSONEncoder._create())
	do v:setStringFormattedBoolean(false) end
	do v:setStringFormattedNumber(false) end
	do v:setNiceFormatting(true) end
	do v:setEncodeNullAsNull(true) end
	do return v:execute(o) end
end

function jk.json.JSONEncoder:toCompactString(o)
	local v = _g.jk.json.JSONEncoder._construct0(_g.jk.json.JSONEncoder._create())
	do v:setStringFormattedBoolean(false) end
	do v:setStringFormattedNumber(false) end
	do v:setNiceFormatting(false) end
	do v:setEncodeNullAsNull(true) end
	do return v:execute(o) end
end

function jk.json.JSONEncoder:getNiceFormatting()
	do return self.niceFormatting end
end

function jk.json.JSONEncoder:setNiceFormatting(v)
	self.niceFormatting = v
	do return self end
end

function jk.json.JSONEncoder:getStringFormattedBoolean()
	do return self.stringFormattedBoolean end
end

function jk.json.JSONEncoder:setStringFormattedBoolean(v)
	self.stringFormattedBoolean = v
	do return self end
end

function jk.json.JSONEncoder:getStringFormattedNumber()
	do return self.stringFormattedNumber end
end

function jk.json.JSONEncoder:setStringFormattedNumber(v)
	self.stringFormattedNumber = v
	do return self end
end

function jk.json.JSONEncoder:getNewJSONFormat()
	do return self.newJSONFormat end
end

function jk.json.JSONEncoder:setNewJSONFormat(v)
	self.newJSONFormat = v
	do return self end
end

function jk.json.JSONEncoder:getEncodeNullAsNull()
	do return self.encodeNullAsNull end
end

function jk.json.JSONEncoder:setEncodeNullAsNull(v)
	self.encodeNullAsNull = v
	do return self end
end

jk.json.JSONObjectAdapter = {}
jk.json.JSONObjectAdapter.__index = jk.json.JSONObjectAdapter
_vm:set_metatable(jk.json.JSONObjectAdapter, {})

function jk.json.JSONObjectAdapter._create()
	local v = _vm:set_metatable({}, jk.json.JSONObjectAdapter)
	return v
end

function jk.json.JSONObjectAdapter:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.json.JSONObjectAdapter'
	self['_isType.jk.json.JSONObjectAdapter'] = true
	self['_isType.jk.json.JSONObject'] = true
end

function jk.json.JSONObjectAdapter:_construct0()
	jk.json.JSONObjectAdapter._init(self)
	return self
end

function jk.json.JSONObjectAdapter:asJsonValue(value)
	if not (value ~= nil) then
		do return nil end
	end
	if (_vm:to_table_with_key(value, '_isType.jk.json.JSONObject') ~= nil) then
		local oj = value
		do return oj:toJsonObject() end
	end
	do return value end
end

function jk.json.JSONObjectAdapter:toDynamicMap()
	do return _vm:to_table_with_key(self:toJsonObject(), '_isType.jk.lang.DynamicMap') end
end

function jk.json.JSONObjectAdapter:toObjectMap()
	local dm = self:toDynamicMap()
	if not (dm ~= nil) then
		do return nil end
	end
	do return dm:toObjectMap() end
end

function jk.json.JSONObjectAdapter:toJsonObject()
end

function jk.json.JSONObjectAdapter:fromJsonObject(o)
end

jk.json.JSONObjectAdapterExplicit = {}
jk.json.JSONObjectAdapterExplicit.__index = jk.json.JSONObjectAdapterExplicit
_vm:set_metatable(jk.json.JSONObjectAdapterExplicit, {})

function jk.json.JSONObjectAdapterExplicit._create()
	local v = _vm:set_metatable({}, jk.json.JSONObjectAdapterExplicit)
	return v
end

function jk.json.JSONObjectAdapterExplicit:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.json.JSONObjectAdapterExplicit'
	self['_isType.jk.json.JSONObjectAdapterExplicit'] = true
	self['_isType.jk.json.JSONObject'] = true
end

function jk.json.JSONObjectAdapterExplicit:_construct0()
	jk.json.JSONObjectAdapterExplicit._init(self)
	return self
end

function jk.json.JSONObjectAdapterExplicit:asJsonValue(value)
	if not (value ~= nil) then
		do return nil end
	end
	if (_vm:to_table_with_key(value, '_isType.jk.json.JSONObject') ~= nil) then
		local oj = value
		do return oj:toJsonObject() end
	end
	do return value end
end

function jk.json.JSONObjectAdapterExplicit:toDynamicMap()
	do return _vm:to_table_with_key(self:toJsonObject(), '_isType.jk.lang.DynamicMap') end
end

function jk.json.JSONObjectAdapterExplicit:toObjectMap()
	local dm = self:toDynamicMap()
	if not (dm ~= nil) then
		do return nil end
	end
	do return dm:toObjectMap() end
end

function jk.json.JSONObjectAdapterExplicit:toJsonObject()
end

function jk.json.JSONObjectAdapterExplicit:fromJsonObject(o)
end
jk = jk or {}

jk.gfx = jk.gfx or {}

jk.gfx.Color = {}
jk.gfx.Color.__index = jk.gfx.Color
_vm:set_metatable(jk.gfx.Color, {})

jk.gfx.Color.colorBlack = nil
jk.gfx.Color.colorWhite = nil

function jk.gfx.Color._create()
	local v = _vm:set_metatable({}, jk.gfx.Color)
	return v
end

function jk.gfx.Color:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.gfx.Color'
	self['_isType.jk.gfx.Color'] = true
	self.red = 0.0
	self.green = 0.0
	self.blue = 0.0
	self.alpha = 0.0
end

function jk.gfx.Color:black()
	if not (_g.jk.gfx.Color.colorBlack ~= nil) then
		_g.jk.gfx.Color.colorBlack = _g.jk.gfx.Color:instance("black")
	end
	do return _g.jk.gfx.Color.colorBlack end
end

function jk.gfx.Color:white()
	if not (_g.jk.gfx.Color.colorWhite ~= nil) then
		_g.jk.gfx.Color.colorWhite = _g.jk.gfx.Color:instance("white")
	end
	do return _g.jk.gfx.Color.colorWhite end
end

function jk.gfx.Color:asColor(o)
	if not (o ~= nil) then
		do return nil end
	end
	if (_vm:to_table_with_key(o, '_isType.jk.gfx.Color') ~= nil) then
		do return o end
	end
	if (_vm:get_variable_type(o) == 'string') then
		do return _g.jk.gfx.Color:instance(o) end
	end
	do return nil end
end

function jk.gfx.Color:instance(str)
	if str == "none" then
		do return nil end
	end
	do
		local v = _g.jk.gfx.Color._construct0(_g.jk.gfx.Color._create())
		if str ~= nil then
			if v:parse(str) == false then
				v = nil
			end
		end
		do return v end
	end
end

function jk.gfx.Color:forString(str)
	if str == "none" then
		do return nil end
	end
	do
		local v = _g.jk.gfx.Color._construct0(_g.jk.gfx.Color._create())
		if str ~= nil then
			if v:parse(str) == false then
				v = nil
			end
		end
		do return v end
	end
end

function jk.gfx.Color:forRGBDouble(r, g, b)
	local v = _g.jk.gfx.Color._construct0(_g.jk.gfx.Color._create())
	do v:setRed(r) end
	do v:setGreen(g) end
	do v:setBlue(b) end
	do v:setAlpha(1.0) end
	do return v end
end

function jk.gfx.Color:forRGBADouble(r, g, b, a)
	local v = _g.jk.gfx.Color._construct0(_g.jk.gfx.Color._create())
	do v:setRed(r) end
	do v:setGreen(g) end
	do v:setBlue(b) end
	do v:setAlpha(a) end
	do return v end
end

function jk.gfx.Color:forRGB(r, g, b)
	local v = _g.jk.gfx.Color._construct0(_g.jk.gfx.Color._create())
	do v:setRed(r / 255.0) end
	do v:setGreen(g / 255.0) end
	do v:setBlue(b / 255.0) end
	do v:setAlpha(1.0) end
	do return v end
end

function jk.gfx.Color:forRGBA(r, g, b, a)
	local v = _g.jk.gfx.Color._construct0(_g.jk.gfx.Color._create())
	do v:setRed(r / 255.0) end
	do v:setGreen(g / 255.0) end
	do v:setBlue(b / 255.0) end
	do v:setAlpha(a / 255.0) end
	do return v end
end

function jk.gfx.Color:forRGBAInteger(value)
	local v = _g.jk.gfx.Color._construct0(_g.jk.gfx.Color._create())
	do v:setRed(_vm:bitwise_and(_vm:bitwise_right_shift(value, 24), 255) / 255.0) end
	do v:setGreen(_vm:bitwise_and(_vm:bitwise_right_shift(value, 16), 255) / 255.0) end
	do v:setBlue(_vm:bitwise_and(_vm:bitwise_right_shift(value, 8), 255) / 255.0) end
	do v:setAlpha(_vm:bitwise_and(value, 255) / 255.0) end
	do return v end
end

function jk.gfx.Color:forARGBInteger(value)
	local v = _g.jk.gfx.Color._construct0(_g.jk.gfx.Color._create())
	do v:setAlpha(_vm:bitwise_and(_vm:bitwise_right_shift(value, 24), 255) / 255.0) end
	do v:setRed(_vm:bitwise_and(_vm:bitwise_right_shift(value, 16), 255) / 255.0) end
	do v:setGreen(_vm:bitwise_and(_vm:bitwise_right_shift(value, 8), 255) / 255.0) end
	do v:setBlue(_vm:bitwise_and(value, 255) / 255.0) end
	do return v end
end

function jk.gfx.Color:forRGBInteger(value)
	local v = _g.jk.gfx.Color._construct0(_g.jk.gfx.Color._create())
	do v:setRed(_vm:bitwise_and(_vm:bitwise_right_shift(value, 16), 255) / 255.0) end
	do v:setGreen(_vm:bitwise_and(_vm:bitwise_right_shift(value, 8), 255) / 255.0) end
	do v:setBlue(_vm:bitwise_and(value, 255) / 255.0) end
	do v:setAlpha(1.0) end
	do return v end
end

function jk.gfx.Color:_construct0()
	jk.gfx.Color._init(self)
	return self
end

function jk.gfx.Color:_construct1(str)
	jk.gfx.Color._init(self)
	do self:parse(str) end
	return self
end

function jk.gfx.Color:getRedInt()
	local v = _util:convert_to_integer(self.red * 255)
	do return v end
end

function jk.gfx.Color:getGreenInt()
	local v = _util:convert_to_integer(self.green * 255)
	do return v end
end

function jk.gfx.Color:getBlueInt()
	local v = _util:convert_to_integer(self.blue * 255)
	do return v end
end

function jk.gfx.Color:getAlphaInt()
	local v = _util:convert_to_integer(self.alpha * 255)
	do return v end
end

function jk.gfx.Color:isWhite()
	if self.red + self.green + self.blue >= 3.0 then
		do return true end
	end
	do return false end
end

function jk.gfx.Color:isBlack()
	if self.red + self.green + self.blue <= 0 then
		do return true end
	end
	do return false end
end

function jk.gfx.Color:isLightColor()
	if self.red + self.green + self.blue >= 1.5 then
		do return true end
	end
	do return false end
end

function jk.gfx.Color:isDarkColor()
	do return not self:isLightColor() end
end

function jk.gfx.Color:hexCharToInt(c)
	if c >= 48 and c <= 57 then
		local v = _util:convert_to_integer(c) - _util:convert_to_integer(48)
		do return v end
	end
	if c >= 97 and c <= 102 then
		do return 10 + _util:convert_to_integer(c) - _util:convert_to_integer(97) end
	end
	if c >= 65 and c <= 70 then
		do return 10 + _util:convert_to_integer(c) - _util:convert_to_integer(65) end
	end
	do return 0 end
end

function jk.gfx.Color:hexDigitToInt(hx)
	if _g.jk.lang.String:isEmpty(hx) then
		do return 0 end
	end
	do
		local c0 = self:hexCharToInt(_g.jk.lang.String:getChar(hx, 0))
		if _g.jk.lang.String:getLength(hx) < 2 then
			do return c0 end
		end
		do return c0 * 16 + self:hexCharToInt(_g.jk.lang.String:getChar(hx, 1)) end
	end
end

function jk.gfx.Color:parse(s)
	if s == nil then
		self.red = 0.0
		self.green = 0.0
		self.blue = 0.0
		self.alpha = 1.0
		do return true end
	end
	do
		local v = true
		self.alpha = 1.0
		if _g.jk.lang.String:getChar(s, 0) == 35 then
			local slength = _g.jk.lang.String:getLength(s)
			if slength == 7 or slength == 9 then
				self.red = self:hexDigitToInt(_g.jk.lang.String:getSubString(s, 1, 2)) / 255.0
				self.green = self:hexDigitToInt(_g.jk.lang.String:getSubString(s, 3, 2)) / 255.0
				self.blue = self:hexDigitToInt(_g.jk.lang.String:getSubString(s, 5, 2)) / 255.0
				if slength == 9 then
					self.alpha = self:hexDigitToInt(_g.jk.lang.String:getSubString(s, 7, 2)) / 255.0
				end
				v = true
			else
				self.red = 0.0
				self.blue = 0.0
				self.green = 0.0
				v = false
			end
		elseif s == "black" then
			self.red = 0.0
			self.green = 0.0
			self.blue = 0.0
		elseif s == "white" then
			self.red = 1.0
			self.green = 1.0
			self.blue = 1.0
		elseif s == "red" then
			self.red = 1.0
			self.green = 0.0
			self.blue = 0.0
		elseif s == "green" then
			self.red = 0.0
			self.green = 1.0
			self.blue = 0.0
		elseif s == "blue" then
			self.red = 0.0
			self.green = 0.0
			self.blue = 1.0
		elseif s == "lightred" then
			self.red = 0.6
			self.green = 0.4
			self.blue = 0.4
		elseif s == "lightgreen" then
			self.red = 0.4
			self.green = 0.6
			self.blue = 0.4
		elseif s == "lightblue" then
			self.red = 0.4
			self.green = 0.4
			self.blue = 0.6
		elseif s == "yellow" then
			self.red = 1.0
			self.green = 1.0
			self.blue = 0.0
		elseif s == "cyan" then
			self.red = 0.0
			self.green = 1.0
			self.blue = 1.0
		elseif s == "orange" then
			self.red = 1.0
			self.green = 0.5
			self.blue = 0.0
		else
			v = false
		end
		do return v end
	end
end

function jk.gfx.Color:decimalStringToInteger(str)
	if _g.jk.lang.String:isEmpty(str) then
		do return 0 end
	end
	do
		local v = 0
		local m = _g.jk.lang.String:getLength(str)
		local n = 0
		do
			n = 0
			while n < m do
				local c = _g.jk.lang.String:getChar(str, n)
				if c >= 48 and c <= 57 then
					v = v * 10
					v = v + (c - _util:convert_to_integer(48))
				else
					do break end
				end
				do n = n + 1 end
			end
		end
		do return v end
	end
end

function jk.gfx.Color:dup(arg)
	local f = 1.0
	if arg ~= nil then
		if arg == "light" then
			f = 1.2
		elseif arg == "dark" then
			f = 0.8
		elseif _g.jk.lang.String:endsWith(arg, "%") then
			f = self:decimalStringToInteger(arg) / 100.0
		end
	end
	do
		local v = _g.jk.gfx.Color._construct0(_g.jk.gfx.Color._create())
		if f > 1.0 then
			do v:setRed(self.red + (1.0 - self.red) * (f - 1.0)) end
			do v:setGreen(self.green + (1.0 - self.green) * (f - 1.0)) end
			do v:setBlue(self.blue + (1.0 - self.blue) * (f - 1.0)) end
		elseif f < 1.0 then
			do v:setRed(self.red * f) end
			do v:setGreen(self.green * f) end
			do v:setBlue(self.blue * f) end
		else
			do v:setRed(self.red) end
			do v:setGreen(self.green) end
			do v:setBlue(self.blue) end
		end
		do v:setAlpha(self.alpha) end
		do return v end
	end
end

function jk.gfx.Color:toRGBAInt32()
	local v = 0
	v = _vm:bitwise_or(v, _vm:bitwise_left_shift(_vm:bitwise_and(_util:convert_to_integer(self.red * 255), 255), 24))
	v = _vm:bitwise_or(v, _vm:bitwise_left_shift(_vm:bitwise_and(_util:convert_to_integer(self.green * 255), 255), 16))
	v = _vm:bitwise_or(v, _vm:bitwise_left_shift(_vm:bitwise_and(_util:convert_to_integer(self.blue * 255), 255), 8))
	v = _vm:bitwise_or(v, _vm:bitwise_and(_util:convert_to_integer(self.alpha * 255), 255))
	do return v end
end

function jk.gfx.Color:toARGBInt32()
	local v = 0
	v = _vm:bitwise_or(v, _vm:bitwise_left_shift(_vm:bitwise_and(_util:convert_to_integer(self.alpha * 255), 255), 24))
	v = _vm:bitwise_or(v, _vm:bitwise_left_shift(_vm:bitwise_and(_util:convert_to_integer(self.red * 255), 255), 16))
	v = _vm:bitwise_or(v, _vm:bitwise_left_shift(_vm:bitwise_and(_util:convert_to_integer(self.green * 255), 255), 8))
	v = _vm:bitwise_or(v, _vm:bitwise_and(_util:convert_to_integer(self.blue * 255), 255))
	do return v end
end

function jk.gfx.Color:toString()
	do return self:toRgbaString() end
end

function jk.gfx.Color:toRgbString()
	local r = _g.jk.lang.String:forIntegerHex(_util:convert_to_integer(self.red * 255), 0)
	local g = _g.jk.lang.String:forIntegerHex(_util:convert_to_integer(self.green * 255), 0)
	local b = _g.jk.lang.String:forIntegerHex(_util:convert_to_integer(self.blue * 255), 0)
	local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	do sb:appendCharacter(35) end
	do self:to2Digits(r, sb) end
	do self:to2Digits(g, sb) end
	do self:to2Digits(b, sb) end
	do return sb:toString() end
end

function jk.gfx.Color:toRgbaString()
	local a = _g.jk.lang.String:forIntegerHex(_util:convert_to_integer(self.alpha * 255), 0)
	do return _g.jk.lang.String:safeString(self:toRgbString()) .. _g.jk.lang.String:safeString(a) end
end

function jk.gfx.Color:toHtmlRgbaString()
	local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
	do sb:appendString("rgba(") end
	do sb:appendString(_g.jk.lang.String:forInteger(_util:convert_to_integer(self.red * 255))) end
	do sb:appendCharacter(44) end
	do sb:appendString(_g.jk.lang.String:forInteger(_util:convert_to_integer(self.green * 255))) end
	do sb:appendCharacter(44) end
	do sb:appendString(_g.jk.lang.String:forInteger(_util:convert_to_integer(self.blue * 255))) end
	do sb:appendCharacter(44) end
	do sb:appendString(_g.jk.lang.String:forDouble(self.alpha)) end
	do sb:appendCharacter(41) end
	do return sb:toString() end
end

function jk.gfx.Color:toHtmlCompatibleString()
	if self.alpha >= 1.0 then
		do return self:toRgbString() end
	end
	do return self:toHtmlRgbaString() end
end

function jk.gfx.Color:toRGBInteger()
	local v = _util:convert_to_integer(self.blue * 255)
	v = _vm:bitwise_or(v, _vm:bitwise_left_shift(_util:convert_to_integer(self.green * 255), 8))
	v = _vm:bitwise_or(v, _vm:bitwise_left_shift(_util:convert_to_integer(self.red * 255), 16))
	do return v end
end

function jk.gfx.Color:to2Digits(val, sb)
	if _g.jk.lang.String:getLength(val) == 1 then
		do sb:appendCharacter(48) end
	end
	do sb:appendString(val) end
end

function jk.gfx.Color:getRed()
	do return self.red end
end

function jk.gfx.Color:setRed(v)
	self.red = v
	do return self end
end

function jk.gfx.Color:getGreen()
	do return self.green end
end

function jk.gfx.Color:setGreen(v)
	self.green = v
	do return self end
end

function jk.gfx.Color:getBlue()
	do return self.blue end
end

function jk.gfx.Color:setBlue(v)
	self.blue = v
	do return self end
end

function jk.gfx.Color:getAlpha()
	do return self.alpha end
end

function jk.gfx.Color:setAlpha(v)
	self.alpha = v
	do return self end
end

jk.gfx.FontDescription = {}
jk.gfx.FontDescription.__index = jk.gfx.FontDescription
_vm:set_metatable(jk.gfx.FontDescription, {})

function jk.gfx.FontDescription._create()
	local v = _vm:set_metatable({}, jk.gfx.FontDescription)
	return v
end

function jk.gfx.FontDescription:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.gfx.FontDescription'
	self['_isType.jk.gfx.FontDescription'] = true
	self['_isType.jk.lang.StringObject'] = true
	self.file = nil
	self.name = nil
	self.bold = false
	self.italic = false
	self.underline = false
	self.size = nil
end

function jk.gfx.FontDescription:forDefault()
	do return _g.jk.gfx.FontDescription._construct0(_g.jk.gfx.FontDescription._create()) end
end

function jk.gfx.FontDescription:forFile(file, size)
	local v = _g.jk.gfx.FontDescription._construct0(_g.jk.gfx.FontDescription._create())
	do v:setFile(file) end
	if size ~= nil then
		do v:setSize(size) end
	end
	do return v end
end

function jk.gfx.FontDescription:forName(name, size)
	local v = _g.jk.gfx.FontDescription._construct0(_g.jk.gfx.FontDescription._create())
	do v:setName(name) end
	if size ~= nil then
		do v:setSize(size) end
	end
	do return v end
end

function jk.gfx.FontDescription:_construct0()
	jk.gfx.FontDescription._init(self)
	self.file = nil
	self.name = "Sans"
	self.size = _g.jk.gfx.Length:forMicroMeters(2500, 0.0)
	self.bold = false
	self.italic = false
	self.underline = false
	return self
end

function jk.gfx.FontDescription:dup()
	local v = _g.jk.gfx.FontDescription._construct0(_g.jk.gfx.FontDescription._create())
	v.file = self.file
	v.name = self.name
	v.bold = self.bold
	v.italic = self.italic
	v.underline = self.underline
	v.size = self.size
	do return v end
end

function jk.gfx.FontDescription:toString()
	local v = _g.jk.lang.DynamicMap._construct0(_g.jk.lang.DynamicMap._create())
	do v:setObject("file", self.file) end
	do v:setString("name", self.name) end
	do v:setBoolean("bold", self.bold) end
	do v:setBoolean("italic", self.italic) end
	do v:setBoolean("underline", self.underline) end
	do v:setObject("size", self.size) end
	do return _g.jk.json.JSONEncoder:encode(v, true, false) end
end

function jk.gfx.FontDescription:getFile()
	do return self.file end
end

function jk.gfx.FontDescription:setFile(v)
	self.file = v
	do return self end
end

function jk.gfx.FontDescription:getName()
	do return self.name end
end

function jk.gfx.FontDescription:setName(v)
	self.name = v
	do return self end
end

function jk.gfx.FontDescription:getBold()
	do return self.bold end
end

function jk.gfx.FontDescription:setBold(v)
	self.bold = v
	do return self end
end

function jk.gfx.FontDescription:getItalic()
	do return self.italic end
end

function jk.gfx.FontDescription:setItalic(v)
	self.italic = v
	do return self end
end

function jk.gfx.FontDescription:getUnderline()
	do return self.underline end
end

function jk.gfx.FontDescription:setUnderline(v)
	self.underline = v
	do return self end
end

function jk.gfx.FontDescription:getSize()
	do return self.size end
end

function jk.gfx.FontDescription:setSize(v)
	self.size = v
	do return self end
end

jk.gfx.Position = {}
jk.gfx.Position.__index = jk.gfx.Position
_vm:set_metatable(jk.gfx.Position, {})

function jk.gfx.Position._create()
	local v = _vm:set_metatable({}, jk.gfx.Position)
	return v
end

function jk.gfx.Position:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.gfx.Position'
	self['_isType.jk.gfx.Position'] = true
	self.x = 0.0
	self.y = 0.0
end

function jk.gfx.Position:_construct0()
	jk.gfx.Position._init(self)
	return self
end

function jk.gfx.Position:getX()
	do return self.x end
end

function jk.gfx.Position:setX(v)
	self.x = v
	do return self end
end

function jk.gfx.Position:getY()
	do return self.y end
end

function jk.gfx.Position:setY(v)
	self.y = v
	do return self end
end

jk.gfx.Image = {}
jk.gfx.Image.__index = jk.gfx.Image
_vm:set_metatable(jk.gfx.Image, {})

function jk.gfx.Image._create()
	local v = _vm:set_metatable({}, jk.gfx.Image)
	return v
end

function jk.gfx.Image:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.gfx.Image'
	self['_isType.jk.gfx.Image'] = true
end

function jk.gfx.Image:_construct0()
	jk.gfx.Image._init(self)
	return self
end

function jk.gfx.Image:getPixelWidth()
end

function jk.gfx.Image:getPixelHeight()
end

function jk.gfx.Image:scaleToSizeSync(w, h)
end

function jk.gfx.Image:scaleToSize(w, h, callback)
end

function jk.gfx.Image:scaleToWidthSync(w)
end

function jk.gfx.Image:scaleToWidth(w, callback)
end

function jk.gfx.Image:scaleToHeightSync(h)
end

function jk.gfx.Image:scaleToHeight(h, callback)
end

function jk.gfx.Image:cropSync(x, y, w, h)
end

function jk.gfx.Image:crop(x, y, w, h, callback)
end

function jk.gfx.Image:toJPGData()
end

function jk.gfx.Image:toPNGData()
end

function jk.gfx.Image:toRGBAData()
end

function jk.gfx.Image:releaseImage()
end

function jk.gfx.Image:getProportionalWidth(h)
	local width = h / self:getPixelHeight() * _util:convert_to_integer(self:getPixelWidth())
	do return _util:convert_to_integer(width) end
end

function jk.gfx.Image:getProportionalHeight(w)
	local height = w / self:getPixelWidth() * _util:convert_to_integer(self:getPixelHeight())
	do return _util:convert_to_integer(height) end
end

jk.gfx.Size = {}
jk.gfx.Size.__index = jk.gfx.Size
_vm:set_metatable(jk.gfx.Size, {})

function jk.gfx.Size._create()
	local v = _vm:set_metatable({}, jk.gfx.Size)
	return v
end

function jk.gfx.Size:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.gfx.Size'
	self['_isType.jk.gfx.Size'] = true
	self.width = 0.0
	self.height = 0.0
end

function jk.gfx.Size:_construct0()
	jk.gfx.Size._init(self)
	return self
end

function jk.gfx.Size:getWidth()
	do return self.width end
end

function jk.gfx.Size:setWidth(v)
	self.width = v
	do return self end
end

function jk.gfx.Size:getHeight()
	do return self.height end
end

function jk.gfx.Size:setHeight(v)
	self.height = v
	do return self end
end

jk.gfx.Length = {}
jk.gfx.Length.__index = jk.gfx.Length
_vm:set_metatable(jk.gfx.Length, {})

jk.gfx.Length.UNIT_POINT = 0
jk.gfx.Length.UNIT_MILLIMETER = 1
jk.gfx.Length.UNIT_MICROMETER = 2
jk.gfx.Length.UNIT_NANOMETER = 3
jk.gfx.Length.UNIT_INCH = 4

function jk.gfx.Length._create()
	local v = _vm:set_metatable({}, jk.gfx.Length)
	return v
end

function jk.gfx.Length:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.gfx.Length'
	self['_isType.jk.gfx.Length'] = true
	self['_isType.jk.lang.StringObject'] = true
	self.value = 0.0
	self.unit = 0
	self.ppi = 96.0
end

function jk.gfx.Length:_construct0()
	jk.gfx.Length._init(self)
	return self
end

function jk.gfx.Length:asPoints(value, ppi)
	do return _g.jk.gfx.Length:forString(value, 0.0):toPoints(ppi) end
end

function jk.gfx.Length:asPointsWithPpi(value, ppi)
	do return _g.jk.gfx.Length:forString(value, 0.0):getValueAsPointsWithPpi(ppi) end
end

function jk.gfx.Length:unitToString(unit)
	if unit == _g.jk.gfx.Length.UNIT_POINT then
		do return "pt" end
	end
	if unit == _g.jk.gfx.Length.UNIT_MILLIMETER then
		do return "mm" end
	end
	if unit == _g.jk.gfx.Length.UNIT_MICROMETER then
		do return "um" end
	end
	if unit == _g.jk.gfx.Length.UNIT_NANOMETER then
		do return "nm" end
	end
	if unit == _g.jk.gfx.Length.UNIT_INCH then
		do return "in" end
	end
	do return nil end
end

function jk.gfx.Length:asStringWithUnit(length, unit)
	local v = 0.0
	if not (length ~= nil) then
		v = 0.0
	else
		v = length:getValueAsUnit(unit)
	end
	do return _g.jk.lang.String:safeString(_g.jk.lang.String:forDouble(v)) .. _g.jk.lang.String:safeString(_g.jk.gfx.Length:unitToString(unit)) end
end

function jk.gfx.Length:asString(length)
	if not (length ~= nil) then
		do return "0px" end
	end
	do return _g.jk.gfx.Length:asStringWithUnit(length, length:getUnit()) end
end

function jk.gfx.Length:forString(value, ppi)
	local v = _g.jk.gfx.Length._construct0(_g.jk.gfx.Length._create())
	do v:parse(value) end
	if ppi > 0.0 then
		do v:setPpi(ppi) end
	end
	do return v end
end

function jk.gfx.Length:forPoints(value, ppi)
	local v = _g.jk.gfx.Length._construct0(_g.jk.gfx.Length._create())
	do v:setValue(value) end
	do v:setUnit(_g.jk.gfx.Length.UNIT_POINT) end
	if ppi > 0.0 then
		do v:setPpi(ppi) end
	end
	do return v end
end

function jk.gfx.Length:forMilliMeters(value, ppi)
	local v = _g.jk.gfx.Length._construct0(_g.jk.gfx.Length._create())
	do v:setValue(value) end
	do v:setUnit(_g.jk.gfx.Length.UNIT_MILLIMETER) end
	if ppi > 0.0 then
		do v:setPpi(ppi) end
	end
	do return v end
end

function jk.gfx.Length:forMicroMeters(value, ppi)
	local v = _g.jk.gfx.Length._construct0(_g.jk.gfx.Length._create())
	do v:setValue(value) end
	do v:setUnit(_g.jk.gfx.Length.UNIT_MICROMETER) end
	if ppi > 0.0 then
		do v:setPpi(ppi) end
	end
	do return v end
end

function jk.gfx.Length:forNanoMeters(value, ppi)
	local v = _g.jk.gfx.Length._construct0(_g.jk.gfx.Length._create())
	do v:setValue(value) end
	do v:setUnit(_g.jk.gfx.Length.UNIT_NANOMETER) end
	if ppi > 0.0 then
		do v:setPpi(ppi) end
	end
	do return v end
end

function jk.gfx.Length:forInches(value, ppi)
	local v = _g.jk.gfx.Length._construct0(_g.jk.gfx.Length._create())
	do v:setValue(value) end
	do v:setUnit(_g.jk.gfx.Length.UNIT_INCH) end
	if ppi > 0.0 then
		do v:setPpi(ppi) end
	end
	do return v end
end

function jk.gfx.Length:forValue(value, unit, ppi)
	local v = _g.jk.gfx.Length._construct0(_g.jk.gfx.Length._create())
	do v:setValue(value) end
	do v:setUnit(unit) end
	if ppi > 0.0 then
		do v:setPpi(ppi) end
	end
	do return v end
end

function jk.gfx.Length:forStringAsPoints(value, ppi)
	local v = _g.jk.gfx.Length._construct0(_g.jk.gfx.Length._create())
	do v:parse(value) end
	do v:setValue(v:toPoints(ppi)) end
	do v:setUnit(_g.jk.gfx.Length.UNIT_POINT) end
	do v:setPpi(ppi) end
	do return v end
end

function jk.gfx.Length:parse(value)
	if value == nil then
		self.value = 0
		self.unit = _g.jk.gfx.Length.UNIT_POINT
		do return end
	end
	do
		local i = 0
		local n = 0
		local it = _g.jk.lang.String:iterate(value)
		while true do
			local c = it:getNextChar()
			if c < 1 then
				do break end
			elseif c >= 48 and c <= 57 then
				i = i * 10
				i = i + (c - _util:convert_to_integer(48))
			else
				do break end
			end
			do n = n + 1 end
		end
		self.value = i
		do
			local suffix = _g.jk.lang.String:getEndOfString(value, n)
			if _g.jk.lang.String:isEmpty(suffix) then
				self.unit = _g.jk.gfx.Length.UNIT_POINT
			elseif suffix == "pt" or suffix == "px" then
				self.unit = _g.jk.gfx.Length.UNIT_POINT
			elseif suffix == "mm" then
				self.unit = _g.jk.gfx.Length.UNIT_MILLIMETER
			elseif suffix == "um" then
				self.unit = _g.jk.gfx.Length.UNIT_MICROMETER
			elseif suffix == "nm" then
				self.unit = _g.jk.gfx.Length.UNIT_NANOMETER
			elseif suffix == "in" then
				self.unit = _g.jk.gfx.Length.UNIT_INCH
			else
				self.unit = _g.jk.gfx.Length.UNIT_POINT
			end
		end
	end
end

function jk.gfx.Length:toPoints(customPpi)
	do return _util:convert_to_integer(self:getValueAsPointsWithPpi(customPpi)) end
end

function jk.gfx.Length:getValueAsPointsWithPpi(customPpi)
	if self.unit == _g.jk.gfx.Length.UNIT_POINT then
		if self.ppi == customPpi then
			do return self.value end
		end
		if self.ppi == 0.0 then
			do return 0.0 end
		end
		do return customPpi * self.value / self.ppi end
	end
	if self.unit == _g.jk.gfx.Length.UNIT_MILLIMETER then
		local v = self.value * customPpi / 25
		if self.value > 0 and v < 1 then
			v = 1.0
		end
		do return v end
	end
	if self.unit == _g.jk.gfx.Length.UNIT_MICROMETER then
		local v = self.value * customPpi / 25000
		if self.value > 0 and v < 1 then
			v = 1.0
		end
		do return v end
	end
	if self.unit == _g.jk.gfx.Length.UNIT_NANOMETER then
		local v = self.value * customPpi / 25000000
		if self.value > 0 and v < 1 then
			v = 1.0
		end
		do return v end
	end
	if self.unit == _g.jk.gfx.Length.UNIT_INCH then
		local v = self.value * customPpi
		if self.value > 0 and v < 1 then
			v = 1.0
		end
		do return v end
	end
	do return 0.0 end
end

function jk.gfx.Length:getValueAsPoints()
	do return self:getValueAsPointsWithPpi(self.ppi) end
end

function jk.gfx.Length:getValueAsMilliMeters()
	if not (self.ppi ~= 0.0) then
		do return 0.0 end
	end
	do return 25 * self:getValueAsPoints() / self.ppi end
end

function jk.gfx.Length:getValueAsMicroMeters()
	if not (self.ppi ~= 0.0) then
		do return 0.0 end
	end
	do return 25000 * self:getValueAsPoints() / self.ppi end
end

function jk.gfx.Length:getValueAsNanoMeters()
	if not (self.ppi ~= 0.0) then
		do return 0.0 end
	end
	do return 25000000 * self:getValueAsPoints() / self.ppi end
end

function jk.gfx.Length:getValueAsInches()
	if not (self.ppi ~= 0.0) then
		do return 0.0 end
	end
	do return self:getValueAsPoints() / self.ppi end
end

function jk.gfx.Length:getValueAsUnit(unit)
	if unit == _g.jk.gfx.Length.UNIT_POINT then
		do return self:getValueAsPoints() end
	end
	if unit == _g.jk.gfx.Length.UNIT_MILLIMETER then
		do return self:getValueAsMilliMeters() end
	end
	if unit == _g.jk.gfx.Length.UNIT_MICROMETER then
		do return self:getValueAsMicroMeters() end
	end
	if unit == _g.jk.gfx.Length.UNIT_NANOMETER then
		do return self:getValueAsNanoMeters() end
	end
	if unit == _g.jk.gfx.Length.UNIT_INCH then
		do return self:getValueAsInches() end
	end
	do return self.value end
end

function jk.gfx.Length:toString()
	do return _g.jk.gfx.Length:asString(self) end
end

function jk.gfx.Length:getValue()
	do return self.value end
end

function jk.gfx.Length:setValue(v)
	self.value = v
	do return self end
end

function jk.gfx.Length:getUnit()
	do return self.unit end
end

function jk.gfx.Length:setUnit(v)
	self.unit = v
	do return self end
end

function jk.gfx.Length:getPpi()
	do return self.ppi end
end

function jk.gfx.Length:setPpi(v)
	self.ppi = v
	do return self end
end
jk = jk or {}

jk.app = jk.app or {}

jk.app.ApplicationContext = {}
jk = jk or {}

jk.thread = jk.thread or {}

jk.thread.Mutex = {}
jk.thread.Mutex.__index = jk.thread.Mutex
_vm:set_metatable(jk.thread.Mutex, {})

function jk.thread.Mutex._create()
	local v = _vm:set_metatable({}, jk.thread.Mutex)
	return v
end

function jk.thread.Mutex:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.thread.Mutex'
	self['_isType.jk.thread.Mutex'] = true
end

function jk.thread.Mutex:_construct0()
	jk.thread.Mutex._init(self)
	return self
end

function jk.thread.Mutex:create()
	_io:write_to_stdout("[jk.thread.Mutex.create] (Mutex.sling:48:3): Not implemented" .. "\n")
	do return nil end
end

function jk.thread.Mutex:forObject(value)
	_io:write_to_stdout("[jk.thread.Mutex.forObject] (Mutex.sling:55:2): Not implemented" .. "\n")
	do return nil end
end

function jk.thread.Mutex:lockMutex()
end

function jk.thread.Mutex:unlockMutex()
end

jk.thread.RunningThread = {}

jk.thread.Thread = {}
jk.thread.Thread.__index = jk.thread.Thread
_vm:set_metatable(jk.thread.Thread, {})

jk.thread.Thread.localValues = {}

function jk.thread.Thread._create()
	local v = _vm:set_metatable({}, jk.thread.Thread)
	return v
end

function jk.thread.Thread:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.thread.Thread'
	self['_isType.jk.thread.Thread'] = true
end

function jk.thread.Thread:_construct0()
	jk.thread.Thread._init(self)
	return self
end

function jk.thread.Thread:setLocalValue(id, value)
	if id ~= nil then
		_g.jk.thread.Thread.localValues[id] = value
	end
end

function jk.thread.Thread:getLocalValue(id)
	if not (id ~= nil) then
		do return nil end
	end
	do return _g.jk.lang.Map:get(_g.jk.thread.Thread.localValues, id) end
end

function jk.thread.Thread:removeLocalValue(id)
	if id ~= nil then
		do _g.jk.lang.Map:remove(_g.jk.thread.Thread.localValues, id) end
	end
end

function jk.thread.Thread:start(runnable)
	if not (runnable ~= nil) then
		do return nil end
	end
	_io:write_to_stdout("[jk.thread.Thread.start] (Thread.sling:359:3): Not implemented" .. "\n")
	do return nil end
end

jk.thread.ThreadPool = {}
jk.thread.ThreadPool.__index = jk.thread.ThreadPool
_vm:set_metatable(jk.thread.ThreadPool, {})

function jk.thread.ThreadPool._create()
	local v = _vm:set_metatable({}, jk.thread.ThreadPool)
	return v
end

function jk.thread.ThreadPool:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.thread.ThreadPool'
	self['_isType.jk.thread.ThreadPool'] = true
	self.maximumPoolSize = 0
	self.queue = nil
	self.runningThreadsCount = 0
	self.mutex = nil
end

function jk.thread.ThreadPool:forMaxPoolSize(maximumPoolSize)
	local v = _g.jk.thread.ThreadPool._construct0(_g.jk.thread.ThreadPool._create())
	v.maximumPoolSize = maximumPoolSize
	do return v end
end

function jk.thread.ThreadPool:_construct0()
	jk.thread.ThreadPool._init(self)
	self.queue = {}
	self.mutex = _g.jk.thread.Mutex:create()
	return self
end

function jk.thread.ThreadPool:getRunningThreadsCount()
	do return self.runningThreadsCount end
end

function jk.thread.ThreadPool:submitTask(task)
	do self:execute(task) end
end

function jk.thread.ThreadPool:submitTasks(tasks)
	if tasks ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(tasks)
		do
			n = 0
			while n < m do
				local task = tasks[n + 1]
				if task ~= nil then
					do self:execute(task) end
				end
				do n = n + 1 end
			end
		end
	end
end

function jk.thread.ThreadPool:execute(task)
	if not (task ~= nil) then
		do return end
	end
	do self.mutex:lockMutex() end
	if self.runningThreadsCount < self.maximumPoolSize then
		local runner = _g.jk.thread.ThreadPool.TaskRunner._construct0(_g.jk.thread.ThreadPool.TaskRunner._create())
		do runner:setMyParent(self) end
		do runner:setRunnable(task) end
		if _g.jk.thread.Thread:start(runner) ~= nil then
			do self.runningThreadsCount = self.runningThreadsCount + 1 end
		else
			do _g.jk.lang.Vector:append(self.queue, task) end
		end
	else
		do _g.jk.lang.Vector:append(self.queue, task) end
	end
	do self.mutex:unlockMutex() end
end

function jk.thread.ThreadPool:getTaskFromQueue()
	do self.mutex:lockMutex() end
	do
		local item = _vm:to_table_with_key(_g.jk.lang.Vector:popFirst(self.queue), '_isType.jk.lang.Runnable')
		if not (item ~= nil) then
			do self.runningThreadsCount = self.runningThreadsCount - 1 end
		end
		do self.mutex:unlockMutex() end
		do return item end
	end
end

jk.thread.ThreadPool.TaskRunner = {}
jk.thread.ThreadPool.TaskRunner.__index = jk.thread.ThreadPool.TaskRunner
_vm:set_metatable(jk.thread.ThreadPool.TaskRunner, {})

function jk.thread.ThreadPool.TaskRunner._create()
	local v = _vm:set_metatable({}, jk.thread.ThreadPool.TaskRunner)
	return v
end

function jk.thread.ThreadPool.TaskRunner:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.thread.ThreadPool.TaskRunner'
	self['_isType.jk.thread.ThreadPool.TaskRunner'] = true
	self['_isType.jk.lang.Runnable'] = true
	self.runnable = nil
	self.myParent = nil
end

function jk.thread.ThreadPool.TaskRunner:_construct0()
	jk.thread.ThreadPool.TaskRunner._init(self)
	return self
end

function jk.thread.ThreadPool.TaskRunner:run()
	while true do
		do self.runnable:run() end
		do
			local next = self.myParent:getTaskFromQueue()
			if not (next ~= nil) then
				do break end
			end
			self.runnable = next
		end
	end
end

function jk.thread.ThreadPool.TaskRunner:getRunnable()
	do return self.runnable end
end

function jk.thread.ThreadPool.TaskRunner:setRunnable(v)
	self.runnable = v
	do return self end
end

function jk.thread.ThreadPool.TaskRunner:getMyParent()
	do return self.myParent end
end

function jk.thread.ThreadPool.TaskRunner:setMyParent(v)
	self.myParent = v
	do return self end
end

jk.thread.CurrentThread = {}
jk.thread.CurrentThread.__index = jk.thread.CurrentThread
_vm:set_metatable(jk.thread.CurrentThread, {})

function jk.thread.CurrentThread._create()
	local v = _vm:set_metatable({}, jk.thread.CurrentThread)
	return v
end

function jk.thread.CurrentThread:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.thread.CurrentThread'
	self['_isType.jk.thread.CurrentThread'] = true
end

function jk.thread.CurrentThread:_construct0()
	jk.thread.CurrentThread._init(self)
	return self
end

function jk.thread.CurrentThread:sleepSeconds(seconds)
	do _os:sleep_seconds(seconds) end
end

function jk.thread.CurrentThread:sleepMicroSeconds(uSeconds)
	do _os:sleep_microseconds(uSeconds) end
end

function jk.thread.CurrentThread:sleepMilliSeconds(mSeconds)
	do _os:sleep_milliseconds(mSeconds) end
end

jk.thread.CriticalSection = {}
jk.thread.CriticalSection.__index = jk.thread.CriticalSection
_vm:set_metatable(jk.thread.CriticalSection, {})

function jk.thread.CriticalSection._create()
	local v = _vm:set_metatable({}, jk.thread.CriticalSection)
	return v
end

function jk.thread.CriticalSection:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.thread.CriticalSection'
	self['_isType.jk.thread.CriticalSection'] = true
end

function jk.thread.CriticalSection:_construct0()
	jk.thread.CriticalSection._init(self)
	return self
end

function jk.thread.CriticalSection:execute(value, block)
	local mutex = _g.jk.thread.Mutex:forObject(value)
	if mutex ~= nil then
		do mutex:lockMutex() end
	end
	if block ~= nil then
		do block() end
	end
	if mutex ~= nil then
		do mutex:unlockMutex() end
	end
end

jk.thread.SushiThread = {}
jk.thread.SushiThread.__index = jk.thread.SushiThread
_vm:set_metatable(jk.thread.SushiThread, {})

function jk.thread.SushiThread._create()
	local v = _vm:set_metatable({}, jk.thread.SushiThread)
	return v
end

function jk.thread.SushiThread:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.thread.SushiThread'
	self['_isType.jk.thread.SushiThread'] = true
	self.interpreter = nil
	self.reuseInterpreter = false
end

function jk.thread.SushiThread:_construct0()
	jk.thread.SushiThread._init(self)
	return self
end

function jk.thread.SushiThread:getOutputWriter()
	local fd = _pipefd
	if fd < 0 then
		do return nil end
	end
	do return _g.jk.io.FileDescriptorWriter:forUnownedFileDescriptor(fd) end
end

function jk.thread.SushiThread:getInputBuffer()
	do return _input end
end

function jk.thread.SushiThread:forThisProgram()
	local interpreter = _vm:prepare_interpreter(_code)
	if not (interpreter ~= nil) then
		do return nil end
	end
	do
		local v = _g.jk.thread.SushiThread._construct0(_g.jk.thread.SushiThread._create())
		do v:setInterpreter(interpreter) end
		do return v end
	end
end

function jk.thread.SushiThread:forCode(code)
	if not (code ~= nil) then
		do return nil end
	end
	do
		local interpreter = _vm:prepare_interpreter(code)
		if not (interpreter ~= nil) then
			do return nil end
		end
		do
			local v = _g.jk.thread.SushiThread._construct0(_g.jk.thread.SushiThread._create())
			do v:setInterpreter(interpreter) end
			do return v end
		end
	end
end

function jk.thread.SushiThread:start(fname, input)
	local interpreter = self.interpreter
	if not (interpreter ~= nil) then
		do return false end
	end
	do
		local ff = fname
		if _g.jk.lang.String:isEmpty(ff) then
			ff = "_main()"
		end
		do
			local reuse = 0
			if self.reuseInterpreter then
				reuse = 1
			end
			do
				local v = _os:execute_in_thread(interpreter, ff, input, 0, reuse)
				if v < 0 then
					do return false end
				end
				if not self.reuseInterpreter then
					interpreter = nil
				end
				do return true end
			end
		end
	end
end

function jk.thread.SushiThread:startPiped(fname, input)
	local interpreter = self.interpreter
	if not (interpreter ~= nil) then
		do return nil end
	end
	do
		local ff = fname
		if _g.jk.lang.String:isEmpty(ff) then
			ff = "_main()"
		end
		do
			local reuse = 0
			if self.reuseInterpreter then
				reuse = 1
			end
			do
				local v = _os:execute_in_thread(interpreter, ff, input, 1, reuse)
				if v < 0 then
					do return nil end
				end
				do
					local reader = _g.jk.io.FileDescriptorReader._construct0(_g.jk.io.FileDescriptorReader._create())
					do reader:setFd(v) end
					do return reader end
				end
			end
		end
	end
end

function jk.thread.SushiThread:getInterpreter()
	do return self.interpreter end
end

function jk.thread.SushiThread:setInterpreter(v)
	self.interpreter = v
	do return self end
end

function jk.thread.SushiThread:getReuseInterpreter()
	do return self.reuseInterpreter end
end

function jk.thread.SushiThread:setReuseInterpreter(v)
	self.reuseInterpreter = v
	do return self end
end
jk = jk or {}

jk.math = jk.math or {}

jk.math.Vector3 = {}
jk.math.Vector3.__index = jk.math.Vector3
_vm:set_metatable(jk.math.Vector3, {})

function jk.math.Vector3._create()
	local v = _vm:set_metatable({}, jk.math.Vector3)
	return v
end

function jk.math.Vector3:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.math.Vector3'
	self['_isType.jk.math.Vector3'] = true
	self.x = 0.0
	self.y = 0.0
	self.z = 0.0
end

function jk.math.Vector3:_construct0()
	jk.math.Vector3._init(self)
	return self
end

function jk.math.Vector3:create(x, y, z)
	local v = _g.jk.math.Vector3._construct0(_g.jk.math.Vector3._create())
	v.x = x
	v.y = y
	v.z = z
	do return v end
end

function jk.math.Vector3:add(b)
	self.x = self.x + b.x
	self.y = self.y + b.y
	self.z = self.z + b.z
	do return self end
end

function jk.math.Vector3:subtract(b)
	self.x = self.x - b.x
	self.y = self.y - b.y
	self.z = self.z - b.z
	do return self end
end

function jk.math.Vector3:multiply(b)
	self.x = self.x * b.x
	self.y = self.y * b.y
	self.z = self.z * b.z
	do return self end
end

function jk.math.Vector3:multiplyScalar(a)
	self.x = self.x * a
	self.y = self.y * a
	self.z = self.z * a
	do return self end
end

function jk.math.Vector3:distance(b)
	local dist = (self.y - b.y) * (self.y - b.y) + (self.x - b.x) * (self.x - b.x) + (self.z - b.z) * (self.z - b.z)
	do return _g.jk.math.Math:sqrt(dist) end
end

function jk.math.Vector3:getLength()
	do return _g.jk.math.Math:sqrt(self.x * self.x + self.y * self.y + self.z * self.z) end
end

jk.math.Vector2 = {}
jk.math.Vector2.__index = jk.math.Vector2
_vm:set_metatable(jk.math.Vector2, {})

function jk.math.Vector2._create()
	local v = _vm:set_metatable({}, jk.math.Vector2)
	return v
end

function jk.math.Vector2:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.math.Vector2'
	self['_isType.jk.math.Vector2'] = true
	self.x = 0.0
	self.y = 0.0
end

function jk.math.Vector2:_construct0()
	jk.math.Vector2._init(self)
	return self
end

function jk.math.Vector2:create(x, y)
	local v = _g.jk.math.Vector2._construct0(_g.jk.math.Vector2._create())
	v.x = x
	v.y = y
	do return v end
end

function jk.math.Vector2:add(b)
	self.x = self.x + b.x
	self.y = self.y + b.y
	do return self end
end

function jk.math.Vector2:subtract(b)
	self.x = self.x - b.x
	self.y = self.y - b.y
	do return self end
end

function jk.math.Vector2:multiply(b)
	self.x = self.x * b.x
	self.y = self.y * b.y
	do return self end
end

function jk.math.Vector2:multiplyScalar(a)
	self.x = self.x + a
	self.y = self.y + a
	do return self end
end

function jk.math.Vector2:distance(b)
	local dist = (self.y - b.y) * (self.y - b.y) + (self.x - b.x) * (self.x - b.x)
	do return _g.jk.math.Math:sqrt(dist) end
end

function jk.math.Vector2:getLength()
	do return _g.jk.math.Math:sqrt(self.x * self.x + self.y * self.y) end
end

jk.math.Matrix44 = {}
jk.math.Matrix44.__index = jk.math.Matrix44
_vm:set_metatable(jk.math.Matrix44, {})

function jk.math.Matrix44._create()
	local v = _vm:set_metatable({}, jk.math.Matrix44)
	return v
end

function jk.math.Matrix44:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.math.Matrix44'
	self['_isType.jk.math.Matrix44'] = true
	self.v = _vm:allocate_array(16)
end

function jk.math.Matrix44:_construct0()
	jk.math.Matrix44._init(self)
	return self
end

function jk.math.Matrix44:forZero()
	do return _g.jk.math.Matrix44:forValues({
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0
	}) end
end

function jk.math.Matrix44:forIdentity()
	do return _g.jk.math.Matrix44:forValues({
		1.0,
		0.0,
		0.0,
		0.0,
		0.0,
		1.0,
		0.0,
		0.0,
		0.0,
		0.0,
		1.0,
		0.0,
		0.0,
		0.0,
		0.0,
		1.0
	}) end
end

function jk.math.Matrix44:forTranslate(translateX, translateY, translateZ)
	do return _g.jk.math.Matrix44:forValues({
		1.0,
		0.0,
		0.0,
		translateX,
		0.0,
		1.0,
		0.0,
		translateY,
		0.0,
		0.0,
		1.0,
		translateZ,
		0.0,
		0.0,
		0.0,
		1.0
	}) end
end

function jk.math.Matrix44:forXRotation(angle)
	local c = _g.jk.math.Math:cos(angle)
	local s = _g.jk.math.Math:sin(angle)
	do return _g.jk.math.Matrix44:forValues({
		1.0,
		0.0,
		0.0,
		0.0,
		0.0,
		c,
		-s,
		0.0,
		0.0,
		s,
		c,
		0.0,
		0.0,
		0.0,
		0.0,
		1.0
	}) end
end

function jk.math.Matrix44:forYRotation(angle)
	local c = _g.jk.math.Math:cos(angle)
	local s = _g.jk.math.Math:sin(angle)
	do return _g.jk.math.Matrix44:forValues({
		c,
		0.0,
		s,
		0.0,
		0.0,
		1.0,
		0.0,
		0.0,
		-s,
		0.0,
		c,
		0.0,
		0.0,
		0.0,
		0.0,
		1.0
	}) end
end

function jk.math.Matrix44:forZRotation(angle)
	local c = _g.jk.math.Math:cos(angle)
	local s = _g.jk.math.Math:sin(angle)
	do return _g.jk.math.Matrix44:forValues({
		c,
		-s,
		0.0,
		0.0,
		s,
		c,
		0.0,
		0.0,
		0.0,
		0.0,
		1.0,
		0.0,
		0.0,
		0.0,
		0.0,
		1.0
	}) end
end

function jk.math.Matrix44:forSkew(vx, vy, vz)
	do return _g.jk.math.Matrix44:forValues({
		1.0,
		vx,
		vx,
		0.0,
		vy,
		1.0,
		vy,
		0.0,
		vz,
		vz,
		1.0,
		0.0,
		0.0,
		0.0,
		0.0,
		1.0
	}) end
end

function jk.math.Matrix44:forXRotationWithCenter(angle, centerX, centerY, centerZ)
	local translate = _g.jk.math.Matrix44:forTranslate(centerX, centerY, centerZ)
	local rotate = _g.jk.math.Matrix44:forXRotation(angle)
	local translateBack = _g.jk.math.Matrix44:forTranslate(-centerX, -centerY, -centerZ)
	local translatedRotated = _g.jk.math.Matrix44:multiplyMatrix(translate, rotate)
	do return _g.jk.math.Matrix44:multiplyMatrix(translatedRotated, translateBack) end
end

function jk.math.Matrix44:forYRotationWithCenter(angle, centerX, centerY, centerZ)
	local translate = _g.jk.math.Matrix44:forTranslate(centerX, centerY, centerZ)
	local rotate = _g.jk.math.Matrix44:forYRotation(angle)
	local translateBack = _g.jk.math.Matrix44:forTranslate(-centerX, -centerY, -centerZ)
	local translatedRotated = _g.jk.math.Matrix44:multiplyMatrix(translate, rotate)
	do return _g.jk.math.Matrix44:multiplyMatrix(translatedRotated, translateBack) end
end

function jk.math.Matrix44:forZRotationWithCenter(angle, centerX, centerY, centerZ)
	local translate = _g.jk.math.Matrix44:forTranslate(centerX, centerY, centerZ)
	local rotate = _g.jk.math.Matrix44:forZRotation(angle)
	local translateBack = _g.jk.math.Matrix44:forTranslate(-centerX, -centerY, -centerZ)
	local translatedRotated = _g.jk.math.Matrix44:multiplyMatrix(translate, rotate)
	do return _g.jk.math.Matrix44:multiplyMatrix(translatedRotated, translateBack) end
end

function jk.math.Matrix44:forScale(scaleX, scaleY, scaleZ)
	do return _g.jk.math.Matrix44:forValues({
		scaleX,
		0.0,
		0.0,
		0.0,
		0.0,
		scaleY,
		0.0,
		0.0,
		0.0,
		0.0,
		scaleZ,
		0.0,
		0.0,
		0.0,
		0.0,
		1.0
	}) end
end

function jk.math.Matrix44:forFlipXY(flipXY)
	if flipXY then
		do return _g.jk.math.Matrix44:forValues({
			1.0,
			0.0,
			0.0,
			0.0,
			0.0,
			1.0,
			0.0,
			0.0,
			0.0,
			0.0,
			-1.0,
			0.0,
			0.0,
			0.0,
			0.0,
			1.0
		}) end
	end
	do return _g.jk.math.Matrix44:forIdentity() end
end

function jk.math.Matrix44:forFlipXZ(flipXZ)
	if flipXZ then
		do return _g.jk.math.Matrix44:forValues({
			1.0,
			0.0,
			0.0,
			0.0,
			0.0,
			-1.0,
			0.0,
			0.0,
			0.0,
			0.0,
			1.0,
			0.0,
			0.0,
			0.0,
			0.0,
			1.0
		}) end
	end
	do return _g.jk.math.Matrix44:forIdentity() end
end

function jk.math.Matrix44:forFlipYZ(flipYZ)
	if flipYZ then
		do return _g.jk.math.Matrix44:forValues({
			-1.0,
			0.0,
			0.0,
			0.0,
			0.0,
			1.0,
			0.0,
			0.0,
			0.0,
			0.0,
			1.0,
			0.0,
			0.0,
			0.0,
			0.0,
			1.0
		}) end
	end
	do return _g.jk.math.Matrix44:forIdentity() end
end

function jk.math.Matrix44:forValues(mv)
	local v = _g.jk.math.Matrix44._construct0(_g.jk.math.Matrix44._create())
	local i = 0
	do
		i = 0
		while i < 16 do
			if i >= #mv then
				v.v[i + 1] = 0.0
			else
				v.v[i + 1] = mv[i + 1]
			end
			do i = i + 1 end
		end
	end
	do return v end
end

function jk.math.Matrix44:multiplyScalar(v, mm)
	do return _g.jk.math.Matrix44:forValues({
		mm.v[0 + 1] * v,
		mm.v[1 + 1] * v,
		mm.v[2 + 1] * v,
		mm.v[3 + 1] * v,
		mm.v[4 + 1] * v,
		mm.v[5 + 1] * v,
		mm.v[6 + 1] * v,
		mm.v[7 + 1] * v,
		mm.v[8 + 1] * v,
		mm.v[9 + 1] * v,
		mm.v[10 + 1] * v,
		mm.v[11 + 1] * v,
		mm.v[12 + 1] * v,
		mm.v[3 + 1] * v,
		mm.v[14 + 1] * v,
		mm.v[15 + 1] * v
	}) end
end

function jk.math.Matrix44:multiplyMatrix(a, b)
	local matrix44 = _g.jk.math.Matrix44._construct0(_g.jk.math.Matrix44._create())
	matrix44.v[0 + 1] = a.v[0 + 1] * b.v[0 + 1] + a.v[1 + 1] * b.v[4 + 1] + a.v[2 + 1] * b.v[8 + 1] + a.v[3 + 1] * b.v[12 + 1]
	matrix44.v[1 + 1] = a.v[0 + 1] * b.v[1 + 1] + a.v[1 + 1] * b.v[5 + 1] + a.v[2 + 1] * b.v[9 + 1] + a.v[3 + 1] * b.v[13 + 1]
	matrix44.v[2 + 1] = a.v[0 + 1] * b.v[2 + 1] + a.v[1 + 1] * b.v[6 + 1] + a.v[2 + 1] * b.v[10 + 1] + a.v[3 + 1] * b.v[14 + 1]
	matrix44.v[3 + 1] = a.v[0 + 1] * b.v[3 + 1] + a.v[1 + 1] * b.v[7 + 1] + a.v[2 + 1] * b.v[11 + 1] + a.v[3 + 1] * b.v[15 + 1]
	matrix44.v[4 + 1] = a.v[4 + 1] * b.v[0 + 1] + a.v[5 + 1] * b.v[4 + 1] + a.v[6 + 1] * b.v[8 + 1] + a.v[7 + 1] * b.v[12 + 1]
	matrix44.v[5 + 1] = a.v[4 + 1] * b.v[1 + 1] + a.v[5 + 1] * b.v[5 + 1] + a.v[6 + 1] * b.v[9 + 1] + a.v[7 + 1] * b.v[13 + 1]
	matrix44.v[6 + 1] = a.v[4 + 1] * b.v[2 + 1] + a.v[5 + 1] * b.v[6 + 1] + a.v[6 + 1] * b.v[10 + 1] + a.v[7 + 1] * b.v[14 + 1]
	matrix44.v[7 + 1] = a.v[4 + 1] * b.v[3 + 1] + a.v[5 + 1] * b.v[7 + 1] + a.v[6 + 1] * b.v[11 + 1] + a.v[7 + 1] * b.v[15 + 1]
	matrix44.v[8 + 1] = a.v[8 + 1] * b.v[0 + 1] + a.v[9 + 1] * b.v[4 + 1] + a.v[10 + 1] * b.v[8 + 1] + a.v[11 + 1] * b.v[12 + 1]
	matrix44.v[9 + 1] = a.v[8 + 1] * b.v[1 + 1] + a.v[9 + 1] * b.v[5 + 1] + a.v[10 + 1] * b.v[9 + 1] + a.v[11 + 1] * b.v[13 + 1]
	matrix44.v[10 + 1] = a.v[8 + 1] * b.v[2 + 1] + a.v[9 + 1] * b.v[6 + 1] + a.v[10 + 1] * b.v[10 + 1] + a.v[11 + 1] * b.v[14 + 1]
	matrix44.v[11 + 1] = a.v[8 + 1] * b.v[3 + 1] + a.v[9 + 1] * b.v[7 + 1] + a.v[10 + 1] * b.v[11 + 1] + a.v[11 + 1] * b.v[15 + 1]
	matrix44.v[12 + 1] = a.v[12 + 1] * b.v[0 + 1] + a.v[13 + 1] * b.v[4 + 1] + a.v[14 + 1] * b.v[8 + 1] + a.v[15 + 1] * b.v[12 + 1]
	matrix44.v[13 + 1] = a.v[12 + 1] * b.v[1 + 1] + a.v[13 + 1] * b.v[5 + 1] + a.v[14 + 1] * b.v[9 + 1] + a.v[15 + 1] * b.v[13 + 1]
	matrix44.v[14 + 1] = a.v[12 + 1] * b.v[2 + 1] + a.v[13 + 1] * b.v[6 + 1] + a.v[14 + 1] * b.v[10 + 1] + a.v[15 + 1] * b.v[14 + 1]
	matrix44.v[15 + 1] = a.v[12 + 1] * b.v[3 + 1] + a.v[13 + 1] * b.v[7 + 1] + a.v[14 + 1] * b.v[11 + 1] + a.v[15 + 1] * b.v[15 + 1]
	do return matrix44 end
end

function jk.math.Matrix44:multiplyVector(a, b)
	local x = a.v[0 + 1] * b.x + a.v[1 + 1] * b.y + a.v[2 + 1] * b.z + a.v[3 + 1] * 1.0
	local y = a.v[4 + 1] * b.x + a.v[5 + 1] * b.y + a.v[6 + 1] * b.z + a.v[7 + 1] * 1.0
	local z = a.v[8 + 1] * b.x + a.v[9 + 1] * b.y + a.v[10 + 1] * b.z + a.v[11 + 1] * 1.0
	do return _g.jk.math.Vector3:create(x, y, z) end
end

jk.math.Matrix33 = {}
jk.math.Matrix33.__index = jk.math.Matrix33
_vm:set_metatable(jk.math.Matrix33, {})

function jk.math.Matrix33._create()
	local v = _vm:set_metatable({}, jk.math.Matrix33)
	return v
end

function jk.math.Matrix33:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.math.Matrix33'
	self['_isType.jk.math.Matrix33'] = true
	self.v = _vm:allocate_array(9)
end

function jk.math.Matrix33:_construct0()
	jk.math.Matrix33._init(self)
	return self
end

function jk.math.Matrix33:forZero()
	do return _g.jk.math.Matrix33:forValues({
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0
	}) end
end

function jk.math.Matrix33:forIdentity()
	do return _g.jk.math.Matrix33:forValues({
		1.0,
		0.0,
		0.0,
		0.0,
		1.0,
		0.0,
		0.0,
		0.0,
		1.0
	}) end
end

function jk.math.Matrix33:invertMatrix(m)
	local d = m.v[0 + 1] * m.v[4 + 1] * m.v[8 + 1] + m.v[3 + 1] * m.v[7 + 1] * m.v[2 + 1] + m.v[6 + 1] * m.v[1 + 1] * m.v[5 + 1] - m.v[0 + 1] * m.v[7 + 1] * m.v[5 + 1] - m.v[3 + 1] * m.v[1 + 1] * m.v[8 + 1] - m.v[6 + 1] * m.v[4 + 1] * m.v[2 + 1]
	local v = _g.jk.math.Matrix33._construct0(_g.jk.math.Matrix33._create())
	v.v[0 + 1] = (m.v[4 + 1] * m.v[8 + 1] - m.v[7 + 1] * m.v[5 + 1]) / d
	v.v[3 + 1] = (m.v[6 + 1] * m.v[5 + 1] - m.v[3 + 1] * m.v[8 + 1]) / d
	v.v[6 + 1] = (m.v[3 + 1] * m.v[7 + 1] - m.v[6 + 1] * m.v[4 + 1]) / d
	v.v[1 + 1] = (m.v[7 + 1] * m.v[2 + 1] - m.v[1 + 1] * m.v[8 + 1]) / d
	v.v[4 + 1] = (m.v[0 + 1] * m.v[8 + 1] - m.v[6 + 1] * m.v[2 + 1]) / d
	v.v[7 + 1] = (m.v[6 + 1] * m.v[1 + 1] - m.v[0 + 1] * m.v[7 + 1]) / d
	v.v[2 + 1] = (m.v[1 + 1] * m.v[5 + 1] - m.v[4 + 1] * m.v[2 + 1]) / d
	v.v[5 + 1] = (m.v[3 + 1] * m.v[2 + 1] - m.v[0 + 1] * m.v[5 + 1]) / d
	v.v[8 + 1] = (m.v[0 + 1] * m.v[4 + 1] - m.v[3 + 1] * m.v[1 + 1]) / d
	do return v end
end

function jk.math.Matrix33:forTranslate(translateX, translateY)
	do return _g.jk.math.Matrix33:forValues({
		1.0,
		0.0,
		translateX,
		0.0,
		1.0,
		translateY,
		0.0,
		0.0,
		1.0
	}) end
end

function jk.math.Matrix33:forRotation(angle)
	local c = _g.jk.math.Math:cos(angle)
	local s = _g.jk.math.Math:sin(angle)
	do return _g.jk.math.Matrix33:forValues({
		c,
		s,
		0.0,
		-s,
		c,
		0.0,
		0.0,
		0.0,
		1.0
	}) end
end

function jk.math.Matrix33:forRotationWithCenter(angle, centerX, centerY)
	local translate = _g.jk.math.Matrix33:forTranslate(centerX, centerY)
	local rotate = _g.jk.math.Matrix33:forRotation(angle)
	local translateBack = _g.jk.math.Matrix33:forTranslate(-centerX, -centerY)
	local translatedRotated = _g.jk.math.Matrix33:multiplyMatrix(translate, rotate)
	do return _g.jk.math.Matrix33:multiplyMatrix(translatedRotated, translateBack) end
end

function jk.math.Matrix33:forSkew(skewX, skewY)
	do return _g.jk.math.Matrix33:forValues({
		1.0,
		skewX,
		0.0,
		skewY,
		1.0,
		0.0,
		0.0,
		0.0,
		1.0
	}) end
end

function jk.math.Matrix33:forScale(scaleX, scaleY)
	do return _g.jk.math.Matrix33:forValues({
		scaleX,
		0.0,
		0.0,
		0.0,
		scaleY,
		0.0,
		0.0,
		0.0,
		1.0
	}) end
end

function jk.math.Matrix33:forFlip(flipX, flipY)
	local xmat33 = _g.jk.math.Matrix33:forValues({
		1.0,
		0.0,
		0.0,
		0.0,
		-1.0,
		0.0,
		0.0,
		0.0,
		1.0
	})
	local ymat33 = _g.jk.math.Matrix33:forValues({
		-1.0,
		0.0,
		0.0,
		0.0,
		1.0,
		0.0,
		0.0,
		0.0,
		1.0
	})
	if flipX and flipY then
		do return _g.jk.math.Matrix33:multiplyMatrix(xmat33, ymat33) end
	elseif flipX then
		do return xmat33 end
	elseif flipY then
		do return ymat33 end
	end
	do return _g.jk.math.Matrix33:forIdentity() end
end

function jk.math.Matrix33:forValues(mv)
	local v = _g.jk.math.Matrix33._construct0(_g.jk.math.Matrix33._create())
	local i = 0
	do
		i = 0
		while i < 9 do
			if i >= #mv then
				v.v[i + 1] = 0.0
			else
				v.v[i + 1] = mv[i + 1]
			end
			do i = i + 1 end
		end
	end
	do return v end
end

function jk.math.Matrix33:multiplyScalar(v, mm)
	local mat33 = _g.jk.math.Matrix33:forZero()
	mat33.v[0 + 1] = mm.v[0 + 1] * v
	mat33.v[1 + 1] = mm.v[1 + 1] * v
	mat33.v[2 + 1] = mm.v[2 + 1] * v
	mat33.v[3 + 1] = mm.v[3 + 1] * v
	mat33.v[4 + 1] = mm.v[4 + 1] * v
	mat33.v[5 + 1] = mm.v[5 + 1] * v
	mat33.v[6 + 1] = mm.v[6 + 1] * v
	mat33.v[7 + 1] = mm.v[7 + 1] * v
	mat33.v[8 + 1] = mm.v[8 + 1] * v
	do return mat33 end
end

function jk.math.Matrix33:multiplyMatrix(a, b)
	local matrix33 = _g.jk.math.Matrix33._construct0(_g.jk.math.Matrix33._create())
	matrix33.v[0 + 1] = a.v[0 + 1] * b.v[0 + 1] + a.v[1 + 1] * b.v[3 + 1] + a.v[2 + 1] * b.v[6 + 1]
	matrix33.v[1 + 1] = a.v[0 + 1] * b.v[1 + 1] + a.v[1 + 1] * b.v[4 + 1] + a.v[2 + 1] * b.v[7 + 1]
	matrix33.v[2 + 1] = a.v[0 + 1] * b.v[2 + 1] + a.v[1 + 1] * b.v[5 + 1] + a.v[2 + 1] * b.v[8 + 1]
	matrix33.v[3 + 1] = a.v[3 + 1] * b.v[0 + 1] + a.v[4 + 1] * b.v[3 + 1] + a.v[5 + 1] * b.v[6 + 1]
	matrix33.v[4 + 1] = a.v[3 + 1] * b.v[1 + 1] + a.v[4 + 1] * b.v[4 + 1] + a.v[5 + 1] * b.v[7 + 1]
	matrix33.v[5 + 1] = a.v[3 + 1] * b.v[2 + 1] + a.v[4 + 1] * b.v[5 + 1] + a.v[5 + 1] * b.v[8 + 1]
	matrix33.v[6 + 1] = a.v[6 + 1] * b.v[0 + 1] + a.v[7 + 1] * b.v[3 + 1] + a.v[8 + 1] * b.v[6 + 1]
	matrix33.v[7 + 1] = a.v[6 + 1] * b.v[1 + 1] + a.v[7 + 1] * b.v[4 + 1] + a.v[8 + 1] * b.v[7 + 1]
	matrix33.v[8 + 1] = a.v[6 + 1] * b.v[2 + 1] + a.v[7 + 1] * b.v[5 + 1] + a.v[8 + 1] * b.v[8 + 1]
	do return matrix33 end
end

function jk.math.Matrix33:multiplyVector(a, b)
	local x = a.v[0 + 1] * b.x + a.v[1 + 1] * b.y + a.v[2 + 1] * 1.0
	local y = a.v[3 + 1] * b.x + a.v[4 + 1] * b.y + a.v[5 + 1] * 1.0
	do return _g.jk.math.Vector2:create(x, y) end
end

jk.math.Math = {}
jk.math.Math.__index = jk.math.Math
_vm:set_metatable(jk.math.Math, {})

jk.math.Math.M_PI = 3.14159265358979
jk.math.Math.M_PI_2 = 1.5707963267949
jk.math.Math.M_PI_4 = 0.78539816339745
jk.math.Math.M_1_PI = 0.31830988618379
jk.math.Math.M_2_PI = 0.63661977236758
jk.math.Math.M_2_SQRTPI = 1.12837916709551
jk.math.Math.M_SQRT2 = 1.4142135623731
jk.math.Math.M_SQRT1_2 = 0.70710678118655
jk.math.Math.HALF_AWAY_FROM_ZERO = 0
jk.math.Math.HALF_TOWARD_ZERO = 1
jk.math.Math.HALF_NEAREST_EVEN = 2
jk.math.Math.HALF_POSITIVE = 3
jk.math.Math.HALF_NEGATIVE = 4

function jk.math.Math._create()
	local v = _vm:set_metatable({}, jk.math.Math)
	return v
end

function jk.math.Math:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.math.Math'
	self['_isType.jk.math.Math'] = true
end

function jk.math.Math:_construct0()
	jk.math.Math._init(self)
	return self
end

function jk.math.Math:toRadians(d)
	do return _g.jk.math.Math.M_PI / 180 * d end
end

function jk.math.Math:toDegrees(r)
	do return _g.jk.math.Math.M_PI * r / 180 end
end

function jk.math.Math:abs(d)
	_io:write_to_stdout("[jk.math.Math.abs] (Math.sling:153:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:absFloat(f)
	_io:write_to_stdout("[jk.math.Math.absFloat] (Math.sling:183:3): Not implemented" .. "\n")
	do return 0.0 end
end

function jk.math.Math:absInt32(i)
	_io:write_to_stdout("[jk.math.Math.absInt32] (Math.sling:213:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:absInt64(l)
	_io:write_to_stdout("[jk.math.Math.absInt64] (Math.sling:243:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:acos(d)
	_io:write_to_stdout("[jk.math.Math.acos] (Math.sling:273:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:asin(d)
	_io:write_to_stdout("[jk.math.Math.asin] (Math.sling:303:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:atan(d)
	_io:write_to_stdout("[jk.math.Math.atan] (Math.sling:333:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:atan2(y, x)
	_io:write_to_stdout("[jk.math.Math.atan2] (Math.sling:363:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:ceil(d)
	_io:write_to_stdout("[jk.math.Math.ceil] (Math.sling:393:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:cos(d)
	_io:write_to_stdout("[jk.math.Math.cos] (Math.sling:423:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:cosh(d)
	_io:write_to_stdout("[jk.math.Math.cosh] (Math.sling:453:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:exp(d)
	_io:write_to_stdout("[jk.math.Math.exp] (Math.sling:483:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:floor(d)
	_io:write_to_stdout("[jk.math.Math.floor] (Math.sling:513:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:remainder(x, y)
	_io:write_to_stdout("[jk.math.Math.remainder] (Math.sling:542:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:log(d)
	_io:write_to_stdout("[jk.math.Math.log] (Math.sling:572:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:log10(d)
	_io:write_to_stdout("[jk.math.Math.log10] (Math.sling:602:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:max(d1, d2)
	_io:write_to_stdout("[jk.math.Math.max] (Math.sling:638:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:maxFloat(f1, f2)
	_io:write_to_stdout("[jk.math.Math.maxFloat] (Math.sling:674:3): Not implemented" .. "\n")
	do return 0.0 end
end

function jk.math.Math:maxInt32(i1, i2)
	_io:write_to_stdout("[jk.math.Math.maxInt32] (Math.sling:710:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:maxInt64(l1, l2)
	_io:write_to_stdout("[jk.math.Math.maxInt64] (Math.sling:746:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:min(d1, d2)
	_io:write_to_stdout("[jk.math.Math.min] (Math.sling:782:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:minFloat(f1, f2)
	_io:write_to_stdout("[jk.math.Math.minFloat] (Math.sling:818:3): Not implemented" .. "\n")
	do return 0.0 end
end

function jk.math.Math:minInt32(i1, i2)
	_io:write_to_stdout("[jk.math.Math.minInt32] (Math.sling:854:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:minInt64(l1, l2)
	_io:write_to_stdout("[jk.math.Math.minInt64] (Math.sling:890:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:pow(x, y)
	_io:write_to_stdout("[jk.math.Math.pow] (Math.sling:920:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:round(n)
	_io:write_to_stdout("[jk.math.Math.round] (Math.sling:955:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:roundWithMode(d, mode)
	local fd = _g.jk.math.Math:floor(d)
	local dp = d - fd
	if dp < 0.5 then
		do return fd end
	end
	if dp > 0.5 then
		do return _g.jk.math.Math:ceil(d) end
	end
	if mode == _g.jk.math.Math.HALF_AWAY_FROM_ZERO then
		if d < 0 then
			do return fd end
		end
		do return _g.jk.math.Math:ceil(d) end
	end
	if mode == _g.jk.math.Math.HALF_TOWARD_ZERO then
		if d < 0 then
			do return _g.jk.math.Math:ceil(d) end
		end
		do return fd end
	end
	if mode == _g.jk.math.Math.HALF_NEAREST_EVEN then
		if _util:convert_to_integer(_util:convert_to_integer(fd) % 2) == 0 then
			do return fd end
		end
		do return _g.jk.math.Math:ceil(d) end
	end
	if mode == _g.jk.math.Math.HALF_POSITIVE then
		do return _g.jk.math.Math:ceil(d) end
	end
	if mode == _g.jk.math.Math.HALF_NEGATIVE then
		do return fd end
	end
	do return d end
end

function jk.math.Math:sin(d)
	_io:write_to_stdout("[jk.math.Math.sin] (Math.sling:1055:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:sinh(d)
	_io:write_to_stdout("[jk.math.Math.sinh] (Math.sling:1085:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:sqrt(d)
	_io:write_to_stdout("[jk.math.Math.sqrt] (Math.sling:1115:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:tan(d)
	_io:write_to_stdout("[jk.math.Math.tan] (Math.sling:1145:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:tanh(d)
	_io:write_to_stdout("[jk.math.Math.tanh] (Math.sling:1175:3): Not implemented" .. "\n")
	do return 0 end
end

function jk.math.Math:computeQuinticInEasing(t, b, c, d)
	local x = t / d
	do return c * x * x * x * x * x + b end
end

function jk.math.Math:computeQuinticOutEasing(t, b, c, d)
	local x = t / d - 1
	do return c * (x * x * x * x * x + 1) + b end
end

function jk.math.Math:computeQuinticInOutEasing(t, b, c, d)
	local x = t / d / 2
	if x < 1.0 then
		do return c / 2 * x * x * x * x * x + b end
	end
	x = x - 2
	do return c / 2 * (x * x * x * x * x + 2) + b end
end
jk = jk or {}

jk.ui = jk.ui or {}

jk.ui.ApplicationData = {}
jk.ui.ApplicationData.__index = jk.ui.ApplicationData
_vm:set_metatable(jk.ui.ApplicationData, {})

function jk.ui.ApplicationData._create()
	local v = _vm:set_metatable({}, jk.ui.ApplicationData)
	return v
end

function jk.ui.ApplicationData:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.ui.ApplicationData'
	self['_isType.jk.ui.ApplicationData'] = true
end

function jk.ui.ApplicationData:_construct0()
	jk.ui.ApplicationData._init(self)
	return self
end

function jk.ui.ApplicationData:getApplicationData(ctx)
	if not (ctx ~= nil) then
		do return nil end
	end
	_io:write_to_stdout("[jk.ui.ApplicationData.getApplicationData] (ApplicationData.sling:63:3): Not implemented." .. "\n")
	do return nil end
end

function jk.ui.ApplicationData:retrieveFile(ctx, filename)
	_io:write_to_stdout("[jk.ui.ApplicationData.retrieveFile] (ApplicationData.sling:87:3): Not implemented." .. "\n")
	do return nil end
end

jk.ui.WebBrowserContext = {}
jk.ui.WebBrowserContext.__index = jk.ui.WebBrowserContext
_vm:set_metatable(jk.ui.WebBrowserContext, {})

function jk.ui.WebBrowserContext._create()
	local v = _vm:set_metatable({}, jk.ui.WebBrowserContext)
	return v
end

function jk.ui.WebBrowserContext:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.ui.WebBrowserContext'
	self['_isType.jk.ui.WebBrowserContext'] = true
end

function jk.ui.WebBrowserContext:_construct0()
	jk.ui.WebBrowserContext._init(self)
	return self
end

function jk.ui.WebBrowserContext:getPageURL()
	do return nil end
end

function jk.ui.WebBrowserContext:getPageHash()
	do return nil end
end

function jk.ui.WebBrowserContext:getQueryString()
	do return nil end
end

function jk.ui.WebBrowserContext:getQueryStringValue(key)
	if not _g.jk.lang.String:isNotEmpty(key) then
		do return nil end
	end
	do
		local qss = _g.jk.ui.WebBrowserContext:getQueryString()
		if not _g.jk.lang.String:isNotEmpty(qss) then
			do return nil end
		end
		do
			local qs = _g.jk.url.QueryString:parse(qss)
			if not (qs ~= nil) then
				do return nil end
			end
			do return _g.jk.lang.Map:get(qs, key) end
		end
	end
end

jk.ui.PointerEvent = {}
jk.ui.PointerEvent.__index = jk.ui.PointerEvent
_vm:set_metatable(jk.ui.PointerEvent, {})

jk.ui.PointerEvent.DOWN = 0
jk.ui.PointerEvent.MOVE = 1
jk.ui.PointerEvent.CANCEL = 2
jk.ui.PointerEvent.UP = 3

function jk.ui.PointerEvent._create()
	local v = _vm:set_metatable({}, jk.ui.PointerEvent)
	return v
end

function jk.ui.PointerEvent:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.ui.PointerEvent'
	self['_isType.jk.ui.PointerEvent'] = true
	self.pointerId = 0
	self.action = 0
	self.x = 0.0
	self.y = 0.0
	self.isConsumed = false
end

function jk.ui.PointerEvent:_construct0()
	jk.ui.PointerEvent._init(self)
	return self
end

function jk.ui.PointerEvent:consume()
	self.isConsumed = true
end

function jk.ui.PointerEvent:getPointerId()
	do return self.pointerId end
end

function jk.ui.PointerEvent:setPointerId(value)
	self.pointerId = value
	do return self end
end

function jk.ui.PointerEvent:getAction()
	do return self.action end
end

function jk.ui.PointerEvent:setAction(value)
	self.action = value
	do return self end
end

function jk.ui.PointerEvent:getX()
	do return self.x end
end

function jk.ui.PointerEvent:setX(value)
	self.x = value
	do return self end
end

function jk.ui.PointerEvent:getY()
	do return self.y end
end

function jk.ui.PointerEvent:setY(value)
	self.y = value
	do return self end
end

function jk.ui.PointerEvent:isInside(xc, yc, width, height)
	if self.x >= xc and self.x < xc + width and self.y >= yc and self.y < yc + height then
		do return true end
	end
	do return false end
end

jk.ui.ImageUtil = {}
jk.ui.ImageUtil.__index = jk.ui.ImageUtil
_vm:set_metatable(jk.ui.ImageUtil, {})

function jk.ui.ImageUtil._create()
	local v = _vm:set_metatable({}, jk.ui.ImageUtil)
	return v
end

function jk.ui.ImageUtil:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.ui.ImageUtil'
	self['_isType.jk.ui.ImageUtil'] = true
end

function jk.ui.ImageUtil:_construct0()
	jk.ui.ImageUtil._init(self)
	return self
end

function jk.ui.ImageUtil:createCircularImageSync(m)
	if not (m ~= nil) then
		do return nil end
	end
	do
		local image = m
		local minSize = _util:convert_to_integer(_g.jk.math.Math:min(image:getPixelWidth(), image:getPixelHeight()))
		image = image:cropSync(0, 0, minSize, minSize)
		_io:write_to_stdout("[jk.ui.ImageUtil.createCircularImageSync] (ImageUtil.sling:113:3): Not implemented" .. "\n")
		do return nil end
	end
end

function jk.ui.ImageUtil:createCircularImage(oimage, callback)
	if not (callback ~= nil) then
		do return end
	end
	if not (oimage ~= nil) then
		do callback(nil) end
		do return end
	end
	do callback(_g.jk.ui.ImageUtil:createCircularImageSync(oimage)) end
end

jk.ui.ScreenWithContext = {}

jk.ui.Screen = {}
jk.ui.Screen.__index = jk.ui.Screen
_vm:set_metatable(jk.ui.Screen, {})

function jk.ui.Screen._create()
	local v = _vm:set_metatable({}, jk.ui.Screen)
	return v
end

function jk.ui.Screen:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.ui.Screen'
	self['_isType.jk.ui.Screen'] = true
end

function jk.ui.Screen:_construct0()
	jk.ui.Screen._init(self)
	return self
end

jk.ui.IOSDeviceInfo = {}
jk.ui.IOSDeviceInfo.__index = jk.ui.IOSDeviceInfo
_vm:set_metatable(jk.ui.IOSDeviceInfo, {})

function jk.ui.IOSDeviceInfo._create()
	local v = _vm:set_metatable({}, jk.ui.IOSDeviceInfo)
	return v
end

function jk.ui.IOSDeviceInfo:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.ui.IOSDeviceInfo'
	self['_isType.jk.ui.IOSDeviceInfo'] = true
	self.id = nil
	self.name = nil
	self.dpi = 0
	self.scale = 0.0
	self.screenWidth = 0
	self.screenHeight = 0
end

function jk.ui.IOSDeviceInfo:_construct0()
	jk.ui.IOSDeviceInfo._init(self)
	return self
end

function jk.ui.IOSDeviceInfo:forDetails(id, name, dpi)
	local v = _g.jk.ui.IOSDeviceInfo._construct0(_g.jk.ui.IOSDeviceInfo._create())
	do v:setId(id) end
	do v:setName(name) end
	do v:setDpi(dpi) end
	do return v end
end

function jk.ui.IOSDeviceInfo:toString()
	do return _g.jk.lang.String:safeString(self.name) .. " (" .. _g.jk.lang.String:safeString(self.id) .. ") " .. _g.jk.lang.String:safeString(_g.jk.lang.String:forInteger(self.screenWidth)) .. "x" .. _g.jk.lang.String:safeString(_g.jk.lang.String:forInteger(self.screenHeight)) .. " (" .. _g.jk.lang.String:safeString(_g.jk.lang.String:forDouble(self.scale)) .. "x) @ " .. _g.jk.lang.String:safeString(_g.jk.lang.String:forInteger(self.dpi)) .. "DPI" end
end

function jk.ui.IOSDeviceInfo:getId()
	do return self.id end
end

function jk.ui.IOSDeviceInfo:setId(v)
	self.id = v
	do return self end
end

function jk.ui.IOSDeviceInfo:getName()
	do return self.name end
end

function jk.ui.IOSDeviceInfo:setName(v)
	self.name = v
	do return self end
end

function jk.ui.IOSDeviceInfo:getDpi()
	do return self.dpi end
end

function jk.ui.IOSDeviceInfo:setDpi(v)
	self.dpi = v
	do return self end
end

function jk.ui.IOSDeviceInfo:getScale()
	do return self.scale end
end

function jk.ui.IOSDeviceInfo:setScale(v)
	self.scale = v
	do return self end
end

function jk.ui.IOSDeviceInfo:getScreenWidth()
	do return self.screenWidth end
end

function jk.ui.IOSDeviceInfo:setScreenWidth(v)
	self.screenWidth = v
	do return self end
end

function jk.ui.IOSDeviceInfo:getScreenHeight()
	do return self.screenHeight end
end

function jk.ui.IOSDeviceInfo:setScreenHeight(v)
	self.screenHeight = v
	do return self end
end

jk.ui.RouterListener = {}

jk.ui.KeyEvent = {}
jk.ui.KeyEvent.__index = jk.ui.KeyEvent
_vm:set_metatable(jk.ui.KeyEvent, {})

jk.ui.KeyEvent.ACTION_NONE = 0
jk.ui.KeyEvent.ACTION_DOWN = 1
jk.ui.KeyEvent.ACTION_UP = 2
jk.ui.KeyEvent.KEY_NONE = 0
jk.ui.KeyEvent.KEY_SPACE = 1
jk.ui.KeyEvent.KEY_ENTER = 2
jk.ui.KeyEvent.KEY_TAB = 3
jk.ui.KeyEvent.KEY_ESCAPE = 4
jk.ui.KeyEvent.KEY_BACKSPACE = 5
jk.ui.KeyEvent.KEY_SHIFT = 6
jk.ui.KeyEvent.KEY_CONTROL = 7
jk.ui.KeyEvent.KEY_ALT = 8
jk.ui.KeyEvent.KEY_CAPSLOCK = 9
jk.ui.KeyEvent.KEY_NUMLOCK = 10
jk.ui.KeyEvent.KEY_LEFT = 11
jk.ui.KeyEvent.KEY_UP = 12
jk.ui.KeyEvent.KEY_RIGHT = 13
jk.ui.KeyEvent.KEY_DOWN = 14
jk.ui.KeyEvent.KEY_INSERT = 15
jk.ui.KeyEvent.KEY_DELETE = 16
jk.ui.KeyEvent.KEY_HOME = 17
jk.ui.KeyEvent.KEY_END = 18
jk.ui.KeyEvent.KEY_PAGEUP = 19
jk.ui.KeyEvent.KEY_PAGEDOWN = 20
jk.ui.KeyEvent.KEY_F1 = 21
jk.ui.KeyEvent.KEY_F2 = 22
jk.ui.KeyEvent.KEY_F3 = 23
jk.ui.KeyEvent.KEY_F4 = 24
jk.ui.KeyEvent.KEY_F5 = 25
jk.ui.KeyEvent.KEY_F6 = 26
jk.ui.KeyEvent.KEY_F7 = 27
jk.ui.KeyEvent.KEY_F8 = 28
jk.ui.KeyEvent.KEY_F9 = 29
jk.ui.KeyEvent.KEY_F10 = 30
jk.ui.KeyEvent.KEY_F11 = 31
jk.ui.KeyEvent.KEY_F12 = 32
jk.ui.KeyEvent.KEY_SUPER = 33
jk.ui.KeyEvent.KEY_BACK = 34

function jk.ui.KeyEvent._create()
	local v = _vm:set_metatable({}, jk.ui.KeyEvent)
	return v
end

function jk.ui.KeyEvent:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.ui.KeyEvent'
	self['_isType.jk.ui.KeyEvent'] = true
	self.action = 0
	self.keyCode = 0
	self.stringValue = nil
	self.shift = false
	self.control = false
	self.command = false
	self.alt = false
	self.isConsumed = false
end

function jk.ui.KeyEvent:_construct0()
	jk.ui.KeyEvent._init(self)
	return self
end

function jk.ui.KeyEvent:consume()
	self.isConsumed = true
end

function jk.ui.KeyEvent:isKeyPress(key)
	if self.action == _g.jk.ui.KeyEvent.ACTION_DOWN and self.keyCode == key then
		do return true end
	end
	do return false end
end

function jk.ui.KeyEvent:isKey(key)
	if self.keyCode == key then
		do return true end
	end
	do return false end
end

function jk.ui.KeyEvent:isString(value)
	if value == self.stringValue then
		do return true end
	end
	do return false end
end

function jk.ui.KeyEvent:isCharacter(value)
	if not (self.stringValue == nil) and _g.jk.lang.String:getChar(self.stringValue, 0) == value then
		do return true end
	end
	do return false end
end

function jk.ui.KeyEvent:clear()
	self.action = 0
	self.keyCode = 0
	self.stringValue = nil
	self.isConsumed = false
end

function jk.ui.KeyEvent:getAction()
	do return self.action end
end

function jk.ui.KeyEvent:setAction(v)
	self.action = v
	do return self end
end

function jk.ui.KeyEvent:getKeyCode()
	do return self.keyCode end
end

function jk.ui.KeyEvent:setKeyCode(v)
	self.keyCode = v
	do return self end
end

function jk.ui.KeyEvent:getStringValue()
	do return self.stringValue end
end

function jk.ui.KeyEvent:setStringValue(v)
	self.stringValue = v
	do return self end
end

function jk.ui.KeyEvent:getShift()
	do return self.shift end
end

function jk.ui.KeyEvent:setShift(v)
	self.shift = v
	do return self end
end

function jk.ui.KeyEvent:getControl()
	do return self.control end
end

function jk.ui.KeyEvent:setControl(v)
	self.control = v
	do return self end
end

function jk.ui.KeyEvent:getCommand()
	do return self.command end
end

function jk.ui.KeyEvent:setCommand(v)
	self.command = v
	do return self end
end

function jk.ui.KeyEvent:getAlt()
	do return self.alt end
end

function jk.ui.KeyEvent:setAlt(v)
	self.alt = v
	do return self end
end

jk.ui.Router = {}
jk.ui.Router.__index = jk.ui.Router
_vm:set_metatable(jk.ui.Router, {})

jk.ui.Router.listener = nil

function jk.ui.Router._create()
	local v = _vm:set_metatable({}, jk.ui.Router)
	return v
end

function jk.ui.Router:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.ui.Router'
	self['_isType.jk.ui.Router'] = true
end

function jk.ui.Router:_construct0()
	jk.ui.Router._init(self)
	return self
end

function jk.ui.Router:initialize(l)
	if not (l ~= nil) then
		do return end
	end
	_g.jk.ui.Router.listener = l
end

function jk.ui.Router:goToDefault()
	if _g.jk.ui.Router.listener ~= nil then
		do _g.jk.ui.Router.listener:onRouteChanged("/") end
	end
end

function jk.ui.Router:go(route)
	if _g.jk.ui.Router.listener ~= nil then
		do _g.jk.ui.Router.listener:onRouteChanged(route) end
	end
end

jk.ui.PointerListener = {}

jk.ui.KeyListener = {}

jk.ui.GuiApplicationContext = {}
jk.ui.GuiApplicationContext.__index = jk.ui.GuiApplicationContext
_vm:set_metatable(jk.ui.GuiApplicationContext, {})

function jk.ui.GuiApplicationContext._create()
	local v = _vm:set_metatable({}, jk.ui.GuiApplicationContext)
	return v
end

function jk.ui.GuiApplicationContext:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.ui.GuiApplicationContext'
	self['_isType.jk.ui.GuiApplicationContext'] = true
	self['_isType.jk.app.ApplicationContext'] = true
	self['_isType.jk.lang.EventLoop'] = true
	self.styles = nil
	self.errorCounter = 0
	self.warningCounter = 0
	self.infoCounter = 0
	self.debugCounter = 0
end

function jk.ui.GuiApplicationContext:_construct0()
	jk.ui.GuiApplicationContext._init(self)
	return self
end

jk.ui.GuiApplicationContext.TimerObject = {}

function jk.ui.GuiApplicationContext:setStyle(id, style)
	if not (self.styles ~= nil) then
		self.styles = {}
	end
	self.styles[id] = style
end

function jk.ui.GuiApplicationContext:getStyle(id)
	if not (self.styles ~= nil) then
		do return nil end
	end
	if not (id ~= nil) then
		do return nil end
	end
	do return self.styles[id] end
end

function jk.ui.GuiApplicationContext:getStyleObject(id, style)
	local ss = _g.jk.lang.Map:getValue(self.styles, id)
	if not (ss ~= nil) then
		do return nil end
	end
	do return _g.jk.lang.Map:getValue(ss, style) end
end

function jk.ui.GuiApplicationContext:getStyleString(id, style, defval)
	local v = _g.jk.lang.String:asString(self:getStyleObject(id, style))
	if _g.jk.lang.String:isEmpty(v) then
		v = defval
	end
	do return v end
end

function jk.ui.GuiApplicationContext:getStyleColor(id, style, defval)
	local v = _g.jk.gfx.Color:asColor(self:getStyleObject(id, style))
	if not (v ~= nil) and defval ~= nil then
		v = _g.jk.gfx.Color:instance(defval)
	end
	do return v end
end

function jk.ui.GuiApplicationContext:getStylePixels(id, style, defval)
	local ss = self:getStyleString(id, style, nil)
	if _g.jk.lang.String:isEmpty(ss) then
		ss = defval
	end
	do return self:getHeightValue(ss) end
end

function jk.ui.GuiApplicationContext:getApplicationDataDirectory()
end

function jk.ui.GuiApplicationContext:getResourceImage(id)
end

function jk.ui.GuiApplicationContext:getImageForBufferSync(buffer, mimeType)
end

function jk.ui.GuiApplicationContext:getImageForBuffer(buffer, mimeType, callback)
end

function jk.ui.GuiApplicationContext:showMessageDialog(title, message, callback)
end

function jk.ui.GuiApplicationContext:showConfirmDialog(title, message, okcallback, cancelcallback)
end

function jk.ui.GuiApplicationContext:showErrorDialog(message, callback)
end

function jk.ui.GuiApplicationContext:getScreenTopMargin()
end

function jk.ui.GuiApplicationContext:getScreenWidth()
end

function jk.ui.GuiApplicationContext:getScreenHeight()
end

function jk.ui.GuiApplicationContext:getScreenDensity()
end

function jk.ui.GuiApplicationContext:getHeightValue(spec)
end

function jk.ui.GuiApplicationContext:getWidthValue(spec)
end

function jk.ui.GuiApplicationContext:startTimer(timeout, callback)
end

function jk.ui.GuiApplicationContext:enableKeepAwakeMode()
end

function jk.ui.GuiApplicationContext:disableKeepAwakeMode()
end

function jk.ui.GuiApplicationContext:px(spec)
	do return self:getHeightValue(spec) end
end

function jk.ui.GuiApplicationContext:logError(message)
	_io:write_to_stdout("[ERROR] " .. _g.jk.lang.String:safeString(message) .. "\n")
	do self.errorCounter = self.errorCounter + 1 end
end

function jk.ui.GuiApplicationContext:logWarning(message)
	_io:write_to_stdout("[WARNING] " .. _g.jk.lang.String:safeString(message) .. "\n")
	do self.warningCounter = self.warningCounter + 1 end
end

function jk.ui.GuiApplicationContext:logInfo(message)
	_io:write_to_stdout("[INFO] " .. _g.jk.lang.String:safeString(message) .. "\n")
	do self.infoCounter = self.infoCounter + 1 end
end

function jk.ui.GuiApplicationContext:logDebug(message)
	_io:write_to_stdout("[DEBUG] " .. _g.jk.lang.String:safeString(message) .. "\n")
	do self.debugCounter = self.debugCounter + 1 end
end

function jk.ui.GuiApplicationContext:logStatus(message)
	_io:write_to_stdout("[STATUS] " .. _g.jk.lang.String:safeString(message) .. "\n")
end

function jk.ui.GuiApplicationContext:isInDebugMode()
	do return false end
end

function jk.ui.GuiApplicationContext:getErrorCount()
	do return self.errorCounter end
end

function jk.ui.GuiApplicationContext:getWarningCount()
	do return self.warningCounter end
end

function jk.ui.GuiApplicationContext:getInfoCount()
	do return self.infoCounter end
end

function jk.ui.GuiApplicationContext:getDebugCount()
	do return self.debugCounter end
end

function jk.ui.GuiApplicationContext:resetCounters()
	self.errorCounter = 0
	self.warningCounter = 0
	self.infoCounter = 0
	self.debugCounter = 0
end

function jk.ui.GuiApplicationContext:runScheduled(timeout, runnable)
	if not (timeout >= 0) then
		do return end
	end
	do
		local rr = runnable
		if not (rr ~= nil) then
			do return end
		end
		do self:startTimer(timeout, function()
			do rr:run() end
		end) end
	end
end

function jk.ui.GuiApplicationContext:runInBackground(runnable)
	if not (runnable ~= nil) then
		do return end
	end
	do _g.jk.thread.Thread:start(runnable) end
end
jk = jk or {}

jk.gfx = jk.gfx or {}

jk.gfx.util = jk.gfx.util or {}

jk.gfx.util.ImageSheet = {}
jk.gfx.util.ImageSheet.__index = jk.gfx.util.ImageSheet
_vm:set_metatable(jk.gfx.util.ImageSheet, {})

function jk.gfx.util.ImageSheet._create()
	local v = _vm:set_metatable({}, jk.gfx.util.ImageSheet)
	return v
end

function jk.gfx.util.ImageSheet:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.gfx.util.ImageSheet'
	self['_isType.jk.gfx.util.ImageSheet'] = true
	self.sheet = nil
	self.cols = -1
	self.rows = -1
	self.sourceSkipX = 0
	self.sourceSkipY = 0
	self.sourceImageWidth = -1
	self.sourceImageHeight = -1
	self.maxImages = -1
end

function jk.gfx.util.ImageSheet:_construct0()
	jk.gfx.util.ImageSheet._init(self)
	return self
end

function jk.gfx.util.ImageSheet:toImages(resizeToWidth, resizeToHeight)
	if not (self.sheet ~= nil) then
		do return nil end
	end
	do
		local cols = self.cols
		local rows = self.rows
		local fwidth = self.sourceImageWidth
		if fwidth < 1 then
			fwidth = _util:convert_to_integer((self.sheet:getPixelWidth() - self.sourceSkipX) / cols)
		else
			cols = _util:convert_to_integer((self.sheet:getPixelWidth() - self.sourceSkipX) / fwidth)
		end
		do
			local fheight = self.sourceImageHeight
			if fheight < 1 then
				fheight = _util:convert_to_integer((self.sheet:getPixelHeight() - self.sourceSkipY) / rows)
			else
				rows = _util:convert_to_integer((self.sheet:getPixelHeight() - self.sourceSkipY) / fheight)
			end
			do
				local frames = {}
				local x = 0
				local y = 0
				do
					y = 0
					while y < rows do
						do
							x = 0
							while x < cols do
								local img = self.sheet:cropSync(x * fwidth, y * fheight, fwidth, fheight)
								if resizeToWidth > 0 then
									img = img:scaleToSizeSync(resizeToWidth, resizeToHeight)
								end
								do _g.jk.lang.Vector:append(frames, img) end
								if self.maxImages > 0 and _g.jk.lang.Vector:getSize(frames) >= self.maxImages then
									do return frames end
								end
								do x = x + 1 end
							end
						end
						do y = y + 1 end
					end
				end
				do return frames end
			end
		end
	end
end

function jk.gfx.util.ImageSheet:getSheet()
	do return self.sheet end
end

function jk.gfx.util.ImageSheet:setSheet(v)
	self.sheet = v
	do return self end
end

function jk.gfx.util.ImageSheet:getCols()
	do return self.cols end
end

function jk.gfx.util.ImageSheet:setCols(v)
	self.cols = v
	do return self end
end

function jk.gfx.util.ImageSheet:getRows()
	do return self.rows end
end

function jk.gfx.util.ImageSheet:setRows(v)
	self.rows = v
	do return self end
end

function jk.gfx.util.ImageSheet:getSourceSkipX()
	do return self.sourceSkipX end
end

function jk.gfx.util.ImageSheet:setSourceSkipX(v)
	self.sourceSkipX = v
	do return self end
end

function jk.gfx.util.ImageSheet:getSourceSkipY()
	do return self.sourceSkipY end
end

function jk.gfx.util.ImageSheet:setSourceSkipY(v)
	self.sourceSkipY = v
	do return self end
end

function jk.gfx.util.ImageSheet:getSourceImageWidth()
	do return self.sourceImageWidth end
end

function jk.gfx.util.ImageSheet:setSourceImageWidth(v)
	self.sourceImageWidth = v
	do return self end
end

function jk.gfx.util.ImageSheet:getSourceImageHeight()
	do return self.sourceImageHeight end
end

function jk.gfx.util.ImageSheet:setSourceImageHeight(v)
	self.sourceImageHeight = v
	do return self end
end

function jk.gfx.util.ImageSheet:getMaxImages()
	do return self.maxImages end
end

function jk.gfx.util.ImageSheet:setMaxImages(v)
	self.maxImages = v
	do return self end
end
jk = jk or {}

jk.render = jk.render or {}

jk.render.RenderingContext = {}
jk.render.RenderingContext.__index = jk.render.RenderingContext
_vm:set_metatable(jk.render.RenderingContext, {})

jk.render.RenderingContext.REPEAT_BOTH = 0
jk.render.RenderingContext.REPEAT_X = 1
jk.render.RenderingContext.REPEAT_Y = 2
jk.render.RenderingContext.REPEAT_NONE = 3
jk.render.RenderingContext.LINE_CAP_BUTT = 0
jk.render.RenderingContext.LINE_CAP_ROUND = 1
jk.render.RenderingContext.LINE_CAP_SQUARE = 2
jk.render.RenderingContext.LINE_JOIN_MITER = 0
jk.render.RenderingContext.LINE_JOIN_BEVEL = 1
jk.render.RenderingContext.LINE_JOIN_ROUND = 2
jk.render.RenderingContext.ALIGN_START = 0
jk.render.RenderingContext.ALIGN_END = 1
jk.render.RenderingContext.ALIGN_CENTER = 2
jk.render.RenderingContext.ALIGN_LEFT = 3
jk.render.RenderingContext.ALIGN_RIGHT = 4
jk.render.RenderingContext.BASELINE_ALPHABETIC = 0
jk.render.RenderingContext.BASELINE_TOP = 1
jk.render.RenderingContext.BASELINE_HANGING = 2
jk.render.RenderingContext.BASELINE_MIDDLE = 3
jk.render.RenderingContext.BASELINE_IDEOGRAPHIC = 4
jk.render.RenderingContext.BASELINE_BOTTOM = 5

function jk.render.RenderingContext._create()
	local v = _vm:set_metatable({}, jk.render.RenderingContext)
	return v
end

function jk.render.RenderingContext:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.render.RenderingContext'
	self['_isType.jk.render.RenderingContext'] = true
end

function jk.render.RenderingContext:_construct0()
	jk.render.RenderingContext._init(self)
	return self
end

function jk.render.RenderingContext:setFillStyle(style)
end

function jk.render.RenderingContext:setStrokeStyle(style)
end

function jk.render.RenderingContext:setShadowColor(color)
end

function jk.render.RenderingContext:setShadowBlur(blur)
end

function jk.render.RenderingContext:setShadowOffsetX(offset)
end

function jk.render.RenderingContext:setShadowOffsetY(offset)
end

function jk.render.RenderingContext:createLinearGradient(x0, y0, x1, y1)
end

function jk.render.RenderingContext:createPattern(image, _repeat)
end

function jk.render.RenderingContext:createRadialGradient(x0, y0, r0, x1, y1, r1)
end

function jk.render.RenderingContext:addColorStop(gradient, index, color)
end

function jk.render.RenderingContext:setLineCap(cap)
end

function jk.render.RenderingContext:setLineJoin(join)
end

function jk.render.RenderingContext:setLineWidth(width)
end

function jk.render.RenderingContext:setMiterLimit(limit)
end

function jk.render.RenderingContext:rect(x, y, width, height)
end

function jk.render.RenderingContext:fillRect(x, y, width, height)
end

function jk.render.RenderingContext:strokeRect(x, y, width, height)
end

function jk.render.RenderingContext:clearRect(x, y, width, height)
end

function jk.render.RenderingContext:fill()
end

function jk.render.RenderingContext:stroke()
end

function jk.render.RenderingContext:beginPath()
end

function jk.render.RenderingContext:moveTo(x, y)
end

function jk.render.RenderingContext:closePath()
end

function jk.render.RenderingContext:lineTo(x, y)
end

function jk.render.RenderingContext:clip()
end

function jk.render.RenderingContext:quadraticCurveTo(cpx, cpy, x, y)
end

function jk.render.RenderingContext:bezierCurveTo(cp1x, cp1y, cp2x, cp2y, x, y)
end

function jk.render.RenderingContext:arc(x, y, r, sAngle, eAngle, counterclockwise)
end

function jk.render.RenderingContext:arcTo(x1, y1, x2, y2, r)
end

function jk.render.RenderingContext:isPointInPath(x, y)
end

function jk.render.RenderingContext:scale(scalewidth, scaleheight)
end

function jk.render.RenderingContext:rotate(angle)
end

function jk.render.RenderingContext:translate(x, y)
end

function jk.render.RenderingContext:transform(a, b, c, d, e, f)
end

function jk.render.RenderingContext:setTransform(a, b, c, d, e, f)
end

function jk.render.RenderingContext:setFont(font)
end

function jk.render.RenderingContext:setTextAlign(align)
end

function jk.render.RenderingContext:setTextBaseline(baseline)
end

function jk.render.RenderingContext:fillText(text, x, y, maxWidth)
end

function jk.render.RenderingContext:strokeText(text, x, y, maxWidth)
end

function jk.render.RenderingContext:measureTextHeight(text)
end

function jk.render.RenderingContext:measureTextWidth(text)
end

function jk.render.RenderingContext:drawImage(img, x, y)
end

function jk.render.RenderingContext:drawAndScaleImage(img, x, y, width, height)
end

function jk.render.RenderingContext:drawAndProcessImage(img, sx, sy, swidth, sheight, x, y, width, height)
end

function jk.render.RenderingContext:setGlobalAlpha(alpha)
end

function jk.render.RenderingContext:save()
end

function jk.render.RenderingContext:restore()
end

jk.render.Renderer = {}
jk = jk or {}

jk.widget = jk.widget or {}

jk.widget.WidgetProvider = {}

jk.widget.IdAwareWidget = {}

jk.widget.ResizeAwareWidget = {}

jk.widget.Widget = {}
jk.widget.Widget.__index = jk.widget.Widget
_vm:set_metatable(jk.widget.Widget, {})

jk.widget.Widget.MOUSE_POINTER_DEFAULT = 0
jk.widget.Widget.MOUSE_POINTER_ARROW = 1
jk.widget.Widget.MOUSE_POINTER_CROSSHAIR = 2
jk.widget.Widget.MOUSE_POINTER_IBEAM = 3
jk.widget.Widget.MOUSE_POINTER_ICON = 4
jk.widget.Widget.MOUSE_POINTER_SIZE = 5
jk.widget.Widget.MOUSE_POINTER_NESW = 6
jk.widget.Widget.MOUSE_POINTER_NS = 7
jk.widget.Widget.MOUSE_POINTER_NWSE = 8
jk.widget.Widget.MOUSE_POINTER_WE = 9
jk.widget.Widget.MOUSE_POINTER_UPARROW = 10
jk.widget.Widget.MOUSE_POINTER_HOURGLASS = 11
jk.widget.Widget.MOUSE_POINTER_NODROP = 12
jk.widget.Widget.MOUSE_POINTER_ARROW_HOURGLASS = 13
jk.widget.Widget.MOUSE_POINTER_ARROW_QUESTION = 14
jk.widget.Widget.MOUSE_POINTER_SIZE_ALL = 15

function jk.widget.Widget._create()
	local v = _vm:set_metatable({}, jk.widget.Widget)
	return v
end

function jk.widget.Widget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.Widget'
	self['_isType.jk.widget.Widget'] = true
end

function jk.widget.Widget:_construct0()
	jk.widget.Widget._init(self)
	return self
end

function jk.widget.Widget:onWidgetAddedToParent(widget)
	if not (widget ~= nil) then
		do return end
	end
	if (_vm:to_table_with_key(widget, '_isType.jk.widget.ParentAwareWidget') ~= nil) then
		do widget:onWidgetAddedToParent() end
	end
end

function jk.widget.Widget:onWidgetRemovedFromParent(widget)
	if not (widget ~= nil) then
		do return end
	end
	if (_vm:to_table_with_key(widget, '_isType.jk.widget.ParentAwareWidget') ~= nil) then
		do widget:onWidgetRemovedFromParent() end
	end
end

function jk.widget.Widget:notifyOnStartScreen(widget, screen)
	local array = _g.jk.widget.Widget:getChildren(widget)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local child = array[n + 1]
				if child ~= nil then
					do _g.jk.widget.Widget:notifyOnStartScreen(child, screen) end
				end
				do n = n + 1 end
			end
		end
	end
	if (_vm:to_table_with_key(widget, '_isType.jk.widget.ScreenStartStopAwareWidget') ~= nil) then
		do widget:onStartScreen(screen) end
	end
end

function jk.widget.Widget:notifyOnStopScreen(widget, screen)
	local array = _g.jk.widget.Widget:getChildren(widget)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local child = array[n + 1]
				if child ~= nil then
					do _g.jk.widget.Widget:notifyOnStopScreen(child, screen) end
				end
				do n = n + 1 end
			end
		end
	end
	if (_vm:to_table_with_key(widget, '_isType.jk.widget.ScreenStartStopAwareWidget') ~= nil) then
		do widget:onStopScreen(screen) end
	end
end

function jk.widget.Widget:notifyOnAddedToScreen(widget, screen)
	local array = _g.jk.widget.Widget:getChildren(widget)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local child = array[n + 1]
				if child ~= nil then
					do _g.jk.widget.Widget:notifyOnAddedToScreen(child, screen) end
				end
				do n = n + 1 end
			end
		end
	end
	if (_vm:to_table_with_key(widget, '_isType.jk.widget.ScreenAwareWidget') ~= nil) then
		do widget:onWidgetAddedToScreen(screen) end
	end
end

function jk.widget.Widget:notifyOnRemovedFromScreen(widget, screen)
	if (_vm:to_table_with_key(widget, '_isType.jk.widget.ScreenAwareWidget') ~= nil) then
		do widget:onWidgetRemovedFromScreen(screen) end
	end
	do
		local array = _g.jk.widget.Widget:getChildren(widget)
		if array ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(array)
			do
				n = 0
				while n < m do
					local child = array[n + 1]
					if child ~= nil then
						do _g.jk.widget.Widget:notifyOnRemovedFromScreen(child, screen) end
					end
					do n = n + 1 end
				end
			end
		end
	end
end

function jk.widget.Widget:addChild(parent, child)
	if not (parent ~= nil) then
		do return end
	end
	if not (child ~= nil) then
		do return end
	end
	if (_vm:to_table_with_key(child, '_isType.jk.widget.ParentAwareWidget') ~= nil) then
		do child:onWidgetAddingToParent() end
	end
	_io:write_to_stdout("[jk.widget.Widget.addChild] (Widget.sling:252:3): Not implemented." .. "\n")
	do
		local pp = _vm:to_table_with_key(parent, '_isType.jk.widget.ContainerWidget')
		if pp ~= nil then
			do pp:onChildWidgetAdded(child) end
		end
		do _g.jk.widget.Widget:onWidgetAddedToParent(child) end
		do
			local screen = _g.jk.widget.ScreenForWidget:findScreenForWidget(child)
			if screen ~= nil then
				do _g.jk.widget.Widget:notifyOnAddedToScreen(child, screen) end
			end
		end
	end
end

function jk.widget.Widget:removeFromParent(child)
	if not (child ~= nil) then
		do return nil end
	end
	do
		local parentWidget = _g.jk.widget.Widget:getParent(child)
		if not (parentWidget ~= nil) then
			do return nil end
		end
		do
			local pp = _vm:to_table_with_key(parentWidget, '_isType.jk.widget.ContainerWidget')
			_io:write_to_stdout("[jk.widget.Widget.removeFromParent] (Widget.sling:289:3): Not implemented." .. "\n")
			if pp ~= nil then
				local v = {}
				do _g.jk.lang.Vector:append(v, child) end
				do pp:onChildWidgetsRemoved(v) end
			end
			do
				local screen = _g.jk.widget.ScreenForWidget:findScreenForWidget(parentWidget)
				if screen ~= nil then
					do _g.jk.widget.Widget:notifyOnRemovedFromScreen(child, screen) end
				end
				do _g.jk.widget.Widget:onWidgetRemovedFromParent(child) end
				do return nil end
			end
		end
	end
end

function jk.widget.Widget:hasParent(widget)
	if not (_g.jk.widget.Widget:getParent(widget) ~= nil) then
		do return false end
	end
	do return true end
end

function jk.widget.Widget:getParent(widget)
	if not (widget ~= nil) then
		do return nil end
	end
	_io:write_to_stdout("[jk.widget.Widget.getParent] (Widget.sling:369:3): Not implemented." .. "\n")
	do return nil end
end

function jk.widget.Widget:getChildren(widget)
	if not (widget ~= nil) then
		do return nil end
	end
	_io:write_to_stdout("[jk.widget.Widget.getChildren] (Widget.sling:440:3): Not implemented." .. "\n")
	do return nil end
end

function jk.widget.Widget:getX(widget)
	if not (widget ~= nil) then
		do return 0 end
	end
	do
		local v = 0
		_io:write_to_stdout("[jk.widget.Widget.getX] (Widget.sling:483:3): Not implemented." .. "\n")
		do return v end
	end
end

function jk.widget.Widget:getY(widget)
	if not (widget ~= nil) then
		do return 0 end
	end
	do
		local v = 0
		_io:write_to_stdout("[jk.widget.Widget.getY] (Widget.sling:526:3): Not implemented." .. "\n")
		do return v end
	end
end

function jk.widget.Widget:getAbsoluteX(widget)
	if not (widget ~= nil) then
		do return 0 end
	end
	do
		local v = 0
		_io:write_to_stdout("[jk.widget.Widget.getAbsoluteX] (Widget.sling:571:3): Not implemented" .. "\n")
		do return v end
	end
end

function jk.widget.Widget:getAbsoluteY(widget)
	if not (widget ~= nil) then
		do return 0 end
	end
	do
		local v = 0
		_io:write_to_stdout("[jk.widget.Widget.getAbsoluteY] (Widget.sling:616:3): Not implemented" .. "\n")
		do return v end
	end
end

function jk.widget.Widget:getWidth(widget)
	if not (widget ~= nil) then
		do return 0 end
	end
	do
		local v = 0
		_io:write_to_stdout("[jk.widget.Widget.getWidth] (Widget.sling:660:3): Not implemented." .. "\n")
		do return v end
	end
end

function jk.widget.Widget:getHeight(widget)
	if not (widget ~= nil) then
		do return 0 end
	end
	do
		local v = 0
		_io:write_to_stdout("[jk.widget.Widget.getHeight] (Widget.sling:704:3): Not implemented." .. "\n")
		do return v end
	end
end

function jk.widget.Widget:getGeometryString(widget)
	if not (widget ~= nil) then
		do return "null,null,null,null" end
	end
	do return _g.jk.lang.String:safeString(_g.jk.lang.String:forInteger(_g.jk.widget.Widget:getX(widget))) .. "," .. _g.jk.lang.String:safeString(_g.jk.lang.String:forInteger(_g.jk.widget.Widget:getY(widget))) .. "," .. _g.jk.lang.String:safeString(_g.jk.lang.String:forInteger(_g.jk.widget.Widget:getWidth(widget))) .. "," .. _g.jk.lang.String:safeString(_g.jk.lang.String:forInteger(_g.jk.widget.Widget:getHeight(widget))) end
end

function jk.widget.Widget:move(widget, x, y)
	_io:write_to_stdout("[jk.widget.Widget.move] (Widget.sling:757:3): Not implemented." .. "\n")
end

function jk.widget.Widget:isRootWidget(widget)
	local cw = _vm:to_table_with_key(widget, '_isType.jk.widget.ContainerWidget')
	if not (cw ~= nil) then
		do return false end
	end
	do
		local pp = _g.jk.widget.Widget:getParent(cw)
		if not (pp ~= nil) then
			do return true end
		end
		if (_vm:to_table_with_key(pp, '_isType.jk.widget.WidgetWithLayout') ~= nil) then
			do return false end
		end
		do return true end
	end
end

function jk.widget.Widget:findScreen(widget)
	_io:write_to_stdout("[jk.widget.Widget.findScreen] (Widget.sling:838:3): Not implemented" .. "\n")
	do return nil end
end

function jk.widget.Widget:findRootWidget(widget)
	local v = widget
	while true do
		if not (v ~= nil) then
			do break end
		end
		if _g.jk.widget.Widget:isRootWidget(v) then
			do return _vm:to_table_with_key(v, '_isType.jk.widget.ContainerWidget') end
		end
		v = _g.jk.widget.Widget:getParent(v)
	end
	do return nil end
end

function jk.widget.Widget:setLayoutSize(widget, widthValue, heightValue)
	if _g.jk.widget.Widget:isRootWidget(widget) then
		local ccw = _vm:to_table_with_key(widget, '_isType.jk.widget.ContainerWidget')
		if ccw ~= nil and ccw:getAllowResize() == false then
			do return false end
		end
	end
	do
		local width = widthValue
		if width < 0 then
			width = 0
		end
		do
			local height = heightValue
			if height < 0 then
				height = 0
			end
			if _g.jk.widget.Widget:getWidth(widget) == width and _g.jk.widget.Widget:getHeight(widget) == height then
				do return false end
			end
			_io:write_to_stdout("[jk.widget.Widget.setLayoutSize] (Widget.sling:920:3): Not implemented." .. "\n")
			if (_vm:to_table_with_key(widget, '_isType.jk.widget.ResizeAwareWidget') ~= nil) then
				do widget:onWidgetResized() end
			end
			do return true end
		end
	end
end

function jk.widget.Widget:resizeHeight(widget, height)
	if not _g.jk.widget.Widget:setLayoutSize(widget, _g.jk.widget.Widget:getWidth(widget), height) then
		do return false end
	end
	if (_vm:to_table_with_key(widget, '_isType.jk.widget.HeightAwareWidget') ~= nil) then
		do widget:onWidgetHeightChanged(height) end
	end
	do return true end
end

function jk.widget.Widget:layout(widget, widthConstraint, force)
	if not (widget ~= nil) then
		do return end
	end
	do
		local done = false
		if (_vm:to_table_with_key(widget, '_isType.jk.widget.WidgetWithLayout') ~= nil) then
			done = widget:layoutWidget(widthConstraint, force)
		end
		if not done then
			_io:write_to_stdout("[jk.widget.Widget.layout] (Widget.sling:1061:4): Not implemented." .. "\n")
		end
	end
end

function jk.widget.Widget:togglePointerEventHandling(widget, value)
	local cw = _vm:to_table_with_key(widget, '_isType.jk.widget.ContainerWidget')
	if not (cw ~= nil) then
		do return end
	end
	do cw:togglePointerEventHandling1(value) end
end

function jk.widget.Widget:setWidgetClickHandler(widget, handler)
	if handler ~= nil then
		do _g.jk.widget.Widget:togglePointerEventHandling(widget, true) end
	else
		do _g.jk.widget.Widget:togglePointerEventHandling(widget, false) end
	end
	_io:write_to_stdout("[jk.widget.Widget.setWidgetClickHandler] (Widget.sling:1362:3): Not implemented" .. "\n")
end

function jk.widget.Widget:setWidgetDoubleClickHandler(widget, handler)
	if handler ~= nil then
		do _g.jk.widget.Widget:togglePointerEventHandling(widget, true) end
	else
		do _g.jk.widget.Widget:togglePointerEventHandling(widget, false) end
	end
	_io:write_to_stdout("[jk.widget.Widget.setWidgetDoubleClickHandler] (Widget.sling:1396:3): Not implemented" .. "\n")
end

function jk.widget.Widget:setWidgetLongClickHandler(widget, handler)
	if handler ~= nil then
		do _g.jk.widget.Widget:togglePointerEventHandling(widget, true) end
	else
		do _g.jk.widget.Widget:togglePointerEventHandling(widget, false) end
	end
	_io:write_to_stdout("[jk.widget.Widget.setWidgetLongClickHandler] (Widget.sling:1473:3): Not implemented" .. "\n")
end

function jk.widget.Widget:setWidgetPointerHandlers(widget, onStartHandler, onTouchHandler, onEndHandler)
	if onStartHandler == nil and onTouchHandler == nil and onEndHandler == nil then
		do _g.jk.widget.Widget:togglePointerEventHandling(widget, false) end
	else
		do _g.jk.widget.Widget:togglePointerEventHandling(widget, true) end
	end
	_io:write_to_stdout("[jk.widget.Widget.setWidgetPointerHandlers] (Widget.sling:1610:3): Not implemented" .. "\n")
end

function jk.widget.Widget:removeChildrenOf(widget)
	if not (widget ~= nil) then
		do return end
	end
	do
		local children = _g.jk.widget.Widget:getChildren(widget)
		if children ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(children)
			do
				n = 0
				while n < m do
					local child = children[n + 1]
					if child ~= nil then
						do _g.jk.widget.Widget:removeFromParent(child) end
					end
					do n = n + 1 end
				end
			end
		end
	end
end

function jk.widget.Widget:onLayoutChanged(widget)
	if not (widget ~= nil) then
		do return end
	end
	do
		local wwl = _vm:to_table_with_key(widget, '_isType.jk.widget.WidgetWithLayout')
		if wwl ~= nil and wwl:hasWidgetLayoutChanged() then
			do return end
		end
		if _g.jk.widget.Widget:isRootWidget(widget) then
			do widget:scheduleLayout() end
		else
			local pp = _vm:to_table_with_key(_g.jk.widget.Widget:getParent(widget), '_isType.jk.widget.Widget')
			if pp ~= nil then
				do _g.jk.widget.Widget:onLayoutChanged(pp) end
			else
				local root = _g.jk.widget.Widget:findRootWidget(widget)
				if root ~= nil then
					do root:scheduleLayout() end
				end
			end
		end
		if wwl ~= nil then
			do wwl:setWidgetLayoutChanged() end
		end
	end
end

function jk.widget.Widget:setAlpha(widget, alpha)
	if not (widget ~= nil) then
		do return end
	end
	_io:write_to_stdout("[jk.widget.Widget.setAlpha] (Widget.sling:1695:3): Not implemented" .. "\n")
end

function jk.widget.Widget:setRotation(widget, degrees)
	if not (widget ~= nil) then
		do return end
	end
	_io:write_to_stdout("[jk.widget.Widget.setRotation] (Widget.sling:1738:3): Not implemented" .. "\n")
end

function jk.widget.Widget:setEnabled(widget, enabled)
	if not (widget ~= nil) then
		do return end
	end
	_io:write_to_stdout("[jk.widget.Widget.setEnabled] (Widget.sling:1786:3): Not implemented" .. "\n")
end

function jk.widget.Widget:setTabIndex(widget, index)
	if not (widget ~= nil) then
		do return end
	end
	_io:write_to_stdout("[jk.widget.Widget.setTabIndex] (Widget.sling:1797:3): Not Implemented" .. "\n")
end

function jk.widget.Widget:setVisible(widget, visible)
	if not (widget ~= nil) then
		do return end
	end
	_io:write_to_stdout("[jk.widget.Widget.setVisible] (Widget.sling:1848:3): Not implemented" .. "\n")
end

function jk.widget.Widget:getVisible(widget)
	if not (widget ~= nil) then
		do return false end
	end
	_io:write_to_stdout("[jk.widget.Widget.getVisible] (Widget.sling:1881:3): Not implemented" .. "\n")
	do return false end
end

function jk.widget.Widget:setWidgetId(widget, idValue)
	if not (widget ~= nil) then
		do return end
	end
	if (_vm:to_table_with_key(widget, '_isType.jk.widget.IdAwareWidget') ~= nil) then
		do _vm:to_table_with_key(widget, '_isType.jk.widget.IdAwareWidget'):setWidgetId(idValue) end
	else
		_io:write_to_stdout("[jk.widget.Widget.setWidgetId] (Widget.sling:1918:4): Not yet implemented" .. "\n")
	end
end

function jk.widget.Widget:focus(widget)
	_io:write_to_stdout("[jk.widget.Widget.focus] (Widget.sling:1930:3): Not implemented" .. "\n")
end

function jk.widget.Widget:setWidgetToolTipText(widget, str)
	_io:write_to_stdout("[jk.widget.Widget.setWidgetToolTipText] (Widget.sling:1940:3): Not implemented" .. "\n")
end

function jk.widget.Widget:setWidgetMousePointer(widget, mousePointer)
	_io:write_to_stdout("[jk.widget.Widget.setWidgetMousePointer] (Widget.sling:1970:3): Not Implemented" .. "\n")
end

jk.widget.TitleContainerWidget = {}

jk.widget.WidgetWithLayout = {}

jk.widget.ParentAwareWidget = {}

jk.widget.RenderableWidget = _g.jk.widget.Widget._create()
jk.widget.RenderableWidget.__index = jk.widget.RenderableWidget
_vm:set_metatable(jk.widget.RenderableWidget, {
	__index = _g.jk.widget.Widget
})

function jk.widget.RenderableWidget._create()
	local v = _vm:set_metatable({}, jk.widget.RenderableWidget)
	return v
end

function jk.widget.RenderableWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.RenderableWidget'
	self['_isType.jk.widget.RenderableWidget'] = true
	self['_isType.jk.widget.ParentAwareWidget'] = true
	self['_isType.jk.widget.ResizeAwareWidget'] = true
	self.context = nil
	self.renderer = nil
end

function jk.widget.RenderableWidget:_construct0()
	jk.widget.RenderableWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	return self
end

function jk.widget.RenderableWidget:forRenderer(ctx, renderer)
	local v = _g.jk.widget.RenderableWidget._construct1(_g.jk.widget.RenderableWidget._create(), ctx)
	do v:setRenderer(renderer) end
	do return v end
end

function jk.widget.RenderableWidget:_construct1(ctx)
	jk.widget.RenderableWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	self.context = ctx
	return self
end

function jk.widget.RenderableWidget:render(ctx)
	if self.renderer ~= nil then
		do self.renderer:render(ctx, _g.jk.widget.Widget:getWidth(self), _g.jk.widget.Widget:getHeight(self)) end
	end
end

function jk.widget.RenderableWidget:redraw()
	_io:write_to_stdout("[jk.widget.RenderableWidget.redraw] (RenderableWidget.sling:144:3): Not implemented" .. "\n")
end

function jk.widget.RenderableWidget:onWidgetResized()
end

function jk.widget.RenderableWidget:onWidgetAddedToParent()
end

function jk.widget.RenderableWidget:onWidgetRemovedFromParent()
end

function jk.widget.RenderableWidget:onWidgetAddingToParent()
end

function jk.widget.RenderableWidget:getRenderer()
	do return self.renderer end
end

function jk.widget.RenderableWidget:setRenderer(v)
	self.renderer = v
	do return self end
end

jk.widget.CanvasWidget = {}
jk.widget.CanvasWidget.__index = jk.widget.CanvasWidget
_vm:set_metatable(jk.widget.CanvasWidget, {})

jk.widget.CanvasWidget.BORDER_STYLE_SOLID = 0
jk.widget.CanvasWidget.BORDER_STYLE_DASHED = 1
jk.widget.CanvasWidget.BORDER_STYLE_DOTTED = 2
jk.widget.CanvasWidget.BORDER_STYLE_NONE = 3
jk.widget.CanvasWidget.BORDER_STYLE_3D = 4

function jk.widget.CanvasWidget._create()
	local v = _vm:set_metatable({}, jk.widget.CanvasWidget)
	return v
end

function jk.widget.CanvasWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.CanvasWidget'
	self['_isType.jk.widget.CanvasWidget'] = true
	self['_isType.jk.widget.WidgetWithLayout'] = true
	self.widgetContext = nil
	self.widgetColor = nil
	self.widgetTopLeftRadius = 0.0
	self.widgetTopRightRadius = 0.0
	self.widgetBottomRightRadius = 0.0
	self.widgetBottomLeftRadius = 0.0
	self.widgetOutlineColor = nil
	self.widgetOutlineWidth = 0
	self.widgetBorderStyle = 0
end

function jk.widget.CanvasWidget:_construct0()
	jk.widget.CanvasWidget._init(self)
	return self
end

function jk.widget.CanvasWidget:forColor(context, color)
	local v = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), context)
	do v:setWidgetColor(color) end
	do return v end
end

function jk.widget.CanvasWidget:_construct1(context)
	jk.widget.CanvasWidget._init(self)
	self.widgetContext = context
	self.widgetColor = _g.jk.gfx.Color:black()
	self.widgetOutlineColor = _g.jk.gfx.Color:black()
	return self
end

function jk.widget.CanvasWidget:setWidgetLayoutChanged()
end

function jk.widget.CanvasWidget:hasWidgetLayoutChanged()
	do return false end
end

function jk.widget.CanvasWidget:layoutWidget(widthConstraint, force)
	local wc = widthConstraint
	if wc < 0 then
		wc = 0
	end
	do _g.jk.widget.Widget:setLayoutSize(self, wc, 0) end
	do return true end
end

function jk.widget.CanvasWidget:setWidgetColor(color)
	self.widgetColor = color
	_io:write_to_stdout("[jk.widget.CanvasWidget.setWidgetColor] (CanvasWidget.sling:195:3): Not implemented" .. "\n")
end

function jk.widget.CanvasWidget:getWidgetColor()
	do return self.widgetColor end
end

function jk.widget.CanvasWidget:setWidgetOutlineColor(color)
	self.widgetOutlineColor = color
	do self:updateCanvas() end
end

function jk.widget.CanvasWidget:getWidgetOutlineColor()
	do return self.widgetOutlineColor end
end

function jk.widget.CanvasWidget:setWidgetOutlineWidth(width)
	self.widgetOutlineWidth = width
	do self:updateCanvas() end
end

function jk.widget.CanvasWidget:getWidgetOutlineWidth()
	do return self.widgetOutlineWidth end
end

function jk.widget.CanvasWidget:updateCanvas()
	_io:write_to_stdout("[jk.widget.CanvasWidget.updateCanvas] (CanvasWidget.sling:278:3): Not implemented." .. "\n")
end

function jk.widget.CanvasWidget:updateCanvasRoundingRadius()
	local isRounded = true
	if self.widgetTopLeftRadius <= 0.0 and self.widgetTopRightRadius <= 0.0 and self.widgetBottomRightRadius <= 0.0 and self.widgetBottomLeftRadius <= 0.0 then
		isRounded = false
	end
	_io:write_to_stdout("[jk.widget.CanvasWidget.updateCanvasRoundingRadius] (CanvasWidget.sling:386:3): Not implemented" .. "\n")
end

function jk.widget.CanvasWidget:getWidgetTopLeftRadius()
	do return self.widgetTopLeftRadius end
end

function jk.widget.CanvasWidget:getWidgetTopRightRadius()
	do return self.widgetTopRightRadius end
end

function jk.widget.CanvasWidget:getWidgetBottomRightRadius()
	do return self.widgetBottomRightRadius end
end

function jk.widget.CanvasWidget:getWidgetBottomLeftRadius()
	do return self.widgetBottomLeftRadius end
end

function jk.widget.CanvasWidget:setWidgetRoundingRadiusTopLeft(radius)
	self.widgetTopLeftRadius = radius
	do self:updateCanvasRoundingRadius() end
end

function jk.widget.CanvasWidget:setWidgetRoundingRadiusTopRight(radius)
	self.widgetTopRightRadius = radius
	do self:updateCanvasRoundingRadius() end
end

function jk.widget.CanvasWidget:setWidgetRoundingRadiusBottomLeft(radius)
	self.widgetBottomLeftRadius = radius
	do self:updateCanvasRoundingRadius() end
end

function jk.widget.CanvasWidget:setWidgetRoundingRadiusBottomRight(radius)
	self.widgetBottomRightRadius = radius
	do self:updateCanvasRoundingRadius() end
end

function jk.widget.CanvasWidget:setWidgetRoundingRadius1(radius)
	do self:setWidgetRoundingRadius3(radius, radius, radius, radius) end
end

function jk.widget.CanvasWidget:setWidgetRoundingRadius2(lradius, rradius)
	do self:setWidgetRoundingRadius3(lradius, rradius, rradius, lradius) end
end

function jk.widget.CanvasWidget:setWidgetRoundingRadius3(tlradius, trradius, brradius, blradius)
	self.widgetTopLeftRadius = tlradius
	self.widgetTopRightRadius = trradius
	self.widgetBottomRightRadius = brradius
	self.widgetBottomLeftRadius = blradius
	do self:updateCanvasRoundingRadius() end
end

function jk.widget.CanvasWidget:setWidgetBorderStyle(style)
	self.widgetBorderStyle = style
	_io:write_to_stdout("[jk.widget.CanvasWidget.setWidgetBorderStyle] (CanvasWidget.sling:519:3): Not implemented" .. "\n")
	do return self end
end

jk.widget.HeightAwareWidget = {}

jk.widget.ScreenStartStopAwareWidget = {}

jk.widget.ContainerWidget = _g.jk.widget.Widget._create()
jk.widget.ContainerWidget.__index = jk.widget.ContainerWidget
_vm:set_metatable(jk.widget.ContainerWidget, {
	__index = _g.jk.widget.Widget
})

jk.widget.ContainerWidget.layoutQueue = nil

function jk.widget.ContainerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.ContainerWidget)
	return v
end

function jk.widget.ContainerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.ContainerWidget'
	self['_isType.jk.widget.ContainerWidget'] = true
	self['_isType.jk.widget.ParentAwareWidget'] = true
	self['_isType.jk.widget.WidgetWithLayout'] = true
	self['_isType.jk.widget.HeightAwareWidget'] = true
	self.context = nil
	self.widgetLayoutChanged = true
	self.lastWidthConstraint = -2
	self.lastLayoutWidth = -1
	self.isLayoutScheduled = false
	self.allowResize = true
	self.initialized = false
	self.created = false
end

function jk.widget.ContainerWidget:_construct0()
	jk.widget.ContainerWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	return self
end

function jk.widget.ContainerWidget:_construct1(ctx)
	jk.widget.ContainerWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	self.context = ctx
	do self:togglePointerEventHandling1(false) end
	return self
end

function jk.widget.ContainerWidget:togglePointerEventHandling1(active)
	if active then
		_io:write_to_stdout("[jk.widget.ContainerWidget.togglePointerEventHandling] (ContainerWidget.sling:257:4): Not implemented" .. "\n")
	else
		_io:write_to_stdout("[jk.widget.ContainerWidget.togglePointerEventHandling] (ContainerWidget.sling:274:4): Not implemented" .. "\n")
	end
end

function jk.widget.ContainerWidget:onNativelyResized()
	if _g.jk.widget.Widget:isRootWidget(self) then
		do _g.jk.widget.Widget:layout(self, _g.jk.widget.Widget:getWidth(self), false) end
		do self:onWidgetHeightChanged(_g.jk.widget.Widget:getHeight(self)) end
	end
end

function jk.widget.ContainerWidget:hasSize()
	if _g.jk.widget.Widget:getWidth(self) > 0 or _g.jk.widget.Widget:getHeight(self) > 0 then
		do return true end
	end
	do return false end
end

function jk.widget.ContainerWidget:createWidget()
end

function jk.widget.ContainerWidget:forceCreateWidget()
	if not self.created then
		do self:createWidget() end
		self.created = true
	end
end

function jk.widget.ContainerWidget:onWidgetAddingToParent()
	do self:forceCreateWidget() end
	if self.initialized then
		do return end
	end
	do self:setInitialized(true) end
	do self:initializeWidget() end
end

function jk.widget.ContainerWidget:initializeWidget()
end

function jk.widget.ContainerWidget:addWidget(widget)
	do _g.jk.widget.Widget:addChild(self, widget) end
	do return self end
end

function jk.widget.ContainerWidget:onChildWidgetAdded(widget)
	do _g.jk.widget.Widget:onLayoutChanged(self) end
end

function jk.widget.ContainerWidget:onChildWidgetsRemoved(widgets)
	do _g.jk.widget.Widget:onLayoutChanged(self) end
end

function jk.widget.ContainerWidget:onWidgetAddedToParent()
	do _g.jk.widget.Widget:onLayoutChanged(self) end
end

function jk.widget.ContainerWidget:onWidgetRemovedFromParent()
end

function jk.widget.ContainerWidget:onWidgetHeightChanged(height)
end

function jk.widget.ContainerWidget:computeWidgetLayout(widthConstraint)
end

function jk.widget.ContainerWidget:setWidgetLayoutChanged()
	self.widgetLayoutChanged = true
end

function jk.widget.ContainerWidget:hasWidgetLayoutChanged()
	do return self.widgetLayoutChanged end
end

function jk.widget.ContainerWidget:layoutWidget(widthConstraint, force)
	if force or self.widgetLayoutChanged or widthConstraint ~= self.lastWidthConstraint then
		if force == false and self.widgetLayoutChanged == false and (widthConstraint >= 0 and widthConstraint == self.lastLayoutWidth) then
		else
			self.widgetLayoutChanged = false
			do self:computeWidgetLayout(widthConstraint) end
			self.lastWidthConstraint = widthConstraint
			self.lastLayoutWidth = _g.jk.widget.Widget:getWidth(self)
		end
	end
	do return true end
end

function jk.widget.ContainerWidget:scheduleLayout()
	if self.isLayoutScheduled then
		do return end
	end
	self.isLayoutScheduled = true
	do self:addToLayoutQueue(self) end
end

function jk.widget.ContainerWidget:executeLayout()
	self.isLayoutScheduled = false
	do
		local ww = _g.jk.widget.Widget:getWidth(self)
		if ww == 0 and self.allowResize then
			ww = -1
		end
		do _g.jk.widget.Widget:layout(self, ww, false) end
	end
end

function jk.widget.ContainerWidget:processLayoutQueue()
	if not (_g.jk.widget.ContainerWidget.layoutQueue ~= nil) then
		do return end
	end
	do
		local lq = _g.jk.widget.ContainerWidget.layoutQueue
		_g.jk.widget.ContainerWidget.layoutQueue = nil
		if lq ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(lq)
			do
				n = 0
				while n < m do
					local widget = lq[n + 1]
					if widget ~= nil then
						do widget:executeLayout() end
					end
					do n = n + 1 end
				end
			end
		end
	end
end

function jk.widget.ContainerWidget:addToLayoutQueue(widget)
	if not (widget ~= nil) then
		do return end
	end
	if _g.jk.widget.ContainerWidget.layoutQueue ~= nil then
		do _g.jk.lang.Vector:append(_g.jk.widget.ContainerWidget.layoutQueue, widget) end
		do return end
	end
	_g.jk.widget.ContainerWidget.layoutQueue = {}
	do _g.jk.lang.Vector:append(_g.jk.widget.ContainerWidget.layoutQueue, widget) end
	do self.context:startTimer(0, function()
		local c = 0
		while _g.jk.widget.ContainerWidget.layoutQueue ~= nil do
			if c >= 10 then
				do break end
			end
			do self:processLayoutQueue() end
			do c = c + 1 end
		end
	end) end
end

function jk.widget.ContainerWidget:getAllowResize()
	do return self.allowResize end
end

function jk.widget.ContainerWidget:setAllowResize(v)
	self.allowResize = v
	do return self end
end

function jk.widget.ContainerWidget:getInitialized()
	do return self.initialized end
end

function jk.widget.ContainerWidget:setInitialized(v)
	self.initialized = v
	do return self end
end

function jk.widget.ContainerWidget:getCreated()
	do return self.created end
end

function jk.widget.ContainerWidget:setCreated(v)
	self.created = v
	do return self end
end

jk.widget.HorizontalBoxWidget = _g.jk.widget.ContainerWidget._create()
jk.widget.HorizontalBoxWidget.__index = jk.widget.HorizontalBoxWidget
_vm:set_metatable(jk.widget.HorizontalBoxWidget, {
	__index = _g.jk.widget.ContainerWidget
})

function jk.widget.HorizontalBoxWidget._create()
	local v = _vm:set_metatable({}, jk.widget.HorizontalBoxWidget)
	return v
end

function jk.widget.HorizontalBoxWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.HorizontalBoxWidget'
	self['_isType.jk.widget.HorizontalBoxWidget'] = true
	self.children = nil
	self.widgetSpacing = 0
	self.widgetMarginLeft = 0
	self.widgetMarginRight = 0
	self.widgetMarginTop = 0
	self.widgetMarginBottom = 0
	self.widgetFixedHeight = 0
end

function jk.widget.HorizontalBoxWidget:_construct0()
	jk.widget.HorizontalBoxWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct0(self) end
	return self
end

jk.widget.HorizontalBoxWidget.MyChildEntry = {}
jk.widget.HorizontalBoxWidget.MyChildEntry.__index = jk.widget.HorizontalBoxWidget.MyChildEntry
_vm:set_metatable(jk.widget.HorizontalBoxWidget.MyChildEntry, {})

function jk.widget.HorizontalBoxWidget.MyChildEntry._create()
	local v = _vm:set_metatable({}, jk.widget.HorizontalBoxWidget.MyChildEntry)
	return v
end

function jk.widget.HorizontalBoxWidget.MyChildEntry:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.HorizontalBoxWidget.MyChildEntry'
	self['_isType.jk.widget.HorizontalBoxWidget.MyChildEntry'] = true
	self.widget = nil
	self.weight = 0.0
end

function jk.widget.HorizontalBoxWidget.MyChildEntry:_construct0()
	jk.widget.HorizontalBoxWidget.MyChildEntry._init(self)
	return self
end

function jk.widget.HorizontalBoxWidget:forContext(context, widgetMargin, widgetSpacing)
	local v = _g.jk.widget.HorizontalBoxWidget._construct1(_g.jk.widget.HorizontalBoxWidget._create(), context)
	v.widgetMarginLeft = widgetMargin
	v.widgetMarginRight = widgetMargin
	v.widgetMarginTop = widgetMargin
	v.widgetMarginBottom = widgetMargin
	v.widgetSpacing = widgetSpacing
	do return v end
end

function jk.widget.HorizontalBoxWidget:_construct1(ctx)
	jk.widget.HorizontalBoxWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct1(self, ctx) end
	self.children = {}
	return self
end

function jk.widget.HorizontalBoxWidget:setWidgetMargin(margin)
	self.widgetMarginLeft = margin
	self.widgetMarginRight = margin
	self.widgetMarginTop = margin
	self.widgetMarginBottom = margin
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.HorizontalBoxWidget:getWidgetMarginLeft()
	do return self.widgetMarginLeft end
end

function jk.widget.HorizontalBoxWidget:setWidgetMarginLeft(value)
	self.widgetMarginLeft = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.HorizontalBoxWidget:getWidgetMarginRight()
	do return self.widgetMarginRight end
end

function jk.widget.HorizontalBoxWidget:setWidgetMarginRight(value)
	self.widgetMarginRight = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.HorizontalBoxWidget:getWidgetMarginTop()
	do return self.widgetMarginTop end
end

function jk.widget.HorizontalBoxWidget:setWidgetMarginTop(value)
	self.widgetMarginTop = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.HorizontalBoxWidget:getWidgetMarginBottom()
	do return self.widgetMarginBottom end
end

function jk.widget.HorizontalBoxWidget:setWidgetMarginBottom(value)
	self.widgetMarginBottom = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.HorizontalBoxWidget:computeWidgetLayout(widthConstraint)
	local totalWeight = 0.0
	local highest = 0
	local availableWidth = widthConstraint - self.widgetMarginLeft - self.widgetMarginRight
	local childCount = 0
	if self.children ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(self.children)
		do
			n = 0
			while n < m do
				local child = self.children[n + 1]
				if child ~= nil then
					do childCount = childCount + 1 end
					if child.weight > 0.0 then
						totalWeight = totalWeight + child.weight
					else
						do _g.jk.widget.Widget:layout(child.widget, -1, false) end
						availableWidth = availableWidth - _g.jk.widget.Widget:getWidth(child.widget)
						do
							local height = _g.jk.widget.Widget:getHeight(child.widget)
							if height > highest then
								highest = height
							end
						end
					end
				end
				do n = n + 1 end
			end
		end
	end
	if childCount > 1 and self.widgetSpacing > 0 then
		availableWidth = availableWidth - (childCount - 1) * self.widgetSpacing
	end
	if self.children ~= nil then
		local n2 = 0
		local m2 = _g.jk.lang.Vector:getSize(self.children)
		do
			n2 = 0
			while n2 < m2 do
				local child = self.children[n2 + 1]
				if child ~= nil then
					if child.weight > 0.0 then
						local ww = _util:convert_to_integer(availableWidth * child.weight / totalWeight)
						do _g.jk.widget.Widget:layout(child.widget, ww, false) end
						do
							local height = _g.jk.widget.Widget:getHeight(child.widget)
							if height > highest then
								highest = height
							end
						end
					end
				end
				do n2 = n2 + 1 end
			end
		end
	end
	do
		local realHighest = highest
		highest = highest + (self.widgetMarginTop + self.widgetMarginBottom)
		if self.widgetFixedHeight > 0 then
			highest = self.widgetFixedHeight
		end
		if widthConstraint < 0 then
			local totalWidth = widthConstraint - availableWidth
			do _g.jk.widget.Widget:setLayoutSize(self, totalWidth, highest) end
		else
			do _g.jk.widget.Widget:setLayoutSize(self, widthConstraint, highest) end
		end
		if availableWidth < 0 then
			availableWidth = 0
		end
		do
			local x = self.widgetMarginLeft
			if self.children ~= nil then
				local n3 = 0
				local m3 = _g.jk.lang.Vector:getSize(self.children)
				do
					n3 = 0
					while n3 < m3 do
						local child = self.children[n3 + 1]
						if child ~= nil then
							local ww = 0
							if child.weight > 0.0 then
								ww = _util:convert_to_integer(availableWidth * child.weight / totalWeight)
								do _g.jk.widget.Widget:move(child.widget, x, self.widgetMarginTop) end
								do _g.jk.widget.Widget:layout(child.widget, ww, false) end
								do _g.jk.widget.Widget:resizeHeight(child.widget, realHighest) end
							else
								ww = _g.jk.widget.Widget:getWidth(child.widget)
								do _g.jk.widget.Widget:move(child.widget, x, self.widgetMarginTop) end
								do _g.jk.widget.Widget:layout(child.widget, ww, false) end
								do _g.jk.widget.Widget:resizeHeight(child.widget, realHighest) end
							end
							x = x + ww
							x = x + self.widgetSpacing
						end
						do n3 = n3 + 1 end
					end
				end
			end
		end
	end
end

function jk.widget.HorizontalBoxWidget:onWidgetHeightChanged(height)
	do _g.jk.widget.ContainerWidget.onWidgetHeightChanged(self, height) end
	do
		local array = _g.jk.widget.Widget:getChildren(self)
		if array ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(array)
			do
				n = 0
				while n < m do
					local child = array[n + 1]
					if child ~= nil then
						do _g.jk.widget.Widget:resizeHeight(child, height - self.widgetMarginTop - self.widgetMarginBottom) end
					end
					do n = n + 1 end
				end
			end
		end
	end
end

function jk.widget.HorizontalBoxWidget:onChildWidgetsRemoved(widgets)
	local ws = _g.jk.lang.Vector:getSize(widgets)
	if ws > 0 then
		local vs = _g.jk.lang.Vector:getSize(self.children)
		if ws == vs then
			do _g.jk.lang.Vector:clear(self.children) end
		else
			local widget = _g.jk.lang.Vector:get(widgets, 0)
			if self.children ~= nil then
				local n = 0
				local m = _g.jk.lang.Vector:getSize(self.children)
				do
					n = 0
					while n < m do
						local child = self.children[n + 1]
						if child ~= nil then
							if child.widget == widget then
								do _g.jk.lang.Vector:removeValue(self.children, child) end
								do break end
							end
						end
						do n = n + 1 end
					end
				end
			end
		end
	end
	do _g.jk.widget.ContainerWidget.onChildWidgetsRemoved(self, widgets) end
end

function jk.widget.HorizontalBoxWidget:addWidget(widget)
	do return self:addWidget1(widget, 0.0) end
end

function jk.widget.HorizontalBoxWidget:removeAllChildren()
	do _g.jk.widget.Widget:removeChildrenOf(self) end
end

function jk.widget.HorizontalBoxWidget:addWidget1(widget, weight)
	if widget ~= nil then
		local ee = _g.jk.widget.HorizontalBoxWidget.MyChildEntry._construct0(_g.jk.widget.HorizontalBoxWidget.MyChildEntry._create())
		ee.widget = widget
		ee.weight = weight
		do _g.jk.lang.Vector:append(self.children, ee) end
		do _g.jk.widget.Widget:addChild(self, widget) end
	end
	do return self end
end

function jk.widget.HorizontalBoxWidget:setWidgetWeight(widget, weight)
	if self.children ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(self.children)
		do
			n = 0
			while n < m do
				local child = self.children[n + 1]
				if child ~= nil then
					if child.widget == widget then
						child.weight = weight
						do _g.jk.widget.Widget:onLayoutChanged(self) end
						do break end
					end
				end
				do n = n + 1 end
			end
		end
	end
end

function jk.widget.HorizontalBoxWidget:getWidgetSpacing()
	do return self.widgetSpacing end
end

function jk.widget.HorizontalBoxWidget:setWidgetSpacing(v)
	self.widgetSpacing = v
	do return self end
end

function jk.widget.HorizontalBoxWidget:getWidgetFixedHeight()
	do return self.widgetFixedHeight end
end

function jk.widget.HorizontalBoxWidget:setWidgetFixedHeight(v)
	self.widgetFixedHeight = v
	do return self end
end

jk.widget.StaticWidgetProvider = {}
jk.widget.StaticWidgetProvider.__index = jk.widget.StaticWidgetProvider
_vm:set_metatable(jk.widget.StaticWidgetProvider, {})

function jk.widget.StaticWidgetProvider._create()
	local v = _vm:set_metatable({}, jk.widget.StaticWidgetProvider)
	return v
end

function jk.widget.StaticWidgetProvider:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.StaticWidgetProvider'
	self['_isType.jk.widget.StaticWidgetProvider'] = true
	self['_isType.jk.widget.WidgetProvider'] = true
	self.widgets = nil
	self.current = 0
end

function jk.widget.StaticWidgetProvider:_construct0()
	jk.widget.StaticWidgetProvider._init(self)
	return self
end

function jk.widget.StaticWidgetProvider:forWidgets(widgets)
	local v = _g.jk.widget.StaticWidgetProvider._construct0(_g.jk.widget.StaticWidgetProvider._create())
	do v:setWidgets(widgets) end
	do return v end
end

function jk.widget.StaticWidgetProvider:getNextWidget()
	if not (self.widgets ~= nil) then
		do return nil end
	end
	do
		local v = _g.jk.lang.Vector:get(self.widgets, self.current)
		if v ~= nil then
			do self.current = self.current + 1 end
		end
		do return v end
	end
end

function jk.widget.StaticWidgetProvider:getTotalCount()
	do return _g.jk.lang.Vector:getSize(self.widgets) end
end

function jk.widget.StaticWidgetProvider:reset()
	self.current = 0
end

function jk.widget.StaticWidgetProvider:getWidgets()
	do return self.widgets end
end

function jk.widget.StaticWidgetProvider:setWidgets(v)
	self.widgets = v
	do return self end
end

jk.widget.ResponsiveAwareWidget = {}

jk.widget.ScrollerWidget = {}
jk.widget.ScrollerWidget.__index = jk.widget.ScrollerWidget
_vm:set_metatable(jk.widget.ScrollerWidget, {})

function jk.widget.ScrollerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.ScrollerWidget)
	return v
end

function jk.widget.ScrollerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.ScrollerWidget'
	self['_isType.jk.widget.ScrollerWidget'] = true
	self['_isType.jk.widget.WidgetWithLayout'] = true
	self['_isType.jk.widget.HeightAwareWidget'] = true
	self.widgetOnScrolledHandlerX = nil
	self.widgetOnScrolledHandlerY = nil
	self.widgetMaximumValueX = 1000.0
	self.widgetMaximumValueY = 1000.0
	self.layoutHeight = -1
	self.layoutWidth = -1
	self.heightChanged = false
	self.valueX = 0.0
	self.valueY = 0.0
	self.currentScrollX = 0
	self.currentScrollY = 0
	self.lastScrollX = 0
	self.lastScrollY = 0
	self.nearEndX = false
	self.nearEndY = false
end

function jk.widget.ScrollerWidget:_construct0()
	jk.widget.ScrollerWidget._init(self)
	return self
end

function jk.widget.ScrollerWidget:forWidget(context, widget)
	local v = _g.jk.widget.ScrollerWidget._construct1(_g.jk.widget.ScrollerWidget._create(), context)
	do v:addWidget(widget) end
	do return v end
end

function jk.widget.ScrollerWidget:onScroll(scrollX, scrollY)
	self.currentScrollX = scrollX
	do
		local cw = _g.jk.widget.Widget:getWidth(_g.jk.lang.Vector:get(_g.jk.widget.Widget:getChildren(self), 0))
		self.valueX = _util:convert_to_integer(self.currentScrollX / (cw - _g.jk.widget.Widget:getWidth(self))) * self.widgetMaximumValueX
		if cw > 0 then
			self.nearEndX = cw - self.currentScrollX < _g.jk.widget.Widget:getWidth(self) * 2
		end
		if self.widgetOnScrolledHandlerX ~= nil and self.lastScrollX ~= self.currentScrollX then
			do self.widgetOnScrolledHandlerX((function(a, b, c)
				if a then
					do return b() end
				end
				do return c() end
			end)(self.lastScrollX < self.currentScrollX, function()
				do return 0 end
			end, function()
				do return 1 end
			end)) end
			self.lastScrollX = self.currentScrollX
		end
		self.currentScrollY = scrollY
		do
			local ch = _g.jk.widget.Widget:getHeight(_g.jk.lang.Vector:get(_g.jk.widget.Widget:getChildren(self), 0))
			self.valueY = _util:convert_to_integer(scrollY / (ch - _g.jk.widget.Widget:getHeight(self))) * self.widgetMaximumValueY
			if ch > 0 then
				self.nearEndY = ch - self.currentScrollY < _g.jk.widget.Widget:getHeight(self) * 2
			end
			if self.widgetOnScrolledHandlerY ~= nil and self.lastScrollY ~= self.currentScrollY then
				do self.widgetOnScrolledHandlerY((function(a, b, c)
					if a then
						do return b() end
					end
					do return c() end
				end)(self.lastScrollY < self.currentScrollY, function()
					do return 0 end
				end, function()
					do return 1 end
				end)) end
				self.lastScrollY = self.currentScrollY
			end
		end
	end
end

function jk.widget.ScrollerWidget:isNearEndX()
	do return self.nearEndX end
end

function jk.widget.ScrollerWidget:isNearEndY()
	do return self.nearEndY end
end

function jk.widget.ScrollerWidget:getValueX()
	do return self.valueX end
end

function jk.widget.ScrollerWidget:getValueY()
	do return self.valueY end
end

function jk.widget.ScrollerWidget:_construct1(context)
	jk.widget.ScrollerWidget._init(self)
	return self
end

function jk.widget.ScrollerWidget:setWidgetScrollBarDisabled(value)
end

function jk.widget.ScrollerWidget:onWidgetHeightChanged(height)
	local array = _g.jk.widget.Widget:getChildren(self)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local child = array[n + 1]
				if child ~= nil then
					if height > self.layoutHeight then
						do _g.jk.widget.Widget:resizeHeight(child, height) end
					else
						do _g.jk.widget.Widget:resizeHeight(child, self.layoutHeight) end
					end
				end
				do n = n + 1 end
			end
		end
	end
	self.heightChanged = true
end

function jk.widget.ScrollerWidget:setWidgetLayoutChanged()
end

function jk.widget.ScrollerWidget:hasWidgetLayoutChanged()
	do return false end
end

function jk.widget.ScrollerWidget:layoutWidget(widthConstraint, force)
	local mw = 0
	local mh = 0
	local array = _g.jk.widget.Widget:getChildren(self)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local child = array[n + 1]
				if child ~= nil then
					do _g.jk.widget.Widget:move(child, 0, 0) end
					do _g.jk.widget.Widget:layout(child, -1, self.heightChanged) end
					do
						local cw = _g.jk.widget.Widget:getWidth(child)
						local ch = _g.jk.widget.Widget:getHeight(child)
						if cw > mw then
							mw = cw
						end
						if ch > mh then
							mh = ch
						end
					end
				end
				do n = n + 1 end
			end
		end
	end
	do
		local mh2 = mh
		local eh = _g.jk.widget.Widget:getHeight(self)
		if eh > 0 and mh2 > eh then
			mh2 = eh
		end
		self.heightChanged = false
		self.layoutHeight = mh
		self.layoutWidth = mw
		if widthConstraint < 0 then
			do _g.jk.widget.Widget:setLayoutSize(self, mw, mh2) end
		else
			do _g.jk.widget.Widget:setLayoutSize(self, widthConstraint, mh2) end
		end
		do return true end
	end
end

function jk.widget.ScrollerWidget:addWidget(widget)
	do _g.jk.widget.Widget:addChild(self, widget) end
	do return self end
end

function jk.widget.ScrollerWidget:getWidgetOnScrolledHandlerX()
	do return self.widgetOnScrolledHandlerX end
end

function jk.widget.ScrollerWidget:setWidgetOnScrolledHandlerX(v)
	self.widgetOnScrolledHandlerX = v
	do return self end
end

function jk.widget.ScrollerWidget:getWidgetOnScrolledHandlerY()
	do return self.widgetOnScrolledHandlerY end
end

function jk.widget.ScrollerWidget:setWidgetOnScrolledHandlerY(v)
	self.widgetOnScrolledHandlerY = v
	do return self end
end

function jk.widget.ScrollerWidget:getWidgetMaximumValueX()
	do return self.widgetMaximumValueX end
end

function jk.widget.ScrollerWidget:setWidgetMaximumValueX(v)
	self.widgetMaximumValueX = v
	do return self end
end

function jk.widget.ScrollerWidget:getWidgetMaximumValueY()
	do return self.widgetMaximumValueY end
end

function jk.widget.ScrollerWidget:setWidgetMaximumValueY(v)
	self.widgetMaximumValueY = v
	do return self end
end

jk.widget.ImageWidget = {}
jk.widget.ImageWidget.__index = jk.widget.ImageWidget
_vm:set_metatable(jk.widget.ImageWidget, {})

jk.widget.ImageWidget.STRETCH = 0
jk.widget.ImageWidget.FIT = 1
jk.widget.ImageWidget.FILL = 2

function jk.widget.ImageWidget._create()
	local v = _vm:set_metatable({}, jk.widget.ImageWidget)
	return v
end

function jk.widget.ImageWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.ImageWidget'
	self['_isType.jk.widget.ImageWidget'] = true
	self['_isType.jk.widget.WidgetWithLayout'] = true
	self.widgetContext = nil
	self.widgetImage = nil
	self.widgetImageWidth = 0
	self.widgetImageHeight = 0
	self.widgetImageRounded = false
	self.widgetImageScaleMethod = 0
	self.lastLayoutWidth = 0
end

function jk.widget.ImageWidget:_construct0()
	jk.widget.ImageWidget._init(self)
	return self
end

function jk.widget.ImageWidget:forImage(context, image)
	local v = _g.jk.widget.ImageWidget._construct1(_g.jk.widget.ImageWidget._create(), context)
	do v:setWidgetImage(image) end
	do return v end
end

function jk.widget.ImageWidget:forImageResource(context, resName)
	local v = _g.jk.widget.ImageWidget._construct1(_g.jk.widget.ImageWidget._create(), context)
	do v:setWidgetImageResource(resName) end
	do return v end
end

function jk.widget.ImageWidget:_construct1(context)
	jk.widget.ImageWidget._init(self)
	self.widgetContext = context
	do self:setWidgetImageScaleMethod(_g.jk.widget.ImageWidget.STRETCH) end
	return self
end

function jk.widget.ImageWidget:setWidgetImageScaleMethod(method)
	self.widgetImageScaleMethod = method
	_io:write_to_stdout("[jk.widget.ImageWidget.setWidgetImageScaleMethod] (ImageWidget.sling:221:3): Not implemented" .. "\n")
end

function jk.widget.ImageWidget:setWidgetImage(image)
	if self.widgetImageRounded then
		self.widgetImage = _g.jk.ui.ImageUtil:createCircularImageSync(image)
	else
		self.widgetImage = image
	end
	_io:write_to_stdout("[jk.widget.ImageWidget.setWidgetImage] (ImageWidget.sling:272:4): Not implemented" .. "\n")
	do _g.jk.widget.Widget:onLayoutChanged(self) end
end

function jk.widget.ImageWidget:setWidgetImageResource(resName)
	local img = nil
	if _g.jk.lang.String:isEmpty(resName) == false and self.widgetContext ~= nil then
		img = self.widgetContext:getResourceImage(resName)
		if img == nil then
			do _g.jk.log.Log:error(self.widgetContext, "Failed to get resource image: `" .. _g.jk.lang.String:safeString(resName) .. "'") end
		end
	end
	do self:setWidgetImage(img) end
end

function jk.widget.ImageWidget:setWidgetLayoutChanged()
end

function jk.widget.ImageWidget:hasWidgetLayoutChanged()
	do return false end
end

function jk.widget.ImageWidget:layoutWidget(widthConstraint, force)
	if widthConstraint >= 0 and widthConstraint == self.lastLayoutWidth then
		do return true end
	end
	if self.widgetImage == nil then
		do _g.jk.widget.Widget:setLayoutSize(self, self.widgetImageWidth, self.widgetImageHeight) end
		self.lastLayoutWidth = _g.jk.widget.Widget:getWidth(self)
		do return true end
	end
	if widthConstraint < 0 and self.widgetImageWidth < 1 and self.widgetImageHeight < 1 then
		do return false end
	end
	do
		local width = -1
		local height = -1
		if self.widgetImageWidth > 0 and self.widgetImageHeight > 0 then
			width = self.widgetImageWidth
			height = self.widgetImageHeight
		elseif self.widgetImageWidth > 0 then
			width = self.widgetImageWidth
		elseif self.widgetImageHeight > 0 then
			height = self.widgetImageHeight
		else
			width = widthConstraint
		end
		if width > 0 and widthConstraint >= 0 and width > widthConstraint then
			width = widthConstraint
			height = -1
		end
		if height < 0 then
			height = _util:convert_to_integer(self.widgetImage:getPixelHeight() * width / self.widgetImage:getPixelWidth())
		end
		if width < 0 then
			width = _util:convert_to_integer(self.widgetImage:getPixelWidth() * height / self.widgetImage:getPixelHeight())
		end
		do _g.jk.widget.Widget:setLayoutSize(self, width, height) end
		self.lastLayoutWidth = _g.jk.widget.Widget:getWidth(self)
		do return true end
	end
end

function jk.widget.ImageWidget:getWidgetImageWidth()
	do return self.widgetImageWidth end
end

function jk.widget.ImageWidget:setWidgetImageWidth(v)
	self.widgetImageWidth = v
	do return self end
end

function jk.widget.ImageWidget:getWidgetImageHeight()
	do return self.widgetImageHeight end
end

function jk.widget.ImageWidget:setWidgetImageHeight(v)
	self.widgetImageHeight = v
	do return self end
end

function jk.widget.ImageWidget:getWidgetImageRounded()
	do return self.widgetImageRounded end
end

function jk.widget.ImageWidget:setWidgetImageRounded(v)
	self.widgetImageRounded = v
	do return self end
end

jk.widget.LayerWidget = _g.jk.widget.ContainerWidget._create()
jk.widget.LayerWidget.__index = jk.widget.LayerWidget
_vm:set_metatable(jk.widget.LayerWidget, {
	__index = _g.jk.widget.ContainerWidget
})

function jk.widget.LayerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.LayerWidget)
	return v
end

function jk.widget.LayerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.LayerWidget'
	self['_isType.jk.widget.LayerWidget'] = true
	self.widgetMouseOver = nil
	self.widgetMouseOut = nil
	self.widgetMarginLeft = 0
	self.widgetMarginRight = 0
	self.widgetMarginTop = 0
	self.widgetMarginBottom = 0
	self.widgetWidthRequest = 0
	self.widgetHeightRequest = 0
	self.widgetMinimumHeightRequest = 0
	self.widgetMaximumWidthRequest = 0
end

function jk.widget.LayerWidget:_construct0()
	jk.widget.LayerWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct0(self) end
	return self
end

function jk.widget.LayerWidget:_construct1(context)
	jk.widget.LayerWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct1(self, context) end
	return self
end

function jk.widget.LayerWidget:findTopMostLayerWidget(widget)
	local v = nil
	local pp = widget
	while pp ~= nil do
		if (_vm:to_table_with_key(pp, '_isType.jk.widget.LayerWidget') ~= nil) then
			v = pp
		end
		pp = _g.jk.widget.Widget:getParent(pp)
	end
	do return v end
end

function jk.widget.LayerWidget:forContext(context)
	do return _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), context) end
end

function jk.widget.LayerWidget:forMargin(context, margin)
	local v = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), context)
	do v:setWidgetMargin(margin) end
	do return v end
end

function jk.widget.LayerWidget:forWidget(context, widget, margin)
	local v = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), context)
	do v:setWidgetMargin(margin) end
	do v:addWidget(widget) end
	do return v end
end

function jk.widget.LayerWidget:forWidgetAndWidth(context, widget, width)
	local v = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), context)
	do v:addWidget(widget) end
	do v:setWidgetWidthRequest(width) end
	do return v end
end

function jk.widget.LayerWidget:forWidgets(context, widgets, margin)
	local v = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), context)
	do v:setWidgetMargin(margin) end
	if widgets ~= nil then
		local n = 0
		local m = #widgets
		do
			n = 0
			while n < m do
				local widget = widgets[n + 1]
				if widget ~= nil then
					do v:addWidget(widget) end
				end
				do n = n + 1 end
			end
		end
	end
	do return v end
end

function jk.widget.LayerWidget:setWidgetMaximumWidthRequest(width)
	self.widgetMaximumWidthRequest = width
	if _g.jk.widget.Widget:getWidth(self) > width then
		do _g.jk.widget.Widget:onLayoutChanged(self) end
	end
	do return self end
end

function jk.widget.LayerWidget:getWidgetMaximumWidthRequest()
	do return self.widgetMaximumWidthRequest end
end

function jk.widget.LayerWidget:setWidgetWidthRequest(request)
	self.widgetWidthRequest = request
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.LayerWidget:getWidgetWidthRequest()
	do return self.widgetWidthRequest end
end

function jk.widget.LayerWidget:setWidgetHeightRequest(request)
	self.widgetHeightRequest = request
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.LayerWidget:getWidgetHeightRequest()
	do return self.widgetHeightRequest end
end

function jk.widget.LayerWidget:setWidgetMinimumHeightRequest(request)
	self.widgetMinimumHeightRequest = request
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.LayerWidget:getWidgetMinimumHeightRequest()
	do return self.widgetMinimumHeightRequest end
end

function jk.widget.LayerWidget:setWidgetMargin(margin)
	self.widgetMarginLeft = margin
	self.widgetMarginRight = margin
	self.widgetMarginTop = margin
	self.widgetMarginBottom = margin
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.LayerWidget:getWidgetMarginLeft()
	do return self.widgetMarginLeft end
end

function jk.widget.LayerWidget:setWidgetMarginLeft(value)
	self.widgetMarginLeft = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.LayerWidget:getWidgetMarginRight()
	do return self.widgetMarginRight end
end

function jk.widget.LayerWidget:setWidgetMarginRight(value)
	self.widgetMarginRight = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.LayerWidget:getWidgetMarginTop()
	do return self.widgetMarginTop end
end

function jk.widget.LayerWidget:setWidgetMarginTop(value)
	self.widgetMarginTop = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.LayerWidget:getWidgetMarginBottom()
	do return self.widgetMarginBottom end
end

function jk.widget.LayerWidget:setWidgetMarginBottom(value)
	self.widgetMarginBottom = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.LayerWidget:onWidgetHeightChanged(height)
	do _g.jk.widget.ContainerWidget.onWidgetHeightChanged(self, height) end
	do
		local mh = height - self.widgetMarginTop - self.widgetMarginBottom
		local array = _g.jk.widget.Widget:getChildren(self)
		if array ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(array)
			do
				n = 0
				while n < m do
					local child = array[n + 1]
					if child ~= nil then
						do _g.jk.widget.Widget:resizeHeight(child, mh) end
					end
					do n = n + 1 end
				end
			end
		end
	end
end

function jk.widget.LayerWidget:computeWidgetLayout(widthConstraint)
	local wc = widthConstraint
	if wc < 0 and self.widgetWidthRequest > 0 then
		wc = self.widgetWidthRequest
	end
	if wc >= 0 then
		wc = wc - self.widgetMarginLeft - self.widgetMarginRight
		if wc < 0 then
			wc = 0
		end
	end
	do
		local mw = 0
		local mh = 0
		local array = _g.jk.widget.Widget:getChildren(self)
		if array ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(array)
			do
				n = 0
				while n < m do
					local child = array[n + 1]
					if child ~= nil then
						do _g.jk.widget.Widget:layout(child, wc, false) end
						do _g.jk.widget.Widget:move(child, self.widgetMarginLeft, self.widgetMarginTop) end
						do
							local cw = _g.jk.widget.Widget:getWidth(child)
							if wc < 0 and self.widgetMaximumWidthRequest > 0 and cw + self.widgetMarginLeft + self.widgetMarginRight > self.widgetMaximumWidthRequest then
								do _g.jk.widget.Widget:layout(child, self.widgetMaximumWidthRequest - self.widgetMarginLeft - self.widgetMarginRight, false) end
								cw = _g.jk.widget.Widget:getWidth(child)
							end
							do
								local ch = _g.jk.widget.Widget:getHeight(child)
								if cw > mw then
									mw = cw
								end
								if ch > mh then
									mh = ch
								end
							end
						end
					end
					do n = n + 1 end
				end
			end
		end
		do
			local fw = widthConstraint
			if self.widgetWidthRequest > 0 and mw <= 0 then
				fw = self.widgetWidthRequest
			end
			if fw < 0 then
				fw = mw + self.widgetMarginLeft + self.widgetMarginRight
			end
			do
				local fh = mh + self.widgetMarginTop + self.widgetMarginBottom
				if self.widgetHeightRequest > 0 then
					fh = self.widgetHeightRequest
				end
				if self.widgetMinimumHeightRequest > 0 and fh < self.widgetMinimumHeightRequest then
					fh = self.widgetMinimumHeightRequest
				end
				do _g.jk.widget.Widget:setLayoutSize(self, fw, fh) end
				mw = _g.jk.widget.Widget:getWidth(self) - self.widgetMarginLeft - self.widgetMarginRight
				mh = _g.jk.widget.Widget:getHeight(self) - self.widgetMarginTop - self.widgetMarginBottom
				do
					local array2 = _g.jk.widget.Widget:getChildren(self)
					if array2 ~= nil then
						local n2 = 0
						local m2 = _g.jk.lang.Vector:getSize(array2)
						do
							n2 = 0
							while n2 < m2 do
								local child = array2[n2 + 1]
								if child ~= nil then
									if wc < 0 then
										do _g.jk.widget.Widget:layout(child, mw, false) end
									end
									do _g.jk.widget.Widget:resizeHeight(child, mh) end
								end
								do n2 = n2 + 1 end
							end
						end
					end
				end
			end
		end
	end
end

function jk.widget.LayerWidget:removeAllChildren()
	do _g.jk.widget.Widget:removeChildrenOf(self) end
end

function jk.widget.LayerWidget:getChildWidget(index)
	local children = _g.jk.widget.Widget:getChildren(self)
	if not (children ~= nil) then
		do return nil end
	end
	do return _g.jk.lang.Vector:get(children, index) end
end

function jk.widget.LayerWidget:getWidgetMouseOver()
	do return self.widgetMouseOver end
end

function jk.widget.LayerWidget:setWidgetMouseOver(v)
	self.widgetMouseOver = v
	do return self end
end

function jk.widget.LayerWidget:getWidgetMouseOut()
	do return self.widgetMouseOut end
end

function jk.widget.LayerWidget:setWidgetMouseOut(v)
	self.widgetMouseOut = v
	do return self end
end

jk.widget.Menu = {}
jk.widget.Menu.__index = jk.widget.Menu
_vm:set_metatable(jk.widget.Menu, {})

function jk.widget.Menu._create()
	local v = _vm:set_metatable({}, jk.widget.Menu)
	return v
end

function jk.widget.Menu:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.Menu'
	self['_isType.jk.widget.Menu'] = true
	self.entries = nil
end

function jk.widget.Menu:_construct0()
	jk.widget.Menu._init(self)
	return self
end

jk.widget.Menu.Entry = {}
jk.widget.Menu.Entry.__index = jk.widget.Menu.Entry
_vm:set_metatable(jk.widget.Menu.Entry, {})

function jk.widget.Menu.Entry._create()
	local v = _vm:set_metatable({}, jk.widget.Menu.Entry)
	return v
end

function jk.widget.Menu.Entry:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.Menu.Entry'
	self['_isType.jk.widget.Menu.Entry'] = true
	self.title = nil
	self.handler = nil
end

function jk.widget.Menu.Entry:_construct0()
	jk.widget.Menu.Entry._init(self)
	return self
end

function jk.widget.Menu:addEntry1(entry)
	if not (entry ~= nil) then
		do return end
	end
	if not (self.entries ~= nil) then
		self.entries = {}
	end
	do _g.jk.lang.Vector:append(self.entries, entry) end
end

function jk.widget.Menu:addEntry2(title, handler)
	local e = _g.jk.widget.Menu.Entry._construct0(_g.jk.widget.Menu.Entry._create())
	e.title = title
	e.handler = handler
	do self:addEntry1(e) end
end

function jk.widget.Menu:getEntries()
	do return self.entries end
end

function jk.widget.Menu:setEntries(v)
	self.entries = v
	do return self end
end

jk.widget.TitledWidget = {}

jk.widget.LayerWithBackgroundColorWidget = _g.jk.widget.LayerWidget._create()
jk.widget.LayerWithBackgroundColorWidget.__index = jk.widget.LayerWithBackgroundColorWidget
_vm:set_metatable(jk.widget.LayerWithBackgroundColorWidget, {
	__index = _g.jk.widget.LayerWidget
})

jk.widget.LayerWithBackgroundColorWidget.TOP_SIDE = 0
jk.widget.LayerWithBackgroundColorWidget.LEFT_SIDE = 1
jk.widget.LayerWithBackgroundColorWidget.BOTTOM_SIDE = 2
jk.widget.LayerWithBackgroundColorWidget.RIGHT_SIDE = 3

function jk.widget.LayerWithBackgroundColorWidget._create()
	local v = _vm:set_metatable({}, jk.widget.LayerWithBackgroundColorWidget)
	return v
end

function jk.widget.LayerWithBackgroundColorWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.LayerWithBackgroundColorWidget'
	self['_isType.jk.widget.LayerWithBackgroundColorWidget'] = true
	self.canvas = nil
	self.widgetColor = nil
	self.widgetOutlineColor = _g.jk.gfx.Color:black()
	self.widgetOutlineWidth = 0
	self.widgetBorderStyle = 0
	self.widgetTopLeftRadius = 0.0
	self.widgetTopRightRadius = 0.0
	self.widgetBottomRightRadius = 0.0
	self.widgetBottomLeftRadius = 0.0
	self.widgetBorderLeftWidth = -1
	self.widgetBorderRightWidth = -1
	self.widgetBorderTopWidth = -1
	self.widgetBorderBottomWidth = -1
	self.widgetBorderLeftColor = _g.jk.gfx.Color:black()
	self.widgetBorderRightColor = _g.jk.gfx.Color:black()
	self.widgetBorderTopColor = _g.jk.gfx.Color:black()
	self.widgetBorderBottomColor = _g.jk.gfx.Color:black()
	self.widgetBorderLeftStyle = 0
	self.widgetBorderRightStyle = 0
	self.widgetBorderTopStyle = 0
	self.widgetBorderBottomStyle = 0
end

function jk.widget.LayerWithBackgroundColorWidget:_construct0()
	jk.widget.LayerWithBackgroundColorWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.LayerWithBackgroundColorWidget:_construct1(ctx)
	jk.widget.LayerWithBackgroundColorWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, ctx) end
	do self:addWidget((function()
		self.canvas = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), ctx)
		do return self.canvas end
	end)()) end
	return self
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetColor(color)
	self.widgetColor = color
	if not (self.canvas ~= nil) then
		do return nil end
	end
	do self.canvas:setWidgetColor(color) end
	do return self end
end

function jk.widget.LayerWithBackgroundColorWidget:getWidgetColor()
	do return self.widgetColor end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetOutlineColor(color)
	self.widgetOutlineColor = color
	do self:updateWidgetBorder(-1, self.widgetOutlineWidth, self.widgetOutlineColor, self.widgetBorderStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:getWidgetOutlineColor()
	do return self.widgetOutlineColor end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetOutlineWidth(width)
	self.widgetOutlineWidth = width
	do self:updateWidgetBorder(-1, self.widgetOutlineWidth, self.widgetOutlineColor, self.widgetBorderStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:getWidgetOutlineWidth()
	do return self.widgetOutlineWidth end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetBorderLeftWidth(sz)
	self.widgetBorderLeftWidth = sz
	do self:updateWidgetBorder(_g.jk.widget.LayerWithBackgroundColorWidget.LEFT_SIDE, self.widgetBorderLeftWidth, self.widgetBorderLeftColor, self.widgetBorderLeftStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetBorderRightWidth(sz)
	self.widgetBorderRightWidth = sz
	do self:updateWidgetBorder(_g.jk.widget.LayerWithBackgroundColorWidget.RIGHT_SIDE, self.widgetBorderRightWidth, self.widgetBorderRightColor, self.widgetBorderRightStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetBorderTopWidth(sz)
	self.widgetBorderTopWidth = sz
	do self:updateWidgetBorder(_g.jk.widget.LayerWithBackgroundColorWidget.TOP_SIDE, self.widgetBorderTopWidth, self.widgetBorderTopColor, self.widgetBorderTopStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetBorderBottomWidth(sz)
	self.widgetBorderBottomWidth = sz
	do self:updateWidgetBorder(_g.jk.widget.LayerWithBackgroundColorWidget.BOTTOM_SIDE, self.widgetBorderBottomWidth, self.widgetBorderBottomColor, self.widgetBorderBottomStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetBorderBottomColor(color)
	self.widgetBorderBottomColor = color
	do self:updateWidgetBorder(_g.jk.widget.LayerWithBackgroundColorWidget.BOTTOM_SIDE, self.widgetBorderBottomWidth, self.widgetBorderBottomColor, self.widgetBorderBottomStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetBorderTopColor(color)
	self.widgetBorderTopColor = color
	do self:updateWidgetBorder(_g.jk.widget.LayerWithBackgroundColorWidget.TOP_SIDE, self.widgetBorderTopWidth, self.widgetBorderTopColor, self.widgetBorderTopStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetBorderRightColor(color)
	self.widgetBorderRightColor = color
	do self:updateWidgetBorder(_g.jk.widget.LayerWithBackgroundColorWidget.RIGHT_SIDE, self.widgetBorderRightWidth, self.widgetBorderRightColor, self.widgetBorderRightStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetBorderLeftColor(color)
	self.widgetBorderLeftColor = color
	do self:updateWidgetBorder(_g.jk.widget.LayerWithBackgroundColorWidget.LEFT_SIDE, self.widgetBorderLeftWidth, self.widgetBorderLeftColor, self.widgetBorderLeftStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetBorderStyle(style)
	self.widgetBorderStyle = style
	do self:updateWidgetBorder(-1, self.widgetOutlineWidth, self.widgetOutlineColor, self.widgetBorderStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetBorderLeftStyle(style)
	self.widgetBorderLeftStyle = style
	do self:updateWidgetBorder(_g.jk.widget.LayerWithBackgroundColorWidget.LEFT_SIDE, self.widgetBorderLeftWidth, self.widgetBorderLeftColor, self.widgetBorderLeftStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetBorderRightStyle(style)
	self.widgetBorderRightStyle = style
	do self:updateWidgetBorder(_g.jk.widget.LayerWithBackgroundColorWidget.RIGHT_SIDE, self.widgetBorderRightWidth, self.widgetBorderRightColor, self.widgetBorderRightStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetBorderTopStyle(style)
	self.widgetBorderTopStyle = style
	do self:updateWidgetBorder(_g.jk.widget.LayerWithBackgroundColorWidget.TOP_SIDE, self.widgetBorderTopWidth, self.widgetBorderTopColor, self.widgetBorderTopStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetBorderBottomStyle(style)
	self.widgetBorderBottomStyle = style
	do self:updateWidgetBorder(_g.jk.widget.LayerWithBackgroundColorWidget.BOTTOM_SIDE, self.widgetBorderBottomWidth, self.widgetBorderBottomColor, self.widgetBorderBottomStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:updateWidgetBorder(borderSide, borderWidth, borderColor, borderStyle)
	do self.canvas:setWidgetOutlineColor(borderColor) end
	do self.canvas:setWidgetOutlineWidth(borderWidth) end
	do self.canvas:setWidgetBorderStyle(borderStyle) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetRoundingRadiusTopLeft(radius)
	self.widgetTopLeftRadius = radius
	do self:updateCanvasRoundingRadius() end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetRoundingRadiusTopRight(radius)
	self.widgetTopRightRadius = radius
	do self:updateCanvasRoundingRadius() end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetRoundingRadiusBottomLeft(radius)
	self.widgetBottomLeftRadius = radius
	do self:updateCanvasRoundingRadius() end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetRoundingRadiusBottomRight(radius)
	self.widgetBottomRightRadius = radius
	do self:updateCanvasRoundingRadius() end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetRoundingRadius1(radius)
	do self:setWidgetRoundingRadius3(radius, radius, radius, radius) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetRoundingRadius2(lradius, rradius)
	do self:setWidgetRoundingRadius3(lradius, rradius, rradius, lradius) end
end

function jk.widget.LayerWithBackgroundColorWidget:setWidgetRoundingRadius3(tlradius, trradius, brradius, blradius)
	self.widgetTopLeftRadius = tlradius
	self.widgetTopRightRadius = trradius
	self.widgetBottomRightRadius = brradius
	self.widgetBottomLeftRadius = blradius
	do self:updateCanvasRoundingRadius() end
end

function jk.widget.LayerWithBackgroundColorWidget:updateCanvasRoundingRadius()
	local isRounded = true
	if self.widgetTopLeftRadius <= 0.0 and self.widgetTopRightRadius <= 0.0 and self.widgetBottomRightRadius <= 0.0 and self.widgetBottomLeftRadius <= 0.0 then
		isRounded = false
	end
	if self.canvas ~= nil then
		do self.canvas:setWidgetRoundingRadius3(self.widgetTopLeftRadius, self.widgetTopRightRadius, self.widgetBottomRightRadius, self.widgetBottomLeftRadius) end
	end
end

jk.widget.HorizontalScrollerWidget = {}
jk.widget.HorizontalScrollerWidget.__index = jk.widget.HorizontalScrollerWidget
_vm:set_metatable(jk.widget.HorizontalScrollerWidget, {})

function jk.widget.HorizontalScrollerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.HorizontalScrollerWidget)
	return v
end

function jk.widget.HorizontalScrollerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.HorizontalScrollerWidget'
	self['_isType.jk.widget.HorizontalScrollerWidget'] = true
	self['_isType.jk.widget.WidgetWithLayout'] = true
	self.onScrolledHandler = nil
	self.layoutWidth = -1
end

function jk.widget.HorizontalScrollerWidget:_construct0()
	jk.widget.HorizontalScrollerWidget._init(self)
	return self
end

function jk.widget.HorizontalScrollerWidget:forWidget(context, widget)
	local v = _g.jk.widget.HorizontalScrollerWidget._construct1(_g.jk.widget.HorizontalScrollerWidget._create(), context)
	do v:addWidget(widget) end
	do return v end
end

function jk.widget.HorizontalScrollerWidget:_construct1(context)
	jk.widget.HorizontalScrollerWidget._init(self)
	return self
end

function jk.widget.HorizontalScrollerWidget:setWidgetLayoutChanged()
end

function jk.widget.HorizontalScrollerWidget:hasWidgetLayoutChanged()
	do return false end
end

function jk.widget.HorizontalScrollerWidget:layoutWidget(widthConstraint, force)
	local mw = 0
	local mh = 0
	local array = _g.jk.widget.Widget:getChildren(self)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local child = array[n + 1]
				if child ~= nil then
					do _g.jk.widget.Widget:move(child, 0, 0) end
					do _g.jk.widget.Widget:layout(child, -1, false) end
					do
						local childWidth = _g.jk.widget.Widget:getWidth(child)
						local childHeight = _g.jk.widget.Widget:getHeight(child)
						if childWidth > mw then
							mw = childWidth
						end
						if childHeight > mh then
							mh = childHeight
						end
					end
				end
				do n = n + 1 end
			end
		end
	end
	self.layoutWidth = mw
	if widthConstraint < 0 then
		do _g.jk.widget.Widget:setLayoutSize(self, mw, mh) end
	else
		do _g.jk.widget.Widget:setLayoutSize(self, widthConstraint, mh) end
	end
	do return true end
end

function jk.widget.HorizontalScrollerWidget:addWidget(widget)
	do _g.jk.widget.Widget:addChild(self, widget) end
	do return self end
end

function jk.widget.HorizontalScrollerWidget:setWidgetScrollBarDisabled(value)
end

function jk.widget.HorizontalScrollerWidget:getOnScrolledHandler()
	do return self.onScrolledHandler end
end

function jk.widget.HorizontalScrollerWidget:setOnScrolledHandler(v)
	self.onScrolledHandler = v
	do return self end
end

jk.widget.SwitcherWidget = _g.jk.widget.LayerWidget._create()
jk.widget.SwitcherWidget.__index = jk.widget.SwitcherWidget
_vm:set_metatable(jk.widget.SwitcherWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.SwitcherWidget._create()
	local v = _vm:set_metatable({}, jk.widget.SwitcherWidget)
	return v
end

function jk.widget.SwitcherWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.SwitcherWidget'
	self['_isType.jk.widget.SwitcherWidget'] = true
end

function jk.widget.SwitcherWidget:_construct0()
	jk.widget.SwitcherWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.SwitcherWidget:_construct1(context)
	jk.widget.SwitcherWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function jk.widget.SwitcherWidget:replaceWith(widget)
	do self:removeAllChildren() end
	if widget ~= nil then
		do _g.jk.widget.LayerWidget.addWidget(self, widget) end
		if widget ~= nil and (_vm:to_table_with_key(widget, '_isType.jk.widget.DisplayAwareWidget') ~= nil) then
			do widget:onWidgetDisplayed() end
		end
	end
end

function jk.widget.SwitcherWidget:addWidget(widget)
	do _g.jk.widget.LayerWidget.addWidget(self, widget) end
	do _g.jk.widget.Widget:setVisible(widget, false) end
	do return self end
end

function jk.widget.SwitcherWidget:showWidget(widget)
	local array = _g.jk.widget.Widget:getChildren(self)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local ww = array[n + 1]
				if ww ~= nil then
					if ww ~= widget then
						do _g.jk.widget.Widget:setVisible(ww, false) end
					end
				end
				do n = n + 1 end
			end
		end
	end
	if widget ~= nil then
		do _g.jk.widget.Widget:setVisible(widget, true) end
		if (_vm:to_table_with_key(widget, '_isType.jk.widget.DisplayAwareWidget') ~= nil) then
			do widget:onWidgetDisplayed() end
		end
	end
end

function jk.widget.SwitcherWidget:showWidgetWithIndex(index)
	do self:showWidget(_g.jk.lang.Vector:get(_g.jk.widget.Widget:getChildren(self), index)) end
end

jk.widget.ScreenForWidget = {}
jk.widget.ScreenForWidget.__index = jk.widget.ScreenForWidget
_vm:set_metatable(jk.widget.ScreenForWidget, {})

function jk.widget.ScreenForWidget._create()
	local v = _vm:set_metatable({}, jk.widget.ScreenForWidget)
	return v
end

function jk.widget.ScreenForWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.ScreenForWidget'
	self['_isType.jk.widget.ScreenForWidget'] = true
	self['_isType.jk.ui.ScreenWithContext'] = true
	self.captureBrowserBackButton = true
	self.context = nil
	self.myWidget = nil
	self.keyEvent = nil
end

function jk.widget.ScreenForWidget:_construct0()
	jk.widget.ScreenForWidget._init(self)
	return self
end

function jk.widget.ScreenForWidget:findScreenForWidget(widget)
	do return _vm:to_table_with_key(_g.jk.widget.Widget:findScreen(widget), '_isType.jk.widget.ScreenForWidget') end
end

function jk.widget.ScreenForWidget:onBackKeyPressEvent()
	if not (self.keyEvent ~= nil) then
		self.keyEvent = _g.jk.ui.KeyEvent._construct0(_g.jk.ui.KeyEvent._create())
	end
	do self.keyEvent:clear() end
	do self.keyEvent:setAction(_g.jk.ui.KeyEvent.ACTION_DOWN) end
	do self.keyEvent:setKeyCode(_g.jk.ui.KeyEvent.KEY_BACK) end
	do self:deliverKeyEventToWidget(self.keyEvent, self:getWidget()) end
end

function jk.widget.ScreenForWidget:deliverKeyEventToWidget(event, widget)
	if not (widget ~= nil) then
		do return end
	end
	do
		local array = _g.jk.widget.Widget:getChildren(widget)
		if array ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(array)
			do
				n = 0
				while n < m do
					local child = array[n + 1]
					if child ~= nil then
						do self:deliverKeyEventToWidget(event, child) end
						if event.isConsumed then
							do return end
						end
					end
					do n = n + 1 end
				end
			end
		end
		do
			local kl = _vm:to_table_with_key(widget, '_isType.jk.ui.KeyListener')
			if kl ~= nil then
				do kl:onKeyEvent(event) end
				if event.isConsumed then
					do return end
				end
			end
		end
	end
end

function jk.widget.ScreenForWidget:unlockOrientation()
	_io:write_to_stdout("[jk.widget.ScreenForWidget.unlockOrientation] (ScreenForWidget.sling:704:3): Not implemented" .. "\n")
end

function jk.widget.ScreenForWidget:lockToLandscapeOrientation()
	_io:write_to_stdout("[jk.widget.ScreenForWidget.lockToLandscapeOrientation] (ScreenForWidget.sling:731:3): Not implemented" .. "\n")
end

function jk.widget.ScreenForWidget:lockToPortraitOrientation()
	_io:write_to_stdout("[jk.widget.ScreenForWidget.lockToPortraitOrientation] (ScreenForWidget.sling:758:3): Not implemented" .. "\n")
end

function jk.widget.ScreenForWidget:setContext(context)
	self.context = context
end

function jk.widget.ScreenForWidget:getContext()
	do return self.context end
end

function jk.widget.ScreenForWidget:createContext()
	local v = nil
	_io:write_to_stdout("[jk.widget.ScreenForWidget.createContext] (ScreenForWidget.sling:788:3): Not implemented" .. "\n")
	do return v end
end

function jk.widget.ScreenForWidget:onPrepareScreen()
end

function jk.widget.ScreenForWidget:onStartScreen()
	do _g.jk.widget.Widget:notifyOnStartScreen(self.myWidget, self) end
end

function jk.widget.ScreenForWidget:onStartScreenWithData(data)
end

function jk.widget.ScreenForWidget:onStopScreen()
	do _g.jk.widget.Widget:notifyOnStopScreen(self.myWidget, self) end
end

function jk.widget.ScreenForWidget:onDestroyScreen()
end

function jk.widget.ScreenForWidget:initialize()
	if self.context == nil then
		self.context = self:createContext()
	end
end

function jk.widget.ScreenForWidget:cleanup()
end

function jk.widget.ScreenForWidget:getWidget()
	do return self.myWidget end
end

function jk.widget.ScreenForWidget:setWidget(widget)
	if not not (self.myWidget ~= nil) then
		_io:write_to_stdout("[jk.widget.ScreenForWidget.setWidget] (ScreenForWidget.sling:850:3): Multiple calls to setWidget()" .. "\n")
		do return end
	end
	if not (widget ~= nil) then
		do return end
	end
	self.myWidget = widget
	do widget:setAllowResize(false) end
	_io:write_to_stdout("[jk.widget.ScreenForWidget.setWidget] (ScreenForWidget.sling:897:3): Not implemented" .. "\n")
	do _g.jk.widget.Widget:notifyOnAddedToScreen(widget, self) end
end

function jk.widget.ScreenForWidget:getCaptureBrowserBackButton()
	do return self.captureBrowserBackButton end
end

function jk.widget.ScreenForWidget:setCaptureBrowserBackButton(v)
	self.captureBrowserBackButton = v
	do return self end
end

jk.widget.ResponsiveWidget = _g.jk.widget.LayerWithBackgroundColorWidget._create()
jk.widget.ResponsiveWidget.__index = jk.widget.ResponsiveWidget
_vm:set_metatable(jk.widget.ResponsiveWidget, {
	__index = _g.jk.widget.LayerWithBackgroundColorWidget
})

function jk.widget.ResponsiveWidget._create()
	local v = _vm:set_metatable({}, jk.widget.ResponsiveWidget)
	return v
end

function jk.widget.ResponsiveWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.ResponsiveWidget'
	self['_isType.jk.widget.ResponsiveWidget'] = true
	self['_isType.jk.widget.ResizeAwareWidget'] = true
	self.widgetNarrowWidth = 0
	self.isNarrowInitialized = false
	self.isWideInitialized = false
end

function jk.widget.ResponsiveWidget:_construct0()
	jk.widget.ResponsiveWidget._init(self)
	do _g.jk.widget.LayerWithBackgroundColorWidget._construct0(self) end
	return self
end

function jk.widget.ResponsiveWidget:_construct1(ctx)
	jk.widget.ResponsiveWidget._init(self)
	do _g.jk.widget.LayerWithBackgroundColorWidget._construct1(self, ctx) end
	return self
end

function jk.widget.ResponsiveWidget:onWidgetResized()
	if self.widgetNarrowWidth <= 0 then
		self.widgetNarrowWidth = self.context:getHeightValue("150mm")
	end
	do
		local width = _g.jk.widget.Widget:getWidth(self)
		if width < self.widgetNarrowWidth and not self.isNarrowInitialized then
			do self:onNarrowLayout() end
			self.isNarrowInitialized = true
			self.isWideInitialized = false
		elseif width > self.widgetNarrowWidth and not self.isWideInitialized then
			do self:onWideLayout() end
			self.isWideInitialized = true
			self.isNarrowInitialized = false
		end
	end
end

function jk.widget.ResponsiveWidget:onNarrowLayout()
	do self:checkForNarrow(self) end
end

function jk.widget.ResponsiveWidget:onWideLayout()
	do self:checkForWide(self) end
end

function jk.widget.ResponsiveWidget:checkForNarrow(widget)
	if (_vm:to_table_with_key(widget, '_isType.jk.widget.ResponsiveAwareWidget') ~= nil) then
		do _vm:to_table_with_key(widget, '_isType.jk.widget.ResponsiveAwareWidget'):doNarrowLayout() end
	end
	if (_vm:to_table_with_key(widget, '_isType.jk.widget.ContainerWidget') ~= nil) or (_vm:to_table_with_key(widget, '_isType.jk.widget.VerticalScrollerWidget') ~= nil) then
		local children = _g.jk.widget.Widget:getChildren(widget)
		if children ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(children)
			do
				n = 0
				while n < m do
					local child = children[n + 1]
					if child ~= nil then
						do self:checkForNarrow(child) end
					end
					do n = n + 1 end
				end
			end
		end
	end
end

function jk.widget.ResponsiveWidget:checkForWide(widget)
	if (_vm:to_table_with_key(widget, '_isType.jk.widget.ResponsiveAwareWidget') ~= nil) then
		do _vm:to_table_with_key(widget, '_isType.jk.widget.ResponsiveAwareWidget'):doWideLayout() end
	end
	if (_vm:to_table_with_key(widget, '_isType.jk.widget.ContainerWidget') ~= nil) or (_vm:to_table_with_key(widget, '_isType.jk.widget.VerticalScrollerWidget') ~= nil) then
		local children = _g.jk.widget.Widget:getChildren(widget)
		if children ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(children)
			do
				n = 0
				while n < m do
					local child = children[n + 1]
					if child ~= nil then
						do self:checkForWide(child) end
					end
					do n = n + 1 end
				end
			end
		end
	end
end

function jk.widget.ResponsiveWidget:getWidgetNarrowWidth()
	do return self.widgetNarrowWidth end
end

function jk.widget.ResponsiveWidget:setWidgetNarrowWidth(v)
	self.widgetNarrowWidth = v
	do return self end
end

function jk.widget.ResponsiveWidget:getIsNarrowInitialized()
	do return self.isNarrowInitialized end
end

function jk.widget.ResponsiveWidget:setIsNarrowInitialized(v)
	self.isNarrowInitialized = v
	do return self end
end

function jk.widget.ResponsiveWidget:getIsWideInitialized()
	do return self.isWideInitialized end
end

function jk.widget.ResponsiveWidget:setIsWideInitialized(v)
	self.isWideInitialized = v
	do return self end
end

jk.widget.ScreenAwareWidget = {}

jk.widget.LabelWidget = _g.jk.widget.Widget._create()
jk.widget.LabelWidget.__index = jk.widget.LabelWidget
_vm:set_metatable(jk.widget.LabelWidget, {
	__index = _g.jk.widget.Widget
})

jk.widget.LabelWidget.ALIGN_LEFT = 0
jk.widget.LabelWidget.ALIGN_CENTER = 1
jk.widget.LabelWidget.ALIGN_RIGHT = 2
jk.widget.LabelWidget.ALIGN_JUSTIFY = 3
jk.widget.LabelWidget.WORD_WRAP = 0
jk.widget.LabelWidget.NO_WRAP = 1

function jk.widget.LabelWidget._create()
	local v = _vm:set_metatable({}, jk.widget.LabelWidget)
	return v
end

function jk.widget.LabelWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.LabelWidget'
	self['_isType.jk.widget.LabelWidget'] = true
	self.widgetContext = nil
	self.widgetText = nil
	self.widgetTextColor = nil
	self.widgetFontSize = 0.0
	self.widgetFontBold = false
	self.widgetFontFamily = nil
	self.widgetFontResource = nil
	self.widgetTextAlign = 0
	self.widgetFontUnderline = false
	self.widgetFontItalic = false
	self.widgetPaddingLeft = 0
	self.widgetPaddingTop = 0
	self.widgetPaddingRight = 0
	self.widgetPaddingBottom = 0
	self.widgetMaximumNumberOfLines = 0
end

function jk.widget.LabelWidget:_construct0()
	jk.widget.LabelWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	return self
end

function jk.widget.LabelWidget:forText(context, text)
	local v = _g.jk.widget.LabelWidget._construct1(_g.jk.widget.LabelWidget._create(), context)
	do v:setWidgetText(text) end
	do return v end
end

function jk.widget.LabelWidget:_construct1(context)
	jk.widget.LabelWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	self.widgetContext = context
	do self:setWidgetStyle("LabelWidget") end
	return self
end

function jk.widget.LabelWidget:setWidgetText(text)
	self.widgetText = text
	if not (self.widgetText ~= nil) then
		self.widgetText = ""
	end
	_io:write_to_stdout("[jk.widget.LabelWidget.setWidgetText] (LabelWidget.sling:199:3): Not implemented" .. "\n")
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.LabelWidget:getWidgetText()
	do return self.widgetText end
end

function jk.widget.LabelWidget:setWidgetTextAlign(align)
	self.widgetTextAlign = align
	_io:write_to_stdout("[jk.widget.LabelWidget.setWidgetTextAlign] (LabelWidget.sling:379:3): Not implemented" .. "\n")
	do return self end
end

function jk.widget.LabelWidget:getWidgetTextAlign()
	do return self.widgetTextAlign end
end

function jk.widget.LabelWidget:setWidgetWordWrapping(wrap)
	if wrap == _g.jk.widget.LabelWidget.NO_WRAP then
		_io:write_to_stdout("[jk.widget.LabelWidget.setWidgetWordWrapping] (LabelWidget.sling:421:4): Not implemented" .. "\n")
	elseif wrap == _g.jk.widget.LabelWidget.WORD_WRAP then
		_io:write_to_stdout("[jk.widget.LabelWidget.setWidgetWordWrapping] (LabelWidget.sling:482:4): Not implemented" .. "\n")
	end
	do return self end
end

function jk.widget.LabelWidget:setWidgetTextColor(color)
	self.widgetTextColor = color
	do self:updateWidgetFont(false) end
	do return self end
end

function jk.widget.LabelWidget:getWidgetTextColor()
	do return self.widgetTextColor end
end

function jk.widget.LabelWidget:setWidgetFontSize(fontSize)
	self.widgetFontSize = fontSize
	do self:updateWidgetFont(true) end
	do return self end
end

function jk.widget.LabelWidget:getFontSize()
	do return self.widgetFontSize end
end

function jk.widget.LabelWidget:setWidgetFontBold(bold)
	self.widgetFontBold = bold
	do self:updateWidgetFont(true) end
	do return self end
end

function jk.widget.LabelWidget:setWidgetFontUnderline(underline)
	self.widgetFontUnderline = underline
	do self:updateWidgetFont(true) end
	do return self end
end

function jk.widget.LabelWidget:setWidgetFontItalic(italic)
	self.widgetFontItalic = italic
	do self:updateWidgetFont(true) end
	do return self end
end

function jk.widget.LabelWidget:setWidgetFontFamily(font)
	self.widgetFontFamily = font
	do self:updateWidgetFont(true) end
	do return self end
end

function jk.widget.LabelWidget:setWidgetFontResource(res)
	self.widgetFontResource = res
	do self:updateWidgetFont(true) end
	do return self end
end

function jk.widget.LabelWidget:setWidgetStyle(style)
	self.widgetFontFamily = self.widgetContext:getStyleString(style, "fontFamily", nil)
	if _g.jk.lang.String:isEmpty(self.widgetFontFamily) then
		self.widgetFontFamily = "Arial"
	end
	self.widgetFontResource = self.widgetContext:getStyleString(style, "fontResource", nil)
	self.widgetTextColor = self.widgetContext:getStyleColor(style, "textColor", nil)
	if not (self.widgetTextColor ~= nil) then
		self.widgetTextColor = _g.jk.gfx.Color:forRGB(0, 0, 0)
	end
	self.widgetFontSize = self.widgetContext:getStylePixels(style, "fontSize", nil)
	if self.widgetFontSize < 1.0 then
		self.widgetFontSize = self.widgetContext:getHeightValue("3mm")
	end
	self.widgetFontBold = _g.jk.lang.Boolean:asBoolean(self.widgetContext:getStyleString(style, "fontBold", nil), false)
	do self:setWidgetPadding1(self.widgetContext:getStylePixels(style, "padding", nil)) end
	do self:updateWidgetFont(true) end
	do return self end
end

function jk.widget.LabelWidget:updateWidgetFont(changesLayout)
	local fs = self.widgetFontSize
	if fs < 1.0 then
		fs = 1.0
	end
	_io:write_to_stdout("[jk.widget.LabelWidget.updateWidgetFont] (LabelWidget.sling:732:3): Not implemented" .. "\n")
	if changesLayout then
		do _g.jk.widget.Widget:onLayoutChanged(self) end
	end
end

function jk.widget.LabelWidget:setWidgetPadding1(padding)
	do return self:setWidgetPadding2(padding, padding, padding, padding) end
end

function jk.widget.LabelWidget:setWidgetPaddingLeft(value)
	do return self:setWidgetPadding2(value, self.widgetPaddingTop, self.widgetPaddingRight, self.widgetPaddingBottom) end
end

function jk.widget.LabelWidget:setWidgetPaddingTop(value)
	do return self:setWidgetPadding2(self.widgetPaddingLeft, value, self.widgetPaddingRight, self.widgetPaddingBottom) end
end

function jk.widget.LabelWidget:setWidgetPaddingRight(value)
	do return self:setWidgetPadding2(self.widgetPaddingLeft, self.widgetPaddingTop, value, self.widgetPaddingBottom) end
end

function jk.widget.LabelWidget:setWidgetPaddingBottom(value)
	do return self:setWidgetPadding2(self.widgetPaddingLeft, self.widgetPaddingTop, self.widgetPaddingRight, value) end
end

function jk.widget.LabelWidget:setWidgetPadding2(l, t, r, b)
	if l < 0 or t < 0 or r < 0 or b < 0 then
		do return self end
	end
	if self.widgetPaddingLeft == l and self.widgetPaddingTop == t and self.widgetPaddingRight == r and self.widgetPaddingBottom == b then
		do return self end
	end
	self.widgetPaddingLeft = l
	self.widgetPaddingTop = t
	self.widgetPaddingRight = r
	self.widgetPaddingBottom = b
	do self:updateWidgetPadding() end
	do return self end
end

function jk.widget.LabelWidget:updateWidgetPadding()
	_io:write_to_stdout("[jk.widget.LabelWidget.updateWidgetPadding] (LabelWidget.sling:789:3): Not implemented" .. "\n")
end

function jk.widget.LabelWidget:getWidgetMaximumNumberOfLines()
	do return self.widgetMaximumNumberOfLines end
end

function jk.widget.LabelWidget:setWidgetMaximumNumberOfLines(v)
	self.widgetMaximumNumberOfLines = v
	do return self end
end

jk.widget.GridWidget = _g.jk.widget.ContainerWidget._create()
jk.widget.GridWidget.__index = jk.widget.GridWidget
_vm:set_metatable(jk.widget.GridWidget, {
	__index = _g.jk.widget.ContainerWidget
})

function jk.widget.GridWidget._create()
	local v = _vm:set_metatable({}, jk.widget.GridWidget)
	return v
end

function jk.widget.GridWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.GridWidget'
	self['_isType.jk.widget.GridWidget'] = true
	self.widgetCellSize = -1
	self.minimumCols = 2
	self.maximumCols = 0
	self.widgetSpacing = 0
	self.widgetMargin = 0
end

function jk.widget.GridWidget:_construct0()
	jk.widget.GridWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct0(self) end
	return self
end

function jk.widget.GridWidget:_construct1(context)
	jk.widget.GridWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct1(self, context) end
	return self
end

function jk.widget.GridWidget:forContext(context)
	do return _g.jk.widget.GridWidget._construct1(_g.jk.widget.GridWidget._create(), context) end
end

function jk.widget.GridWidget:computeWidgetLayout(widthConstraint)
	local rows = 0
	local cols = 0
	local children = _g.jk.widget.Widget:getChildren(self)
	if children == nil then
		do return end
	end
	do
		local childCount = _g.jk.lang.Vector:getSize(children)
		if childCount < 1 then
			do return end
		end
		do
			local wcs = self.widgetCellSize
			if wcs < 1 then
				wcs = self.context:getWidthValue("25mm")
			end
			do
				local adjustWcs = false
				local mywidth = widthConstraint - self.widgetMargin - self.widgetMargin
				if widthConstraint < 0 then
					cols = childCount
				else
					cols = _util:convert_to_integer(_g.jk.math.Math:floor(_util:convert_to_integer((mywidth + self.widgetSpacing) / (wcs + self.widgetSpacing))))
					if self.minimumCols > 0 and cols < self.minimumCols then
						cols = self.minimumCols
						adjustWcs = true
					elseif childCount >= cols then
						adjustWcs = true
					end
				end
				if adjustWcs then
					wcs = _util:convert_to_integer((mywidth + self.widgetSpacing) / cols) - self.widgetSpacing
				end
				if self.maximumCols > 0 and cols > self.maximumCols then
					cols = self.maximumCols
				end
				rows = _util:convert_to_integer(_g.jk.math.Math:floor(_util:convert_to_integer(childCount / cols)))
				if _util:convert_to_integer(childCount % cols) > 0 then
					do rows = rows + 1 end
				end
				do _g.jk.widget.Widget:setLayoutSize(self, self.widgetMargin + cols * wcs + (cols - 1) * self.widgetSpacing + self.widgetMargin, self.widgetMargin + rows * wcs + (rows - 1) * self.widgetSpacing + self.widgetMargin) end
				do
					local cx = 0
					local x = self.widgetMargin
					local y = self.widgetMargin
					if children ~= nil then
						local n = 0
						local m = _g.jk.lang.Vector:getSize(children)
						do
							n = 0
							while n < m do
								local child = children[n + 1]
								if child ~= nil then
									do _g.jk.widget.Widget:move(child, x, y) end
									do _g.jk.widget.Widget:layout(child, wcs, false) end
									do _g.jk.widget.Widget:resizeHeight(child, wcs) end
									x = x + wcs
									x = x + self.widgetSpacing
									do cx = cx + 1 end
									if cx >= cols then
										cx = 0
										y = y + wcs
										y = y + self.widgetSpacing
										x = self.widgetMargin
									end
								end
								do n = n + 1 end
							end
						end
					end
				end
			end
		end
	end
end

function jk.widget.GridWidget:getWidgetCellSize()
	do return self.widgetCellSize end
end

function jk.widget.GridWidget:setWidgetCellSize(v)
	self.widgetCellSize = v
	do return self end
end

function jk.widget.GridWidget:getMinimumCols()
	do return self.minimumCols end
end

function jk.widget.GridWidget:setMinimumCols(v)
	self.minimumCols = v
	do return self end
end

function jk.widget.GridWidget:getMaximumCols()
	do return self.maximumCols end
end

function jk.widget.GridWidget:setMaximumCols(v)
	self.maximumCols = v
	do return self end
end

function jk.widget.GridWidget:getWidgetSpacing()
	do return self.widgetSpacing end
end

function jk.widget.GridWidget:setWidgetSpacing(v)
	self.widgetSpacing = v
	do return self end
end

function jk.widget.GridWidget:getWidgetMargin()
	do return self.widgetMargin end
end

function jk.widget.GridWidget:setWidgetMargin(v)
	self.widgetMargin = v
	do return self end
end

jk.widget.AlignWidget = _g.jk.widget.ContainerWidget._create()
jk.widget.AlignWidget.__index = jk.widget.AlignWidget
_vm:set_metatable(jk.widget.AlignWidget, {
	__index = _g.jk.widget.ContainerWidget
})

function jk.widget.AlignWidget._create()
	local v = _vm:set_metatable({}, jk.widget.AlignWidget)
	return v
end

function jk.widget.AlignWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.AlignWidget'
	self['_isType.jk.widget.AlignWidget'] = true
	self.children = nil
	self.widgetMarginLeft = 0
	self.widgetMarginRight = 0
	self.widgetMarginTop = 0
	self.widgetMarginBottom = 0
end

function jk.widget.AlignWidget:_construct0()
	jk.widget.AlignWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct0(self) end
	return self
end

jk.widget.AlignWidget.MyChildEntry = {}
jk.widget.AlignWidget.MyChildEntry.__index = jk.widget.AlignWidget.MyChildEntry
_vm:set_metatable(jk.widget.AlignWidget.MyChildEntry, {})

function jk.widget.AlignWidget.MyChildEntry._create()
	local v = _vm:set_metatable({}, jk.widget.AlignWidget.MyChildEntry)
	return v
end

function jk.widget.AlignWidget.MyChildEntry:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.AlignWidget.MyChildEntry'
	self['_isType.jk.widget.AlignWidget.MyChildEntry'] = true
	self.widget = nil
	self.alignX = 0.0
	self.alignY = 0.0
	self.maximizeWidth = false
end

function jk.widget.AlignWidget.MyChildEntry:_construct0()
	jk.widget.AlignWidget.MyChildEntry._init(self)
	return self
end

function jk.widget.AlignWidget:forWidget(context, widget, alignX, alignY, margin)
	local v = _g.jk.widget.AlignWidget._construct1(_g.jk.widget.AlignWidget._create(), context)
	v.widgetMarginLeft = margin
	v.widgetMarginRight = margin
	v.widgetMarginTop = margin
	v.widgetMarginBottom = margin
	do v:addWidget1(widget, alignX, alignY, false) end
	do return v end
end

function jk.widget.AlignWidget:_construct1(ctx)
	jk.widget.AlignWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct1(self, ctx) end
	self.children = {}
	return self
end

function jk.widget.AlignWidget:setWidgetMargin(margin)
	self.widgetMarginLeft = margin
	self.widgetMarginRight = margin
	self.widgetMarginTop = margin
	self.widgetMarginBottom = margin
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.AlignWidget:getWidgetMarginLeft()
	do return self.widgetMarginLeft end
end

function jk.widget.AlignWidget:setWidgetMarginLeft(value)
	self.widgetMarginLeft = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.AlignWidget:getWidgetMarginRight()
	do return self.widgetMarginRight end
end

function jk.widget.AlignWidget:setWidgetMarginRight(value)
	self.widgetMarginRight = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.AlignWidget:getWidgetMarginTop()
	do return self.widgetMarginTop end
end

function jk.widget.AlignWidget:setWidgetMarginTop(value)
	self.widgetMarginTop = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.AlignWidget:getWidgetMarginBottom()
	do return self.widgetMarginBottom end
end

function jk.widget.AlignWidget:setWidgetMarginBottom(value)
	self.widgetMarginBottom = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.AlignWidget:onWidgetHeightChanged(height)
	do _g.jk.widget.ContainerWidget.onWidgetHeightChanged(self, height) end
	do self:updateChildWidgetLocations() end
end

function jk.widget.AlignWidget:updateChildWidgetLocations()
	if self.children ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(self.children)
		do
			n = 0
			while n < m do
				local child = self.children[n + 1]
				if child ~= nil then
					do self:handleEntry(child) end
				end
				do n = n + 1 end
			end
		end
	end
end

function jk.widget.AlignWidget:computeWidgetLayout(widthConstraint)
	local wc = -1
	if widthConstraint >= 0 then
		wc = widthConstraint - self.widgetMarginLeft - self.widgetMarginRight
		if wc < 0 then
			wc = 0
		end
	end
	do
		local mw = 0
		local mh = 0
		if self.children ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(self.children)
			do
				n = 0
				while n < m do
					local child = self.children[n + 1]
					if child ~= nil then
						local widget = child.widget
						if child.maximizeWidth then
							do _g.jk.widget.Widget:layout(widget, widthConstraint, false) end
						else
							do _g.jk.widget.Widget:layout(widget, -1, false) end
						end
						do
							local cw = _g.jk.widget.Widget:getWidth(widget)
							if wc >= 0 and cw > wc then
								do _g.jk.widget.Widget:layout(widget, wc, false) end
								cw = _g.jk.widget.Widget:getWidth(widget)
							end
							if cw > mw then
								mw = cw
							end
							do
								local ch = _g.jk.widget.Widget:getHeight(widget)
								if ch > mh then
									mh = ch
								end
							end
						end
					end
					do n = n + 1 end
				end
			end
		end
		do
			local mywidth = mw + self.widgetMarginLeft + self.widgetMarginRight
			if widthConstraint >= 0 then
				mywidth = widthConstraint
			end
			do _g.jk.widget.Widget:setLayoutSize(self, mywidth, mh + self.widgetMarginTop + self.widgetMarginBottom) end
			do self:updateChildWidgetLocations() end
		end
	end
end

function jk.widget.AlignWidget:handleEntry(entry)
	local w = _g.jk.widget.Widget:getWidth(self) - self.widgetMarginLeft - self.widgetMarginRight
	local h = _g.jk.widget.Widget:getHeight(self) - self.widgetMarginTop - self.widgetMarginBottom
	local cw = _g.jk.widget.Widget:getWidth(entry.widget)
	local ch = _g.jk.widget.Widget:getHeight(entry.widget)
	if cw > w or ch > h then
		if cw > w then
			cw = w
		end
		if ch > h then
			ch = h
		end
	end
	do
		local dx = self.widgetMarginLeft + _util:convert_to_integer((w - cw) * entry.alignX)
		local dy = self.widgetMarginTop + _util:convert_to_integer((h - ch) * entry.alignY)
		do _g.jk.widget.Widget:move(entry.widget, dx, dy) end
	end
end

function jk.widget.AlignWidget:onChildWidgetsRemoved(widgets)
	do _g.jk.widget.ContainerWidget.onChildWidgetsRemoved(self, widgets) end
	do
		local ws = _g.jk.lang.Vector:getSize(widgets)
		if ws > 0 then
			local vs = _g.jk.lang.Vector:getSize(self.children)
			if ws == vs then
				do _g.jk.lang.Vector:clear(self.children) end
			else
				local widget = _g.jk.lang.Vector:get(widgets, 0)
				if self.children ~= nil then
					local n = 0
					local m = _g.jk.lang.Vector:getSize(self.children)
					do
						n = 0
						while n < m do
							local child = self.children[n + 1]
							if child ~= nil then
								if child.widget == widget then
									do _g.jk.lang.Vector:removeValue(self.children, child) end
									do break end
								end
							end
							do n = n + 1 end
						end
					end
				end
			end
		end
	end
end

function jk.widget.AlignWidget:addWidget(widget)
	do return self:addWidget1(widget, 0.5, 0.5, false) end
end

function jk.widget.AlignWidget:addWidget1(widget, alignX, alignY, maximizeWidth)
	local ee = _g.jk.widget.AlignWidget.MyChildEntry._construct0(_g.jk.widget.AlignWidget.MyChildEntry._create())
	ee.widget = widget
	ee.alignX = alignX
	ee.alignY = alignY
	ee.maximizeWidth = maximizeWidth
	do _g.jk.lang.Vector:append(self.children, ee) end
	do _g.jk.widget.Widget:addChild(self, widget) end
	if self:hasSize() then
		do self:handleEntry(ee) end
	end
	do return self end
end

function jk.widget.AlignWidget:setAlignForIndex(index, alignX, alignY)
	local child = _g.jk.lang.Vector:get(self.children, index)
	if child == nil then
		do return end
	end
	if child.alignX ~= alignX or child.alignY ~= alignY then
		child.alignX = alignX
		child.alignY = alignY
		do _g.jk.widget.Widget:onLayoutChanged(self) end
	end
end

jk.widget.WidgetAnimation = {}
jk.widget.WidgetAnimation.__index = jk.widget.WidgetAnimation
_vm:set_metatable(jk.widget.WidgetAnimation, {})

function jk.widget.WidgetAnimation._create()
	local v = _vm:set_metatable({}, jk.widget.WidgetAnimation)
	return v
end

function jk.widget.WidgetAnimation:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.WidgetAnimation'
	self['_isType.jk.widget.WidgetAnimation'] = true
	self.context = nil
	self.duration = 0
	self.callbacks = nil
	self.endListener = nil
	self.shouldStop = false
	self.shouldLoop = false
end

function jk.widget.WidgetAnimation:_construct0()
	jk.widget.WidgetAnimation._init(self)
	return self
end

function jk.widget.WidgetAnimation:forDuration(context, duration)
	local v = _g.jk.widget.WidgetAnimation._construct1(_g.jk.widget.WidgetAnimation._create(), context)
	do v:setDuration(duration) end
	do return v end
end

function jk.widget.WidgetAnimation:_construct1(context)
	jk.widget.WidgetAnimation._init(self)
	self.context = context
	self.callbacks = {}
	return self
end

function jk.widget.WidgetAnimation:addCallback(callback)
	if callback ~= nil then
		do _g.jk.lang.Vector:append(self.callbacks, callback) end
	end
	do return self end
end

function jk.widget.WidgetAnimation:addCrossFade(from, to, removeFrom)
	local ff = from
	local tt = to
	local rf = removeFrom
	do self:addCallback(function(completion)
		do _g.jk.widget.Widget:setAlpha(ff, 1.0 - completion) end
		do _g.jk.widget.Widget:setAlpha(tt, completion) end
		if rf and completion >= 1.0 then
			do _g.jk.widget.Widget:removeFromParent(ff) end
		end
	end) end
	do return self end
end

function jk.widget.WidgetAnimation:addFadeIn(from)
	local ff = from
	do self:addCallback(function(completion)
		do _g.jk.widget.Widget:setAlpha(ff, completion) end
	end) end
	do return self end
end

function jk.widget.WidgetAnimation:addFadeOut(from, removeAfter)
	local ff = from
	local ra = removeAfter
	do self:addCallback(function(completion)
		do _g.jk.widget.Widget:setAlpha(ff, 1.0 - completion) end
		if ra and completion >= 1.0 then
			do _g.jk.widget.Widget:removeFromParent(ff) end
		end
	end) end
	do return self end
end

function jk.widget.WidgetAnimation:addFadeOutIn(from)
	local ff = from
	do self:addCallback(function(completion)
		local r = _g.jk.math.Math:remainder(completion, 1.0)
		if r < 0.5 then
			do _g.jk.widget.Widget:setAlpha(ff, 1.0 - r * 2) end
		else
			do _g.jk.widget.Widget:setAlpha(ff, (r - 0.5) * 2) end
		end
	end) end
	do return self end
end

function jk.widget.WidgetAnimation:tick(completion)
	if self.callbacks ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(self.callbacks)
		do
			n = 0
			while n < m do
				local callback = self.callbacks[n + 1]
				if callback ~= nil then
					do callback(completion) end
				end
				do n = n + 1 end
			end
		end
	end
end

function jk.widget.WidgetAnimation:onProgress(elapsedTime)
	local completion = elapsedTime / self.duration
	do self:tick(completion) end
	if self.shouldLoop == false and completion >= 1.0 or self.shouldStop then
		do self:onAnimationEnded() end
		do return false end
	end
	do return true end
end

function jk.widget.WidgetAnimation:onAnimationEnded()
	if self.endListener ~= nil then
		do self.endListener() end
	end
end

function jk.widget.WidgetAnimation:start()
	_io:write_to_stdout("[jk.widget.WidgetAnimation.start] (WidgetAnimation.sling:252:3): Not implemented" .. "\n")
end

function jk.widget.WidgetAnimation:getDuration()
	do return self.duration end
end

function jk.widget.WidgetAnimation:setDuration(v)
	self.duration = v
	do return self end
end

function jk.widget.WidgetAnimation:getEndListener()
	do return self.endListener end
end

function jk.widget.WidgetAnimation:setEndListener(v)
	self.endListener = v
	do return self end
end

function jk.widget.WidgetAnimation:getShouldStop()
	do return self.shouldStop end
end

function jk.widget.WidgetAnimation:setShouldStop(v)
	self.shouldStop = v
	do return self end
end

function jk.widget.WidgetAnimation:getShouldLoop()
	do return self.shouldLoop end
end

function jk.widget.WidgetAnimation:setShouldLoop(v)
	self.shouldLoop = v
	do return self end
end

jk.widget.VerticalScrollerWidget = {}
jk.widget.VerticalScrollerWidget.__index = jk.widget.VerticalScrollerWidget
_vm:set_metatable(jk.widget.VerticalScrollerWidget, {})

function jk.widget.VerticalScrollerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.VerticalScrollerWidget)
	return v
end

function jk.widget.VerticalScrollerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.VerticalScrollerWidget'
	self['_isType.jk.widget.VerticalScrollerWidget'] = true
	self['_isType.jk.widget.WidgetWithLayout'] = true
	self['_isType.jk.widget.HeightAwareWidget'] = true
	self.currentScrollY = 0
	self.lastScrollY = 0
	self.nearEnd = false
	self.onScrolledHandler = nil
	self.onEndScrollHandler = nil
	self.layoutHeight = -1
	self.heightChanged = false
end

function jk.widget.VerticalScrollerWidget:_construct0()
	jk.widget.VerticalScrollerWidget._init(self)
	return self
end

function jk.widget.VerticalScrollerWidget:forWidget(context, widget)
	local v = _g.jk.widget.VerticalScrollerWidget._construct1(_g.jk.widget.VerticalScrollerWidget._create(), context)
	do v:addWidget(widget) end
	do return v end
end

function jk.widget.VerticalScrollerWidget:isNearEnd()
	do return self.nearEnd end
end

function jk.widget.VerticalScrollerWidget:onScroll(scrollY)
	self.currentScrollY = scrollY
	do
		local ch = _g.jk.widget.Widget:getHeight(_g.jk.lang.Vector:get(_g.jk.widget.Widget:getChildren(self), 0))
		if ch > 0 then
			self.nearEnd = (function(a, b, c)
				if a then
					do return b() end
				end
				do return c() end
			end)(ch - self.currentScrollY < _g.jk.widget.Widget:getHeight(self) * 2, function()
				do return true end
			end, function()
				do return false end
			end)
		end
		if self.onEndScrollHandler ~= nil and ch - (scrollY + _g.jk.widget.Widget:getHeight(self)) == 0 then
			do self.onEndScrollHandler() end
		end
		if self.onScrolledHandler ~= nil and self.lastScrollY ~= self.currentScrollY then
			do self.onScrolledHandler((function(a, b, c)
				if a then
					do return b() end
				end
				do return c() end
			end)(self.lastScrollY < self.currentScrollY, function()
				do return 0 end
			end, function()
				do return 1 end
			end)) end
			self.lastScrollY = self.currentScrollY
		end
	end
end

function jk.widget.VerticalScrollerWidget:_construct1(context)
	jk.widget.VerticalScrollerWidget._init(self)
	return self
end

function jk.widget.VerticalScrollerWidget:setWidgetScrollBarDisabled(value)
end

function jk.widget.VerticalScrollerWidget:onWidgetHeightChanged(height)
	local array = _g.jk.widget.Widget:getChildren(self)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local child = array[n + 1]
				if child ~= nil then
					if height > self.layoutHeight then
						do _g.jk.widget.Widget:resizeHeight(child, height) end
					else
						do _g.jk.widget.Widget:resizeHeight(child, self.layoutHeight) end
					end
				end
				do n = n + 1 end
			end
		end
	end
	self.heightChanged = true
end

function jk.widget.VerticalScrollerWidget:setWidgetLayoutChanged()
end

function jk.widget.VerticalScrollerWidget:hasWidgetLayoutChanged()
	do return false end
end

function jk.widget.VerticalScrollerWidget:layoutWidget(widthConstraint, force)
	local mw = 0
	local mh = 0
	local array = _g.jk.widget.Widget:getChildren(self)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local child = array[n + 1]
				if child ~= nil then
					do _g.jk.widget.Widget:move(child, 0, 0) end
					do _g.jk.widget.Widget:layout(child, widthConstraint, self.heightChanged) end
					do
						local cw = _g.jk.widget.Widget:getWidth(child)
						local ch = _g.jk.widget.Widget:getHeight(child)
						if cw > mw then
							mw = cw
						end
						if ch > mh then
							mh = ch
						end
					end
				end
				do n = n + 1 end
			end
		end
	end
	do
		local mh2 = mh
		local eh = _g.jk.widget.Widget:getHeight(self)
		if eh > 0 and mh2 > eh then
			mh2 = eh
		end
		self.heightChanged = false
		self.layoutHeight = mh
		do _g.jk.widget.Widget:setLayoutSize(self, mw, mh2) end
		do
			local array2 = _g.jk.widget.Widget:getChildren(self)
			if array2 ~= nil then
				local n2 = 0
				local m2 = _g.jk.lang.Vector:getSize(array2)
				do
					n2 = 0
					while n2 < m2 do
						local child = array2[n2 + 1]
						if child ~= nil then
							do _g.jk.widget.Widget:resizeHeight(child, mh) end
						end
						do n2 = n2 + 1 end
					end
				end
			end
			do return true end
		end
	end
end

function jk.widget.VerticalScrollerWidget:addWidget(widget)
	do _g.jk.widget.Widget:addChild(self, widget) end
	do return self end
end

function jk.widget.VerticalScrollerWidget:scrollToBottom(animate)
	local child = _g.jk.lang.Vector:get(_g.jk.widget.Widget:getChildren(self), 0)
	if not (child ~= nil) then
		do return end
	end
	do
		local y = _g.jk.widget.Widget:getHeight(child) - _g.jk.widget.Widget:getHeight(self)
		if not (y > 0) then
			do return end
		end
		do
			local x = _g.jk.widget.Widget:getX(child)
			_io:write_to_stdout("[jk.widget.VerticalScrollerWidget.scrollToBottom] (VerticalScrollerWidget.sling:324:3): Not implemented" .. "\n")
		end
	end
end

function jk.widget.VerticalScrollerWidget:getOnScrolledHandler()
	do return self.onScrolledHandler end
end

function jk.widget.VerticalScrollerWidget:setOnScrolledHandler(v)
	self.onScrolledHandler = v
	do return self end
end

function jk.widget.VerticalScrollerWidget:getOnEndScrollHandler()
	do return self.onEndScrollHandler end
end

function jk.widget.VerticalScrollerWidget:setOnEndScrollHandler(v)
	self.onEndScrollHandler = v
	do return self end
end

jk.widget.VerticalBoxWidget = _g.jk.widget.ContainerWidget._create()
jk.widget.VerticalBoxWidget.__index = jk.widget.VerticalBoxWidget
_vm:set_metatable(jk.widget.VerticalBoxWidget, {
	__index = _g.jk.widget.ContainerWidget
})

function jk.widget.VerticalBoxWidget._create()
	local v = _vm:set_metatable({}, jk.widget.VerticalBoxWidget)
	return v
end

function jk.widget.VerticalBoxWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.VerticalBoxWidget'
	self['_isType.jk.widget.VerticalBoxWidget'] = true
	self.children = nil
	self.widgetSpacing = 0
	self.widgetMarginLeft = 0
	self.widgetMarginRight = 0
	self.widgetMarginTop = 0
	self.widgetMarginBottom = 0
	self.widgetWidthRequest = 0
	self.widgetMaximumWidthRequest = 0
end

function jk.widget.VerticalBoxWidget:_construct0()
	jk.widget.VerticalBoxWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct0(self) end
	return self
end

jk.widget.VerticalBoxWidget.MyChildEntry = {}
jk.widget.VerticalBoxWidget.MyChildEntry.__index = jk.widget.VerticalBoxWidget.MyChildEntry
_vm:set_metatable(jk.widget.VerticalBoxWidget.MyChildEntry, {})

function jk.widget.VerticalBoxWidget.MyChildEntry._create()
	local v = _vm:set_metatable({}, jk.widget.VerticalBoxWidget.MyChildEntry)
	return v
end

function jk.widget.VerticalBoxWidget.MyChildEntry:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.VerticalBoxWidget.MyChildEntry'
	self['_isType.jk.widget.VerticalBoxWidget.MyChildEntry'] = true
	self.widget = nil
	self.weight = 0.0
end

function jk.widget.VerticalBoxWidget.MyChildEntry:_construct0()
	jk.widget.VerticalBoxWidget.MyChildEntry._init(self)
	return self
end

function jk.widget.VerticalBoxWidget:forContext(context, widgetMargin, widgetSpacing)
	local v = _g.jk.widget.VerticalBoxWidget._construct1(_g.jk.widget.VerticalBoxWidget._create(), context)
	v.widgetMarginLeft = widgetMargin
	v.widgetMarginRight = widgetMargin
	v.widgetMarginTop = widgetMargin
	v.widgetMarginBottom = widgetMargin
	v.widgetSpacing = widgetSpacing
	do return v end
end

function jk.widget.VerticalBoxWidget:_construct1(ctx)
	jk.widget.VerticalBoxWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct1(self, ctx) end
	self.children = {}
	return self
end

function jk.widget.VerticalBoxWidget:setWidgetMargin(margin)
	self.widgetMarginLeft = margin
	self.widgetMarginRight = margin
	self.widgetMarginTop = margin
	self.widgetMarginBottom = margin
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.VerticalBoxWidget:getWidgetMarginLeft()
	do return self.widgetMarginLeft end
end

function jk.widget.VerticalBoxWidget:setWidgetMarginLeft(value)
	self.widgetMarginLeft = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.VerticalBoxWidget:getWidgetMarginRight()
	do return self.widgetMarginRight end
end

function jk.widget.VerticalBoxWidget:setWidgetMarginRight(value)
	self.widgetMarginRight = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.VerticalBoxWidget:getWidgetMarginTop()
	do return self.widgetMarginTop end
end

function jk.widget.VerticalBoxWidget:setWidgetMarginTop(value)
	self.widgetMarginTop = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.VerticalBoxWidget:getWidgetMarginBottom()
	do return self.widgetMarginBottom end
end

function jk.widget.VerticalBoxWidget:setWidgetMarginBottom(value)
	self.widgetMarginBottom = value
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.VerticalBoxWidget:setWidgetWidthRequest(request)
	self.widgetWidthRequest = request
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.VerticalBoxWidget:getWidgetWidthRequest()
	do return self.widgetWidthRequest end
end

function jk.widget.VerticalBoxWidget:setWidgetMaximumWidthRequest(width)
	self.widgetMaximumWidthRequest = width
	if _g.jk.widget.Widget:getWidth(self) > width then
		do _g.jk.widget.Widget:onLayoutChanged(self) end
	end
	do return self end
end

function jk.widget.VerticalBoxWidget:getWidgetMaximumWidthRequest()
	do return self.widgetMaximumWidthRequest end
end

function jk.widget.VerticalBoxWidget:computeWidgetLayout(widthConstraint)
	local wc = -1
	if widthConstraint < 0 and self.widgetWidthRequest > 0 then
		wc = self.widgetWidthRequest - self.widgetMarginLeft - self.widgetMarginRight
	end
	if wc < 0 and widthConstraint >= 0 then
		wc = widthConstraint - self.widgetMarginLeft - self.widgetMarginRight
		if wc < 0 then
			wc = 0
		end
	end
	do
		local widest = 0
		local childCount = 0
		local y = self.widgetMarginTop
		if wc < 0 then
			if self.children ~= nil then
				local n = 0
				local m = _g.jk.lang.Vector:getSize(self.children)
				do
					n = 0
					while n < m do
						local child = self.children[n + 1]
						if child ~= nil then
							do _g.jk.widget.Widget:layout(child.widget, -1, false) end
							do
								local ww = _g.jk.widget.Widget:getWidth(child.widget)
								if ww > wc then
									wc = ww
								end
							end
						end
						do n = n + 1 end
					end
				end
			end
		end
		if self.children ~= nil then
			local n2 = 0
			local m2 = _g.jk.lang.Vector:getSize(self.children)
			do
				n2 = 0
				while n2 < m2 do
					local child = self.children[n2 + 1]
					if child ~= nil then
						if childCount > 0 then
							y = y + self.widgetSpacing
						end
						do childCount = childCount + 1 end
						do _g.jk.widget.Widget:layout(child.widget, wc, false) end
						do _g.jk.widget.Widget:move(child.widget, self.widgetMarginLeft, y) end
						do
							local ww = _g.jk.widget.Widget:getWidth(child.widget)
							if wc < 0 and self.widgetMaximumWidthRequest > 0 and ww + self.widgetMarginLeft + self.widgetMarginRight > self.widgetMaximumWidthRequest then
								do _g.jk.widget.Widget:layout(child.widget, self.widgetMaximumWidthRequest - self.widgetMarginLeft - self.widgetMarginRight, false) end
								ww = _g.jk.widget.Widget:getWidth(child.widget)
							end
							if ww > widest then
								widest = ww
							end
							y = y + _g.jk.widget.Widget:getHeight(child.widget)
						end
					end
					do n2 = n2 + 1 end
				end
			end
		end
		y = y + self.widgetMarginBottom
		do
			local mywidth = widest + self.widgetMarginLeft + self.widgetMarginRight
			if widthConstraint >= 0 then
				mywidth = widthConstraint
			end
			do _g.jk.widget.Widget:setLayoutSize(self, mywidth, y) end
			do self:onWidgetHeightChanged(y) end
		end
	end
end

function jk.widget.VerticalBoxWidget:onWidgetHeightChanged(height)
	do _g.jk.widget.ContainerWidget.onWidgetHeightChanged(self, height) end
	do
		local totalWeight = 0.0
		local availableHeight = height - self.widgetMarginTop - self.widgetMarginBottom
		local childCount = 0
		if self.children ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(self.children)
			do
				n = 0
				while n < m do
					local child = self.children[n + 1]
					if child ~= nil then
						do childCount = childCount + 1 end
						if child.weight > 0.0 then
							totalWeight = totalWeight + child.weight
						else
							availableHeight = availableHeight - _g.jk.widget.Widget:getHeight(child.widget)
						end
					end
					do n = n + 1 end
				end
			end
		end
		if childCount > 1 and self.widgetSpacing > 0 then
			availableHeight = availableHeight - (childCount - 1) * self.widgetSpacing
		end
		if availableHeight < 0 then
			availableHeight = 0
		end
		do
			local y = self.widgetMarginTop
			if self.children ~= nil then
				local n2 = 0
				local m2 = _g.jk.lang.Vector:getSize(self.children)
				do
					n2 = 0
					while n2 < m2 do
						local child = self.children[n2 + 1]
						if child ~= nil then
							do _g.jk.widget.Widget:move(child.widget, self.widgetMarginLeft, y) end
							if child.weight > 0.0 then
								local hh = _util:convert_to_integer(availableHeight * child.weight / totalWeight)
								do _g.jk.widget.Widget:resizeHeight(child.widget, hh) end
							end
							do
								local hh = _g.jk.widget.Widget:getHeight(child.widget)
								y = y + hh
								y = y + self.widgetSpacing
							end
						end
						do n2 = n2 + 1 end
					end
				end
			end
		end
	end
end

function jk.widget.VerticalBoxWidget:onChildWidgetsRemoved(widgets)
	local ws = _g.jk.lang.Vector:getSize(widgets)
	if ws > 0 then
		local vs = _g.jk.lang.Vector:getSize(self.children)
		if ws == vs then
			do _g.jk.lang.Vector:clear(self.children) end
		else
			local widget = _g.jk.lang.Vector:get(widgets, 0)
			if self.children ~= nil then
				local n = 0
				local m = _g.jk.lang.Vector:getSize(self.children)
				do
					n = 0
					while n < m do
						local child = self.children[n + 1]
						if child ~= nil then
							if child.widget == widget then
								do _g.jk.lang.Vector:removeValue(self.children, child) end
								do break end
							end
						end
						do n = n + 1 end
					end
				end
			end
		end
	end
	do _g.jk.widget.ContainerWidget.onChildWidgetsRemoved(self, widgets) end
end

function jk.widget.VerticalBoxWidget:addWidget(widget)
	do return self:addWidget1(widget, 0.0) end
end

function jk.widget.VerticalBoxWidget:removeAllChildren()
	do _g.jk.widget.Widget:removeChildrenOf(self) end
end

function jk.widget.VerticalBoxWidget:addWidget1(widget, weight)
	if widget ~= nil then
		local ee = _g.jk.widget.VerticalBoxWidget.MyChildEntry._construct0(_g.jk.widget.VerticalBoxWidget.MyChildEntry._create())
		ee.widget = widget
		ee.weight = weight
		do _g.jk.lang.Vector:append(self.children, ee) end
		do _g.jk.widget.Widget:addChild(self, widget) end
	end
	do return self end
end

function jk.widget.VerticalBoxWidget:getWidgetSpacing()
	do return self.widgetSpacing end
end

function jk.widget.VerticalBoxWidget:setWidgetSpacing(v)
	self.widgetSpacing = v
	do return self end
end

jk.widget.DisplayAwareWidget = {}

jk.widget.WidgetWithValue = {}
jk = jk or {}

jk.web = jk.web or {}

jk.web.NativeWebClient = {}
jk.web.NativeWebClient.__index = jk.web.NativeWebClient
_vm:set_metatable(jk.web.NativeWebClient, {})

function jk.web.NativeWebClient._create()
	local v = _vm:set_metatable({}, jk.web.NativeWebClient)
	return v
end

function jk.web.NativeWebClient:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.web.NativeWebClient'
	self['_isType.jk.web.NativeWebClient'] = true
end

function jk.web.NativeWebClient:_construct0()
	jk.web.NativeWebClient._init(self)
	return self
end

function jk.web.NativeWebClient:instance()
	_io:write_to_stdout("[jk.web.NativeWebClient.instance] (NativeWebClient.sling:50:3): Not implemented." .. "\n")
	do return nil end
end

jk.web.WebClient = {}
jk.web.WebClient.__index = jk.web.WebClient
_vm:set_metatable(jk.web.WebClient, {})

function jk.web.WebClient._create()
	local v = _vm:set_metatable({}, jk.web.WebClient)
	return v
end

function jk.web.WebClient:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.web.WebClient'
	self['_isType.jk.web.WebClient'] = true
	self.followRedirects = true
	self.credentialsEnabled = false
end

function jk.web.WebClient:_construct0()
	jk.web.WebClient._init(self)
	return self
end

function jk.web.WebClient:query(method, url, headers, body, callback)
end

function jk.web.WebClient:getFollowRedirects()
	do return self.followRedirects end
end

function jk.web.WebClient:setFollowRedirects(v)
	self.followRedirects = v
	do return self end
end

function jk.web.WebClient:getCredentialsEnabled()
	do return self.credentialsEnabled end
end

function jk.web.WebClient:setCredentialsEnabled(v)
	self.credentialsEnabled = v
	do return self end
end
jk = jk or {}

jk.web = jk.web or {}

jk.web.json = jk.web.json or {}

jk.web.json.JSONAPIClient = {}
jk.web.json.JSONAPIClient.__index = jk.web.json.JSONAPIClient
_vm:set_metatable(jk.web.json.JSONAPIClient, {})

function jk.web.json.JSONAPIClient._create()
	local v = _vm:set_metatable({}, jk.web.json.JSONAPIClient)
	return v
end

function jk.web.json.JSONAPIClient:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.web.json.JSONAPIClient'
	self['_isType.jk.web.json.JSONAPIClient'] = true
	self.credentialsEnabled = false
	self.redirectionEnabled = false
	self.redirectionLimit = 5
	self.apiUrl = nil
	self.webClient = nil
	self.debugCallback = nil
end

function jk.web.json.JSONAPIClient:_construct0()
	jk.web.json.JSONAPIClient._init(self)
	return self
end

function jk.web.json.JSONAPIClient:getFullURL(api)
	local url = self.apiUrl
	if _g.jk.lang.String:isEmpty(url) then
		url = "/"
	end
	if url == "/" then
		if _g.jk.lang.String:startsWith(api, "/", 0) then
			do return api end
		end
		do return _g.jk.lang.String:safeString(url) .. _g.jk.lang.String:safeString(api) end
	end
	if _g.jk.lang.String:endsWith(url, "/") then
		if _g.jk.lang.String:startsWith(api, "/", 0) then
			do return _g.jk.lang.String:safeString(url) .. _g.jk.lang.String:safeString(_g.jk.lang.String:getEndOfString(api, 1)) end
		end
		do return _g.jk.lang.String:safeString(url) .. _g.jk.lang.String:safeString(api) end
	end
	if _g.jk.lang.String:startsWith(api, "/", 0) then
		do return _g.jk.lang.String:safeString(url) .. _g.jk.lang.String:safeString(api) end
	end
	do return _g.jk.lang.String:safeString(url) .. "/" .. _g.jk.lang.String:safeString(api) end
end

function jk.web.json.JSONAPIClient:toUTF8Buffer(data)
	if not (data ~= nil) then
		do return nil end
	end
	do return _g.jk.lang.String:toUTF8Buffer(_g.jk.json.JSONEncoder:encode(data, true, false)) end
end

function jk.web.json.JSONAPIClient:customizeRequestHeaders(headers)
end

function jk.web.json.JSONAPIClient:onStartSendRequest()
end

function jk.web.json.JSONAPIClient:onEndSendRequest()
end

function jk.web.json.JSONAPIClient:onDefaultErrorHandler(error)
end

function jk.web.json.JSONAPIClient:handleAsError(response, callback)
	local error = self:toError(response)
	if error ~= nil then
		do self:onError1(error, callback) end
		do return true end
	end
	do return false end
end

function jk.web.json.JSONAPIClient:toError(response)
	if not (response ~= nil) then
		do return _g.jk.lang.Error:forCode("noServerResponse", nil) end
	end
	if response:getString("status", nil) == "error" then
		local v = _g.jk.lang.Error._construct0(_g.jk.lang.Error._create())
		local code = response:getString("code", nil)
		if _g.jk.lang.String:isEmpty(code) then
			code = response:getString("error", nil)
		end
		do v:setCode(code) end
		do
			local detail = response:getString("detail", nil)
			if _g.jk.lang.String:isEmpty(detail) then
				detail = response:getString("message", nil)
			end
			do v:setDetail(detail) end
			do return v end
		end
	end
	do return nil end
end

function jk.web.json.JSONAPIClient:onError1(error, callback)
	if not (callback ~= nil) then
		do self:onDefaultErrorHandler(error) end
		do return end
	end
	do callback(error) end
end

function jk.web.json.JSONAPIClient:onError2(error)
	do self:onError1(error, nil) end
end

function jk.web.json.JSONAPIClient:sendRequest(method, url, headers, data, callback, errorCallback)
	if not (callback ~= nil) then
		do return end
	end
	do
		local ll = callback
		local ecb = errorCallback
		do self:doSendRequest(method, url, headers, data, function(responseHeaders, body)
			if not (body ~= nil and _g.jk.lang.Buffer:getSize(body) > 0) then
				do self:onError1(_g.jk.lang.Error:forCode("requestFailed", nil), ecb) end
				do return end
			end
			do
				local responseString = _g.jk.lang.String:forUTF8Buffer(body)
				if self.debugCallback ~= nil then
					do self.debugCallback("Received response: `" .. _g.jk.lang.String:safeString(responseString) .. "'") end
				end
				do
					local jsonResponseBody = _vm:to_table_with_key(_g.jk.json.JSONParser:parseString(responseString), '_isType.jk.lang.DynamicMap')
					if not (jsonResponseBody ~= nil) then
						do self:onError1(_g.jk.lang.Error:forCode("invalidServerResponse", nil), ecb) end
						do return end
					end
					if not self:handleAsError(jsonResponseBody, ecb) then
						do ll(jsonResponseBody) end
					end
				end
			end
		end, ecb, 0) end
	end
end

function jk.web.json.JSONAPIClient:doSendRequest(method, url, headers, data, callback, errorCallback, redirectCount)
	if not (callback ~= nil) then
		do return end
	end
	if not (redirectCount <= self.redirectionLimit) then
		do self:onError1(_g.jk.lang.Error:forCode("tooManyRedirections", nil), errorCallback) end
		do return end
	end
	do
		local hrs = headers
		if not (hrs ~= nil) then
			hrs = _g.jk.lang.KeyValueList._construct0(_g.jk.lang.KeyValueList._create())
			do hrs:add("Content-Type", "application/json") end
		end
		if not (self.webClient ~= nil) then
			self.webClient = _g.jk.web.NativeWebClient:instance()
		end
		if not (self.webClient ~= nil) then
			do self:onError1(_g.jk.lang.Error:forCode("noWebClient", nil), errorCallback) end
			do return end
		end
		do self.webClient:setCredentialsEnabled(self.credentialsEnabled) end
		do self:customizeRequestHeaders(hrs) end
		do
			local hrsf = hrs
			local cb = callback
			local ecb = errorCallback
			local urlf = url
			local dataf = data
			local methodf = method
			do self:onStartSendRequest() end
			if self.debugCallback ~= nil then
				do self.debugCallback("Sending request: `" .. _g.jk.lang.String:safeString(_g.jk.lang.String:forUTF8Buffer(data)) .. "'") end
			end
			do
				local rdc = redirectCount
				do self.webClient:query(methodf, urlf, hrsf, dataf, function(statusCode, responseHeaders, body)
					do self:onEndSendRequest() end
					if self.redirectionEnabled then
						local code = _g.jk.lang.String:toInteger(statusCode)
						if code >= 300 and code <= 399 and responseHeaders ~= nil then
							local location = nil
							local rhs = responseHeaders:asVector()
							if rhs ~= nil then
								local n2 = 0
								local m = _g.jk.lang.Vector:getSize(rhs)
								do
									n2 = 0
									while n2 < m do
										local kvp = rhs[n2 + 1]
										if kvp ~= nil then
											if _g.jk.lang.String:equalsIgnoreCase(kvp.key, "Location") then
												location = kvp.value
												do break end
											end
										end
										do n2 = n2 + 1 end
									end
								end
							end
							if _g.jk.lang.String:isNotEmpty(location) then
								if not _g.jk.lang.String:startsWith(location, "http", 0) then
									location = self:getFullURL(location)
								end
								do
									local o = _g.jk.url.URL:forString(urlf, false)
									local n = _g.jk.url.URL:forString(location, false)
									if o ~= nil and n ~= nil and _g.jk.lang.String:equalsIgnoreCase(o:getHost(), n:getHost()) and not (o:getPort() == n:getPort()) then
										do n:setPort(o:getPort()) end
										location = n:toString()
									end
									do self:doSendRequest(methodf, location, hrsf, dataf, cb, ecb, rdc + 1) end
									do return end
								end
							end
						end
					end
					if not (body ~= nil and _g.jk.lang.Buffer:getSize(body) > 0) then
						do self:onError1(_g.jk.lang.Error:forCode("failedToConnect", nil), ecb) end
						do return end
					end
					do cb(responseHeaders, body) end
				end) end
			end
		end
	end
end

function jk.web.json.JSONAPIClient:doGetFile(url, callback, errorCallback)
	do self:doSendRequest("GET", self:getFullURL(url), nil, nil, callback, errorCallback, 0) end
end

function jk.web.json.JSONAPIClient:doGet(url, callback, errorCallback)
	do self:sendRequest("GET", self:getFullURL(url), nil, nil, callback, errorCallback) end
end

function jk.web.json.JSONAPIClient:doPost(url, data, callback, errorCallback)
	do self:sendRequest("POST", self:getFullURL(url), nil, self:toUTF8Buffer(data), callback, errorCallback) end
end

function jk.web.json.JSONAPIClient:doPut(url, data, callback, errorCallback)
	do self:sendRequest("PUT", self:getFullURL(url), nil, self:toUTF8Buffer(data), callback, errorCallback) end
end

function jk.web.json.JSONAPIClient:doDelete(url, callback, errorCallback)
	do self:sendRequest("DELETE", self:getFullURL(url), nil, nil, callback, errorCallback) end
end

function jk.web.json.JSONAPIClient:uploadFile(url, data, mimeType, callback, errorCallback)
	local mt = mimeType
	if _g.jk.lang.String:isEmpty(mt) then
		mt = "application/octet-stream"
	end
	do
		local hdrs = _g.jk.lang.KeyValueList._construct0(_g.jk.lang.KeyValueList._create())
		do hdrs:add("content-type", mt) end
		do self:sendRequest("POST", self:getFullURL(url), hdrs, data, callback, errorCallback) end
	end
end

function jk.web.json.JSONAPIClient:getWithStatus(url, callback)
	local cb = callback
	local okcb = function(v)
		local data = v:getDynamicMap("data")
		if data == nil then
			data = _g.jk.lang.DynamicMap._construct0(_g.jk.lang.DynamicMap._create())
		end
		do cb(data, nil) end
	end
	local errcb = function(err)
		do cb(nil, err) end
	end
	do self:sendRequest("GET", self:getFullURL(url), nil, nil, okcb, errcb) end
end

function jk.web.json.JSONAPIClient:postWithStatus(url, data, headers, callback)
	local cb = callback
	local okcb = function(v)
		local data = v:getDynamicMap("data")
		if data == nil then
			data = _g.jk.lang.DynamicMap._construct0(_g.jk.lang.DynamicMap._create())
		end
		do cb(data, nil) end
	end
	local errcb = function(err)
		do cb(nil, err) end
	end
	do self:sendRequest("POST", self:getFullURL(url), headers, self:toUTF8Buffer(data), okcb, errcb) end
end

function jk.web.json.JSONAPIClient:getCredentialsEnabled()
	do return self.credentialsEnabled end
end

function jk.web.json.JSONAPIClient:setCredentialsEnabled(v)
	self.credentialsEnabled = v
	do return self end
end

function jk.web.json.JSONAPIClient:getRedirectionEnabled()
	do return self.redirectionEnabled end
end

function jk.web.json.JSONAPIClient:setRedirectionEnabled(v)
	self.redirectionEnabled = v
	do return self end
end

function jk.web.json.JSONAPIClient:getRedirectionLimit()
	do return self.redirectionLimit end
end

function jk.web.json.JSONAPIClient:setRedirectionLimit(v)
	self.redirectionLimit = v
	do return self end
end

function jk.web.json.JSONAPIClient:getApiUrl()
	do return self.apiUrl end
end

function jk.web.json.JSONAPIClient:setApiUrl(v)
	self.apiUrl = v
	do return self end
end

function jk.web.json.JSONAPIClient:getWebClient()
	do return self.webClient end
end

function jk.web.json.JSONAPIClient:setWebClient(v)
	self.webClient = v
	do return self end
end

function jk.web.json.JSONAPIClient:getDebugCallback()
	do return self.debugCallback end
end

function jk.web.json.JSONAPIClient:setDebugCallback(v)
	self.debugCallback = v
	do return self end
end
jk = jk or {}

jk.widget = jk.widget or {}

jk.widget.common = jk.widget.common or {}

jk.widget.common.RoundedImageWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.RoundedImageWidget.__index = jk.widget.common.RoundedImageWidget
_vm:set_metatable(jk.widget.common.RoundedImageWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.RoundedImageWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.RoundedImageWidget)
	return v
end

function jk.widget.common.RoundedImageWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.RoundedImageWidget'
	self['_isType.jk.widget.common.RoundedImageWidget'] = true
	self.widgetScaleSize = 0
	self.imageWidget = nil
end

function jk.widget.common.RoundedImageWidget:_construct0()
	jk.widget.common.RoundedImageWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.RoundedImageWidget:_construct1(ctx)
	jk.widget.common.RoundedImageWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, ctx) end
	do self:forceCreateWidget() end
	return self
end

function jk.widget.common.RoundedImageWidget:setWidgetSize(sz)
	do self:setWidgetHeightRequest(sz) end
	do self:setWidgetWidthRequest(sz) end
	do return self end
end

function jk.widget.common.RoundedImageWidget:setWidgetImageResource(src)
	local image = _g.jk.ui.ImageUtil:createCircularImageSync(self.context:getResourceImage(src))
	do self.imageWidget:setWidgetImage(image) end
	do return self end
end

function jk.widget.common.RoundedImageWidget:setWidgetImage(image)
	local img = _g.jk.ui.ImageUtil:createCircularImageSync(image)
	do self.imageWidget:setWidgetImage(img) end
	do return self end
end

function jk.widget.common.RoundedImageWidget:createWidget()
	do _g.jk.widget.LayerWidget.createWidget(self) end
	do
		local thisWidget = self
		self.imageWidget = _g.jk.widget.ImageWidget._construct1(_g.jk.widget.ImageWidget._create(), self.context)
		do self.imageWidget:setWidgetImageScaleMethod(_g.jk.widget.ImageWidget.FILL) end
		do self:addWidget(self.imageWidget) end
	end
end

function jk.widget.common.RoundedImageWidget:getWidgetScaleSize()
	do return self.widgetScaleSize end
end

function jk.widget.common.RoundedImageWidget:setWidgetScaleSize(v)
	self.widgetScaleSize = v
	do return self end
end

jk.widget.common.PopupDialogManager = {}
jk.widget.common.PopupDialogManager.__index = jk.widget.common.PopupDialogManager
_vm:set_metatable(jk.widget.common.PopupDialogManager, {})

function jk.widget.common.PopupDialogManager._create()
	local v = _vm:set_metatable({}, jk.widget.common.PopupDialogManager)
	return v
end

function jk.widget.common.PopupDialogManager:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.PopupDialogManager'
	self['_isType.jk.widget.common.PopupDialogManager'] = true
	self.context = nil
	self.parent = nil
	self.backgroundColor = nil
	self.headerBackgroundColor = nil
	self.headerTextColor = nil
	self.messageTextColor = nil
	self.positiveButtonColor = nil
	self.negativeButtonColor = nil
end

function jk.widget.common.PopupDialogManager:_construct0()
	jk.widget.common.PopupDialogManager._init(self)
	return self
end

function jk.widget.common.PopupDialogManager:_construct2(context, parent)
	jk.widget.common.PopupDialogManager._init(self)
	self.context = context
	self.parent = parent
	self.positiveButtonColor = _g.jk.gfx.Color:forRGB(128, 204, 128)
	self.negativeButtonColor = _g.jk.gfx.Color:forRGB(204, 128, 128)
	self.backgroundColor = nil
	self.headerBackgroundColor = nil
	self.headerTextColor = nil
	self.messageTextColor = nil
	return self
end

function jk.widget.common.PopupDialogManager:setButtonColor(color)
	self.positiveButtonColor = color
	self.negativeButtonColor = color
	do return self end
end

function jk.widget.common.PopupDialogManager:showTextInputDialog(title, prompt, callback)
	do self:checkForDefaultColors() end
	do
		local mm2 = self.context:getWidthValue("2mm")
		local mm3 = self.context:getWidthValue("3mm")
		local widget = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
		do widget:setWidgetWidthRequest(self.context:getWidthValue("100mm")) end
		do widget:addWidget(_g.jk.widget.CanvasWidget:forColor(self.context, self.backgroundColor)) end
		do
			local titleLabel = _g.jk.widget.LabelWidget:forText(self.context, title)
			do titleLabel:setWidgetFontSize(mm3) end
			do titleLabel:setWidgetTextColor(self.headerTextColor) end
			do titleLabel:setWidgetFontBold(true) end
			do
				local box = _g.jk.widget.VerticalBoxWidget._construct1(_g.jk.widget.VerticalBoxWidget._create(), self.context)
				do box:addWidget(_g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context):addWidget(_g.jk.widget.CanvasWidget:forColor(self.context, self.headerBackgroundColor)):addWidget(_g.jk.widget.AlignWidget:forWidget(self.context, titleLabel, 0, 0.5, 0):setWidgetMargin(mm3))) end
				do
					local sbox = _g.jk.widget.VerticalBoxWidget._construct1(_g.jk.widget.VerticalBoxWidget._create(), self.context)
					do sbox:setWidgetMargin(mm3) end
					do sbox:setWidgetSpacing(mm3) end
					do
						local messageLabel = _g.jk.widget.LabelWidget:forText(self.context, prompt)
						do messageLabel:setWidgetTextAlign(_g.jk.widget.LabelWidget.ALIGN_CENTER) end
						do messageLabel:setWidgetFontSize(mm3) end
						do messageLabel:setWidgetTextColor(self.messageTextColor) end
						do sbox:addWidget(messageLabel) end
						do
							local input = _g.jk.widget.common.TextInputWidget._construct1(_g.jk.widget.common.TextInputWidget._create(), self.context)
							do input:setWidgetBackgroundColor(_g.jk.gfx.Color:forRGB(200, 200, 200)) end
							do input:setWidgetPadding1(self.context:getHeightValue("2mm")) end
							do input:setWidgetFontSize(self.context:getHeightValue("3000um")) end
							do sbox:addWidget(input) end
							do
								local buttons = _g.jk.widget.HorizontalBoxWidget._construct1(_g.jk.widget.HorizontalBoxWidget._create(), self.context)
								do buttons:setWidgetSpacing(mm3) end
								do
									local padding = self.context:getHeightValue("2000um")
									local noButton = _g.jk.widget.common.TextButtonWidget:forText(self.context, "Cancel", nil)
									do noButton:setWidgetBackgroundColor(self.negativeButtonColor) end
									do noButton:setWidgetPadding(padding) end
									do buttons:addWidget1(noButton, 1.0) end
									do
										local yesButton = _g.jk.widget.common.TextButtonWidget:forText(self.context, "OK", nil)
										do yesButton:setWidgetBackgroundColor(self.positiveButtonColor) end
										do yesButton:setWidgetPadding(padding) end
										do buttons:addWidget1(yesButton, 1.0) end
										do sbox:addWidget(buttons) end
										do box:addWidget(sbox) end
										do widget:addWidget(box) end
										do
											local pp = _g.jk.widget.common.PopupWidget:forContentWidget(self.context, _g.jk.widget.LayerWidget:forWidget(self.context, widget, mm2))
											local cb = callback
											do pp:showPopup(self.parent) end
											do yesButton:setWidgetClickHandler1(function()
												do pp:hidePopup() end
												if cb ~= nil then
													do cb(input:getWidgetText()) end
												end
											end) end
											do noButton:setWidgetClickHandler1(function()
												do pp:hidePopup() end
												if cb ~= nil then
													do cb(nil) end
												end
											end) end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function jk.widget.common.PopupDialogManager:showMessageDialog(title, message, callback)
	do self:checkForDefaultColors() end
	do
		local mm2 = self.context:getWidthValue("2mm")
		local mm3 = self.context:getWidthValue("3mm")
		local widget = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
		do widget:setWidgetWidthRequest(self.context:getWidthValue("100mm")) end
		do widget:addWidget(_g.jk.widget.CanvasWidget:forColor(self.context, _g.jk.gfx.Color:white())) end
		do
			local titleLabel = _g.jk.widget.LabelWidget:forText(self.context, title)
			do titleLabel:setWidgetFontSize(mm3) end
			do titleLabel:setWidgetTextColor(self.headerTextColor) end
			do titleLabel:setWidgetFontBold(true) end
			do
				local box = _g.jk.widget.VerticalBoxWidget._construct1(_g.jk.widget.VerticalBoxWidget._create(), self.context)
				do box:addWidget(_g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context):addWidget(_g.jk.widget.CanvasWidget:forColor(self.context, self.headerBackgroundColor)):addWidget(_g.jk.widget.AlignWidget:forWidget(self.context, titleLabel, 0, 0.5, 0):setWidgetMargin(mm3))) end
				do
					local sbox = _g.jk.widget.VerticalBoxWidget._construct1(_g.jk.widget.VerticalBoxWidget._create(), self.context)
					do sbox:setWidgetMargin(mm3) end
					do sbox:setWidgetSpacing(mm3) end
					do
						local messageLabel = _g.jk.widget.LabelWidget:forText(self.context, message)
						do messageLabel:setWidgetTextAlign(_g.jk.widget.LabelWidget.ALIGN_CENTER) end
						do messageLabel:setWidgetFontSize(mm3) end
						do messageLabel:setWidgetTextColor(self.messageTextColor) end
						do sbox:addWidget(messageLabel) end
						do
							local buttons = _g.jk.widget.HorizontalBoxWidget._construct1(_g.jk.widget.HorizontalBoxWidget._create(), self.context)
							do buttons:setWidgetSpacing(mm3) end
							do
								local okButton = _g.jk.widget.common.TextButtonWidget:forText(self.context, "OK", nil)
								do okButton:setWidgetBackgroundColor(self.positiveButtonColor) end
								do okButton:setWidgetPadding(self.context:getHeightValue("2000um")) end
								do buttons:addWidget1(okButton, 1.0) end
								do sbox:addWidget(buttons) end
								do box:addWidget(sbox) end
								do widget:addWidget(box) end
								do
									local pp = _g.jk.widget.common.PopupWidget:forContentWidget(self.context, _g.jk.widget.LayerWidget:forWidget(self.context, widget, mm2))
									local cb = callback
									do pp:showPopup(self.parent) end
									do okButton:setWidgetClickHandler1(function()
										do pp:hidePopup() end
										if cb ~= nil then
											do cb() end
										end
									end) end
								end
							end
						end
					end
				end
			end
		end
	end
end

function jk.widget.common.PopupDialogManager:showConfirmDialog(title, message, okcallback, cancelcallback)
	do self:checkForDefaultColors() end
	do
		local mm2 = self.context:getWidthValue("2mm")
		local mm3 = self.context:getWidthValue("3mm")
		local widget = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
		do widget:setWidgetWidthRequest(self.context:getWidthValue("100mm")) end
		do widget:addWidget(_g.jk.widget.CanvasWidget:forColor(self.context, _g.jk.gfx.Color:white())) end
		do
			local titleLabel = _g.jk.widget.LabelWidget:forText(self.context, title)
			do titleLabel:setWidgetFontSize(mm3) end
			do titleLabel:setWidgetTextColor(self.headerTextColor) end
			do titleLabel:setWidgetFontBold(true) end
			do
				local box = _g.jk.widget.VerticalBoxWidget._construct1(_g.jk.widget.VerticalBoxWidget._create(), self.context)
				do box:addWidget(_g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context):addWidget(_g.jk.widget.CanvasWidget:forColor(self.context, self.headerBackgroundColor)):addWidget(_g.jk.widget.AlignWidget:forWidget(self.context, titleLabel, 0, 0.5, 0):setWidgetMargin(mm3))) end
				do
					local sbox = _g.jk.widget.VerticalBoxWidget._construct1(_g.jk.widget.VerticalBoxWidget._create(), self.context)
					do sbox:setWidgetMargin(mm3) end
					do sbox:setWidgetSpacing(mm3) end
					do
						local messageLabel = _g.jk.widget.LabelWidget:forText(self.context, message)
						do messageLabel:setWidgetTextAlign(_g.jk.widget.LabelWidget.ALIGN_CENTER) end
						do messageLabel:setWidgetFontSize(mm3) end
						do messageLabel:setWidgetTextColor(self.messageTextColor) end
						do sbox:addWidget(messageLabel) end
						do
							local buttons = _g.jk.widget.HorizontalBoxWidget._construct1(_g.jk.widget.HorizontalBoxWidget._create(), self.context)
							do buttons:setWidgetSpacing(mm3) end
							do
								local padding = self.context:getHeightValue("2000um")
								local noButton = _g.jk.widget.common.TextButtonWidget:forText(self.context, "NO", nil)
								do noButton:setWidgetBackgroundColor(self.negativeButtonColor) end
								do noButton:setWidgetPadding(padding) end
								do buttons:addWidget1(noButton, 1.0) end
								do
									local yesButton = _g.jk.widget.common.TextButtonWidget:forText(self.context, "YES", nil)
									do yesButton:setWidgetBackgroundColor(self.positiveButtonColor) end
									do yesButton:setWidgetPadding(padding) end
									do buttons:addWidget1(yesButton, 1.0) end
									do sbox:addWidget(buttons) end
									do box:addWidget(sbox) end
									do widget:addWidget(box) end
									do
										local pp = _g.jk.widget.common.PopupWidget:forContentWidget(self.context, _g.jk.widget.LayerWidget:forWidget(self.context, widget, mm2))
										local okcb = okcallback
										local cancelcb = cancelcallback
										do pp:showPopup(self.parent) end
										do yesButton:setWidgetClickHandler1(function()
											do pp:hidePopup() end
											if okcb ~= nil then
												do okcb() end
											end
										end) end
										do noButton:setWidgetClickHandler1(function()
											do pp:hidePopup() end
											if cancelcb ~= nil then
												do cancelcb() end
											end
										end) end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function jk.widget.common.PopupDialogManager:showErrorDialog(message, callback)
	do self:showMessageDialog("Error", message, callback) end
end

function jk.widget.common.PopupDialogManager:checkForDefaultColors()
	local bgc = self.backgroundColor
	if bgc == nil then
		self.backgroundColor = _g.jk.gfx.Color:white()
	end
	do
		local hbg = self.headerBackgroundColor
		if hbg == nil then
			self.headerBackgroundColor = _g.jk.gfx.Color:black()
		end
		do
			local htc = self.headerTextColor
			if htc == nil then
				if self.headerBackgroundColor:isDarkColor() then
					self.headerTextColor = _g.jk.gfx.Color:white()
				else
					self.headerTextColor = _g.jk.gfx.Color:black()
				end
			end
			do
				local mtc = self.messageTextColor
				if mtc == nil then
					if self.backgroundColor:isDarkColor() then
						self.messageTextColor = _g.jk.gfx.Color:white()
					else
						self.messageTextColor = _g.jk.gfx.Color:black()
					end
				end
			end
		end
	end
end

function jk.widget.common.PopupDialogManager:getContext()
	do return self.context end
end

function jk.widget.common.PopupDialogManager:setContext(v)
	self.context = v
	do return self end
end

function jk.widget.common.PopupDialogManager:getParent()
	do return self.parent end
end

function jk.widget.common.PopupDialogManager:setParent(v)
	self.parent = v
	do return self end
end

function jk.widget.common.PopupDialogManager:getBackgroundColor()
	do return self.backgroundColor end
end

function jk.widget.common.PopupDialogManager:setBackgroundColor(v)
	self.backgroundColor = v
	do return self end
end

function jk.widget.common.PopupDialogManager:getHeaderBackgroundColor()
	do return self.headerBackgroundColor end
end

function jk.widget.common.PopupDialogManager:setHeaderBackgroundColor(v)
	self.headerBackgroundColor = v
	do return self end
end

function jk.widget.common.PopupDialogManager:getHeaderTextColor()
	do return self.headerTextColor end
end

function jk.widget.common.PopupDialogManager:setHeaderTextColor(v)
	self.headerTextColor = v
	do return self end
end

function jk.widget.common.PopupDialogManager:getMessageTextColor()
	do return self.messageTextColor end
end

function jk.widget.common.PopupDialogManager:setMessageTextColor(v)
	self.messageTextColor = v
	do return self end
end

function jk.widget.common.PopupDialogManager:getPositiveButtonColor()
	do return self.positiveButtonColor end
end

function jk.widget.common.PopupDialogManager:setPositiveButtonColor(v)
	self.positiveButtonColor = v
	do return self end
end

function jk.widget.common.PopupDialogManager:getNegativeButtonColor()
	do return self.negativeButtonColor end
end

function jk.widget.common.PopupDialogManager:setNegativeButtonColor(v)
	self.negativeButtonColor = v
	do return self end
end

jk.widget.common.ToolbarWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.ToolbarWidget.__index = jk.widget.common.ToolbarWidget
_vm:set_metatable(jk.widget.common.ToolbarWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.ToolbarWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.ToolbarWidget)
	return v
end

function jk.widget.common.ToolbarWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.ToolbarWidget'
	self['_isType.jk.widget.common.ToolbarWidget'] = true
	self.defaultActionItemWidgetBackgroundColor = nil
	self.defaultActionItemWidgetTextColor = nil
	self.widgetBackgroundColor = nil
	self.widgetItems = nil
	self.overlayWidget = nil
end

function jk.widget.common.ToolbarWidget:_construct0()
	jk.widget.common.ToolbarWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.ToolbarWidget:_construct1(context)
	jk.widget.common.ToolbarWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.ToolbarWidget:forItems(ctx, items, color)
	local v = _g.jk.widget.common.ToolbarWidget._construct1(_g.jk.widget.common.ToolbarWidget._create(), ctx)
	do v:setWidgetItems(items) end
	do v:setWidgetBackgroundColor(color) end
	do return v end
end

function jk.widget.common.ToolbarWidget:addToWidgetItems(widget)
	if not (widget ~= nil) then
		do return end
	end
	if not (self.widgetItems ~= nil) then
		self.widgetItems = {}
	end
	do _g.jk.lang.Vector:append(self.widgetItems, widget) end
end

function jk.widget.common.ToolbarWidget:determineBackgroundColor()
	local wc = self.widgetBackgroundColor
	if not (wc ~= nil) then
		wc = _g.jk.gfx.Color:white()
	end
	do return wc end
end

function jk.widget.common.ToolbarWidget:determineTextColor(backgroundColor, textColor, defaultTextColor)
	local tc = textColor
	if not (tc ~= nil) then
		tc = defaultTextColor
	end
	if not (tc ~= nil) then
		local cc = self:determineBackgroundColor()
		if cc:isDarkColor() then
			tc = _g.jk.gfx.Color:white()
		else
			tc = _g.jk.gfx.Color:black()
		end
	end
	do return tc end
end

function jk.widget.common.ToolbarWidget:addActionItem(text, resName, handler, textColor)
	local iconWidget = _g.jk.widget.ImageWidget:forImageResource(self.context, resName)
	do iconWidget:setWidgetImageScaleMethod(_g.jk.widget.ImageWidget.FIT) end
	do iconWidget:setWidgetImageHeight(self.context:getHeightValue("5mm")) end
	do iconWidget:setWidgetImageWidth(self.context:getWidthValue("5mm")) end
	do
		local tc = self:determineTextColor(self.widgetBackgroundColor, textColor, self.defaultActionItemWidgetTextColor)
		local mm2 = self.context:getHeightValue("2mm")
		local lbl = _g.jk.widget.LabelWidget:forText(self.context, text)
		do lbl:setWidgetFontSize(mm2) end
		do lbl:setWidgetTextColor(tc) end
		do
			local vbox = _g.jk.widget.VerticalBoxWidget:forContext(self.context, 0, self.context:getHeightValue("1mm"))
			do vbox:addWidget(_g.jk.widget.AlignWidget:forWidget(self.context, iconWidget, 0.5, 0.5, 0)) end
			do vbox:addWidget(_g.jk.widget.AlignWidget:forWidget(self.context, lbl, 0.5, 0.5, 0)) end
			if handler ~= nil then
				do _g.jk.widget.Widget:setWidgetClickHandler(vbox, handler) end
			end
			do self:addToWidgetItems(vbox) end
			do return self end
		end
	end
end

function jk.widget.common.ToolbarWidget:addOverlay(widget)
	do self.overlayWidget:addWidget(widget) end
end

function jk.widget.common.ToolbarWidget:removeOverlay()
	if not (self.overlayWidget ~= nil) then
		do return false end
	end
	do _g.jk.widget.Widget:removeChildrenOf(self.overlayWidget) end
	do return true end
end

function jk.widget.common.ToolbarWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	self.overlayWidget = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
	do
		local bgc = self.widgetBackgroundColor
		if not (bgc ~= nil) then
			bgc = self.defaultActionItemWidgetBackgroundColor
		end
		if bgc ~= nil then
			do self:addWidget(_g.jk.widget.CanvasWidget:forColor(self.context, bgc)) end
		end
		do
			local hbox = _g.jk.widget.HorizontalBoxWidget:forContext(self.context, 0, 0)
			if self.widgetItems ~= nil then
				local n = 0
				local m = _g.jk.lang.Vector:getSize(self.widgetItems)
				do
					n = 0
					while n < m do
						local w = self.widgetItems[n + 1]
						if w ~= nil then
							do hbox:addWidget1(_g.jk.widget.AlignWidget:forWidget(self.context, w, 0.5, 0.5, 0), 1.0) end
						end
						do n = n + 1 end
					end
				end
			end
			do self:addWidget(_g.jk.widget.LayerWidget:forWidget(self.context, hbox, self.context:getHeightValue("1mm"))) end
			do self:addWidget(self.overlayWidget) end
		end
	end
end

function jk.widget.common.ToolbarWidget:getDefaultActionItemWidgetBackgroundColor()
	do return self.defaultActionItemWidgetBackgroundColor end
end

function jk.widget.common.ToolbarWidget:setDefaultActionItemWidgetBackgroundColor(v)
	self.defaultActionItemWidgetBackgroundColor = v
	do return self end
end

function jk.widget.common.ToolbarWidget:getDefaultActionItemWidgetTextColor()
	do return self.defaultActionItemWidgetTextColor end
end

function jk.widget.common.ToolbarWidget:setDefaultActionItemWidgetTextColor(v)
	self.defaultActionItemWidgetTextColor = v
	do return self end
end

function jk.widget.common.ToolbarWidget:getWidgetBackgroundColor()
	do return self.widgetBackgroundColor end
end

function jk.widget.common.ToolbarWidget:setWidgetBackgroundColor(v)
	self.widgetBackgroundColor = v
	do return self end
end

function jk.widget.common.ToolbarWidget:getWidgetItems()
	do return self.widgetItems end
end

function jk.widget.common.ToolbarWidget:setWidgetItems(v)
	self.widgetItems = v
	do return self end
end

jk.widget.common.CustomScrollBarWidget = _g.jk.widget.RenderableWidget._create()
jk.widget.common.CustomScrollBarWidget.__index = jk.widget.common.CustomScrollBarWidget
_vm:set_metatable(jk.widget.common.CustomScrollBarWidget, {
	__index = _g.jk.widget.RenderableWidget
})

function jk.widget.common.CustomScrollBarWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.CustomScrollBarWidget)
	return v
end

function jk.widget.common.CustomScrollBarWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.CustomScrollBarWidget'
	self['_isType.jk.widget.common.CustomScrollBarWidget'] = true
	self.widgetOnScrollCallback = nil
	self.widgetMaximumValueY = 1000.0
	self.widgetVisibleHeight = 40.0
	self.widgetScrollableHeight = 100.0
	self.widgetSpeedY = 0.5
	self.valueY = 0.0
	self.scrollBarY = 0.0
	self.scrollBarHeight = 0.0
end

function jk.widget.common.CustomScrollBarWidget:_construct0()
	jk.widget.common.CustomScrollBarWidget._init(self)
	do _g.jk.widget.RenderableWidget._construct0(self) end
	return self
end

function jk.widget.common.CustomScrollBarWidget:_construct1(context)
	jk.widget.common.CustomScrollBarWidget._init(self)
	do _g.jk.widget.RenderableWidget._construct1(self, context) end
	return self
end

function jk.widget.common.CustomScrollBarWidget:onWidgetResized()
	do self:computeScrollBarLayout() end
	do _g.jk.widget.RenderableWidget.onWidgetResized(self) end
end

function jk.widget.common.CustomScrollBarWidget:render(ctx)
	do ctx:clearRect(0, 0, _g.jk.widget.Widget:getWidth(self), _g.jk.widget.Widget:getHeight(self)) end
	do ctx:setFillStyle(_g.jk.gfx.Color:forString("red")) end
	do ctx:fillRect(0, self.scrollBarY, _g.jk.widget.Widget:getWidth(self), self.scrollBarHeight) end
	self.valueY = self.scrollBarY / (_g.jk.widget.Widget:getHeight(self) - _util:convert_to_integer(self.scrollBarHeight)) * self.widgetMaximumValueY
end

function jk.widget.common.CustomScrollBarWidget:computeScrollBarLayout()
	self.scrollBarHeight = self.widgetVisibleHeight / self.widgetScrollableHeight * _g.jk.widget.Widget:getHeight(self)
	self.scrollBarY = self.valueY / self.widgetMaximumValueY * (_g.jk.widget.Widget:getHeight(self) - _util:convert_to_integer(self.scrollBarHeight))
end

function jk.widget.common.CustomScrollBarWidget:onScroll(scrollX, scrollY)
	if self.widgetOnScrollCallback ~= nil then
		do self.widgetOnScrollCallback(scrollX, scrollY) end
	end
end

function jk.widget.common.CustomScrollBarWidget:getWidgetOnScrollCallback()
	do return self.widgetOnScrollCallback end
end

function jk.widget.common.CustomScrollBarWidget:setWidgetOnScrollCallback(v)
	self.widgetOnScrollCallback = v
	do return self end
end

function jk.widget.common.CustomScrollBarWidget:getWidgetMaximumValueY()
	do return self.widgetMaximumValueY end
end

function jk.widget.common.CustomScrollBarWidget:setWidgetMaximumValueY(v)
	self.widgetMaximumValueY = v
	do return self end
end

function jk.widget.common.CustomScrollBarWidget:getWidgetVisibleHeight()
	do return self.widgetVisibleHeight end
end

function jk.widget.common.CustomScrollBarWidget:setWidgetVisibleHeight(v)
	self.widgetVisibleHeight = v
	do return self end
end

function jk.widget.common.CustomScrollBarWidget:getWidgetScrollableHeight()
	do return self.widgetScrollableHeight end
end

function jk.widget.common.CustomScrollBarWidget:setWidgetScrollableHeight(v)
	self.widgetScrollableHeight = v
	do return self end
end

function jk.widget.common.CustomScrollBarWidget:getWidgetSpeedY()
	do return self.widgetSpeedY end
end

function jk.widget.common.CustomScrollBarWidget:setWidgetSpeedY(v)
	self.widgetSpeedY = v
	do return self end
end

jk.widget.common.SelectSearchWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.SelectSearchWidget.__index = jk.widget.common.SelectSearchWidget
_vm:set_metatable(jk.widget.common.SelectSearchWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.SelectSearchWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.SelectSearchWidget)
	return v
end

function jk.widget.common.SelectSearchWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.SelectSearchWidget'
	self['_isType.jk.widget.common.SelectSearchWidget'] = true
	self['_isType.jk.widget.WidgetWithValue'] = true
	self.defaultNoRecordMessage = "No record found"
	self.widgetOutlineColor = nil
	self.widgetItems = nil
	self.widgetValueChangeHandler = nil
	self.itemscontainer = nil
	self.myContainer = nil
	self.container = nil
	self.shown = false
	self.background = nil
	self.label = nil
	self.icon = nil
end

function jk.widget.common.SelectSearchWidget:_construct0()
	jk.widget.common.SelectSearchWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.SelectSearchWidget:_construct1(context)
	jk.widget.common.SelectSearchWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

jk.widget.common.SelectSearchWidget.MyContainerWidget = _g.jk.widget.ContainerWidget._create()
jk.widget.common.SelectSearchWidget.MyContainerWidget.__index = jk.widget.common.SelectSearchWidget.MyContainerWidget
_vm:set_metatable(jk.widget.common.SelectSearchWidget.MyContainerWidget, {
	__index = _g.jk.widget.ContainerWidget
})

function jk.widget.common.SelectSearchWidget.MyContainerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.SelectSearchWidget.MyContainerWidget)
	return v
end

function jk.widget.common.SelectSearchWidget.MyContainerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.SelectSearchWidget.MyContainerWidget'
	self['_isType.jk.widget.common.SelectSearchWidget.MyContainerWidget'] = true
	self.widget = nil
end

function jk.widget.common.SelectSearchWidget.MyContainerWidget:_construct0()
	jk.widget.common.SelectSearchWidget.MyContainerWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct0(self) end
	return self
end

function jk.widget.common.SelectSearchWidget.MyContainerWidget:_construct1(context)
	jk.widget.common.SelectSearchWidget.MyContainerWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.SelectSearchWidget.MyContainerWidget:onWidgetHeightChanged(height)
	local array = _g.jk.widget.Widget:getChildren(self)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local child = array[n + 1]
				if child ~= nil then
					do _g.jk.widget.Widget:move(child, _g.jk.widget.Widget:getAbsoluteX(self.widget), _g.jk.widget.Widget:getAbsoluteY(self.widget)) end
				end
				do n = n + 1 end
			end
		end
	end
end

function jk.widget.common.SelectSearchWidget.MyContainerWidget:computeWidgetLayout(widthConstraint)
	local array = _g.jk.widget.Widget:getChildren(self)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local child = array[n + 1]
				if child ~= nil then
					do _g.jk.widget.Widget:layout(child, _g.jk.widget.Widget:getWidth(self.widget), false) end
					do _g.jk.widget.Widget:move(child, _g.jk.widget.Widget:getAbsoluteX(self.widget), _g.jk.widget.Widget:getAbsoluteY(self.widget)) end
				end
				do n = n + 1 end
			end
		end
	end
	do _g.jk.widget.Widget:setLayoutSize(self, widthConstraint, _g.jk.widget.Widget:getHeight(self)) end
end

function jk.widget.common.SelectSearchWidget.MyContainerWidget:getWidget()
	do return self.widget end
end

function jk.widget.common.SelectSearchWidget.MyContainerWidget:setWidget(v)
	self.widget = v
	do return self end
end

function jk.widget.common.SelectSearchWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	self.itemscontainer = _g.jk.widget.VerticalBoxWidget:forContext(self.context, 0, 0)
	do
		local input = _g.jk.widget.common.TextInputWidget:forType(self.context, _g.jk.widget.common.TextInputWidget.TYPE_DEFAULT, "Search")
		do input:setWidgetPadding1(self.context:getHeightValue("1000um")) end
		do input:setWidgetTextChangeHandler(function()
			do self:onWidgetTextChanged(input:getWidgetText()) end
		end) end
		do
			local canvas = _g.jk.widget.CanvasWidget:forColor(self.context, _g.jk.gfx.Color:white())
			do canvas:setWidgetOutlineWidth(self.context:getHeightValue("100um")) end
			if self.widgetOutlineColor ~= nil then
				do self.background:setWidgetOutlineColor(self.widgetOutlineColor) end
				do canvas:setWidgetOutlineColor(self.widgetOutlineColor) end
			else
				do canvas:setWidgetOutlineColor(_g.jk.gfx.Color:black()) end
			end
			do
				local vbox = _g.jk.widget.VerticalBoxWidget:forContext(self.context, 0, 0)
				do vbox:addWidget(_g.jk.widget.LayerWidget:forWidget(self.context, input, self.context:getHeightValue("500um"))) end
				do vbox:addWidget(_g.jk.widget.LayerWidget:forWidget(self.context, self.itemscontainer, self.context:getHeightValue("500um"))) end
				self.container = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
				do self.container:addWidget(canvas) end
				do self.container:addWidget(vbox) end
				do _g.jk.widget.Widget:setWidgetClickHandler(self, function()
					if not self.shown then
						do self:showPopup() end
					else
						do self:closePopup() end
					end
				end) end
			end
		end
	end
end

function jk.widget.common.SelectSearchWidget:setWidgetPlaceholder(text)
	do self.label:setWidgetText(text) end
	do return self end
end

function jk.widget.common.SelectSearchWidget:setWidgetImageResource(resource)
	do self.icon:setWidgetImageResource(resource) end
	do return self end
end

function jk.widget.common.SelectSearchWidget:setWidgetBackgroundColor(color)
	do self.background:setWidgetColor(color) end
	do return self end
end

function jk.widget.common.SelectSearchWidget:onWidgetTextChanged(value)
	do self:clearItems() end
	do self:searchStringFromItems(value) end
end

function jk.widget.common.SelectSearchWidget:searchStringFromItems(value)
	if not (self.widgetItems ~= nil) or self.widgetItems:count() < 1 then
		do self:addItemToList(nil) end
	end
	do
		local isEmpty = false
		if _g.jk.lang.String:isEmpty(value) then
			isEmpty = true
		end
		do
			local it = self.widgetItems:iterate()
			while it ~= nil do
				local item = it:next()
				if not (item ~= nil) then
					do break end
				end
				if not isEmpty then
					if _g.jk.lang.String:contains(_g.jk.lang.String:toLowerCase(item.value), _g.jk.lang.String:toLowerCase(value)) then
						do self:addItemToList(item.value) end
					end
				else
					do self:addItemToList(item.value) end
				end
			end
			if _g.jk.lang.Vector:getSize(_g.jk.widget.Widget:getChildren(self.itemscontainer)) < 1 then
				do self:addItemToList(nil) end
			end
		end
	end
end

function jk.widget.common.SelectSearchWidget:clearItems()
	if not (self.itemscontainer ~= nil) then
		do return end
	end
	do _g.jk.widget.Widget:removeChildrenOf(self.itemscontainer) end
end

function jk.widget.common.SelectSearchWidget:setWidgetItems(items)
	self.widgetItems = items
	if not (self.widgetItems ~= nil) then
		do return end
	end
	do
		local it = self.widgetItems:iterate()
		while it ~= nil do
			local item = it:next()
			if not (item ~= nil) then
				do break end
			end
			do self:addItemToList(item.value) end
		end
	end
end

function jk.widget.common.SelectSearchWidget:createWidgetItem(title)
	local textColor = self.context:getStyleColor("SelectSearchWidget", "textColor", nil)
	if not (textColor ~= nil) then
		textColor = _g.jk.gfx.Color:black()
	end
	do
		local backgroundColor = self.context:getStyleColor("SelectSearchWidget", "itemBackgroundColor", nil)
		if not (backgroundColor ~= nil) then
			backgroundColor = _g.jk.gfx.Color:white()
		end
		do
			local padding = self.context:getStylePixels("SelectSearchWidget", "padding", nil)
			if padding < 1 then
				padding = self.context:getHeightValue("1000um")
			end
			do
				local fontSize = self.context:getStylePixels("SelectSearchWidget", "fontSize", nil)
				if fontSize < 1 then
					fontSize = self.context:getHeightValue("2mm")
				end
				do
					local t = title
					if _g.jk.lang.String:isEmpty(t) then
						t = self.defaultNoRecordMessage
					end
					do
						local ttitle = t
						local lbl = _g.jk.widget.LabelWidget:forText(self.context, ttitle)
						do lbl:setWidgetTextColor(textColor) end
						do
							local layer = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
							do layer:addWidget(_g.jk.widget.CanvasWidget:forColor(self.context, backgroundColor)) end
							do layer:addWidget(_g.jk.widget.LayerWidget:forWidget(self.context, lbl, padding)) end
							if _g.jk.lang.String:isNotEmpty(title) then
								do _g.jk.widget.Widget:setWidgetClickHandler(layer, function()
									do self.label:setWidgetText(ttitle) end
									do self:closePopup() end
									do self:onWidgetSelectionChanged() end
								end) end
							end
							do return layer end
						end
					end
				end
			end
		end
	end
end

function jk.widget.common.SelectSearchWidget:onWidgetSelectionChanged()
	if self.widgetValueChangeHandler ~= nil then
		do self.widgetValueChangeHandler() end
	end
end

function jk.widget.common.SelectSearchWidget:showPopup()
	if not (self.container ~= nil) then
		do return end
	end
	if self.shown then
		do return end
	end
	do
		local thisWidget = self
		local parentLayer = nil
		local parent = _g.jk.widget.Widget:getParent(thisWidget)
		while parent ~= nil do
			if (_vm:to_table_with_key(parent, '_isType.jk.widget.LayerWidget') ~= nil) then
				parentLayer = parent
			end
			parent = _g.jk.widget.Widget:getParent(parent)
		end
		if not (parentLayer ~= nil) then
			_io:write_to_stdout("[jk.widget.common.SelectSearchWidget.showPopup] (SelectSearchWidget.sling:234:3): No LayerWidget was found in the widget tree. Cannot show suggestions dropdown!" .. "\n")
			do return end
		end
		self.myContainer = _g.jk.widget.common.SelectSearchWidget.MyContainerWidget._construct1(_g.jk.widget.common.SelectSearchWidget.MyContainerWidget._create(), self.context)
		do self.myContainer:setWidget(thisWidget) end
		do self.myContainer:addWidget(self.container) end
		do parentLayer:addWidget(self.myContainer) end
		do
			local animationDestY = _g.jk.widget.Widget:getAbsoluteY(thisWidget)
			local ay = self.context:getHeightValue("3mm")
			do _g.jk.widget.Widget:move(self.container, _g.jk.widget.Widget:getAbsoluteX(thisWidget), animationDestY + ay) end
			do
				local anim = _g.jk.widget.WidgetAnimation:forDuration(self.context, 300)
				do anim:addCallback(function(completion)
					local bgf = completion * 1.5
					if bgf > 1.0 then
						bgf = 1.0
					end
					do _g.jk.widget.Widget:move(self.container, _g.jk.widget.Widget:getAbsoluteX(thisWidget), _util:convert_to_integer(animationDestY + _util:convert_to_integer((1.0 - completion) * ay))) end
				end) end
				do anim:start() end
				self.shown = true
			end
		end
	end
end

function jk.widget.common.SelectSearchWidget:closePopup()
	if not self.shown then
		do return end
	end
	do
		local anim = _g.jk.widget.WidgetAnimation:forDuration(self.context, 300)
		do anim:addFadeOut(self.myContainer, true) end
		do anim:start() end
		self.shown = false
	end
end

function jk.widget.common.SelectSearchWidget:addItemToList(item)
	local v = self:createWidgetItem(item)
	if v ~= nil then
		do self.itemscontainer:addWidget(v) end
	end
end

function jk.widget.common.SelectSearchWidget:findIndexForWidgetValue(value)
	local v = -1
	if self.widgetItems ~= nil then
		local n = 0
		local it = self.widgetItems:iterate()
		while it ~= nil do
			local item = it:next()
			if not (item ~= nil) then
				do break end
			end
			if item.value == value then
				v = n
				do break end
			end
			do n = n + 1 end
		end
	end
	do return v end
end

function jk.widget.common.SelectSearchWidget:getSelectedWidgetValue()
	local index = self:findIndexForWidgetValue(self.label:getWidgetText())
	if not (self.widgetItems ~= nil) or index < 0 then
		do return nil end
	end
	do return self.widgetItems:getKey(index) end
end

function jk.widget.common.SelectSearchWidget:setSelectedWidgetValue(value)
	do self.label:setWidgetText(value) end
end

function jk.widget.common.SelectSearchWidget:setWidgetValue(value)
	do self:setSelectedWidgetValue(_g.jk.lang.String:asString(value)) end
end

function jk.widget.common.SelectSearchWidget:getWidgetValue()
	do return self:getSelectedWidgetValue() end
end

function jk.widget.common.SelectSearchWidget:setWidgetValueChangeHandler(handler)
	self.widgetValueChangeHandler = handler
end

function jk.widget.common.SelectSearchWidget:createWidget()
	do _g.jk.widget.LayerWidget.createWidget(self) end
	do
		local thisWidget = self
		self.background = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
		do self.background:setWidgetColor(_g.jk.gfx.Color:white()) end
		do self.background:setWidgetOutlineWidth(self.context:getHeightValue("100um")) end
		do self.background:setWidgetOutlineColor(_g.jk.gfx.Color:black()) end
		do self:addWidget(self.background) end
		do
			local widget = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
			do widget:setWidgetMarginLeft(self.context:getHeightValue("1000um")) end
			do
				local widget2 = _g.jk.widget.AlignWidget._construct1(_g.jk.widget.AlignWidget._create(), self.context)
				self.label = _g.jk.widget.LabelWidget._construct1(_g.jk.widget.LabelWidget._create(), self.context)
				do self.label:setWidgetText("Select") end
				do widget2:addWidget1(self.label, 0.0, 0.5, false) end
				do widget:addWidget(widget2) end
				do self:addWidget(widget) end
				do
					local widget3 = _g.jk.widget.AlignWidget._construct1(_g.jk.widget.AlignWidget._create(), self.context)
					self.icon = _g.jk.widget.ImageWidget._construct1(_g.jk.widget.ImageWidget._create(), self.context)
					do self.icon:setWidgetImageResource("arrow_down") end
					do self.icon:setWidgetImageWidth(self.context:getHeightValue("7000um")) end
					do self.icon:setWidgetImageHeight(self.context:getHeightValue("7000um")) end
					do widget3:addWidget1(self.icon, 1.0, 0.5, false) end
					do self:addWidget(widget3) end
				end
			end
		end
	end
end

function jk.widget.common.SelectSearchWidget:getDefaultNoRecordMessage()
	do return self.defaultNoRecordMessage end
end

function jk.widget.common.SelectSearchWidget:setDefaultNoRecordMessage(v)
	self.defaultNoRecordMessage = v
	do return self end
end

function jk.widget.common.SelectSearchWidget:getWidgetOutlineColor()
	do return self.widgetOutlineColor end
end

function jk.widget.common.SelectSearchWidget:setWidgetOutlineColor(v)
	self.widgetOutlineColor = v
	do return self end
end

jk.widget.common.NavigationFrameWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.NavigationFrameWidget.__index = jk.widget.common.NavigationFrameWidget
_vm:set_metatable(jk.widget.common.NavigationFrameWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.NavigationFrameWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.NavigationFrameWidget)
	return v
end

function jk.widget.common.NavigationFrameWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.NavigationFrameWidget'
	self['_isType.jk.widget.common.NavigationFrameWidget'] = true
	self['_isType.jk.widget.TitleContainerWidget'] = true
	self.contentArea = nil
	self.actionBar = nil
	self.dimWidget = nil
	self.sidebarWidget = nil
	self.sidebarSlotLeft = nil
	self.sidebarIsFixed = false
	self.sidebarIsDisplayed = false
	self.widgetEnableSidebar = true
	self.widgetEnableActionBar = true
	self.widgetActionBarIsFloating = false
	self.widgetActionBarBackgroundColor = nil
	self.widgetActionBarTextColor = nil
	self.widgetActionBarMenuItemSpacing = 0
	self.widgetBackgroundColor = nil
	self.widgetBurgerMenuImageResourceName = "burger"
end

function jk.widget.common.NavigationFrameWidget:_construct0()
	jk.widget.common.NavigationFrameWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.NavigationFrameWidget:_construct1(ctx)
	jk.widget.common.NavigationFrameWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, ctx) end
	self.widgetActionBarBackgroundColor = _g.jk.gfx.Color:black()
	self.widgetActionBarTextColor = _g.jk.gfx.Color:white()
	return self
end

function jk.widget.common.NavigationFrameWidget:getActionBarMenuItems()
	do return nil end
end

function jk.widget.common.NavigationFrameWidget:getMenuHandler()
	do return nil end
end

function jk.widget.common.NavigationFrameWidget:getAppIconResource()
	do return nil end
end

function jk.widget.common.NavigationFrameWidget:getAppMenuHandler()
	do return nil end
end

function jk.widget.common.NavigationFrameWidget:getAppMenu()
	do return nil end
end

function jk.widget.common.NavigationFrameWidget:defaultLeftButtonConfiguration()
	if not (self.actionBar ~= nil) then
		do return end
	end
	do
		local handler = self:getMenuHandler()
		if self.widgetEnableSidebar == false then
			do self.actionBar:configureLeftButton(nil, nil) end
		elseif handler == nil then
			if self.sidebarIsFixed == false then
				do self.actionBar:configureLeftButton(self.widgetBurgerMenuImageResourceName, function()
					do self:displaySidebarWidget(true) end
				end) end
			else
				do self.actionBar:configureLeftButton(nil, nil) end
			end
		else
			do self.actionBar:configureLeftButton(self.widgetBurgerMenuImageResourceName, handler) end
		end
	end
end

function jk.widget.common.NavigationFrameWidget:updateMenuButton()
	do self:defaultLeftButtonConfiguration() end
end

function jk.widget.common.NavigationFrameWidget:createSidebarWidget()
	do return nil end
end

function jk.widget.common.NavigationFrameWidget:enableFixedSidebar()
	if self.sidebarWidget == nil or self.sidebarSlotLeft == nil or self.sidebarIsFixed then
		do return end
	end
	do self:hideSidebarWidget(false) end
	self.sidebarIsFixed = true
	do self.sidebarSlotLeft:addWidget(self.sidebarWidget) end
	do self:updateMenuButton() end
end

function jk.widget.common.NavigationFrameWidget:disableFixedSidebar()
	if self.sidebarIsDisplayed or self.sidebarIsFixed == false then
		do return end
	end
	do _g.jk.widget.Widget:removeFromParent(self.sidebarWidget) end
	self.sidebarIsFixed = false
	do self:updateMenuButton() end
end

function jk.widget.common.NavigationFrameWidget:updateSidebarWidthRequest(sz)
	local v = 0
	if self.sidebarIsFixed == false and self.sidebarIsDisplayed and self.sidebarWidget ~= nil then
		local layer = _vm:to_table_with_key(_g.jk.widget.Widget:getParent(self.sidebarWidget), '_isType.jk.widget.LayerWidget')
		if layer ~= nil then
			v = _util:convert_to_integer(0.8 * sz)
			do layer:setWidgetMaximumWidthRequest(v) end
		end
	end
	do return v end
end

function jk.widget.common.NavigationFrameWidget:computeWidgetLayout(widthConstraint)
	if widthConstraint > self.context:getWidthValue("200mm") then
		do self:enableFixedSidebar() end
	else
		do self:disableFixedSidebar() end
	end
	do _g.jk.widget.LayerWidget.computeWidgetLayout(self, widthConstraint) end
end

function jk.widget.common.NavigationFrameWidget:displaySidebarWidget(animated)
	if self.sidebarIsFixed or self.sidebarIsDisplayed or self.sidebarWidget == nil then
		do return end
	end
	if self.dimWidget == nil then
		self.dimWidget = _g.jk.widget.CanvasWidget:forColor(self.context, _g.jk.gfx.Color:forRGBADouble(0.0, 0.0, 0.0, 0.8))
	end
	do self:addWidget(self.dimWidget) end
	self.sidebarIsDisplayed = true
	do
		local box = _g.jk.widget.HorizontalBoxWidget._construct1(_g.jk.widget.HorizontalBoxWidget._create(), self.context)
		do box:addWidget(_g.jk.widget.LayerWidget:forWidget(self.context, self.sidebarWidget, 0)) end
		do
			local filler = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
			do _g.jk.widget.Widget:setWidgetClickHandler(filler, function()
				do self:hideSidebarWidget(true) end
			end) end
			do box:addWidget1(filler, 1) end
			do
				local sidebarWidthRequest = self:updateSidebarWidthRequest(_g.jk.widget.Widget:getWidth(self))
				do self:addWidget(box) end
				if animated then
					do _g.jk.widget.Widget:setAlpha(box, 0.0) end
					do
						local sx = -sidebarWidthRequest
						do _g.jk.widget.Widget:move(box, sx, _g.jk.widget.Widget:getY(box)) end
						do _g.jk.widget.Widget:setAlpha(self.dimWidget, 0.0) end
						do
							local anim = _g.jk.widget.WidgetAnimation:forDuration(self.context, 250)
							do anim:addCallback(function(completion)
								local dx = _util:convert_to_integer(sx + _util:convert_to_integer((0 - sx) * completion))
								if dx > 0 then
									dx = 0
								end
								do _g.jk.widget.Widget:move(box, dx, _g.jk.widget.Widget:getY(box)) end
								do _g.jk.widget.Widget:setAlpha(self.dimWidget, completion) end
								do _g.jk.widget.Widget:setAlpha(box, completion) end
							end) end
							do anim:start() end
						end
					end
				end
			end
		end
	end
end

function jk.widget.common.NavigationFrameWidget:hideSidebarWidget(animated)
	if self.sidebarIsDisplayed == false then
		do return end
	end
	self.sidebarIsDisplayed = false
	do
		local box = _g.jk.widget.Widget:getParent(_g.jk.widget.Widget:getParent(self.sidebarWidget))
		if animated then
			local fx = -_g.jk.widget.Widget:getWidth(self.sidebarWidget)
			local anim = _g.jk.widget.WidgetAnimation:forDuration(self.context, 250)
			do anim:addCallback(function(completion)
				local dx = _util:convert_to_integer(fx * completion)
				do _g.jk.widget.Widget:move(box, dx, _g.jk.widget.Widget:getY(box)) end
				do _g.jk.widget.Widget:setAlpha(self.dimWidget, 1.0 - completion) end
			end) end
			do anim:setEndListener(function()
				do _g.jk.widget.Widget:removeFromParent(self.sidebarWidget) end
				do _g.jk.widget.Widget:removeFromParent(box) end
				do _g.jk.widget.Widget:removeFromParent(self.dimWidget) end
			end) end
			do anim:start() end
		else
			do _g.jk.widget.Widget:removeFromParent(self.sidebarWidget) end
			do _g.jk.widget.Widget:removeFromParent(box) end
			do _g.jk.widget.Widget:removeFromParent(self.dimWidget) end
		end
	end
end

function jk.widget.common.NavigationFrameWidget:createBackground()
	local bgc = self:getWidgetBackgroundColor()
	if bgc ~= nil then
		do self:addWidget(_g.jk.widget.CanvasWidget:forColor(self.context, bgc)) end
	end
end

function jk.widget.common.NavigationFrameWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	do self:createBackground() end
	do
		local mainContainer = _g.jk.widget.VerticalBoxWidget:forContext(self.context, 0, 0)
		if self.widgetEnableActionBar then
			self.actionBar = _g.jk.widget.common.ActionBarWidget._construct1(_g.jk.widget.common.ActionBarWidget._create(), self.context)
			do self.actionBar:setWidgetBackgroundColor(self.widgetActionBarBackgroundColor) end
			do self.actionBar:setWidgetTextColor(self.widgetActionBarTextColor) end
			do self.actionBar:setWidgetMenuItemSpacing(self.widgetActionBarMenuItemSpacing) end
			do
				local appIcon = self:getAppIconResource()
				if _g.jk.lang.String:isEmpty(appIcon) == false then
					local menu = self:getAppMenu()
					if menu ~= nil then
						do self.actionBar:configureRightButtonMenu(appIcon, menu) end
					else
						local handler = self:getAppMenuHandler()
						if handler ~= nil then
							do self.actionBar:configureRightButton(appIcon, handler) end
						end
					end
				end
			end
		end
		if self.actionBar ~= nil and self.widgetActionBarIsFloating == false then
			do mainContainer:addWidget(self.actionBar) end
		end
		self.contentArea = _g.jk.widget.common.SwitcherLayerWidget._construct1(_g.jk.widget.common.SwitcherLayerWidget._create(), self.context)
		if self.actionBar ~= nil and self.widgetActionBarIsFloating == true then
			local ll = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
			do ll:addWidget(self.contentArea) end
			do ll:addWidget(_g.jk.widget.VerticalBoxWidget:forContext(self.context, 0, 0):addWidget1(self.actionBar, 0.0):addWidget1(_g.jk.widget.ContainerWidget._construct1(_g.jk.widget.ContainerWidget._create(), self.context), 1.0)) end
			do mainContainer:addWidget1(ll, 1.0) end
		else
			do mainContainer:addWidget1(self.contentArea, 1.0) end
		end
		do
			local superMainContainer = _g.jk.widget.HorizontalBoxWidget:forContext(self.context, 0, 0)
			self.sidebarSlotLeft = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
			do superMainContainer:addWidget(self.sidebarSlotLeft) end
			do superMainContainer:addWidget1(mainContainer, 1) end
			do self:addWidget(superMainContainer) end
			self.sidebarWidget = self:createSidebarWidget()
			do self:updateMenuButton() end
		end
	end
end

function jk.widget.common.NavigationFrameWidget:updateWidgetTitle(title)
	if self.actionBar ~= nil then
		do self.actionBar:setWidgetTitle(title) end
	end
end

function jk.widget.common.NavigationFrameWidget:onCurrentWidgetChanged()
	if not (self.contentArea ~= nil) then
		do return end
	end
	do
		local widget = nil
		local widgets = _g.jk.widget.Widget:getChildren(self.contentArea)
		if widgets ~= nil and _g.jk.lang.Vector:getSize(widgets) > 0 then
			widget = _g.jk.lang.Vector:get(widgets, _g.jk.lang.Vector:getSize(widgets) - 1)
		end
		if widget ~= nil and (_vm:to_table_with_key(widget, '_isType.jk.widget.DisplayAwareWidget') ~= nil) then
			do widget:onWidgetDisplayed() end
		end
		if widget ~= nil and (_vm:to_table_with_key(widget, '_isType.jk.widget.TitledWidget') ~= nil) then
			do self:updateWidgetTitle(widget:getWidgetTitle()) end
		else
			do self:updateWidgetTitle("") end
		end
		if widget ~= nil and (_vm:to_table_with_key(widget, '_isType.jk.widget.common.ActionBarControlWidget') ~= nil) then
			if not (self.actionBar ~= nil) then
				do return end
			end
			do self.actionBar:removeOverlay() end
			do
				local customBar = widget:createActionBarOverlay(self.actionBar)
				if customBar ~= nil then
					do self.actionBar:addOverlay(customBar) end
				end
				do self.actionBar:clearMenuItems() end
				do
					local menuItems = widget:getActionBarItems()
					if menuItems ~= nil then
						do self.actionBar:configureMenuItems(menuItems) end
					end
					do widget:setActionBarBackgroundColor(self.actionBar) end
				end
			end
		else
			if self.actionBar ~= nil then
				do self.actionBar:removeOverlay() end
				do self.actionBar:clearMenuItems() end
				do self.actionBar:setActionBarBackgroundColor(self.widgetActionBarBackgroundColor) end
			end
			do
				local menuItems = self:getActionBarMenuItems()
				if menuItems ~= nil then
					do self.actionBar:configureMenuItems(menuItems) end
				end
			end
		end
		do self:updateMenuButton() end
	end
end

function jk.widget.common.NavigationFrameWidget:createWidget()
	do _g.jk.widget.LayerWidget.createWidget(self) end
	do
		local thisWidget = self
	end
end

function jk.widget.common.NavigationFrameWidget:getWidgetEnableSidebar()
	do return self.widgetEnableSidebar end
end

function jk.widget.common.NavigationFrameWidget:setWidgetEnableSidebar(v)
	self.widgetEnableSidebar = v
	do return self end
end

function jk.widget.common.NavigationFrameWidget:getWidgetEnableActionBar()
	do return self.widgetEnableActionBar end
end

function jk.widget.common.NavigationFrameWidget:setWidgetEnableActionBar(v)
	self.widgetEnableActionBar = v
	do return self end
end

function jk.widget.common.NavigationFrameWidget:getWidgetActionBarIsFloating()
	do return self.widgetActionBarIsFloating end
end

function jk.widget.common.NavigationFrameWidget:setWidgetActionBarIsFloating(v)
	self.widgetActionBarIsFloating = v
	do return self end
end

function jk.widget.common.NavigationFrameWidget:getWidgetActionBarBackgroundColor()
	do return self.widgetActionBarBackgroundColor end
end

function jk.widget.common.NavigationFrameWidget:setWidgetActionBarBackgroundColor(v)
	self.widgetActionBarBackgroundColor = v
	do return self end
end

function jk.widget.common.NavigationFrameWidget:getWidgetActionBarTextColor()
	do return self.widgetActionBarTextColor end
end

function jk.widget.common.NavigationFrameWidget:setWidgetActionBarTextColor(v)
	self.widgetActionBarTextColor = v
	do return self end
end

function jk.widget.common.NavigationFrameWidget:getWidgetActionBarMenuItemSpacing()
	do return self.widgetActionBarMenuItemSpacing end
end

function jk.widget.common.NavigationFrameWidget:setWidgetActionBarMenuItemSpacing(v)
	self.widgetActionBarMenuItemSpacing = v
	do return self end
end

function jk.widget.common.NavigationFrameWidget:getWidgetBackgroundColor()
	do return self.widgetBackgroundColor end
end

function jk.widget.common.NavigationFrameWidget:setWidgetBackgroundColor(v)
	self.widgetBackgroundColor = v
	do return self end
end

function jk.widget.common.NavigationFrameWidget:getWidgetBurgerMenuImageResourceName()
	do return self.widgetBurgerMenuImageResourceName end
end

function jk.widget.common.NavigationFrameWidget:setWidgetBurgerMenuImageResourceName(v)
	self.widgetBurgerMenuImageResourceName = v
	do return self end
end

jk.widget.common.ProgressBarWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.ProgressBarWidget.__index = jk.widget.common.ProgressBarWidget
_vm:set_metatable(jk.widget.common.ProgressBarWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.ProgressBarWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.ProgressBarWidget)
	return v
end

function jk.widget.common.ProgressBarWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.ProgressBarWidget'
	self['_isType.jk.widget.common.ProgressBarWidget'] = true
	self.widgetProgressBarColor = _g.jk.gfx.Color:black()
	self.minimumPercentage = 0
	self.maximumPercentage = 100
	self.currentPercentage = 0
	self.totalPercentage = 0
	self.widgetWidth = 0
	self.layer = nil
	self.hbox = nil
	self.container = nil
	self.canvas = nil
end

function jk.widget.common.ProgressBarWidget:_construct0()
	jk.widget.common.ProgressBarWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.ProgressBarWidget:_construct1(context)
	jk.widget.common.ProgressBarWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.ProgressBarWidget:updateProgress(value)
	self.currentPercentage = value
	do
		local percentage = _util:convert_to_integer(100 / self.maximumPercentage) * self.currentPercentage
		if percentage < self.minimumPercentage then
			percentage = self.minimumPercentage
		end
		self.totalPercentage = percentage
		self.widgetWidth = _util:convert_to_integer(_g.jk.widget.Widget:getWidth(self.layer) / self.maximumPercentage) * percentage
		if self.totalPercentage <= 100 then
			if self.totalPercentage < 1 then
				self.totalPercentage = 0
				do self.canvas:setWidgetColor(_g.jk.gfx.Color:white()) end
			else
				do self.canvas:setWidgetColor(self.widgetProgressBarColor) end
			end
			do self.container:setWidgetWidthRequest(self.widgetWidth) end
		end
	end
end

function jk.widget.common.ProgressBarWidget:createWidget()
	do _g.jk.widget.LayerWidget.createWidget(self) end
	do
		local thisWidget = self
		do self:setWidgetHeightRequest(self.context:getHeightValue("10mm")) end
		self.layer = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
		do self.layer:setWidgetMargin(self.context:getHeightValue("1px")) end
		do
			local widget = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
			do widget:setWidgetOutlineColor(_g.jk.gfx.Color:black()) end
			do widget:setWidgetOutlineWidth(self.context:getHeightValue("1px")) end
			do self.layer:addWidget(widget) end
			self.hbox = _g.jk.widget.HorizontalBoxWidget._construct1(_g.jk.widget.HorizontalBoxWidget._create(), self.context)
			self.container = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
			self.canvas = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
			do self.container:addWidget(self.canvas) end
			do self.hbox:addWidget(self.container) end
			do self.layer:addWidget(self.hbox) end
			do self:addWidget(self.layer) end
		end
	end
end

function jk.widget.common.ProgressBarWidget:getWidgetProgressBarColor()
	do return self.widgetProgressBarColor end
end

function jk.widget.common.ProgressBarWidget:setWidgetProgressBarColor(v)
	self.widgetProgressBarColor = v
	do return self end
end

function jk.widget.common.ProgressBarWidget:getMinimumPercentage()
	do return self.minimumPercentage end
end

function jk.widget.common.ProgressBarWidget:setMinimumPercentage(v)
	self.minimumPercentage = v
	do return self end
end

function jk.widget.common.ProgressBarWidget:getMaximumPercentage()
	do return self.maximumPercentage end
end

function jk.widget.common.ProgressBarWidget:setMaximumPercentage(v)
	self.maximumPercentage = v
	do return self end
end

jk.widget.common.LoadingWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.LoadingWidget.__index = jk.widget.common.LoadingWidget
_vm:set_metatable(jk.widget.common.LoadingWidget, {
	__index = _g.jk.widget.LayerWidget
})

jk.widget.common.LoadingWidget.displayText = nil
jk.widget.common.LoadingWidget.displayImage = nil

function jk.widget.common.LoadingWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.LoadingWidget)
	return v
end

function jk.widget.common.LoadingWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.LoadingWidget'
	self['_isType.jk.widget.common.LoadingWidget'] = true
	self.loading = nil
	self.animation = nil
end

function jk.widget.common.LoadingWidget:_construct0()
	jk.widget.common.LoadingWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.LoadingWidget:_construct1(context)
	jk.widget.common.LoadingWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.LoadingWidget:initializeWithText(text)
	_g.jk.widget.common.LoadingWidget.displayText = text
	_g.jk.widget.common.LoadingWidget.displayImage = nil
end

function jk.widget.common.LoadingWidget:initializeWithImage(image)
	_g.jk.widget.common.LoadingWidget.displayText = nil
	_g.jk.widget.common.LoadingWidget.displayImage = image
end

function jk.widget.common.LoadingWidget:openPopup(context, widget)
	local v = _g.jk.widget.common.LoadingWidget._construct1(_g.jk.widget.common.LoadingWidget._create(), context)
	if v:showPopup(widget) == false then
		v = nil
	end
	do return v end
end

function jk.widget.common.LoadingWidget:closePopup(widget)
	if widget ~= nil then
		do widget:stop() end
		do _g.jk.widget.Widget:removeFromParent(widget) end
	end
	do return nil end
end

function jk.widget.common.LoadingWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	do
		local background = _g.jk.widget.CanvasWidget:forColor(self.context, _g.jk.gfx.Color:forRGBADouble(0, 0, 0, 0.8))
		do _g.jk.widget.Widget:setWidgetClickHandler(background, function()
		end) end
		do self:addWidget(background) end
		if _g.jk.widget.common.LoadingWidget.displayImage ~= nil then
			local img = _g.jk.widget.ImageWidget:forImage(self.context, _g.jk.widget.common.LoadingWidget.displayImage)
			do img:setWidgetImageHeight(self.context:getHeightValue("20mm")) end
			self.loading = img
		else
			local text = _g.jk.widget.common.LoadingWidget.displayText
			if _g.jk.lang.String:isEmpty(text) then
				text = "Loading .."
			end
			do
				local lt = _g.jk.widget.LabelWidget:forText(self.context, text)
				do lt:setWidgetTextColor(_g.jk.gfx.Color:white()) end
				do lt:setWidgetFontSize(self.context:getHeightValue("3mm")) end
				self.loading = lt
			end
		end
		do self:addWidget(_g.jk.widget.AlignWidget:forWidget(self.context, self.loading, 0.5, 0.5, 0)) end
		do self:start() end
	end
end

function jk.widget.common.LoadingWidget:start()
	self.animation = _g.jk.widget.WidgetAnimation:forDuration(self.context, 1000)
	do self.animation:addFadeOutIn(self.loading) end
	do self.animation:setShouldLoop(true) end
	do self.animation:start() end
end

function jk.widget.common.LoadingWidget:stop()
	if self.animation ~= nil then
		do self.animation:setShouldStop(true) end
		self.animation = nil
	end
end

function jk.widget.common.LoadingWidget:showPopup(target)
	local topmost = _g.jk.widget.LayerWidget:findTopMostLayerWidget(target)
	if topmost == nil then
		do return false end
	end
	do topmost:addWidget(self) end
	do return true end
end

jk.widget.common.PopupWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.PopupWidget.__index = jk.widget.common.PopupWidget
_vm:set_metatable(jk.widget.common.PopupWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.PopupWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.PopupWidget)
	return v
end

function jk.widget.common.PopupWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.PopupWidget'
	self['_isType.jk.widget.common.PopupWidget'] = true
	self.widgetContext = nil
	self.widgetContainerBackgroundColor = nil
	self.widgetContainer = nil
	self.widgetContent = nil
	self.animationDestY = 0
	self.popupShowAnimationEndHandler = nil
	self.popupHideAnimationEndHandler = nil
	self.widgetModal = true
end

function jk.widget.common.PopupWidget:_construct0()
	jk.widget.common.PopupWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.PopupWidget:forContentWidget(context, widget)
	local v = _g.jk.widget.common.PopupWidget._construct1(_g.jk.widget.common.PopupWidget._create(), context)
	do v:setWidgetContent(widget) end
	do return v end
end

function jk.widget.common.PopupWidget:_construct1(ctx)
	jk.widget.common.PopupWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, ctx) end
	self.widgetContext = ctx
	return self
end

function jk.widget.common.PopupWidget:setWidgetContainerBackgroundColor(color)
	if color ~= nil then
		self.widgetContainerBackgroundColor = _g.jk.widget.CanvasWidget:forColor(self.widgetContext, color)
	end
end

function jk.widget.common.PopupWidget:setWidgetContent(widget)
	if widget ~= nil then
		self.widgetContent = widget
	end
end

function jk.widget.common.PopupWidget:getWidgetContainerBackgroundColor()
	do return self.widgetContainerBackgroundColor end
end

function jk.widget.common.PopupWidget:getWidgetContent()
	do return self.widgetContent end
end

function jk.widget.common.PopupWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	if self.widgetContainerBackgroundColor == nil then
		self.widgetContainerBackgroundColor = _g.jk.widget.CanvasWidget:forColor(self.widgetContext, _g.jk.gfx.Color:forRGBADouble(0, 0, 0, 0.8))
		do _g.jk.widget.Widget:setWidgetClickHandler(self.widgetContainerBackgroundColor, function()
			if not self.widgetModal then
				do self:hidePopup() end
			end
		end) end
	end
	do self:addWidget(self.widgetContainerBackgroundColor) end
	if self.widgetContent ~= nil then
		do self:addWidget(_g.jk.widget.AlignWidget:forWidget(self.widgetContext, self.widgetContent, 0.5, 0.5, 0)) end
	end
end

function jk.widget.common.PopupWidget:onWidgetHeightChanged(height)
	do _g.jk.widget.LayerWidget.onWidgetHeightChanged(self, height) end
	self.animationDestY = _g.jk.widget.Widget:getY(self.widgetContent)
end

function jk.widget.common.PopupWidget:computeWidgetLayout(widthConstraint)
	do _g.jk.widget.LayerWidget.computeWidgetLayout(self, widthConstraint) end
	self.animationDestY = _g.jk.widget.Widget:getY(self.widgetContent)
end

function jk.widget.common.PopupWidget:showPopup(widget)
	local parentLayer = nil
	local parent = widget
	while parent ~= nil do
		if (_vm:to_table_with_key(parent, '_isType.jk.widget.LayerWidget') ~= nil) then
			parentLayer = parent
		end
		parent = _g.jk.widget.Widget:getParent(parent)
	end
	if parentLayer == nil then
		_io:write_to_stdout("[jk.widget.common.PopupWidget.showPopup] (PopupWidget.sling:121:4): No LayerWidget was found in the widget tree. Cannot show popup!" .. "\n")
		do return end
	end
	self.widgetContainer = _g.jk.widget.VerticalScrollerWidget._construct1(_g.jk.widget.VerticalScrollerWidget._create(), self.context)
	do self.widgetContainer:setWidgetScrollBarDisabled(true) end
	do self.widgetContainer:addWidget(self) end
	do parentLayer:addWidget(self.widgetContainer) end
	do _g.jk.widget.Widget:setAlpha(self.widgetContainerBackgroundColor, 0) end
	do _g.jk.widget.Widget:setAlpha(self.widgetContent, 0) end
	self.animationDestY = _g.jk.widget.Widget:getY(self.widgetContent)
	do
		local ay = self.context:getHeightValue("3mm")
		do _g.jk.widget.Widget:move(self.widgetContent, _g.jk.widget.Widget:getX(self.widgetContent), self.animationDestY + ay) end
		do
			local anim = _g.jk.widget.WidgetAnimation:forDuration(self.context, 300)
			do anim:addCallback(function(completion)
				local bgf = completion * 1.5
				if bgf > 1.0 then
					bgf = 1.0
				end
				do _g.jk.widget.Widget:setAlpha(self.widgetContainerBackgroundColor, bgf) end
				do _g.jk.widget.Widget:setAlpha(self.widgetContent, completion) end
				do _g.jk.widget.Widget:move(self.widgetContent, _g.jk.widget.Widget:getX(self.widgetContent), _util:convert_to_integer(self.animationDestY + _util:convert_to_integer((1.0 - completion) * ay))) end
			end) end
			do anim:setEndListener(function()
				if self.popupShowAnimationEndHandler ~= nil then
					do self.popupShowAnimationEndHandler() end
				end
			end) end
			do anim:start() end
		end
	end
end

function jk.widget.common.PopupWidget:hidePopup()
	local anim = _g.jk.widget.WidgetAnimation:forDuration(self.context, 300)
	do anim:addFadeOut(self.widgetContainer, true) end
	do anim:setEndListener(function()
		if self.popupHideAnimationEndHandler ~= nil then
			do self.popupHideAnimationEndHandler() end
		end
	end) end
	do anim:start() end
end

function jk.widget.common.PopupWidget:getPopupShowAnimationEndHandler()
	do return self.popupShowAnimationEndHandler end
end

function jk.widget.common.PopupWidget:setPopupShowAnimationEndHandler(v)
	self.popupShowAnimationEndHandler = v
	do return self end
end

function jk.widget.common.PopupWidget:getPopupHideAnimationEndHandler()
	do return self.popupHideAnimationEndHandler end
end

function jk.widget.common.PopupWidget:setPopupHideAnimationEndHandler(v)
	self.popupHideAnimationEndHandler = v
	do return self end
end

function jk.widget.common.PopupWidget:getWidgetModal()
	do return self.widgetModal end
end

function jk.widget.common.PopupWidget:setWidgetModal(v)
	self.widgetModal = v
	do return self end
end

jk.widget.common.SwitcherLayerWidget = _g.jk.widget.ContainerWidget._create()
jk.widget.common.SwitcherLayerWidget.__index = jk.widget.common.SwitcherLayerWidget
_vm:set_metatable(jk.widget.common.SwitcherLayerWidget, {
	__index = _g.jk.widget.ContainerWidget
})

function jk.widget.common.SwitcherLayerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.SwitcherLayerWidget)
	return v
end

function jk.widget.common.SwitcherLayerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.SwitcherLayerWidget'
	self['_isType.jk.widget.common.SwitcherLayerWidget'] = true
	self.margin = 0
end

function jk.widget.common.SwitcherLayerWidget:_construct0()
	jk.widget.common.SwitcherLayerWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct0(self) end
	return self
end

function jk.widget.common.SwitcherLayerWidget:_construct1(context)
	jk.widget.common.SwitcherLayerWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.SwitcherLayerWidget:findTopMostLayerWidget(widget)
	local v = nil
	local pp = widget
	while pp ~= nil do
		if (_vm:to_table_with_key(pp, '_isType.jk.widget.common.SwitcherLayerWidget') ~= nil) then
			v = pp
		end
		pp = _g.jk.widget.Widget:getParent(pp)
	end
	do return v end
end

function jk.widget.common.SwitcherLayerWidget:forMargin(context, margin)
	local v = _g.jk.widget.common.SwitcherLayerWidget._construct1(_g.jk.widget.common.SwitcherLayerWidget._create(), context)
	v.margin = margin
	do return v end
end

function jk.widget.common.SwitcherLayerWidget:forWidget(context, widget, margin)
	local v = _g.jk.widget.common.SwitcherLayerWidget._construct1(_g.jk.widget.common.SwitcherLayerWidget._create(), context)
	v.margin = margin
	do v:addWidget(widget) end
	do return v end
end

function jk.widget.common.SwitcherLayerWidget:forWidgets(context, widgets, margin)
	local v = _g.jk.widget.common.SwitcherLayerWidget._construct1(_g.jk.widget.common.SwitcherLayerWidget._create(), context)
	v.margin = margin
	if widgets ~= nil then
		local n = 0
		local m = #widgets
		do
			n = 0
			while n < m do
				local widget = widgets[n + 1]
				if widget ~= nil then
					do v:addWidget(widget) end
				end
				do n = n + 1 end
			end
		end
	end
	do return v end
end

function jk.widget.common.SwitcherLayerWidget:onWidgetHeightChanged(height)
	do _g.jk.widget.ContainerWidget.onWidgetHeightChanged(self, height) end
	do
		local children = _g.jk.widget.Widget:getChildren(self)
		if children ~= nil then
			local topmost = _g.jk.lang.Vector:get(children, _g.jk.lang.Vector:getSize(children) - 1)
			if topmost ~= nil then
				do _g.jk.widget.Widget:resizeHeight(topmost, height - self.margin - self.margin) end
			end
		end
	end
end

function jk.widget.common.SwitcherLayerWidget:computeWidgetLayout(widthConstraint)
	local children = _g.jk.widget.Widget:getChildren(self)
	if not (children ~= nil) then
		do return end
	end
	do
		local childCount = _g.jk.lang.Vector:getSize(children)
		local wc = -1
		if widthConstraint >= 0 then
			wc = widthConstraint - self.margin - self.margin
			if wc < 0 then
				wc = 0
			end
		end
		do
			local mw = 0
			local mh = 0
			local n = 0
			local array = _g.jk.widget.Widget:getChildren(self)
			if array ~= nil then
				local n2 = 0
				local m = _g.jk.lang.Vector:getSize(array)
				do
					n2 = 0
					while n2 < m do
						local child = array[n2 + 1]
						if child ~= nil then
							if n == childCount - 1 then
								do _g.jk.widget.Widget:layout(child, wc, false) end
								mw = _g.jk.widget.Widget:getWidth(child)
								mh = _g.jk.widget.Widget:getHeight(child)
								do _g.jk.widget.Widget:move(child, self.margin, self.margin) end
							else
								local ww = _g.jk.widget.Widget:getWidth(child)
								do _g.jk.widget.Widget:move(child, -ww, self.margin) end
							end
							do n = n + 1 end
						end
						do n2 = n2 + 1 end
					end
				end
			end
			do _g.jk.widget.Widget:setLayoutSize(self, mw + self.margin + self.margin, mh + self.margin + self.margin) end
		end
	end
end

function jk.widget.common.SwitcherLayerWidget:removeAllChildren()
	do _g.jk.widget.Widget:removeChildrenOf(self) end
end

function jk.widget.common.SwitcherLayerWidget:getChildWidget(index)
	local children = _g.jk.widget.Widget:getChildren(self)
	if not (children ~= nil) then
		do return nil end
	end
	do return _g.jk.lang.Vector:get(children, index) end
end

jk.widget.common.CheckBoxWidget = _g.jk.widget.Widget._create()
jk.widget.common.CheckBoxWidget.__index = jk.widget.common.CheckBoxWidget
_vm:set_metatable(jk.widget.common.CheckBoxWidget, {
	__index = _g.jk.widget.Widget
})

function jk.widget.common.CheckBoxWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.CheckBoxWidget)
	return v
end

function jk.widget.common.CheckBoxWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.CheckBoxWidget'
	self['_isType.jk.widget.common.CheckBoxWidget'] = true
	self['_isType.jk.widget.WidgetWithValue'] = true
	self.widgetContext = nil
	self.widgetText = nil
	self.widgetTextColor = nil
	self.widgetFontResource = nil
	self.widgetFontFamily = nil
	self.widgetCheckHandler = nil
end

function jk.widget.common.CheckBoxWidget:_construct0()
	jk.widget.common.CheckBoxWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	return self
end

function jk.widget.common.CheckBoxWidget:forText(context, text)
	local v = _g.jk.widget.common.CheckBoxWidget._construct1(_g.jk.widget.common.CheckBoxWidget._create(), context)
	do v:setWidgetText(text) end
	do return v end
end

function jk.widget.common.CheckBoxWidget:_construct1(context)
	jk.widget.common.CheckBoxWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	self.widgetContext = context
	self.widgetFontFamily = "Arial"
	self.widgetTextColor = _g.jk.gfx.Color:black()
	do self:setWidgetTextColor(self.widgetTextColor) end
	return self
end

function jk.widget.common.CheckBoxWidget:setWidgetText(text)
	self.widgetText = text
	_io:write_to_stdout("[jk.widget.common.CheckBoxWidget.setWidgetText] (CheckBoxWidget.sling:198:3): Not implemented" .. "\n")
end

function jk.widget.common.CheckBoxWidget:getWidgetText()
	do return self.widgetText end
end

function jk.widget.common.CheckBoxWidget:setWidgetTextColor(color)
	self.widgetTextColor = color
	do self:updateWidgetFont() end
	do return self end
end

function jk.widget.common.CheckBoxWidget:getWidgetTextColor()
	do return self.widgetTextColor end
end

function jk.widget.common.CheckBoxWidget:setWidgetFontFamily(font)
	self.widgetFontFamily = font
	do self:updateWidgetFont() end
	do return self end
end

function jk.widget.common.CheckBoxWidget:setWidgetFontResource(res)
	self.widgetFontResource = res
	do self:updateWidgetFont() end
	do return self end
end

function jk.widget.common.CheckBoxWidget:updateWidgetFont()
	_io:write_to_stdout("[jk.widget.common.CheckBoxWidget.updateWidgetFont] (CheckBoxWidget.sling:270:3): Not implemented" .. "\n")
end

function jk.widget.common.CheckBoxWidget:getWidgetChecked()
	_io:write_to_stdout("[jk.widget.common.CheckBoxWidget.getWidgetChecked] (CheckBoxWidget.sling:298:3): Not implemented." .. "\n")
	do return false end
end

function jk.widget.common.CheckBoxWidget:setWidgetChecked(x)
	_io:write_to_stdout("[jk.widget.common.CheckBoxWidget.setWidgetChecked] (CheckBoxWidget.sling:334:3): Not implemented" .. "\n")
end

function jk.widget.common.CheckBoxWidget:setWidgetValue(value)
	do self:setWidgetChecked(_g.jk.lang.Boolean:asBoolean(value, false)) end
end

function jk.widget.common.CheckBoxWidget:getWidgetValue()
	do return _g.jk.lang.Boolean:asObject(self:getWidgetChecked()) end
end

function jk.widget.common.CheckBoxWidget:onCheckChangeListener()
	if self.widgetCheckHandler ~= nil then
		do self.widgetCheckHandler() end
	end
end

function jk.widget.common.CheckBoxWidget:getWidgetCheckHandler()
	do return self.widgetCheckHandler end
end

function jk.widget.common.CheckBoxWidget:setWidgetCheckHandler(v)
	self.widgetCheckHandler = v
	do return self end
end

jk.widget.common.ActionBarWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.ActionBarWidget.__index = jk.widget.common.ActionBarWidget
_vm:set_metatable(jk.widget.common.ActionBarWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.ActionBarWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.ActionBarWidget)
	return v
end

function jk.widget.common.ActionBarWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.ActionBarWidget'
	self['_isType.jk.widget.common.ActionBarWidget'] = true
	self['_isType.jk.widget.ScreenAwareWidget'] = true
	self.widgetBackgroundColor = nil
	self.widgetTextColor = nil
	self.widgetMenuItemSpacing = 0
	self.widgetTitle = nil
	self.widgetLeftIconResource = nil
	self.widgetLeftAction = nil
	self.widgetRightIconResource = nil
	self.widgetRightAction = nil
	self.widgetTitleContainer = nil
	self.label = nil
	self.leftButton = nil
	self.rightButton = nil
	self.box = nil
	self.menuItems = nil
	self.overlayWidget = nil
	self.canvas = nil
end

function jk.widget.common.ActionBarWidget:_construct0()
	jk.widget.common.ActionBarWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.ActionBarWidget:_construct1(context)
	jk.widget.common.ActionBarWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.ActionBarWidget:setWidgetTitle(value)
	self.widgetTitle = value
	if self.label ~= nil then
		do self.label:setWidgetText(self.widgetTitle) end
	end
	do _g.jk.widget.Widget:setLayoutSize(self.label, -1, _g.jk.widget.Widget:getHeight(self.label)) end
	do return self end
end

function jk.widget.common.ActionBarWidget:setWidgetTitleAlignment(align)
	if not (self.widgetTitleContainer ~= nil) then
		do return end
	end
	do self.widgetTitleContainer:setAlignForIndex(0, align, 0.5) end
end

function jk.widget.common.ActionBarWidget:setActionBarMargin(margin)
	if not (self.box ~= nil) then
		do return end
	end
	do self.box:setWidgetMargin(margin) end
end

function jk.widget.common.ActionBarWidget:setActionBarMarginLeft(margin)
	if not (self.box ~= nil) then
		do return end
	end
	do self.box:setWidgetMarginLeft(margin) end
end

function jk.widget.common.ActionBarWidget:setActionBarMarginRight(margin)
	if not (self.box ~= nil) then
		do return end
	end
	do self.box:setWidgetMarginRight(margin) end
end

function jk.widget.common.ActionBarWidget:setActionBarMarginTop(margin)
	if not (self.box ~= nil) then
		do return end
	end
	do self.box:setWidgetMarginTop(margin) end
end

function jk.widget.common.ActionBarWidget:setActionBarMarginBottom(margin)
	if not (self.box ~= nil) then
		do return end
	end
	do self.box:setWidgetMarginBottom(margin) end
end

function jk.widget.common.ActionBarWidget:getWidgetTitleLabel()
	do return self.label end
end

function jk.widget.common.ActionBarWidget:getWidgetTitle()
	do return self.widgetTitle end
end

function jk.widget.common.ActionBarWidget:configureLeftButton(iconResource, action)
	self.widgetLeftIconResource = iconResource
	self.widgetLeftAction = action
	do self:updateLeftButton() end
end

function jk.widget.common.ActionBarWidget:configureRightButton(iconResource, action)
	self.widgetRightIconResource = iconResource
	self.widgetRightAction = action
	do self:updateRightButton() end
end

function jk.widget.common.ActionBarWidget:configureRightButtonMenu(iconResource, menu)
	self.widgetRightIconResource = iconResource
	do
		local m = menu
		self.widgetRightAction = function()
			do _g.jk.widget.common.PopupMenu:showBelow(self.context, self.rightButton, m, self.context:getWidthValue("50mm"), 1) end
		end
		do self:updateRightButton() end
	end
end

function jk.widget.common.ActionBarWidget:updateLeftButton()
	if not (self.leftButton ~= nil) then
		do return end
	end
	if _g.jk.lang.String:isNotEmpty(self.widgetLeftIconResource) then
		do self.leftButton:setWidgetImageResource(self.widgetLeftIconResource) end
		do self.leftButton:setWidgetClickHandler1(self.widgetLeftAction) end
	else
		do self.leftButton:setWidgetImageResource(nil) end
		do self.leftButton:setWidgetClickHandler1(nil) end
	end
end

function jk.widget.common.ActionBarWidget:updateRightButton()
	if not (self.rightButton ~= nil) then
		do return end
	end
	if _g.jk.lang.String:isNotEmpty(self.widgetRightIconResource) then
		do self.rightButton:setWidgetImageResource(self.widgetRightIconResource) end
		do self.rightButton:setWidgetClickHandler1(self.widgetRightAction) end
	else
		do self.rightButton:setWidgetImageResource(nil) end
		do self.rightButton:setWidgetClickHandler1(nil) end
	end
end

function jk.widget.common.ActionBarWidget:getWidgetTextColor()
	local wtc = self.widgetTextColor
	if not (wtc ~= nil) then
		wtc = _g.jk.gfx.Color:forRGB(255, 255, 255)
	end
	do return wtc end
end

function jk.widget.common.ActionBarWidget:onWidgetAddedToScreen(screen)
end

function jk.widget.common.ActionBarWidget:onWidgetRemovedFromScreen(screen)
end

function jk.widget.common.ActionBarWidget:configureMenuItems(items)
	if not (items ~= nil) then
		do return end
	end
	if not (self.menuItems ~= nil) then
		do return end
	end
	if items ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(items)
		do
			n = 0
			while n < m do
				local widget = items[n + 1]
				if widget ~= nil then
					do self.menuItems:addWidget(widget) end
				end
				do n = n + 1 end
			end
		end
	end
end

function jk.widget.common.ActionBarWidget:setActionBarBackgroundColor(color)
	if self.canvas ~= nil then
		do self.canvas:setWidgetColor(color) end
	end
end

function jk.widget.common.ActionBarWidget:addOverlay(widget)
	if self.overlayWidget ~= nil then
		do self.overlayWidget:addWidget(widget) end
	end
end

function jk.widget.common.ActionBarWidget:removeOverlay()
	if not (self.overlayWidget ~= nil) then
		do return false end
	end
	do _g.jk.widget.Widget:removeChildrenOf(self.overlayWidget) end
	do return true end
end

function jk.widget.common.ActionBarWidget:clearMenuItems()
	if self.menuItems ~= nil then
		do _g.jk.widget.Widget:removeChildrenOf(self.menuItems) end
	end
end

function jk.widget.common.ActionBarWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	do
		local bgc = self.widgetBackgroundColor
		if bgc ~= nil then
			self.canvas = _g.jk.widget.CanvasWidget:forColor(self.context, bgc)
			do self:addWidget(self.canvas) end
		end
		do
			local tml = _g.jk.widget.common.TopMarginLayerWidget._construct1(_g.jk.widget.common.TopMarginLayerWidget._create(), self.context)
			self.label = _g.jk.widget.LabelWidget:forText(self.context, self.widgetTitle)
			do self.label:setWidgetFontFamily("Arial") end
			do
				local wtc = self:getWidgetTextColor()
				do self.label:setWidgetTextColor(wtc) end
				self.box = _g.jk.widget.HorizontalBoxWidget:forContext(self.context, 0, 0)
				do self.box:setWidgetMargin(self.context:getWidthValue("1mm")) end
				do self.box:setWidgetSpacing(self.context:getWidthValue("1mm")) end
				self.leftButton = _g.jk.widget.common.ImageButtonWidget._construct1(_g.jk.widget.common.ImageButtonWidget._create(), self.context)
				do self.leftButton:setWidgetButtonHeight(self.context:getHeightValue("6mm")) end
				do self.box:addWidget(self.leftButton) end
				do self:updateLeftButton() end
				self.widgetTitleContainer = _g.jk.widget.AlignWidget:forWidget(self.context, self.label, 0.5, 0.5, 0)
				do self.box:addWidget1(self.widgetTitleContainer, 1.0) end
				do
					local spacing = self.widgetMenuItemSpacing
					if spacing < 0 then
						spacing = self.context:getWidthValue("1mm")
					end
					self.menuItems = _g.jk.widget.HorizontalBoxWidget:forContext(self.context, self.context:getWidthValue("1mm"), spacing)
					do self.box:addWidget(self.menuItems) end
					self.rightButton = _g.jk.widget.common.ImageButtonWidget._construct1(_g.jk.widget.common.ImageButtonWidget._create(), self.context)
					do self.rightButton:setWidgetButtonHeight(self.context:getHeightValue("6mm")) end
					do self.box:addWidget(self.rightButton) end
					do self:updateRightButton() end
					do tml:addWidget(self.box) end
					self.overlayWidget = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
					do tml:addWidget(self.overlayWidget) end
					do self:addWidget(tml) end
				end
			end
		end
	end
end

function jk.widget.common.ActionBarWidget:getWidgetBackgroundColor()
	do return self.widgetBackgroundColor end
end

function jk.widget.common.ActionBarWidget:setWidgetBackgroundColor(v)
	self.widgetBackgroundColor = v
	do return self end
end

function jk.widget.common.ActionBarWidget:setWidgetTextColor(v)
	self.widgetTextColor = v
	do return self end
end

function jk.widget.common.ActionBarWidget:getWidgetMenuItemSpacing()
	do return self.widgetMenuItemSpacing end
end

function jk.widget.common.ActionBarWidget:setWidgetMenuItemSpacing(v)
	self.widgetMenuItemSpacing = v
	do return self end
end

jk.widget.common.TableWidget = _g.jk.widget.VerticalBoxWidget._create()
jk.widget.common.TableWidget.__index = jk.widget.common.TableWidget
_vm:set_metatable(jk.widget.common.TableWidget, {
	__index = _g.jk.widget.VerticalBoxWidget
})

function jk.widget.common.TableWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.TableWidget)
	return v
end

function jk.widget.common.TableWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.TableWidget'
	self['_isType.jk.widget.common.TableWidget'] = true
	self.widgetSortHandler = nil
	self.rowWidgets = nil
	self.columns = nil
	self.data = nil
	self.header = nil
	self.scrollerLayer = nil
end

function jk.widget.common.TableWidget:_construct0()
	jk.widget.common.TableWidget._init(self)
	do _g.jk.widget.VerticalBoxWidget._construct0(self) end
	return self
end

function jk.widget.common.TableWidget:_construct1(context)
	jk.widget.common.TableWidget._init(self)
	do _g.jk.widget.VerticalBoxWidget._construct1(self, context) end
	return self
end

jk.widget.common.TableWidget.CellWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.TableWidget.CellWidget.__index = jk.widget.common.TableWidget.CellWidget
_vm:set_metatable(jk.widget.common.TableWidget.CellWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.TableWidget.CellWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.TableWidget.CellWidget)
	return v
end

function jk.widget.common.TableWidget.CellWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.TableWidget.CellWidget'
	self['_isType.jk.widget.common.TableWidget.CellWidget'] = true
	self.contentWidget = nil
	self.contentWidgetAlign = 0.5
	self.contentWidgetWidth = 0
	self.contentWidgetWeight = 0.0
	self.align = nil
end

function jk.widget.common.TableWidget.CellWidget:_construct0()
	jk.widget.common.TableWidget.CellWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.TableWidget.CellWidget:_construct1(context)
	jk.widget.common.TableWidget.CellWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.TableWidget.CellWidget:forWidget1(ctx, widget, align)
	local v = _g.jk.widget.common.TableWidget.CellWidget._construct1(_g.jk.widget.common.TableWidget.CellWidget._create(), ctx)
	do v:setContentWidget(widget, align) end
	do return v end
end

function jk.widget.common.TableWidget.CellWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	do self:updateWidget() end
end

function jk.widget.common.TableWidget.CellWidget:getCellWeight()
	do return self.contentWidgetWeight end
end

function jk.widget.common.TableWidget.CellWidget:updateWidget()
	if not self:getInitialized() then
		do return end
	end
	do _g.jk.widget.Widget:removeChildrenOf(self.align) end
	if self.contentWidget ~= nil then
		do self.align:addWidget1(self.contentWidget, self.contentWidgetAlign, 0.5, false) end
	end
	if self.contentWidgetWidth > 0 then
		do self:setWidgetWidthRequest(self.contentWidgetWidth) end
	end
	do
		local parent = _vm:to_table_with_key(_g.jk.widget.Widget:getParent(self), '_isType.jk.widget.HorizontalBoxWidget')
		if parent ~= nil then
			do parent:setWidgetWeight(self, self.contentWidgetWeight) end
		end
	end
end

function jk.widget.common.TableWidget.CellWidget:setContentWidget(widget, vv)
	self.contentWidget = widget
	self.contentWidgetAlign = vv
	do self:updateWidget() end
end

function jk.widget.common.TableWidget.CellWidget:setCellWidth(width)
	self.contentWidgetWidth = width
	if self.contentWidgetWidth < 1 then
		self.contentWidgetWeight = 1.0
	else
		self.contentWidgetWeight = 0.0
	end
	do self:updateWidget() end
end

function jk.widget.common.TableWidget.CellWidget:setCellAlign(vv)
	self.contentWidgetAlign = vv
	do self:updateWidget() end
end

function jk.widget.common.TableWidget.CellWidget:createWidget()
	do _g.jk.widget.LayerWidget.createWidget(self) end
	do
		local thisWidget = self
		self.align = _g.jk.widget.AlignWidget._construct1(_g.jk.widget.AlignWidget._create(), self.context)
		do self:addWidget(self.align) end
	end
end

jk.widget.common.TableWidget.RowWidget = _g.jk.widget.LayerWithBackgroundColorWidget._create()
jk.widget.common.TableWidget.RowWidget.__index = jk.widget.common.TableWidget.RowWidget
_vm:set_metatable(jk.widget.common.TableWidget.RowWidget, {
	__index = _g.jk.widget.LayerWithBackgroundColorWidget
})

function jk.widget.common.TableWidget.RowWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.TableWidget.RowWidget)
	return v
end

function jk.widget.common.TableWidget.RowWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.TableWidget.RowWidget'
	self['_isType.jk.widget.common.TableWidget.RowWidget'] = true
	self.childWidgets = nil
	self.widgetTextColor = nil
	self.box = nil
end

function jk.widget.common.TableWidget.RowWidget:_construct0()
	jk.widget.common.TableWidget.RowWidget._init(self)
	do _g.jk.widget.LayerWithBackgroundColorWidget._construct0(self) end
	return self
end

function jk.widget.common.TableWidget.RowWidget:_construct1(context)
	jk.widget.common.TableWidget.RowWidget._init(self)
	do _g.jk.widget.LayerWithBackgroundColorWidget._construct1(self, context) end
	return self
end

function jk.widget.common.TableWidget.RowWidget:forTextValues(context, data)
	local v = _g.jk.widget.common.TableWidget.RowWidget._construct1(_g.jk.widget.common.TableWidget.RowWidget._create(), context)
	if data ~= nil then
		local n = 0
		local m = #data
		do
			n = 0
			while n < m do
				local str = data[n + 1]
				if str ~= nil then
					do v:addText(str, 0.0, 0) end
				end
				do n = n + 1 end
			end
		end
	end
	do return v end
end

function jk.widget.common.TableWidget.RowWidget:initializeWidget()
	do _g.jk.widget.LayerWithBackgroundColorWidget.initializeWidget(self) end
	if self.childWidgets ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(self.childWidgets)
		do
			n = 0
			while n < m do
				local widget = self.childWidgets[n + 1]
				if widget ~= nil then
					do self.box:addWidget1(widget, widget:getCellWeight()) end
				end
				do n = n + 1 end
			end
		end
	end
end

function jk.widget.common.TableWidget.RowWidget:reset()
	self.childWidgets = nil
	if self:getInitialized() then
		do _g.jk.widget.Widget:removeChildrenOf(self.box) end
	end
end

function jk.widget.common.TableWidget.RowWidget:addText(text, align, width)
	do self:addCellWidget(_g.jk.widget.LabelWidget:forText(self.context, text):setWidgetTextColor(self.widgetTextColor), align, width) end
end

function jk.widget.common.TableWidget.RowWidget:addClickableText(text, clickid, clickHandler, align, width)
	local ch = clickHandler
	local cl = clickid
	local handler = function()
		if ch ~= nil then
			do ch(cl) end
		end
	end
	do self:addCellWidget(_g.jk.widget.common.HyperLinkWidget:forText(self.context, text, handler):setWidgetTextColor(self.widgetTextColor), align, width) end
end

function jk.widget.common.TableWidget.RowWidget:addCellWidget(widget, align, width)
	if not (widget ~= nil) then
		do return end
	end
	do
		local cell = _g.jk.widget.common.TableWidget.CellWidget:forWidget1(self.context, widget, align)
		do cell:setCellWidth(width) end
		if not (self.childWidgets ~= nil) then
			self.childWidgets = {}
		end
		do _g.jk.lang.Vector:append(self.childWidgets, cell) end
		if self:getInitialized() then
			do self.box:addWidget1(cell, cell:getCellWeight()) end
		end
	end
end

function jk.widget.common.TableWidget.RowWidget:getCellWidgets()
	do return self.childWidgets end
end

function jk.widget.common.TableWidget.RowWidget:createWidget()
	do _g.jk.widget.LayerWithBackgroundColorWidget.createWidget(self) end
	do
		local thisWidget = self
		self.box = _g.jk.widget.HorizontalBoxWidget._construct1(_g.jk.widget.HorizontalBoxWidget._create(), self.context)
		do self.box:setWidgetMargin(self.context:getStylePixels("jkwidget", "table-spacing", "2mm")) end
		do self.box:setWidgetSpacing(self.context:getStylePixels("jkwidget", "table-spacing", "2mm")) end
		do self:addWidget(self.box) end
	end
end

function jk.widget.common.TableWidget.RowWidget:getWidgetTextColor()
	do return self.widgetTextColor end
end

function jk.widget.common.TableWidget.RowWidget:setWidgetTextColor(v)
	self.widgetTextColor = v
	do return self end
end

jk.widget.common.TableWidget.ColumnInfo = {}
jk.widget.common.TableWidget.ColumnInfo.__index = jk.widget.common.TableWidget.ColumnInfo
_vm:set_metatable(jk.widget.common.TableWidget.ColumnInfo, {})

function jk.widget.common.TableWidget.ColumnInfo._create()
	local v = _vm:set_metatable({}, jk.widget.common.TableWidget.ColumnInfo)
	return v
end

function jk.widget.common.TableWidget.ColumnInfo:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.TableWidget.ColumnInfo'
	self['_isType.jk.widget.common.TableWidget.ColumnInfo'] = true
	self.label = nil
	self.width = 0
	self.align = 0.0
	self.sortid = nil
end

function jk.widget.common.TableWidget.ColumnInfo:_construct0()
	jk.widget.common.TableWidget.ColumnInfo._init(self)
	return self
end

function jk.widget.common.TableWidget.ColumnInfo:getLabel()
	do return self.label end
end

function jk.widget.common.TableWidget.ColumnInfo:setLabel(v)
	self.label = v
	do return self end
end

function jk.widget.common.TableWidget.ColumnInfo:getWidth()
	do return self.width end
end

function jk.widget.common.TableWidget.ColumnInfo:setWidth(v)
	self.width = v
	do return self end
end

function jk.widget.common.TableWidget.ColumnInfo:getAlign()
	do return self.align end
end

function jk.widget.common.TableWidget.ColumnInfo:setAlign(v)
	self.align = v
	do return self end
end

function jk.widget.common.TableWidget.ColumnInfo:getSortid()
	do return self.sortid end
end

function jk.widget.common.TableWidget.ColumnInfo:setSortid(v)
	self.sortid = v
	do return self end
end

function jk.widget.common.TableWidget:initializeWidget()
	do _g.jk.widget.VerticalBoxWidget.initializeWidget(self) end
	do self:updateWidgetColumns() end
	do self:updateDataWidgets() end
end

function jk.widget.common.TableWidget:parseColumnInfo(value)
	local v = _g.jk.widget.common.TableWidget.ColumnInfo._construct0(_g.jk.widget.common.TableWidget.ColumnInfo._create())
	if not (value ~= nil) then
		do return v end
	end
	do
		local array = _g.jk.lang.String:split(value, 44, 0)
		if array ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(array)
			do
				n = 0
				while n < m do
					local comp = array[n + 1]
					if comp ~= nil then
						local vals = _g.jk.lang.String:split(comp, 61, 2)
						local key = _g.jk.lang.Vector:get(vals, 0)
						local val = _g.jk.lang.Vector:get(vals, 1)
						if key == "label" then
							do v:setLabel(val) end
						elseif key == "width" then
							do v:setWidth(self.context:getWidthValue(val)) end
						elseif key == "align" then
							if val == "left" then
								do v:setAlign(0.0) end
							elseif val == "center" then
								do v:setAlign(0.5) end
							elseif val == "right" then
								do v:setAlign(1.0) end
							else
								do v:setAlign(0.0) end
							end
						elseif key == "sortid" then
							do v:setSortid(val) end
						end
					end
					do n = n + 1 end
				end
			end
		end
		do return v end
	end
end

function jk.widget.common.TableWidget:onSort(sortid)
	if self.widgetSortHandler ~= nil then
		do self.widgetSortHandler(sortid) end
	end
end

function jk.widget.common.TableWidget:setWidgetHasHeader(value)
	do _g.jk.widget.Widget:setVisible(self.header, value) end
end

function jk.widget.common.TableWidget:setWidgetColumns(columns)
	self.columns = columns
	if self:getInitialized() then
		do self:updateWidgetColumns() end
	end
end

function jk.widget.common.TableWidget:updateWidgetColumns()
	do self.header:reset() end
	if self.columns ~= nil then
		local n = 0
		local m = #self.columns
		do
			n = 0
			while n < m do
				local cc = self.columns[n + 1]
				if cc ~= nil then
					local column = _g.jk.lang.String:asString(cc)
					local ci = self:parseColumnInfo(column)
					local sortid = ci:getSortid()
					if _g.jk.lang.String:isNotEmpty(sortid) then
						local handler = function(vv)
							do self:onSort(vv) end
						end
						do self.header:addClickableText(ci:getLabel(), sortid, handler, ci:getAlign(), ci:getWidth()) end
					else
						do self.header:addText(ci:getLabel(), ci:getAlign(), ci:getWidth()) end
					end
				end
				do n = n + 1 end
			end
		end
	end
	if self.rowWidgets ~= nil then
		local n2 = 0
		local m2 = _g.jk.lang.Vector:getSize(self.rowWidgets)
		do
			n2 = 0
			while n2 < m2 do
				local row = _vm:to_table_with_key(self.rowWidgets[n2 + 1], '_isType.jk.widget.common.TableWidget.RowWidget')
				if row ~= nil then
					do self:updateCellProperties(row) end
				end
				do n2 = n2 + 1 end
			end
		end
	end
end

function jk.widget.common.TableWidget:getColumnInfo(idx)
	if not (self.columns ~= nil) then
		do return _g.jk.widget.common.TableWidget.ColumnInfo._construct0(_g.jk.widget.common.TableWidget.ColumnInfo._create()) end
	end
	if idx < 0 or idx >= #self.columns then
		do return _g.jk.widget.common.TableWidget.ColumnInfo._construct0(_g.jk.widget.common.TableWidget.ColumnInfo._create()) end
	end
	do return self:parseColumnInfo(_g.jk.lang.String:asString(self.columns[idx + 1])) end
end

function jk.widget.common.TableWidget:updateCellProperties(row)
	if not (row ~= nil) then
		do return end
	end
	do
		local cells = row:getCellWidgets()
		if not (cells ~= nil) then
			do return end
		end
		do
			local n = 0
			while n < _g.jk.lang.Vector:getSize(cells) do
				local cell = _g.jk.lang.Vector:get(cells, n)
				if cell ~= nil then
					local ci = self:getColumnInfo(n)
					do cell:setCellWidth(ci:getWidth()) end
					do cell:setCellAlign(ci:getAlign()) end
				end
				do n = n + 1 end
			end
		end
	end
end

function jk.widget.common.TableWidget:setWidgetData(data)
	self.data = data
	if self:getInitialized() then
		do self:updateDataWidgets() end
	end
end

function jk.widget.common.TableWidget:setRowStyle(row)
	do row:setWidgetColor(self.context:getStyleColor("jkwidget", "table-row-color", "#EEEEEE")) end
	do row:setWidgetTextColor(self.context:getStyleColor("jkwidget", "table-row-text-color", "#000000")) end
end

function jk.widget.common.TableWidget:updateDataWidgets()
	local widgets = {}
	if self.data ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(self.data)
		do
			n = 0
			while n < m do
				local entry = self.data[n + 1]
				if entry ~= nil then
					local v = _g.jk.widget.common.TableWidget.RowWidget._construct1(_g.jk.widget.common.TableWidget.RowWidget._create(), self.context)
					do self:setRowStyle(v) end
					if entry ~= nil then
						local n2 = 0
						local m2 = #entry
						do
							n2 = 0
							while n2 < m2 do
								local cell = entry[n2 + 1]
								if cell ~= nil then
									if (_vm:to_table_with_key(cell, '_isType.jk.widget.Widget') ~= nil) then
										do v:addCellWidget(cell, 0.0, 0) end
									else
										do v:addText(_g.jk.lang.String:asString(cell), 0.0, 0) end
									end
								end
								do n2 = n2 + 1 end
							end
						end
					end
					do _g.jk.lang.Vector:append(widgets, v) end
				end
				do n = n + 1 end
			end
		end
	end
	self.rowWidgets = widgets
	if widgets ~= nil then
		local n3 = 0
		local m3 = _g.jk.lang.Vector:getSize(widgets)
		do
			n3 = 0
			while n3 < m3 do
				local row = _vm:to_table_with_key(widgets[n3 + 1], '_isType.jk.widget.common.TableWidget.RowWidget')
				if row ~= nil then
					do self:updateCellProperties(row) end
				end
				do n3 = n3 + 1 end
			end
		end
	end
	do
		local original = _g.jk.lang.Vector:get(_g.jk.widget.Widget:getChildren(self.scrollerLayer), 0)
		local scroller = _g.jk.widget.common.DynamicVerticalScrollerWidget._construct1(_g.jk.widget.common.DynamicVerticalScrollerWidget._create(), self.context)
		do scroller:setWidgetContainerSpacing(self.context:getHeightValue("1mm")) end
		do scroller:setWidgetContainerMargin(self.context:getHeightValue("1mm")) end
		do scroller:setWidgetProvider(_g.jk.widget.StaticWidgetProvider:forWidgets(widgets)) end
		do scroller:clear() end
		do _g.jk.widget.Widget:setVisible(scroller, false) end
		do self.scrollerLayer:addWidget(scroller) end
		if original ~= nil then
			local o = original
			local s = scroller
			do self.context:startTimer(0, function()
				do _g.jk.widget.Widget:removeFromParent(o) end
				do _g.jk.widget.Widget:setVisible(s, true) end
			end) end
		end
	end
end

function jk.widget.common.TableWidget:createWidget()
	do _g.jk.widget.VerticalBoxWidget.createWidget(self) end
	do
		local thisWidget = self
		self.header = _g.jk.widget.common.TableWidget.RowWidget._construct1(_g.jk.widget.common.TableWidget.RowWidget._create(), self.context)
		do self.header:setWidgetColor(self.context:getStyleColor("jkwidget", "table-header-color", "#777777")) end
		do self.header:setWidgetTextColor(self.context:getStyleColor("jkwidget", "table-header-text-color", "#FFFFFF")) end
		do self:addWidget(self.header) end
		self.scrollerLayer = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
		do self:addWidget1(self.scrollerLayer, 1.0) end
	end
end

function jk.widget.common.TableWidget:getWidgetSortHandler()
	do return self.widgetSortHandler end
end

function jk.widget.common.TableWidget:setWidgetSortHandler(v)
	self.widgetSortHandler = v
	do return self end
end

jk.widget.common.RadioButtonGroupWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.RadioButtonGroupWidget.__index = jk.widget.common.RadioButtonGroupWidget
_vm:set_metatable(jk.widget.common.RadioButtonGroupWidget, {
	__index = _g.jk.widget.LayerWidget
})

jk.widget.common.RadioButtonGroupWidget.HORIZONTAL = 0
jk.widget.common.RadioButtonGroupWidget.VERTICAL = 1

function jk.widget.common.RadioButtonGroupWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.RadioButtonGroupWidget)
	return v
end

function jk.widget.common.RadioButtonGroupWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.RadioButtonGroupWidget'
	self['_isType.jk.widget.common.RadioButtonGroupWidget'] = true
	self['_isType.jk.widget.WidgetWithValue'] = true
	self.vrb = nil
	self.box = nil
	self.widgetContext = nil
	self.widgetName = nil
	self.widgetSelectedValue = nil
	self.widgetItems = nil
	self.selectedWidgetIndex = -1
	self.widgetChangeHandler = nil
end

function jk.widget.common.RadioButtonGroupWidget:_construct0()
	jk.widget.common.RadioButtonGroupWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.RadioButtonGroupWidget:forGroup(context, group, items, orientation)
	local v = _g.jk.widget.common.RadioButtonGroupWidget._construct1(_g.jk.widget.common.RadioButtonGroupWidget._create(), context)
	do v:setWidgetName(group) end
	do v:setWidgetOrientation(orientation) end
	do
		local i = 0
		while i < _g.jk.lang.Vector:getSize(items) do
			do v:addWidgetItem(_g.jk.lang.Vector:get(items, i), i) end
			do i = i + 1 end
		end
	end
	do return v end
end

jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget = _g.jk.widget.HorizontalBoxWidget._create()
jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget.__index = jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget
_vm:set_metatable(jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget, {
	__index = _g.jk.widget.HorizontalBoxWidget
})

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget)
	return v
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget'
	self['_isType.jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget'] = true
	self.widgetIndex = 0
	self.widgetContainer = nil
	self.widgetText = nil
	self.radio = nil
	self.outline = nil
	self.canvas = nil
	self.label = nil
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:_construct0()
	jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget._init(self)
	do _g.jk.widget.HorizontalBoxWidget._construct0(self) end
	return self
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:_construct1(context)
	jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget._init(self)
	do _g.jk.widget.HorizontalBoxWidget._construct1(self, context) end
	return self
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:initializeWidget()
	do _g.jk.widget.HorizontalBoxWidget.initializeWidget(self) end
	do self.label:setWidgetText(self.widgetText) end
	do _g.jk.widget.Widget:setWidgetClickHandler(self.radio, function()
		do self.widgetContainer:updateSelectedWidget(self.widgetIndex) end
	end) end
	do _g.jk.widget.Widget:setWidgetClickHandler(self.label, function()
		do self.widgetContainer:updateSelectedWidget(self.widgetIndex) end
	end) end
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:onSelected()
	do self.canvas:setWidgetColor(_g.jk.gfx.Color:black()) end
	do self.canvas:setWidgetRoundingRadius1(self.context:getHeightValue("1500um")) end
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:onDeSelected()
	do self.canvas:setWidgetColor(_g.jk.gfx.Color:white()) end
	do self.canvas:setWidgetRoundingRadius1(self.context:getHeightValue("1500um")) end
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:getWidgetLabel()
	do return self.label:getWidgetText() end
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:createWidget()
	do _g.jk.widget.HorizontalBoxWidget.createWidget(self) end
	do
		local thisWidget = self
		do self:setWidgetSpacing(self.context:getHeightValue("2000um")) end
		do
			local widget = _g.jk.widget.AlignWidget._construct1(_g.jk.widget.AlignWidget._create(), self.context)
			self.radio = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
			do self.radio:setWidgetHeightRequest(self.context:getHeightValue("4000um")) end
			do self.radio:setWidgetWidthRequest(self.context:getHeightValue("4000um")) end
			self.outline = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
			do self.outline:setWidgetColor(_g.jk.gfx.Color:black()) end
			do self.outline:setWidgetRoundingRadius1(self.context:getHeightValue("2000um")) end
			do self.radio:addWidget(self.outline) end
			do
				local widget2 = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
				do widget2:setWidgetMargin(self.context:getHeightValue("500um")) end
				self.canvas = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
				do self.canvas:setWidgetColor(_g.jk.gfx.Color:white()) end
				do self.canvas:setWidgetRoundingRadius1(self.context:getHeightValue("1500um")) end
				do widget2:addWidget(self.canvas) end
				do self.radio:addWidget(widget2) end
				do widget:addWidget(self.radio) end
				do self:addWidget(widget) end
				self.label = _g.jk.widget.LabelWidget._construct1(_g.jk.widget.LabelWidget._create(), self.context)
				do self.label:setWidgetFontSize(self.context:getHeightValue("3000um")) end
				do self:addWidget(self.label) end
			end
		end
	end
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:getWidgetIndex()
	do return self.widgetIndex end
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:setWidgetIndex(v)
	self.widgetIndex = v
	do return self end
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:getWidgetContainer()
	do return self.widgetContainer end
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:setWidgetContainer(v)
	self.widgetContainer = v
	do return self end
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:getWidgetText()
	do return self.widgetText end
end

function jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget:setWidgetText(v)
	self.widgetText = v
	do return self end
end

function jk.widget.common.RadioButtonGroupWidget:updateSelectedWidget(index)
	if self.selectedWidgetIndex > -1 then
		local widget = _g.jk.lang.Vector:get(self.vrb, self.selectedWidgetIndex)
		if widget ~= nil then
			do widget:onDeSelected() end
		end
	end
	do
		local v = nil
		local ww = _g.jk.lang.Vector:get(self.vrb, index)
		if ww ~= nil then
			do ww:onSelected() end
			v = ww:getWidgetLabel()
		end
		self.selectedWidgetIndex = index
		self.widgetSelectedValue = _g.jk.lang.String:asString(v)
		do self:onChangeSelectedItem() end
	end
end

function jk.widget.common.RadioButtonGroupWidget:findIndexForWidgetValue(id)
	local v = -1
	if self.widgetItems ~= nil then
		local n = 0
		if self.widgetItems ~= nil then
			local n2 = 0
			local m = _g.jk.lang.Vector:getSize(self.widgetItems)
			do
				n2 = 0
				while n2 < m do
					local item = self.widgetItems[n2 + 1]
					if item ~= nil then
						if n == id then
							v = n
							do break end
						end
						do n = n + 1 end
					end
					do n2 = n2 + 1 end
				end
			end
		end
	end
	do return v end
end

function jk.widget.common.RadioButtonGroupWidget:_construct1(context)
	jk.widget.common.RadioButtonGroupWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	self.widgetContext = context
	return self
end

function jk.widget.common.RadioButtonGroupWidget:addWidgetItem(text, index)
	if not (self.widgetItems ~= nil) then
		self.widgetItems = {}
	end
	do _g.jk.lang.Vector:append(self.widgetItems, text) end
	do
		local rb = _g.jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget._construct1(_g.jk.widget.common.RadioButtonGroupWidget.MyRadioButtonWidget._create(), self.widgetContext)
		do rb:setWidgetText(text) end
		do rb:setWidgetIndex(index) end
		do rb:setWidgetContainer(self) end
		do _g.jk.lang.Vector:append(self.vrb, rb) end
		if self.box ~= nil then
			do self.box:addWidget(rb) end
		end
	end
end

function jk.widget.common.RadioButtonGroupWidget:setWidgetSelectedValue(indx)
	do self:updateSelectedWidget(self:findIndexForWidgetValue(indx)) end
end

function jk.widget.common.RadioButtonGroupWidget:setWidgetName(name)
	self.widgetName = name
end

function jk.widget.common.RadioButtonGroupWidget:setWidgetOrientation(orientation)
	if orientation == _g.jk.widget.common.RadioButtonGroupWidget.HORIZONTAL then
		self.box = _g.jk.widget.HorizontalBoxWidget:forContext(self.context, self.context:getHeightValue("2500um"), self.context:getHeightValue("1500um"))
		do self:addWidget(self.box) end
	elseif orientation == _g.jk.widget.common.RadioButtonGroupWidget.VERTICAL then
		self.box = _g.jk.widget.VerticalBoxWidget:forContext(self.context, self.context:getHeightValue("2500um"), self.context:getHeightValue("1500um"))
		do self:addWidget(self.box) end
	end
end

function jk.widget.common.RadioButtonGroupWidget:getWidgetSelectedValue()
	do return self.widgetSelectedValue end
end

function jk.widget.common.RadioButtonGroupWidget:onChangeSelectedItem()
	if self.widgetChangeHandler ~= nil then
		do self.widgetChangeHandler() end
	end
end

function jk.widget.common.RadioButtonGroupWidget:setWidgetValue(value)
	local io = _vm:to_table_with_key(value, '_isType.jk.lang.IntegerObject')
	if io ~= nil then
		do self:setWidgetSelectedValue(io:toInteger()) end
	else
		do self:setWidgetSelectedValue(-1) end
	end
end

function jk.widget.common.RadioButtonGroupWidget:getWidgetValue()
	do return self:getWidgetSelectedValue() end
end

function jk.widget.common.RadioButtonGroupWidget:getWidgetChangeHandler()
	do return self.widgetChangeHandler end
end

function jk.widget.common.RadioButtonGroupWidget:setWidgetChangeHandler(v)
	self.widgetChangeHandler = v
	do return self end
end

jk.widget.common.SelectWidget = _g.jk.widget.Widget._create()
jk.widget.common.SelectWidget.__index = jk.widget.common.SelectWidget
_vm:set_metatable(jk.widget.common.SelectWidget, {
	__index = _g.jk.widget.Widget
})

function jk.widget.common.SelectWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.SelectWidget)
	return v
end

function jk.widget.common.SelectWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.SelectWidget'
	self['_isType.jk.widget.common.SelectWidget'] = true
	self['_isType.jk.widget.WidgetWithValue'] = true
	self.widgetOnFocusHandler = nil
	self.widgetOnLoseFocusHandler = nil
	self.widgetContext = nil
	self.widgetItems = nil
	self.widgetValueChangeHandler = nil
	self.widgetBackgroundColor = nil
	self.widgetTextColor = nil
	self.widgetPadding = 0
	self.widgetFontFamily = nil
	self.widgetFontResource = nil
	self.widgetFontSize = 0.0
	self.widgetFontUnderline = false
	self.widgetFontItalic = false
	self.widgetFontBold = false
	self.widgetIsEnabled = true
end

function jk.widget.common.SelectWidget:_construct0()
	jk.widget.common.SelectWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	return self
end

function jk.widget.common.SelectWidget:forKeyValueList(context, options)
	local v = _g.jk.widget.common.SelectWidget._construct1(_g.jk.widget.common.SelectWidget._create(), context)
	do v:setWidgetItemsAsKeyValueList(options) end
	do return v end
end

function jk.widget.common.SelectWidget:forKeyValueStrings1(context, options)
	local v = _g.jk.widget.common.SelectWidget._construct1(_g.jk.widget.common.SelectWidget._create(), context)
	do v:setWidgetItemsAsKeyValueStrings2(options) end
	do return v end
end

function jk.widget.common.SelectWidget:forKeyValueStrings2(context, options)
	local v = _g.jk.widget.common.SelectWidget._construct1(_g.jk.widget.common.SelectWidget._create(), context)
	do v:setWidgetItemsAsKeyValueStrings1(options) end
	do return v end
end

function jk.widget.common.SelectWidget:forStringList1(context, options)
	local v = _g.jk.widget.common.SelectWidget._construct1(_g.jk.widget.common.SelectWidget._create(), context)
	do v:setWidgetItemsAsStringList3(options) end
	do return v end
end

function jk.widget.common.SelectWidget:forStringList2(context, options)
	local v = _g.jk.widget.common.SelectWidget._construct1(_g.jk.widget.common.SelectWidget._create(), context)
	do v:setWidgetItemsAsStringList2(options) end
	do return v end
end

function jk.widget.common.SelectWidget:forStringList3(context, options)
	local v = _g.jk.widget.common.SelectWidget._construct1(_g.jk.widget.common.SelectWidget._create(), context)
	do v:setWidgetItemsAsStringList1(options) end
	do return v end
end

function jk.widget.common.SelectWidget:_construct1(context)
	jk.widget.common.SelectWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	self.widgetContext = context
	do self:setWidgetStyle("SelectWidget") end
	return self
end

function jk.widget.common.SelectWidget:setWidgetStyle(style)
	self.widgetFontFamily = self.widgetContext:getStyleString(style, "fontFamily", nil)
	if _g.jk.lang.String:isEmpty(self.widgetFontFamily) then
		self.widgetFontFamily = "Arial"
	end
	self.widgetFontSize = self.widgetContext:getStylePixels(style, "fontSize", nil)
	if self.widgetFontSize < 1.0 then
		self.widgetFontSize = self.widgetContext:getHeightValue("3mm")
	end
	self.widgetFontResource = self.widgetContext:getStyleString(style, "fontResource", nil)
	self.widgetTextColor = self.widgetContext:getStyleColor(style, "textColor", nil)
	self.widgetBackgroundColor = self.widgetContext:getStyleColor(style, "backgroundColor", nil)
	self.widgetPadding = self.widgetContext:getStylePixels(style, "padding", nil)
	do self:updateWidgetFont() end
	do self:updateWidgetAppearance(true) end
	do return self end
end

function jk.widget.common.SelectWidget:setWidgetFontFamily(family)
	self.widgetFontFamily = family
	do self:updateWidgetFont() end
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.SelectWidget:setWidgetFontResource(res)
	self.widgetFontResource = res
	do self:updateWidgetFont() end
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.SelectWidget:setWidgetFontSize(fontSize)
	self.widgetFontSize = fontSize
	do self:updateWidgetFont() end
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.SelectWidget:setWidgetFontUnderline(underline)
	self.widgetFontUnderline = underline
	do self:updateWidgetFont() end
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.SelectWidget:setWidgetFontItalic(italic)
	self.widgetFontItalic = italic
	do self:updateWidgetFont() end
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.SelectWidget:setWidgetFontBold(bold)
	self.widgetFontBold = bold
	do self:updateWidgetFont() end
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.SelectWidget:updateWidgetFont()
	_io:write_to_stdout("[jk.widget.common.SelectWidget.updateWidgetFont] (SelectWidget.sling:654:3): Not implemented" .. "\n")
end

function jk.widget.common.SelectWidget:setWidgetPadding(value)
	self.widgetPadding = value
	do self:updateWidgetAppearance(true) end
	do return self end
end

function jk.widget.common.SelectWidget:getWidgetPadding()
	do return self.widgetPadding end
end

function jk.widget.common.SelectWidget:setWidgetTextColor(color)
	self.widgetTextColor = color
	do self:updateWidgetAppearance(false) end
	do return self end
end

function jk.widget.common.SelectWidget:getWidgetTextColor()
	do return self.widgetTextColor end
end

function jk.widget.common.SelectWidget:setWidgetBackgroundColor(color)
	self.widgetBackgroundColor = color
	do self:updateWidgetAppearance(false) end
	do return self end
end

function jk.widget.common.SelectWidget:getWidgetBackgroundColor()
	do return self.widgetBackgroundColor end
end

function jk.widget.common.SelectWidget:getActualWidgetTextColor()
	local textColor = self.widgetTextColor
	if textColor == nil then
		if self.widgetBackgroundColor ~= nil then
			if self.widgetBackgroundColor:isLightColor() then
				textColor = _g.jk.gfx.Color:black()
			else
				textColor = _g.jk.gfx.Color:white()
			end
		else
			textColor = _g.jk.gfx.Color:black()
		end
	end
	do return textColor end
end

function jk.widget.common.SelectWidget:updateWidgetAppearance(layoutChanged)
	local textColor = self:getActualWidgetTextColor()
	_io:write_to_stdout("[jk.widget.common.SelectWidget.updateWidgetAppearance] (SelectWidget.sling:789:3): Not implemented" .. "\n")
	if layoutChanged then
		do _g.jk.widget.Widget:onLayoutChanged(self) end
	end
end

function jk.widget.common.SelectWidget:setWidgetItemsAsKeyValueList(items)
	local selectedIndex = self:getSelectedWidgetIndex()
	self.widgetItems = items
	_io:write_to_stdout("[jk.widget.common.SelectWidget.setWidgetItemsAsKeyValueList] (SelectWidget.sling:877:3): Not implemented." .. "\n")
	do self:setSelectedWidgetIndex(selectedIndex) end
end

function jk.widget.common.SelectWidget:addWidgetItem1(value)
	do self:addWidgetItem2(value, value) end
end

function jk.widget.common.SelectWidget:addWidgetItem2(k, v)
	local list = self.widgetItems
	if not (list ~= nil) then
		list = _g.jk.lang.KeyValueList._construct0(_g.jk.lang.KeyValueList._create())
	end
	do list:add(k, v) end
	do self:setWidgetItemsAsKeyValueList(list) end
end

function jk.widget.common.SelectWidget:removeWidgetItem(index)
	if not (self.widgetItems ~= nil) then
		do return end
	end
	do
		local list = self.widgetItems
		local selectedIndex = self:getSelectedWidgetIndex()
		do list:remove(index) end
		do self:setWidgetItemsAsKeyValueList(list) end
		do self:setSelectedWidgetIndex(selectedIndex) end
	end
end

function jk.widget.common.SelectWidget:setWidgetItemsAsKeyValueStrings1(options)
	local list = _g.jk.lang.KeyValueList._construct0(_g.jk.lang.KeyValueList._create())
	if options ~= nil then
		if options ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(options)
			do
				n = 0
				while n < m do
					local option = options[n + 1]
					if option ~= nil then
						local comps = _g.jk.lang.String:split(option, 58, 2)
						local kk = _g.jk.lang.Vector:get(comps, 0)
						local vv = _g.jk.lang.Vector:get(comps, 1)
						if vv == nil then
							vv = kk
						end
						do list:add(kk, vv) end
					end
					do n = n + 1 end
				end
			end
		end
	end
	do self:setWidgetItemsAsKeyValueList(list) end
end

function jk.widget.common.SelectWidget:setWidgetItemsAsKeyValueStrings2(options)
	local list = _g.jk.lang.KeyValueList._construct0(_g.jk.lang.KeyValueList._create())
	if options ~= nil then
		if options ~= nil then
			local n = 0
			local m = #options
			do
				n = 0
				while n < m do
					local option = (function(o)
						if (_vm:get_variable_type(o) == 'string') then
							do return o end
						end
						do return nil end
					end)(options[n + 1])
					if option ~= nil then
						local comps = _g.jk.lang.String:split(option, 58, 2)
						local kk = _g.jk.lang.Vector:get(comps, 0)
						local vv = _g.jk.lang.Vector:get(comps, 1)
						if vv == nil then
							vv = kk
						end
						do list:add(kk, vv) end
					end
					do n = n + 1 end
				end
			end
		end
	end
	do self:setWidgetItemsAsKeyValueList(list) end
end

function jk.widget.common.SelectWidget:setWidgetItemsAsStringList1(options)
	local list = _g.jk.lang.KeyValueList._construct0(_g.jk.lang.KeyValueList._create())
	if options ~= nil then
		local array = options:toVector()
		if array ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(array)
			do
				n = 0
				while n < m do
					local option = (function(o)
						if (_vm:get_variable_type(o) == 'string') then
							do return o end
						end
						do return nil end
					end)(array[n + 1])
					if option ~= nil then
						do list:add(option, option) end
					end
					do n = n + 1 end
				end
			end
		end
	end
	do self:setWidgetItemsAsKeyValueList(list) end
end

function jk.widget.common.SelectWidget:setWidgetItemsAsStringList2(options)
	local list = _g.jk.lang.KeyValueList._construct0(_g.jk.lang.KeyValueList._create())
	if options ~= nil then
		if options ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(options)
			do
				n = 0
				while n < m do
					local option = options[n + 1]
					if option ~= nil then
						do list:add(option, option) end
					end
					do n = n + 1 end
				end
			end
		end
	end
	do self:setWidgetItemsAsKeyValueList(list) end
end

function jk.widget.common.SelectWidget:setWidgetItemsAsStringList3(options)
	local list = _g.jk.lang.KeyValueList._construct0(_g.jk.lang.KeyValueList._create())
	if options ~= nil then
		if options ~= nil then
			local n = 0
			local m = #options
			do
				n = 0
				while n < m do
					local option = (function(o)
						if (_vm:get_variable_type(o) == 'string') then
							do return o end
						end
						do return nil end
					end)(options[n + 1])
					if option ~= nil then
						do list:add(option, option) end
					end
					do n = n + 1 end
				end
			end
		end
	end
	do self:setWidgetItemsAsKeyValueList(list) end
end

function jk.widget.common.SelectWidget:adjustSelectedWidgetItemIndex(index)
	if self.widgetItems == nil or self.widgetItems:count() < 1 then
		do return -1 end
	end
	if index < 0 then
		do return 0 end
	end
	if index >= self.widgetItems:count() then
		do return self.widgetItems:count() - 1 end
	end
	do return index end
end

function jk.widget.common.SelectWidget:findIndexForWidgetValue(id)
	local v = -1
	if self.widgetItems ~= nil then
		local n = 0
		local it = self.widgetItems:iterate()
		while it ~= nil do
			local item = it:next()
			if item == nil then
				do break end
			end
			if item.key == id then
				v = n
				do break end
			end
			do n = n + 1 end
		end
	end
	do return v end
end

function jk.widget.common.SelectWidget:getWidgetItemCount()
	if self.widgetItems == nil then
		do return 0 end
	end
	do return self.widgetItems:count() end
end

function jk.widget.common.SelectWidget:getWidgetTextForIndex(index)
	if not (self.widgetItems ~= nil) then
		do return nil end
	end
	do return self.widgetItems:getValue(index) end
end

function jk.widget.common.SelectWidget:getSelectedWidgetIndex()
	_io:write_to_stdout("[jk.widget.common.SelectWidget.getSelectedWidgetIndex] (SelectWidget.sling:1029:3): Not implemented" .. "\n")
	do return -1 end
end

function jk.widget.common.SelectWidget:setSelectedWidgetIndex(index)
	local v = self:adjustSelectedWidgetItemIndex(index)
	_io:write_to_stdout("[jk.widget.common.SelectWidget.setSelectedWidgetIndex] (SelectWidget.sling:1078:3): Not implemented" .. "\n")
end

function jk.widget.common.SelectWidget:setSelectedWidgetValue(id)
	do self:setSelectedWidgetIndex(self:findIndexForWidgetValue(id)) end
end

function jk.widget.common.SelectWidget:getSelectedWidgetValue()
	local index = self:getSelectedWidgetIndex()
	if self.widgetItems == nil or index < 0 then
		do return nil end
	end
	do return self.widgetItems:getKey(index) end
end

function jk.widget.common.SelectWidget:setWidgetValue(value)
	do self:setSelectedWidgetValue(_g.jk.lang.String:asString(value)) end
end

function jk.widget.common.SelectWidget:getWidgetValue()
	do return self:getSelectedWidgetValue() end
end

function jk.widget.common.SelectWidget:setWidgetValueChangeHandler(handler)
	self.widgetValueChangeHandler = handler
end

function jk.widget.common.SelectWidget:onWidgetSelectionChanged()
	if self.widgetValueChangeHandler ~= nil then
		do self.widgetValueChangeHandler() end
	end
end

function jk.widget.common.SelectWidget:getWidgetItems()
	do return self.widgetItems end
end

function jk.widget.common.SelectWidget:onFocusListener()
	if self.widgetOnFocusHandler ~= nil then
		do self.widgetOnFocusHandler() end
	end
end

function jk.widget.common.SelectWidget:onLoseFocusListener()
	if self.widgetOnLoseFocusHandler ~= nil then
		do self.widgetOnLoseFocusHandler() end
	end
end

function jk.widget.common.SelectWidget:setWidgetIsEnabled(v, background)
	self.widgetIsEnabled = v
	_io:write_to_stdout("[jk.widget.common.SelectWidget.setWidgetIsEnabled] (SelectWidget.sling:1137:3): Not implemented" .. "\n")
end

function jk.widget.common.SelectWidget:getWidgetIsEnabled()
	do return self.widgetIsEnabled end
end

function jk.widget.common.SelectWidget:focus1()
	_io:write_to_stdout("[jk.widget.common.SelectWidget.focus] (SelectWidget.sling:1168:3): Not implemented" .. "\n")
end

function jk.widget.common.SelectWidget:getWidgetOnFocusHandler()
	do return self.widgetOnFocusHandler end
end

function jk.widget.common.SelectWidget:setWidgetOnFocusHandler(v)
	self.widgetOnFocusHandler = v
	do return self end
end

function jk.widget.common.SelectWidget:getWidgetOnLoseFocusHandler()
	do return self.widgetOnLoseFocusHandler end
end

function jk.widget.common.SelectWidget:setWidgetOnLoseFocusHandler(v)
	self.widgetOnLoseFocusHandler = v
	do return self end
end

jk.widget.common.SplashScreenWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.SplashScreenWidget.__index = jk.widget.common.SplashScreenWidget
_vm:set_metatable(jk.widget.common.SplashScreenWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.SplashScreenWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.SplashScreenWidget)
	return v
end

function jk.widget.common.SplashScreenWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.SplashScreenWidget'
	self['_isType.jk.widget.common.SplashScreenWidget'] = true
	self.backgroundColor = nil
	self.slides = nil
	self.doneHandler = nil
	self.currentSlide = -1
	self.currentImageWidget = nil
	self.imageWidgetWidth = "80mm"
	self.margin = "5mm"
	self.canvas = nil
end

function jk.widget.common.SplashScreenWidget:_construct0()
	jk.widget.common.SplashScreenWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

jk.widget.common.SplashScreenWidget.Slide = {}
jk.widget.common.SplashScreenWidget.Slide.__index = jk.widget.common.SplashScreenWidget.Slide
_vm:set_metatable(jk.widget.common.SplashScreenWidget.Slide, {})

function jk.widget.common.SplashScreenWidget.Slide._create()
	local v = _vm:set_metatable({}, jk.widget.common.SplashScreenWidget.Slide)
	return v
end

function jk.widget.common.SplashScreenWidget.Slide:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.SplashScreenWidget.Slide'
	self['_isType.jk.widget.common.SplashScreenWidget.Slide'] = true
	self.resource = nil
	self.delay = 0
	self.backgroundColor = nil
end

function jk.widget.common.SplashScreenWidget.Slide:_construct0()
	jk.widget.common.SplashScreenWidget.Slide._init(self)
	return self
end

function jk.widget.common.SplashScreenWidget:_construct1(ctx)
	jk.widget.common.SplashScreenWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, ctx) end
	self.slides = {}
	return self
end

function jk.widget.common.SplashScreenWidget:addSlide(resource, delay, bgColor)
	local slide = _g.jk.widget.common.SplashScreenWidget.Slide._construct0(_g.jk.widget.common.SplashScreenWidget.Slide._create())
	slide.resource = resource
	slide.delay = delay
	if bgColor ~= nil then
		slide.backgroundColor = bgColor
	end
	do _g.jk.lang.Vector:append(self.slides, slide) end
end

function jk.widget.common.SplashScreenWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	if self.backgroundColor ~= nil then
		self.canvas = _g.jk.widget.CanvasWidget:forColor(self.context, self.backgroundColor)
	else
		self.canvas = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
	end
	do self:addWidget(self.canvas) end
	do self:nextImage() end
end

function jk.widget.common.SplashScreenWidget:nextImage()
	do self.currentSlide = self.currentSlide + 1 end
	do
		local slide = _g.jk.lang.Vector:get(self.slides, self.currentSlide)
		if slide == nil then
			local anim = _g.jk.widget.WidgetAnimation:forDuration(self.context, 1000)
			do anim:addFadeOut(self.currentImageWidget, true) end
			do anim:setEndListener(function()
				do self:onEnded() end
			end) end
			do anim:start() end
			do return end
		end
		if self.canvas ~= nil and slide.backgroundColor ~= nil then
			do self.canvas:setWidgetColor(slide.backgroundColor) end
		elseif not (slide.backgroundColor ~= nil) and not (self.backgroundColor ~= nil) then
			do self.canvas:setWidgetColor(nil) end
		end
		do
			local imageWidget = _g.jk.widget.ImageWidget:forImageResource(self.context, slide.resource)
			do _g.jk.widget.Widget:setAlpha(imageWidget, 0) end
			do imageWidget:setWidgetImageWidth(self.context:getWidthValue(self.imageWidgetWidth)) end
			do
				local align = _g.jk.widget.AlignWidget:forWidget(self.context, imageWidget, 0.5, 0.5, 0)
				local sz = self.context:getWidthValue(self.margin)
				if sz > 0 then
					do align:setWidgetMargin(sz) end
				end
				do self:addWidget(align) end
				do
					local anim = _g.jk.widget.WidgetAnimation:forDuration(self.context, 1000)
					do anim:addCrossFade(self.currentImageWidget, imageWidget, true) end
					do anim:start() end
					self.currentImageWidget = imageWidget
					do self.context:startTimer(slide.delay, function()
						do self:nextImage() end
					end) end
				end
			end
		end
	end
end

function jk.widget.common.SplashScreenWidget:onEnded()
	if self.doneHandler ~= nil then
		do self.doneHandler() end
	end
end

function jk.widget.common.SplashScreenWidget:getBackgroundColor()
	do return self.backgroundColor end
end

function jk.widget.common.SplashScreenWidget:setBackgroundColor(v)
	self.backgroundColor = v
	do return self end
end

function jk.widget.common.SplashScreenWidget:getDoneHandler()
	do return self.doneHandler end
end

function jk.widget.common.SplashScreenWidget:setDoneHandler(v)
	self.doneHandler = v
	do return self end
end

function jk.widget.common.SplashScreenWidget:getImageWidgetWidth()
	do return self.imageWidgetWidth end
end

function jk.widget.common.SplashScreenWidget:setImageWidgetWidth(v)
	self.imageWidgetWidth = v
	do return self end
end

function jk.widget.common.SplashScreenWidget:getMargin()
	do return self.margin end
end

function jk.widget.common.SplashScreenWidget:setMargin(v)
	self.margin = v
	do return self end
end

jk.widget.common.ImageButtonWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.ImageButtonWidget.__index = jk.widget.common.ImageButtonWidget
_vm:set_metatable(jk.widget.common.ImageButtonWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.ImageButtonWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.ImageButtonWidget)
	return v
end

function jk.widget.common.ImageButtonWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.ImageButtonWidget'
	self['_isType.jk.widget.common.ImageButtonWidget'] = true
	self.widgetContext = nil
	self.widgetImage = nil
	self.widgetImageResource = nil
	self.widgetClickHandler = nil
	self.widgetImageScale = 0
	self.widgetButtonWidth = 0
	self.widgetButtonHeight = 0
	self.imageWidget = nil
end

function jk.widget.common.ImageButtonWidget:_construct0()
	jk.widget.common.ImageButtonWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.ImageButtonWidget:forImage(context, image, handler)
	local v = _g.jk.widget.common.ImageButtonWidget._construct1(_g.jk.widget.common.ImageButtonWidget._create(), context)
	do v:setWidgetImage(image) end
	do v:setWidgetClickHandler1(handler) end
	do return v end
end

function jk.widget.common.ImageButtonWidget:forImageResource(context, resName, handler)
	local v = _g.jk.widget.common.ImageButtonWidget._construct1(_g.jk.widget.common.ImageButtonWidget._create(), context)
	do v:setWidgetImageResource(resName) end
	do v:setWidgetClickHandler1(handler) end
	do return v end
end

function jk.widget.common.ImageButtonWidget:_construct1(ctx)
	jk.widget.common.ImageButtonWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, ctx) end
	self.widgetContext = ctx
	return self
end

function jk.widget.common.ImageButtonWidget:setWidgetImage(image)
	self.widgetImage = image
	self.widgetImageResource = nil
	do self:updateImageWidget() end
	do return self end
end

function jk.widget.common.ImageButtonWidget:setWidgetImageResource(resName)
	self.widgetImageResource = resName
	self.widgetImage = nil
	do self:updateImageWidget() end
	do return self end
end

function jk.widget.common.ImageButtonWidget:setWidgetClickHandler1(handler)
	self.widgetClickHandler = handler
	do _g.jk.widget.Widget:setWidgetClickHandler(self, handler) end
	do return self end
end

function jk.widget.common.ImageButtonWidget:updateImageWidget()
	if not (self.imageWidget ~= nil) then
		do return end
	end
	if self.widgetImage ~= nil then
		do self.imageWidget:setWidgetImage(self.widgetImage) end
	else
		do self.imageWidget:setWidgetImageResource(self.widgetImageResource) end
	end
end

function jk.widget.common.ImageButtonWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	self.imageWidget = _g.jk.widget.ImageWidget._construct1(_g.jk.widget.ImageWidget._create(), self.context)
	do self.imageWidget:setWidgetImageScaleMethod(self.widgetImageScale) end
	do self.imageWidget:setWidgetImageWidth(self.widgetButtonWidth) end
	do self.imageWidget:setWidgetImageHeight(self.widgetButtonHeight) end
	do self:addWidget(self.imageWidget) end
	do self:updateImageWidget() end
end

function jk.widget.common.ImageButtonWidget:getWidgetImageScale()
	do return self.widgetImageScale end
end

function jk.widget.common.ImageButtonWidget:setWidgetImageScale(v)
	self.widgetImageScale = v
	do return self end
end

function jk.widget.common.ImageButtonWidget:getWidgetButtonWidth()
	do return self.widgetButtonWidth end
end

function jk.widget.common.ImageButtonWidget:setWidgetButtonWidth(v)
	self.widgetButtonWidth = v
	do return self end
end

function jk.widget.common.ImageButtonWidget:getWidgetButtonHeight()
	do return self.widgetButtonHeight end
end

function jk.widget.common.ImageButtonWidget:setWidgetButtonHeight(v)
	self.widgetButtonHeight = v
	do return self end
end

jk.widget.common.ButtonWithImageWidget = _g.jk.widget.VerticalBoxWidget._create()
jk.widget.common.ButtonWithImageWidget.__index = jk.widget.common.ButtonWithImageWidget
_vm:set_metatable(jk.widget.common.ButtonWithImageWidget, {
	__index = _g.jk.widget.VerticalBoxWidget
})

function jk.widget.common.ButtonWithImageWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.ButtonWithImageWidget)
	return v
end

function jk.widget.common.ButtonWithImageWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.ButtonWithImageWidget'
	self['_isType.jk.widget.common.ButtonWithImageWidget'] = true
	self.image = nil
	self.label = nil
end

function jk.widget.common.ButtonWithImageWidget:_construct0()
	jk.widget.common.ButtonWithImageWidget._init(self)
	do _g.jk.widget.VerticalBoxWidget._construct0(self) end
	return self
end

function jk.widget.common.ButtonWithImageWidget:_construct1(ctx)
	jk.widget.common.ButtonWithImageWidget._init(self)
	do _g.jk.widget.VerticalBoxWidget._construct1(self, ctx) end
	do self:forceCreateWidget() end
	return self
end

function jk.widget.common.ButtonWithImageWidget:setWidgetButtonImage(source)
	do self.image:setWidgetImageResource(source) end
	do return self end
end

function jk.widget.common.ButtonWithImageWidget:setWidgetButtonTitle(title)
	do self.label:setWidgetText(title) end
	do return self end
end

function jk.widget.common.ButtonWithImageWidget:setWidgetClickHandler1(handler)
	if not (handler ~= nil) then
		do return nil end
	end
	do _g.jk.widget.Widget:setWidgetClickHandler(self, handler) end
	do return self end
end

function jk.widget.common.ButtonWithImageWidget:setWidgetFontSize(size)
	do self.label:setWidgetFontSize(size) end
	do return self end
end

function jk.widget.common.ButtonWithImageWidget:setWidgetImageSize(size)
	do self.image:setWidgetImageWidth(size) end
	do self.image:setWidgetImageHeight(size) end
	do return self end
end

function jk.widget.common.ButtonWithImageWidget:createWidget()
	do _g.jk.widget.VerticalBoxWidget.createWidget(self) end
	do
		local thisWidget = self
		do self:setWidgetSpacing(self.context:getHeightValue("1000um")) end
		do
			local widget = _g.jk.widget.AlignWidget._construct1(_g.jk.widget.AlignWidget._create(), self.context)
			self.image = _g.jk.widget.ImageWidget._construct1(_g.jk.widget.ImageWidget._create(), self.context)
			do self.image:setWidgetImageScaleMethod(_g.jk.widget.ImageWidget.FIT) end
			do self.image:setWidgetImageWidth(self.context:getHeightValue("4mm")) end
			do self.image:setWidgetImageHeight(self.context:getHeightValue("4mm")) end
			do widget:addWidget(self.image) end
			do self:addWidget1(widget, 1.0) end
			self.label = _g.jk.widget.LabelWidget._construct1(_g.jk.widget.LabelWidget._create(), self.context)
			do self.label:setWidgetTextAlign(_g.jk.widget.LabelWidget.ALIGN_CENTER) end
			do self.label:setWidgetFontSize(self.context:getHeightValue("2000um")) end
			do self:addWidget(self.label) end
		end
	end
end

jk.widget.common.DateSelectorWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.DateSelectorWidget.__index = jk.widget.common.DateSelectorWidget
_vm:set_metatable(jk.widget.common.DateSelectorWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.DateSelectorWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.DateSelectorWidget)
	return v
end

function jk.widget.common.DateSelectorWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.DateSelectorWidget'
	self['_isType.jk.widget.common.DateSelectorWidget'] = true
	self['_isType.jk.widget.WidgetWithValue'] = true
	self.widgetContext = nil
	self.dayBox = nil
	self.monthBox = nil
	self.yearBox = nil
	self.value = nil
	self.skipYears = 0
end

function jk.widget.common.DateSelectorWidget:_construct0()
	jk.widget.common.DateSelectorWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.DateSelectorWidget:forContext1(context)
	do return _g.jk.widget.common.DateSelectorWidget._construct1(_g.jk.widget.common.DateSelectorWidget._create(), context) end
end

function jk.widget.common.DateSelectorWidget:_construct1(ctx)
	jk.widget.common.DateSelectorWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, ctx) end
	self.widgetContext = ctx
	return self
end

function jk.widget.common.DateSelectorWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	self.dayBox = _g.jk.widget.common.SelectWidget:forStringList1(self.context, {
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"10",
		"11",
		"12",
		"13",
		"14",
		"15",
		"16",
		"17",
		"18",
		"19",
		"20",
		"21",
		"22",
		"23",
		"24",
		"25",
		"26",
		"27",
		"28",
		"29",
		"30",
		"31"
	})
	self.monthBox = _g.jk.widget.common.SelectWidget:forKeyValueStrings1(self.context, {
		"1:January",
		"2:February",
		"3:March",
		"4:April",
		"5:May",
		"6:June",
		"7:July",
		"8:August",
		"9:September",
		"10:October",
		"11:November",
		"12:December"
	})
	do self.monthBox:setWidgetValueChangeHandler(function()
		do self:onChangeValues() end
	end) end
	do
		local cy = _g.jk.time.SystemClock:asDateTimeLocal():getYear()
		if cy < 1 then
			cy = 2016
		end
		cy = cy - self.skipYears
		do
			local yearOptions = _g.jk.lang.KeyValueList._construct0(_g.jk.lang.KeyValueList._create())
			do
				local i = cy
				while i >= 1920 do
					local str = _g.jk.lang.String:forInteger(i)
					do yearOptions:add(str, str) end
					do i = i - 1 end
				end
			end
			self.yearBox = _g.jk.widget.common.SelectWidget:forKeyValueList(self.context, yearOptions)
			do self.yearBox:setWidgetValueChangeHandler(function()
				do self:onChangeValues() end
			end) end
			do
				local box = _g.jk.widget.HorizontalBoxWidget:forContext(self.context, 0, 0)
				do box:setWidgetSpacing(self.context:getHeightValue("1mm")) end
				do box:addWidget1(self.dayBox, 1) end
				do box:addWidget1(self.monthBox, 2) end
				do box:addWidget1(self.yearBox, 1) end
				do self:addWidget(box) end
				do self:applyValueToWidgets() end
			end
		end
	end
end

function jk.widget.common.DateSelectorWidget:applyValueToWidgets()
	if self.dayBox == nil or self.monthBox == nil or self.yearBox == nil then
		do return end
	end
	if not (self.value ~= nil) then
		do return end
	end
	do
		local year = _g.jk.lang.String:getSubString(self.value, 0, 4)
		local month = _g.jk.lang.String:getSubString(self.value, 4, 2)
		local day = _g.jk.lang.String:getSubString(self.value, 6, 2)
		if _g.jk.lang.String:startsWith(day, "0", 0) then
			day = _g.jk.lang.String:getEndOfString(day, 1)
		end
		if _g.jk.lang.String:startsWith(month, "0", 0) then
			month = _g.jk.lang.String:getEndOfString(month, 1)
		end
		do self.yearBox:setWidgetValue(year) end
		do self.monthBox:setWidgetValue(month) end
		do self.dayBox:setWidgetValue(day) end
	end
end

function jk.widget.common.DateSelectorWidget:getValueFromWidgets()
	if self.dayBox == nil or self.monthBox == nil or self.yearBox == nil then
		do return end
	end
	do
		local year = _g.jk.lang.String:asString(self.yearBox:getWidgetValue())
		local month = _g.jk.lang.String:asString(self.monthBox:getWidgetValue())
		local day = _g.jk.lang.String:asString(self.dayBox:getWidgetValue())
		local sb = _g.jk.lang.StringBuilder._construct0(_g.jk.lang.StringBuilder._create())
		do sb:appendString(year) end
		if _g.jk.lang.String:getLength(month) == 1 then
			do sb:appendCharacter(48) end
		end
		do sb:appendString(month) end
		if _g.jk.lang.String:getLength(day) == 1 then
			do sb:appendCharacter(48) end
		end
		do sb:appendString(day) end
		self.value = sb:toString()
	end
end

function jk.widget.common.DateSelectorWidget:setWidgetValue(value)
	self.value = (function(o)
		if (_vm:get_variable_type(o) == 'string') then
			do return o end
		end
		do return nil end
	end)(value)
	do self:applyValueToWidgets() end
end

function jk.widget.common.DateSelectorWidget:getWidgetValue()
	do self:getValueFromWidgets() end
	do return self.value end
end

function jk.widget.common.DateSelectorWidget:isLeapYear(year)
	if year ~= 0 then
		if _util:convert_to_integer(year % 4) == 0 and _util:convert_to_integer(year % 100) ~= 0 or _util:convert_to_integer(year % 400) == 0 then
			do return true end
		end
	end
	do return false end
end

function jk.widget.common.DateSelectorWidget:getNumberOfDays(month, year)
	if month == 4 or month == 6 or month == 9 or month == 11 then
		do return 30 end
	elseif month == 2 then
		if self:isLeapYear(year) then
			do return 29 end
		end
		do return 28 end
	end
	do return 31 end
end

function jk.widget.common.DateSelectorWidget:onChangeValues()
	if not _g.jk.lang.String:isNotEmpty(self.monthBox:getSelectedWidgetValue()) then
		do return end
	end
	if not _g.jk.lang.String:isNotEmpty(self.yearBox:getSelectedWidgetValue()) then
		do return end
	end
	do
		local numberOfDays = self:getNumberOfDays(_g.jk.lang.String:toInteger(self.monthBox:getSelectedWidgetValue()), _g.jk.lang.String:toInteger(self.yearBox:getSelectedWidgetValue()))
		local d = {}
		do
			local x = 1
			while x <= numberOfDays do
				do _g.jk.lang.Vector:append(d, _g.jk.lang.String:forInteger(x)) end
				do x = x + 1 end
			end
		end
		do self.dayBox:setWidgetItemsAsStringList2(d) end
	end
end

function jk.widget.common.DateSelectorWidget:getSkipYears()
	do return self.skipYears end
end

function jk.widget.common.DateSelectorWidget:setSkipYears(v)
	self.skipYears = v
	do return self end
end

jk.widget.common.ButtonWidget = {}
jk.widget.common.ButtonWidget.__index = jk.widget.common.ButtonWidget
_vm:set_metatable(jk.widget.common.ButtonWidget, {})

function jk.widget.common.ButtonWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.ButtonWidget)
	return v
end

function jk.widget.common.ButtonWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.ButtonWidget'
	self['_isType.jk.widget.common.ButtonWidget'] = true
	self.widgetContext = nil
	self.widgetText = nil
	self.widgetTextColor = nil
	self.widgetBackgroundColor = nil
	self.widgetIcon = nil
	self.widgetClickHandler = nil
	self.widgetFont = nil
	self.widgetFontSize = 0.0
end

function jk.widget.common.ButtonWidget:_construct0()
	jk.widget.common.ButtonWidget._init(self)
	return self
end

function jk.widget.common.ButtonWidget:forText(context, text, handler)
	local v = _g.jk.widget.common.ButtonWidget._construct1(_g.jk.widget.common.ButtonWidget._create(), context)
	do v:setWidgetText(text) end
	do v:setWidgetClickHandler(handler) end
	do return v end
end

function jk.widget.common.ButtonWidget:_construct1(context)
	jk.widget.common.ButtonWidget._init(self)
	self.widgetContext = context
	return self
end

function jk.widget.common.ButtonWidget:setWidgetText(text)
	self.widgetText = text
	_io:write_to_stdout("[jk.widget.common.ButtonWidget.setWidgetText] (ButtonWidget.sling:141:3): Not implemented" .. "\n")
end

function jk.widget.common.ButtonWidget:getWidgetText()
	do return self.widgetText end
end

function jk.widget.common.ButtonWidget:setWidgetTextColor(color)
	self.widgetTextColor = color
	_io:write_to_stdout("[jk.widget.common.ButtonWidget.setWidgetTextColor] (ButtonWidget.sling:211:3): Not implemented" .. "\n")
end

function jk.widget.common.ButtonWidget:getWidgetTextColor()
	do return self.widgetTextColor end
end

function jk.widget.common.ButtonWidget:setWidgetBackgroundColor(color)
	self.widgetBackgroundColor = color
	_io:write_to_stdout("[jk.widget.common.ButtonWidget.setWidgetBackgroundColor] (ButtonWidget.sling:282:3): Not implemented" .. "\n")
end

function jk.widget.common.ButtonWidget:getWidgetBackgroundColor()
	do return self.widgetBackgroundColor end
end

function jk.widget.common.ButtonWidget:onWidgetClicked()
	if self.widgetClickHandler ~= nil then
		do self.widgetClickHandler() end
	end
end

function jk.widget.common.ButtonWidget:setWidgetClickHandler(handler)
	self.widgetClickHandler = handler
	_io:write_to_stdout("[jk.widget.common.ButtonWidget.setWidgetClickHandler] (ButtonWidget.sling:352:3): Not implemented" .. "\n")
end

function jk.widget.common.ButtonWidget:setWidgetIcon(icon)
	self.widgetIcon = icon
	_io:write_to_stdout("[jk.widget.common.ButtonWidget.setWidgetIcon] (ButtonWidget.sling:369:3): Not implemented" .. "\n")
end

function jk.widget.common.ButtonWidget:getWidgetIcon()
	do return self.widgetIcon end
end

function jk.widget.common.ButtonWidget:setWidgetFont(font)
	self.widgetFont = font
	_io:write_to_stdout("[jk.widget.common.ButtonWidget.setWidgetFont] (ButtonWidget.sling:383:3): Not implemented" .. "\n")
end

function jk.widget.common.ButtonWidget:setWidgetFontSize(fontSize)
	self.widgetFontSize = fontSize
	_io:write_to_stdout("[jk.widget.common.ButtonWidget.setWidgetFontSize] (ButtonWidget.sling:406:3): Not implemented" .. "\n")
end

jk.widget.common.RoundedTextBoxWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.RoundedTextBoxWidget.__index = jk.widget.common.RoundedTextBoxWidget
_vm:set_metatable(jk.widget.common.RoundedTextBoxWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.RoundedTextBoxWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.RoundedTextBoxWidget)
	return v
end

function jk.widget.common.RoundedTextBoxWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.RoundedTextBoxWidget'
	self['_isType.jk.widget.common.RoundedTextBoxWidget'] = true
	self.outline = nil
	self.background = nil
	self.textInput = nil
end

function jk.widget.common.RoundedTextBoxWidget:_construct0()
	jk.widget.common.RoundedTextBoxWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.RoundedTextBoxWidget:_construct1(ctx)
	jk.widget.common.RoundedTextBoxWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, ctx) end
	do self:forceCreateWidget() end
	return self
end

function jk.widget.common.RoundedTextBoxWidget:setWidgetEnabled(enable)
	do _g.jk.widget.Widget:setEnabled(self.textInput, enable) end
	do return self end
end

function jk.widget.common.RoundedTextBoxWidget:setWidgetFontSize(fontsize)
	do self.textInput:setWidgetFontSize(fontsize) end
	do return self end
end

function jk.widget.common.RoundedTextBoxWidget:setWidgetPlaceholder(str)
	do self.textInput:setWidgetPlaceholder(str) end
	do return self end
end

function jk.widget.common.RoundedTextBoxWidget:setWidgetTextChangeHandler(handler)
	if not (handler ~= nil) then
		do return nil end
	end
	do
		local hnd = handler
		do self.textInput:setWidgetTextChangeHandler(function()
			do hnd(self.textInput:getWidgetText()) end
		end) end
		do return self end
	end
end

function jk.widget.common.RoundedTextBoxWidget:setWidgetText(str)
	do self.textInput:setWidgetText(str) end
	do return self end
end

function jk.widget.common.RoundedTextBoxWidget:getWidgetText()
	do return self.textInput:getWidgetText() end
end

function jk.widget.common.RoundedTextBoxWidget:createWidget()
	do _g.jk.widget.LayerWidget.createWidget(self) end
	do
		local thisWidget = self
		do self:setWidgetMargin(self.context:getHeightValue("1px")) end
		self.outline = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
		do self.outline:setWidgetColor(_g.jk.gfx.Color:instance("#BCBEC0")) end
		do self.outline:setWidgetRoundingRadius1(self.context:getHeightValue("2000um")) end
		do self:addWidget(self.outline) end
		do
			local widget = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
			self.background = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
			do self.background:setWidgetColor(_g.jk.gfx.Color:white()) end
			do self.background:setWidgetRoundingRadius1(self.context:getHeightValue("2000um")) end
			do widget:addWidget(self.background) end
			do widget:setWidgetMargin(self.context:getHeightValue("1px")) end
			do
				local widget2 = _g.jk.widget.AlignWidget._construct1(_g.jk.widget.AlignWidget._create(), self.context)
				local widget3 = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
				do widget3:setWidgetMargin(self.context:getHeightValue("3px")) end
				self.textInput = _g.jk.widget.common.TextInputWidget._construct1(_g.jk.widget.common.TextInputWidget._create(), self.context)
				do self.textInput:setWidgetFontSize(self.context:getHeightValue("2000um")) end
				do widget3:addWidget(self.textInput) end
				do widget2:addWidget1(widget3, 0.0, 0.5, true) end
				do widget:addWidget(widget2) end
				do self:addWidget(widget) end
			end
		end
	end
end

jk.widget.common.TextInputWidget = _g.jk.widget.Widget._create()
jk.widget.common.TextInputWidget.__index = jk.widget.common.TextInputWidget
_vm:set_metatable(jk.widget.common.TextInputWidget, {
	__index = _g.jk.widget.Widget
})

jk.widget.common.TextInputWidget.TYPE_DEFAULT = 0
jk.widget.common.TextInputWidget.TYPE_NONASSISTED = 1
jk.widget.common.TextInputWidget.TYPE_NAME = 2
jk.widget.common.TextInputWidget.TYPE_EMAIL_ADDRESS = 3
jk.widget.common.TextInputWidget.TYPE_URL = 4
jk.widget.common.TextInputWidget.TYPE_PHONE_NUMBER = 5
jk.widget.common.TextInputWidget.TYPE_PASSWORD = 6
jk.widget.common.TextInputWidget.TYPE_INTEGER = 7
jk.widget.common.TextInputWidget.TYPE_FLOAT = 8
jk.widget.common.TextInputWidget.TYPE_STREET_ADDRESS = 9
jk.widget.common.TextInputWidget.ALIGN_LEFT = 0
jk.widget.common.TextInputWidget.ALIGN_RIGHT = 1
jk.widget.common.TextInputWidget.ALIGN_CENTER = 2

function jk.widget.common.TextInputWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.TextInputWidget)
	return v
end

function jk.widget.common.TextInputWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.TextInputWidget'
	self['_isType.jk.widget.common.TextInputWidget'] = true
	self['_isType.jk.widget.WidgetWithValue'] = true
	self.widgetContext = nil
	self.widgetType = 0
	self.widgetPlaceholder = nil
	self.widgetText = nil
	self.widgetFontUnderline = false
	self.widgetFontItalic = false
	self.widgetFontBold = false
	self.widgetTextAlign = 0
	self.widgetPaddingLeft = 0
	self.widgetPaddingTop = 0
	self.widgetPaddingRight = 0
	self.widgetPaddingBottom = 0
	self.widgetFontFamily = nil
	self.widgetFontResource = nil
	self.widgetFontSize = 0.0
	self.widgetTextColor = nil
	self.widgetBackgroundColor = nil
	self.widgetIsEnabled = true
	self.widgetTextChangeHandler = nil
	self.widgetOnEnterKeyPressed = nil
	self.widgetOnArrowUpKeyPressed = nil
	self.widgetOnArrowDownKeyPressed = nil
	self.widgetOnFocusHandler = nil
	self.widgetOnLoseFocusHandler = nil
end

function jk.widget.common.TextInputWidget:_construct0()
	jk.widget.common.TextInputWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	return self
end

function jk.widget.common.TextInputWidget:forType(context, type, placeholder)
	local v = _g.jk.widget.common.TextInputWidget._construct1(_g.jk.widget.common.TextInputWidget._create(), context)
	do v:setWidgetType(type) end
	do v:setWidgetPlaceholder(placeholder) end
	do return v end
end

function jk.widget.common.TextInputWidget:_construct1(context)
	jk.widget.common.TextInputWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	self.widgetContext = context
	do self:setWidgetStyle("TextInputWidget") end
	return self
end

function jk.widget.common.TextInputWidget:setWidgetStyle(style)
	self.widgetFontFamily = self.widgetContext:getStyleString(style, "fontFamily", nil)
	if _g.jk.lang.String:isEmpty(self.widgetFontFamily) then
		self.widgetFontFamily = "Arial"
	end
	self.widgetFontSize = self.widgetContext:getStylePixels(style, "fontSize", nil)
	if self.widgetFontSize < 1.0 then
		self.widgetFontSize = self.widgetContext:getHeightValue("3mm")
	end
	do
		local fr = self.widgetContext:getStyleString(style, "fontResource", nil)
		if _g.jk.lang.String:isNotEmpty(fr) then
			do self:setWidgetFontResource(fr) end
		end
		self.widgetTextColor = self.widgetContext:getStyleColor(style, "textColor", nil)
		self.widgetBackgroundColor = self.widgetContext:getStyleColor(style, "backgroundColor", nil)
		do self:setWidgetPadding1(self.widgetContext:getStylePixels(style, "padding", nil)) end
		do self:updateWidgetFont() end
		do self:updateWidgetColors() end
		do return self end
	end
end

function jk.widget.common.TextInputWidget:setWidgetTextColor(color)
	self.widgetTextColor = color
	do self:updateWidgetColors() end
	do return self end
end

function jk.widget.common.TextInputWidget:getWidgetTextColor()
	do return self.widgetTextColor end
end

function jk.widget.common.TextInputWidget:setWidgetBackgroundColor(color)
	self.widgetBackgroundColor = color
	do self:updateWidgetColors() end
	do return self end
end

function jk.widget.common.TextInputWidget:getWidgetBackgroundColor()
	do return self.widgetBackgroundColor end
end

function jk.widget.common.TextInputWidget:updateWidgetColors()
	local textColor = self.widgetTextColor
	if textColor == nil then
		if self.widgetBackgroundColor ~= nil then
			if self.widgetBackgroundColor:isLightColor() then
				textColor = _g.jk.gfx.Color:black()
			else
				textColor = _g.jk.gfx.Color:white()
			end
		else
			textColor = _g.jk.gfx.Color:black()
		end
	end
	_io:write_to_stdout("[jk.widget.common.TextInputWidget.updateWidgetColors] (TextInputWidget.sling:483:3): Not implemented" .. "\n")
end

function jk.widget.common.TextInputWidget:setWidgetType(type)
	self.widgetType = type
	_io:write_to_stdout("[jk.widget.common.TextInputWidget.setWidgetType] (TextInputWidget.sling:796:3): Not implemented" .. "\n")
	do self:updateWidgetFont() end
	do return self end
end

function jk.widget.common.TextInputWidget:getWidgetType()
	do return self.widgetType end
end

function jk.widget.common.TextInputWidget:setWidgetText(text)
	self.widgetText = text
	_io:write_to_stdout("[jk.widget.common.TextInputWidget.setWidgetText] (TextInputWidget.sling:843:3): Not implemented" .. "\n")
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.TextInputWidget:getWidgetText()
	_io:write_to_stdout("[jk.widget.common.TextInputWidget.getWidgetText] (TextInputWidget.sling:874:3): Not implemented" .. "\n")
	do return nil end
end

function jk.widget.common.TextInputWidget:setWidgetPlaceholder(placeholder)
	self.widgetPlaceholder = placeholder
	_io:write_to_stdout("[jk.widget.common.TextInputWidget.setWidgetPlaceholder] (TextInputWidget.sling:913:3): Not implemented" .. "\n")
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.TextInputWidget:getWidgetPlaceholder()
	do return self.widgetPlaceholder end
end

function jk.widget.common.TextInputWidget:setWidgetFontBold(bold)
	self.widgetFontBold = bold
	do self:updateWidgetFont() end
end

function jk.widget.common.TextInputWidget:setWidgetFontUnderline(underline)
	self.widgetFontUnderline = underline
	do self:updateWidgetFont() end
end

function jk.widget.common.TextInputWidget:setWidgetFontItalic(italic)
	self.widgetFontItalic = italic
	do self:updateWidgetFont() end
end

function jk.widget.common.TextInputWidget:getWidgetFontUnderline()
	do return self.widgetFontUnderline end
end

function jk.widget.common.TextInputWidget:getWidgetFontItalic()
	do return self.widgetFontItalic end
end

function jk.widget.common.TextInputWidget:getWidgetFontBold()
	do return self.widgetFontBold end
end

function jk.widget.common.TextInputWidget:setWidgetPadding1(padding)
	do self:setWidgetPadding3(padding, padding, padding, padding) end
end

function jk.widget.common.TextInputWidget:setWidgetPadding2(x, y)
	do self:setWidgetPadding3(x, y, x, y) end
end

function jk.widget.common.TextInputWidget:setWidgetPadding3(l, t, r, b)
	if l < 0 or t < 0 or r < 0 or b < 0 then
		do return self end
	end
	if self.widgetPaddingLeft == l and self.widgetPaddingTop == t and self.widgetPaddingRight == r and self.widgetPaddingBottom == b then
		do return self end
	end
	self.widgetPaddingLeft = l
	self.widgetPaddingTop = t
	self.widgetPaddingRight = r
	self.widgetPaddingBottom = b
	do self:updateWidgetPadding() end
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.TextInputWidget:updateWidgetPadding()
	_io:write_to_stdout("[jk.widget.common.TextInputWidget.updateWidgetPadding] (TextInputWidget.sling:1005:3): Not implemented" .. "\n")
end

function jk.widget.common.TextInputWidget:setWidgetFontFamily(family)
	self.widgetFontFamily = family
	do self:updateWidgetFont() end
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.TextInputWidget:setWidgetFontResource(res)
	self.widgetFontResource = res
	do self:updateWidgetFont() end
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.TextInputWidget:setWidgetFontSize(fontSize)
	self.widgetFontSize = fontSize
	do self:updateWidgetFont() end
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.TextInputWidget:updateWidgetFont()
	_io:write_to_stdout("[jk.widget.common.TextInputWidget.updateWidgetFont] (TextInputWidget.sling:1118:3): Not implemented" .. "\n")
end

function jk.widget.common.TextInputWidget:setWidgetIsEnabled(v)
	self.widgetIsEnabled = v
	_io:write_to_stdout("[jk.widget.common.TextInputWidget.setWidgetIsEnabled] (TextInputWidget.sling:1139:3): Not implemented" .. "\n")
end

function jk.widget.common.TextInputWidget:getWidgetIsEnabled()
	do return self.widgetIsEnabled end
end

function jk.widget.common.TextInputWidget:setWidgetValue(value)
	local v = _g.jk.lang.String:asString(value)
	if not (v ~= nil) then
		v = ""
	end
	do self:setWidgetText(v) end
end

function jk.widget.common.TextInputWidget:getWidgetValue()
	do return self:getWidgetText() end
end

function jk.widget.common.TextInputWidget:onChangeListener()
	if self.widgetTextChangeHandler ~= nil then
		do self.widgetTextChangeHandler() end
	end
end

function jk.widget.common.TextInputWidget:onEnterKeyListener()
	if self.widgetOnEnterKeyPressed ~= nil then
		do self.widgetOnEnterKeyPressed() end
	end
end

function jk.widget.common.TextInputWidget:onArrowUpKeyListener()
	if self.widgetOnArrowUpKeyPressed ~= nil then
		do self.widgetOnArrowUpKeyPressed() end
	end
end

function jk.widget.common.TextInputWidget:onArrowDownKeyListener()
	if self.widgetOnArrowDownKeyPressed ~= nil then
		do self.widgetOnArrowDownKeyPressed() end
	end
end

function jk.widget.common.TextInputWidget:onFocusListener()
	if self.widgetOnFocusHandler ~= nil then
		do self.widgetOnFocusHandler() end
	end
end

function jk.widget.common.TextInputWidget:onLoseFocusListener()
	if self.widgetOnLoseFocusHandler ~= nil then
		do self.widgetOnLoseFocusHandler() end
	end
end

function jk.widget.common.TextInputWidget:focus1()
	_io:write_to_stdout("[jk.widget.common.TextInputWidget.focus] (TextInputWidget.sling:1217:3): Not implemented" .. "\n")
end

function jk.widget.common.TextInputWidget:setWidgetTextAlign(align)
	self.widgetTextAlign = align
	_io:write_to_stdout("[jk.widget.common.TextInputWidget.setWidgetTextAlign] (TextInputWidget.sling:1343:3): Not implemented" .. "\n")
	do return self end
end

function jk.widget.common.TextInputWidget:getWidgetTextAlign()
	do return self.widgetTextAlign end
end

function jk.widget.common.TextInputWidget:setWidgetMaxLength(v)
	_io:write_to_stdout("[jk.widget.common.TextInputWidget.setWidgetMaxLength] (TextInputWidget.sling:1375:3): Not implemented" .. "\n")
	do return self end
end

function jk.widget.common.TextInputWidget:getWidgetTextChangeHandler()
	do return self.widgetTextChangeHandler end
end

function jk.widget.common.TextInputWidget:setWidgetTextChangeHandler(v)
	self.widgetTextChangeHandler = v
	do return self end
end

function jk.widget.common.TextInputWidget:getWidgetOnEnterKeyPressed()
	do return self.widgetOnEnterKeyPressed end
end

function jk.widget.common.TextInputWidget:setWidgetOnEnterKeyPressed(v)
	self.widgetOnEnterKeyPressed = v
	do return self end
end

function jk.widget.common.TextInputWidget:getWidgetOnArrowUpKeyPressed()
	do return self.widgetOnArrowUpKeyPressed end
end

function jk.widget.common.TextInputWidget:setWidgetOnArrowUpKeyPressed(v)
	self.widgetOnArrowUpKeyPressed = v
	do return self end
end

function jk.widget.common.TextInputWidget:getWidgetOnArrowDownKeyPressed()
	do return self.widgetOnArrowDownKeyPressed end
end

function jk.widget.common.TextInputWidget:setWidgetOnArrowDownKeyPressed(v)
	self.widgetOnArrowDownKeyPressed = v
	do return self end
end

function jk.widget.common.TextInputWidget:getWidgetOnFocusHandler()
	do return self.widgetOnFocusHandler end
end

function jk.widget.common.TextInputWidget:setWidgetOnFocusHandler(v)
	self.widgetOnFocusHandler = v
	do return self end
end

function jk.widget.common.TextInputWidget:getWidgetOnLoseFocusHandler()
	do return self.widgetOnLoseFocusHandler end
end

function jk.widget.common.TextInputWidget:setWidgetOnLoseFocusHandler(v)
	self.widgetOnLoseFocusHandler = v
	do return self end
end

jk.widget.common.RouteNavigationWidget = _g.jk.widget.common.NavigationFrameWidget._create()
jk.widget.common.RouteNavigationWidget.__index = jk.widget.common.RouteNavigationWidget
_vm:set_metatable(jk.widget.common.RouteNavigationWidget, {
	__index = _g.jk.widget.common.NavigationFrameWidget
})

function jk.widget.common.RouteNavigationWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.RouteNavigationWidget)
	return v
end

function jk.widget.common.RouteNavigationWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.RouteNavigationWidget'
	self['_isType.jk.widget.common.RouteNavigationWidget'] = true
	self['_isType.jk.ui.RouterListener'] = true
	self.routes = nil
end

function jk.widget.common.RouteNavigationWidget:_construct0()
	jk.widget.common.RouteNavigationWidget._init(self)
	do _g.jk.widget.common.NavigationFrameWidget._construct0(self) end
	return self
end

jk.widget.common.RouteNavigationWidget.Route = {}
jk.widget.common.RouteNavigationWidget.Route.__index = jk.widget.common.RouteNavigationWidget.Route
_vm:set_metatable(jk.widget.common.RouteNavigationWidget.Route, {})

function jk.widget.common.RouteNavigationWidget.Route._create()
	local v = _vm:set_metatable({}, jk.widget.common.RouteNavigationWidget.Route)
	return v
end

function jk.widget.common.RouteNavigationWidget.Route:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.RouteNavigationWidget.Route'
	self['_isType.jk.widget.common.RouteNavigationWidget.Route'] = true
	self.name = nil
	self.handler = nil
end

function jk.widget.common.RouteNavigationWidget.Route:_construct0()
	jk.widget.common.RouteNavigationWidget.Route._init(self)
	return self
end

function jk.widget.common.RouteNavigationWidget.Route:getName()
	do return self.name end
end

function jk.widget.common.RouteNavigationWidget.Route:setName(v)
	self.name = v
	do return self end
end

function jk.widget.common.RouteNavigationWidget.Route:getHandler()
	do return self.handler end
end

function jk.widget.common.RouteNavigationWidget.Route:setHandler(v)
	self.handler = v
	do return self end
end

function jk.widget.common.RouteNavigationWidget:_construct1(ctx)
	jk.widget.common.RouteNavigationWidget._init(self)
	do _g.jk.widget.common.NavigationFrameWidget._construct1(self, ctx) end
	self.routes = {}
	return self
end

function jk.widget.common.RouteNavigationWidget:initializeWidget()
	do _g.jk.widget.common.NavigationFrameWidget.initializeWidget(self) end
	do _g.jk.ui.Router:goToDefault() end
end

function jk.widget.common.RouteNavigationWidget:onRouteChanged(route)
	local w = self:getWidget(route)
	if not (w ~= nil) then
		do return end
	end
	do _g.jk.widget.Widget:removeChildrenOf(self.contentArea) end
	do self.contentArea:addWidget(w) end
	if (_vm:to_table_with_key(w, '_isType.jk.widget.DisplayAwareWidget') ~= nil) then
		do w:onWidgetDisplayed() end
	end
end

function jk.widget.common.RouteNavigationWidget:initializeRoutes(rs)
	if not (rs ~= nil) then
		do return false end
	end
	if rs ~= nil then
		local n = 0
		local m2 = #rs
		do
			n = 0
			while n < m2 do
				local m = _vm:to_table_with_key(rs[n + 1], '_isType.jk.widget.common.RouteNavigationWidget.Route')
				if m ~= nil then
					local route = m:getName()
					local widget = m:getHandler()
					do self:addRoute(route, widget) end
				end
				do n = n + 1 end
			end
		end
	end
	do return true end
end

function jk.widget.common.RouteNavigationWidget:addRoute(route, callback)
	if not (self.routes ~= nil) then
		self.routes = {}
	end
	self.routes[route] = callback
end

function jk.widget.common.RouteNavigationWidget:getWidget(route)
	local w = _g.jk.lang.Map:getValue(self.routes, route)
	if not (w ~= nil) then
		w = _g.jk.lang.Map:getValue(self.routes, "*")
	end
	if not (w ~= nil) then
		do return nil end
	end
	do return w() end
end

jk.widget.common.MenuBarWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.MenuBarWidget.__index = jk.widget.common.MenuBarWidget
_vm:set_metatable(jk.widget.common.MenuBarWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.MenuBarWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.MenuBarWidget)
	return v
end

function jk.widget.common.MenuBarWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.MenuBarWidget'
	self['_isType.jk.widget.common.MenuBarWidget'] = true
	self.box = nil
end

function jk.widget.common.MenuBarWidget:_construct0()
	jk.widget.common.MenuBarWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.MenuBarWidget:_construct1(context)
	jk.widget.common.MenuBarWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.MenuBarWidget:addMenu(title, menu)
	local v = menu
	if not (v ~= nil) then
		v = _g.jk.widget.Menu._construct0(_g.jk.widget.Menu._create())
	end
	do
		local m = v
		local button = _g.jk.widget.common.TextButtonWidget:forText(self.context, title, nil)
		do button:setWidgetPadding(self.context:getHeightValue("1mm")) end
		do button:setWidgetPaddingHorizontal(self.context:getWidthValue("3mm")) end
		do button:setWidgetBackgroundColor(_g.jk.gfx.Color:forString("#BBBBBB")) end
		do button:setWidgetClickHandler1(function()
			do _g.jk.widget.common.PopupMenu:showBelow(self.context, button, m, -1, -1) end
		end) end
		do self.box:addWidget(button) end
		do return v end
	end
end

function jk.widget.common.MenuBarWidget:createWidget()
	do _g.jk.widget.LayerWidget.createWidget(self) end
	do
		local thisWidget = self
		local widget = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
		do widget:setWidgetColor(_g.jk.gfx.Color:forString("#BBBBBB")) end
		do self:addWidget(widget) end
		self.box = _g.jk.widget.HorizontalBoxWidget._construct1(_g.jk.widget.HorizontalBoxWidget._create(), self.context)
		do self.box:setWidgetSpacing(self.context:getWidthValue("300um")) end
		do self.box:setWidgetMargin(self.context:getWidthValue("300um")) end
		do self:addWidget(self.box) end
	end
end

jk.widget.common.HyperLinkWidget = _g.jk.widget.Widget._create()
jk.widget.common.HyperLinkWidget.__index = jk.widget.common.HyperLinkWidget
_vm:set_metatable(jk.widget.common.HyperLinkWidget, {
	__index = _g.jk.widget.Widget
})

function jk.widget.common.HyperLinkWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.HyperLinkWidget)
	return v
end

function jk.widget.common.HyperLinkWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.HyperLinkWidget'
	self['_isType.jk.widget.common.HyperLinkWidget'] = true
	self.widgetContext = nil
	self.widgetText = nil
	self.widgetTextColor = nil
	self.widgetFontSize = 0.0
	self.widgetClickHandler = nil
	self.widgetUrl = nil
end

function jk.widget.common.HyperLinkWidget:_construct0()
	jk.widget.common.HyperLinkWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	return self
end

function jk.widget.common.HyperLinkWidget:forText(context, text, handler)
	local v = _g.jk.widget.common.HyperLinkWidget._construct1(_g.jk.widget.common.HyperLinkWidget._create(), context)
	do v:setWidgetText(text) end
	do v:setWidgetClickHandler1(handler) end
	do return v end
end

function jk.widget.common.HyperLinkWidget:_construct1(context)
	jk.widget.common.HyperLinkWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	self.widgetContext = context
	do self:setWidgetTextColor(_g.jk.gfx.Color:forRGB(0, 0, 255)) end
	do self:setWidgetFontSize(context:getHeightValue("3mm")) end
	return self
end

function jk.widget.common.HyperLinkWidget:setWidgetText(text)
	self.widgetText = text
	_io:write_to_stdout("[jk.widget.common.HyperLinkWidget.setWidgetText] (HyperLinkWidget.sling:180:3): Not implemented" .. "\n")
end

function jk.widget.common.HyperLinkWidget:getWidgetText()
	do return self.widgetText end
end

function jk.widget.common.HyperLinkWidget:setWidgetTextColor(color)
	self.widgetTextColor = color
	_io:write_to_stdout("[jk.widget.common.HyperLinkWidget.setWidgetTextColor] (HyperLinkWidget.sling:244:3): Not implemented" .. "\n")
	do return self end
end

function jk.widget.common.HyperLinkWidget:getWidgetTextColor()
	do return self.widgetTextColor end
end

function jk.widget.common.HyperLinkWidget:setWidgetFontSize(fontSize)
	self.widgetFontSize = fontSize
	_io:write_to_stdout("[jk.widget.common.HyperLinkWidget.setWidgetFontSize] (HyperLinkWidget.sling:283:3): Not implemented" .. "\n")
end

function jk.widget.common.HyperLinkWidget:getFontSize()
	do return self.widgetFontSize end
end

function jk.widget.common.HyperLinkWidget:setWidgetClickHandler1(handler)
	self.widgetClickHandler = handler
	do _g.jk.widget.Widget:setWidgetClickHandler(self, handler) end
end

function jk.widget.common.HyperLinkWidget:setWidgetUrl(url)
	self.widgetUrl = url
end

function jk.widget.common.HyperLinkWidget:getWidgetUrl()
	do return self.widgetUrl end
end

jk.widget.common.DynamicVerticalScrollerWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.DynamicVerticalScrollerWidget.__index = jk.widget.common.DynamicVerticalScrollerWidget
_vm:set_metatable(jk.widget.common.DynamicVerticalScrollerWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.DynamicVerticalScrollerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.DynamicVerticalScrollerWidget)
	return v
end

function jk.widget.common.DynamicVerticalScrollerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.DynamicVerticalScrollerWidget'
	self['_isType.jk.widget.common.DynamicVerticalScrollerWidget'] = true
	self.widgetProviderHandler = nil
	self.widgetProvider = nil
	self.widgetItemAddCount = 5
	self.lastContainerHeight = -1
	self.onScrollNearEndEventRaised = false
	self.isAdding = false
	self.scroller = nil
	self.container = nil
end

function jk.widget.common.DynamicVerticalScrollerWidget:_construct0()
	jk.widget.common.DynamicVerticalScrollerWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.DynamicVerticalScrollerWidget:_construct1(context)
	jk.widget.common.DynamicVerticalScrollerWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget = _g.jk.widget.VerticalBoxWidget._create()
jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget.__index = jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget
_vm:set_metatable(jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget, {
	__index = _g.jk.widget.VerticalBoxWidget
})

function jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget)
	return v
end

function jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget'
	self['_isType.jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget'] = true
	self.widgetHeightChangeListener = nil
end

function jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget:_construct0()
	jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget._init(self)
	do _g.jk.widget.VerticalBoxWidget._construct0(self) end
	return self
end

function jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget:_construct1(context)
	jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget._init(self)
	do _g.jk.widget.VerticalBoxWidget._construct1(self, context) end
	return self
end

function jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget:onWidgetHeightChanged(height)
	do _g.jk.widget.VerticalBoxWidget.onWidgetHeightChanged(self, height) end
	if self.widgetHeightChangeListener ~= nil then
		do self.widgetHeightChangeListener(height) end
	end
end

function jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget:clear()
	do _g.jk.widget.Widget:removeChildrenOf(self) end
end

function jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget:createWidget()
	do _g.jk.widget.VerticalBoxWidget.createWidget(self) end
	do
		local thisWidget = self
	end
end

function jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget:getWidgetHeightChangeListener()
	do return self.widgetHeightChangeListener end
end

function jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget:setWidgetHeightChangeListener(v)
	self.widgetHeightChangeListener = v
	do return self end
end

function jk.widget.common.DynamicVerticalScrollerWidget:forHandler(context, handler)
	local v = _g.jk.widget.common.DynamicVerticalScrollerWidget._construct1(_g.jk.widget.common.DynamicVerticalScrollerWidget._create(), context)
	do v:setWidgetProviderHandler(handler) end
	do return v end
end

function jk.widget.common.DynamicVerticalScrollerWidget:forProvider(context, provider)
	local v = _g.jk.widget.common.DynamicVerticalScrollerWidget._construct1(_g.jk.widget.common.DynamicVerticalScrollerWidget._create(), context)
	do v:setWidgetProvider(provider) end
	do return v end
end

function jk.widget.common.DynamicVerticalScrollerWidget:forWidgets1(context, widgets)
	local v = _g.jk.widget.common.DynamicVerticalScrollerWidget._construct1(_g.jk.widget.common.DynamicVerticalScrollerWidget._create(), context)
	do v:setWidgetProvider(_g.jk.widget.StaticWidgetProvider:forWidgets(widgets)) end
	do return v end
end

function jk.widget.common.DynamicVerticalScrollerWidget:setWidgetContainerSpacing(height)
	if not (self.container ~= nil) then
		do self:forceCreateWidget() end
	end
	do self.container:setWidgetSpacing(height) end
end

function jk.widget.common.DynamicVerticalScrollerWidget:setWidgetContainerMargin(height)
	if not (self.container ~= nil) then
		do self:forceCreateWidget() end
	end
	do self.container:setWidgetMargin(height) end
end

function jk.widget.common.DynamicVerticalScrollerWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	do self.scroller:setOnScrolledHandler(function(direction)
		do self:onScroll(direction) end
	end) end
	do self:onAddWidget(self.container) end
end

function jk.widget.common.DynamicVerticalScrollerWidget:onScroll(direction)
	if not (self.scroller:isNearEnd() and not self.onScrollNearEndEventRaised) then
		do return end
	end
	self.onScrollNearEndEventRaised = true
	do
		local containerHeight = _g.jk.widget.Widget:getHeight(self.container)
		if not (containerHeight > _g.jk.widget.Widget:getHeight(self.scroller) and self.lastContainerHeight ~= containerHeight) then
			self.onScrollNearEndEventRaised = false
			do return end
		end
		self.lastContainerHeight = containerHeight
		do self:onScrollNearEnd() end
		self.onScrollNearEndEventRaised = false
	end
end

function jk.widget.common.DynamicVerticalScrollerWidget:onContainerHeightChanged(newHeight)
	if _g.jk.widget.Widget:getHeight(self.scroller) * 2 > newHeight then
		do self:showNextWidgets() end
	end
end

function jk.widget.common.DynamicVerticalScrollerWidget:onScrollNearEnd()
	do self:showNextWidgets() end
end

function jk.widget.common.DynamicVerticalScrollerWidget:showNextWidgets()
	if not not self.isAdding then
		do return end
	end
	self.isAdding = true
	do
		local count = self.widgetItemAddCount
		while count > 0 do
			do self:onAddWidget(self.container) end
			do count = count - 1 end
		end
		self.isAdding = false
	end
end

function jk.widget.common.DynamicVerticalScrollerWidget:onAddWidget(container)
	local widget = nil
	if self.widgetProvider ~= nil then
		widget = self.widgetProvider:getNextWidget()
	elseif self.widgetProviderHandler ~= nil then
		widget = self.widgetProviderHandler()
	end
	if widget ~= nil then
		do container:addWidget(widget) end
	end
end

function jk.widget.common.DynamicVerticalScrollerWidget:clear()
	do self.container:clear() end
	if self.widgetProvider ~= nil then
		do self.widgetProvider:reset() end
	end
	do self:showNextWidgets() end
end

function jk.widget.common.DynamicVerticalScrollerWidget:createWidget()
	do _g.jk.widget.LayerWidget.createWidget(self) end
	do
		local thisWidget = self
		self.scroller = _g.jk.widget.VerticalScrollerWidget._construct1(_g.jk.widget.VerticalScrollerWidget._create(), self.context)
		do self.scroller:setWidgetScrollBarDisabled(true) end
		self.container = _g.jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget._construct1(_g.jk.widget.common.DynamicVerticalScrollerWidget.MyContainerWidget._create(), self.context)
		do self.container:setWidgetHeightChangeListener(function(height)
			do self:onContainerHeightChanged(height) end
		end) end
		do self.scroller:addWidget(self.container) end
		do self:addWidget(self.scroller) end
	end
end

function jk.widget.common.DynamicVerticalScrollerWidget:getWidgetProviderHandler()
	do return self.widgetProviderHandler end
end

function jk.widget.common.DynamicVerticalScrollerWidget:setWidgetProviderHandler(v)
	self.widgetProviderHandler = v
	do return self end
end

function jk.widget.common.DynamicVerticalScrollerWidget:getWidgetProvider()
	do return self.widgetProvider end
end

function jk.widget.common.DynamicVerticalScrollerWidget:setWidgetProvider(v)
	self.widgetProvider = v
	do return self end
end

function jk.widget.common.DynamicVerticalScrollerWidget:getWidgetItemAddCount()
	do return self.widgetItemAddCount end
end

function jk.widget.common.DynamicVerticalScrollerWidget:setWidgetItemAddCount(v)
	self.widgetItemAddCount = v
	do return self end
end

jk.widget.common.ActionBarControlWidget = {}

jk.widget.common.NavigationWidget = _g.jk.widget.common.NavigationFrameWidget._create()
jk.widget.common.NavigationWidget.__index = jk.widget.common.NavigationWidget
_vm:set_metatable(jk.widget.common.NavigationWidget, {
	__index = _g.jk.widget.common.NavigationFrameWidget
})

function jk.widget.common.NavigationWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.NavigationWidget)
	return v
end

function jk.widget.common.NavigationWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.NavigationWidget'
	self['_isType.jk.widget.common.NavigationWidget'] = true
	self['_isType.jk.ui.KeyListener'] = true
	self.widgetBackImageResourceName = "backarrow"
	self.widgetStack = nil
	self.contentWidget = nil
end

function jk.widget.common.NavigationWidget:_construct0()
	jk.widget.common.NavigationWidget._init(self)
	do _g.jk.widget.common.NavigationFrameWidget._construct0(self) end
	return self
end

function jk.widget.common.NavigationWidget:switchToContainer(widget, newWidget)
	local ng = nil
	local pp = _g.jk.widget.Widget:getParent(widget)
	while pp ~= nil do
		if (_vm:to_table_with_key(pp, '_isType.jk.widget.common.NavigationWidget') ~= nil) then
			ng = pp
			do break end
		end
		pp = _g.jk.widget.Widget:getParent(pp)
	end
	if not (ng ~= nil) then
		do return false end
	end
	do return ng:switchWidget(newWidget) end
end

function jk.widget.common.NavigationWidget:pushToContainer(widget, newWidget)
	local ng = nil
	local pp = _g.jk.widget.Widget:getParent(widget)
	while pp ~= nil do
		if (_vm:to_table_with_key(pp, '_isType.jk.widget.common.NavigationWidget') ~= nil) then
			ng = pp
			do break end
		end
		pp = _g.jk.widget.Widget:getParent(pp)
	end
	if not (ng ~= nil) then
		do return false end
	end
	do return ng:pushWidget(newWidget) end
end

function jk.widget.common.NavigationWidget:popFromContainer(widget)
	local ng = nil
	local pp = _g.jk.widget.Widget:getParent(widget)
	while pp ~= nil do
		if (_vm:to_table_with_key(pp, '_isType.jk.widget.common.NavigationWidget') ~= nil) then
			ng = pp
			do break end
		end
		pp = _g.jk.widget.Widget:getParent(pp)
	end
	if not (ng ~= nil) then
		do return nil end
	end
	do return ng:popWidget() end
end

function jk.widget.common.NavigationWidget:findNavigationWidget(widget)
	local pp = _g.jk.widget.Widget:getParent(widget)
	while pp ~= nil do
		if (_vm:to_table_with_key(pp, '_isType.jk.widget.common.NavigationWidget') ~= nil) then
			do return pp end
		end
		pp = _g.jk.widget.Widget:getParent(pp)
	end
	do return nil end
end

function jk.widget.common.NavigationWidget:_construct1(ctx)
	jk.widget.common.NavigationWidget._init(self)
	do _g.jk.widget.common.NavigationFrameWidget._construct1(self, ctx) end
	self.widgetStack = _g.jk.lang.Stack._construct0(_g.jk.lang.Stack._create())
	return self
end

function jk.widget.common.NavigationWidget:createMainWidget()
	do return nil end
end

function jk.widget.common.NavigationWidget:initializeWidget()
	do _g.jk.widget.common.NavigationFrameWidget.initializeWidget(self) end
	do
		local main = self.contentWidget
		if not (main ~= nil) then
			main = self:createMainWidget()
		end
		if main ~= nil then
			do self:pushWidget(main) end
		end
	end
end

function jk.widget.common.NavigationWidget:updateMenuButton()
	if not (self.actionBar ~= nil) then
		do return end
	end
	do
		local handler = self:getMenuHandler()
		if self.widgetStack ~= nil and self.widgetStack:getSize() > 1 then
			do self.actionBar:configureLeftButton(self.widgetBackImageResourceName, function()
				do self:popWidget() end
			end) end
		else
			do self:defaultLeftButtonConfiguration() end
		end
	end
end

function jk.widget.common.NavigationWidget:onKeyEvent(event)
	if event:isKeyPress(_g.jk.ui.KeyEvent.KEY_BACK) then
		if self.widgetStack ~= nil and self.widgetStack:getSize() > 1 then
			if self:popWidget() ~= nil then
				do event:consume() end
			end
		end
	end
end

function jk.widget.common.NavigationWidget:setWidgetContent(widget)
	if not (widget ~= nil) then
		do return end
	end
	if self.widgetStack:getSize() > 0 then
		do return end
	end
	if not (self.contentArea ~= nil) then
		self.contentWidget = widget
		do return end
	end
	do self:pushWidget(widget) end
end

function jk.widget.common.NavigationWidget:pushWidget(widget)
	if self.contentArea == nil or widget == nil then
		do return false end
	end
	do self.widgetStack:push(widget) end
	do self.contentArea:addWidget(widget) end
	do self:onCurrentWidgetChanged() end
	do return true end
end

function jk.widget.common.NavigationWidget:switchWidget(widget)
	if not (widget ~= nil) then
		do return false end
	end
	do self:popWidget() end
	do return self:pushWidget(widget) end
end

function jk.widget.common.NavigationWidget:popWidget()
	if not (self.contentArea ~= nil) then
		do return nil end
	end
	do
		local topmost = self.widgetStack:pop()
		if not (topmost ~= nil) then
			do return nil end
		end
		do _g.jk.widget.Widget:removeFromParent(topmost) end
		do self:onCurrentWidgetChanged() end
		do return topmost end
	end
end

function jk.widget.common.NavigationWidget:peekWidget()
	do return self.widgetStack:peek() end
end

function jk.widget.common.NavigationWidget:getWidgetBackImageResourceName()
	do return self.widgetBackImageResourceName end
end

function jk.widget.common.NavigationWidget:setWidgetBackImageResourceName(v)
	self.widgetBackImageResourceName = v
	do return self end
end

jk.widget.common.TextButtonWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.TextButtonWidget.__index = jk.widget.common.TextButtonWidget
_vm:set_metatable(jk.widget.common.TextButtonWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.TextButtonWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.TextButtonWidget)
	return v
end

function jk.widget.common.TextButtonWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.TextButtonWidget'
	self['_isType.jk.widget.common.TextButtonWidget'] = true
	self.widgetContext = nil
	self.widgetClickHandler = nil
	self.widgetText = nil
	self.widgetRoundingRadius = 0.0
	self.widgetBackgroundColor = nil
	self.widgetPressedBackgroundColor = nil
	self.widgetTextColor = nil
	self.widgetFontSize = 0
	self.widgetFontFamily = "Arial"
	self.widgetFontResource = nil
	self.widgetPadding = -1
	self.widgetPaddingHorizontal = -1
end

function jk.widget.common.TextButtonWidget:_construct0()
	jk.widget.common.TextButtonWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.TextButtonWidget:forText(context, text, handler)
	local v = _g.jk.widget.common.TextButtonWidget._construct1(_g.jk.widget.common.TextButtonWidget._create(), context)
	do v:setWidgetText(text) end
	if handler ~= nil then
		do v:setWidgetClickHandler1(handler) end
	end
	do return v end
end

function jk.widget.common.TextButtonWidget:_construct1(ctx)
	jk.widget.common.TextButtonWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, ctx) end
	self.widgetContext = ctx
	do self:setWidgetStyle("TextButtonWidget") end
	return self
end

function jk.widget.common.TextButtonWidget:setWidgetClickHandler1(handler)
	self.widgetClickHandler = handler
	do return self end
end

function jk.widget.common.TextButtonWidget:getWidgetClickHandler()
	do return self.widgetClickHandler end
end

function jk.widget.common.TextButtonWidget:setWidgetStyle(style)
	self.widgetRoundingRadius = self.context:getStylePixels(style, "roundingRadius", nil)
	self.widgetBackgroundColor = self.context:getStyleColor(style, "backgroundColor", nil)
	self.widgetPressedBackgroundColor = self.context:getStyleColor(style, "pressedColor", nil)
	self.widgetTextColor = self.context:getStyleColor(style, "textColor", nil)
	self.widgetFontSize = self.context:getStylePixels(style, "fontSize", nil)
	self.widgetFontFamily = self.context:getStyleString(style, "fontFamily", nil)
	self.widgetFontResource = self.context:getStyleString(style, "fontResource", nil)
	self.widgetPadding = self.context:getStylePixels(style, "padding", nil)
	do return self end
end

function jk.widget.common.TextButtonWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	do
		local bgc = self.widgetBackgroundColor
		if not (bgc ~= nil) then
			bgc = _g.jk.gfx.Color:forRGBDouble(0.6, 0.6, 0.6)
		end
		do
			local canvas = _g.jk.widget.CanvasWidget:forColor(self.context, bgc)
			do canvas:setWidgetRoundingRadius1(self.widgetRoundingRadius) end
			do self:addWidget(canvas) end
			do
				local pbgc = self.widgetPressedBackgroundColor
				if not (pbgc ~= nil) then
					pbgc = self:createDefaultPressColor(bgc)
				end
				do
					local cvn = canvas
					local c1 = bgc
					local c2 = pbgc
					local thisWidget = self
					do _g.jk.widget.Widget:setWidgetPointerHandlers(self, function(x, y)
						do cvn:setWidgetColor(c2) end
					end, nil, function(x, y)
						if self.widgetClickHandler ~= nil and x <= _g.jk.widget.Widget:getWidth(thisWidget) and y <= _g.jk.widget.Widget:getHeight(thisWidget) and x >= 0 and y >= 0 then
							do self.widgetClickHandler() end
						end
						do cvn:setWidgetColor(c1) end
					end) end
					do
						local fgc = self.widgetTextColor
						if not (fgc ~= nil) then
							if bgc:isLightColor() then
								fgc = _g.jk.gfx.Color:forRGB(0, 0, 0)
							else
								fgc = _g.jk.gfx.Color:forRGB(255, 255, 255)
							end
						end
						do
							local padding = self.widgetPadding
							if padding < 0 then
								padding = self.context:getHeightValue("2mm")
							end
							do
								local label = _g.jk.widget.LabelWidget:forText(self.context, self.widgetText)
								do label:setWidgetTextColor(fgc) end
								if self.widgetFontResource ~= nil then
									do label:setWidgetFontResource(self.widgetFontResource) end
								end
								do label:setWidgetFontFamily(self.widgetFontFamily) end
								if self.widgetFontSize > 0 then
									do label:setWidgetFontSize(self.widgetFontSize) end
								end
								do
									local aw = _g.jk.widget.AlignWidget:forWidget(self.context, label, 0.5, 0.5, padding)
									if self.widgetPaddingHorizontal >= 0 then
										do aw:setWidgetMarginLeft(self.widgetPaddingHorizontal) end
										do aw:setWidgetMarginRight(self.widgetPaddingHorizontal) end
									end
									do self:addWidget(aw) end
								end
							end
						end
					end
				end
			end
		end
	end
end

function jk.widget.common.TextButtonWidget:createDefaultPressColor(bg)
	if not (bg ~= nil) then
		do return nil end
	end
	do
		local r = bg:getRedInt() * _util:convert_to_integer(1 - _util:convert_to_integer(0.25))
		local g = bg:getGreenInt() * _util:convert_to_integer(1 - _util:convert_to_integer(0.25))
		local b = bg:getBlueInt() * _util:convert_to_integer(1 - _util:convert_to_integer(0.25))
		do return _g.jk.gfx.Color:forRGB(r, g, b) end
	end
end

function jk.widget.common.TextButtonWidget:getWidgetText()
	do return self.widgetText end
end

function jk.widget.common.TextButtonWidget:setWidgetText(v)
	self.widgetText = v
	do return self end
end

function jk.widget.common.TextButtonWidget:getWidgetRoundingRadius()
	do return self.widgetRoundingRadius end
end

function jk.widget.common.TextButtonWidget:setWidgetRoundingRadius(v)
	self.widgetRoundingRadius = v
	do return self end
end

function jk.widget.common.TextButtonWidget:getWidgetBackgroundColor()
	do return self.widgetBackgroundColor end
end

function jk.widget.common.TextButtonWidget:setWidgetBackgroundColor(v)
	self.widgetBackgroundColor = v
	do return self end
end

function jk.widget.common.TextButtonWidget:getWidgetPressedBackgroundColor()
	do return self.widgetPressedBackgroundColor end
end

function jk.widget.common.TextButtonWidget:setWidgetPressedBackgroundColor(v)
	self.widgetPressedBackgroundColor = v
	do return self end
end

function jk.widget.common.TextButtonWidget:getWidgetTextColor()
	do return self.widgetTextColor end
end

function jk.widget.common.TextButtonWidget:setWidgetTextColor(v)
	self.widgetTextColor = v
	do return self end
end

function jk.widget.common.TextButtonWidget:getWidgetFontSize()
	do return self.widgetFontSize end
end

function jk.widget.common.TextButtonWidget:setWidgetFontSize(v)
	self.widgetFontSize = v
	do return self end
end

function jk.widget.common.TextButtonWidget:getWidgetFontFamily()
	do return self.widgetFontFamily end
end

function jk.widget.common.TextButtonWidget:setWidgetFontFamily(v)
	self.widgetFontFamily = v
	do return self end
end

function jk.widget.common.TextButtonWidget:getWidgetFontResource()
	do return self.widgetFontResource end
end

function jk.widget.common.TextButtonWidget:setWidgetFontResource(v)
	self.widgetFontResource = v
	do return self end
end

function jk.widget.common.TextButtonWidget:getWidgetPadding()
	do return self.widgetPadding end
end

function jk.widget.common.TextButtonWidget:setWidgetPadding(v)
	self.widgetPadding = v
	do return self end
end

function jk.widget.common.TextButtonWidget:getWidgetPaddingHorizontal()
	do return self.widgetPaddingHorizontal end
end

function jk.widget.common.TextButtonWidget:setWidgetPaddingHorizontal(v)
	self.widgetPaddingHorizontal = v
	do return self end
end

jk.widget.common.PopupMenu = {}
jk.widget.common.PopupMenu.__index = jk.widget.common.PopupMenu
_vm:set_metatable(jk.widget.common.PopupMenu, {})

function jk.widget.common.PopupMenu._create()
	local v = _vm:set_metatable({}, jk.widget.common.PopupMenu)
	return v
end

function jk.widget.common.PopupMenu:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.PopupMenu'
	self['_isType.jk.widget.common.PopupMenu'] = true
end

function jk.widget.common.PopupMenu:_construct0()
	jk.widget.common.PopupMenu._init(self)
	return self
end

jk.widget.common.PopupMenu.MyContainerWidget = _g.jk.widget.ContainerWidget._create()
jk.widget.common.PopupMenu.MyContainerWidget.__index = jk.widget.common.PopupMenu.MyContainerWidget
_vm:set_metatable(jk.widget.common.PopupMenu.MyContainerWidget, {
	__index = _g.jk.widget.ContainerWidget
})

function jk.widget.common.PopupMenu.MyContainerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.PopupMenu.MyContainerWidget)
	return v
end

function jk.widget.common.PopupMenu.MyContainerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.PopupMenu.MyContainerWidget'
	self['_isType.jk.widget.common.PopupMenu.MyContainerWidget'] = true
	self.widget = nil
	self.menuWidth = 0
end

function jk.widget.common.PopupMenu.MyContainerWidget:_construct0()
	jk.widget.common.PopupMenu.MyContainerWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct0(self) end
	return self
end

function jk.widget.common.PopupMenu.MyContainerWidget:_construct1(context)
	jk.widget.common.PopupMenu.MyContainerWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.PopupMenu.MyContainerWidget:onWidgetHeightChanged(height)
	local array = _g.jk.widget.Widget:getChildren(self)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local child = array[n + 1]
				if child ~= nil then
					do _g.jk.widget.Widget:move(child, _g.jk.widget.Widget:getAbsoluteX(self.widget), _g.jk.widget.Widget:getAbsoluteY(self.widget)) end
				end
				do n = n + 1 end
			end
		end
	end
end

function jk.widget.common.PopupMenu.MyContainerWidget:computeWidgetLayout(widthConstraint)
	local w = self.menuWidth
	if w == 0 then
		w = widthConstraint
	end
	do
		local array = _g.jk.widget.Widget:getChildren(self)
		if array ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(array)
			do
				n = 0
				while n < m do
					local child = array[n + 1]
					if child ~= nil then
						do _g.jk.widget.Widget:layout(child, w, false) end
						do _g.jk.widget.Widget:move(child, _g.jk.widget.Widget:getAbsoluteX(self.widget), _g.jk.widget.Widget:getAbsoluteY(self.widget)) end
					end
					do n = n + 1 end
				end
			end
		end
		do _g.jk.widget.Widget:setLayoutSize(self, widthConstraint, _g.jk.widget.Widget:getHeight(self)) end
	end
end

function jk.widget.common.PopupMenu.MyContainerWidget:getWidget()
	do return self.widget end
end

function jk.widget.common.PopupMenu.MyContainerWidget:setWidget(v)
	self.widget = v
	do return self end
end

function jk.widget.common.PopupMenu.MyContainerWidget:getMenuWidth()
	do return self.menuWidth end
end

function jk.widget.common.PopupMenu.MyContainerWidget:setMenuWidth(v)
	self.menuWidth = v
	do return self end
end

function jk.widget.common.PopupMenu:showBelow(ctx, w, menu, menuWidth, align)
	if not (w ~= nil) then
		do return end
	end
	if not (menu ~= nil) then
		do return end
	end
	do
		local widget = w
		local context = ctx
		local parentLayer = _g.jk.widget.common.PopupMenu:getParentLayer(context, widget)
		local vbox = _g.jk.widget.common.PopupMenu:initializeMenus(context, menu)
		local container = _g.jk.widget.common.PopupMenu.MyContainerWidget._construct1(_g.jk.widget.common.PopupMenu.MyContainerWidget._create(), context)
		do container:setWidget(widget) end
		do container:setMenuWidth(menuWidth) end
		do container:addWidget(vbox) end
		do parentLayer:addWidget(container) end
		do _g.jk.widget.Widget:setWidgetClickHandler(parentLayer, function()
			local anim = _g.jk.widget.WidgetAnimation:forDuration(context, 300)
			do anim:addFadeOut(container, true) end
			do anim:start() end
		end) end
		do
			local destX = _g.jk.widget.Widget:getAbsoluteX(widget)
			if menuWidth > 0 then
				local mwidth = menuWidth
				if align == 0 then
					if mwidth > 0 then
						destX = destX - (_util:convert_to_integer(mwidth / 2) - _util:convert_to_integer(_g.jk.widget.Widget:getWidth(widget) / 2))
					end
				elseif align > 0 then
					if mwidth > 0 then
						destX = destX - (mwidth - _g.jk.widget.Widget:getWidth(widget))
					end
				else
				end
			end
			do
				local dx = destX
				local animationDestY = _g.jk.widget.Widget:getAbsoluteY(widget)
				local ay = context:getHeightValue("3mm")
				do _g.jk.widget.Widget:move(vbox, destX, animationDestY + ay) end
				do
					local anim = _g.jk.widget.WidgetAnimation:forDuration(context, 300)
					do anim:addCallback(function(completion)
						local bgf = completion * 1.5
						if bgf > 1.0 then
							bgf = 1.0
						end
						do _g.jk.widget.Widget:move(vbox, dx, _util:convert_to_integer(animationDestY + _util:convert_to_integer((1.0 - completion) * ay))) end
					end) end
					do anim:start() end
				end
			end
		end
	end
end

function jk.widget.common.PopupMenu:showBeside(ctx, w, menu)
	if not (w ~= nil) then
		do return end
	end
	if not (menu ~= nil) then
		do return end
	end
	do
		local widget = w
		local context = ctx
		local parentLayer = _g.jk.widget.common.PopupMenu:getParentLayer(context, widget)
		local vbox = _g.jk.widget.common.PopupMenu:initializeMenus(context, menu)
		local container = _g.jk.widget.common.PopupMenu.MyContainerWidget._construct1(_g.jk.widget.common.PopupMenu.MyContainerWidget._create(), context)
		do container:setWidget(widget) end
		do container:addWidget(vbox) end
		do parentLayer:addWidget(container) end
		do _g.jk.widget.Widget:setWidgetClickHandler(parentLayer, function()
			local anim = _g.jk.widget.WidgetAnimation:forDuration(context, 300)
			do anim:addFadeOut(container, true) end
			do anim:start() end
		end) end
		do
			local animationDestY = _g.jk.widget.Widget:getAbsoluteY(widget) - _g.jk.widget.Widget:getHeight(widget)
			local ay = context:getHeightValue("3mm")
			do _g.jk.widget.Widget:move(vbox, _g.jk.widget.Widget:getAbsoluteX(widget), animationDestY + ay) end
			do
				local anim = _g.jk.widget.WidgetAnimation:forDuration(context, 300)
				do anim:addCallback(function(completion)
					local bgf = completion * 1.5
					if bgf > 1.0 then
						bgf = 1.0
					end
					do _g.jk.widget.Widget:move(vbox, _g.jk.widget.Widget:getAbsoluteX(widget) + _g.jk.widget.Widget:getWidth(widget), _util:convert_to_integer(animationDestY + _util:convert_to_integer((1.0 - completion) * ay))) end
				end) end
				do anim:start() end
			end
		end
	end
end

function jk.widget.common.PopupMenu:getParentLayer(context, widget)
	local parentLayer = nil
	local parent = widget
	while parent ~= nil do
		if (_vm:to_table_with_key(parent, '_isType.jk.widget.LayerWidget') ~= nil) then
			parentLayer = parent
		end
		parent = _g.jk.widget.Widget:getParent(parent)
	end
	if not (parentLayer ~= nil) then
		_io:write_to_stdout("[jk.widget.common.PopupMenu.getParentLayer] (PopupMenu.sling:191:4): No LayerWidget was found in the widget tree. Cannot show popup!" .. "\n")
		do return nil end
	end
	do return parentLayer end
end

function jk.widget.common.PopupMenu:initializeMenus(context, menu)
	local textColor = context:getStyleColor("PopupMenu", "textColor", nil)
	if not (textColor ~= nil) then
		textColor = _g.jk.gfx.Color:black()
	end
	do
		local backgroundColor = context:getStyleColor("PopupMenu", "backgroundColor", nil)
		if not (backgroundColor ~= nil) then
			backgroundColor = _g.jk.gfx.Color:white()
		end
		do
			local padding = context:getStylePixels("PopupMenu", "padding", nil)
			if padding < 1 then
				padding = context:getHeightValue("1000um")
			end
			do
				local fontSize = context:getStylePixels("PopupMenu", "fontSize", nil)
				if fontSize < 1 then
					fontSize = context:getHeightValue("2mm")
				end
				do
					local vbox = _g.jk.widget.VerticalBoxWidget:forContext(context, 0, 0)
					local array = menu:getEntries()
					if array ~= nil then
						local n = 0
						local m = _g.jk.lang.Vector:getSize(array)
						do
							n = 0
							while n < m do
								local entry = array[n + 1]
								if entry ~= nil then
									local lbl = _g.jk.widget.LabelWidget:forText(context, entry.title)
									do lbl:setWidgetTextColor(textColor) end
									do
										local layer = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), context)
										do layer:addWidget(_g.jk.widget.CanvasWidget:forColor(context, backgroundColor)) end
										do layer:addWidget(_g.jk.widget.LayerWidget:forWidget(context, lbl, padding)) end
										do _g.jk.widget.Widget:setWidgetClickHandler(layer, entry.handler) end
										do vbox:addWidget(layer) end
									end
								end
								do n = n + 1 end
							end
						end
					end
					do return vbox end
				end
			end
		end
	end
end

jk.widget.common.RangePickerWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.RangePickerWidget.__index = jk.widget.common.RangePickerWidget
_vm:set_metatable(jk.widget.common.RangePickerWidget, {
	__index = _g.jk.widget.LayerWidget
})

jk.widget.common.RangePickerWidget.LEFT_CONTROL = 0
jk.widget.common.RangePickerWidget.RIGHT_CONTROL = 1

function jk.widget.common.RangePickerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.RangePickerWidget)
	return v
end

function jk.widget.common.RangePickerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.RangePickerWidget'
	self['_isType.jk.widget.common.RangePickerWidget'] = true
	self['_isType.jk.widget.ResizeAwareWidget'] = true
	self['_isType.jk.widget.WidgetWithValue'] = true
	self.widgetMaximumValue = 100
	self.widgetLeftControlChangeListener = nil
	self.widgetRightControlChangeListener = nil
	self.widgetDisableLeftControl = false
	self.selectedControl = nil
	self.refX = 0.0
	self.firstLayoutDone = false
	self.rangeValue = 0
	self.leftValue = -1.0
	self.rightValue = -1.0
	self.con = nil
	self.background = nil
	self.range = nil
	self.outOfRangeColor = nil
	self.insideOfRangeColor = nil
	self.leftControl = nil
	self.rightControl = nil
end

function jk.widget.common.RangePickerWidget:_construct0()
	jk.widget.common.RangePickerWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

jk.widget.common.RangePickerWidget.RangeControlWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.RangePickerWidget.RangeControlWidget.__index = jk.widget.common.RangePickerWidget.RangeControlWidget
_vm:set_metatable(jk.widget.common.RangePickerWidget.RangeControlWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.RangePickerWidget.RangeControlWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.RangePickerWidget.RangeControlWidget)
	return v
end

function jk.widget.common.RangePickerWidget.RangeControlWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.RangePickerWidget.RangeControlWidget'
	self['_isType.jk.widget.common.RangePickerWidget.RangeControlWidget'] = true
	self.outline = nil
	self.main = nil
end

function jk.widget.common.RangePickerWidget.RangeControlWidget:_construct0()
	jk.widget.common.RangePickerWidget.RangeControlWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.RangePickerWidget.RangeControlWidget:_construct1(context)
	jk.widget.common.RangePickerWidget.RangeControlWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.RangePickerWidget.RangeControlWidget:setWidgetColor(color)
	do self.main:setWidgetColor(color) end
end

function jk.widget.common.RangePickerWidget.RangeControlWidget:setWidgetRoundingRadius(radius)
	do self.outline:setWidgetRoundingRadius1(radius) end
	do self.main:setWidgetRoundingRadius1(radius) end
end

function jk.widget.common.RangePickerWidget.RangeControlWidget:createWidget()
	do _g.jk.widget.LayerWidget.createWidget(self) end
	do
		local thisWidget = self
		do self:setWidgetWidthRequest(self.context:getHeightValue("4mm")) end
		do self:setWidgetHeightRequest(self.context:getHeightValue("4mm")) end
		self.outline = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
		do self.outline:setWidgetColor(_g.jk.gfx.Color:instance("#C0C0C0")) end
		do self.outline:setWidgetRoundingRadius1(self.context:getHeightValue("800um")) end
		do self:addWidget(self.outline) end
		do
			local widget = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
			do widget:setWidgetMargin(self.context:getHeightValue("10um")) end
			self.main = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
			do self.main:setWidgetColor(_g.jk.gfx.Color:instance("#ffffff")) end
			do self.main:setWidgetRoundingRadius1(self.context:getHeightValue("800um")) end
			do widget:addWidget(self.main) end
			do self:addWidget(widget) end
		end
	end
end

jk.widget.common.RangePickerWidget.SelectedControl = {}
jk.widget.common.RangePickerWidget.SelectedControl.__index = jk.widget.common.RangePickerWidget.SelectedControl
_vm:set_metatable(jk.widget.common.RangePickerWidget.SelectedControl, {})

function jk.widget.common.RangePickerWidget.SelectedControl._create()
	local v = _vm:set_metatable({}, jk.widget.common.RangePickerWidget.SelectedControl)
	return v
end

function jk.widget.common.RangePickerWidget.SelectedControl:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.RangePickerWidget.SelectedControl'
	self['_isType.jk.widget.common.RangePickerWidget.SelectedControl'] = true
	self.widget = nil
	self.control = 0
end

function jk.widget.common.RangePickerWidget.SelectedControl:_construct0()
	jk.widget.common.RangePickerWidget.SelectedControl._init(self)
	return self
end

function jk.widget.common.RangePickerWidget:_construct1(ctx)
	jk.widget.common.RangePickerWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, ctx) end
	do self:forceCreateWidget() end
	return self
end

function jk.widget.common.RangePickerWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	if self.widgetDisableLeftControl then
		do _g.jk.widget.Widget:removeFromParent(self.leftControl) end
	end
	do _g.jk.widget.Widget:setWidgetPointerHandlers(self.con, function(x, y)
		do self:onStartHandler(x, y) end
	end, function(x, y)
		do self:onTouchHandler(x, y) end
	end, function(x, y)
		do self:onEndHandler(x, y) end
	end) end
end

function jk.widget.common.RangePickerWidget:isInside(x, y, widget)
	local wx = _g.jk.widget.Widget:getX(widget)
	local wy = _g.jk.widget.Widget:getY(widget)
	do return x >= wx and y >= wy and x <= wx + _g.jk.widget.Widget:getWidth(widget) and y <= wy + _g.jk.widget.Widget:getHeight(widget) end
end

function jk.widget.common.RangePickerWidget:onStartHandler(x, y)
	do self:resetSelectedControl() end
	if self:isInside(x, y, self.leftControl) then
		self.selectedControl.widget = self.leftControl
		self.selectedControl.control = _g.jk.widget.common.RangePickerWidget.LEFT_CONTROL
		self.refX = x
	elseif self:isInside(x, y, self.rightControl) then
		self.selectedControl.widget = self.rightControl
		self.selectedControl.control = _g.jk.widget.common.RangePickerWidget.RIGHT_CONTROL
		self.refX = x
	end
end

function jk.widget.common.RangePickerWidget:onTouchHandler(x, y)
	if not (self.selectedControl ~= nil) then
		do return end
	end
	do
		local dx = _g.jk.widget.Widget:getX(self.selectedControl.widget) + _util:convert_to_integer(x - self.refX)
		do self:moveControl(dx, self.selectedControl.control) end
		self.refX = x
	end
end

function jk.widget.common.RangePickerWidget:onEndHandler(x, y)
	do self:resetSelectedControl() end
end

function jk.widget.common.RangePickerWidget:calculateValueForX(x)
	local y = x / self.rangeValue
	do return _g.jk.math.Math:round(y * self.widgetMaximumValue * 100) / 100 end
end

function jk.widget.common.RangePickerWidget:calculateXForValue(value)
	local x = value / self.widgetMaximumValue
	do return x * self.rangeValue end
end

function jk.widget.common.RangePickerWidget:updateInsideOfRangeCanvas()
	local x = _g.jk.widget.Widget:getX(self.leftControl) + _util:convert_to_integer(_g.jk.widget.Widget:getWidth(self.leftControl) / 2)
	local width = _g.jk.widget.Widget:getX(self.rightControl) + _util:convert_to_integer(_g.jk.widget.Widget:getWidth(self.rightControl) / 2) - x
	do _g.jk.widget.Widget:setLayoutSize(self.insideOfRangeColor, width, _g.jk.widget.Widget:getHeight(self.insideOfRangeColor)) end
	do _g.jk.widget.Widget:move(self.insideOfRangeColor, x, _g.jk.widget.Widget:getY(self.insideOfRangeColor)) end
end

function jk.widget.common.RangePickerWidget:resetSelectedControl()
	if not (self.selectedControl ~= nil) then
		self.selectedControl = _g.jk.widget.common.RangePickerWidget.SelectedControl._construct0(_g.jk.widget.common.RangePickerWidget.SelectedControl._create())
	end
	self.selectedControl.widget = nil
	self.selectedControl.control = -1
end

function jk.widget.common.RangePickerWidget:moveLeftControlTo(value)
	do self:moveControl(self:calculateXForValue(value), _g.jk.widget.common.RangePickerWidget.LEFT_CONTROL) end
end

function jk.widget.common.RangePickerWidget:moveRightControlTo(value)
	do self:moveControl(self:calculateXForValue(value), _g.jk.widget.common.RangePickerWidget.RIGHT_CONTROL) end
end

function jk.widget.common.RangePickerWidget:moveControl(value, control)
	if not (control == _g.jk.widget.common.RangePickerWidget.LEFT_CONTROL or control == _g.jk.widget.common.RangePickerWidget.RIGHT_CONTROL) then
		do return end
	end
	do self:resetSelectedControl() end
	self.selectedControl.control = control
	do
		local x = value
		if control == _g.jk.widget.common.RangePickerWidget.LEFT_CONTROL then
			self.selectedControl.widget = self.leftControl
			do
				local rx = _g.jk.widget.Widget:getX(self.rightControl)
				x = (function(a, b, c)
					if a then
						do return b() end
					end
					do return c() end
				end)(x < 0, function()
					do return 0.0 end
				end, function()
					do return x end
				end)
				x = (function(a, b, c)
					if a then
						do return b() end
					end
					do return c() end
				end)(x > rx, function()
					do return rx end
				end, function()
					do return x end
				end)
				if self.widgetLeftControlChangeListener ~= nil then
					self.leftValue = self:calculateValueForX(x)
					do self.widgetLeftControlChangeListener(self.leftValue) end
				end
			end
		elseif control == _g.jk.widget.common.RangePickerWidget.RIGHT_CONTROL then
			self.selectedControl.widget = self.rightControl
			do
				local mx = self.rangeValue
				local lx = _g.jk.widget.Widget:getX(self.leftControl)
				x = (function(a, b, c)
					if a then
						do return b() end
					end
					do return c() end
				end)(x > mx, function()
					do return mx end
				end, function()
					do return x end
				end)
				x = (function(a, b, c)
					if a then
						do return b() end
					end
					do return c() end
				end)(x < lx, function()
					do return lx end
				end, function()
					do return x end
				end)
				if self.widgetRightControlChangeListener ~= nil then
					self.rightValue = self:calculateValueForX(x)
					do self.widgetRightControlChangeListener(self.rightValue) end
				end
			end
		end
		do _g.jk.widget.Widget:move(self.selectedControl.widget, _util:convert_to_integer(x), _g.jk.widget.Widget:getY(self.selectedControl.widget)) end
		do self:updateInsideOfRangeCanvas() end
	end
end

function jk.widget.common.RangePickerWidget:setWidgetStyle(style)
	do self:setWidgetControlColor(self.context:getStyleColor(style, "controlColor", nil)) end
	do self:setWidgetBackgroundColor(self.context:getStyleColor(style, "backgroundColor", nil)) end
	do self:setWidgetOutOfRangeColor(self.context:getStyleColor(style, "outOfRangeColor", nil)) end
	do self:setWidgetInsideOfRangeColor(self.context:getStyleColor(style, "insideOfRangeColor", nil)) end
	do return self end
end

function jk.widget.common.RangePickerWidget:setWidgetBackgroundColor(color)
	do self.background:setWidgetColor(color) end
end

function jk.widget.common.RangePickerWidget:setWidgetOutOfRangeColor(color)
	do self.outOfRangeColor:setWidgetColor(color) end
end

function jk.widget.common.RangePickerWidget:setWidgetInsideOfRangeColor(color)
	do self.insideOfRangeColor:setWidgetColor(color) end
end

function jk.widget.common.RangePickerWidget:setWidgetControlColor(color)
	do self.leftControl:setWidgetColor(color) end
	do self.rightControl:setWidgetColor(color) end
end

function jk.widget.common.RangePickerWidget:setWidgetRoundingRadius(radius)
	do self.leftControl:setWidgetRoundingRadius(radius) end
	do self.rightControl:setWidgetRoundingRadius(radius) end
end

function jk.widget.common.RangePickerWidget:onWidgetResized()
	self.rangeValue = _g.jk.widget.Widget:getWidth(self.range) - _g.jk.widget.Widget:getWidth(self.rightControl)
	if not self.firstLayoutDone then
		self.firstLayoutDone = true
	end
	if self.leftValue < 0 or self.rightValue < 0 then
		do return end
	end
	if not self.widgetDisableLeftControl then
		do self:moveLeftControlTo(self.leftValue) end
	end
	do self:moveRightControlTo(self.rightValue) end
end

function jk.widget.common.RangePickerWidget:setWidgetValue(value)
	if not (value ~= nil) then
		do return end
	end
	if not (_vm:get_variable_type(value) == 'string') then
		do return end
	end
	do
		local v = _g.jk.lang.String:split(value, 45, 2)
		if not self.firstLayoutDone then
			self.leftValue = _g.jk.lang.String:toDouble(v[0 + 1])
			self.rightValue = _g.jk.lang.String:toDouble(v[1 + 1])
		else
			if not self.widgetDisableLeftControl then
				do self:moveLeftControlTo(_g.jk.lang.String:toDouble(v[0 + 1])) end
			end
			do self:moveRightControlTo(_g.jk.lang.String:toDouble(v[1 + 1])) end
		end
	end
end

function jk.widget.common.RangePickerWidget:setWidgetValueForDynamicMap(value)
	if not (value ~= nil) then
		do return end
	end
	do self:moveLeftControlTo(value:getDouble("from", 0.0)) end
	do self:moveRightControlTo(value:getDouble("to", 0.0)) end
end

function jk.widget.common.RangePickerWidget:setWidgetFromValue(fvalue)
	do self:moveLeftControlTo(fvalue) end
end

function jk.widget.common.RangePickerWidget:setWidgetToValue(tvalue)
	do self:moveRightControlTo(tvalue) end
end

function jk.widget.common.RangePickerWidget:getWidgetValue()
	do return _g.jk.lang.String:safeString(_g.jk.lang.String:forDouble(self.leftValue)) .. "-" .. _g.jk.lang.String:safeString(_g.jk.lang.String:forDouble(self.rightValue)) end
end

function jk.widget.common.RangePickerWidget:getWidgetValueAsDynamicMap()
	local v = _g.jk.lang.DynamicMap._construct0(_g.jk.lang.DynamicMap._create())
	do v:setDouble("from", self.leftValue) end
	do v:setDouble("to", self.rightValue) end
	do return v end
end

function jk.widget.common.RangePickerWidget:getWidgetFromValue()
	do return self.leftValue end
end

function jk.widget.common.RangePickerWidget:getWidgetToValue()
	do return self.rightValue end
end

function jk.widget.common.RangePickerWidget:createWidget()
	do _g.jk.widget.LayerWidget.createWidget(self) end
	do
		local thisWidget = self
		do self:setWidgetHeightRequest(self.context:getHeightValue("4mm")) end
		self.con = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
		self.background = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
		do self.con:addWidget(self.background) end
		do
			local widget = _g.jk.widget.AlignWidget._construct1(_g.jk.widget.AlignWidget._create(), self.context)
			self.range = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
			do self.range:setWidgetMarginLeft(self.context:getHeightValue("2mm")) end
			do self.range:setWidgetMarginRight(self.context:getHeightValue("2mm")) end
			do self.range:setWidgetHeightRequest(self.context:getHeightValue("1mm")) end
			self.outOfRangeColor = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
			do self.outOfRangeColor:setWidgetColor(_g.jk.gfx.Color:instance("#A9A9A9")) end
			do self.range:addWidget(self.outOfRangeColor) end
			self.insideOfRangeColor = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
			do self.insideOfRangeColor:setWidgetColor(_g.jk.gfx.Color:instance("#FF8C00")) end
			do self.range:addWidget(self.insideOfRangeColor) end
			do widget:addWidget1(self.range, 0.5, 0.5, true) end
			self.leftControl = _g.jk.widget.common.RangePickerWidget.RangeControlWidget._construct1(_g.jk.widget.common.RangePickerWidget.RangeControlWidget._create(), self.context)
			do widget:addWidget1(self.leftControl, 0.0, 0.5, false) end
			self.rightControl = _g.jk.widget.common.RangePickerWidget.RangeControlWidget._construct1(_g.jk.widget.common.RangePickerWidget.RangeControlWidget._create(), self.context)
			do widget:addWidget1(self.rightControl, 1.0, 0.5, false) end
			do self.con:addWidget(widget) end
			do self:addWidget(self.con) end
		end
	end
end

function jk.widget.common.RangePickerWidget:getWidgetMaximumValue()
	do return self.widgetMaximumValue end
end

function jk.widget.common.RangePickerWidget:setWidgetMaximumValue(v)
	self.widgetMaximumValue = v
	do return self end
end

function jk.widget.common.RangePickerWidget:getWidgetLeftControlChangeListener()
	do return self.widgetLeftControlChangeListener end
end

function jk.widget.common.RangePickerWidget:setWidgetLeftControlChangeListener(v)
	self.widgetLeftControlChangeListener = v
	do return self end
end

function jk.widget.common.RangePickerWidget:getWidgetRightControlChangeListener()
	do return self.widgetRightControlChangeListener end
end

function jk.widget.common.RangePickerWidget:setWidgetRightControlChangeListener(v)
	self.widgetRightControlChangeListener = v
	do return self end
end

function jk.widget.common.RangePickerWidget:getWidgetDisableLeftControl()
	do return self.widgetDisableLeftControl end
end

function jk.widget.common.RangePickerWidget:setWidgetDisableLeftControl(v)
	self.widgetDisableLeftControl = v
	do return self end
end

jk.widget.common.SpinnerWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.SpinnerWidget.__index = jk.widget.common.SpinnerWidget
_vm:set_metatable(jk.widget.common.SpinnerWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.SpinnerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.SpinnerWidget)
	return v
end

function jk.widget.common.SpinnerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.SpinnerWidget'
	self['_isType.jk.widget.common.SpinnerWidget'] = true
	self['_isType.jk.widget.ScreenAwareWidget'] = true
	self.image = nil
	self.rotation = 0.0
	self.active = false
	self.imageWidget = nil
end

function jk.widget.common.SpinnerWidget:_construct0()
	jk.widget.common.SpinnerWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.SpinnerWidget:_construct1(context)
	jk.widget.common.SpinnerWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.SpinnerWidget:forImage(ctx, image)
	local v = _g.jk.widget.common.SpinnerWidget._construct1(_g.jk.widget.common.SpinnerWidget._create(), ctx)
	do v:setImage(image) end
	do return v end
end

function jk.widget.common.SpinnerWidget:onWidgetRemovedFromScreen(screen)
	self.active = false
end

function jk.widget.common.SpinnerWidget:onWidgetAddedToScreen(screen)
	do self.imageWidget:setWidgetImage(self.image) end
	self.active = true
	do self:doSpin() end
end

function jk.widget.common.SpinnerWidget:doSpin()
	if not self.active then
		do return end
	end
	do _g.jk.widget.Widget:setRotation(self.imageWidget, self.rotation) end
	self.rotation = self.rotation + _g.jk.math.Math.M_PI / 50.0
	do self.context:startTimer(100, function()
		do self:doSpin() end
	end) end
end

function jk.widget.common.SpinnerWidget:createWidget()
	do _g.jk.widget.LayerWidget.createWidget(self) end
	do
		local thisWidget = self
		self.imageWidget = _g.jk.widget.ImageWidget._construct1(_g.jk.widget.ImageWidget._create(), self.context)
		do self.imageWidget:setWidgetImageWidth(self.context:getWidthValue("15mm")) end
		do self.imageWidget:setWidgetImageHeight(self.context:getHeightValue("15mm")) end
		do self:addWidget(self.imageWidget) end
	end
end

function jk.widget.common.SpinnerWidget:getImage()
	do return self.image end
end

function jk.widget.common.SpinnerWidget:setImage(v)
	self.image = v
	do return self end
end

jk.widget.common.TextAreaWidget = _g.jk.widget.Widget._create()
jk.widget.common.TextAreaWidget.__index = jk.widget.common.TextAreaWidget
_vm:set_metatable(jk.widget.common.TextAreaWidget, {
	__index = _g.jk.widget.Widget
})

function jk.widget.common.TextAreaWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.TextAreaWidget)
	return v
end

function jk.widget.common.TextAreaWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.TextAreaWidget'
	self['_isType.jk.widget.common.TextAreaWidget'] = true
	self['_isType.jk.widget.WidgetWithValue'] = true
	self.widgetTextChangeHandler = nil
	self.widgetOnFocusHandler = nil
	self.widgetOnLoseFocusHandler = nil
	self.widgetOnEnterKeyPressed = nil
	self.widgetContext = nil
	self.widgetPlaceholder = nil
	self.widgetPaddingLeft = 0
	self.widgetPaddingTop = 0
	self.widgetPaddingRight = 0
	self.widgetPaddingBottom = 0
	self.widgetRows = 0
	self.widgetTextColor = nil
	self.widgetBackgroundColor = nil
	self.widgetFontFamily = nil
	self.widgetFontResource = nil
	self.widgetFontSize = 0.0
end

function jk.widget.common.TextAreaWidget:_construct0()
	jk.widget.common.TextAreaWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	return self
end

function jk.widget.common.TextAreaWidget:forPlaceholder(context, placeholder, rows)
	local v = _g.jk.widget.common.TextAreaWidget._construct1(_g.jk.widget.common.TextAreaWidget._create(), context)
	do v:setWidgetPlaceholder(placeholder) end
	do v:setWidgetRows(rows) end
	do return v end
end

function jk.widget.common.TextAreaWidget:_construct1(context)
	jk.widget.common.TextAreaWidget._init(self)
	do _g.jk.widget.Widget._construct0(self) end
	self.widgetContext = context
	do self:setWidgetStyle("TextAreaWidget") end
	return self
end

function jk.widget.common.TextAreaWidget:setWidgetStyle(style)
	self.widgetFontFamily = self.widgetContext:getStyleString(style, "fontFamily", nil)
	if _g.jk.lang.String:isEmpty(self.widgetFontFamily) then
		self.widgetFontFamily = "Arial"
	end
	self.widgetFontSize = self.widgetContext:getStylePixels(style, "fontSize", nil)
	if self.widgetFontSize < 1.0 then
		self.widgetFontSize = self.widgetContext:getHeightValue("3mm")
	end
	self.widgetTextColor = self.widgetContext:getStyleColor(style, "textColor", nil)
	self.widgetBackgroundColor = self.widgetContext:getStyleColor(style, "backgroundColor", nil)
	do self:setWidgetPadding1(self.widgetContext:getStylePixels(style, "padding", nil)) end
	do self:updateWidgetFont() end
	do self:updateWidgetColors() end
	do return self end
end

function jk.widget.common.TextAreaWidget:configureMonospaceFont()
	do self:setWidgetFontFamily("monospace") end
end

function jk.widget.common.TextAreaWidget:updateWidgetColors()
	local textColor = self.widgetTextColor
	if not (textColor ~= nil) then
		if self.widgetBackgroundColor ~= nil then
			if self.widgetBackgroundColor:isLightColor() then
				textColor = _g.jk.gfx.Color:black()
			else
				textColor = _g.jk.gfx.Color:white()
			end
		else
			textColor = _g.jk.gfx.Color:black()
		end
	end
end

function jk.widget.common.TextAreaWidget:updateWidgetFont()
	_io:write_to_stdout("[jk.widget.common.TextAreaWidget.updateWidgetFont] (TextAreaWidget.sling:543:3): Not implemented" .. "\n")
end

function jk.widget.common.TextAreaWidget:focus1()
	_io:write_to_stdout("[jk.widget.common.TextAreaWidget.focus] (TextAreaWidget.sling:560:3): Not implemented" .. "\n")
end

function jk.widget.common.TextAreaWidget:setWidgetFontFamily(family)
	self.widgetFontFamily = family
	do self:updateWidgetFont() end
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.TextAreaWidget:setWidgetFontResource(res)
	self.widgetFontResource = res
	do self:updateWidgetFont() end
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.TextAreaWidget:setWidgetFontSize(fontSize)
	self.widgetFontSize = fontSize
	do self:updateWidgetFont() end
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.TextAreaWidget:setWidgetTextColor(color)
	self.widgetTextColor = color
	do self:updateWidgetColors() end
	do return self end
end

function jk.widget.common.TextAreaWidget:getWidgetTextColor()
	do return self.widgetTextColor end
end

function jk.widget.common.TextAreaWidget:setWidgetBackgroundColor(color)
	self.widgetBackgroundColor = color
	do self:updateWidgetColors() end
	do return self end
end

function jk.widget.common.TextAreaWidget:getWidgetBackgroundColor()
	do return self.widgetBackgroundColor end
end

function jk.widget.common.TextAreaWidget:setWidgetRows(row)
	self.widgetRows = row
	_io:write_to_stdout("[jk.widget.common.TextAreaWidget.setWidgetRows] (TextAreaWidget.sling:630:3): Not implemented" .. "\n")
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.TextAreaWidget:setWidgetText(text)
	_io:write_to_stdout("[jk.widget.common.TextAreaWidget.setWidgetText] (TextAreaWidget.sling:666:3): Not implemented" .. "\n")
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.TextAreaWidget:onEnterKeyListener()
	if self.widgetOnEnterKeyPressed ~= nil then
		do self.widgetOnEnterKeyPressed() end
	end
end

function jk.widget.common.TextAreaWidget:setWidgetPlaceholder(placeholder)
	self.widgetPlaceholder = placeholder
	_io:write_to_stdout("[jk.widget.common.TextAreaWidget.setWidgetPlaceholder] (TextAreaWidget.sling:702:3): Not implemented" .. "\n")
	do _g.jk.widget.Widget:onLayoutChanged(self) end
	do return self end
end

function jk.widget.common.TextAreaWidget:setWidgetPadding1(padding)
	do return self:setWidgetPadding3(padding, padding, padding, padding) end
end

function jk.widget.common.TextAreaWidget:setWidgetPadding2(lr, tb)
	do return self:setWidgetPadding3(lr, tb, lr, tb) end
end

function jk.widget.common.TextAreaWidget:setWidgetPadding3(l, t, r, b)
	if l < 0 or t < 0 or r < 0 or b < 0 then
		do return self end
	end
	if self.widgetPaddingLeft == l and self.widgetPaddingTop == t and self.widgetPaddingRight == r and self.widgetPaddingBottom == b then
		do return self end
	end
	self.widgetPaddingLeft = l
	self.widgetPaddingTop = t
	self.widgetPaddingRight = r
	self.widgetPaddingBottom = b
	do self:updateWidgetPadding() end
	do return self end
end

function jk.widget.common.TextAreaWidget:updateWidgetPadding()
	_io:write_to_stdout("[jk.widget.common.TextAreaWidget.updateWidgetPadding] (TextAreaWidget.sling:752:3): Not implemented" .. "\n")
end

function jk.widget.common.TextAreaWidget:getWidgetText()
	_io:write_to_stdout("[jk.widget.common.TextAreaWidget.getWidgetText] (TextAreaWidget.sling:778:3): Not implemented" .. "\n")
	do return nil end
end

function jk.widget.common.TextAreaWidget:getWidgetPlaceholder()
	do return self.widgetPlaceholder end
end

function jk.widget.common.TextAreaWidget:setWidgetValue(value)
	do self:setWidgetText(_g.jk.lang.String:asString(value)) end
end

function jk.widget.common.TextAreaWidget:getWidgetValue()
	do return self:getWidgetText() end
end

function jk.widget.common.TextAreaWidget:onChangeListener()
	if self.widgetTextChangeHandler ~= nil then
		do self.widgetTextChangeHandler() end
	end
end

function jk.widget.common.TextAreaWidget:onFocusListener()
	if self.widgetOnFocusHandler ~= nil then
		do self.widgetOnFocusHandler() end
	end
end

function jk.widget.common.TextAreaWidget:onLoseFocusListener()
	if self.widgetOnLoseFocusHandler ~= nil then
		do self.widgetOnLoseFocusHandler() end
	end
end

function jk.widget.common.TextAreaWidget:setWidgetMaxLength(v)
	_io:write_to_stdout("[jk.widget.common.TextAreaWidget.setWidgetMaxLength] (TextAreaWidget.sling:831:3): Not implemented" .. "\n")
	do return self end
end

function jk.widget.common.TextAreaWidget:getWidgetTextChangeHandler()
	do return self.widgetTextChangeHandler end
end

function jk.widget.common.TextAreaWidget:setWidgetTextChangeHandler(v)
	self.widgetTextChangeHandler = v
	do return self end
end

function jk.widget.common.TextAreaWidget:getWidgetOnFocusHandler()
	do return self.widgetOnFocusHandler end
end

function jk.widget.common.TextAreaWidget:setWidgetOnFocusHandler(v)
	self.widgetOnFocusHandler = v
	do return self end
end

function jk.widget.common.TextAreaWidget:getWidgetOnLoseFocusHandler()
	do return self.widgetOnLoseFocusHandler end
end

function jk.widget.common.TextAreaWidget:setWidgetOnLoseFocusHandler(v)
	self.widgetOnLoseFocusHandler = v
	do return self end
end

function jk.widget.common.TextAreaWidget:getWidgetOnEnterKeyPressed()
	do return self.widgetOnEnterKeyPressed end
end

function jk.widget.common.TextAreaWidget:setWidgetOnEnterKeyPressed(v)
	self.widgetOnEnterKeyPressed = v
	do return self end
end

jk.widget.common.RadioButtonWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.RadioButtonWidget.__index = jk.widget.common.RadioButtonWidget
_vm:set_metatable(jk.widget.common.RadioButtonWidget, {
	__index = _g.jk.widget.LayerWidget
})

jk.widget.common.RadioButtonWidget.HORIZONTAL = 0
jk.widget.common.RadioButtonWidget.VERTICAL = 1

function jk.widget.common.RadioButtonWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.RadioButtonWidget)
	return v
end

function jk.widget.common.RadioButtonWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.RadioButtonWidget'
	self['_isType.jk.widget.common.RadioButtonWidget'] = true
	self['_isType.jk.widget.WidgetWithValue'] = true
	self.selectedWidgetIndex = -1
	self.vrb = nil
	self.widgetItems = nil
	self.widgetFontSize = 0
	self.widgetFontResource = nil
	self.widgetFontFamily = nil
	self.widgetTextColor = nil
	self.widgetFontBold = false
	self.widgetOnSelectedColor = nil
	self.widgetOutlineColor = nil
	self.widgetOrientation = _g.jk.widget.common.RadioButtonWidget.VERTICAL
	self.widgetClickHandler = nil
end

function jk.widget.common.RadioButtonWidget:_construct0()
	jk.widget.common.RadioButtonWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.RadioButtonWidget:_construct1(context)
	jk.widget.common.RadioButtonWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

jk.widget.common.RadioButtonWidget.MyRadioButtonWidget = _g.jk.widget.HorizontalBoxWidget._create()
jk.widget.common.RadioButtonWidget.MyRadioButtonWidget.__index = jk.widget.common.RadioButtonWidget.MyRadioButtonWidget
_vm:set_metatable(jk.widget.common.RadioButtonWidget.MyRadioButtonWidget, {
	__index = _g.jk.widget.HorizontalBoxWidget
})

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.RadioButtonWidget.MyRadioButtonWidget)
	return v
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.RadioButtonWidget.MyRadioButtonWidget'
	self['_isType.jk.widget.common.RadioButtonWidget.MyRadioButtonWidget'] = true
	self.widgetIndex = 0
	self.widgetContainer = nil
	self.widgetColor = nil
	self.widgetOutLineColor = nil
	self.widgetText = nil
	self.widgetFontSize = 0
	self.widgetFontResource = nil
	self.widgetFontFamily = nil
	self.widgetFontBold = false
	self.widgetTextColor = nil
	self.enabled = true
	self.radio = nil
	self.outline = nil
	self.canvas = nil
	self.label = nil
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:_construct0()
	jk.widget.common.RadioButtonWidget.MyRadioButtonWidget._init(self)
	do _g.jk.widget.HorizontalBoxWidget._construct0(self) end
	return self
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:_construct1(context)
	jk.widget.common.RadioButtonWidget.MyRadioButtonWidget._init(self)
	do _g.jk.widget.HorizontalBoxWidget._construct1(self, context) end
	return self
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:initializeWidget()
	do _g.jk.widget.HorizontalBoxWidget.initializeWidget(self) end
	do self.label:setWidgetText(self.widgetText) end
	do self.label:setWidgetFontSize(self.widgetFontSize) end
	if self.widgetFontResource ~= nil then
		do self.label:setWidgetFontResource(self.widgetFontResource) end
	end
	if self.widgetFontFamily ~= nil then
		do self.label:setWidgetFontFamily(self.widgetFontFamily) end
	end
	if self.widgetFontBold then
		do self.label:setWidgetFontBold(true) end
	end
	if self.widgetTextColor ~= nil then
		do self.label:setWidgetTextColor(self.widgetTextColor) end
	end
	if not (self.widgetOutLineColor ~= nil) then
		self.widgetOutLineColor = _g.jk.gfx.Color:black()
	end
	do self.outline:setWidgetColor(self.widgetOutLineColor) end
	do self.outline:setWidgetRoundingRadius1(self.context:getHeightValue("2000um")) end
	do self.canvas:setWidgetColor(_g.jk.gfx.Color:white()) end
	do self.canvas:setWidgetRoundingRadius1(self.context:getHeightValue("1500um")) end
	do _g.jk.widget.Widget:setWidgetClickHandler(self.radio, function()
		if self.enabled then
			do self.widgetContainer:updateSelectedWidget(self.widgetIndex) end
		end
	end) end
	do _g.jk.widget.Widget:setWidgetClickHandler(self.label, function()
		if self.enabled then
			do self.widgetContainer:updateSelectedWidget(self.widgetIndex) end
		end
	end) end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:setWidgetEnabled(v)
	self.enabled = v
	if not self.enabled then
		do _g.jk.widget.Widget:setAlpha(self, 0.5) end
	else
		do _g.jk.widget.Widget:setAlpha(self, 1.0) end
	end
	do return self end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:onSelected()
	if not (self.widgetColor ~= nil) then
		self.widgetColor = _g.jk.gfx.Color:black()
	end
	do self.canvas:setWidgetColor(self.widgetColor) end
	do self.canvas:setWidgetRoundingRadius1(self.context:getHeightValue("1500um")) end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:onDeSelected()
	do self.canvas:setWidgetColor(_g.jk.gfx.Color:white()) end
	do self.canvas:setWidgetRoundingRadius1(self.context:getHeightValue("1500um")) end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:createWidget()
	do _g.jk.widget.HorizontalBoxWidget.createWidget(self) end
	do
		local thisWidget = self
		do self:setWidgetSpacing(self.context:getHeightValue("2000um")) end
		do
			local widget = _g.jk.widget.AlignWidget._construct1(_g.jk.widget.AlignWidget._create(), self.context)
			self.radio = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
			do self.radio:setWidgetHeightRequest(self.context:getHeightValue("4000um")) end
			do self.radio:setWidgetWidthRequest(self.context:getHeightValue("4000um")) end
			self.outline = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
			do self.radio:addWidget(self.outline) end
			do
				local widget2 = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
				do widget2:setWidgetMargin(self.context:getHeightValue("500um")) end
				self.canvas = _g.jk.widget.CanvasWidget._construct1(_g.jk.widget.CanvasWidget._create(), self.context)
				do widget2:addWidget(self.canvas) end
				do self.radio:addWidget(widget2) end
				do widget:addWidget(self.radio) end
				do self:addWidget(widget) end
				self.label = _g.jk.widget.LabelWidget._construct1(_g.jk.widget.LabelWidget._create(), self.context)
				do self:addWidget(self.label) end
			end
		end
	end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:getWidgetIndex()
	do return self.widgetIndex end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:setWidgetIndex(v)
	self.widgetIndex = v
	do return self end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:getWidgetContainer()
	do return self.widgetContainer end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:setWidgetContainer(v)
	self.widgetContainer = v
	do return self end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:getWidgetColor()
	do return self.widgetColor end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:setWidgetColor(v)
	self.widgetColor = v
	do return self end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:getWidgetOutLineColor()
	do return self.widgetOutLineColor end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:setWidgetOutLineColor(v)
	self.widgetOutLineColor = v
	do return self end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:getWidgetText()
	do return self.widgetText end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:setWidgetText(v)
	self.widgetText = v
	do return self end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:getWidgetFontSize()
	do return self.widgetFontSize end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:setWidgetFontSize(v)
	self.widgetFontSize = v
	do return self end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:getWidgetFontResource()
	do return self.widgetFontResource end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:setWidgetFontResource(v)
	self.widgetFontResource = v
	do return self end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:getWidgetFontFamily()
	do return self.widgetFontFamily end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:setWidgetFontFamily(v)
	self.widgetFontFamily = v
	do return self end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:getWidgetFontBold()
	do return self.widgetFontBold end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:setWidgetFontBold(v)
	self.widgetFontBold = v
	do return self end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:getWidgetTextColor()
	do return self.widgetTextColor end
end

function jk.widget.common.RadioButtonWidget.MyRadioButtonWidget:setWidgetTextColor(v)
	self.widgetTextColor = v
	do return self end
end

function jk.widget.common.RadioButtonWidget:forGroup(context, items)
	local v = _g.jk.widget.common.RadioButtonWidget._construct1(_g.jk.widget.common.RadioButtonWidget._create(), context)
	do v:setWidgetItems(items) end
	do return v end
end

function jk.widget.common.RadioButtonWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	self.vrb = {}
	do
		local box = nil
		if self.widgetOrientation == _g.jk.widget.common.RadioButtonWidget.HORIZONTAL then
			box = _g.jk.widget.HorizontalBoxWidget:forContext(self.context, self.context:getHeightValue("2500um"), self.context:getHeightValue("1500um"))
		else
			box = _g.jk.widget.VerticalBoxWidget:forContext(self.context, self.context:getHeightValue("2500um"), self.context:getHeightValue("1500um"))
		end
		do
			local i = 0
			while i < _g.jk.lang.Vector:getSize(self.widgetItems) do
				local d = _g.jk.lang.Vector:get(self.widgetItems, i)
				if not (d ~= nil) then
					goto _continue1
				end
				do
					local rb = _g.jk.widget.common.RadioButtonWidget.MyRadioButtonWidget._construct1(_g.jk.widget.common.RadioButtonWidget.MyRadioButtonWidget._create(), self.context)
					do rb:setWidgetText(d) end
					do rb:setWidgetIndex(i) end
					do rb:setWidgetContainer(self) end
					do rb:setWidgetFontSize(self.widgetFontSize) end
					do rb:setWidgetFontResource(self.widgetFontResource) end
					do rb:setWidgetFontFamily(self.widgetFontFamily) end
					do rb:setWidgetFontBold(self.widgetFontBold) end
					do rb:setWidgetTextColor(self.widgetTextColor) end
					do rb:setWidgetColor(self.widgetOnSelectedColor) end
					do rb:setWidgetOutLineColor(self.widgetOutlineColor) end
					do _g.jk.lang.Vector:append(self.vrb, rb) end
					if self.widgetOrientation == _g.jk.widget.common.RadioButtonWidget.HORIZONTAL then
						do box:addWidget1(rb, 1.0) end
					else
						do box:addWidget(rb) end
					end
				end
				::_continue1::
				do i = i + 1 end
			end
		end
		do self:addWidget(box) end
	end
end

function jk.widget.common.RadioButtonWidget:setWidgetEnabled(v)
	if self.vrb ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(self.vrb)
		do
			n = 0
			while n < m do
				local rb = self.vrb[n + 1]
				if rb ~= nil then
					do rb:setWidgetEnabled(v) end
				end
				do n = n + 1 end
			end
		end
	end
	do return self end
end

function jk.widget.common.RadioButtonWidget:setWidgetValue(value)
	do self:setSelectWidgetValue(_g.jk.lang.String:asString(value)) end
end

function jk.widget.common.RadioButtonWidget:getWidgetValue()
	local index = self:getSelectedWidgetIndex()
	if not (self.widgetItems ~= nil) or index < 0 then
		do return nil end
	end
	do return _g.jk.lang.Vector:get(self.widgetItems, index) end
end

function jk.widget.common.RadioButtonWidget:getSelectedWidgetIndex()
	do return self.selectedWidgetIndex end
end

function jk.widget.common.RadioButtonWidget:setSelectWidgetValue(selectedWidget)
	do self:updateSelectedWidget(self:findIndexForWidgetValue(selectedWidget)) end
end

function jk.widget.common.RadioButtonWidget:setSelectedWidgetIndex(index)
	do self:updateSelectedWidget(index) end
end

function jk.widget.common.RadioButtonWidget:updateSelectedWidget(index)
	if self.selectedWidgetIndex > -1 then
		local widget = _g.jk.lang.Vector:get(self.vrb, self.selectedWidgetIndex)
		if widget ~= nil then
			do widget:onDeSelected() end
		end
	end
	do
		local ww = _g.jk.lang.Vector:get(self.vrb, index)
		if ww ~= nil then
			do ww:onSelected() end
		end
		self.selectedWidgetIndex = index
		if self.widgetClickHandler ~= nil then
			do self.widgetClickHandler(index) end
		end
	end
end

function jk.widget.common.RadioButtonWidget:findIndexForWidgetValue(id)
	local v = -1
	if self.widgetItems ~= nil then
		local n = 0
		local it = _g.jk.lang.Vector:iterate(self.widgetItems)
		while it ~= nil do
			local item = it:next()
			if item == nil then
				do break end
			end
			if item == id then
				v = n
				do break end
			end
			do n = n + 1 end
		end
	end
	do return v end
end

function jk.widget.common.RadioButtonWidget:getWidgetItems()
	do return self.widgetItems end
end

function jk.widget.common.RadioButtonWidget:setWidgetItems(v)
	self.widgetItems = v
	do return self end
end

function jk.widget.common.RadioButtonWidget:getWidgetFontSize()
	do return self.widgetFontSize end
end

function jk.widget.common.RadioButtonWidget:setWidgetFontSize(v)
	self.widgetFontSize = v
	do return self end
end

function jk.widget.common.RadioButtonWidget:getWidgetFontResource()
	do return self.widgetFontResource end
end

function jk.widget.common.RadioButtonWidget:setWidgetFontResource(v)
	self.widgetFontResource = v
	do return self end
end

function jk.widget.common.RadioButtonWidget:getWidgetFontFamily()
	do return self.widgetFontFamily end
end

function jk.widget.common.RadioButtonWidget:setWidgetFontFamily(v)
	self.widgetFontFamily = v
	do return self end
end

function jk.widget.common.RadioButtonWidget:getWidgetTextColor()
	do return self.widgetTextColor end
end

function jk.widget.common.RadioButtonWidget:setWidgetTextColor(v)
	self.widgetTextColor = v
	do return self end
end

function jk.widget.common.RadioButtonWidget:getWidgetFontBold()
	do return self.widgetFontBold end
end

function jk.widget.common.RadioButtonWidget:setWidgetFontBold(v)
	self.widgetFontBold = v
	do return self end
end

function jk.widget.common.RadioButtonWidget:getWidgetOnSelectedColor()
	do return self.widgetOnSelectedColor end
end

function jk.widget.common.RadioButtonWidget:setWidgetOnSelectedColor(v)
	self.widgetOnSelectedColor = v
	do return self end
end

function jk.widget.common.RadioButtonWidget:getWidgetOutlineColor()
	do return self.widgetOutlineColor end
end

function jk.widget.common.RadioButtonWidget:setWidgetOutlineColor(v)
	self.widgetOutlineColor = v
	do return self end
end

function jk.widget.common.RadioButtonWidget:getWidgetOrientation()
	do return self.widgetOrientation end
end

function jk.widget.common.RadioButtonWidget:setWidgetOrientation(v)
	self.widgetOrientation = v
	do return self end
end

function jk.widget.common.RadioButtonWidget:getWidgetClickHandler()
	do return self.widgetClickHandler end
end

function jk.widget.common.RadioButtonWidget:setWidgetClickHandler1(v)
	self.widgetClickHandler = v
	do return self end
end

jk.widget.common.SidebarWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.SidebarWidget.__index = jk.widget.common.SidebarWidget
_vm:set_metatable(jk.widget.common.SidebarWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.SidebarWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.SidebarWidget)
	return v
end

function jk.widget.common.SidebarWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.SidebarWidget'
	self['_isType.jk.widget.common.SidebarWidget'] = true
	self.widgetBackgroundColor = nil
	self.defaultActionItemWidgetBackgroundColor = nil
	self.defaultActionItemWidgetTextColor = nil
	self.defaultLabelItemWidgetBackgroundColor = nil
	self.defaultLabelItemWidgetTextColor = nil
	self.widgetItems = nil
	self.widgetScrollEnabled = true
end

function jk.widget.common.SidebarWidget:_construct0()
	jk.widget.common.SidebarWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.SidebarWidget:_construct1(context)
	jk.widget.common.SidebarWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.SidebarWidget:forItems(ctx, items, color)
	local v = _g.jk.widget.common.SidebarWidget._construct1(_g.jk.widget.common.SidebarWidget._create(), ctx)
	do v:setWidgetBackgroundColor(color) end
	do v:setWidgetItems(items) end
	do return v end
end

function jk.widget.common.SidebarWidget:addToWidgetItems(widget)
	if not (widget ~= nil) then
		do return end
	end
	if self.widgetItems == nil then
		self.widgetItems = {}
	end
	do _g.jk.lang.Vector:append(self.widgetItems, widget) end
end

function jk.widget.common.SidebarWidget:determineBackgroundColor()
	local wc = self.widgetBackgroundColor
	if wc == nil then
		wc = _g.jk.gfx.Color:white()
	end
	do return wc end
end

function jk.widget.common.SidebarWidget:determineTextColor(backgroundColor, textColor, defaultTextColor, lowerBackgroundColor)
	local tc = textColor
	if tc == nil then
		tc = defaultTextColor
	end
	if tc == nil then
		local cc = lowerBackgroundColor
		if cc == nil then
			cc = self:determineBackgroundColor()
		end
		if cc:isDarkColor() then
			tc = _g.jk.gfx.Color:white()
		else
			tc = _g.jk.gfx.Color:black()
		end
	end
	do return tc end
end

function jk.widget.common.SidebarWidget:addLabelItem(text, bold, backgroundColor, textColor)
	local v = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
	local bgc = backgroundColor
	if bgc == nil then
		bgc = self.defaultLabelItemWidgetBackgroundColor
	end
	do
		local tc = self:determineTextColor(backgroundColor, textColor, self.defaultLabelItemWidgetTextColor, bgc)
		if bgc ~= nil then
			do v:addWidget(_g.jk.widget.CanvasWidget:forColor(self.context, bgc)) end
		end
		do
			local mm3 = self.context:getHeightValue("3mm")
			local lbl = _g.jk.widget.LabelWidget:forText(self.context, text)
			do lbl:setWidgetFontSize(mm3) end
			do lbl:setWidgetTextColor(tc) end
			do lbl:setWidgetFontBold(bold) end
			do v:addWidget(_g.jk.widget.LayerWidget:forWidget(self.context, lbl, mm3)) end
			do self:addToWidgetItems(v) end
			do return self end
		end
	end
end

function jk.widget.common.SidebarWidget:addActionItem(text, handler, bold, backgroundColor, textColor)
	local v = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.context)
	local bgc = backgroundColor
	if bgc == nil then
		bgc = self.defaultActionItemWidgetBackgroundColor
	end
	do
		local tc = self:determineTextColor(backgroundColor, textColor, self.defaultActionItemWidgetTextColor, bgc)
		if bgc ~= nil then
			do v:addWidget(_g.jk.widget.CanvasWidget:forColor(self.context, bgc)) end
		end
		do
			local mm3 = self.context:getHeightValue("3mm")
			local lbl = _g.jk.widget.LabelWidget:forText(self.context, text)
			do lbl:setWidgetFontSize(mm3) end
			do lbl:setWidgetTextColor(tc) end
			do lbl:setWidgetFontBold(bold) end
			do v:addWidget(_g.jk.widget.LayerWidget:forWidget(self.context, lbl, mm3)) end
			if handler ~= nil then
				do _g.jk.widget.Widget:setWidgetClickHandler(v, handler) end
			end
			do self:addToWidgetItems(v) end
			do return self end
		end
	end
end

function jk.widget.common.SidebarWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	do
		local wc = self:determineBackgroundColor()
		do self:addWidget(_g.jk.widget.CanvasWidget:forColor(self.context, wc)) end
		do
			local vbox = _g.jk.widget.VerticalBoxWidget:forContext(self.context, 0, 0)
			if _g.jk.lang.Vector:isEmpty(self.widgetItems) == false then
				if self.widgetItems ~= nil then
					local n = 0
					local m = _g.jk.lang.Vector:getSize(self.widgetItems)
					do
						n = 0
						while n < m do
							local item = self.widgetItems[n + 1]
							if item ~= nil then
								do vbox:addWidget(item) end
							end
							do n = n + 1 end
						end
					end
				end
			end
			do
				local tml = _g.jk.widget.common.TopMarginLayerWidget._construct1(_g.jk.widget.common.TopMarginLayerWidget._create(), self.context)
				do tml:addWidget(_g.jk.widget.LayerWidget:forWidgetAndWidth(self.context, vbox, self.context:getWidthValue("50mm"))) end
				do self:applyScroller(tml) end
			end
		end
	end
end

function jk.widget.common.SidebarWidget:applyScroller(widget)
	if not (widget ~= nil) then
		do return end
	end
	if not self.widgetScrollEnabled then
		do self:addWidget(widget) end
	else
		local scroller = _g.jk.widget.VerticalScrollerWidget:forWidget(self.context, widget)
		do scroller:setWidgetScrollBarDisabled(true) end
		do self:addWidget(scroller) end
	end
end

function jk.widget.common.SidebarWidget:getWidgetBackgroundColor()
	do return self.widgetBackgroundColor end
end

function jk.widget.common.SidebarWidget:setWidgetBackgroundColor(v)
	self.widgetBackgroundColor = v
	do return self end
end

function jk.widget.common.SidebarWidget:getDefaultActionItemWidgetBackgroundColor()
	do return self.defaultActionItemWidgetBackgroundColor end
end

function jk.widget.common.SidebarWidget:setDefaultActionItemWidgetBackgroundColor(v)
	self.defaultActionItemWidgetBackgroundColor = v
	do return self end
end

function jk.widget.common.SidebarWidget:getDefaultActionItemWidgetTextColor()
	do return self.defaultActionItemWidgetTextColor end
end

function jk.widget.common.SidebarWidget:setDefaultActionItemWidgetTextColor(v)
	self.defaultActionItemWidgetTextColor = v
	do return self end
end

function jk.widget.common.SidebarWidget:getDefaultLabelItemWidgetBackgroundColor()
	do return self.defaultLabelItemWidgetBackgroundColor end
end

function jk.widget.common.SidebarWidget:setDefaultLabelItemWidgetBackgroundColor(v)
	self.defaultLabelItemWidgetBackgroundColor = v
	do return self end
end

function jk.widget.common.SidebarWidget:getDefaultLabelItemWidgetTextColor()
	do return self.defaultLabelItemWidgetTextColor end
end

function jk.widget.common.SidebarWidget:setDefaultLabelItemWidgetTextColor(v)
	self.defaultLabelItemWidgetTextColor = v
	do return self end
end

function jk.widget.common.SidebarWidget:getWidgetItems()
	do return self.widgetItems end
end

function jk.widget.common.SidebarWidget:setWidgetItems(v)
	self.widgetItems = v
	do return self end
end

function jk.widget.common.SidebarWidget:getWidgetScrollEnabled()
	do return self.widgetScrollEnabled end
end

function jk.widget.common.SidebarWidget:setWidgetScrollEnabled(v)
	self.widgetScrollEnabled = v
	do return self end
end

jk.widget.common.TopMarginLayerWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.TopMarginLayerWidget.__index = jk.widget.common.TopMarginLayerWidget
_vm:set_metatable(jk.widget.common.TopMarginLayerWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.TopMarginLayerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.TopMarginLayerWidget)
	return v
end

function jk.widget.common.TopMarginLayerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.TopMarginLayerWidget'
	self['_isType.jk.widget.common.TopMarginLayerWidget'] = true
end

function jk.widget.common.TopMarginLayerWidget:_construct0()
	jk.widget.common.TopMarginLayerWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.TopMarginLayerWidget:_construct1(context)
	jk.widget.common.TopMarginLayerWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.TopMarginLayerWidget:computeWidgetLayout(widthConstraint)
	self.widgetMarginTop = self.context:getScreenTopMargin()
	do _g.jk.widget.LayerWidget.computeWidgetLayout(self, widthConstraint) end
end

jk.widget.common.VerticalScrollerWithToolbarWidget = _g.jk.widget.LayerWidget._create()
jk.widget.common.VerticalScrollerWithToolbarWidget.__index = jk.widget.common.VerticalScrollerWithToolbarWidget
_vm:set_metatable(jk.widget.common.VerticalScrollerWithToolbarWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.common.VerticalScrollerWithToolbarWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.VerticalScrollerWithToolbarWidget)
	return v
end

function jk.widget.common.VerticalScrollerWithToolbarWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.VerticalScrollerWithToolbarWidget'
	self['_isType.jk.widget.common.VerticalScrollerWithToolbarWidget'] = true
	self.autohideToolbar = false
	self.widgetContent = nil
	self.widgetToolbar = nil
	self.shown = true
end

function jk.widget.common.VerticalScrollerWithToolbarWidget:_construct0()
	jk.widget.common.VerticalScrollerWithToolbarWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.common.VerticalScrollerWithToolbarWidget:_construct1(context)
	jk.widget.common.VerticalScrollerWithToolbarWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.VerticalScrollerWithToolbarWidget:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	do
		local scroller = _g.jk.widget.VerticalScrollerWidget:forWidget(self.context, self.widgetContent)
		do scroller:setOnScrolledHandler(function(direction)
			if self.autohideToolbar then
				if direction == 0 and self.shown == true then
					do self:hideToolbar() end
					self.shown = false
				elseif direction == 1 and self.shown == false then
					do self:showToolbar() end
					self.shown = true
				end
			end
		end) end
		if self.autohideToolbar then
			do self:addWidget(scroller) end
			do
				local align = _g.jk.widget.AlignWidget._construct1(_g.jk.widget.AlignWidget._create(), self.context)
				do align:addWidget1(self.widgetToolbar, 0, 1.0, true) end
				do self:addWidget(align) end
			end
		else
			local vbox = _g.jk.widget.VerticalBoxWidget:forContext(self.context, 0, 0)
			do vbox:addWidget1(scroller, 1.0) end
			do vbox:addWidget(self.widgetToolbar) end
			do self:addWidget(vbox) end
		end
	end
end

function jk.widget.common.VerticalScrollerWithToolbarWidget:showToolbar()
	local sy = _g.jk.widget.Widget:getHeight(self.widgetToolbar)
	local y = _g.jk.widget.Widget:getY(self.widgetToolbar)
	local targety = _g.jk.widget.Widget:getHeight(self) - sy
	local anim = _g.jk.widget.WidgetAnimation:forDuration(self.context, 250)
	do anim:addCallback(function(completion)
		local dy = y - _util:convert_to_integer(completion * sy)
		if dy < targety then
			dy = targety
		end
		do _g.jk.widget.Widget:move(self.widgetToolbar, 0, dy) end
	end) end
	do anim:setEndListener(function()
		self.shown = true
	end) end
	do anim:start() end
end

function jk.widget.common.VerticalScrollerWithToolbarWidget:hideToolbar()
	local sy = _g.jk.widget.Widget:getHeight(self.widgetToolbar)
	local y = _g.jk.widget.Widget:getY(self.widgetToolbar)
	local targety = _g.jk.widget.Widget:getHeight(self)
	local anim = _g.jk.widget.WidgetAnimation:forDuration(self.context, 250)
	do anim:addCallback(function(completion)
		local dy = y + _util:convert_to_integer(completion * sy)
		if dy > targety then
			dy = targety
		end
		do _g.jk.widget.Widget:move(self.widgetToolbar, 0, dy) end
	end) end
	do anim:setEndListener(function()
		self.shown = false
	end) end
	do anim:start() end
end

function jk.widget.common.VerticalScrollerWithToolbarWidget:getAutohideToolbar()
	do return self.autohideToolbar end
end

function jk.widget.common.VerticalScrollerWithToolbarWidget:setAutohideToolbar(v)
	self.autohideToolbar = v
	do return self end
end

function jk.widget.common.VerticalScrollerWithToolbarWidget:getWidgetContent()
	do return self.widgetContent end
end

function jk.widget.common.VerticalScrollerWithToolbarWidget:setWidgetContent(v)
	self.widgetContent = v
	do return self end
end

function jk.widget.common.VerticalScrollerWithToolbarWidget:getWidgetToolbar()
	do return self.widgetToolbar end
end

function jk.widget.common.VerticalScrollerWithToolbarWidget:setWidgetToolbar(v)
	self.widgetToolbar = v
	do return self end
end

jk.widget.common.AutoSuggestInputWidget = _g.jk.widget.common.TextInputWidget._create()
jk.widget.common.AutoSuggestInputWidget.__index = jk.widget.common.AutoSuggestInputWidget
_vm:set_metatable(jk.widget.common.AutoSuggestInputWidget, {
	__index = _g.jk.widget.common.TextInputWidget
})

function jk.widget.common.AutoSuggestInputWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.AutoSuggestInputWidget)
	return v
end

function jk.widget.common.AutoSuggestInputWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.AutoSuggestInputWidget'
	self['_isType.jk.widget.common.AutoSuggestInputWidget'] = true
	self.defaultNoRecordMessage = "No record found"
	self.widgetValueChangeHandler = nil
	self.widgetContext = nil
	self.widgetItems = nil
	self.container = nil
	self.myContainer = nil
	self.shown = false
end

function jk.widget.common.AutoSuggestInputWidget:_construct0()
	jk.widget.common.AutoSuggestInputWidget._init(self)
	do _g.jk.widget.common.TextInputWidget._construct0(self) end
	return self
end

jk.widget.common.AutoSuggestInputWidget.MyContainerWidget = _g.jk.widget.ContainerWidget._create()
jk.widget.common.AutoSuggestInputWidget.MyContainerWidget.__index = jk.widget.common.AutoSuggestInputWidget.MyContainerWidget
_vm:set_metatable(jk.widget.common.AutoSuggestInputWidget.MyContainerWidget, {
	__index = _g.jk.widget.ContainerWidget
})

function jk.widget.common.AutoSuggestInputWidget.MyContainerWidget._create()
	local v = _vm:set_metatable({}, jk.widget.common.AutoSuggestInputWidget.MyContainerWidget)
	return v
end

function jk.widget.common.AutoSuggestInputWidget.MyContainerWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.common.AutoSuggestInputWidget.MyContainerWidget'
	self['_isType.jk.widget.common.AutoSuggestInputWidget.MyContainerWidget'] = true
	self.widget = nil
end

function jk.widget.common.AutoSuggestInputWidget.MyContainerWidget:_construct0()
	jk.widget.common.AutoSuggestInputWidget.MyContainerWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct0(self) end
	return self
end

function jk.widget.common.AutoSuggestInputWidget.MyContainerWidget:_construct1(context)
	jk.widget.common.AutoSuggestInputWidget.MyContainerWidget._init(self)
	do _g.jk.widget.ContainerWidget._construct1(self, context) end
	return self
end

function jk.widget.common.AutoSuggestInputWidget.MyContainerWidget:onWidgetHeightChanged(height)
	local array = _g.jk.widget.Widget:getChildren(self)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local child = array[n + 1]
				if child ~= nil then
					do _g.jk.widget.Widget:move(child, _g.jk.widget.Widget:getAbsoluteX(self.widget), _g.jk.widget.Widget:getAbsoluteY(self.widget)) end
				end
				do n = n + 1 end
			end
		end
	end
end

function jk.widget.common.AutoSuggestInputWidget.MyContainerWidget:computeWidgetLayout(widthConstraint)
	local array = _g.jk.widget.Widget:getChildren(self)
	if array ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(array)
		do
			n = 0
			while n < m do
				local child = array[n + 1]
				if child ~= nil then
					do _g.jk.widget.Widget:layout(child, _g.jk.widget.Widget:getWidth(self.widget), false) end
					do _g.jk.widget.Widget:move(child, _g.jk.widget.Widget:getAbsoluteX(self.widget), _g.jk.widget.Widget:getAbsoluteY(self.widget)) end
				end
				do n = n + 1 end
			end
		end
	end
	do _g.jk.widget.Widget:setLayoutSize(self, widthConstraint, _g.jk.widget.Widget:getHeight(self)) end
end

function jk.widget.common.AutoSuggestInputWidget.MyContainerWidget:getWidget()
	do return self.widget end
end

function jk.widget.common.AutoSuggestInputWidget.MyContainerWidget:setWidget(v)
	self.widget = v
	do return self end
end

function jk.widget.common.AutoSuggestInputWidget:_construct1(ctx)
	jk.widget.common.AutoSuggestInputWidget._init(self)
	do _g.jk.widget.common.TextInputWidget._construct1(self, ctx) end
	self.widgetContext = ctx
	self.container = _g.jk.widget.VerticalBoxWidget:forContext(self.widgetContext, 0, 0)
	do self:setWidgetTextChangeHandler(function()
		do self:onWidgetTextChanged() end
	end) end
	return self
end

function jk.widget.common.AutoSuggestInputWidget:isWidgetShown()
	do return self.shown end
end

function jk.widget.common.AutoSuggestInputWidget:clearItems()
	if not (self.container ~= nil) then
		do return end
	end
	do _g.jk.widget.Widget:removeChildrenOf(self.container) end
end

function jk.widget.common.AutoSuggestInputWidget:setWidgetItems(items)
	self.widgetItems = items
end

function jk.widget.common.AutoSuggestInputWidget:getWidgetItems()
	do return self.widgetItems end
end

function jk.widget.common.AutoSuggestInputWidget:createWidgetItem(title, isFirst, index)
	local textColor = self.widgetContext:getStyleColor("AutoSuggestInputWidget", "textColor", nil)
	if not (textColor ~= nil) then
		textColor = _g.jk.gfx.Color:black()
	end
	do
		local backgroundColor = self.widgetContext:getStyleColor("AutoSuggestInputWidget", "backgroundColor", nil)
		if not (backgroundColor ~= nil) then
			backgroundColor = _g.jk.gfx.Color:white()
		end
		do
			local outlineColor = self.widgetContext:getStyleColor("AutoSuggestInputWidget", "outlineColor", nil)
			if not (outlineColor ~= nil) then
				outlineColor = _g.jk.gfx.Color:black()
			end
			do
				local outlineWidth = self.widgetContext:getStylePixels("AutoSuggestInputWidget", "outlineWidth", nil)
				if outlineWidth < 1 then
					outlineWidth = self.widgetContext:getHeightValue("1px")
				end
				do
					local padding = self.widgetContext:getStylePixels("AutoSuggestInputWidget", "padding", nil)
					if padding < 1 then
						padding = self.widgetContext:getHeightValue("1000um")
					end
					do
						local fontSize = self.widgetContext:getStylePixels("AutoSuggestInputWidget", "fontSize", nil)
						if fontSize < 1 then
							fontSize = self.widgetContext:getHeightValue("2mm")
						end
						do
							local t = title
							if _g.jk.lang.String:isEmpty(t) then
								t = self.defaultNoRecordMessage
							end
							do
								local ttitle = t
								local lbl = _g.jk.widget.LabelWidget:forText(self.widgetContext, t)
								do lbl:setWidgetTextColor(textColor) end
								do
									local layer = _g.jk.widget.LayerWidget._construct1(_g.jk.widget.LayerWidget._create(), self.widgetContext)
									local canvas = _g.jk.widget.CanvasWidget:forColor(self.widgetContext, backgroundColor)
									do canvas:setWidgetOutlineColor(outlineColor) end
									do canvas:setWidgetOutlineWidth(outlineWidth) end
									do layer:addWidget(canvas) end
									do layer:addWidget(_g.jk.widget.LayerWidget:forWidget(self.widgetContext, lbl, padding)) end
									if _g.jk.lang.String:isNotEmpty(title) then
										do _g.jk.widget.Widget:setWidgetClickHandler(layer, function()
											do self:setWidgetText(ttitle) end
											if self.widgetValueChangeHandler ~= nil then
												do self.widgetValueChangeHandler() end
											end
											do self:closePopup() end
										end) end
									end
									do return layer end
								end
							end
						end
					end
				end
			end
		end
	end
end

function jk.widget.common.AutoSuggestInputWidget:showPopup()
	if not (self.container ~= nil) then
		do return end
	end
	if self.shown then
		do return end
	end
	do
		local thisWidget = self
		local parentLayer = nil
		local parent = _g.jk.widget.Widget:getParent(thisWidget)
		while parent ~= nil do
			if (_vm:to_table_with_key(parent, '_isType.jk.widget.LayerWidget') ~= nil) then
				parentLayer = parent
			end
			parent = _g.jk.widget.Widget:getParent(parent)
		end
		if not (parentLayer ~= nil) then
			_io:write_to_stdout("[jk.widget.common.AutoSuggestInputWidget.showPopup] (AutoSuggestInputWidget.sling:137:3): No LayerWidget was found in the widget tree. Cannot show suggestions dropdown!" .. "\n")
			do return end
		end
		self.myContainer = _g.jk.widget.common.AutoSuggestInputWidget.MyContainerWidget._construct1(_g.jk.widget.common.AutoSuggestInputWidget.MyContainerWidget._create(), self.widgetContext)
		do self.myContainer:setWidget(thisWidget) end
		do self.myContainer:addWidget(self.container) end
		do parentLayer:addWidget(self.myContainer) end
		do
			local animationDestY = _g.jk.widget.Widget:getAbsoluteY(thisWidget)
			local ay = self.widgetContext:getHeightValue("3mm")
			do _g.jk.widget.Widget:move(self.container, _g.jk.widget.Widget:getAbsoluteX(thisWidget), animationDestY + ay) end
			do
				local anim = _g.jk.widget.WidgetAnimation:forDuration(self.widgetContext, 300)
				do anim:addCallback(function(completion)
					local bgf = completion * 1.5
					if bgf > 1.0 then
						bgf = 1.0
					end
					do _g.jk.widget.Widget:move(self.container, _g.jk.widget.Widget:getAbsoluteX(thisWidget), _util:convert_to_integer(animationDestY + _util:convert_to_integer((1.0 - completion) * ay))) end
				end) end
				do anim:start() end
				self.shown = true
			end
		end
	end
end

function jk.widget.common.AutoSuggestInputWidget:closePopup()
	if not self.shown then
		do return end
	end
	do
		local anim = _g.jk.widget.WidgetAnimation:forDuration(self.widgetContext, 300)
		do anim:addFadeOut(self.myContainer, true) end
		do anim:start() end
		self.shown = false
	end
end

function jk.widget.common.AutoSuggestInputWidget:onWidgetTextChanged()
	do self:clearItems() end
	if _g.jk.lang.String:getLength(self:getWidgetText()) < 3 then
		do self:closePopup() end
		do return end
	end
	do self:searchStringFromItems(self:getWidgetText()) end
	do self:showPopup() end
end

function jk.widget.common.AutoSuggestInputWidget:searchStringFromItems(value)
	if not (self.widgetItems ~= nil) or _g.jk.lang.Vector:isEmpty(self.widgetItems) then
		do self:addItemToList(nil, false, 0) end
	end
	if self.widgetItems ~= nil then
		local n = 0
		local m = _g.jk.lang.Vector:getSize(self.widgetItems)
		do
			n = 0
			while n < m do
				local item = self.widgetItems[n + 1]
				if item ~= nil then
					if _g.jk.lang.String:contains(_g.jk.lang.String:toLowerCase(item), _g.jk.lang.String:toLowerCase(value)) then
						do self:addItemToList(item, false, 0) end
					end
				end
				do n = n + 1 end
			end
		end
	end
	if _g.jk.lang.Vector:getSize(_g.jk.widget.Widget:getChildren(self.container)) < 1 then
		do self:addItemToList(nil, false, 0) end
	end
end

function jk.widget.common.AutoSuggestInputWidget:addSuggestedItems()
	if not (self.widgetItems ~= nil) or _g.jk.lang.Vector:isEmpty(self.widgetItems) then
		do self:addItemToList(nil, false, 0) end
	end
	do
		local index = 0
		local isFirst = true
		if self.widgetItems ~= nil then
			local n = 0
			local m = _g.jk.lang.Vector:getSize(self.widgetItems)
			do
				n = 0
				while n < m do
					local item = self.widgetItems[n + 1]
					if item ~= nil then
						do self:addItemToList(item, isFirst, index) end
						isFirst = false
						do index = index + 1 end
					end
					do n = n + 1 end
				end
			end
		end
	end
end

function jk.widget.common.AutoSuggestInputWidget:addItemToList(item, isFirst, index)
	local v = self:createWidgetItem(item, isFirst, index)
	if v ~= nil then
		do self.container:addWidget(v) end
	end
end

function jk.widget.common.AutoSuggestInputWidget:getDefaultNoRecordMessage()
	do return self.defaultNoRecordMessage end
end

function jk.widget.common.AutoSuggestInputWidget:setDefaultNoRecordMessage(v)
	self.defaultNoRecordMessage = v
	do return self end
end

function jk.widget.common.AutoSuggestInputWidget:getWidgetValueChangeHandler()
	do return self.widgetValueChangeHandler end
end

function jk.widget.common.AutoSuggestInputWidget:setWidgetValueChangeHandler(v)
	self.widgetValueChangeHandler = v
	do return self end
end
jk = jk or {}

jk.widget = jk.widget or {}

jk.widget.web = jk.widget.web or {}

jk.widget.web.AsynchronousImageWidget = _g.jk.widget.LayerWidget._create()
jk.widget.web.AsynchronousImageWidget.__index = jk.widget.web.AsynchronousImageWidget
_vm:set_metatable(jk.widget.web.AsynchronousImageWidget, {
	__index = _g.jk.widget.LayerWidget
})

function jk.widget.web.AsynchronousImageWidget._create()
	local v = _vm:set_metatable({}, jk.widget.web.AsynchronousImageWidget)
	return v
end

function jk.widget.web.AsynchronousImageWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.web.AsynchronousImageWidget'
	self['_isType.jk.widget.web.AsynchronousImageWidget'] = true
	self.overlay = nil
	self.widgetImageWidth = 0
	self.widgetImageHeight = 0
	self.widgetImageScaleMethod = 0
	self.widgetPlaceholderImage = nil
end

function jk.widget.web.AsynchronousImageWidget:_construct0()
	jk.widget.web.AsynchronousImageWidget._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function jk.widget.web.AsynchronousImageWidget:_construct1(context)
	jk.widget.web.AsynchronousImageWidget._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function jk.widget.web.AsynchronousImageWidget:configureImageWidgetProperties(imageWidget)
	do imageWidget:setWidgetImageWidth(self.widgetImageWidth) end
	do imageWidget:setWidgetImageHeight(self.widgetImageHeight) end
	do imageWidget:setWidgetImageScaleMethod(self.widgetImageScaleMethod) end
end

function jk.widget.web.AsynchronousImageWidget:onStartLoading(useOverlay)
	do self:removeAllChildren() end
	do
		local v = _g.jk.widget.ImageWidget._construct1(_g.jk.widget.ImageWidget._create(), self.context)
		do self:configureImageWidgetProperties(v) end
		if self.widgetPlaceholderImage ~= nil then
			do v:setWidgetImage(self.widgetPlaceholderImage) end
		end
		do self:addWidget(v) end
		if useOverlay then
			self.overlay = _g.jk.widget.CanvasWidget:forColor(self.context, _g.jk.gfx.Color:forRGBA(0, 0, 0, 200))
			do self:addWidget(self.overlay) end
		end
		do return v end
	end
end

function jk.widget.web.AsynchronousImageWidget:onEndLoading()
	if self.overlay ~= nil then
		do _g.jk.widget.Widget:removeFromParent(self.overlay) end
		self.overlay = nil
	end
end

function jk.widget.web.AsynchronousImageWidget:getWidgetImageWidth()
	do return self.widgetImageWidth end
end

function jk.widget.web.AsynchronousImageWidget:setWidgetImageWidth(v)
	self.widgetImageWidth = v
	do return self end
end

function jk.widget.web.AsynchronousImageWidget:getWidgetImageHeight()
	do return self.widgetImageHeight end
end

function jk.widget.web.AsynchronousImageWidget:setWidgetImageHeight(v)
	self.widgetImageHeight = v
	do return self end
end

function jk.widget.web.AsynchronousImageWidget:getWidgetImageScaleMethod()
	do return self.widgetImageScaleMethod end
end

function jk.widget.web.AsynchronousImageWidget:setWidgetImageScaleMethod(v)
	self.widgetImageScaleMethod = v
	do return self end
end

function jk.widget.web.AsynchronousImageWidget:getWidgetPlaceholderImage()
	do return self.widgetPlaceholderImage end
end

function jk.widget.web.AsynchronousImageWidget:setWidgetPlaceholderImage(v)
	self.widgetPlaceholderImage = v
	do return self end
end

jk.widget.web.JSONAPIClientWithGui = _g.jk.web.json.JSONAPIClient._create()
jk.widget.web.JSONAPIClientWithGui.__index = jk.widget.web.JSONAPIClientWithGui
_vm:set_metatable(jk.widget.web.JSONAPIClientWithGui, {
	__index = _g.jk.web.json.JSONAPIClient
})

function jk.widget.web.JSONAPIClientWithGui._create()
	local v = _vm:set_metatable({}, jk.widget.web.JSONAPIClientWithGui)
	return v
end

function jk.widget.web.JSONAPIClientWithGui:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.web.JSONAPIClientWithGui'
	self['_isType.jk.widget.web.JSONAPIClientWithGui'] = true
	self.context = nil
	self.parentWidget = nil
	self.loadingWidget = nil
	self.requestCounter = 0
end

function jk.widget.web.JSONAPIClientWithGui:_construct0()
	jk.widget.web.JSONAPIClientWithGui._init(self)
	do _g.jk.web.json.JSONAPIClient._construct0(self) end
	return self
end

function jk.widget.web.JSONAPIClientWithGui:onStartSendRequest()
	do _g.jk.web.json.JSONAPIClient.onStartSendRequest(self) end
	if self.loadingWidget == nil then
		self.loadingWidget = _g.jk.widget.common.LoadingWidget:openPopup(self.context, self.parentWidget)
	end
	do self.requestCounter = self.requestCounter + 1 end
end

function jk.widget.web.JSONAPIClientWithGui:onEndSendRequest()
	do _g.jk.web.json.JSONAPIClient.onEndSendRequest(self) end
	do self.requestCounter = self.requestCounter - 1 end
	if self.requestCounter < 1 then
		self.loadingWidget = _g.jk.widget.common.LoadingWidget:closePopup(self.loadingWidget)
	end
end

function jk.widget.web.JSONAPIClientWithGui:onDefaultErrorHandler(error)
	if error == nil or self.context == nil then
		do return end
	end
	do self.context:showErrorDialog(error:toString(), nil) end
end

function jk.widget.web.JSONAPIClientWithGui:getContext()
	do return self.context end
end

function jk.widget.web.JSONAPIClientWithGui:setContext(v)
	self.context = v
	do return self end
end

function jk.widget.web.JSONAPIClientWithGui:getParentWidget()
	do return self.parentWidget end
end

function jk.widget.web.JSONAPIClientWithGui:setParentWidget(v)
	self.parentWidget = v
	do return self end
end

jk.widget.web.WebWidget = {}
jk.widget.web.WebWidget.__index = jk.widget.web.WebWidget
_vm:set_metatable(jk.widget.web.WebWidget, {})

function jk.widget.web.WebWidget._create()
	local v = _vm:set_metatable({}, jk.widget.web.WebWidget)
	return v
end

function jk.widget.web.WebWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.web.WebWidget'
	self['_isType.jk.widget.web.WebWidget'] = true
	self.widgetContext = nil
	self.widgetUrl = nil
	self.widgetHtmlString = nil
	self.customUrlHandler = nil
end

function jk.widget.web.WebWidget:_construct0()
	jk.widget.web.WebWidget._init(self)
	return self
end

function jk.widget.web.WebWidget:forUrl(context, url)
	local v = _g.jk.widget.web.WebWidget._construct1(_g.jk.widget.web.WebWidget._create(), context)
	do v:setWidgetUrl(url) end
	do return v end
end

function jk.widget.web.WebWidget:forHtmlString(context, html)
	local v = _g.jk.widget.web.WebWidget._construct1(_g.jk.widget.web.WebWidget._create(), context)
	do v:setWidgetHtmlString(html) end
	do return v end
end

function jk.widget.web.WebWidget:_construct1(context)
	jk.widget.web.WebWidget._init(self)
	self.widgetContext = context
	return self
end

function jk.widget.web.WebWidget:overrideWidgetUrlLoading(url)
	if self.customUrlHandler ~= nil then
		do return self.customUrlHandler(url) end
	end
	do return false end
end

function jk.widget.web.WebWidget:setWebCustomUserAgent(customUserAgent)
	local cua = customUserAgent
	local web = self
	do return self end
end

function jk.widget.web.WebWidget:setWidgetHtmlString(html)
	self.widgetHtmlString = html
	self.widgetUrl = nil
	do self:updateWidgetContent() end
	do return self end
end

function jk.widget.web.WebWidget:getWidgetHtmlString()
	do return self.widgetHtmlString end
end

function jk.widget.web.WebWidget:setWidgetUrl(url)
	self.widgetUrl = url
	self.widgetHtmlString = nil
	do self:updateWidgetContent() end
	do return self end
end

function jk.widget.web.WebWidget:getWidgetUrl()
	do return self.widgetUrl end
end

function jk.widget.web.WebWidget:updateWidgetContent()
	local url = self.widgetUrl
	if url ~= nil then
		_io:write_to_stdout("[jk.widget.web.WebWidget.updateWidgetContent] (WebWidget.sling:247:4): Not implemented" .. "\n")
	else
		local htmlString = self.widgetHtmlString
		_io:write_to_stdout("[jk.widget.web.WebWidget.updateWidgetContent] (WebWidget.sling:280:4): Not implemented" .. "\n")
	end
end

function jk.widget.web.WebWidget:getCustomUrlHandler()
	do return self.customUrlHandler end
end

function jk.widget.web.WebWidget:setCustomUrlHandler(v)
	self.customUrlHandler = v
	do return self end
end

jk.widget.web.WebImageWidget = _g.jk.widget.web.AsynchronousImageWidget._create()
jk.widget.web.WebImageWidget.__index = jk.widget.web.WebImageWidget
_vm:set_metatable(jk.widget.web.WebImageWidget, {
	__index = _g.jk.widget.web.AsynchronousImageWidget
})

function jk.widget.web.WebImageWidget._create()
	local v = _vm:set_metatable({}, jk.widget.web.WebImageWidget)
	return v
end

function jk.widget.web.WebImageWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.web.WebImageWidget'
	self['_isType.jk.widget.web.WebImageWidget'] = true
	self.widgetImage = nil
	self.widgetUseOverlay = false
end

function jk.widget.web.WebImageWidget:_construct0()
	jk.widget.web.WebImageWidget._init(self)
	do _g.jk.widget.web.AsynchronousImageWidget._construct0(self) end
	return self
end

function jk.widget.web.WebImageWidget:forPlaceholderImage(context, image)
	local v = _g.jk.widget.web.WebImageWidget._construct1(_g.jk.widget.web.WebImageWidget._create(), context)
	do v:setWidgetPlaceholderImage(image) end
	do return v end
end

function jk.widget.web.WebImageWidget:_construct1(context)
	jk.widget.web.WebImageWidget._init(self)
	do _g.jk.widget.web.AsynchronousImageWidget._construct1(self, context) end
	return self
end

function jk.widget.web.WebImageWidget:setWidgetImageResource(resName)
	local img = self:onStartLoading(false)
	if img ~= nil then
		do img:setWidgetImageResource(resName) end
	end
	do self:onEndLoading() end
end

function jk.widget.web.WebImageWidget:getWidgetImage()
	do return self.widgetImage end
end

function jk.widget.web.WebImageWidget:setWidgetImage(image)
	local img = self:onStartLoading(false)
	self.widgetImage = image
	if img ~= nil then
		do img:setWidgetImage(image) end
	end
	do self:onEndLoading() end
end

function jk.widget.web.WebImageWidget:setWidgetImageUrl1(url, callback)
	do self:setWidgetImageUrl2(url, nil, nil, callback) end
end

function jk.widget.web.WebImageWidget:setWidgetImageUrl2(url, headers, body, callback)
	do _g.jk.log.Log:debug(self.context, "WebImageWidget" .. ": Start loading image: `" .. _g.jk.lang.String:safeString(url) .. "'") end
	do
		local img = self:onStartLoading(self.widgetUseOverlay)
		do _g.jk.widget.web.WebImageWidget:doQueryImage(self.context, url, headers, body, function(imgo)
			do self:onEndLoading() end
			self.widgetImage = imgo
			do img:setWidgetImage(imgo) end
		end, callback) end
	end
end

function jk.widget.web.WebImageWidget:doQueryImage(context, url, headers, body, callback, errorCallback)
	local client = _g.jk.web.NativeWebClient:instance()
	if not (client ~= nil) then
		do _g.jk.log.Log:error(context, "Failed to create web client.") end
		if errorCallback ~= nil then
			do errorCallback(_g.jk.lang.Error:forCode("noWebClient", nil)) end
		end
		do return end
	end
	do
		local uu = url
		local cb = callback
		local ecb = errorCallback
		local contextf = context
		do client:query("GET", url, headers, body, function(rcode, rheaders, rbody)
			if rbody == nil or _g.jk.lang.Buffer:getSize(rbody) < 1 then
				do _g.jk.log.Log:error(contextf, "WebImageWidget" .. ": FAILED loading image: `" .. _g.jk.lang.String:safeString(uu) .. "'") end
				if ecb ~= nil then
					do ecb(_g.jk.lang.Error:forCode("failedToDownload", nil)) end
				end
				do return end
			end
			do
				local mimeType = nil
				local hdrv = rheaders:asVector()
				if hdrv ~= nil then
					local n = 0
					local m = _g.jk.lang.Vector:getSize(hdrv)
					do
						n = 0
						while n < m do
							local hdr = hdrv[n + 1]
							if hdr ~= nil then
								if _g.jk.lang.String:equalsIgnoreCase(hdr.key, "content-type") then
									local vv = hdr.value
									if vv ~= nil then
										local sc = _g.jk.lang.String:getIndexOfCharacter(vv, 59, 0)
										if sc < 0 then
											mimeType = vv
										else
											mimeType = _g.jk.lang.String:getEndOfString(vv, sc)
										end
									end
								end
							end
							do n = n + 1 end
						end
					end
				end
				do contextf:getImageForBuffer(rbody, mimeType, function(imgo)
					if not (imgo ~= nil) then
						do _g.jk.log.Log:error(contextf, "WebImageWidget" .. ": Failed to create image from the returned data") end
						if ecb ~= nil then
							do ecb(_g.jk.lang.Error:forCode("failedToCreateImage", nil)) end
						end
						do return end
					end
					do cb(imgo) end
				end) end
			end
		end) end
	end
end

function jk.widget.web.WebImageWidget:getWidgetUseOverlay()
	do return self.widgetUseOverlay end
end

function jk.widget.web.WebImageWidget:setWidgetUseOverlay(v)
	self.widgetUseOverlay = v
	do return self end
end

jk.widget.web.CachingWebImageWidget = _g.jk.widget.web.WebImageWidget._create()
jk.widget.web.CachingWebImageWidget.__index = jk.widget.web.CachingWebImageWidget
_vm:set_metatable(jk.widget.web.CachingWebImageWidget, {
	__index = _g.jk.widget.web.WebImageWidget
})

jk.widget.web.CachingWebImageWidget.cacheMap = nil
jk.widget.web.CachingWebImageWidget.ttl = 60 * 5

function jk.widget.web.CachingWebImageWidget._create()
	local v = _vm:set_metatable({}, jk.widget.web.CachingWebImageWidget)
	return v
end

function jk.widget.web.CachingWebImageWidget:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.web.CachingWebImageWidget'
	self['_isType.jk.widget.web.CachingWebImageWidget'] = true
	self.widgetImageRounded = false
end

function jk.widget.web.CachingWebImageWidget:_construct0()
	jk.widget.web.CachingWebImageWidget._init(self)
	do _g.jk.widget.web.WebImageWidget._construct0(self) end
	return self
end

function jk.widget.web.CachingWebImageWidget:_construct1(context)
	jk.widget.web.CachingWebImageWidget._init(self)
	do _g.jk.widget.web.WebImageWidget._construct1(self, context) end
	return self
end

jk.widget.web.CachingWebImageWidget.CachedImage = {}
jk.widget.web.CachingWebImageWidget.CachedImage.__index = jk.widget.web.CachingWebImageWidget.CachedImage
_vm:set_metatable(jk.widget.web.CachingWebImageWidget.CachedImage, {})

function jk.widget.web.CachingWebImageWidget.CachedImage._create()
	local v = _vm:set_metatable({}, jk.widget.web.CachingWebImageWidget.CachedImage)
	return v
end

function jk.widget.web.CachingWebImageWidget.CachedImage:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'jk.widget.web.CachingWebImageWidget.CachedImage'
	self['_isType.jk.widget.web.CachingWebImageWidget.CachedImage'] = true
	self.image = nil
	self.timeStamp = 0
	self.ttl = 0
	self.queue = nil
end

function jk.widget.web.CachingWebImageWidget.CachedImage:_construct0()
	jk.widget.web.CachingWebImageWidget.CachedImage._init(self)
	self.queue = {}
	self.timeStamp = _g.jk.time.SystemClock:asSeconds()
	return self
end

function jk.widget.web.CachingWebImageWidget.CachedImage:isAvailable()
	do return self.image ~= nil and _g.jk.time.SystemClock:asSeconds() - self.timeStamp < self.ttl end
end

function jk.widget.web.CachingWebImageWidget.CachedImage:push(callback)
	do _g.jk.lang.Vector:append(self.queue, callback) end
end

function jk.widget.web.CachingWebImageWidget.CachedImage:pop()
	do return _g.jk.lang.Vector:popFirst(self.queue) end
end

function jk.widget.web.CachingWebImageWidget.CachedImage:checkTTL()
	if _g.jk.time.SystemClock:asSeconds() - self.timeStamp >= self.ttl then
		self.timeStamp = _g.jk.time.SystemClock:asSeconds()
		self.image = nil
	end
end

function jk.widget.web.CachingWebImageWidget.CachedImage:getImage()
	do return self.image end
end

function jk.widget.web.CachingWebImageWidget.CachedImage:setImage(v)
	self.image = v
	do return self end
end

function jk.widget.web.CachingWebImageWidget.CachedImage:getTimeStamp()
	do return self.timeStamp end
end

function jk.widget.web.CachingWebImageWidget.CachedImage:setTimeStamp(v)
	self.timeStamp = v
	do return self end
end

function jk.widget.web.CachingWebImageWidget.CachedImage:getTtl()
	do return self.ttl end
end

function jk.widget.web.CachingWebImageWidget.CachedImage:setTtl(v)
	self.ttl = v
	do return self end
end

function jk.widget.web.CachingWebImageWidget:setTTL(seconds)
	if not (seconds >= 60) then
		do return end
	end
	_g.jk.widget.web.CachingWebImageWidget.ttl = seconds
end

function jk.widget.web.CachingWebImageWidget:removeCachedImage(url, rounded)
	if not (_g.jk.widget.web.CachingWebImageWidget.cacheMap ~= nil and _g.jk.lang.String:isNotEmpty(url)) then
		do return end
	end
	do
		local key = (function(a, b, c)
			if a then
				do return b() end
			end
			do return c() end
		end)(rounded, function()
			do return _g.jk.lang.String:safeString(url) .. "_rounded" end
		end, function()
			do return _g.jk.lang.String:safeString(url) .. "_raw" end
		end)
		do _g.jk.widget.web.CachingWebImageWidget.cacheMap:remove(key) end
	end
end

function jk.widget.web.CachingWebImageWidget:queryImage(context, url, headers, body, rounded, callback, errorCallback)
	if not (_g.jk.widget.web.CachingWebImageWidget.cacheMap ~= nil) then
		_g.jk.widget.web.CachingWebImageWidget.cacheMap = _g.jk.lang.DynamicMap._construct0(_g.jk.lang.DynamicMap._create())
	end
	do
		local key = (function(a, b, c)
			if a then
				do return b() end
			end
			do return c() end
		end)(rounded, function()
			do return _g.jk.lang.String:safeString(url) .. "_rounded" end
		end, function()
			do return _g.jk.lang.String:safeString(url) .. "_raw" end
		end)
		local cachedImage = _vm:to_table_with_key(_g.jk.widget.web.CachingWebImageWidget.cacheMap:get(key), '_isType.jk.widget.web.CachingWebImageWidget.CachedImage')
		if not (cachedImage ~= nil) then
			cachedImage = _g.jk.widget.web.CachingWebImageWidget.CachedImage._construct0(_g.jk.widget.web.CachingWebImageWidget.CachedImage._create())
			do cachedImage:setTtl(_g.jk.widget.web.CachingWebImageWidget.ttl) end
			do _g.jk.widget.web.CachingWebImageWidget.cacheMap:setObject(key, cachedImage) end
		end
		do cachedImage:checkTTL() end
		if cachedImage:isAvailable() then
			do callback(cachedImage:getImage()) end
			do return end
		end
		do cachedImage:push(callback) end
		do
			local client = _g.jk.web.NativeWebClient:instance()
			if not (client ~= nil) then
				do _g.jk.log.Log:error(context, "Failed to create web client.") end
				if errorCallback ~= nil then
					do errorCallback(_g.jk.lang.Error:forCode("noWebClient", nil)) end
				end
				do return end
			end
			do _g.jk.log.Log:debug(context, "CachingWebImageWidget" .. ": Start loading image: `" .. _g.jk.lang.String:safeString(url) .. "'") end
			do
				local cif = cachedImage
				local roundedf = rounded
				local invokeCallback = function(cache)
					if not (cache ~= nil) then
						do return end
					end
					while true do
						local cb = cache:pop()
						if not (cb ~= nil) then
							do break end
						end
						do cb(cache:getImage()) end
					end
				end
				do _g.jk.widget.web.WebImageWidget:doQueryImage(context, url, headers, body, function(image)
					if roundedf then
						do _g.jk.ui.ImageUtil:createCircularImage(image, function(newImage)
							do cif:setImage(newImage) end
							do invokeCallback(cif) end
						end) end
					else
						do cif:setImage(image) end
						do invokeCallback(cif) end
					end
				end, errorCallback) end
			end
		end
	end
end

function jk.widget.web.CachingWebImageWidget:setWidgetImageUrl2(url, headers, body, callback)
	local img = self:onStartLoading(self:getWidgetUseOverlay())
	local cb = callback
	do _g.jk.widget.web.CachingWebImageWidget:queryImage(self.context, url, headers, body, self.widgetImageRounded, function(imgo)
		do self:onEndLoading() end
		do img:setWidgetImage(imgo) end
	end, function(error)
		do self:onEndLoading() end
		if cb ~= nil then
			do cb(error) end
		end
	end) end
end

function jk.widget.web.CachingWebImageWidget:getWidgetImageRounded()
	do return self.widgetImageRounded end
end

function jk.widget.web.CachingWebImageWidget:setWidgetImageRounded(v)
	self.widgetImageRounded = v
	do return self end
end
app = app or {}

app.MainScreen = _g.jk.widget.ScreenForWidget._create()
app.MainScreen.__index = app.MainScreen
_vm:set_metatable(app.MainScreen, {
	__index = _g.jk.widget.ScreenForWidget
})

function app.MainScreen._create()
	local v = _vm:set_metatable({}, app.MainScreen)
	return v
end

function app.MainScreen:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'app.MainScreen'
	self['_isType.app.MainScreen'] = true
	self.navi = nil
end

function app.MainScreen:_construct0()
	app.MainScreen._init(self)
	do _g.jk.widget.ScreenForWidget._construct0(self) end
	return self
end

function app.MainScreen:initialize()
	do _g.jk.widget.ScreenForWidget.initialize(self) end
	self.navi = _g.jk.widget.common.NavigationWidget._construct1(_g.jk.widget.common.NavigationWidget._create(), self.context)
	do self.navi:setWidgetEnableActionBar(false) end
	do self:setWidget(self.navi) end
	do _g.app.APIClient:create(self.context, self.navi) end
	do self.navi:pushWidget(_g.app.Tasklist._construct1(_g.app.Tasklist._create(), self.context)) end
end

app.Tasklist = _g.jk.widget.LayerWidget._create()
app.Tasklist.__index = app.Tasklist
_vm:set_metatable(app.Tasklist, {
	__index = _g.jk.widget.LayerWidget
})

function app.Tasklist._create()
	local v = _vm:set_metatable({}, app.Tasklist)
	return v
end

function app.Tasklist:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'app.Tasklist'
	self['_isType.app.Tasklist'] = true
	self['_isType.jk.widget.TitledWidget'] = true
	self.container = nil
	self.list = nil
end

function app.Tasklist:_construct0()
	app.Tasklist._init(self)
	do _g.jk.widget.LayerWidget._construct0(self) end
	return self
end

function app.Tasklist:_construct1(context)
	app.Tasklist._init(self)
	do _g.jk.widget.LayerWidget._construct1(self, context) end
	return self
end

function app.Tasklist:initializeWidget()
	do _g.jk.widget.LayerWidget.initializeWidget(self) end
	do _g.app.APIClient:getInstance():getTasks(function(response)
		local data = response:getDynamicMap("data")
		if not (data ~= nil) then
			do return end
		end
		do
			local records = data:getDynamicVector("records")
			if not (records ~= nil) or records:getSize() < 1 then
				do self.list:addWidget1(_g.jk.widget.AlignWidget:forWidget(self.context, _g.jk.widget.LabelWidget:forText(self.context, "No records"), 0.5, 0.5, 0), 1.0) end
			else
				local array = records:toVector()
				if array ~= nil then
					local n = 0
					local m = _g.jk.lang.Vector:getSize(array)
					do
						n = 0
						while n < m do
							local record = _vm:to_table_with_key(array[n + 1], '_isType.jk.lang.DynamicMap')
							if record ~= nil then
								local task = _g.jk.lang.String:safeString(record:getString("name", nil)) .. " - " .. _g.jk.lang.String:safeString(record:getString("unknown", nil))
								local lblTask = _g.jk.widget.LabelWidget:forText(self.context, task)
								local hbox = _g.jk.widget.HorizontalBoxWidget:forContext(self.context, 0, self.context:getHeightValue("0.5mm"))
								do hbox:addWidget(lblTask) end
								do self.list:addWidget1(_g.jk.widget.AlignWidget:forWidget(self.context, hbox, 0.5, 0.5, 0), 1.0) end
							end
							do n = n + 1 end
						end
					end
				end
			end
		end
	end, nil) end
end

function app.Tasklist:getWidgetTitle()
	do return "Task list" end
end

function app.Tasklist:createWidget()
	do _g.jk.widget.LayerWidget.createWidget(self) end
	do
		local thisWidget = self
		local widget = _g.jk.widget.VerticalScrollerWidget._construct1(_g.jk.widget.VerticalScrollerWidget._create(), self.context)
		do widget:setWidgetScrollBarDisabled(true) end
		self.container = _g.jk.widget.LayerWithBackgroundColorWidget._construct1(_g.jk.widget.LayerWithBackgroundColorWidget._create(), self.context)
		do self.container:setWidgetColor(_g.jk.gfx.Color:white()) end
		self.list = _g.jk.widget.VerticalBoxWidget._construct1(_g.jk.widget.VerticalBoxWidget._create(), self.context)
		do self.list:setWidgetMargin(self.context:getHeightValue("5mm")) end
		do self.list:setWidgetSpacing(self.context:getHeightValue("5mm")) end
		do self.container:addWidget(self.list) end
		do widget:addWidget(self.container) end
		do self:addWidget(widget) end
	end
end

app.APIClient = _g.jk.widget.web.JSONAPIClientWithGui._create()
app.APIClient.__index = app.APIClient
_vm:set_metatable(app.APIClient, {
	__index = _g.jk.widget.web.JSONAPIClientWithGui
})

app.APIClient.instance = nil

function app.APIClient._create()
	local v = _vm:set_metatable({}, app.APIClient)
	return v
end

function app.APIClient:_init()
	self._isClassInstance = true
	self._qualifiedClassName = self._qualifiedClassName or 'app.APIClient'
	self['_isType.app.APIClient'] = true
	self.widgetDefaultErrorHandler = nil
end

function app.APIClient:_construct0()
	app.APIClient._init(self)
	do _g.jk.widget.web.JSONAPIClientWithGui._construct0(self) end
	return self
end

function app.APIClient:getInstance()
	do return _g.app.APIClient.instance end
end

function app.APIClient:create(context, parentWidget)
	if not (context ~= nil) then
		do return nil end
	end
	_g.app.APIClient.instance = _g.app.APIClient._construct0(_g.app.APIClient._create())
	do _g.app.APIClient.instance:setApiUrl("http://ec2-54-254-54-51.ap-southeast-1.compute.amazonaws.com:30041") end
	do _g.app.APIClient.instance:setContext(context) end
	if parentWidget ~= nil then
		do _g.app.APIClient.instance:setParentWidget(parentWidget) end
	end
	do return _g.app.APIClient.instance end
end

function app.APIClient:onError1(error, callback)
	if not (callback ~= nil) then
		do self:onDefaultErrorHandler(error) end
		do return end
	end
	do _g.jk.widget.web.JSONAPIClientWithGui.onError1(self, error, callback) end
end

function app.APIClient:onDefaultErrorHandler(error)
	local context = self:getContext()
	if not (context ~= nil) then
		do return end
	end
	if not (error ~= nil) then
		do return end
	end
	if not (self.widgetDefaultErrorHandler ~= nil) then
		do context:showErrorDialog(error:toString(), nil) end
		do return end
	end
	do self.widgetDefaultErrorHandler(error) end
end

function app.APIClient:addTask(data, callback, errorCallback)
	do self:doPost("/task ", data, callback, errorCallback) end
end

function app.APIClient:updateTask(id, data, callback, errorCallback)
	do self:doPut("/task " .. _g.jk.lang.String:safeString(id), data, callback, errorCallback) end
end

function app.APIClient:deleteTask(id, callback, errorCallback)
	do self:doDelete("/task " .. _g.jk.lang.String:safeString(id), callback, errorCallback) end
end

function app.APIClient:getTasks(callback, errorCallback)
	do self:doGet("/task ", callback, errorCallback) end
end

function app.APIClient:getWidgetDefaultErrorHandler()
	do return self.widgetDefaultErrorHandler end
end

function app.APIClient:setWidgetDefaultErrorHandler(v)
	self.widgetDefaultErrorHandler = v
	do return self end
end
