/**
 * WARNING: THIS FILE IS AUTOGENERATED!
 */
package com.example.generated.signals {


public class BlankTestSignalSignal {
	private var _head:Node;
	private var _tail:Node;

	public function BlankTestSignalSignal() {

	}

	public function add(listener:IBlankTestSignalHandler):void {
		register(listener, false);
	}

	public function addOnce(listener:IBlankTestSignalHandler):void {
		register(listener, true);
	}

	private function register(listener:IBlankTestSignalHandler, once:Boolean):void {
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

	public function remove(listener:IBlankTestSignalHandler):void {
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

	public function has(listener:IBlankTestSignalHandler):Boolean {
		return getNode(listener) != null;
	}

	private function getNode(listener:IBlankTestSignalHandler):Node {
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

	public function dispatch():void {
		var node:Node = _head;
		var prev:Node = null;
		while (node) {
			node.listener.handleBlankTestSignal();
			if (node.once) {
				removeNode(prev, node);
			}
			prev = node;
			node = node.next;
		}
	}
}
}

import com.example.generated.signals.IBlankTestSignalHandler;

class Node {
	public var next:Node;
	public var listener:IBlankTestSignalHandler;
	public var once:Boolean;

	public function Node(listener:IBlankTestSignalHandler, once:Boolean) {
		this.listener = listener;
		this.once = once;
	}
}