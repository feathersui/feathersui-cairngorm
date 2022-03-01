package com.feathersui.cafetownsend.view;

import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.feathersui.cafetownsend.control.CancelEmployeeEditsEvent;
import com.feathersui.cafetownsend.control.DeleteEmployeeEvent;
import com.feathersui.cafetownsend.control.SaveEmployeeEditsEvent;
import com.feathersui.cafetownsend.model.AppModelLocator;
import feathers.controls.Alert;
import feathers.controls.Button;
import feathers.controls.Form;
import feathers.controls.FormItem;
import feathers.controls.Header;
import feathers.controls.LayoutGroup;
import feathers.controls.Panel;
import feathers.controls.PopUpDatePicker;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.core.FocusManager;
import feathers.events.TriggerEvent;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.layout.ResponsiveGridLayout;
import feathers.layout.ResponsiveGridLayoutData;

class EmployeeDetail extends ScrollContainer {
	private var model = AppModelLocator.getInstance();
	private var details_frm:Form;
	private var firstname:TextInput;
	private var lastname:TextInput;
	private var startdate:PopUpDatePicker;
	private var email:TextInput;
	private var submit_btn:Button;
	private var delete_btn:Button;
	private var cancel_btn:Button;

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
		panel.layout = new AnchorLayout();
		addChild(panel);

		var header = new Header("Employee Details");
		panel.header = header;

		cancel_btn = new Button();
		cancel_btn.text = "Cancel";
		cancel_btn.addEventListener(TriggerEvent.TRIGGER, cancel_btn_triggerHandler);
		header.leftView = cancel_btn;

		details_frm = new Form();
		details_frm.layoutData = AnchorLayoutData.fill(10.0);
		panel.addChild(details_frm);

		firstname = new TextInput();
		firstname.text = model.employeeTemp.firstname;
		var firstname_fi = new FormItem("First Name:", firstname);
		firstname_fi.required = true;
		firstname_fi.horizontalAlign = JUSTIFY;
		details_frm.addChild(firstname_fi);

		lastname = new TextInput();
		lastname.text = model.employeeTemp.lastname;
		var lastname_fi = new FormItem("Last Name:", lastname);
		lastname_fi.required = true;
		lastname_fi.horizontalAlign = JUSTIFY;
		details_frm.addChild(lastname_fi);

		startdate = new PopUpDatePicker();
		startdate.selectedDate = model.employeeTemp.startdate;
		var startdate_fi = new FormItem("Start Date:", startdate);
		startdate_fi.horizontalAlign = JUSTIFY;
		details_frm.addChild(startdate_fi);

		email = new TextInput();
		email.text = model.employeeTemp.email;
		var email_fi = new FormItem("Email:", email);
		email_fi.required = true;
		email_fi.horizontalAlign = JUSTIFY;
		details_frm.addChild(email_fi);

		var footer = new LayoutGroup();
		footer.variant = LayoutGroup.VARIANT_TOOL_BAR;
		panel.footer = footer;

		submit_btn = new Button();
		submit_btn.text = "Submit";
		submit_btn.addEventListener(TriggerEvent.TRIGGER, submit_btn_triggerHandler);
		footer.addChild(submit_btn);

		delete_btn = new Button();
		delete_btn.text = "Delete";
		delete_btn.addEventListener(TriggerEvent.TRIGGER, delete_btn_triggerHandler);
		footer.addChild(delete_btn);
	}

	private function cancelEmployeeEdits():Void {
		var cgEvent = new CancelEmployeeEditsEvent();
		CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);
	}

	private function saveEmployeeEdits():Void {
		// first, validate the fields
		var noFirstName = firstname.text == null || firstname.text.length == 0;
		var noLastName = lastname.text == null || lastname.text.length == 0;
		var noEmail = email.text == null || email.text.length == 0;
		// if any of the fields were not valid
		if (noFirstName || noLastName || noEmail) {
			// return focus to the firstname field and do nothing else
			FocusManager.setFocus(firstname);
			return;
		}
		// to make it here the fields must have been valid
		// create and broadcast a new cairngorm event with a payload containing the edited fields
		var cgEvent = new SaveEmployeeEditsEvent(model.employeeTemp.emp_id, firstname.text, lastname.text, startdate.selectedDate, email.text);
		CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);
	}

	private function deleteEmployee():Void {
		// broadcast the cairngorm event
		var cgEvent = new DeleteEmployeeEvent();
		CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);
	}

	private function cancel_btn_triggerHandler(event:TriggerEvent):Void {
		cancelEmployeeEdits();
	}

	private function submit_btn_triggerHandler(event:TriggerEvent):Void {
		saveEmployeeEdits();
	}

	private function delete_btn_triggerHandler(event:TriggerEvent):Void {
		Alert.show("Are you sure you want to delete the following employee?", "Delete employee?", ["OK", "Cancel"], state -> {
			if (state.text == "OK") {
				deleteEmployee();
			}
		});
	}
}
