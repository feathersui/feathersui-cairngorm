package com.feathersui.cafetownsend.control;

import com.adobe.cairngorm.control.CairngormEvent;

class CancelEmployeeEditsEvent extends CairngormEvent {
	public function new() {
		super(AppController.CANCEL_EMPLOYEE_EDITS_EVENT);
	}
}
