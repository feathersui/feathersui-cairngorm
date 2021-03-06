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
import com.feathersui.cafetownsend.control.UpdateEmployeeEvent;
import com.feathersui.cafetownsend.model.AppModelLocator;
import com.feathersui.cafetownsend.vo.Employee;

class UpdateEmployeeCommand implements ICommand {
	private var model = AppModelLocator.getInstance();

	public function execute(cgEvent:CairngormEvent):Void {
		// cast the caringorm event so we can get at the selectedItem values sent from the mx:List
		var selectedItem = cast(cgEvent, UpdateEmployeeEvent).selectedItem;

		// populate a temp employee in the model locator with the details from the selectedItem
		var employeeTemp:Employee = new Employee(selectedItem.emp_id, selectedItem.firstname, selectedItem.lastname, selectedItem.email,
			Date.fromTime(selectedItem.startdate.getTime()));

		model.employeeTemp = employeeTemp;
		// main viewstack selectedIndex is bound to this model locator value
		// so this now switches the view from the employee list to the detail screen
		model.viewing = AppModelLocator.EMPLOYEE_DETAIL;
	}
}
