/**
 * Author: Vlaaad
 * Date: 08.11.12
 */
package {
import com.example.generated.signals.BlankTestSignalSignal;

import flash.utils.getTimer;

import org.osflash.signals.Signal;

public class DispatchPerformance {
	private const LISTENERS_COUNT:uint = 8;
	private const ITERATION_COUNT:uint = 10000;

	public function DispatchPerformance() {

	}

	public function start(onComplete:Function):void {
		runAs3Signals();
		runStrictSignals();
		onComplete();
	}

	private function runAs3Signals():void {
		const s:Signal = new Signal();
		for (var i:int = 0; i < LISTENERS_COUNT; i++) {
			s.add(function ():void {});
		}
		var iteration:uint = ITERATION_COUNT;
		const begin:int = getTimer();
		while (iteration) {
			s.dispatch();
			iteration--;
		}
		As3Test.log("as3 signals dispatch performance: " + (getTimer() - begin));
	}

	private function runStrictSignals():void {
		const s:BlankTestSignalSignal = new BlankTestSignalSignal();
		for (var i:int = 0; i < LISTENERS_COUNT; i++) {
			s.add(new EmptyHandler());
		}
		var iteration:uint = ITERATION_COUNT;
		const begin:int = getTimer();
		while (iteration) {
			s.dispatch();
			iteration--;
		}
		As3Test.log("strict as3 signals dispatch performance: " + (getTimer() - begin));
	}
}
}

import com.example.generated.signals.IBlankTestSignalHandler;

class EmptyHandler implements IBlankTestSignalHandler{

	public function handleBlankTestSignal():void {
	}
}