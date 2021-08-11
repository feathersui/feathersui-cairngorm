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

import openfl.Lib;
import com.adobe.cairngorm.commands.ICommand;
import com.adobe.cairngorm.mocks.MockICommand;
import utest.Assert;
import com.adobe.cairngorm.mocks.MockCommand;
import utest.Test;

class TestFrontController extends Test {
	public static var executeCalled:Bool = false;
	public static var dispatchedEvent:CairngormEvent;

	private var frontController:FrontController;
	private var eventName:String;

	public function new() {
		super();
	}

	public function setup():Void {
		frontController = new FrontController();
		executeCalled = false;
		dispatchedEvent = null;

		eventName = createNewEventName();
	}

	public function teardown():Void {
		CairngormEventDispatcher.releaseInstance();
	}

	public function testAddCommandNullCommandName():Void {
		try {
			frontController.addCommand(null, MockCommand);
			Assert.fail("addCommand() should fail when null is passed as  command name");
		} catch (e:CairngormError) {
			verifyMessageCode(CairngormMessageCodes.COMMAND_NAME_NULL, e.message);
		}
	}

	public function testAddCommandNullCommandRef():Void {
		try {
			frontController.addCommand(eventName, null);
			Assert.fail("addCommand() should fail when null is passed instead of class");
		} catch (e:CairngormError) {
			verifyMessageCode(CairngormMessageCodes.COMMAND_REF_NULL, e.message);
		}
	}

	// haxe is more strict at compile time, so this test is no longer necessary
	// public function testAddCommandClassDoesNotImplementICommand():Void {
	// 	try {
	// 		frontController.addCommand(eventName, Test);
	// 		Assert.fail("addCommand() should fail for a class that does not implement the com.adobe.cairngorm.commands.ICommand interface");
	// 	} catch (e:CairngormError) {
	// 		verifyMessageCode(CairngormMessageCodes.COMMAND_SHOULD_IMPLEMENT_ICOMMAND, e.message);
	// 	}
	// }
	// haxe is more strict at compile time, so this test is no longer necessary
	// public function testAddCommandClassDoesNotImplementCommand():Void {
	// 	try {
	// 		frontController.addCommand(eventName, Test);
	// 		Assert.fail("addCommand() should fail for a class that does not implement the com.adobe.cairngorm.commands.Command interface");
	// 	} catch (e:CairngormError) {
	// 		verifyMessageCode(CairngormMessageCodes.COMMAND_SHOULD_IMPLEMENT_ICOMMAND, e.message);
	// 	}
	// }

	public function testAddCommandClassImplementsICommand():Void {
		frontController.addCommand(eventName, MockICommand);
		Assert.isTrue(CairngormEventDispatcher.getInstance().hasEventListener(eventName), "CairngormEventDispatcher should be listening for event");
	}

	public function testAddCommandClassImplementsCommand():Void {
		frontController.addCommand(eventName, MockCommand);
		Assert.isTrue(CairngormEventDispatcher.getInstance().hasEventListener(eventName), "CairngormEventDispatcher should be listening for event");
	}

	public function testAddCommandTwiceWithSameCommandName():Void {
		try {
			frontController.addCommand(eventName, MockCommand);
			frontController.addCommand(eventName, MockICommand);

			Assert.fail("Calling addCommand() twice with the same command name should fail");
		} catch (e:CairngormError) {
			verifyMessageCode(CairngormMessageCodes.COMMAND_ALREADY_REGISTERED, e.message);
		}
	}

	public function testCommandExecuteCalled():Void {
		frontController.addCommand(eventName, LocalCommand);

		var event:CairngormEvent = new CairngormEvent(eventName);
		event.dispatch();

		Assert.isTrue(TestFrontController.executeCalled, "execute should have been called");
		Assert.notNull(TestFrontController.dispatchedEvent, "dispatchedEvent should not be null");
		Assert.equals(event, TestFrontController.dispatchedEvent);
	}

	public function testAddCommandDispatcherHasEventListener():Void {
		frontController.addCommand(eventName, MockCommand);

		Assert.isTrue(CairngormEventDispatcher.getInstance().hasEventListener(eventName), "CairngormEventDispatcher should be listening for event");
	}

	public function testRemoveCommandNullCommandName():Void {
		try {
			frontController.removeCommand(null);
			Assert.fail("removeCommand() should fail for a null commandName");
		} catch (e:CairngormError) {
			verifyMessageCode(CairngormMessageCodes.COMMAND_NAME_NULL, e.message);
		}
	}

	public function testRemoveCommandCommandNotRegistered():Void {
		try {
			frontController.removeCommand(eventName);
			Assert.fail("removeCommand() should fail for a unregistered commandName");
		} catch (e:CairngormError) {
			verifyMessageCode(CairngormMessageCodes.COMMAND_NOT_REGISTERED, e.message);
		}
	}

	public function testRemoveCommand():Void {
		Assert.isFalse(CairngormEventDispatcher.getInstance().hasEventListener(eventName), "CairngormEventDispatcher should not be listening for event");
		frontController.addCommand(eventName, MockCommand);
		Assert.isTrue(CairngormEventDispatcher.getInstance().hasEventListener(eventName), "CairngormEventDispatcher should be listening for event");

		frontController.removeCommand(eventName);
		Assert.isFalse(CairngormEventDispatcher.getInstance().hasEventListener(eventName), "CairngormEventDispatcher should not be listening for event");
	}

	public function testRemoveCommandCanAddAgain():Void {
		frontController.addCommand(eventName, MockCommand);
		frontController.removeCommand(eventName);
		frontController.addCommand(eventName, MockCommand);

		Assert.isTrue(CairngormEventDispatcher.getInstance().hasEventListener(eventName), "CairngormEventDispatcher should be listening for event");
	}

	private function verifyMessageCode(messageCode:String, message:String):Void {
		Assert.isTrue(message.indexOf(messageCode) == 0, "Message code should be " + messageCode);
	}

	private function createNewEventName():String {
		return "event" + Std.string(Lib.getTimer());
	}
}

private class LocalCommand implements ICommand {
	public function new() {}

	public function execute(event:CairngormEvent):Void {
		TestFrontController.executeCalled = true;
		TestFrontController.dispatchedEvent = event;
	}
}
