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

package com.feathersui.cafetownsend.business;

import com.adobe.cairngorm.business.ServiceLocator;
import feathers.rpc.IResponder;
import feathers.rpc.http.HTTPService;

class LoadEmployeesDelegate {
	private var command:IResponder;
	private var service:HTTPService;

	public function new(command:IResponder) {
		// constructor will store a reference to the service we're going to call
		service = ServiceLocator.getInstance().getHTTPService('loadEmployeesService');
		// and store a reference to the command that created this delegate
		this.command = command;
	}

	public function loadEmployeesService():Void {
		// call the service
		var token = service.send();
		// notify this command when the service call completes
		token.addResponder(command);
	}
}
