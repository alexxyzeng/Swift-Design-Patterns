import Foundation

let productLogger = Logger<Product>(callback: { p in
	var builder = ChangeRecordBuilder()
	builder.productName = p.name
	builder.category = p.category
	builder.value = String(p.stockLevel)
	builder.outerTag = "stockChange"
	
	if let changeRecord = builder.changeRecord {
		print(changeRecord)
	}
	
})

final class Logger<T> where T: NSObject, T: NSCopying {
	var dataItems: [T] = []
	var callback: (T) -> Void
	var arrayQ = DispatchQueue(label: "arrayQ", qos: .default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target: nil)
	var callbackQ = DispatchQueue(label: "callbackQ")
	
	fileprivate init(callback: @escaping (T) -> Void, protect: Bool = true) {
		self.callback = callback
		if protect {
			self.callback = { (item: T) in
				self.callbackQ.sync {
					callback(item)
				}
			}
		}
	}
	
	func logItem(item: T) {
		arrayQ.async(group: nil, qos: .default, flags: .barrier) { 
			self.dataItems.append(item)
			self.callback(item)
		}
	}
	
	func processItems(callback: (T) -> Void) {
		arrayQ.sync {
			for item in dataItems {
				callback(item)
			}
		}
	}
}
