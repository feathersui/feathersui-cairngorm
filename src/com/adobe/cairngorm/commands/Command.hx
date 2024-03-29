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

package com.adobe.cairngorm.commands;

/**
	Deprecated, replaced by `com.adobe.cairngorm.commands.ICommand`.

	The Command interface enforces the contract between the Front
	Controller and concrete command classes in your application.

	In a Cairngorm application, the application specific Front Controller
	will listen for events of interest, dispatching control to appropriate
	command classes according to the type of the event broadcast.

	When an event is broadcasted by the Front Controller, it will
	lookup its list of registered commands, to find the command capable
	of carrying out the appropriate work in response to the user gesture
	that has caused the event.

	When the event that a command is registered against is broadcast,
	the Front Controller class will invoke the command by calling its
	execute() method, which can be considered the entry point to a
	command.

	@see `com.adobe.cairngorm.commands.ICommand`
	@see `com.adobe.cairngorm.control.FrontController`
	@see `com.adobe.cairngorm.control.CairngormEventDispatcher`
**/
interface Command extends ICommand {}
