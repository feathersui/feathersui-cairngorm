package com.feathersui.cafetownsend.command;

import com.adobe.cairngorm.commands.Command;
import com.adobe.cairngorm.control.CairngormEvent;
import com.feathersui.cafetownsend.model.AppModelLocator;

class CancelEmployeeEditsCommand implements Command {
	private var model = AppModelLocator.getInstance();

	public function execute(cgEvent:CairngormEvent):Void {
		// decided we don't need to store the edited employee details,
		// so null out the temp employee in the model locators
		model.employeeTemp = null;

		// main viewstack selectedIndex is bound to this model locator value
		// so this now switches the view from the detail screen back to the employee list
		model.viewing = AppModelLocator.EMPLOYEE_LIST;
	}
}
