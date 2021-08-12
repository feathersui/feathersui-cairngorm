package com.adobe.cairngorm.view;

import openfl.Lib;
import utest.Assert;
import utest.Test;

class TestViewLocator extends Test {
	private var viewName:String;

	public function new() {
		super();
	}

	public function setup():Void {
		viewName = createNewViewName();
	}

	public function teardown():Void {
		ViewLocator.releaseInstance();
	}

	public function testGetInstance():Void {
		Assert.notNull(ViewLocator.getInstance(), "getInstance should not be null");
	}

	public function testGetViewHelperWithNullViewName():Void {
		var viewLocator:ViewLocator = ViewLocator.getInstance();
		try {
			viewLocator.getViewHelper(null);
			Assert.fail("getViewHelper() should fail when null is passed as view name");
		} catch (e:CairngormError) {
			verifyMessageCode(CairngormMessageCodes.VIEW_NOT_FOUND, e.message);
		}
	}

	public function testGetViewHelperWithUnregisteredViewName():Void {
		var viewLocator:ViewLocator = ViewLocator.getInstance();
		try {
			viewLocator.getViewHelper("fake");
			Assert.fail("getViewHelper() should fail when unregistered name is passed as view name");
		} catch (e:CairngormError) {
			verifyMessageCode(CairngormMessageCodes.VIEW_NOT_FOUND, e.message);
		}
	}

	public function testGetViewHelperWithValidViewName():Void {
		var viewLocator:ViewLocator = ViewLocator.getInstance();
		viewLocator.register(viewName, new ViewHelper());
		Assert.notNull(viewLocator.getViewHelper(viewName));
	}

	public function testRegistrationExistsForWithNullViewName():Void {
		var viewLocator:ViewLocator = ViewLocator.getInstance();
		Assert.isFalse(viewLocator.registrationExistsFor(null));
	}

	public function testRegistrationExistsForWithUnregisteredViewName():Void {
		var viewLocator:ViewLocator = ViewLocator.getInstance();
		Assert.isFalse(viewLocator.registrationExistsFor("fake"));
	}

	public function testRegistrationExistsForWithValidViewName():Void {
		var viewLocator:ViewLocator = ViewLocator.getInstance();
		viewLocator.register(viewName, new ViewHelper());
		Assert.isTrue(viewLocator.registrationExistsFor(viewName));
	}

	public function testUnregister():Void {
		var viewLocator:ViewLocator = ViewLocator.getInstance();
		viewLocator.register(viewName, new ViewHelper());
		viewLocator.unregister(viewName);
		Assert.isFalse(viewLocator.registrationExistsFor(viewName));
		try {
			viewLocator.getViewHelper(viewName);
			Assert.fail("getViewHelper() should fail when view name is unregistered");
		} catch (e:CairngormError) {
			verifyMessageCode(CairngormMessageCodes.VIEW_NOT_FOUND, e.message);
		}
	}

	private function verifyMessageCode(messageCode:String, message:String):Void {
		Assert.isTrue(message.indexOf(messageCode) == 0, "Message code should be " + messageCode);
	}

	private function createNewViewName():String {
		return "view" + Std.string(Lib.getTimer());
	}
}
