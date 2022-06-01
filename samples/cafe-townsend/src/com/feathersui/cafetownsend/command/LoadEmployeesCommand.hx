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

package com.feathersui.cafetownsend.command;

import com.adobe.cairngorm.commands.ICommand;
import com.adobe.cairngorm.control.CairngormEvent;
import com.feathersui.cafetownsend.business.LoadEmployeesDelegate;
import com.feathersui.cafetownsend.model.AppModelLocator;
import com.feathersui.cafetownsend.vo.Employee;
import feathers.data.ArrayCollection;
import feathers.rpc.IResponder;
import feathers.rpc.events.ResultEvent;

class LoadEmployeesCommand implements ICommand implements IResponder {
	private var model = AppModelLocator.getInstance();

	public function execute(cgEvent:CairngormEvent):Void {
		// create a worker who will go get some data
		// pass it a reference to this command so the delegate knows where to return the data
		var delegate = new LoadEmployeesDelegate(this);
		// make the delegate do some work
		delegate.loadEmployeesService();
	}

	// this is called when the delegate receives a result from the service
	public function result(rpcEvent:Dynamic):Void {
		// populate the employee list in the model locator with the XML results from the service call
		var xmlData:Xml = cast(rpcEvent, ResultEvent).result;
		var employees:Array<Employee> = [];
		for (employeeXml in xmlData.firstElement().elementsNamed("employee")) {
			var emp_id = Std.parseInt(employeeXml.elementsNamed("emp_id").next().firstChild().nodeValue);
			var firstname = employeeXml.elementsNamed("firstname").next().firstChild().nodeValue;
			var lastname = employeeXml.elementsNamed("lastname").next().firstChild().nodeValue;
			var email = employeeXml.elementsNamed("email").next().firstChild().nodeValue;
			var startdate = Date.fromString(employeeXml.elementsNamed("startdate").next().firstChild().nodeValue);
			var employee = new Employee(emp_id, firstname, lastname, email, startdate);
			employees.push(employee);
		}
		model.employeeListDP = new ArrayCollection(employees);
	}

	// this is called when the delegate receives a fault from the service
	public function fault(rpcEvent:Dynamic):Void {
		// store an error message in the model locator
		// labels, alerts, etc can bind to this to notify the user of errors
		model.errorStatus = "Fault occured in LoadEmployeesCommand.";
	}
}
