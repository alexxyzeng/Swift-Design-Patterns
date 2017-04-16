//
//  Euro.swift
//  SportsStore
//
//  Created by User on 2017/4/16.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class EuroHandler {
	func getDisplayString(amount: Double) -> String {
		let formatted = Utils.currencyStringFromNumber(number: amount)
		return "€\(formatted)"
	}
	
	func getCurrencyAmount(amount: Double) -> Double {
		return 0.76164 * amount
	}
}
