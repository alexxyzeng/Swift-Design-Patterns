//: Playground - noun: a place where people can play

import UIKit

class Sum: NSObject, NSCopying {
	var resultsCache: [[Int]]
	var firstValue: Int
	var secondeValue: Int
	
	init(first: Int, second: Int) {
		resultsCache = [[Int]](repeating: [Int](repeating: 0, count: 10), count: 10)
		for i in 0..<10 {
			for j in 0..<10 {
				resultsCache[i][j] = i + j
			}
		}
		self.firstValue = first
		self.secondeValue = second
	}
	
	private init(first: Int, second: Int, cache: [[Int]]) {
		self.firstValue = first
		self.secondeValue = second
		self.resultsCache = cache
	}
	
	var result: Int {
		get {
			return firstValue < resultsCache.count
				&& secondeValue < resultsCache[firstValue].count
				? resultsCache[firstValue][secondeValue]
				: firstValue + secondeValue
		}
	}
	
	func copy(with zone: NSZone? = nil) -> Any {
		return Sum(first: firstValue, second: secondeValue, cache: resultsCache)
	}
}
//  每次创建都要经过cacheSize * cacheSize次的计算
//var calc1 = Sum(first: 0, second: 9, cacheSize: 100).result
//var calc2 = Sum(first: 3, second: 8, cacheSize: 20).result

//  深复制
var prototype = Sum(first: 0, second: 9)

var calc1 = prototype.result
var clone = prototype.copy() as! Sum
clone.firstValue = 3
clone.secondeValue = 8
var calc2 = clone.result


