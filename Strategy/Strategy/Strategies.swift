//
//  Strategies.swift
//  Strategy
//
//  Created by User on 2017/5/11.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

protocol Strategy {
	func execute(values: [Int]) -> Int
}

class SumStrategy: Strategy {
	func execute(values: [Int]) -> Int {
		return values.reduce(0, { return $0 + $1 })
	}
}

class MultiplyStrategy: Strategy {
	func execute(values: [Int]) -> Int {
		return values.reduce(1, { return $0 * $1 })
	}
}

class ClosureStrategy: Strategy {
	private let closure: ([Int]) -> Int
	
	init(_ closure: @escaping ([Int]) -> Int) {
		self.closure = closure
	}
	
	func execute(values: [Int]) -> Int {
		return closure(values)
	}
}
