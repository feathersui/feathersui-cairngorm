package com.feathersui.cafetownsend.model;

import com.adobe.cairngorm.model.ModelLocator;
import com.feathersui.cafetownsend.vo.Employee;
import com.feathersui.cafetownsend.vo.User;
import feathers.data.ArrayCollection;
import openfl.errors.Error;
import openfl.events.Event;
import openfl.events.EventDispatcher;

class AppModelLocator extends EventDispatcher implements ModelLocator {
	public static final VIEWING_CHANGE = "viewingChange";
	public static final EMPLOYEE_LIST_DP_CHANGE = "employeeListDPChange";
	public static final EMPLOYEE_TEMP_CHANGE = "employeeTempChange";
	public static final USER_CHANGE = "userChange";

	// this instance stores a static reference to itself
	private static var model:AppModelLocator;

	// available values for the main viewstack
	// defined as contants to help uncover errors at compile time instead of run time
	public static final EMPLOYEE_LOGIN = 0;
	public static final EMPLOYEE_LIST = 1;
	public static final EMPLOYEE_DETAIL = 2;

	// viewstack starts out on the login screen
	public var viewing(default, set):Int = EMPLOYEE_LOGIN;

	private function set_viewing(value:Int):Int {
		viewing = value;
		dispatchEvent(new Event(VIEWING_CHANGE));
		return viewing;
	}

	// user object contains uid/passwd
	// its value gets set at login and cleared at logout but nothing binds to it or uses it
	// retained since it was used in the original Adobe CafeTownsend example app
	public var user(default, set):User;

	private function set_user(value:User):User {
		user = value;
		dispatchEvent(new Event(USER_CHANGE));
		return user;
	}

	// variable to store error messages from the httpservice
	// nothinng currently binds to it, but an Alert or the login box could to show startup errors
	public var errorStatus:String;

	// contains the main employee list which is populated on startup
	// mx:application's creationComplete event is mutated into a cairngorm event
	// that calls the httpservice for the data
	public var employeeListDP(default, set):ArrayCollection<Employee>;

	private function set_employeeListDP(value:ArrayCollection<Employee>):ArrayCollection<Employee> {
		employeeListDP = value;
		dispatchEvent(new Event(EMPLOYEE_LIST_DP_CHANGE));
		return employeeListDP;
	}

	// temp holding space for employees we're creating or editing
	// this gets copied into or added onto the main employee list
	public var employeeTemp(default, set):Employee;

	private function set_employeeTemp(value:Employee):Employee {
		employeeTemp = value;
		dispatchEvent(new Event(EMPLOYEE_TEMP_CHANGE));
		return employeeTemp;
	}

	// singleton: constructor only allows one model locator
	public function new() {
		super();
		if (AppModelLocator.model != null) {
			throw new Error("Only one ModelLocator instance should be instantiated");
		}
	}

	// singleton: always returns the one existing static instance to itself
	public static function getInstance():AppModelLocator {
		if (model == null)
			model = new AppModelLocator();
		return model;
	}
}
