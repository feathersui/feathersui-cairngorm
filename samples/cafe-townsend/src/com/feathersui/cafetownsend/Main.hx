/*
	Cafe Townsend MVC Tutorial Copyright 2006 Adobe

	Converted to feathersui-cairngorm by Bowler Hat LLC
	https://feathersui.com

	Converted to Cairngorm 2 by Darren Houle
	lokka_@hotmail.com
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
import feathers.controls.navigators.Route;
import feathers.controls.navigators.RouterNavigator;
import feathers.events.FeathersEvent;
import feathers.motion.transitions.FadeTransitionBuilder;
import openfl.events.Event;

class Main extends Application {
	private var model = AppModelLocator.getInstance();
	private var services = new Services();
	private var appController = new AppController();

	private var navigator:RouterNavigator;

	public function new() {
		super();

		addEventListener(FeathersEvent.CREATION_COMPLETE, creationCompleteHandler);
	}

	override private function initialize():Void {
		super.initialize();

		navigator = new RouterNavigator();
		#if feathersui.com
		// to build for the feathersui.com website, run the following command:
		// haxelib run openfl build html5 -final --haxedef=feathersui.com
		navigator.basePath = "/samples/haxe-openfl/cairngorm/cafe-townsend";
		#end

		refreshRoutes();

		navigator.forwardTransition = new FadeTransitionBuilder().build();
		navigator.backTransition = new FadeTransitionBuilder().build();

		addChild(navigator);

		model.addEventListener(AppModelLocator.USER_CHANGE, model_userChangeHandler);
		model.addEventListener(AppModelLocator.VIEWING_CHANGE, model_viewingChangeHandler);
	}

	private function loadEmployees():Void {
		var cgEvent = new LoadEmployeesEvent();
		CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);
	}

	private function refreshRoutes():Void {
		navigator.removeAllItems();
		if (model.user == null) {
			navigator.addRoute(Route.withClass("/login", EmployeeLogin));
			navigator.addRoute(Route.withRedirect("*", "/login"));
		} else {
			navigator.addRoute(Route.withClass("/list", EmployeeList));
			navigator.addRoute(Route.withClass("/detail", EmployeeDetail));
			navigator.addRoute(Route.withRedirect("*", "/list"));
		}
	}

	private function creationCompleteHandler(event:FeathersEvent):Void {
		loadEmployees();
	}

	private function model_userChangeHandler(event:Event):Void {
		refreshRoutes();
	}

	private function model_viewingChangeHandler(event:Event):Void {
		var pathname = "/";
		switch (model.viewing) {
			case AppModelLocator.EMPLOYEE_LOGIN:
				pathname = "/login";
			case AppModelLocator.EMPLOYEE_DETAIL:
				pathname = "/detail";
			case AppModelLocator.EMPLOYEE_LIST:
				pathname = "/list";
		}
		if (navigator.pathname != pathname) {
			navigator.push(pathname);
		}
	}
}
