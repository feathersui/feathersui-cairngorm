package com.feathersui.cafetownsend.control;

import com.adobe.cairngorm.control.CairngormEvent;

class LogoutEvent extends CairngormEvent {
	public function new() {
		super(AppController.LOGOUT_EVENT);
	}
}
