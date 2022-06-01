/*
	TodoMVC with Feathers UI and Cairngorm
	Copyright 2022 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package com.feathersui.cairngorm.todomvc.control;

import com.adobe.cairngorm.control.FrontController;
import com.feathersui.cairngorm.todomvc.command.AddTodoItemCommand;
import com.feathersui.cairngorm.todomvc.command.ClearCompletedCommand;
import com.feathersui.cairngorm.todomvc.command.EditTodoItemCommand;
import com.feathersui.cairngorm.todomvc.command.FilterActiveCommand;
import com.feathersui.cairngorm.todomvc.command.FilterAllCommand;
import com.feathersui.cairngorm.todomvc.command.FilterCompletedCommand;
import com.feathersui.cairngorm.todomvc.command.RemoveTodoItemCommand;
import com.feathersui.cairngorm.todomvc.command.ToggleCompleteAllCommand;
import com.feathersui.cairngorm.todomvc.command.ToggleTodoItemCompletedCommand;

class TodosController extends FrontController {
	public static final ADD_TODO_ITEM_EVENT = "ADD_TODO_ITEM_EVENT";
	public static final EDIT_TODO_ITEM_EVENT = "EDIT_TODO_ITEM_EVENT";
	public static final REMOVE_TODO_ITEM_EVENT = "REMOVE_TODO_ITEM_EVENT";
	public static final TOGGLE_TODO_ITEM_COMPLETED_EVENT = "TOGGLE_TODO_ITEM_COMPLETED_EVENT";
	public static final CLEAR_COMPLETED_EVENT = "CLEAR_COMPLETED_EVENT";
	public static final TOGGLE_COMPLETE_ALL_EVENT = "TOGGLE_COMPLETE_ALL_EVENT";
	public static final FILTER_ALL_EVENT = "FILTER_ALL_EVENT";
	public static final FILTER_ACTIVE_EVENT = "FILTER_ACTIVE_EVENT";
	public static final FILTER_COMPLETED_EVENT = "FILTER_COMPLETED_EVENT";

	public function new() {
		super();
		addCommand(TodosController.ADD_TODO_ITEM_EVENT, AddTodoItemCommand);
		addCommand(TodosController.EDIT_TODO_ITEM_EVENT, EditTodoItemCommand);
		addCommand(TodosController.REMOVE_TODO_ITEM_EVENT, RemoveTodoItemCommand);
		addCommand(TodosController.TOGGLE_TODO_ITEM_COMPLETED_EVENT, ToggleTodoItemCompletedCommand);
		addCommand(TodosController.CLEAR_COMPLETED_EVENT, ClearCompletedCommand);
		addCommand(TodosController.TOGGLE_COMPLETE_ALL_EVENT, ToggleCompleteAllCommand);
		addCommand(TodosController.FILTER_ALL_EVENT, FilterAllCommand);
		addCommand(TodosController.FILTER_ACTIVE_EVENT, FilterActiveCommand);
		addCommand(TodosController.FILTER_COMPLETED_EVENT, FilterCompletedCommand);
	}
}
