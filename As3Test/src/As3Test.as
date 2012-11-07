package {

import com.example.Attribute;
import com.example.generated.signals.CustomClassesTestSignalSignal;
import com.example.generated.signals.ICustomClassesTestSignalHandler;

import flash.display.Sprite;

import org.hamcrest.assertThat;
import org.hamcrest.core.not;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.nullValue;

public class As3Test extends Sprite implements ICustomClassesTestSignalHandler {
	private var attribute:Attribute;
	private var value:int;
	private var handleCount:int;

	public function As3Test() {
		const hp:Attribute = new Attribute("hp");
		const damage:Attribute = new Attribute("damage");
		const exp:Attribute = new Attribute("exp");

		//basic adding
		const signal:CustomClassesTestSignalSignal = new CustomClassesTestSignalSignal();
		var currentCount:int = handleCount;
		signal.add(this);
		signal.dispatch(damage, 1);
		assertThat("handler receives all dispatched values", attribute, equalTo(damage));
		assertThat("handler receives all dispatched values", value, equalTo(1));
		assertThat("handler called once per dispatch", handleCount, equalTo(currentCount + 1));

		//basic removing
		signal.remove(this);
		signal.dispatch(exp, 2);
		assertThat("after handler removed, it is not called", attribute, not(equalTo(exp)));
		assertThat("after handler removed, it is not called", value, not(equalTo(2)));
		assertThat("after handler removed, it is not called", handleCount, not(equalTo(currentCount + 2)));

		//basic clearing
		signal.add(this);
		signal.clear();
		signal.dispatch(hp, 3);
		assertThat("after clearing handler not called", attribute, not(equalTo(hp)));
		assertThat("after clearing handler not called", value, not(equalTo(3)));

		//once handling
		signal.addOnce(this);
		currentCount = handleCount;
		signal.dispatch(hp, 4);
		assertThat("added once handler receives first dispatch", attribute, equalTo(hp));
		assertThat("added once handler receives first dispatch", value, equalTo(4));
		assertThat("handler added once called once per dispatch", handleCount, equalTo(currentCount + 1));
		signal.dispatch(damage, 5);
		assertThat("added once handler is not called second time", attribute, not(equalTo(damage)));
		assertThat("added once handler is not called second time", value, not(equalTo(5)));
		assertThat("added once handler is not called second time", handleCount, equalTo(currentCount + 1));
		signal.clear();

		//multiple handler handling
		var a:Handler = new Handler();
		var b:Handler = new Handler();
		var c:Handler = new Handler();
		signal.add(a);
		signal.add(b);
		signal.add(c);
		signal.dispatch(exp, 6);
		assertThat("every handler receives dispatched params", a.attribute, equalTo(exp));
		assertThat("every handler receives dispatched params", b.attribute, equalTo(exp));
		assertThat("every handler receives dispatched params", c.attribute, equalTo(exp));
		signal.clear();
		signal.dispatch(hp, 7);
		assertThat("after clearing no handlers receive dispatched params", a.attribute, not(equalTo(hp)));
		assertThat("after clearing no handlers receive dispatched params", b.attribute, not(equalTo(hp)));
		assertThat("after clearing no handlers receive dispatched params", c.attribute, not(equalTo(hp)));

		//remove first handling
		a = new Handler();
		b = new Handler();
		c = new Handler();
		signal.add(a);
		signal.add(b);
		signal.add(c);
		signal.remove(a);
		signal.dispatch(damage, 8);
		assertThat("removed first handler does not receive dispatched params", a.attribute, nullValue());
		assertThat("after removing first handler other handlers receive dispatched params", b.attribute, equalTo(damage));
		assertThat("after removing first handler other handlers receive dispatched params", c.attribute, equalTo(damage));
		signal.clear();

		//remove last handling
		a = new Handler();
		b = new Handler();
		c = new Handler();
		signal.add(a);
		signal.add(b);
		signal.add(c);
		signal.remove(c);
		signal.dispatch(hp, 9);
		assertThat("removed last handler does not receive dispatched params", c.attribute, nullValue());
		assertThat("after removing last handler other handlers receive dispatched params", a.attribute, equalTo(hp));
		assertThat("after removing last handler other handlers receive dispatched params", b.attribute, equalTo(hp));
		signal.clear();

		//remove middle handling
		a = new Handler();
		b = new Handler();
		c = new Handler();
		signal.add(a);
		signal.add(b);
		signal.add(c);
		signal.remove(b);
		signal.dispatch(exp, 10);
		assertThat("removed middle handler does not receive dispatched params", b.attribute, nullValue());
		assertThat("after removing middle handler other handlers receive dispatched params", a.attribute, equalTo(exp));
		assertThat("after removing middle handler other handlers receive dispatched params", c.attribute, equalTo(exp));
		signal.clear();

		//multi dispatch with added once first
		a = new Handler();
		b = new Handler();
		c = new Handler();
		signal.addOnce(a);
		signal.add(b);
		signal.add(c);
		signal.dispatch(hp, 11);
		assertThat("with first added once handler on first dispatch all handlers receive dispatched params", a.attribute, equalTo(hp));
		assertThat("with first added once handler on first dispatch all handlers receive dispatched params", b.attribute, equalTo(hp));
		assertThat("with first added once handler on first dispatch all handlers receive dispatched params", c.attribute, equalTo(hp));
		signal.dispatch(damage, 12);
		assertThat("on second dispatch added once as first handler do not receive dispatched params", a.attribute, not(equalTo(damage)));
		assertThat("on second dispatch with added once as first handler other receive dispatched params", b.attribute, equalTo(damage));
		assertThat("on second dispatch with added once as first handler other receive dispatched params", c.attribute, equalTo(damage));
		signal.clear();

		//multi dispatch with added once in a middle
		a = new Handler();
		b = new Handler();
		c = new Handler();
		signal.add(a);
		signal.addOnce(b);
		signal.add(c);
		signal.dispatch(exp, 13);
		assertThat("with middle added once handler on first dispatch all handlers receive dispatched params", a.attribute, equalTo(exp));
		assertThat("with middle added once handler on first dispatch all handlers receive dispatched params", b.attribute, equalTo(exp));
		assertThat("with middle added once handler on first dispatch all handlers receive dispatched params", c.attribute, equalTo(exp));
		signal.dispatch(damage, 14);
		assertThat("on second dispatch added once to middle handler do not receive dispatched params", a.attribute, equalTo(damage));
		assertThat("on second dispatch with added once to middle handler other receive dispatched params", b.attribute, not(equalTo(damage)));
		assertThat("on second dispatch with added once to middle handler other receive dispatched params", c.attribute, equalTo(damage));
		signal.clear();

		//multi dispatch with added once last
		a = new Handler();
		b = new Handler();
		c = new Handler();
		signal.add(a);
		signal.add(b);
		signal.addOnce(c);
		signal.dispatch(exp, 15);
		assertThat("with last added once handler on first dispatch all handlers receive dispatched params", a.attribute, equalTo(exp));
		assertThat("with last added once handler on first dispatch all handlers receive dispatched params", b.attribute, equalTo(exp));
		assertThat("with last added once handler on first dispatch all handlers receive dispatched params", c.attribute, equalTo(exp));
		signal.dispatch(hp, 16);
		assertThat("on second dispatch added once as last handler do not receive dispatched params", a.attribute, equalTo(hp));
		assertThat("on second dispatch with added once as last handler other receive dispatched params", b.attribute, equalTo(hp));
		assertThat("on second dispatch with added once as last handler other receive dispatched params", c.attribute, not(equalTo(hp)));
		signal.clear();

		//removing non existed
		a = new Handler();
		b = new Handler();
		signal.remove(a);
		signal.add(b);
		signal.remove(a);
		signal.dispatch(exp, 17);
		assertThat("after removing non registered handler registered receive dispatched values", b.attribute, equalTo(exp));
		assertThat("removing non registered handler does not make it receive dispatched values", a.attribute, nullValue());
		signal.clear();

		//has
		a = new Handler();
		b = new Handler();
		signal.add(a);
		assertThat("has method returns true if handler is added", signal.has(a), isTrue());
		assertThat("has method returns false if handler is not added", signal.has(b), isFalse());
		signal.addOnce(b);
		assertThat("has method return true if handler added once", signal.has(b), isTrue());
		signal.clear();

		//add handler while handling
		a = new Handler();
		var d:AddHandlerOnHandleHandler = new AddHandlerOnHandleHandler(signal, a);
		signal.add(d);
		signal.dispatch(damage, 18);
		assertThat("after dispatch signal has added while dispatching handlers", signal.has(a), isTrue());
		assertThat("if handler is added while handling, it will not receive dispatched params", a.attribute, nullValue());
		signal.clear();

		//remove handler while handling
		a = new Handler();
		var e:RemoveHandlerOnHandleHandler = new RemoveHandlerOnHandleHandler(signal, a);
		signal.add(e);
		signal.add(a);
		signal.dispatch(exp, 19);
		assertThat("after dispatch signal do not have removed while dispatch handler", signal.has(a), isFalse());
		assertThat("if registered handler was removed while handling, it will receive dispatched params in this dispatch", a.attribute, equalTo(exp));
		signal.dispatch(damage, 20);
		assertThat("on next dispatch handler removed while previous dispatching will not receive dispatched params", a.attribute, not(equalTo(damage)));

	}

	public function handleCustomClassesTestSignal(attribute:Attribute, value:int):void {
		this.attribute = attribute;
		this.value = value;
		handleCount++;
	}
}
}

import com.example.Attribute;
import com.example.generated.signals.CustomClassesTestSignalSignal;
import com.example.generated.signals.ICustomClassesTestSignalHandler;

import org.hamcrest.assertThat;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;

class Handler implements ICustomClassesTestSignalHandler {
	public var attribute:Attribute;
	public var value:int;

	public function handleCustomClassesTestSignal(attribute:Attribute, value:int):void {
		this.attribute = attribute;
		this.value = value;
	}
}

class AddHandlerOnHandleHandler implements ICustomClassesTestSignalHandler {
	private var signal:CustomClassesTestSignalSignal;
	private var toAdd:ICustomClassesTestSignalHandler;

	public function AddHandlerOnHandleHandler(signal:CustomClassesTestSignalSignal, toAdd:ICustomClassesTestSignalHandler) {
		this.signal = signal;
		this.toAdd = toAdd;

	}

	public function handleCustomClassesTestSignal(attribute:Attribute, value:int):void {
		signal.add(toAdd);
		assertThat("on adding while dispatching has method returns true for added handler", signal.has(toAdd), isTrue());
	}
}

class RemoveHandlerOnHandleHandler implements ICustomClassesTestSignalHandler {
	private var signal:CustomClassesTestSignalSignal;
	private var toRemove:ICustomClassesTestSignalHandler;

	public function RemoveHandlerOnHandleHandler(signal:CustomClassesTestSignalSignal, toRemove:ICustomClassesTestSignalHandler) {
		this.signal = signal;
		this.toRemove = toRemove;
	}

	public function handleCustomClassesTestSignal(attribute:Attribute, value:int):void {
		signal.remove(toRemove);
		assertThat("on removing while dispatching has method returns false for removed handler", signal.has(toRemove), isFalse());
	}
}