//: Playground - noun: a place where people can play

import Foundation

class Sum: NSObject, NSCopying {
	var resultsCache: [[Int]]
	var firstValue: Int
	var secondeValue: Int
	
	init(first: Int, second: Int) {
		resultsCache = [[Int]](repeating: [Int](repeating: 0, count: 10), count: 10)
		for i in 0..<10 {
			for j in 0..<10 {
				resultsCache[i][j] = i + j
			}
		}
		self.firstValue = first
		self.secondeValue = second
	}
	
	private init(first: Int, second: Int, cache: [[Int]]) {
		self.firstValue = first
		self.secondeValue = second
		self.resultsCache = cache
	}
	
	var result: Int {
		get {
			return firstValue < resultsCache.count
				&& secondeValue < resultsCache[firstValue].count
				? resultsCache[firstValue][secondeValue]
				: firstValue + secondeValue
		}
	}
	
	func copy(with zone: NSZone? = nil) -> Any {
		return Sum(first: firstValue, second: secondeValue, cache: resultsCache)
	}
}
//  每次创建都要经过cacheSize * cacheSize次的计算
//var calc1 = Sum(first: 0, second: 9, cacheSize: 100).result
//var calc2 = Sum(first: 3, second: 8, cacheSize: 20).result

//  深复制
var prototype = Sum(first: 0, second: 9)

var calc1 = prototype.result
var clone = prototype.copy() as! Sum
clone.firstValue = 3
clone.secondeValue = 8
var calc2 = clone.result

print("Calc1: \(calc1) Calc2: \(calc2)")


//  Cloing Struct Types
struct Appointment {
	var name: String
	var day: String
	var place: String
	
	func printDetail(label: String) {
		print("\(label) with \(name) on \(day) at \(place)")
	}
}

var beerMeeting = Appointment(name: "Bob", day: "Mon", place: "Joe's Bar")
//  get the prototype object and clone
var workMeeting = beerMeeting
workMeeting.name = "Alice"
workMeeting.day = "Fri"
workMeeting.place = "Conference Rm 2"

beerMeeting.printDetail(label: "Social")
workMeeting.printDetail(label: "Work")

//  Cloning Reference Types
class Location: NSObject, NSCopying {
	var name: String
	var address: String
	
	init(name: String, address: String) {
		self.name = name
		self.address = address
	}
	
	func copy(with zone: NSZone? = nil) -> Any {
		return Location(name: name, address: address)
	}
}

//  1.Implementing the NSCoping Protocol
class Schedule: NSObject, NSCopying {
	var name: String
	var day: String
	var place: Location

	init(name: String, day: String, place: Location) {
		self.name = name
		self.day = day
		self.place = place
	}

	func printDetail(label: String) {
		print("\(label) with \(name) on \(day) at \(place.address)")
	}

	//  实现copyWithZone方法
	func copy(with zone: NSZone? = nil) -> Any {
		return Schedule(name: name, day: day, place: place.copy() as! Location)
	}
}

var beerSchedule = Schedule(name: "Bob", day: "Mon", place: Location(name: "Joe's Bar", address: "123 Main St"))
//  get the prototype object and clone
//var workSchedule = beerSchedule
//  调用copyWithZone方法
var workSchedule = beerSchedule.copy() as! Schedule
workSchedule.name = "Alice"
workSchedule.day = "Fri"
workSchedule.place.name = "Conference Rm 2"
workSchedule.place.address = "Company HQ"

beerSchedule.printDetail(label: "Social")
workSchedule.printDetail(label: "Work")

class Person: NSObject, NSCopying {
	var name: String
	var country: String
	
	init(name: String, country: String) {
		self.name = name
		self.country = country
	}
	
	func copy(with zone: NSZone? = nil) -> Any {
		return Person(name: name, country: country)
	}
}

//  NSArray reference type
var data = NSMutableArray(objects: 10, "iOS", Person(name:"Joe", country:"USA"));
//  shallow copy
//var copiedData = data.mutableCopy() as! NSArray
//var copiedData = data.copy() as! NSArray

// deep copy --> copyItems == true  shallow copy --> copytItems == false
var copiedData = NSMutableArray(array: data as! [Any], copyItems: true)

data[0] = 20;
data[1] = "MacOS";
(data[2] as! Person).name = "Alice"

print("Identity: \(data === copiedData)");
print("0: \(copiedData[0]) 1: \(copiedData[1]) 2: \((copiedData[2] as! Person).name)");


var people = [Person(name: "Joe", country: "France"), Person(name: "Bob", country: "USA")]
//  shallow copy
var otherPeople = people
people[0].country = "UK"
print("shallow copy \(otherPeople[0].country)")

//  对数组中的引用类型对象的深复制
func deepCopy(data: [AnyObject]) -> [AnyObject] {
	return data.map({
		if $0 is NSCopying && $0 is NSObject {
			return ($0 as! NSObject).copy() as AnyObject
		} else {
			return $0
		}
	})
}
var people1 = [Person(name: "Joe", country: "France"), Person(name: "Bob", country: "USA")]
var otherPeople1 = deepCopy(data: people1) as! [Person]
people[0].country = "UK"
print("deep copy \(otherPeople1[0].country)")

class Message: NSObject, NSCopying {
	var to: String
	var subject: String
	
	init(to: String, subject: String) {
		self.to = to
		self.subject = subject
	}
	
	func copy(with zone: NSZone? = nil) -> Any {
		return Message(to: to, subject: subject)
	}
}

class DetailedMessage: Message {
	var from: String
	
	init(to: String, subject: String, from: String) {
		self.from = from
		super.init(to: to, subject: subject)
	}
	
	override func copy(with zone: NSZone?) -> Any {
		return DetailedMessage(to: to, subject: subject, from: from)
	}
}

class MessageLogger {
	var messages: [Message] = []
	
	func logMessage(msg: Message) {
		messages.append(msg.copy() as! Message)
	}
	
	func processMessages(callback: (Message) -> Void) {
		for msg in messages {
			callback(msg)
		}
	}
}

var logger = MessageLogger()
var message = Message(to: "Joe", subject: "Hello")
logger.logMessage(msg: message)

message.to = "Bob"
message.subject = "Free for dinner?"
logger.logMessage(msg: message)

logger.logMessage(msg: DetailedMessage(to: "Alice", subject: "Hi!", from: "Joe"))

logger.processMessages { (msg) in
	print("Message - To \(msg.to) Subject: \(msg.subject)")
}

class LogItem {
	var from: String?
	@NSCopying var data: NSArray?
}

var dataArray = NSMutableArray(array: [1, 2, 3 ,4])
var logItem = LogItem()
logItem.from = "Alice"
logItem.data = dataArray

dataArray[1] = 10
print(logItem.data?[0])

