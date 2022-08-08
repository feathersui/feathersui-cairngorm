# Cairngorm for Feathers UI

A port of Cairngorm framework from [Apache Flex](https://flex.apache.org/) (formerly Adobe Flex) to [Feathers UI](https://feathersui.com/) for [Haxe](https://haxe.org/) and [OpenFL](https://openfl.org/).

## What is Cairngorm?

The Cairngorm Microarchitecture is a lightweight yet prescriptive framework for Rich Internet application (RIA) development.

Cairngorm is an implementation of design patterns that the consultants at Adobe Consulting have successfully taken from enterprise software development (with technologies including J2EE and .NET) and applied rich Internet application development.

## Cairngorm API Overview

### `FrontController`

A subclass of `FrontController` defines global _event_ constants and maps them to _commands_. Typically, a _view_ will dispatch an event, and the front controller will respond by executing the associated command.

```haxe
class MyAppController extends FrontController {
	public static final LOGIN_EVENT = "LOGIN_EVENT";

	public function new() {
		super();
		addCommand(AppController.LOGIN_EVENT, LoginCommand);
	}
}
```

### `IModelLocator`

An `IModelLocator` implementation is a singleton class that stores the application's data model. Typically, data loaded by services gets stored using simple classes called _value objects_ (often abbreviated as _VO_).

```haxe
class MyAppModelLocator extends EventDispatcher implements IModelLocator {
	private static var model:AppModelLocator;

	public var items:ArrayCollection<MyItemVO> = new ArrayCollection();

	private function new() {
		super();
	}

	public static function getInstance():AppModelLocator {
		if (model == null) {
			model = new AppModelLocator();
		}
		return model;
	}
}
```

The model locator may be accessed globally, and is often referenced inside `ICommand` implementations and views.

```haxe
private var model = MyAppModelLocator.getInstance();
```

### `CairngormEvent`

A base class for all events dispatched from views using the `CairngormEventDispatcher`.

```haxe
class LoginEvent extends CairngormEvent {
	public function new(username:String, password:String) {
		super(MyAppController.LOGIN_EVENT);
		this.username = username;
		this.password = password;
	}
	public var username:String;
	public var password:String;
}
```

### `CairngormEventDispatcher`

Used by views to dispatch a `CairngormEvent` to the `FrontController`, which will execute a command using the event's properties.

```haxe
var cgEvent = new LoginEvent(username, password);
CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent);
```

### `ICommand`

Implementations of the `ICommand` interface are executed by the `FrontController` when an associated `CairngormEvent` is dispatched from a view. A command typically calls a service or modifies the model (or both).

```haxe
class LoginCommand implements ICommand {
	private var model = MyAppModelLocator.getInstance();

	public function execute(cgEvent:CairngormEvent):Void {
		var loginEvent = cast(cgEvent, LoginEvent);
		var username = loginEvent.username;
		var password = loginEvent.password;
		// call a service or modify the model
	}
}
```

It's common for an `ICommand` implementation to also implement `IResponder` from the [_feathersui-rpc-services_](https://github.com/feathersui/feathersui-rpc-services/) library to receive the result of a service call.

### `ServiceLocator`

A subclass of `ServiceLocator` stores the services used to send and receive messages with an external data source, such as a REST API or database. Typically, services are instances of the `HTTPService` or `RemoteObject` classes from [_feathersui-rpc-services_](https://github.com/feathersui/feathersui-rpc-services/) library.

```haxe
class Services extends ServiceLocator {
	public var loginService:HTTPService;
	public function new() {
		super();
		loginService = new HTTPService();
		loginService.url = "https://example.com/api/login";
		loginService.resultFormat = HTTPService.RESULT_FORMAT_HAXE_XML;
	}
}
```

## Minimum Requirements

- Haxe 4.2
- OpenFL 9.2.0
- Feathers UI 1.0

## Installation

This library is not yet available on Haxelib, so you'll need to install it and its dependencies from Github.

```sh
haxelib git feathersui-cairngorm https://github.com/feathersui/feathersui-cairngorm.git
```

## Project Configuration

After installing the library above, add it to your OpenFL _project.xml_ file:

```xml
<haxelib name="feathersui-cairngorm" />
```

## Documentation

- [API Reference](https://api.feathersui.com/feathersui-cairngorm/)
