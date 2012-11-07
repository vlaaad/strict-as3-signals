/**
 * Author: Vlaaad
 * Date: 07.11.12
 */
package com.example {
public class Attribute {
	private var _name:String;

	public function Attribute(name:String) {
		_name = name;
	}

	public function toString():String {
		return "{" + _name + "}";
	}
}
}
