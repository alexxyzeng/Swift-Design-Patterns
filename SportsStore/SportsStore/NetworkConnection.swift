//
//  NetworkConnection.swift
//  SportsStore
//
//  Created by User on 2017/4/12.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class NetworkConnection {
	private let flyweight: NetConnFlyweight
//	private let stockData: [String: Int] = [
//		"Kayak": 10, "Lifejacket": 14, "Soccer Ball": 32, "Corner Flags": 1,
//		"Stadium": 4, "Thinking Cap": 8, "Unsteady Chair": 3,
//		"Human Chess Board": 2, "Bling-Bling King": 4
//	]
	init() {
		self.flyweight = NetConnFlyweightFactory.createFlyweight()
	}
	
	func getStockLevel(name: String) -> Int? {
		Thread.sleep(forTimeInterval: Double(arc4random() % 2))
		return flyweight.getStockLevel(name: name)
	}
	
	func setStockLevel(name: String, level: Int) {
		print("Stock update: \(name) = \(level)")
	}
}
