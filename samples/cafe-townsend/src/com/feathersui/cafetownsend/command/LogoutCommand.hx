package com.feathersui.cafetownsend.command;

import com.adobe.cairngorm.commands.Command;
import com.adobe.cairngorm.control.CairngormEvent;
import com.feathersui.cafetownsend.model.AppModelLocator;

class LogoutCommand implements Command {
	private var model = AppModelLocator.getInstance();

	public function execute(cgEvent:CairngormEvent):Void {
		// null out the user object stored in the model locator
		model.user = null;

		// main viewstack selectedIndex is bound to this model locator value
		// so this now switches the view from the employee list back to the initial login screen
		model.viewing = AppModelLocator.EMPLOYEE_LOGIN;
	}
}
