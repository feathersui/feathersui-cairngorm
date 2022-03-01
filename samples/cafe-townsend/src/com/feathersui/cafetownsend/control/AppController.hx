package com.feathersui.cafetownsend.control;

import com.adobe.cairngorm.control.FrontController;
import com.feathersui.cafetownsend.command.AddNewEmployeeCommand;
import com.feathersui.cafetownsend.command.CancelEmployeeEditsCommand;
import com.feathersui.cafetownsend.command.DeleteEmployeeCommand;
import com.feathersui.cafetownsend.command.LoadEmployeesCommand;
import com.feathersui.cafetownsend.command.LoginCommand;
import com.feathersui.cafetownsend.command.LogoutCommand;
import com.feathersui.cafetownsend.command.SaveEmployeeEditsCommand;
import com.feathersui.cafetownsend.command.UpdateEmployeeCommand;

class AppController extends FrontController {
	public static final LOGIN_EVENT = "LOGIN_EVENT";
	public static final LOGOUT_EVENT = "LOGOUT_EVENT";
	public static final LOAD_EMPLOYEES_EVENT = "LOAD_EMPLOYEES_EVENT";
	public static final ADD_NEW_EMPLOYEE_EVENT = "ADD_NEW_EMPLOYEE_EVENT";
	public static final UPDATE_EMPLOYEE_EVENT = "UPDATE_EMPLOYEE_EVENT";
	public static final CANCEL_EMPLOYEE_EDITS_EVENT = "CANCEL_EMPLOYEE_EDITS_EVENT";
	public static final DELETE_EMPLOYEE_EVENT = "DELETE_EMPLOYEE_EVENT";
	public static final SAVE_EMPLOYEE_EDITS_EVENT = "SAVE_EMPLOYEE_EDITS_EVENT";

	public function new() {
		super();
		addCommand(AppController.LOGIN_EVENT, LoginCommand);
		addCommand(AppController.LOGOUT_EVENT, LogoutCommand);
		addCommand(AppController.LOAD_EMPLOYEES_EVENT, LoadEmployeesCommand);
		addCommand(AppController.ADD_NEW_EMPLOYEE_EVENT, AddNewEmployeeCommand);
		addCommand(AppController.UPDATE_EMPLOYEE_EVENT, UpdateEmployeeCommand);
		addCommand(AppController.CANCEL_EMPLOYEE_EDITS_EVENT, CancelEmployeeEditsCommand);
		addCommand(AppController.DELETE_EMPLOYEE_EVENT, DeleteEmployeeCommand);
		addCommand(AppController.SAVE_EMPLOYEE_EDITS_EVENT, SaveEmployeeEditsCommand);
	}
}
