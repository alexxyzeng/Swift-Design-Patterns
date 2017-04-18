//
//  Product.swift
//  SportsStore
//
//  Created by User on 2017/1/3.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class Product: NSObject, NSCopying {
	private (set) var name: String
	private (set) var productDescription: String
//	private (set) var description: String
	private (set) var category: String
	//  设计两个私有的backingValue，用来保证公开的值在合理范围内
	private var stockLevelBackingValue: Int = 0
	private var priceBackingValue: Double = 0
	
	var salesTaxRate: Double = 0.2
	
	required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
		self.name = name
		self.productDescription = description
		self.category = category
		super.init()
		
		self.price = price
		self.stockLevel = stockLevel
	}
	
	class func createProduct(name: String, description: String, category: String, price: Double, stockLevel: Int) -> Product {
		var productType: Product.Type
		switch category {
		case "Watersports":
			productType = WatersportsProduct.self
		case "Soccer":
			productType = SoccerProduct.self
		default:
			productType = Product.self
		}
		
		return productType.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
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
//			return price * Double(stockLevel)
			return (price * (1 + salesTaxRate)) * Double(stockLevel)
		}
	}
	
	func copy(with zone: NSZone? = nil) -> Any {
		return Product(name: name, description: productDescription, category: category, price: price, stockLevel: stockLevel)
	}
	
	var upsells: [UpsellOpportunities] {
		get {
			return Array()
		}
	}
}

enum UpsellOpportunities {
	case SwimmingLessions
	case MapOfLakes
	case SoccerVideos
}

class WatersportsProduct: Product {
	required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
		super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
		salesTaxRate = 0.10
	}
	
	override var upsells: [UpsellOpportunities] {
		return [UpsellOpportunities.SwimmingLessions, UpsellOpportunities.MapOfLakes]
	}
}

class SoccerProduct: Product {
	required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
		super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
		salesTaxRate = 0.25
	}
	
	override var upsells: [UpsellOpportunities] {
		return [UpsellOpportunities.SoccerVideos]
	}
}


class ProductComposite: Product {
	private let products: [Product]
	
	required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
		fatalError("Not implemented")
	}
	
	init(name: String, description: String, category: String, stockLevel: Int, products: Product...) {
		self.products = products
		super.init(name: name, description: description, category: category, price: 0, stockLevel: stockLevel)
	}
	
	override var price: Double {
		get {
			return products.reduce(0, {
				return $0 + $1.price
			})
		}
//		set {
//			
//		}
	}
}
