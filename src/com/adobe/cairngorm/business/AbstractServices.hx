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

class AbstractServices implements IServices {
	private static final FLEX_VERSION:String = "FlexVersion";
	private static final AUTHENTICATED:String = "authenticated";

	private function new() {}

	private var _timeout:Int = 0;

	/**
		Register the services.

		@param serviceLocator the IServiceLocator isntance.
	**/
	public function register(serviceLocator:IServiceLocator):Void {
		throw new CairngormError(CairngormMessageCodes.ABSTRACT_METHOD_CALLED, "register");
	}

	/**
		Return the service with the given name.

		@param name the name of the service.
		@return the service.
	**/
	public function getService(name:String):Dynamic {
		throw new CairngormError(CairngormMessageCodes.ABSTRACT_METHOD_CALLED, "getService");
	}

	/**
		Set the credentials for all registered services.

		@param username the username to set.
		@param password the password to set.
	**/
	public function setCredentials(username:String, password:String):Void {
		throw new CairngormError(CairngormMessageCodes.ABSTRACT_METHOD_CALLED, "setCredentials");
	}

	/**
		Set the remote credentials for all registered services.

		@param username the username to set.
		@param password the password to set.
	**/
	public function setRemoteCredentials(username:String, password:String):Void {
		throw new CairngormError(CairngormMessageCodes.ABSTRACT_METHOD_CALLED, "setRemoteCredentials");
	}

	/**
		Release the resources held by the service.
	**/
	public function release():Void {
		throw new CairngormError(CairngormMessageCodes.ABSTRACT_METHOD_CALLED, "release");
	}

	/**
		Log the user out of all registered services.
	**/
	public function logout():Void {
		throw new CairngormError(CairngormMessageCodes.ABSTRACT_METHOD_CALLED, "logout");
	}

	/**
		The timeout for the services. Default to no timeout, same as Flex.
	**/
	@:flash.property
	public var timeout(get, set):Int;

	private function set_timeout(timeoutTime:Int):Int {
		_timeout = timeoutTime;
		return _timeout;
	}

	private function get_timeout():Int {
		return _timeout;
	}

	/**
		Return all the accessors on this object.

		@param serviceLocator the IServiceLocator instance.
		@return this object's accessors.
	**/
	private function getAccessors(serviceLocator:IServiceLocator):Array<String> {
		// var description:XML = describeType(serviceLocator);
		// var accessors:XMLList = description.accessor.(@access == "readwrite").@name;
		// return accessors;
		return [];
	}

	private function serviceLogout(service:Dynamic):Void {
		throw new CairngormError(CairngormMessageCodes.ABSTRACT_METHOD_CALLED, "serviceLogout");
	}
}
