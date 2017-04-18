//
//  Spreadsheet.swift
//  Flyweight
//
//  Created by User on 2017/4/18.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation
//  comform to protocol Equatable
func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
	return lhs.col == rhs.col && lhs.row == rhs.row;
}

class Coordinate : Hashable, CustomStringConvertible {
	let col:Character;
	let row:Int;
	
	init(col:Character, row:Int) {
		self.col = col; self.row = row;
	}
	
	var hashValue: Int {
		return description.hashValue;
	}
	
	var description: String {
		return "\(col)\(row)";
	}
}

class Cell {
	var coordinate:Coordinate;
	var value:Int;
	
	init(col:Character, row:Int, val:Int) {
		self.coordinate = Coordinate(col: col, row: row);
		self.value = val;
	}
}

class Spreadsheet {
	var grid: Flyweight
	
	init() {
//		let letters: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
//		var stringIndex = letters.startIndex
//		let rows = 50
//		
//		//  do while 已经改为 repeat while
//		repeat {
//			let colLetter = letters[stringIndex]
//			stringIndex = letters.index(after: stringIndex)
//			for rowIndex in 1...rows {
//				let cell = Cell(col: colLetter, row: rowIndex, val: rowIndex)
//				grid[cell.coordinate] = cell
//			}
//		} while stringIndex != letters.endIndex
		grid = FlyweightFactory.createFlyweight()
	}
	
	func setValue(coord: Coordinate, value: Int) {
		grid[coord] = value
	}
	
	var total: Int {
		return grid.total
	}
}
