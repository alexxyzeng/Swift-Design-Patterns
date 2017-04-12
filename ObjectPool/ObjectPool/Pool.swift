import Foundation

class Pool<T> {
	fileprivate var data = [T]()
	
	fileprivate let arrayQ = DispatchQueue(label: "arrayQ")
	fileprivate let semaphore: DispatchSemaphore
	
	init(items: [T]) {
		data.reserveCapacity(data.count)
		for item in items {
			data.append(item)
		}
		semaphore = DispatchSemaphore(value: items.count)
	}
	
	func getFromPool() -> T? {
		var result: T?
		if semaphore.wait(timeout: DispatchTime.distantFuture) == DispatchTimeoutResult.success {
			arrayQ.sync {
				print("get from thread: \(Thread.current)")
				result = self.data.remove(at: 0)
			}
		}
		return result
	}
	
	func returnToPool(_ item: T) {
		arrayQ.async {
			print("return from thread: \(Thread.current)")
			self.data.append(item)
			self.semaphore.signal()
		}
	}
}
