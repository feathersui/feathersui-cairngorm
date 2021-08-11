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

package com.adobe.cairngorm.control;

import com.adobe.cairngorm.commands.ICommand;

/**
	A base class for an application specific front controller,
	that is able to dispatch control following particular user gestures to appropriate
	command classes.

	The Front Controller is the centralised request handling class in a
	Cairngorm application.  Throughout the application architecture are
	scattered a number of CairngormEventDispatcher.getInstance().dispatchEvent(event)
	method calls, that signal to the listening controller that a user gesture
	has occured.

	The role of the Front Controller is to first register all the different
	events that it is capable of handling against worker classes, called
	command classes.  On hearing an application event, the Front Controller
	will look up its table of registered events, find the appropriate
	command for handling of the event, before dispatching control to the
	command by calling its execute() method.

	Commands are added to the front controller with a weak reference,
	meaning that when the command is garbage collected, the reference in
	the controller is also garbage collected.

	The Front Controller is a base-class that  listen for events 
	dispatched by CairngormEventDispatcher.  In a 
	Cairngorm application, the developer should create a class that
	extends the FrontController, and in the constructor of their
	application specific controller, they should make numerous calls to
	addCommand() to register all the expected events with application
	specific command classes.

	Consider a LoginController, that is the main controller for a Login
	application that has 2 user gestures - Login and Logout.  The application
	will have 2 buttons, "Login" and "Logout" and in the click handler for
	each button, one of the following methods is executed:

	```hx
	public function doLogin():Void {
		var event = new LoginEvent(username.text, password.text);
		CairngormEventDispatcher.getInstance.dispatchEvent(event);
	}

	public function doLogout():Void {
		var event = new LogoutEvent();
		CairngormEventDispatcher.getInstance.dispatchEvent(event);
	}
	```

	We would create LoginController as follows:

	```hx
	class LoginController extends com.adobe.cairngorm.control.FrontController {
		public function new() {
			initializeCommands();
		}
		
		public function initializeCommands():Void {
			addCommand(LoginEvent.EVENT_LOGIN, LoginCommand);
			addCommand(LogoutEvent.EVENT_LOGOUT, LogoutCommand);
		}
	}
	```

	In our concrete implementation of a FrontController, LoginController, we
	register the 2 events that are expected for broadcast - login and logout -
	using the addCommand() method of the parent FrontController class, to
	assign a command class to each event.

	Adding a new use-case to a Cairngorm application is as simple as
	registering the event against a command in the application Front Controller,
	and then creating the concrete command class.

	The concrete implementation of the FrontController, LoginController,
	should be created once and once only (as we only want a single controller
	in our application architecture).  Typically, in our main application, we
	would declare our FrontController child class as a tag, which should be placed
	above any tags which have a dependency on the FrontController.

	```xml
	&lt;mx:Application  xmlns:control="com.domain.project.control.LoginController"   ... &gt;
		&lt;control:LoginController id="controller" /&gt;

		...

	```

	@see `com.adobe.cairngorm.commands.ICommand`
**/
class FrontController {
	public function new() {}

	/**
		Mappings of event name to command class
	**/
	private var commands:Map<String, Class<ICommand>> = [];

	/**
		Registers a ICommand class with the Front Controller, against an event name
		and listens for events with that name.

		When an event is broadcast that matches commandName,
		the ICommand class referred to by commandRef receives control of the
		application, by having its execute() method invoked.

		@param commandName The name of the event that will be broadcast by the
		when a particular user gesture occurs, eg "login"

		@param commandRef An ICommand Class reference upon which execute()
		can be called when the Front Controller hears an event broadcast with
		commandName. Typically, this argument is passed as "LoginCommand" 
		or similar.

		@param useWeakReference A Boolean indicating whether the controller
		should added as a weak reference to the CairngormEventDispatcher,
		meaning it will eligibile for garbage collection if it is unloaded from 
		the main application. Defaults to true.
	**/
	public function addCommand(commandName:String, commandRef:Class<ICommand>, useWeakReference:Bool = true):Void {
		if (commandName == null) {
			throw new CairngormError(CairngormMessageCodes.COMMAND_NAME_NULL);
		}

		if (commandRef == null) {
			throw new CairngormError(CairngormMessageCodes.COMMAND_REF_NULL);
		}

		if (commands.exists(commandName)) {
			throw new CairngormError(CairngormMessageCodes.COMMAND_ALREADY_REGISTERED, commandName);
		}

		commands.set(commandName, commandRef);
		CairngormEventDispatcher.getInstance().addEventListener(commandName, executeCommand, false, 0, useWeakReference);
	}

	/**
		Deregisters an ICommand class with the given event name from the Front Controller 

		@param commandName The name of the event that will be broadcast by the
		when a particular user gesture occurs, eg "login"
	**/
	public function removeCommand(commandName:String):Void {
		if (commandName == null) {
			throw new CairngormError(CairngormMessageCodes.COMMAND_NAME_NULL, commandName);
		}

		if (!commands.exists(commandName)) {
			throw new CairngormError(CairngormMessageCodes.COMMAND_NOT_REGISTERED, commandName);
		}

		CairngormEventDispatcher.getInstance().removeEventListener(commandName, executeCommand);

		commands.remove(commandName);
	}

	/**
		Executes the command
	**/
	private function executeCommand(event:CairngormEvent):Void {
		var commandToInitialise:Class<ICommand> = getCommand(event.type);
		var commandToExecute:ICommand = Type.createInstance(commandToInitialise, []);

		commandToExecute.execute(event);
	}

	/**
		Returns the command class registered with the command name. 
	**/
	private function getCommand(commandName:String):Class<ICommand> {
		var command:Class<ICommand> = commands.get(commandName);

		if (command == null) {
			throw new CairngormError(CairngormMessageCodes.COMMAND_NOT_FOUND, commandName);
		}
		return command;
	}
}
