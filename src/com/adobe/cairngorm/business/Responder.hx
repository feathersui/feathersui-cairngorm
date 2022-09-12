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

/**
	Deprecated, replaced by `mx.rpc.IResponder`.

	The Responder interface is implemented by classes that wish to handle
	data returned as the result of a service-call to the server.

	Typically, a server-side call will be made using a service
	that is defined on the ServiceLocator.  These services will either be
	remote calls onto Java Objects (RemoteObject), Web Service invocations
	(WebService) or XML over HTTP/HTTPS (HTTPService) service calls.

	The results from these server calls will be handled by an object that has
	been passed to the ServiceLocator as the designated "responder" (the
	class willing to handle the response).

	Typically in the Cairngorm architecture, the Responder interface is
	implemented by a concrete implementation of an ICommand class that will use
	a BusinessDelegate class to handle invocation of server-side business
	logic.

	@see `mx.rpc.IResponder`
	@see `com.adobe.cairngorm.commands.ICommand`
**/
interface Responder {
	/**
		The onResult method interface is used to mark the method on a
		concrete Responder that will handle the results from a successful
		call to a server-side service.  The actual data returned will be
		held in the event.

		@param event An object containing the data passed back from the
		service call, it is recommended that this be immediately narrowed
		within the concrete responder by using an appropriate cast.  For
		instance, if you invoke a Java method that returns an AccountVO
		value object, cast event.result to an AccountVO as follows:

		```hx
		var customerAccount:AccountVO = AccountVO(event.result);
		```

		It is considered good practice when building applications with the
		Cairngorm framework, to indicate the return types from the server
		by appropriate casting.
		Java Developers should take care not to use
		the Java casting notation - a common mistake for RIA developers
		migrating from J2EE development.
	**/
	@:meta(Deprecated(replacement = "mx.rpc.IResponder.result"))
	@:deprecated("mx.rpc.IResponder.result")
	function onResult(event:Dynamic = null):Void;

	/**
		The onFault method interface is used to mark the method on a
		concrete Responder that will handle the information from a failed
		call to a server-side service.  The actual data returned will be
		held in the event.

		@param event An object containing the data passed back from the
		service call
	**/
	@:meta(Deprecated(replacement = "mx.rpc.IResponder.fault"))
	@:deprecated("mx.rpc.IResponder.fault")
	function onFault(event:Dynamic = null):Void;
}
