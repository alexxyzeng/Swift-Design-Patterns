//
//  StockvalueImplementations.swift
//  SportsStore
//
//  Created by User on 2017/4/16.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

protocol StockValueFormatter {
	func formatTotal(total: Double) -> String
}

class DollarStockValueFormatter: StockValueFormatter {
	func formatTotal(total: Double) -> String {
		let formatted = Utils.currencyStringFromNumber(number: total)
		return "\(formatted)"
	}
}

class PoundStockValueFormatter: StockValueFormatter {
	func formatTotal(total: Double) -> String {
		let formatted = Utils.currencyStringFromNumber(number: total)
		return "£\(formatted.characters.dropFirst())"
	}
}

protocol StockValueConverter {
	func convertTotal(total: Double) -> Double
}

class DollarStockValueConverter: StockValueConverter {
	func convertTotal(total: Double) -> Double {
		return total
	}
}

class PoundStockValueConverter: StockValueConverter {
	func convertTotal(total: Double) -> Double {
		return total * 0.60338
	}
}
