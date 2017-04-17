//
//  ProductDecorators.swift
//  SportsStore
//
//  Created by User on 2017/4/17.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class PriceDecorator: Product {
	fileprivate let wrappedProduct: Product
	
	required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
		fatalError("Not supported")
	}
	
	init(product: Product) {
		self.wrappedProduct = product
		super.init(name: product.name, description: product.description, category: product.description, price: product.price, stockLevel: product.stockLevel)
	}
}

class LowStockIncreaseDecorator: PriceDecorator {
	override var price: Double {
		var price = wrappedProduct.price
		if stockLevel < 4 {
			price = price * 1.5
		}
		return price
	}
}

class SoccerDecreaseDecorator: PriceDecorator {
	override var price: Double {
		return super.wrappedProduct.price * 0.5
	}
}
