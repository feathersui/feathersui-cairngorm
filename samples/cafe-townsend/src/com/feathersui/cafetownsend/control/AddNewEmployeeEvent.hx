package com.feathersui.cafetownsend.control;

import com.adobe.cairngorm.control.CairngormEvent;

class AddNewEmployeeEvent extends CairngormEvent {
	public function new() {
		super(AppController.ADD_NEW_EMPLOYEE_EVENT);
	}
}
