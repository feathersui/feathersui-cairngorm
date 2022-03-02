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

import com.adobe.cairngorm.commands.Command;
import com.adobe.cairngorm.control.CairngormEvent;
import com.feathersui.cafetownsend.model.AppModelLocator;

class DeleteEmployeeCommand implements Command {
	private var model = AppModelLocator.getInstance();

	public function execute(cgEvent:CairngormEvent):Void {
		// loop thru the employee list in the model locator
		for (employee in model.employeeListDP) {
			// if the emp_id stored in the temp employee matches one of the emp_id's in the employee list
			if (model.employeeTemp.emp_id == employee.emp_id) {
				// remove that item from the ArrayCollection
				model.employeeListDP.remove(employee);
			}
		}

		// clear out the data stored in the temp employee
		model.employeeTemp = null;

		// main viewstack selectedIndex is bound to this model locator value
		// so this now switches the view from the detail screen back to the employee list
		// the list should be one array item shorter
		model.viewing = AppModelLocator.EMPLOYEE_LIST;
	}
}
