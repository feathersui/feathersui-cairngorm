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

package com.feathersui.cafetownsend.vo;

class Employee {
	private static var currentIndex = 1000;

	public var emp_id:Int;
	public var firstname:String;
	public var lastname:String;
	public var email:String;
	public var startdate:Date;

	public function new(emp_id:Int = 0, firstname:String = "", lastname:String = "", email = "", startdate:Date = null) {
		this.emp_id = (emp_id == 0) ? currentIndex++ : emp_id;
		this.firstname = firstname;
		this.lastname = lastname;
		this.email = email;
		this.startdate = (startdate == null) ? Date.now() : startdate;
	}
}
