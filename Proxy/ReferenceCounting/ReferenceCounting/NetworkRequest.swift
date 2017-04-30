import Foundation;

protocol NetworkConnection {
	func connect()
	func disconnect()
	func sendCommand(_ command:String)
}

class NetworkConnectionFactory {
	class func createNetworkConnection() -> NetworkConnection {
		return connectionProxy
	}
	
	fileprivate class var connectionProxy:NetworkConnection {
		get {
			struct singletonWrapper {
				static let singleton = NetworkRequestProxy()
			}
			return singletonWrapper.singleton
		}
	}
}

private class NetworkConnectionImplementation : NetworkConnection {
	typealias me = NetworkConnectionImplementation;
	
	func connect() { me.writeMessage("Connect"); }
	func disconnect() { me.writeMessage("Disconnect") }
	
	func sendCommand(_ command:String) {
		me.writeMessage("Command: \(command)")
		Thread.sleep(forTimeInterval: 1)
		me.writeMessage("Command completed: \(command)")
	}
	
	fileprivate class func writeMessage(_ msg:String) {
		self.queue.async(execute: {() in
			print(msg)
		});
	}
	
	fileprivate class var queue:DispatchQueue {
		get {
			struct singletonWrapper {
				static let singleton = DispatchQueue(label: "writeQ",
				                                     attributes: [])
			}
			return singletonWrapper.singleton
		}
	}
}

class NetworkRequestProxy : NetworkConnection {
	fileprivate let wrappedRequest: NetworkConnection
	fileprivate let queue = DispatchQueue(label: "commandQ", attributes: [])
	fileprivate var referenceCount: Int = 0
	fileprivate var connected = false
	
	init() {
		wrappedRequest = NetworkConnectionImplementation();
	}
	
	func connect() { /* do nothing */ }
	func disconnect() { /* do nothing */ }
	
	func sendCommand(_ command: String) {
		referenceCount += 1
		queue.sync {
			if !self.connected && self.referenceCount > 0 {
				self.wrappedRequest.connect()
				self.connected = true
			}
			
			self.wrappedRequest.sendCommand(command)
			self.referenceCount -= 1
			if self.connected && self.referenceCount == 0 {
				self.wrappedRequest.disconnect()
				self.connected = false
			}
		}
	}
}
