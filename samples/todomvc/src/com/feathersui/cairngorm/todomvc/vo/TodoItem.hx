/*
	TodoMVC with Feathers UI and Cairngorm
	Copyright 2022 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package com.feathersui.cairngorm.todomvc.vo;

class TodoItem {
	public function new(?text:String) {
		this.text = text;
	}

	public var text:String;
	public var completed:Bool = false;
}
