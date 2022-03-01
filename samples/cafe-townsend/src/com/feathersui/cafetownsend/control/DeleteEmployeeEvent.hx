package com.feathersui.cafetownsend.control;

import com.adobe.cairngorm.control.CairngormEvent;

class DeleteEmployeeEvent extends CairngormEvent {
	public function new() {
		super(AppController.DELETE_EMPLOYEE_EVENT);
	}
}
