/*
	TodoMVC with Feathers UI and Cairngorm
	Copyright 2022 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package com.feathersui.cairngorm.todomvc.command;

import com.adobe.cairngorm.commands.ICommand;
import com.adobe.cairngorm.control.CairngormEvent;
import com.feathersui.cairngorm.todomvc.model.TodosModelLocator;

class ClearCompletedCommand implements ICommand {
	private var model = TodosModelLocator.getInstance();

	public function execute(cgEvent:CairngormEvent):Void {
		var savedFilterFunction = this.model.todosListDP.filterFunction;
		this.model.todosListDP.filterFunction = null;
		var i = this.model.todosListDP.length - 1;
		while (i >= 0) {
			var todoItem = this.model.todosListDP.get(i);
			if (todoItem.completed) {
				this.model.todosListDP.removeAt(i);
			}
			i--;
		}
		this.model.todosListDP.filterFunction = savedFilterFunction;
	}
}
