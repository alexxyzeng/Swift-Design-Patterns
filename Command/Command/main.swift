//
//  main.swift
//  Command
//
//  Created by User on 2017/5/6.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

let calc = Calculator()

calc.add(amount: 10)
calc.multiply(amount: 4)
calc.subtract(amount: 2)

//for _ in 0..<3 {
//	calc.undo()
//	print("Total: \(calc.total)")
//}

//let snapshot = calc.getHistorySnapshot()
//
//print("Pre-Snapshot Total: \(calc.total)")
//snapshot?.execute()
//print("Post-Snapshot Total: \(calc.total)")

print("Calc 1 Total: \(calc.total)")

let calc2 = Calculator()

let macro = calc.getMacroCommand()
macro(calc2)
//macro?.execute(receiver: calc2)

print("Calc 2 Total: \(calc2.total)")
