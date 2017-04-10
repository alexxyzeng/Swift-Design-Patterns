//
//  Product.swift
//  SportsStore
//
//  Created by User on 2017/1/3.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class Product {
	private (set) var name: String
	private (set) var description: String
	private (set) var category: String
	//  设计两个私有的backingValue，用来保证公开的值在合理范围内
	private var stockLevelBackingValue: Int = 0
	private var priceBackingValue: Double = 0
	
	init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
		self.name = name
		self.description = description
		self.category = category
		self.price = price
		self.stockLevel = stockLevel
	}
	//  对外公开的属性
	var stockLevel: Int {
		get {
			return stockLevelBackingValue
		}
		set {
			stockLevelBackingValue = max(0, newValue)
		}
	}
	
	private (set) var price: Double {
		get {
			return priceBackingValue
		}
		set {
			priceBackingValue = max(1, newValue)
		}
	}
	
	//  calculated property
	var stockValue: Double {
		get {
			return price * Double(stockLevel)
		}
	}
}
