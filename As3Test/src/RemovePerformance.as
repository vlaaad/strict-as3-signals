/**
 * Author: Vlaaad
 * Date: 08.11.12
 */
package {
import com.example.generated.signals.BlankTestSignal;

import flash.utils.getTimer;

import org.osflash.signals.Signal;

public class RemovePerformance {
	private const ITERATION_COUNT:int = 1000;

	private const s:Signal = new Signal();
	private const strict:BlankTestSignal = new BlankTestSignal();
	private const h0:RemoveSelfHandler = new RemoveSelfHandler(strict);
	private const h1:RemoveSelfHandler = new RemoveSelfHandler(strict);
	private const h2:RemoveSelfHandler = new RemoveSelfHandler(strict);
	private const h3:RemoveSelfHandler = new RemoveSelfHandler(strict);
	private const h4:RemoveSelfHandler = new RemoveSelfHandler(strict);
	private const h5:RemoveSelfHandler = new RemoveSelfHandler(strict);
	private const h6:RemoveSelfHandler = new RemoveSelfHandler(strict);
	private const h7:RemoveSelfHandler = new RemoveSelfHandler(strict);

	public function RemovePerformance() {

	}

	public function start(onComplete:Function):void {
		runAs3Signals();
		runStrictAs3Signals();
		onComplete();
	}

	private function runAs3Signals():void {
		var it:int = ITERATION_COUNT;
		const begin:int = getTimer();
		while(it){
			s.add(l0);
			s.add(l1);
			s.add(l2);
			s.add(l3);
			s.add(l4);
			s.add(l5);
			s.add(l6);
			s.add(l7);
			s.dispatch();
			it--;
		}
		As3Test.log("as3 signals remove performance: " + (getTimer() - begin));
	}

	private function runStrictAs3Signals():void {
		var it:int = ITERATION_COUNT;
		const begin:int = getTimer();
		while(it){
			strict.add(h0);
			strict.add(h1);
			strict.add(h2);
			strict.add(h3);
			strict.add(h4);
			strict.add(h5);
			strict.add(h6);
			strict.add(h7);
			strict.dispatch();
			it--;
		}
		As3Test.log("strict as3 signals remove performance: " + (getTimer() - begin));
	}

	private function l0():void{s.remove(l0);}
	private function l1():void{s.remove(l1);}
	private function l2():void{s.remove(l2);}
	private function l3():void{s.remove(l3);}
	private function l4():void{s.remove(l4);}
	private function l5():void{s.remove(l5);}
	private function l6():void{s.remove(l6);}
	private function l7():void{s.remove(l7);}

}
}

import com.example.generated.signals.BlankTestSignal;
import com.example.generated.signals.IBlankTestSignalHandler;

class RemoveSelfHandler implements IBlankTestSignalHandler {
	private var signal:BlankTestSignal;


	public function RemoveSelfHandler(signal:BlankTestSignal) {
		this.signal = signal;
	}

	public function handleBlankTestSignal():void {
		signal.remove(this);
	}
}