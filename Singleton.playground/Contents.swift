//: Playground - noun: a place where people can play

import Foundation

class DataItem {
	enum ItemType: String {
		case Email = "Email Address"
		case Phone = "Telephone Number"
		case Card = "Credit Card Number"
	}
	
	var type: ItemType
	var data: String
	
	init(type: ItemType, data: String) {
		self.type = type
		self.data = data
	}
}

final class Logger {
	private var data = [String]()
	
	init() {
		
	}
	
	func log(msg: String) {
		data.append(msg)
	}
	
	func printLog() {
		for msg in data {
			print(msg)
		}
	}
}

let globalLogger = Logger()

final class BackupServer {
	let name: String
	private var data = [DataItem]()
	
	private init(name: String) {
		self.name = name
		globalLogger.log(msg: "Created new server \(name)")
	}
	
	func backup(item: DataItem) {
		data.append(item)
		globalLogger.log(msg: "\(name) backed up item of type \(item.type.rawValue)")
	}
	
	func getData() -> [DataItem] {
		return data
	}
	
	class var server: BackupServer {
		struct SingletonWrapper {
			static let singleton = BackupServer(name: "MainServer")
		}
		return SingletonWrapper.singleton
	}
}

var server = BackupServer.server

server.backup(item: DataItem(type: .Email, data: "joe@example.com"))
server.backup(item: DataItem(type: .Phone, data: "555-123-1133"))

globalLogger.log(msg: "Backed up 2 items to \(server.name)")

var otherServer = BackupServer.server
otherServer.backup(item: DataItem(type: .Email, data: "bob@example.com"))
globalLogger.log(msg: "Backed up 1 item to \(server.name)")

globalLogger.printLog()
