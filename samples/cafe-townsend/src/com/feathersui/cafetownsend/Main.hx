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

package com.feathersui.cafetownsend;

import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.feathersui.cafetownsend.business.Services;
import com.feathersui.cafetownsend.control.AppController;
import com.feathersui.cafetownsend.control.LoadEmployeesEvent;
import com.feathersui.cafetownsend.model.AppModelLocator;
import com.feathersui.cafetownsend.view.EmployeeDetail;
import com.feathersui.cafetownsend.view.EmployeeList;
import com.feathersui.cafetownsend.view.EmployeeLogin;
import feathers.controls.Application;
import feathers.controls.navigators.StackItem;
import feathers.controls.navigators.StackNavigator;
import feathers.events.FeathersEvent;
import feathers.motion.transitions.FadeTransitionBuilder;
import openfl.events.Event;

class Main extends Application {
	private var model = AppModelLocator.getInstance();
	private var services = new Services();
	private var appController = new AppController();

	private var navigator:StackNavigator;

	public function new() {
		super();

		addEventListener(FeathersEvent.CREATION_COMPLETE, creationCompleteHandler);
	}

	override private function initialize():Void {
		super.initialize();

		navigator = new StackNavigator();
		navigator.addItem(StackItem.withClass("login", EmployeeLogin));
		navigator.addItem(StackItem.withClass("list", EmployeeList));
		navigator.addItem(StackItem.withClass("detail", EmployeeDetail));
		navigator.replaceTransition = new FadeTransitionBuilder().build();
		addChild(navigator);

		navigator.rootItemID = "login";

		model.addEventListener(AppModelLocator.VIEWING_CHANGE, model_viewingChangeHandler);
	}

	private function loadEmployees():Void {
		var cgEvent = new LoadEmployeesEvent();
		CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);
	}

	private function creationCompleteHandler(event:FeathersEvent):Void {
		loadEmployees();
	}

	private function model_viewingChangeHandler(event:Event):Void {
		var newID = null;
		switch (model.viewing) {
			case AppModelLocator.EMPLOYEE_LOGIN:
				newID = "login";
			case AppModelLocator.EMPLOYEE_DETAIL:
				newID = "detail";
			case AppModelLocator.EMPLOYEE_LIST:
				newID = "list";
		}
		if (navigator.activeItemID != newID) {
			navigator.replaceItem(newID);
		}
	}
}
