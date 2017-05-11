//: Playground - noun: a place where people can play

import UIKit

@objc class City: NSObject {
	let name: String
	
	init(_ name: String = "") {
		self.name = name
	}
	
	@objc func compareTo(other: City) -> ComparisonResult {
		if name == other.name {
			return .orderedSame
		} else if name < other.name {
			return .orderedAscending
		} else {
			return .orderedDescending
		}
	}

}



let array = Array(arrayLiteral: City("London"), City("New York"), City("Rome"), City("Paris")) as NSArray
let sorted = array.sortedArray(using: #selector(City().compareTo(other:)))

for city in sorted {
	print((city as! City).name)
}



