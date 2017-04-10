
import Foundation

class Utils {
	class func currencyStringFromNumber(number: Double) -> String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		return formatter.string(from: NSNumber(value: number)) ?? ""
	}
}
