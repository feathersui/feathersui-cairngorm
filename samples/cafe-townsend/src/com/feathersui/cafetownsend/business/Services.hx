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
import feathers.rpc.http.HTTPService;

class Services extends ServiceLocator {
	public var loadEmployeesService:HTTPService;

	public function new() {
		super();
		loadEmployeesService = new HTTPService();
		loadEmployeesService.url = "data/Employees.xml";
		loadEmployeesService.resultFormat = HTTPService.RESULT_FORMAT_HAXE_XML;
	}
}
