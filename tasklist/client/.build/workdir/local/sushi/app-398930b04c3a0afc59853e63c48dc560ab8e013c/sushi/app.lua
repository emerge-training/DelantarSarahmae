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
