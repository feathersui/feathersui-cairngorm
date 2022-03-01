package com.feathersui.cafetownsend.control;

import com.adobe.cairngorm.control.CairngormEvent;
import com.feathersui.cafetownsend.vo.Employee;

class UpdateEmployeeEvent extends CairngormEvent {
	public var selectedItem:Employee;

	public function new(selectedItem:Employee) {
		super(AppController.UPDATE_EMPLOYEE_EVENT);
		this.selectedItem = selectedItem;
	}
}
