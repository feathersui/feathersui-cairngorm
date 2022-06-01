/*
	TodoMVC with Feathers UI and Cairngorm
	Copyright 2022 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package com.feathersui.cairngorm.todomvc.control;

import com.adobe.cairngorm.control.CairngormEvent;
import com.feathersui.cairngorm.todomvc.vo.TodoItem;

class EditTodoItemEvent extends CairngormEvent {
	public function new(todoItem:TodoItem, newText:String) {
		super(TodosController.EDIT_TODO_ITEM_EVENT);
		this.todoItem = todoItem;
		this.newText = newText;
	}

	public var todoItem:TodoItem;
	public var newText:String;

	override public function clone():EditTodoItemEvent {
		return new EditTodoItemEvent(this.todoItem, this.newText);
	}
}
