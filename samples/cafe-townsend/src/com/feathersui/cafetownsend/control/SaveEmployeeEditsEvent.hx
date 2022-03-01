package com.feathersui.cafetownsend.control;

import com.adobe.cairngorm.control.CairngormEvent;

class SaveEmployeeEditsEvent extends CairngormEvent {
	public var emp_id:Int;
	public var firstname:String;
	public var lastname:String;
	public var startdate:Date;
	public var email:String;

	public function new(emp_id:Int, firstname:String, lastname:String, startdate:Date, email:String) {
		super(AppController.SAVE_EMPLOYEE_EDITS_EVENT);
		this.emp_id = emp_id;
		this.firstname = firstname;
		this.lastname = lastname;
		this.startdate = startdate;
		this.email = email;
	}
}
