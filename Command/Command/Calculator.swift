//
//  Calculator.swift
//  Command
//
//  Created by User on 2017/5/6.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation
import Foundation;

class Calculator {
	fileprivate(set) var total = 0;
	typealias CommandClosure = ((Calculator) -> Void);
	fileprivate var history = [CommandClosure]();
	fileprivate var queue = DispatchQueue(label: "arrayQ", attributes: []);
	
	func add(amount:Int) {
		addMacro(Calculator.add, amount: amount);
		total += amount;
	}
	
	func subtract(amount:Int) {
		addMacro(Calculator.subtract, amount: amount);
		total -= amount;
	}
	
	func multiply(amount:Int) {
		addMacro(Calculator.multiply, amount: amount);
		total = total * amount;
	}
	
	func divide(amount:Int) {
		addMacro(Calculator.divide, amount: amount);
		total = total / amount;
	}
	
	fileprivate func addMacro(_ method:@escaping (Calculator) -> (Int) -> Void, amount:Int) {
		self.queue.sync(execute: {() in
			self.history.append({ calc in  method(calc)(amount)});
		});
	}
	
	func getMacroCommand() -> ((Calculator) -> Void) {
		var commands = [CommandClosure]();
		queue.sync(execute: {() in
			commands = self.history
		});
		return { calc in
			if (commands.count > 0) {
				for index in 0 ..< commands.count {
					commands[index](calc);
				}
			}
		};
	}
}

