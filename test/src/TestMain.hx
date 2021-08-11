import openfl.display.Sprite;
import utest.Runner;
import utest.ui.common.PackageResult;
import utest.ui.common.ResultAggregator;
import utest.ui.text.HtmlReport;

class TestMain extends Sprite {
	public function new() {
		super();

		var runner = new Runner();
		runner.addCase(new com.adobe.cairngorm.control.TestCairngormEvent());
		runner.addCase(new com.adobe.cairngorm.control.TestCairngormEventDispatcher());
		runner.addCase(new com.adobe.cairngorm.control.TestFrontController());
		#if js
		if (#if (haxe_ver >= 4.0) js.Syntax.code #else untyped __js__ #end ("typeof window != 'undefined'")) {
			new HtmlReport(runner, true);
		} else {
			new NoExitPrintReport(runner);
		}
		#else
		new NoExitPrintReport(runner);
		#end
		var aggregator = new ResultAggregator(runner, true);
		aggregator.onComplete.add(aggregator_onComplete);
		runner.run();
	}

	private function aggregator_onComplete(result:PackageResult):Void {
		var stats = result.stats;
		var exitCode = stats.isOk ? 0 : 1;
		var message = 'Successes: ${stats.successes}, Failures: ${stats.failures}, Errors: ${stats.errors}, Warnings: ${stats.warnings}, Skipped: ${stats.ignores}';
		#if html5
		if (exitCode == 0) {
			js.html.Console.info(message);
		} else {
			js.html.Console.error(message);
		}
		#else
		trace(message);
		#end

		#if sys
		Sys.exit(exitCode);
		#elseif html5
		// cast(js.Lib.global, js.html.Window).close();
		#elseif air
		flash.desktop.NativeApplication.nativeApplication.exit(exitCode);
		#elseif flash
		if (flash.system.Security.sandboxType == "localTrusted") {
			flash.system.System.exit(exitCode);
		} else {
			flash.Lib.fscommand("quit");
		}
		#end
	}
}
