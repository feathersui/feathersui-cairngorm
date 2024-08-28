/*

	Copyright (c) 2007. Adobe Systems Incorporated.
	All rights reserved.

	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:

	  * Redistributions of source code must retain the above copyright notice,
		this list of conditions and the following disclaimer.
	  * Redistributions in binary form must reproduce the above copyright notice,
		this list of conditions and the following disclaimer in the documentation
		and/or other materials provided with the distribution.
	  * Neither the name of Adobe Systems Incorporated nor the names of its
		contributors may be used to endorse or promote products derived from this
		software without specific prior written permission.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
	POSSIBILITY OF SUCH DAMAGE.

	@ignore
 */

package com.adobe.cairngorm.business;

#if feathersui_rpc_services
import feathers.rpc.http.HTTPService;
import com.adobe.cairngorm.CairngormMessageCodes;

/**
 * Used to manage all HTTPService's defined on the IServiceLocator instance.
 */
class HTTPServices extends AbstractServices {
	public function new() {
		super();
	}

	private var services:Map<String, HTTPService> = [];

	/**
	 * Register the services.
	 * @param serviceLocator the IServiceLocator instance.
	 */
	public override function register(serviceLocator:IServiceLocator):Void {
		var instanceFields = getInstanceFields(serviceLocator);

		for (name in instanceFields) {
			var obj:Dynamic = Reflect.getProperty(serviceLocator, name);

			if ((obj is HTTPService)) {
				cast(obj, HTTPService).requestTimeout = timeout;
				services.set(name, obj);
			}
		}
	}

	/**
	 * Return the service with the given name.
	 * @param name the name of the service.
	 * @return the service.
	 */
	public override function getService(name:String):Dynamic {
		var service:HTTPService = services.get(name);

		if (service == null) {
			throw new CairngormError(CairngormMessageCodes.HTTP_SERVICE_NOT_FOUND, name);
		}

		return service;
	}

	/**
	 * Set the credentials for all registered services.
	 * @param username the username to set.
	 * @param password the password to set.
	 */
	public override function setCredentials(username:String, password:String):Void {
		for (name => service in services) {
			service.setCredentials(username, password);
		}
	}

	/**
	 * Set the remote credentials for all registered services.
	 * @param username the username to set.
	 * @param password the password to set.
	 */
	public override function setRemoteCredentials(username:String, password:String):Void {
		for (name => service in services) {
			service.setRemoteCredentials(username, password);
		}
	}

	/**
	 * Release the resources held by the service.
	 */
	public override function release():Void {
		// do nothing.
	}

	/**
	 * Log the user out of all registered services.
	 */
	public override function logout():Void {
		for (name => service in services) {
			serviceLogout(service);
		}
	}

	private override function serviceLogout(service:Dynamic):Void {
		var httpService:HTTPService = cast(service, HTTPService);

		if (httpService.channelSet.authenticated) {
			httpService.logout();
		}
	}
}
#end
