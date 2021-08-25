# Cairngorm for OpenFL and Feathers UI

A port of Cairngorm framework to Haxe and OpenFL.

## What is Cairngorm

The Cairngorm Microarchitecture is a lightweight yet prescriptive framework for Rich Internet application (RIA) development.

Cairngorm is an implementation of design patterns that the consultants at Adobe Consulting have successfully taken from enterprise software development (with technologies including J2EE and .NET) and applied rich Internet application development.

## Installation

This library is not yet available on Haxelib, so you'll need to install it and its dependencies from Github.

```sh
haxelib git feathersui-rpc-services https://github.com/feathersui/feathersui-rpc-services.git
haxelib git cairngorm-openfl https://github.com/feathersui/cairngorm-openfl.git
```

## Project Configuration

After installing the libraries above, add them to your OpenFL _project.xml_ file:

```xml
<haxelib name="feathersui-rpc-services" />
<haxelib name="cairngorm-openfl" />
```
