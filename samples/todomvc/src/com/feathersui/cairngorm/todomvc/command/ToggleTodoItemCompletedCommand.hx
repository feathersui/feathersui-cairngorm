/*
	TodoMVC with Feathers UI and Cairngorm
	Copyright 2022 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package com.feathersui.cairngorm.todomvc.command;

import com.adobe.cairngorm.commands.ICommand;
import com.adobe.cairngorm.control.CairngormEvent;
import com.feathersui.cairngorm.todomvc.control.ToggleTodoItemCompletedEvent;
import com.feathersui.cairngorm.todomvc.model.TodosModelLocator;

class ToggleTodoItemCompletedCommand implements ICommand {
	private var model = TodosModelLocator.getInstance();

	public function execute(cgEvent:CairngormEvent):Void {
		var todoItem = cast(cgEvent, ToggleTodoItemCompletedEvent).todoItem;
		todoItem.completed = !todoItem.completed;
		this.model.todosListDP.updateAt(this.model.todosListDP.indexOf(todoItem));
	}
}
