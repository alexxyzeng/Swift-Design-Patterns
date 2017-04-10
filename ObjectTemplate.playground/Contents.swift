//: Playground - noun: a place where people can play

import UIKit

class Product {
	var name: String
	var price: Double
	
	fileprivate var stockBackingValue = 0
	
	var stock: Int {
		get {
			return stockBackingValue
		}
		set {
			stockBackingValue = newValue
			print(stock)
		}
	}
	
	init(name: String, price: Double, stock: Int) {
		self.name = name
		self.price = price
		self.stock = stock
	}
	
	func calculateTax(_ rate: Double) -> Double {
		return min(10, price * rate)
	}
	
	var stockValue: Double {
		get {
			return price * Double(stock)
		}
	}
}

var products = [
	Product(name: "Kayak", price: 275, stock: 10),
	Product(name: "Lifejacket", price: 48.95, stock: 14),
	Product(name: "Soccer Ball", price: 19.5, stock: 32)
];

func calculateTax(_ productsArr: [Product], rate: Double) -> Double {
	return productsArr.reduce(0, {
		return $0 + $1.calculateTax(rate)
	})
}

func calculateStockValue(_ productsArr: [Product]) -> Double {
	return productsArr.reduce(0, {
		print($1.stockValue)
		return $0 + $1.stockValue
	})
}

print("Sales tax for Kayak: $\(products[0].calculateTax(0.2))");
print("Total value of stock: $\(calculateStockValue(products))");
//products[0].stock = -50;
print("Stock Level for Kayak: \(products[0].stock)");
