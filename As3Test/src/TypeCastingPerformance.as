/**
 * Author: Vlaaad
 * Date: 08.11.12
 */
package {
import com.example.generated.signals.ArgsTestSignalSignal;

import flash.utils.getTimer;

import org.osflash.signals.Signal;

public class TypeCastingPerformance {
	private const LISTENERS_COUNT:int = 10;
	private const ITERATION_COUNT:uint = 10000;

	public function TypeCastingPerformance() {
	}

	public function start():void {
		runAs3Signals();
		runStrictAs3Signals();
	}

	private function runAs3Signals():void {
		const s:Signal = new Signal(Object, int, String);
		for (var i:int = 0; i < LISTENERS_COUNT; i++) {
			s.add(function (obj:Object, num:int,  str:String):void {});
		}
		var iteration:uint = ITERATION_COUNT;
		const begin:int = getTimer();
		while (iteration) {
			s.dispatch({a: true}, 1, "hello");
			iteration--;
		}
		As3Test.log("as3 signals type cast performance: " + (getTimer() - begin));
	}

	private function runStrictAs3Signals():void {
		const s:ArgsTestSignalSignal = new ArgsTestSignalSignal();
		for (var i:int = 0; i < LISTENERS_COUNT; i++) {
			s.add(new ArgsHandler());
		}
		var iteration:uint = ITERATION_COUNT;
		const begin:int = getTimer();
		while (iteration) {
			s.dispatch({a: true}, 1, "hello");
			iteration--;
		}
		As3Test.log("strict as3 signal \"type cast\" performance: " + (getTimer() - begin));
	}
}
}

import com.example.generated.signals.IArgsTestSignalHandler;

class ArgsHandler implements IArgsTestSignalHandler {

	public function handleArgsTestSignal(object:Object, count:int, string:String):void {
	}
}