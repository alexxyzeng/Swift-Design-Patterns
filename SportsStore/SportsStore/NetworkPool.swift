//
//  NetworkPool.swift
//  SportsStore
//
//  Created by User on 2017/4/12.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

final class NetworkPool {
	private let connectionCount = 3
	private var connections = [NetworkConnection]()
	private var semaphore: DispatchSemaphore
	private var queue: DispatchQueue
	private var itemsCreated: Int = 0
	
	private init() {
//		for _ in 0..<connectionCount {
//			connections.append(NetworkConnection())
//		}
		semaphore = DispatchSemaphore(value: connectionCount)
		
		queue = DispatchQueue(label: "networkPoolQ")
	}
	
	private class var sharedInstance: NetworkPool {
		get {
			struct SingletonWrapper {
				static let singleton = NetworkPool()
			}
			return SingletonWrapper.singleton
		}
	}
	
	private func doGetConnection() -> NetworkConnection {
		let _ = semaphore.wait(timeout: DispatchTime.distantFuture)
		
		var result: NetworkConnection? = nil
//		queue.sync {
//			result = self.connections.remove(at: 0)
//		}
		queue.sync {
			if self.connections.count > 0 {
				result = self.connections.remove(at: 0)
			} else if self.itemsCreated < self.connectionCount {
				result = NetworkConnection()
				self.itemsCreated += 1
			}
		}
		
		return result!
	}
	
	private func doReturnConnection(conn: NetworkConnection) {
		queue.async {
			self.connections.append(conn)
			self.semaphore.signal()
		}
	}
	
	class func getConnection() -> NetworkConnection {
		print("get connection")
		return sharedInstance.doGetConnection()
	}
	
	class func returnConnection(conn: NetworkConnection) {
		print("return connection")
		sharedInstance.doReturnConnection(conn: conn)
	}
}
