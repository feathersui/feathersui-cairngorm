/*
	Cafe Townsend MVC Tutorial

	Copyright 2006 Adobe

	Converted to feathersui-cairngorm by Bowler Hat LLC
	https://feathersui.com

	Converted to Cairngorm 2 (Flex) by Darren Houle
	http://www.digimmersion.com

	This is released under a Creative Commons license.
	http://creativecommons.org/licenses/by/2.5/

 */

package com.feathersui.cafetownsend.control;

import com.adobe.cairngorm.control.CairngormEvent;
import com.feathersui.cafetownsend.vo.Employee;

class UpdateEmployeeEvent extends CairngormEvent {
	public var selectedItem:Employee;

	public function new(selectedItem:Employee) {
		super(AppController.UPDATE_EMPLOYEE_EVENT);
		this.selectedItem = selectedItem;
	}
}
