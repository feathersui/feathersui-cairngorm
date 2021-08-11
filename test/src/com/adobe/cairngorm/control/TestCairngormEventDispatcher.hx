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
import utest.Assert;
import utest.Test;

class TestCairngormEventDispatcher extends Test {
	private var listenerCalled:Bool;
	private var dispatchedEvent:CairngormEvent;

	private var eventName:String;

	public function new() {
		super();
	}

	public function setup():Void {
		listenerCalled = false;
		dispatchedEvent = null;

		eventName = createNewEventName();
	}

	public function teardown():Void {
		CairngormEventDispatcher.releaseInstance();
	}

	public function testGetInstance():Void {
		Assert.notNull(CairngormEventDispatcher.getInstance(), "getInstance should not be null");
	}

	public function testEventDispatched():Void {
		var dispatcher:CairngormEventDispatcher = CairngormEventDispatcher.getInstance();

		dispatcher.addEventListener(eventName, dispatchListener);

		dispatcher.dispatchEvent(new CairngormEvent(eventName));

		Assert.isTrue(listenerCalled, "listenerCalled should be true");
		Assert.notNull(dispatchedEvent, "dispatchedEvent was null");
		Assert.equals(eventName, dispatchedEvent.type);
	}

	public function testRemoveEventListener():Void {
		var dispatcher:CairngormEventDispatcher = CairngormEventDispatcher.getInstance();

		dispatcher.addEventListener(eventName, dispatchListener);
		dispatcher.removeEventListener(eventName, dispatchListener);

		dispatcher.dispatchEvent(new CairngormEvent(eventName));

		Assert.isFalse(listenerCalled, "listenerCalled should not be true");
		Assert.isNull(dispatchedEvent, "dispatchedEvent should be null");
	}

	public function testHasEventListener():Void {
		var dispatcher:CairngormEventDispatcher = CairngormEventDispatcher.getInstance();

		dispatcher.addEventListener(eventName, dispatchListener);

		dispatcher.dispatchEvent(new CairngormEvent(eventName));

		Assert.isTrue(dispatcher.hasEventListener(eventName), "hasEventListener() should be true");
	}

	public function testWillTrigger():Void {
		var dispatcher:CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
		dispatcher.addEventListener(eventName, dispatchListener);

		dispatcher.dispatchEvent(new CairngormEvent(eventName));

		Assert.isTrue(dispatcher.willTrigger(eventName), "willTrigger() should be true");
	}

	private function dispatchListener(event:CairngormEvent):Void {
		listenerCalled = true;
		dispatchedEvent = event;
	}

	private function createNewEventName():String {
		return eventName + Std.string(Lib.getTimer());
	}
}
