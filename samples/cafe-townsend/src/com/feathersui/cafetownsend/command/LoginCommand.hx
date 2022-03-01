package com.feathersui.cafetownsend.command;

import com.adobe.cairngorm.commands.Command;
import com.adobe.cairngorm.control.CairngormEvent;
import com.feathersui.cafetownsend.control.LoginEvent;
import com.feathersui.cafetownsend.model.AppModelLocator;
import com.feathersui.cafetownsend.vo.User;
import feathers.controls.Alert;

class LoginCommand implements Command {
	private var model = AppModelLocator.getInstance();

	public function execute(cgEvent:CairngormEvent):Void {
		// after casting, retreive the username & password payload from the incoming event
		var username = cast(cgEvent, LoginEvent).username;
		var password = cast(cgEvent, LoginEvent).password;

		// if the auth info is correct
		if (username == "Feathers" && password == "Cairngorm") {
			// store the user info in a new user object in the model locator
			model.user = new User(username, password);

			// main viewstack selectedIndex is bound to this model locator value
			// so this now switches the view from the login screen to the employee list
			model.viewing = AppModelLocator.EMPLOYEE_LIST;
		} else {
			// if the auth info was incorrect, prompt with an alert box and remain on the login screen
			Alert.show("We couldn't validate your username & password. Please try again.", "Login Failed", ["OK"]);
		}
	}
}
