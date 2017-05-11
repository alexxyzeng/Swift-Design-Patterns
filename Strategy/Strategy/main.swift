//
//  main.swift
//  Strategy
//
//  Created by User on 2017/5/11.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

let sequence = Sequence(1, 2, 3, 4)

let sumStrategy = SumStrategy()
let multiplyStrategy = MultiplyStrategy()

sequence.addNumber(10)
sequence.addNumber(20)

let sum = sequence.compute(strategy: sumStrategy)
print("Sum: \(sum)")

let multiply = sequence.compute(strategy: multiplyStrategy)
print("Multiply: \(multiply)")

let filterThreshold = 10
let cstrategy = ClosureStrategy { (values) -> Int in
	return values.filter({
		$0 < filterThreshold
	}).reduce(0, { $0 + $1 })
}

let filteredSum = sequence.compute(strategy: cstrategy)
print("Filtered Sum: \(filteredSum)")

