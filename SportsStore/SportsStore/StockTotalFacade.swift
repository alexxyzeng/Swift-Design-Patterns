//
//  StockTotalFacade.swift
//  SportsStore
//
//  Created by User on 2017/4/18.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class StockTotalFacade {
	enum Currency {
		case USD
		case GBP
		case EUR
	}
	
	class func formatCurrencyFormat(amount: Double, currency: Currency) -> String? {
		var stfCurrency: StockTotalFactory.Currency
		switch currency {
		case .EUR:
			stfCurrency = StockTotalFactory.Currency.EUR
		case .GBP:
			stfCurrency = StockTotalFactory.Currency.GBP
		case .USD:
			stfCurrency = StockTotalFactory.Currency.USD
		}
		
		let factory = StockTotalFactory.getFactory(curr: stfCurrency)
		let totalAmount = factory.converter?.convertTotal(total: amount)
		if totalAmount != nil {
			guard  let formattedValue = factory.formatter?.formatTotal(total: totalAmount!) else {
				return nil
			}
			return formattedValue
		}
		return nil
	}
}
