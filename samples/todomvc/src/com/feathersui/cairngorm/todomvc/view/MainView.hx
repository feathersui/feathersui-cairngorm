/*
	TodoMVC with Feathers UI and Cairngorm
	Copyright 2022 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package com.feathersui.cairngorm.todomvc.view;

import com.adobe.cairngorm.control.CairngormEvent;
import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.feathersui.cairngorm.todomvc.control.AddTodoItemEvent;
import com.feathersui.cairngorm.todomvc.control.TodosController;
import com.feathersui.cairngorm.todomvc.model.TodosModelLocator;
import com.feathersui.cairngorm.todomvc.vo.TodoItem;
import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.ListView;
import feathers.controls.Panel;
import feathers.controls.ScrollContainer;
import feathers.controls.TabBar;
import feathers.controls.TextInput;
import feathers.controls.ToggleButton;
import feathers.data.ArrayCollection;
import feathers.data.ListViewItemState;
import feathers.events.FlatCollectionEvent;
import feathers.events.TriggerEvent;
import feathers.layout.HorizontalLayout;
import feathers.layout.HorizontalLayoutData;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalListFixedRowLayout;
import feathers.utils.DisplayObjectRecycler;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

class MainView extends ScrollContainer {
	public static final CHILD_VARIANT_CONTENT:String = "todos_content";
	public static final CHILD_VARIANT_NEW_TODO_TEXT_INPUT:String = "todos_newTodoTextInput";
	public static final CHILD_VARIANT_TITLE_LABEL:String = "todos_titleLabel";
	public static final CHILD_VARIANT_SELECT_ALL_TOGGLE:String = "todos_selectAllToggle";
	public static final CHILD_VARIANT_BOTTOM_BAR:String = "todos_bottomBar";
	public static final CHILD_VARIANT_FOOTER_TEXT:String = "todos_footerText";

	public function new() {
		super();
	}

	public var model = TodosModelLocator.getInstance();

	private var todosListView:ListView;
	private var selectAllToggle:ToggleButton;
	private var incompleteLabel:Label;
	private var clearButton:Button;
	private var contentContainer:Panel;
	private var bottomBar:LayoutGroup;
	private var newTodoInput:TextInput;
	private var filterTabs:TabBar;

	private var ignoreSelectAllChange = false;

	override private function initialize():Void {
		super.initialize();

		this.autoSizeMode = STAGE;
		var mainLayout = new VerticalLayout();
		mainLayout.horizontalAlign = CENTER;
		mainLayout.justifyResetEnabled = true;
		mainLayout.setPadding(10.0);
		mainLayout.gap = 10.0;
		this.layout = mainLayout;

		var title = new Label();
		title.text = "todos";
		title.variant = CHILD_VARIANT_TITLE_LABEL;
		this.addChild(title);

		this.contentContainer = new Panel();
		this.contentContainer.width = 550.0;
		var contentLayout = new VerticalLayout();
		contentLayout.horizontalAlign = JUSTIFY;
		this.contentContainer.layout = contentLayout;
		this.addChild(this.contentContainer);

		var topBar = new LayoutGroup();
		var topBarLayout = new HorizontalLayout();
		topBarLayout.gap = 5.0;
		topBarLayout.verticalAlign = MIDDLE;
		topBar.layout = topBarLayout;
		this.contentContainer.header = topBar;

		this.selectAllToggle = new ToggleButton();
		this.selectAllToggle.variant = CHILD_VARIANT_SELECT_ALL_TOGGLE;
		this.selectAllToggle.visible = false;
		this.selectAllToggle.addEventListener(Event.CHANGE, selectAllToggle_changeHandler);

		this.newTodoInput = new TextInput();
		this.newTodoInput.variant = CHILD_VARIANT_NEW_TODO_TEXT_INPUT;
		this.newTodoInput.leftView = this.selectAllToggle;
		this.newTodoInput.prompt = "What needs to be done?";
		this.newTodoInput.layoutData = HorizontalLayoutData.fillHorizontal();
		this.newTodoInput.addEventListener(KeyboardEvent.KEY_DOWN, newTodoInput_keyDownHandler);
		topBar.addChild(this.newTodoInput);

		this.todosListView = new ListView();
		this.todosListView.dataProvider = this.model.todosListDP;
		this.todosListView.itemRendererRecycler = DisplayObjectRecycler.withClass(TodoItemRenderer, (itemRenderer, state:ListViewItemState) -> {
			itemRenderer.todoItem = state.data;
		}, (itemRenderer, state) -> {
			itemRenderer.todoItem = null;
		});

		this.todosListView.itemToText = (item:TodoItem) -> item.text;
		this.todosListView.selectable = false;
		this.todosListView.layout = new VerticalListFixedRowLayout();
		this.todosListView.visible = false;
		this.contentContainer.addChild(this.todosListView);

		this.bottomBar = new LayoutGroup();
		this.bottomBar.variant = CHILD_VARIANT_BOTTOM_BAR;

		this.incompleteLabel = new Label();
		bottomBar.addChild(this.incompleteLabel);

		this.filterTabs = new TabBar();
		this.filterTabs.dataProvider = new ArrayCollection([
			new FilterItem("All", TodosController.FILTER_ALL_EVENT),
			new FilterItem("Active", TodosController.FILTER_ACTIVE_EVENT),
			new FilterItem("Completed", TodosController.FILTER_COMPLETED_EVENT)
		]);
		this.filterTabs.itemToText = item -> item.text;
		this.filterTabs.addEventListener(Event.CHANGE, filterTabs_changeHandler);
		bottomBar.addChild(this.filterTabs);

		this.clearButton = new Button();
		this.clearButton.text = "Clear Completed";
		this.clearButton.visible = false;
		this.clearButton.addEventListener(TriggerEvent.TRIGGER, clearButton_triggerHandler);
		bottomBar.addChild(this.clearButton);

		var footerText = new Label();
		footerText.variant = CHILD_VARIANT_FOOTER_TEXT;
		footerText.htmlText = '<p>Created with <a href="https://feathersui.com/"><u>Feathers UI</u></a> and <a href="https://github.com/feathersui/feathersui-cairngorm/"><u>Cairngorm</u></a></p><p>Inspired by <a href="https://todomvc.com/"><u>TodoMVC</u></a></p>';
		this.addChild(footerText);

		this.model.todosListDP.addEventListener(Event.CHANGE, todosCollection_changeHandler);
		this.model.todosListDP.addEventListener(FlatCollectionEvent.UPDATE_ITEM, todosCollection_updateItemHandler);
		this.model.todosListDP.addEventListener(FlatCollectionEvent.UPDATE_ALL, todosCollection_updateAllHandler);
	}

	private function refreshSelectAllToggle():Void {
		var allSelected = true;
		for (todoItem in this.model.todosListDP.array) {
			if (!todoItem.completed) {
				allSelected = false;
				break;
			}
		}
		this.ignoreSelectAllChange = true;
		this.selectAllToggle.selected = allSelected;
		this.ignoreSelectAllChange = false;
	}

	private function refreshIncompleteCount():Void {
		var incompleteCount = 0;
		for (todoItem in this.model.todosListDP.array) {
			if (!todoItem.completed) {
				incompleteCount++;
			}
		}
		var itemsLeftText = Std.string(incompleteCount);
		if (incompleteCount == 1) {
			itemsLeftText += " item left";
		} else {
			itemsLeftText += " items left";
		}
		this.incompleteLabel.text = itemsLeftText;
	}

	private function refreshVisibility():Void {
		var hasItems = this.model.todosListDP.array.length > 0;
		var hasCompleted = false;
		for (todoItem in this.model.todosListDP.array) {
			if (todoItem.completed) {
				hasCompleted = true;
				break;
			}
		}
		this.clearButton.visible = hasCompleted;
		this.todosListView.visible = hasItems;
		this.todosListView.includeInLayout = hasItems;
		this.contentContainer.footer = hasItems ? this.bottomBar : null;
		this.selectAllToggle.visible = hasItems;
	}

	private function refreshAll():Void {
		this.refreshSelectAllToggle();
		this.refreshIncompleteCount();
		this.refreshVisibility();
	}

	private function createNewTodo(text:String):Void {
		var todoText = StringTools.trim(text);
		if (todoText.length == 0) {
			return;
		}
		var todoItem = new TodoItem(todoText);
		// broadcast the cairngorm event
		var cgEvent = new AddTodoItemEvent(todoItem);
		CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);
	}

	private function selectAllToggle_changeHandler(event:Event):Void {
		if (this.ignoreSelectAllChange) {
			return;
		}
		var cgEvent = new CairngormEvent(TodosController.TOGGLE_COMPLETE_ALL_EVENT);
		CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);
	}

	private function newTodoInput_keyDownHandler(event:KeyboardEvent):Void {
		if (event.keyCode == Keyboard.ENTER) {
			this.createNewTodo(this.newTodoInput.text);
			this.newTodoInput.text = "";
		}
	}

	private function filterTabs_changeHandler(event:Event):Void {
		var filterItem = cast(this.filterTabs.selectedItem, FilterItem);
		var cgEvent = new CairngormEvent(filterItem.event);
		CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);
	}

	private function clearButton_triggerHandler(event:TriggerEvent):Void {
		var cgEvent = new CairngormEvent(TodosController.CLEAR_COMPLETED_EVENT);
		CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);
	}

	private function todosCollection_changeHandler(event:Event):Void {
		this.refreshAll();
	}

	private function todosCollection_updateItemHandler(event:FlatCollectionEvent):Void {
		this.refreshAll();
	}

	private function todosCollection_updateAllHandler(event:FlatCollectionEvent):Void {
		this.refreshAll();
	}
}

private class FilterItem {
	public function new(text:String, event:String) {
		this.text = text;
		this.event = event;
	}

	public var text:String;
	public var event:String;
}
