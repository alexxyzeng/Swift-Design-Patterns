import Foundation

class Logger<T> where T: NSObject, T: NSCopying {
	var dataItems: [T] = []
	var callback: (T) -> Void
	
	init(callback: @escaping (T) -> Void) {
		self.callback = callback
	}
	
	func logItem(item: T) {
		dataItems.append(item)
		callback(item)
	}
	
	func processItems(callback: (T) -> Void) {
		for item in dataItems {
			callback(item)
		}
	}
}
