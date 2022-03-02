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

package com.feathersui.cafetownsend.view;

import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.feathersui.cafetownsend.control.LoginEvent;
import com.feathersui.cafetownsend.model.AppModelLocator;
import feathers.controls.Button;
import feathers.controls.Form;
import feathers.controls.FormItem;
import feathers.controls.Header;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.Panel;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.events.TriggerEvent;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.layout.HorizontalLayoutData;
import feathers.layout.ResponsiveGridLayout;
import feathers.layout.ResponsiveGridLayoutData;

class EmployeeLogin extends ScrollContainer {
	private var model = AppModelLocator.getInstance();
	private var login_frm:Form;
	private var username:TextInput;
	private var password:TextInput;
	private var login_btn:Button;

	public function new() {
		super();
	}

	override private function initialize():Void {
		super.initialize();

		var viewLayout = new ResponsiveGridLayout();
		viewLayout.setPadding(10.0);
		layout = viewLayout;

		var panel = new Panel();
		panel.layoutData = new ResponsiveGridLayoutData(12, 0, 8, 2, 6, 3, 4, 4);
		panel.layout = new AnchorLayout();
		panel.header = new Header("Cafe Townsend Login");
		addChild(panel);

		login_frm = new Form();
		login_frm.layoutData = AnchorLayoutData.fill(10.0);
		panel.addChild(login_frm);

		username = new TextInput();
		var username_fi = new FormItem("Username:", username);
		username_fi.required = true;
		username_fi.horizontalAlign = JUSTIFY;
		login_frm.addChild(username_fi);

		password = new TextInput();
		password.displayAsPassword = true;
		var password_fi = new FormItem("Password:", password);
		password_fi.required = true;
		password_fi.horizontalAlign = JUSTIFY;
		login_frm.addChild(password_fi);

		login_btn = new Button();
		login_btn.text = "Login";
		login_btn.addEventListener(TriggerEvent.TRIGGER, login_btn_triggerHandler);
		login_frm.addChild(login_btn);

		var footer = new LayoutGroup();
		footer.variant = LayoutGroup.VARIANT_TOOL_BAR;
		var instructions = new Label();
		instructions.text = "Username: Feathers   Password: Cairngorm";
		instructions.wordWrap = true;
		instructions.layoutData = HorizontalLayoutData.fillHorizontal();
		footer.addChild(instructions);
		panel.footer = footer;
	}

	// mutate the loginBtn's click event into a cairngorm event
	private function loginEmployee():Void {
		// validate the fields
		var noUsername = username.text == null || username.text.length == 0;
		var noPassword = password.text == null || password.text.length == 0;
		if (noUsername || noPassword) {
			return;
		} else {
			// if everything validates, broadcast an event containing the username & password
			var cgEvent = new LoginEvent(username.text, password.text);
			CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);

			// now that the fields are sent in the event, blank out the login form fields
			// otherwise they'll still be populated whenever the user returns here
			// (if the user does not get the uid/passwd correct or when the user logs out)
			username.text = "";
			password.text = "";
		}
	}

	private function login_btn_triggerHandler(event:TriggerEvent):Void {
		loginEmployee();
	}
}
