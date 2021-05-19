let AppAddNotelistappNote = function() {
	JkJsonJSONObjectAdapter.call(this);
	this._fullname = null;
	this._surname = null;
};

AppAddNotelistappNote.prototype = (function(o) { function F() {}; F.prototype = o; return(new F()); }) (JkJsonJSONObjectAdapter.prototype);
AppAddNotelistappNote.prototype.constructor = AppAddNotelistappNote;
AppAddNotelistappNote.prototype._t = {
	"AppAddNotelistappNote" : true,
	"JkJsonJSONObjectAdapter" : true,
	"JkJsonJSONObject" : true,
	"JkLangStringObject" : true
};
AppAddNotelistappNote.prototype._tobj = AppAddNotelistappNote;

AppAddNotelistappNote.NEW = function() {
	var v = new AppAddNotelistappNote;
	return v.CTOR_AppAddNotelistappNote();
};

AppAddNotelistappNote.prototype.CTOR_AppAddNotelistappNote = function() {
	this._surname = null;
	this._fullname = null;
	if(JkJsonJSONObjectAdapter.prototype.CTOR_JkJsonJSONObjectAdapter.call(this) == null) {
		return null;
	}
	return this;
};

AppAddNotelistappNote.prototype.setFullname = function(value) {
	this._fullname = value;
	return this;
};

AppAddNotelistappNote.prototype.getFullname = function() {
	return this._fullname;
};

AppAddNotelistappNote.prototype.setSurname = function(value) {
	this._surname = value;
	return this;
};

AppAddNotelistappNote.prototype.getSurname = function() {
	return this._surname;
};

AppAddNotelistappNote.prototype.toJsonObject = function() {
	var v = JkLangDynamicMap.NEW();
	if(this._fullname != null) {
		v.setObject("fullname", (this.asJsonValue(this._fullname)));
	}
	if(this._surname != null) {
		v.setObject("surname", (this.asJsonValue(this._surname)));
	}
	return v;
};

AppAddNotelistappNote.prototype.fromJsonObject = function(o1) {
	var v = (function(o) {
		if(JkLangDynamicMap.IS_INSTANCE && JkLangDynamicMap.IS_INSTANCE(o)) {
			return o;
		}
		return null;
	}.bind(this))(o1);
	if(!(v != null)) {
		return false;
	}
	this._fullname = v.getString("fullname", null);
	this._surname = v.getString("surname", null);
	return true;
};

AppAddNotelistappNote.prototype.fromJsonString = function(o) {
	return this.fromJsonObject((JkJsonJSONParser.parse(o)));
};

AppAddNotelistappNote.prototype.toJsonString = function() {
	return JkJsonJSONEncoder.encode((this.toJsonObject()), true, false);
};

AppAddNotelistappNote.prototype.toString = function() {
	return this.toJsonString();
};

AppAddNotelistappNote.forJsonString = function(o) {
	var v = AppAddNotelistappNote.NEW();
	if(!v.fromJsonString(o)) {
		return null;
	}
	return v;
};

AppAddNotelistappNote.forJsonObject = function(o) {
	var v = AppAddNotelistappNote.NEW();
	if(!v.fromJsonObject(o)) {
		return null;
	}
	return v;
};

AppAddNotelistappNote.IS_INSTANCE = function(o) {
	return o != null && o._t != null && o._t["AppAddNotelistappNote"] === true;
};

let AppAddNotelistapp = function() {
	JkWidgetVerticalBoxWidget.call(this);
	this.Viewbtn = null;
	this.container = null;
	this.vbox = null;
	this.fullname = null;
	this.surname = null;
};

AppAddNotelistapp.prototype = (function(o) { function F() {}; F.prototype = o; return(new F()); }) (JkWidgetVerticalBoxWidget.prototype);
AppAddNotelistapp.prototype.constructor = AppAddNotelistapp;
AppAddNotelistapp.prototype._t = {
	"JkWidgetParentAwareWidget" : true,
	"JkWidgetVerticalBoxWidget" : true,
	"JkWidgetWidget" : true,
	"AppAddNotelistapp" : true,
	"JkWidgetHeightAwareWidget" : true,
	"JkWidgetContainerWidget" : true,
	"JkWidgetWidgetWithLayout" : true
};
AppAddNotelistapp.prototype._tobj = AppAddNotelistapp;

AppAddNotelistapp.NEW_JkUiGuiApplicationContext = function(context) {
	var v = new AppAddNotelistapp;
	return v.CTOR_AppAddNotelistapp_JkUiGuiApplicationContext(context);
};

AppAddNotelistapp.prototype.CTOR_AppAddNotelistapp_JkUiGuiApplicationContext = function(context) {
	this.surname = null;
	this.fullname = null;
	this.vbox = null;
	this.container = null;
	this.Viewbtn = null;
	if(JkWidgetVerticalBoxWidget.prototype.CTOR_JkWidgetVerticalBoxWidget_JkUiGuiApplicationContext.call(this, context) == null) {
		return null;
	}
	return this;
};

AppAddNotelistapp.prototype.onViewClicked = function() {
	JkWidgetCommonNavigationWidget.switchToContainer(this, (AppNotelistapp.NEW_JkUiGuiApplicationContext(this.context)));
};

AppAddNotelistapp.prototype.initializeWidget = function() {
	JkWidgetVerticalBoxWidget.prototype.initializeWidget.call(this);
	var savebtn = JkWidgetCommonButtonWidget.forText(this.context, "SAVE", (function() {
		var note = AppAddNotelistappNote.NEW();
		note.setFullname((this.fullname.getWidgetText()));
		note.setSurname((this.surname.getWidgetText()));
		AppAPIClient.getInstance().addNotelistapp((note.toDynamicMap()), (function(response1) {
			this.context.showMessageDialog("Notice", "Recorded", null);
			this.fullname.setWidgetText("");
			this.surname.setWidgetText("");
		}.bind(this)), (function(error1) {
			this.context.showMessageDialog("Notice", "Record Failed!", null);
		}.bind(this)));
	}.bind(this)));
	savebtn.setWidgetFontSize((this.context.getHeightValue("4mm")));
	this.vbox.addWidget(savebtn);
};

AppAddNotelistapp.prototype.createWidget = function() {
	JkWidgetVerticalBoxWidget.prototype.createWidget.call(this);
	var thisWidget = this;
	this.setWidgetSpacing((this.context.getHeightValue("2000um")));
	this.setWidgetMargin((this.context.getHeightValue("5mm")));
	var widget = JkWidgetHorizontalBoxWidget.NEW_JkUiGuiApplicationContext(this.context);
	widget.setWidgetSpacing((this.context.getHeightValue("100um")));
	this.Viewbtn = JkWidgetCommonTextButtonWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.Viewbtn.setWidgetText("List of Participants");
	this.Viewbtn.setWidgetPadding((this.context.getHeightValue("1000um")));
	this.Viewbtn.setWidgetBackgroundColor((JkGfxColor.instance("#F2eded")));
	this.Viewbtn.setWidgetClickHandler((function() {
		this.onViewClicked();
	}.bind(this)));
	widget.addWidget1(this.Viewbtn, 1.0);
	this.addWidget(widget);
	var widget2 = JkWidgetVerticalScrollerWidget.NEW_JkUiGuiApplicationContext(this.context);
	widget2.setWidgetScrollBarDisabled(true);
	this.container = JkWidgetLayerWithBackgroundColorWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.container.setWidgetColor((JkGfxColor.instance("#F2eded")));
	var widget3 = JkWidgetAlignWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.vbox = JkWidgetVerticalBoxWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.vbox.setWidgetMargin((this.context.getHeightValue("5mm")));
	this.vbox.setWidgetSpacing((this.context.getHeightValue("2000um")));
	this.fullname = JkWidgetCommonTextInputWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.fullname.setWidgetType(JkWidgetCommonTextInputWidget.TYPE_NAME);
	this.fullname.setWidgetPlaceholder("Fullname");
	this.fullname.setWidgetBackgroundColor((JkGfxColor.white()));
	this.fullname.setWidgetFontSize((this.context.getHeightValue("2mm")));
	this.fullname.setWidgetPadding1((this.context.getHeightValue("2500um")));
	this.vbox.addWidget(this.fullname);
	this.surname = JkWidgetCommonTextInputWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.surname.setWidgetType(JkWidgetCommonTextInputWidget.TYPE_NAME);
	this.surname.setWidgetPlaceholder("SURNAME");
	this.surname.setWidgetBackgroundColor((JkGfxColor.white()));
	this.surname.setWidgetFontSize((this.context.getHeightValue("2mm")));
	this.surname.setWidgetPadding1((this.context.getHeightValue("2500um")));
	this.vbox.addWidget(this.surname);
	widget3.addWidget1(this.vbox, 0.5, 0.5, false);
	this.container.addWidget(widget3);
	widget2.addWidget(this.container);
	this.addWidget(widget2);
};

AppAddNotelistapp.IS_INSTANCE = function(o) {
	return o != null && o._t != null && o._t["AppAddNotelistapp"] === true;
};

let AppAPIClient = function() {
	JkWidgetWebJSONAPIClientWithGui.call(this);
	this.widgetDefaultErrorHandler = null;
};

AppAPIClient.prototype = (function(o) { function F() {}; F.prototype = o; return(new F()); }) (JkWidgetWebJSONAPIClientWithGui.prototype);
AppAPIClient.prototype.constructor = AppAPIClient;
AppAPIClient.prototype._t = {
	"JkWebJsonJSONAPIClient" : true,
	"AppAPIClient" : true,
	"JkWidgetWebJSONAPIClientWithGui" : true
};
AppAPIClient.prototype._tobj = AppAPIClient;

AppAPIClient.NEW = function() {
	var v = new AppAPIClient;
	return v.CTOR_AppAPIClient();
};

AppAPIClient.prototype.CTOR_AppAPIClient = function() {
	this.widgetDefaultErrorHandler = null;
	if(JkWidgetWebJSONAPIClientWithGui.prototype.CTOR_JkWidgetWebJSONAPIClientWithGui.call(this) == null) {
		return null;
	}
	return this;
};

AppAPIClient.getInstance = function() {
	return AppAPIClient.instance;
};

AppAPIClient.create = function(context, parentWidget) {
	if(!(context != null)) {
		return null;
	}
	AppAPIClient.instance = AppAPIClient.NEW();
	AppAPIClient.instance.setApiUrl("http://ec2-13-228-75-243.ap-southeast-1.compute.amazonaws.com:30111");
	AppAPIClient.instance.setContext(context);
	if(parentWidget != null) {
		AppAPIClient.instance.setParentWidget(parentWidget);
	}
	return AppAPIClient.instance;
};

AppAPIClient.prototype.onError1 = function(error, callback) {
	if(!(callback != null)) {
		this.onDefaultErrorHandler(error);
		return;
	}
	JkWidgetWebJSONAPIClientWithGui.prototype.onError1.call(this, error, callback);
};

AppAPIClient.prototype.onDefaultErrorHandler = function(error) {
	var context = this.getContext();
	if(!(context != null)) {
		return;
	}
	if(!(error != null)) {
		return;
	}
	if(!(this.widgetDefaultErrorHandler != null)) {
		context.showErrorDialog((error.toString()), null);
		return;
	}
	this.widgetDefaultErrorHandler(error);
};

AppAPIClient.prototype.addNotelistapp = function(data, callback, errorCallback) {
	this.doPost("/notelistapp ", data, callback, errorCallback);
};

AppAPIClient.prototype.updateNotelistapp = function(id, data, callback, errorCallback) {
	this.doPut("/notelistapp/" + (JkLangString.safeString(id)), data, callback, errorCallback);
};

AppAPIClient.prototype.deleteNotelistapp = function(id, callback, errorCallback) {
	this.doDelete("/notelistapp/" + (JkLangString.safeString(id)), callback, errorCallback);
};

AppAPIClient.prototype.getNotelistapp = function(callback, errorCallback) {
	this.doGet("/notelistapp ", callback, errorCallback);
};

AppAPIClient.prototype.getWidgetDefaultErrorHandler = function() {
	return this.widgetDefaultErrorHandler;
};

AppAPIClient.prototype.setWidgetDefaultErrorHandler = function(v) {
	this.widgetDefaultErrorHandler = v;
	return this;
};

AppAPIClient.IS_INSTANCE = function(o) {
	return o != null && o._t != null && o._t["AppAPIClient"] === true;
};

AppAPIClient.instance = null;

let AppUpdateNotelistappNote = function() {
	JkJsonJSONObjectAdapter.call(this);
	this._fullname = null;
	this._surname = null;
};

AppUpdateNotelistappNote.prototype = (function(o) { function F() {}; F.prototype = o; return(new F()); }) (JkJsonJSONObjectAdapter.prototype);
AppUpdateNotelistappNote.prototype.constructor = AppUpdateNotelistappNote;
AppUpdateNotelistappNote.prototype._t = {
	"JkLangStringObject" : true,
	"JkJsonJSONObjectAdapter" : true,
	"JkJsonJSONObject" : true,
	"AppUpdateNotelistappNote" : true
};
AppUpdateNotelistappNote.prototype._tobj = AppUpdateNotelistappNote;

AppUpdateNotelistappNote.NEW = function() {
	var v = new AppUpdateNotelistappNote;
	return v.CTOR_AppUpdateNotelistappNote();
};

AppUpdateNotelistappNote.prototype.CTOR_AppUpdateNotelistappNote = function() {
	this._surname = null;
	this._fullname = null;
	if(JkJsonJSONObjectAdapter.prototype.CTOR_JkJsonJSONObjectAdapter.call(this) == null) {
		return null;
	}
	return this;
};

AppUpdateNotelistappNote.prototype.setFullname = function(value) {
	this._fullname = value;
	return this;
};

AppUpdateNotelistappNote.prototype.getFullname = function() {
	return this._fullname;
};

AppUpdateNotelistappNote.prototype.setSurname = function(value) {
	this._surname = value;
	return this;
};

AppUpdateNotelistappNote.prototype.getSurname = function() {
	return this._surname;
};

AppUpdateNotelistappNote.prototype.toJsonObject = function() {
	var v = JkLangDynamicMap.NEW();
	if(this._fullname != null) {
		v.setObject("fullname", (this.asJsonValue(this._fullname)));
	}
	if(this._surname != null) {
		v.setObject("surname", (this.asJsonValue(this._surname)));
	}
	return v;
};

AppUpdateNotelistappNote.prototype.fromJsonObject = function(o1) {
	var v = (function(o) {
		if(JkLangDynamicMap.IS_INSTANCE && JkLangDynamicMap.IS_INSTANCE(o)) {
			return o;
		}
		return null;
	}.bind(this))(o1);
	if(!(v != null)) {
		return false;
	}
	this._fullname = v.getString("fullname", null);
	this._surname = v.getString("surname", null);
	return true;
};

AppUpdateNotelistappNote.prototype.fromJsonString = function(o) {
	return this.fromJsonObject((JkJsonJSONParser.parse(o)));
};

AppUpdateNotelistappNote.prototype.toJsonString = function() {
	return JkJsonJSONEncoder.encode((this.toJsonObject()), true, false);
};

AppUpdateNotelistappNote.prototype.toString = function() {
	return this.toJsonString();
};

AppUpdateNotelistappNote.forJsonString = function(o) {
	var v = AppUpdateNotelistappNote.NEW();
	if(!v.fromJsonString(o)) {
		return null;
	}
	return v;
};

AppUpdateNotelistappNote.forJsonObject = function(o) {
	var v = AppUpdateNotelistappNote.NEW();
	if(!v.fromJsonObject(o)) {
		return null;
	}
	return v;
};

AppUpdateNotelistappNote.IS_INSTANCE = function(o) {
	return o != null && o._t != null && o._t["AppUpdateNotelistappNote"] === true;
};

let AppUpdateNotelistapp = function() {
	JkWidgetVerticalBoxWidget.call(this);
	this.btnHome = null;
	this.container = null;
	this.vbox = null;
	this.id = null;
	this.fullname = null;
	this.surname = null;
};

AppUpdateNotelistapp.prototype = (function(o) { function F() {}; F.prototype = o; return(new F()); }) (JkWidgetVerticalBoxWidget.prototype);
AppUpdateNotelistapp.prototype.constructor = AppUpdateNotelistapp;
AppUpdateNotelistapp.prototype._t = {
	"AppUpdateNotelistapp" : true,
	"JkWidgetParentAwareWidget" : true,
	"JkWidgetContainerWidget" : true,
	"JkWidgetWidget" : true,
	"JkWidgetHeightAwareWidget" : true,
	"JkWidgetVerticalBoxWidget" : true,
	"JkWidgetWidgetWithLayout" : true
};
AppUpdateNotelistapp.prototype._tobj = AppUpdateNotelistapp;

AppUpdateNotelistapp.NEW_JkUiGuiApplicationContext = function(context) {
	var v = new AppUpdateNotelistapp;
	return v.CTOR_AppUpdateNotelistapp_JkUiGuiApplicationContext(context);
};

AppUpdateNotelistapp.prototype.CTOR_AppUpdateNotelistapp_JkUiGuiApplicationContext = function(context) {
	this.surname = null;
	this.fullname = null;
	this.id = null;
	this.vbox = null;
	this.container = null;
	this.btnHome = null;
	if(JkWidgetVerticalBoxWidget.prototype.CTOR_JkWidgetVerticalBoxWidget_JkUiGuiApplicationContext.call(this, context) == null) {
		return null;
	}
	return this;
};

AppUpdateNotelistapp.prototype.initializeWidget = function() {
	JkWidgetVerticalBoxWidget.prototype.initializeWidget.call(this);
	var updatebtn = JkWidgetCommonButtonWidget.forText(this.context, "UPDATE", (function() {
		AppAPIClient.getInstance().getNotelistapp((function(response1) {
			var data = response1.getDynamicMap("data");
			if(!(data != null)) {
				return;
			}
			var records = data.getDynamicVector("records");
			var array = records.toVector();
			if(array != null) {
				var n = 0;
				var m = array.length;
				for(n = 0 ; n < m ; n++) {
					var record = (function(o) {
						if(JkLangDynamicMap.IS_INSTANCE && JkLangDynamicMap.IS_INSTANCE(o)) {
							return o;
						}
						return null;
					}.bind(this))(array[n]);
					if(record != null) {
						if(record.getString("id", null) == this.id.getWidgetText()) {
							var note = AppUpdateNotelistappNote.NEW();
							var popup = JkWidgetCommonPopupDialogManager.NEW_JkUiGuiApplicationContextJkWidgetWidget(this.context, this);
							popup.showConfirmDialog("Confirmation", "Sure to Update ?", (function() {
								note.setFullname((this.fullname.getWidgetText()));
								note.setSurname((this.surname.getWidgetText()));
								AppAPIClient.getInstance().updateNotelistapp((this.id.getWidgetText()), (note.toDynamicMap()), (function(res1) {
									this.context.showMessageDialog("Notice", "Successfully updated!", null);
									this.id.setWidgetText("");
									this.fullname.setWidgetText("");
									this.surname.setWidgetText("");
								}.bind(this)), (function(err1) {
									this.context.showMessageDialog("Notice", "Failed!", null);
								}.bind(this)));
							}.bind(this)), (function() {
								;
							}.bind(this)));
						}
					}
				}
			}
		}.bind(this)), null);
	}.bind(this)));
	updatebtn.setWidgetFontSize((this.context.getHeightValue("4mm")));
	updatebtn.setWidgetBackgroundColor((JkGfxColor.instance("#6aeb7f")));
	this.vbox.addWidget(updatebtn);
};

AppUpdateNotelistapp.prototype.createWidget = function() {
	JkWidgetVerticalBoxWidget.prototype.createWidget.call(this);
	var thisWidget = this;
	this.setWidgetSpacing((this.context.getHeightValue("2000um")));
	this.setWidgetMargin((this.context.getHeightValue("5mm")));
	var widget = JkWidgetHorizontalBoxWidget.NEW_JkUiGuiApplicationContext(this.context);
	widget.setWidgetSpacing((this.context.getHeightValue("100um")));
	this.btnHome = JkWidgetCommonTextButtonWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.btnHome.setWidgetText("View Participants");
	this.btnHome.setWidgetPadding((this.context.getHeightValue("1000um")));
	this.btnHome.setWidgetBackgroundColor((JkGfxColor.instance("#ffffff")));
	this.btnHome.setWidgetClickHandler((function() {
		JkWidgetCommonNavigationWidget.switchToContainer(this, (AppNotelistapp.NEW_JkUiGuiApplicationContext(this.context)));
	}.bind(this)));
	widget.addWidget1(this.btnHome, 1.0);
	this.addWidget(widget);
	var widget2 = JkWidgetVerticalScrollerWidget.NEW_JkUiGuiApplicationContext(this.context);
	widget2.setWidgetScrollBarDisabled(true);
	this.container = JkWidgetLayerWithBackgroundColorWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.container.setWidgetColor((JkGfxColor.instance("#F2eded")));
	var widget3 = JkWidgetAlignWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.vbox = JkWidgetVerticalBoxWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.vbox.setWidgetMargin((this.context.getHeightValue("5mm")));
	this.vbox.setWidgetSpacing((this.context.getHeightValue("2000um")));
	var widget4 = JkWidgetLabelWidget.NEW_JkUiGuiApplicationContext(this.context);
	widget4.setWidgetText("UPDATING NOTELISTAPP");
	widget4.setWidgetTextColor((JkGfxColor.black()));
	widget4.setWidgetFontSize((this.context.getHeightValue("4mm")));
	widget4.setWidgetTextAlign(JkWidgetLabelWidget.ALIGN_CENTER);
	widget4.setWidgetFontBold(true);
	this.vbox.addWidget(widget4);
	this.id = JkWidgetCommonTextInputWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.id.setWidgetType(JkWidgetCommonTextInputWidget.TYPE_INTEGER);
	this.id.setWidgetPlaceholder("Id");
	this.id.setWidgetBackgroundColor((JkGfxColor.white()));
	this.id.setWidgetFontSize((this.context.getHeightValue("2mm")));
	this.id.setWidgetPadding1((this.context.getHeightValue("2500um")));
	this.vbox.addWidget(this.id);
	this.fullname = JkWidgetCommonTextInputWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.fullname.setWidgetType(JkWidgetCommonTextInputWidget.TYPE_NAME);
	this.fullname.setWidgetPlaceholder("Fullname");
	this.fullname.setWidgetBackgroundColor((JkGfxColor.white()));
	this.fullname.setWidgetFontSize((this.context.getHeightValue("2mm")));
	this.fullname.setWidgetPadding1((this.context.getHeightValue("2500um")));
	this.vbox.addWidget(this.fullname);
	this.surname = JkWidgetCommonTextInputWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.surname.setWidgetType(JkWidgetCommonTextInputWidget.TYPE_NAME);
	this.surname.setWidgetPlaceholder("Surname");
	this.surname.setWidgetBackgroundColor((JkGfxColor.white()));
	this.surname.setWidgetFontSize((this.context.getHeightValue("2mm")));
	this.surname.setWidgetPadding1((this.context.getHeightValue("2500um")));
	this.vbox.addWidget(this.surname);
	widget3.addWidget1(this.vbox, 0.5, 0.5, false);
	this.container.addWidget(widget3);
	widget2.addWidget(this.container);
	this.addWidget(widget2);
};

AppUpdateNotelistapp.IS_INSTANCE = function(o) {
	return o != null && o._t != null && o._t["AppUpdateNotelistapp"] === true;
};

let AppNotelistapp = function() {
	JkWidgetVerticalBoxWidget.call(this);
	this.addBtn = null;
	this.updateBtn = null;
	this.deleteBtn = null;
	this.container = null;
	this.vbox = null;
	this.grid = null;
};

AppNotelistapp.prototype = (function(o) { function F() {}; F.prototype = o; return(new F()); }) (JkWidgetVerticalBoxWidget.prototype);
AppNotelistapp.prototype.constructor = AppNotelistapp;
AppNotelistapp.prototype._t = {
	"JkWidgetParentAwareWidget" : true,
	"JkWidgetVerticalBoxWidget" : true,
	"JkWidgetWidget" : true,
	"JkWidgetWidgetWithLayout" : true,
	"JkWidgetHeightAwareWidget" : true,
	"JkWidgetContainerWidget" : true,
	"AppNotelistapp" : true
};
AppNotelistapp.prototype._tobj = AppNotelistapp;

AppNotelistapp.NEW_JkUiGuiApplicationContext = function(context) {
	var v = new AppNotelistapp;
	return v.CTOR_AppNotelistapp_JkUiGuiApplicationContext(context);
};

AppNotelistapp.prototype.CTOR_AppNotelistapp_JkUiGuiApplicationContext = function(context) {
	this.grid = null;
	this.vbox = null;
	this.container = null;
	this.deleteBtn = null;
	this.updateBtn = null;
	this.addBtn = null;
	if(JkWidgetVerticalBoxWidget.prototype.CTOR_JkWidgetVerticalBoxWidget_JkUiGuiApplicationContext.call(this, context) == null) {
		return null;
	}
	return this;
};

AppNotelistapp.prototype.initializeWidget = function() {
	JkWidgetVerticalBoxWidget.prototype.initializeWidget.call(this);
	this.grid.addColumn("ID", "id", 0.5, 0);
	this.grid.addColumn("Fullname", "fullname", 1.0, 0);
	this.grid.addColumn("Surname", "surname", 1.0, 0);
	this.grid.addWidgetHeaderRow();
	AppAPIClient.getInstance().getNotelistapp((function(response1) {
		var data = response1.getDynamicMap("data");
		if(!(data != null)) {
			return;
		}
		var records = data.getDynamicVector("records");
		if(!(records != null) || records.getSize() < 1) {
			this.grid.addRow(["No Records"], null, null);
		}
		else {
			var array = records.toVector();
			if(array != null) {
				var n = 0;
				var m = array.length;
				for(n = 0 ; n < m ; n++) {
					var record = (function(o) {
						if(JkLangDynamicMap.IS_INSTANCE && JkLangDynamicMap.IS_INSTANCE(o)) {
							return o;
						}
						return null;
					}.bind(this))(array[n]);
					if(record != null) {
						this.grid.addRow([record.getString("id", null), record.getString("fullname", null), record.getString("surname", null)], null, null);
					}
				}
			}
		}
	}.bind(this)), (function(err1) {
		this.grid.addRow(["Error"], null, null);
	}.bind(this)));
};

AppNotelistapp.prototype.onAddClicked = function() {
	JkWidgetCommonNavigationWidget.switchToContainer(this, (AppAddNotelistapp.NEW_JkUiGuiApplicationContext(this.context)));
};

AppNotelistapp.prototype.onUpdateClicked = function() {
	JkWidgetCommonNavigationWidget.switchToContainer(this, (AppUpdateNotelistapp.NEW_JkUiGuiApplicationContext(this.context)));
};

AppNotelistapp.prototype.onDeleteClicked = function() {
	JkWidgetCommonNavigationWidget.switchToContainer(this, (AppDeleteNotelistapp.NEW_JkUiGuiApplicationContext(this.context)));
};

AppNotelistapp.prototype.createWidget = function() {
	JkWidgetVerticalBoxWidget.prototype.createWidget.call(this);
	var thisWidget = this;
	this.setWidgetSpacing((this.context.getHeightValue("2000um")));
	this.setWidgetMargin((this.context.getHeightValue("5mm")));
	var widget = JkWidgetLabelWidget.NEW_JkUiGuiApplicationContext(this.context);
	widget.setWidgetText("NOTELIST APPLICATION");
	widget.setWidgetTextColor((JkGfxColor.black()));
	widget.setWidgetFontSize((this.context.getHeightValue("5mm")));
	widget.setWidgetTextAlign(JkWidgetLabelWidget.ALIGN_CENTER);
	widget.setWidgetFontBold(true);
	this.addWidget(widget);
	var widget2 = JkWidgetHorizontalBoxWidget.NEW_JkUiGuiApplicationContext(this.context);
	widget2.setWidgetSpacing((this.context.getHeightValue("100um")));
	this.addBtn = JkWidgetCommonTextButtonWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.addBtn.setWidgetText("ADDING NOTELISTAPP");
	this.addBtn.setWidgetPadding((this.context.getHeightValue("1000um")));
	this.addBtn.setWidgetBackgroundColor((JkGfxColor.instance("#F2eded")));
	this.addBtn.setWidgetClickHandler((function() {
		this.onAddClicked();
	}.bind(this)));
	widget2.addWidget1(this.addBtn, 1.0);
	this.updateBtn = JkWidgetCommonTextButtonWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.updateBtn.setWidgetText("UPDATING NOTELISTAPP");
	this.updateBtn.setWidgetPadding((this.context.getHeightValue("1000um")));
	this.updateBtn.setWidgetBackgroundColor((JkGfxColor.instance("#F2eded")));
	this.updateBtn.setWidgetClickHandler((function() {
		this.onUpdateClicked();
	}.bind(this)));
	widget2.addWidget1(this.updateBtn, 1.0);
	this.deleteBtn = JkWidgetCommonTextButtonWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.deleteBtn.setWidgetText("DELETING NOTELISTAPP");
	this.deleteBtn.setWidgetPadding((this.context.getHeightValue("1000um")));
	this.deleteBtn.setWidgetBackgroundColor((JkGfxColor.instance("#F2eded")));
	this.deleteBtn.setWidgetClickHandler((function() {
		this.onDeleteClicked();
	}.bind(this)));
	widget2.addWidget1(this.deleteBtn, 1.0);
	this.addWidget(widget2);
	var widget3 = JkWidgetVerticalScrollerWidget.NEW_JkUiGuiApplicationContext(this.context);
	widget3.setWidgetScrollBarDisabled(true);
	this.container = JkWidgetLayerWithBackgroundColorWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.container.setWidgetColor((JkGfxColor.instance("#F2eded")));
	var widget4 = JkWidgetAlignWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.vbox = JkWidgetVerticalBoxWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.vbox.setWidgetMargin((this.context.getHeightValue("40mm")));
	this.vbox.setWidgetSpacing((this.context.getHeightValue("2000um")));
	widget4.addWidget1(this.vbox, 0.5, 0.5, false);
	this.container.addWidget(widget4);
	this.grid = JkWidgetDatagridDataGridWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.grid.setWidgetCellPadding(1);
	this.container.addWidget(this.grid);
	widget3.addWidget(this.container);
	this.addWidget(widget3);
};

AppNotelistapp.IS_INSTANCE = function(o) {
	return o != null && o._t != null && o._t["AppNotelistapp"] === true;
};

let AppMainScreen = function() {
	JkWidgetScreenForWidget.call(this);
	this.navi = null;
};

AppMainScreen.prototype = (function(o) { function F() {}; F.prototype = o; return(new F()); }) (JkWidgetScreenForWidget.prototype);
AppMainScreen.prototype.constructor = AppMainScreen;
AppMainScreen.prototype._t = {
	"JkUiScreen" : true,
	"JkUiScreenWithContext" : true,
	"AppMainScreen" : true,
	"JkWidgetScreenForWidget" : true
};
AppMainScreen.prototype._tobj = AppMainScreen;

AppMainScreen.NEW = function() {
	var v = new AppMainScreen;
	return v.CTOR_AppMainScreen();
};

AppMainScreen.prototype.CTOR_AppMainScreen = function() {
	this.navi = null;
	if(JkWidgetScreenForWidget.prototype.CTOR_JkWidgetScreenForWidget.call(this) == null) {
		return null;
	}
	return this;
};

AppMainScreen.prototype.initialize = function() {
	JkWidgetScreenForWidget.prototype.initialize.call(this);
	this.navi = JkWidgetCommonNavigationWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.navi.setWidgetEnableActionBar(false);
	this.setWidget(this.navi);
	AppAPIClient.create(this.context, this.navi);
	this.navi.pushWidget((AppNotelistapp.NEW_JkUiGuiApplicationContext(this.context)));
};

AppMainScreen.main = function(args) {
	var context = JkUiGuiApplicationContextForHTML.NEW();
	var resources = [];
	context.prepareResources(resources, (function() {
		var main = AppMainScreen.NEW();
		if(JkUiScreenWithContext.IS_INSTANCE && JkUiScreenWithContext.IS_INSTANCE(main)) {
			main.setContext(context);
		}
		main.initialize();
	}.bind(this)));
	return 0;
};

AppMainScreen.main();

AppMainScreen.IS_INSTANCE = function(o) {
	return o != null && o._t != null && o._t["AppMainScreen"] === true;
};

let AppDeleteNotelistapp = function() {
	JkWidgetVerticalBoxWidget.call(this);
	this.btnHome = null;
	this.container = null;
	this.vbox = null;
	this.id = null;
};

AppDeleteNotelistapp.prototype = (function(o) { function F() {}; F.prototype = o; return(new F()); }) (JkWidgetVerticalBoxWidget.prototype);
AppDeleteNotelistapp.prototype.constructor = AppDeleteNotelistapp;
AppDeleteNotelistapp.prototype._t = {
	"JkWidgetParentAwareWidget" : true,
	"JkWidgetContainerWidget" : true,
	"JkWidgetWidget" : true,
	"AppDeleteNotelistapp" : true,
	"JkWidgetHeightAwareWidget" : true,
	"JkWidgetVerticalBoxWidget" : true,
	"JkWidgetWidgetWithLayout" : true
};
AppDeleteNotelistapp.prototype._tobj = AppDeleteNotelistapp;

AppDeleteNotelistapp.NEW_JkUiGuiApplicationContext = function(context) {
	var v = new AppDeleteNotelistapp;
	return v.CTOR_AppDeleteNotelistapp_JkUiGuiApplicationContext(context);
};

AppDeleteNotelistapp.prototype.CTOR_AppDeleteNotelistapp_JkUiGuiApplicationContext = function(context) {
	this.id = null;
	this.vbox = null;
	this.container = null;
	this.btnHome = null;
	if(JkWidgetVerticalBoxWidget.prototype.CTOR_JkWidgetVerticalBoxWidget_JkUiGuiApplicationContext.call(this, context) == null) {
		return null;
	}
	return this;
};

AppDeleteNotelistapp.prototype.initializeWidget = function() {
	JkWidgetVerticalBoxWidget.prototype.initializeWidget.call(this);
	var deletebtn = JkWidgetCommonButtonWidget.forText(this.context, "DELETE", (function() {
		AppAPIClient.getInstance().getNotelistapp((function(response1) {
			var data = response1.getDynamicMap("data");
			if(!(data != null)) {
				return;
			}
			var records = data.getDynamicVector("records");
			var array = records.toVector();
			if(array != null) {
				var n = 0;
				var m = array.length;
				for(n = 0 ; n < m ; n++) {
					var record = (function(o) {
						if(JkLangDynamicMap.IS_INSTANCE && JkLangDynamicMap.IS_INSTANCE(o)) {
							return o;
						}
						return null;
					}.bind(this))(array[n]);
					if(record != null) {
						if(record.getString("id", null) == this.id.getWidgetText()) {
							var popup = JkWidgetCommonPopupDialogManager.NEW_JkUiGuiApplicationContextJkWidgetWidget(this.context, this);
							popup.showConfirmDialog("Confirmation", "sure to delete?", (function() {
								AppAPIClient.getInstance().deleteNotelistapp((this.id.getWidgetText()), (function(res1) {
									this.context.showMessageDialog("Notice", "Successfully deleted!", null);
									this.id.setWidgetText("");
								}.bind(this)), (function(err1) {
									this.context.showMessageDialog("Notice", "Failed!", null);
								}.bind(this)));
							}.bind(this)), (function() {
								;
							}.bind(this)));
						}
					}
				}
			}
		}.bind(this)), null);
	}.bind(this)));
	deletebtn.setWidgetFontSize((this.context.getHeightValue("4mm")));
	deletebtn.setWidgetBackgroundColor((JkGfxColor.instance("#F2eded")));
	this.vbox.addWidget(deletebtn);
};

AppDeleteNotelistapp.prototype.createWidget = function() {
	JkWidgetVerticalBoxWidget.prototype.createWidget.call(this);
	var thisWidget = this;
	this.setWidgetSpacing((this.context.getHeightValue("2000um")));
	this.setWidgetMargin((this.context.getHeightValue("5mm")));
	var widget = JkWidgetHorizontalBoxWidget.NEW_JkUiGuiApplicationContext(this.context);
	widget.setWidgetSpacing((this.context.getHeightValue("100um")));
	this.btnHome = JkWidgetCommonTextButtonWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.btnHome.setWidgetText("VIEW NOTE LIST");
	this.btnHome.setWidgetPadding((this.context.getHeightValue("1000um")));
	this.btnHome.setWidgetBackgroundColor((JkGfxColor.instance("#ffffff")));
	this.btnHome.setWidgetClickHandler((function() {
		JkWidgetCommonNavigationWidget.switchToContainer(this, (AppNotelistapp.NEW_JkUiGuiApplicationContext(this.context)));
	}.bind(this)));
	widget.addWidget1(this.btnHome, 1.0);
	this.addWidget(widget);
	var widget2 = JkWidgetVerticalScrollerWidget.NEW_JkUiGuiApplicationContext(this.context);
	widget2.setWidgetScrollBarDisabled(true);
	this.container = JkWidgetLayerWithBackgroundColorWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.container.setWidgetColor((JkGfxColor.instance("#F2eded")));
	var widget3 = JkWidgetAlignWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.vbox = JkWidgetVerticalBoxWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.vbox.setWidgetMargin((this.context.getHeightValue("5mm")));
	this.vbox.setWidgetSpacing((this.context.getHeightValue("2000um")));
	var widget4 = JkWidgetLabelWidget.NEW_JkUiGuiApplicationContext(this.context);
	widget4.setWidgetText("DELETING NOTELISTAPP");
	widget4.setWidgetTextColor((JkGfxColor.black()));
	widget4.setWidgetFontSize((this.context.getHeightValue("4mm")));
	widget4.setWidgetTextAlign(JkWidgetLabelWidget.ALIGN_CENTER);
	widget4.setWidgetFontBold(true);
	this.vbox.addWidget(widget4);
	this.id = JkWidgetCommonTextInputWidget.NEW_JkUiGuiApplicationContext(this.context);
	this.id.setWidgetType(JkWidgetCommonTextInputWidget.TYPE_INTEGER);
	this.id.setWidgetPlaceholder("Id");
	this.id.setWidgetBackgroundColor((JkGfxColor.white()));
	this.id.setWidgetFontSize((this.context.getHeightValue("2mm")));
	this.id.setWidgetPadding1((this.context.getHeightValue("2500um")));
	this.vbox.addWidget(this.id);
	widget3.addWidget1(this.vbox, 0.5, 0.5, false);
	this.container.addWidget(widget3);
	widget2.addWidget(this.container);
	this.addWidget(widget2);
};

AppDeleteNotelistapp.IS_INSTANCE = function(o) {
	return o != null && o._t != null && o._t["AppDeleteNotelistapp"] === true;
};
