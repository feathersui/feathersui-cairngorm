package com.feathersui.cafetownsend.control;

import com.adobe.cairngorm.control.CairngormEvent;

class LoadEmployeesEvent extends CairngormEvent {
	public function new() {
		super(AppController.LOAD_EMPLOYEES_EVENT);
	}
}
