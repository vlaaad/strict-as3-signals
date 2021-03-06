<#assign params = params!>
<#assign name = name!>
<#assign package = package!>
/**
 * WARNING: THIS FILE IS AUTOGENERATED!
 */
package ${package} {

<#if params?has_content>
    <#assign argNames = params?keys>
    <#list argNames as arg>
        <#assign dispatchClass = params[arg]>
        <#if dispatchClass?split(".")?size != 1 >
import ${params[arg]};
        </#if>
    </#list>
</#if>

public class ${name?cap_first} {
	private var _head:Node;
	private var _tail:Node;

    private var _dispatching:Boolean;
    private var _queueHead:QueueNode;
    private var _queueTail:QueueNode;

public function ${name?cap_first}() {

	}

	public function add(listener:I${name?cap_first}Handler):void {
		register(listener, false);
	}

	public function addOnce(listener:I${name?cap_first}Handler):void {
		register(listener, true);
	}

	private function register(listener:I${name?cap_first}Handler, once:Boolean):void {
		if (_dispatching) {
			addQueueNode(true, once, listener);
			return;
		}
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

	private function addQueueNode(add:Boolean, once:Boolean, listener:I${name?cap_first}Handler):void {
		if (!_queueTail) {
			var queueNode:QueueNode = new QueueNode(add, listener, once);
			_queueHead = queueNode;
			_queueTail = queueNode;
		} else {
			queueNode = new QueueNode(add, listener, once);
			_queueTail.next = queueNode;
			_queueTail = queueNode;
		}
	}

	public function remove(listener:I${name?cap_first}Handler):void {
		if (_dispatching) {
			addQueueNode(false, false, listener);
			return;
		}
		var node:Node = _head;
		var prev:Node = null;
		while (node) {
			if (node.listener == listener) {
				removeNode(prev, node);
                return;
			}
			prev = node;
			node = node.next;
		}
	}

	public function clear():void {
		_head = null;
		_tail = null;
	}

	public function has(listener:I${name?cap_first}Handler):Boolean {
		var exists:Boolean = getNode(listener) != null;
		if (_dispatching) {
			var queueNode:QueueNode = _queueHead;
			while (queueNode) {
				if (queueNode.listener == listener) {
					exists = queueNode.add;
				}
				queueNode = queueNode.next;
			}
		}
		return exists;
	}

	private function getNode(listener:I${name?cap_first}Handler):Node {
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

	public function dispatch(<#if params?has_content><#list argNames as arg>${arg}:${params[arg]}<#if arg_has_next>, </#if></#list></#if>):void {
		var node:Node = _head;
		var prev:Node = null;
        _dispatching = true;
		while (node) {
			node.listener.handle${name?cap_first}(<#if params?has_content><#list argNames as arg>${arg}<#if arg_has_next>, </#if></#list></#if>);
			if (node.once) {
				removeNode(prev, node);
			} else {
                prev = node;
            }
			node = node.next;
		}
		_dispatching = false;

		var queueNode:QueueNode = _queueHead;
		while (queueNode) {
			if (queueNode.add) {
				register(queueNode.listener, queueNode.once);
			} else {
				remove(queueNode.listener);
			}
			queueNode = queueNode.next;
		}
		_queueHead = null;
		_queueTail = null;
	}
}
}

import ${package}.I${name}Handler;

class Node {
	public var next:Node;
	public var listener:I${name?cap_first}Handler;
	public var once:Boolean;

	public function Node(listener:I${name?cap_first}Handler, once:Boolean) {
		this.listener = listener;
		this.once = once;
	}
}
class QueueNode {

	public var add:Boolean;
	public var listener:I${name?cap_first}Handler;
	public var once:Boolean;
	public var next:QueueNode;

	public function QueueNode(add:Boolean, listener:I${name?cap_first}Handler, once:Boolean) {
		this.add = add;
		this.listener = listener;
		this.once = once;
	}
}