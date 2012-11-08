/**
 * Author: Vlaaad
 * Date: 08.11.12
 */
package {
import com.example.generated.signals.BlankTestSignal;

import flash.utils.getTimer;

import org.osflash.signals.Signal;

public class MassDispatchPerformance {

	private const LISTENERS_COUNT: int = 10000;

	public function MassDispatchPerformance() {
	}

	public function start(onComplete:Function):void {
		runAs3Signals();
		runStrictAs3Signals();
		onComplete();
	}

	private function runAs3Signals():void {
		const s:Signal = new Signal();
		const addBegin:int = getTimer();
		for (var i:int = 0; i < LISTENERS_COUNT; i++) {
			s.add(function ():void {});
		}
		As3Test.log("as3 signals add " + LISTENERS_COUNT + " listeners performance: " + (getTimer() - addBegin));
		const begin:int = getTimer();
		s.dispatch();
		As3Test.log("as3 signals dispatch to " + LISTENERS_COUNT + " listeners performance: " + (getTimer() - begin));
	}

	private function runStrictAs3Signals():void {
		const s:BlankTestSignal = new BlankTestSignal();
		const addBegin:int = getTimer();
		for (var i:int = 0; i < LISTENERS_COUNT; i++) {
			s.add(new EmptyHandler());
		}
		As3Test.log("strict as3 signals add " + LISTENERS_COUNT + " listeners performance: " + (getTimer() - addBegin));
		const begin:int = getTimer();
		s.dispatch();
		As3Test.log("strict as3 signals dispatch to " + LISTENERS_COUNT + " listeners performance: " + (getTimer() - begin));
	}
}
}

import com.example.generated.signals.IBlankTestSignalHandler;

class EmptyHandler implements IBlankTestSignalHandler {

	public function handleBlankTestSignal():void {
	}
}