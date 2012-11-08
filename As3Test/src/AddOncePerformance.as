/**
 * Author: Vlaaad
 * Date: 08.11.12
 */
package {
import com.example.generated.signals.BlankTestSignal;

import flash.utils.getTimer;

import org.osflash.signals.Signal;

public class AddOncePerformance {

	private const ITERATION_COUNT:uint = 10000;

	private var _s:Signal;
	private var _strictS:BlankTestSignal;

	private var n0:EmptyHandler = new EmptyHandler();
	private var n1:EmptyHandler = new EmptyHandler();
	private var n2:EmptyHandler = new EmptyHandler();
	private var n3:EmptyHandler = new EmptyHandler();
	private var n4:EmptyHandler = new EmptyHandler();
	private var n5:EmptyHandler = new EmptyHandler();
	private var n6:EmptyHandler = new EmptyHandler();
	private var n7:EmptyHandler = new EmptyHandler();

	public function AddOncePerformance() {
		_s = new Signal();
		_strictS = new BlankTestSignal();

	}

	public function start(onCompleteCallBack:Function):void {
		runAs3Signals();
		runStrictAs3Signals();
		onCompleteCallBack();
	}

	private function runAs3Signals():void {
		const begin:int = getTimer();
		var iterations:uint = ITERATION_COUNT;
		while (iterations) {
			_s.addOnce(l0);//2**(4-1)=8
			_s.addOnce(l1);
			_s.addOnce(l2);
			_s.addOnce(l3);
			_s.addOnce(l4);
			_s.addOnce(l5);
			_s.addOnce(l6);
			_s.addOnce(l7);
			_s.dispatch();
			iterations--;
		}
		As3Test.log("as3 signals add once performance: " + (getTimer() - begin));
	}

	private function runStrictAs3Signals():void {
		const begin:int = getTimer();
		var iterations:uint = ITERATION_COUNT;
		while (iterations) {
			_strictS.addOnce(n0);
			_strictS.addOnce(n1);
			_strictS.addOnce(n2);
			_strictS.addOnce(n3);
			_strictS.addOnce(n4);
			_strictS.addOnce(n5);
			_strictS.addOnce(n6);
			_strictS.addOnce(n7);
			_strictS.dispatch();
			iterations--;
		}
		As3Test.log("strict as3 signals add once performance: " + (getTimer() - begin));
	}

	private function l0():void { }

	private function l1():void { }

	private function l2():void { }

	private function l3():void { }

	private function l4():void { }

	private function l5():void { }

	private function l6():void { }

	private function l7():void { }
}
}

import com.example.generated.signals.IBlankTestSignalHandler;

class EmptyHandler implements IBlankTestSignalHandler {

	public function handleBlankTestSignal():void {

	}
}