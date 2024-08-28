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
import feathers.rpc.remoting.RemoteObject;
import feathers.rpc.AbstractInvoker;
import feathers.rpc.AbstractService;
import feathers.rpc.http.HTTPService;
#end

/**
	The ServiceLocator allows service to be located and security
	credentials to be managed.

	Although credentials are set against a service they apply to the channel
	i.e. the set of services belonging to the channel share the same
	credentials.

	You must always make sure you call logout at the end of the user's
	session.
**/
class ServiceLocator implements IServiceLocator {
	private static var _instance:ServiceLocator;

	#if feathersui_rpc_services
	private var _httpServices:HTTPServices;
	private var _remoteObjects:RemoteObjects;

	// private var _webServices:WebServices;
	#end
	private var _timeout:Int = 0;

	public static var instance(get, never):ServiceLocator;

	/**
		Return the ServiceLocator instance.

		@return the instance.
	**/
	private static function get_instance():ServiceLocator {
		if (_instance == null) {
			_instance = new ServiceLocator();
		}

		return _instance;
	}

	/**
		Return the ServiceLocator instance.

		@return the instance.
	**/
	public static function getInstance():ServiceLocator {
		return instance;
	}

	/**
		Releases the current instance so that the next call to `getInstance()`
		returns a new instance.
	**/
	public static function releaseInstance():Void {
		_instance = null;
	}

	private function new() {
		if (_instance != null) {
			throw new CairngormError(CairngormMessageCodes.SINGLETON_EXCEPTION, "ServiceLocator");
		}

		_instance = this;
	}

	#if feathersui_rpc_services
	/**
		Deprecated.

		Returns the service defined for the id, to allow services to be looked up
		using the ServiceLocator by a canonical name.

		If no service exists for the service name, an Error will be thrown.</p>

		@param serviceId The id of the service to be returned. This is the id defined in the
		concrete service locator implementation.
	**/
	@:meta(Deprecated("You should now use one of the strongly typed methods for returning a service."))
	@:deprecated("You should now use one of the strongly typed methods for returning a service.")
	public function getService(serviceId:String):AbstractService {
		return getServiceForId(serviceId);
	}

	/**
		Deprecated.

		Returns an AbstractInvoker defined for the id, to allow services to be looked up
		using the ServiceLocator by a canonical name.

		If no service exists for the service name, an Error will be thrown.

		@param serviceId The id of the service to be returned. This is the id defined in the
		concrete service locator implementation.
	**/
	@:meta(Deprecated("You should now use one of the strongly typed methods for returning a service."))
	@:deprecated("You should now use one of the strongly typed methods for returning a service.")
	public function getInvokerService(serviceId:String):AbstractInvoker {
		return getServiceForId(serviceId);
	}

	/**
		Return the HTTPService for the given name.
		@param name the name of the HTTPService
		@return the HTTPService.
	**/
	public function getHTTPService(name:String):HTTPService {
		return cast(httpServices.getService(name), HTTPService);
	}

	/**
		Return the RemoteObject for the given name.
		@param name the name of the RemoteObject.
		@return the RemoteObject.
	**/
	public function getRemoteObject(name:String):RemoteObject {
		return cast(remoteObjects.getService(name), RemoteObject);
	}

	// /**
	// 	Return the WebService for the given name.
	// 	@param name the name of the WebService.
	// 	@return the WebService.
	// **/
	// public function getWebService(name:String):WebService {
	// 	return cast(webServices.getService(name), WebService);
	// }
	#end

	/**
		Set the credentials for all registered services.

		@param username the username to set.
		@param password the password to set.
	**/
	public function setCredentials(username:String, password:String):Void {
		#if feathersui_rpc_services
		httpServices.setCredentials(username, password);
		// remoteObjects.setCredentials(username, password);
		// webServices.setCredentials(username, password);
		#end
	}

	/**
		Set the remote credentials for all registered services.
		@param username the username to set.
		@param password the password to set.
	**/
	public function setRemoteCredentials(username:String, password:String):Void {
		#if feathersui_rpc_services
		httpServices.setRemoteCredentials(username, password);
		// remoteObjects.setRemoteCredentials(username, password);
		// webServices.setRemoteCredentials(username, password);
		#end
	}

	/**
		Logs the user out of all registered services.
	**/
	public function logout():Void {
		#if feathersui_rpc_services
		// First release the resources held by the service. We release the
		// resources first as the logout logs the user out at a channel level.
		httpServices.release();
		// remoteObjects.release();
		// webServices.release();

		// Now log the services out.
		httpServices.logout();
		// remoteObjects.logout();
		// webServices.logout();
		#end
	}

	public var timeout(get, set):Int;

	private function set_timeout(timeoutTime:Int):Int {
		_timeout = timeoutTime;
		return _timeout;
	}

	private function get_timeout():Int {
		return _timeout;
	}

	#if feathersui_rpc_services
	private var httpServices(get, never):HTTPServices;

	private function get_httpServices():HTTPServices {
		if (_httpServices == null) {
			_httpServices = new HTTPServices();
			_httpServices.timeout = timeout;
			_httpServices.register(this);
		}
		return _httpServices;
	}

	private var remoteObjects(get, never):RemoteObjects;

	private function get_remoteObjects():RemoteObjects {
		if (_remoteObjects == null) {
			_remoteObjects = new RemoteObjects();
			_remoteObjects.timeout = timeout;
			_remoteObjects.register(this);
		}
		return _remoteObjects;
	}

	// private var webServices(get, never):WebServices;
	// private function get_webServices():WebServices {
	// 	if (_webServices == null) {
	// 		_webServices = new WebServices();
	// 		_webServices.timeout = timeout;
	// 		_webServices.register(this);
	// 	}
	// 	return _webServices;
	// }
	#end

	/**
		Return the service with the given id.

		@param serviceId the id of the service to return.
		@return the service.
	**/
	private function getServiceForId(serviceId:String):Dynamic {
		if (Reflect.getProperty(this, serviceId) == null) {
			throw new CairngormError(CairngormMessageCodes.SERVICE_NOT_FOUND, serviceId);
		}

		return Reflect.getProperty(this, serviceId);
	}
}
