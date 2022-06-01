/*
	TodoMVC with Feathers UI and Cairngorm
	Copyright 2022 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package com.feathersui.cairngorm.todomvc;

import com.feathersui.cairngorm.todomvc.control.TodosController;
import com.feathersui.cairngorm.todomvc.model.TodosModelLocator;
import com.feathersui.cairngorm.todomvc.theme.TodoTheme;
import com.feathersui.cairngorm.todomvc.view.MainView;
import feathers.controls.Application;
import feathers.style.Theme;

class TodoMVC extends Application {
	public function new() {
		Theme.setTheme(new TodoTheme());
		super();
	}

	private var model = TodosModelLocator.getInstance();
	private var controller = new TodosController();

	public var mainView:MainView;

	override private function initialize():Void {
		super.initialize();
		this.mainView = new MainView();
		this.addChild(this.mainView);
	}
}
