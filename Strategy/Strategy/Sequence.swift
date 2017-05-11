//
//  Sequence.swift
//  Strategy
//
//  Created by User on 2017/5/11.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

final class Sequence {
	private var numbers: [Int]
	
	init(_ numbers: Int...) {
		self.numbers = numbers
	}
	
	func addNumber(_ value: Int) {
		numbers.append(value)
	}
	
	func compute(strategy: Strategy) -> Int {
		return strategy.execute(values: numbers)
	}
}
