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
import com.feathersui.cafetownsend.model.AppModelLocator;

class CancelEmployeeEditsCommand implements ICommand {
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
