/*
	TodoMVC with Feathers UI and Cairngorm
	Copyright 2022 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package com.feathersui.cairngorm.todomvc.control;

import com.adobe.cairngorm.control.CairngormEvent;
import com.feathersui.cairngorm.todomvc.vo.TodoItem;

class ToggleTodoItemCompletedEvent extends CairngormEvent {
	public function new(todoItem:TodoItem) {
		super(TodosController.TOGGLE_TODO_ITEM_COMPLETED_EVENT);
		this.todoItem = todoItem;
	}

	public var todoItem:TodoItem;
}
