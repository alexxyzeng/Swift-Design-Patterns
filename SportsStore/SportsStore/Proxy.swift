//
//  Proxy.swift
//  SportsStore
//
//  Created by User on 2017/4/30.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

protocol StockServer {
	func getStockLevel(product: String, callback: (String, Int) -> Void)
	
	func setStockLevel(product: String, stockLevel: Int)
}

class StockServerFactory {
	class func getStockServer() -> StockServer {
		return server
	}
	
	private class var server: StockServer {
		struct singletonWrapper {
			static let singleton = StockServerProxy()
		}
		return singletonWrapper.singleton
	}
}


class StockServerProxy: StockServer {
	func getStockLevel(product: String, callback: (String, Int) -> Void) {
		let stockConn = NetworkPool.getConnection()
		if let level = stockConn.getStockLevel(name: product) {
			callback(product, level)
		}
		NetworkPool.returnConnection(conn: stockConn)
		
	}
	
	func setStockLevel(product: String, stockLevel: Int) {
		let stockConn = NetworkPool.getConnection()
		stockConn.setStockLevel(name: product, level: stockLevel)
		NetworkPool.returnConnection(conn: stockConn)
	}
}
