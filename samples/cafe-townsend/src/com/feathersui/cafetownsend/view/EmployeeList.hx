package com.feathersui.cafetownsend.view;

import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.feathersui.cafetownsend.control.AddNewEmployeeEvent;
import com.feathersui.cafetownsend.control.LogoutEvent;
import com.feathersui.cafetownsend.control.UpdateEmployeeEvent;
import com.feathersui.cafetownsend.model.AppModelLocator;
import com.feathersui.cafetownsend.vo.Employee;
import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.LayoutGroup;
import feathers.controls.ListView;
import feathers.controls.Panel;
import feathers.controls.ScrollContainer;
import feathers.events.ListViewEvent;
import feathers.events.TriggerEvent;
import feathers.layout.ResponsiveGridLayout;
import feathers.layout.ResponsiveGridLayoutData;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalLayoutData;

class EmployeeList extends ScrollContainer {
	private var model = AppModelLocator.getInstance();
	private var addEmployee_btn:Button;
	private var logout_btn:Button;
	private var employees_li:ListView;

	public function new() {
		super();
	}

	override private function initialize():Void {
		super.initialize();

		var viewLayout = new ResponsiveGridLayout();
		viewLayout.setPadding(10.0);
		layout = viewLayout;

		var panel = new Panel();
		panel.layoutData = new ResponsiveGridLayoutData(12, 0, 8, 2, 6, 3, 4, 4);
		panel.layout = new VerticalLayout();
		addChild(panel);

		panel.header = new Header("Employee List");

		var toolBar = new LayoutGroup();
		toolBar.variant = LayoutGroup.VARIANT_TOOL_BAR;
		toolBar.layoutData = VerticalLayoutData.fillHorizontal();
		panel.addChild(toolBar);

		addEmployee_btn = new Button();
		addEmployee_btn.text = "Add New Employee";
		addEmployee_btn.addEventListener(TriggerEvent.TRIGGER, addEmployee_btn_triggerHandler);
		toolBar.addChild(addEmployee_btn);

		logout_btn = new Button();
		logout_btn.text = "Logout";
		logout_btn.addEventListener(TriggerEvent.TRIGGER, logout_btn_triggerHandler);
		toolBar.addChild(logout_btn);

		employees_li = new ListView();
		employees_li.layoutData = VerticalLayoutData.fill();
		employees_li.dataProvider = model.employeeListDP;
		employees_li.itemToText = (item:Employee) -> item.lastname + ", " + item.firstname;
		employees_li.minHeight = 150.0;
		employees_li.addEventListener(ListViewEvent.ITEM_TRIGGER, employees_li_itemTriggerHandler);
		panel.addChild(employees_li);
	}

	// mutate the logout button's click event
	private function logout():Void {
		// broadcast a cairngorm event
		var cgEvent = new LogoutEvent();
		CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);
	}

	// mutate the add new employee button's click event
	public function addNewEmployee():Void {
		// broadcast a cairngorm event
		var cgEvent = new AddNewEmployeeEvent();
		CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);
		// de-select the list item (it may not exist next time we're on this view)
		clearSelectedEmployee();
	}

	// mutate the List's change event
	public function updateEmployee(employee:Employee):Void {
		// boardcast a cairngorm event that contains the selectedItem from the List
		var cgEvent = new UpdateEmployeeEvent(employee);
		CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);
		// de-select the list item (it may not exist next time we're on this view)
		clearSelectedEmployee();
	}

	// de-select any selected List items
	private function clearSelectedEmployee():Void {
		employees_li.selectedIndex = -1;
	}

	private function addEmployee_btn_triggerHandler(event:TriggerEvent):Void {
		addNewEmployee();
	}

	private function employees_li_itemTriggerHandler(event:ListViewEvent):Void {
		updateEmployee((event.state.data : Employee));
	}

	private function logout_btn_triggerHandler(event:TriggerEvent):Void {
		logout();
	}
}
