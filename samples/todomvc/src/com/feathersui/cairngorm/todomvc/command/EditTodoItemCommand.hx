/*
	TodoMVC with Feathers UI and Cairngorm
	Copyright 2022 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package com.feathersui.cairngorm.todomvc.command;

import com.adobe.cairngorm.commands.ICommand;
import com.adobe.cairngorm.control.CairngormEvent;
import com.feathersui.cairngorm.todomvc.control.EditTodoItemEvent;
import com.feathersui.cairngorm.todomvc.model.TodosModelLocator;

class EditTodoItemCommand implements ICommand {
	private var model = TodosModelLocator.getInstance();

	public function execute(cgEvent:CairngormEvent):Void {
		var event = cast(cgEvent, EditTodoItemEvent);
		var todoItem = event.todoItem;
		todoItem.text = event.newText;
		this.model.todosListDP.updateAt(this.model.todosListDP.indexOf(todoItem));
	}
}
