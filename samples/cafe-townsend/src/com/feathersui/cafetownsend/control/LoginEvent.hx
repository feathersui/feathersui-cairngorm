/*
	Cafe Townsend MVC Tutorial

	Copyright 2006 Adobe

	Converted to feathersui-cairngorm by Bowler Hat LLC
	https://feathersui.com

	Converted to Cairngorm 2 (Flex) by Darren Houle
	http://www.digimmersion.com

	This is released under a Creative Commons license.
	http://creativecommons.org/licenses/by/2.5/

 */

package com.feathersui.cafetownsend.control;

import com.adobe.cairngorm.control.CairngormEvent;

class LoginEvent extends CairngormEvent {
	public var username:String;
	public var password:String;

	public function new(username:String, password:String) {
		super(AppController.LOGIN_EVENT);
		this.username = username;
		this.password = password;
	}
}
