/**
 * WARNING: THIS FILE IS AUTOGENERATED!
 */
package com.example.generated.signals {


public class ArgsTestSignalSignal {
	private var _head:Node;
	private var _tail:Node;

	public function ArgsTestSignalSignal() {

	}

	public function add(listener:IArgsTestSignalHandler):void {
		register(listener, false);
	}

	public function addOnce(listener:IArgsTestSignalHandler):void {
		register(listener, true);
	}

	private function register(listener:IArgsTestSignalHandler, once:Boolean):void {
		var node:Node = getNode(listener);
		if (node) {
			if (node.once) throw new Error("Illegal operation: adding listener that was added once");
			return;
		}
		node = new Node(listener, once);
		if (_tail) {
			_tail.next = node;
			_tail = node;
		} else {
			_head = node;
			_tail = node;
		}
	}

	public function remove(listener:IArgsTestSignalHandler):void {
		var node:Node = _head;
		var prev:Node = null;
		while (node) {
			if (node.listener == listener) {
				removeNode(prev, node);
			}
			prev = node;
			node = node.next;
		}
	}

	public function clear():void {
		_head = null;
		_tail = null;
	}

	public function has(listener:IArgsTestSignalHandler):Boolean {
		return getNode(listener) != null;
	}

	private function getNode(listener:IArgsTestSignalHandler):Node {
		var node:Node = _head;
		while (node) {
			if (node.listener == listener) return node;
			node = node.next;
		}
		return null;
	}

	private function removeNode(prev:Node, node:Node):void {
	    if (prev) {
	        if (node.next) {
                prev.next = node.next;
	        } else {
                prev.next = null;
                _tail = prev;
	        }
	    } else {
	        if (node.next) {
                _head = node.next;
	        } else {
	            _head = null;
	            _tail = null;
	        }
	    }
	}

	public function dispatch(object:Object, count:int, string:String):void {
		var node:Node = _head;
		var prev:Node = null;
		while (node) {
			node.listener.handleArgsTestSignal(object, count, string);
			if (node.once) {
				removeNode(prev, node);
			}
			prev = node;
			node = node.next;
		}
	}
}
}

import com.example.generated.signals.IArgsTestSignalHandler;

class Node {
	public var next:Node;
	public var listener:IArgsTestSignalHandler;
	public var once:Boolean;

	public function Node(listener:IArgsTestSignalHandler, once:Boolean) {
		this.listener = listener;
		this.once = once;
	}
}