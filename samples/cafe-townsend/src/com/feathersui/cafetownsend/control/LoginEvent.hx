package com.feathersui.cafetownsend.control;

import com.adobe.cairngorm.control.CairngormEvent;

class LoginEvent extends CairngormEvent {
	public var username:String;
	public var password:String;

	public function new(username:String, password:String) {
		super(AppController.LOGIN_EVENT);
		this.username = username;
		this.password = password;
	}
}
