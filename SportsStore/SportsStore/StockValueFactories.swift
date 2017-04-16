//
//  StockValueFactories.swift
//  SportsStore
//
//  Created by User on 2017/4/16.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class StockTotalFactory {
	enum Currency {
		case USD
		case GBP
	}
	
	var formatter: StockValueFormatter?
	var converter: StockValueConverter?
	
	class func getFactory(curr: Currency) -> StockTotalFactory {
		if curr == .USD {
			return DollarStockTotalFactory.sharedInstance
		}
		return PoundStockTotalFactory.sharedInstance
	}
}

private class DollarStockTotalFactory: StockTotalFactory {
	override init() {
		super.init()
		formatter = DollarStockValueFormatter()
		converter = DollarStockValueConverter()
	}
	
	class var sharedInstance: StockTotalFactory {
		get {
			struct SingletonWrapper {
				static let singleton = DollarStockTotalFactory()
			}
			return SingletonWrapper.singleton
		}
	}
}

private class PoundStockTotalFactory: StockTotalFactory {
	override init() {
		super.init()
		formatter = DollarStockValueFormatter()
		converter = DollarStockValueConverter()
	}
	
	class var sharedInstance: StockTotalFactory {
		get {
			struct SingletonWrapper {
				static let singleton = PoundStockTotalFactory()
			}
			return SingletonWrapper.singleton
		}
	}
}
