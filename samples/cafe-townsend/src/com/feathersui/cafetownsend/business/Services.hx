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
