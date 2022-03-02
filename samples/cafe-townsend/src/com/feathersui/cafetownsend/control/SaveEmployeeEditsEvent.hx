/*
	Cafe Townsend MVC Tutorial

	Copyright 2006 Adobe

	Converted to feathersui-cairngorm by Bowler Hat LLC
	https://feathersui.com

	Converted to Cairngorm 2 (Flex) by Darren Houle
	http://www.digimmersion.com

	This is released under a Creative Commons license.
	http://creativecommons.org/licenses/by/2.5/

 */

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
