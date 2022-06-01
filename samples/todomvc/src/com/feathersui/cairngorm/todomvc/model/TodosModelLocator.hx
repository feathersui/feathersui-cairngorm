/*
	TodoMVC with Feathers UI and Cairngorm
	Copyright 2022 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package com.feathersui.cairngorm.todomvc.model;

import com.adobe.cairngorm.model.IModelLocator;
import com.feathersui.cairngorm.todomvc.vo.TodoItem;
import feathers.data.ArrayCollection;
import openfl.errors.Error;
import openfl.events.Event;
import openfl.events.EventDispatcher;

class TodosModelLocator extends EventDispatcher implements IModelLocator {
	public static final TODOS_LIST_DP_CHANGE = "employeeListDPChange";

	public static function activeFilterFunction(item:TodoItem):Bool {
		return !item.completed;
	}

	public static function completedFilterFunction(item:TodoItem):Bool {
		return item.completed;
	}

	// this instance stores a static reference to itself
	private static var model:TodosModelLocator;

	public var todosListDP(default, set):ArrayCollection<TodoItem> = new ArrayCollection();

	private function set_todosListDP(value:ArrayCollection<TodoItem>):ArrayCollection<TodoItem> {
		todosListDP = value;
		dispatchEvent(new Event(TODOS_LIST_DP_CHANGE));
		return todosListDP;
	}

	// singleton: constructor only allows one model locator
	public function new() {
		super();
		if (TodosModelLocator.model != null) {
			throw new Error("Only one ModelLocator instance should be instantiated");
		}
	}

	// singleton: always returns the one existing static instance to itself
	public static function getInstance():TodosModelLocator {
		if (model == null)
			model = new TodosModelLocator();
		return model;
	}
}
