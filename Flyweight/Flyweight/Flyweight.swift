//
//  Flyweight.swift
//  Flyweight
//
//  Created by User on 2017/4/18.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

protocol Flyweight {
	subscript(index: Coordinate) -> Int? { get set }
	
	var total: Int { get }
	var count: Int { get }
}

extension Dictionary {
	init(setupFunc: (() -> [(Key, Value)])) {
		self.init()
		for item in setupFunc() {
			self[item.0] = item.1
		}
	}
}

class FlyweightFactory {
	class func createFlyweight() -> Flyweight {
		return FlyweightImplementation(extrinsic: extrinsicData)
	}
	//  外部数据，一个单例，可以共享，不可变
	private class var extrinsicData: [Coordinate: Cell] {
		get {
			struct singletonWrapper {
				static let singletonData = Dictionary<Coordinate, Cell> { () -> [(Coordinate, Cell)] in
					var results = [(Coordinate, Cell)]()
					let letters: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
					var stringIndex = letters.startIndex
					let rows = 50
					repeat {
						let colLetter = letters[stringIndex]
						stringIndex = letters.index(after: stringIndex)
						for rowIndex in 1...rows {
							let cell = Cell(col: colLetter, row: rowIndex, val: rowIndex)
							results.append((cell.coordinate, cell))
						}
					} while stringIndex != letters.endIndex
					return results
				}
			}
			return singletonWrapper.singletonData
		}
	}
}


class FlyweightImplementation: Flyweight {
	private let extrinsicData: [Coordinate: Cell]
	private var intrinsicData: [Coordinate: Cell]
	private let queue: DispatchQueue
	
	fileprivate init(extrinsic: [Coordinate: Cell]) {
		self.extrinsicData = extrinsic
		self.intrinsicData = Dictionary<Coordinate, Cell>()
		self.queue = DispatchQueue(label: "dataQ", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
	}
	
	//  下标方法
	subscript(key: Coordinate) -> Int? {
		get {
			var result: Int?
			//  先从内部数据中取值，如果没有再去外部数据中取值
			queue.sync {
				if let cell = intrinsicData[key] {
					result = cell.value
				} else {
					result = extrinsicData[key]?.value
				}
			}
			return result
		}
		set (value) {
			if value != nil {
				//  将数据写入到内部数据，不共享
				queue.async(group: nil, qos: .default, flags: .barrier, execute: { 
					self.intrinsicData[key] = Cell(col: key.col, row: key.row, val: value!)
				})
			}
		}
	}
	
	var total: Int {
		var result = 0
		queue.sync {
			//  优先从内部数据中取值，没有则从外部数据中取值
			result = extrinsicData.values.reduce(0, {
				guard let intrinsicCell = self.intrinsicData[$1.coordinate] else {
					return $0 + $1.value
				}
				return $0 + intrinsicCell.value
			})
		}
		return result
	}
	
	var count: Int {
		var result = 0
		//  获取内部数据的总数
		queue.sync {
			result = intrinsicData.count
		}
		return result
	}
}
