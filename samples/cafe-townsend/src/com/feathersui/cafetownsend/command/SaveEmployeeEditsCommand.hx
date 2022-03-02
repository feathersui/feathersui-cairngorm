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
import com.feathersui.cafetownsend.control.SaveEmployeeEditsEvent;
import com.feathersui.cafetownsend.model.AppModelLocator;

class SaveEmployeeEditsCommand implements Command {
	private var model = AppModelLocator.getInstance();

	public function execute(cgEvent:CairngormEvent):Void {
		// cast the cairngorm event and extract the edited employee data fields
		var editItems = cast(cgEvent, SaveEmployeeEditsEvent);
		// store those values in the temp employee in the model locator
		model.employeeTemp.emp_id = editItems.emp_id;
		model.employeeTemp.firstname = editItems.firstname;
		model.employeeTemp.lastname = editItems.lastname;
		model.employeeTemp.startdate = editItems.startdate;
		model.employeeTemp.email = editItems.email;

		// assume the edited fields are not an existing employee, but a new employee
		// and set the ArrayCollection index to -1, which means this employee is not in our existing
		// employee list anywhere
		var dpIndex = -1;

		// loop thru the employee list
		for (i in 0...model.employeeListDP.length) {
			// if the emp_id of the incoming employee matches an employee already in the list
			if (model.employeeListDP.get(i).emp_id == model.employeeTemp.emp_id) {
				// set our ArrayCollection index to that employee position
				dpIndex = i;
			}
		}

		// if it was an existing employee already in the ArrayCollection
		if (dpIndex >= 0) {
			// update that employee's values
			model.employeeListDP.set(dpIndex, model.employeeTemp);
		}
		// otherwise, if it didn't match any existing employees
		else {
			// add the temp employee to the ArrayCollection
			model.employeeListDP.add(model.employeeTemp);
		}

		// now that we've trasferred the temp employee to the array we can clear out the temp employee
		model.employeeTemp = null;

		// main viewstack selectedIndex is bound to this model locator value
		// so this now switches the view from the detail screen back to the employee list
		// the employee list should now contain one more item
		model.viewing = AppModelLocator.EMPLOYEE_LIST;
	}
}
