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

package com.adobe.cairngorm;

import openfl.errors.Error;

/**
	Error class thrown when a Cairngorm error occurs.
	Used to substitute data in error messages.
**/
class CairngormError extends Error {
	public function new(errorCode:String, ...rest) {
		super(formatMessage(errorCode, rest.toString()));
	}

	private function formatMessage(errorCode:String, ...rest:String):String {
		var i18nErrorMessage:String = Reflect.field(CairngormMessages, errorCode);
		var message = i18nErrorMessage;
		for (i in 0...rest.length) {
			var value = rest[i];
			message = StringTools.replace(message, '{$i}', value);
		}
		return errorCode + ": " + message;
	}
}

private class CairngormMessages {
	public static final C0001E = "Only one {0} instance can be instantiated";
	public static final C0002E = "Service not found for {0}";
	public static final C0003E = "Command already registered for {0}";
	public static final C0004E = "Command not found for {0}";
	public static final C0005E = "View already registered for {0}";
	public static final C0006E = "View not found for {0}";
	public static final C0007E = "RemoteObject not found for {0}";
	public static final C0008E = "HTTPService not found for {0}";
	public static final C0009E = "WebService not found for {0}";
	public static final C0010E = "Consumer not found for {0}";
	public static final C0012E = "Producer not found for {0}";
	public static final C0013E = "DataService not found for {0}";
	public static final C0014E = "Abstract method called {0}";
	public static final C0015E = "Command not registered for {0}";
	public static final C0016E = "The 'commandRef' argument cannot be null";
	public static final C0017E = "The 'commandRef' argument '{0}' should implement the ICommand interface";
	public static final C0018E = "The 'commandName' argument cannot be null";
}
