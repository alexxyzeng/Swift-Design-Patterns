//
//  Transmitter.swift
//  ChainOfResponsibility
//
//  Created by User on 2017/5/5.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation



class Transmitter {
	var nextLink: Transmitter?
	
	required init() {}
	
	func sendMessage(message: Message, handled: Bool = false) -> Bool {
		if let nextLink = nextLink {
			return nextLink.sendMessage(message: message, handled: handled)
		} else if !handled {
			print("End of chain reached. Message not sent")
			
		}
		return handled
	}
	
	class func createChain(localOnly: Bool) -> Transmitter? {
//		let transimitterClasses: [Transmitter.Type] = [
//			PriorityTransmitter.self,
//			LocalTransmitter.self,
//			RemoteTransmitter.self
//		]
		let transmitterClasses: [Transmitter.Type] = localOnly ? [
			PriorityTransmitter.self,
			LocalTransmitter.self
		] : [
			PriorityTransmitter.self,
			LocalTransmitter.self,
			RemoteTransmitter.self
		]
		
		var link: Transmitter?
		
		for tClass in transmitterClasses.reversed() {
			let existingLink = link
			link = tClass.init()
			link?.nextLink = existingLink
		}
		return link
	}
	
	fileprivate class func matchEmailSuffix(message: Message) -> Bool {
		if let index = message.from.range(of: "@")?.upperBound {
			return message.to.hasSuffix(message.from.substring(from: index))
		}
		return false
	}
}

class LocalTransmitter: Transmitter {
//	override func sendMessage(message: Message, var handled: Bool) -> Bool {
//		if !handled && Transmitter.matchEmailSuffix(message: message) {
//			print("Message to \(message.to) sent locally")
//			handled = true
//		}
//		return super.sendMessage(message: message, handled: handled)
//	}
	override func sendMessage(message: Message, handled: Bool) -> Bool {
		var handledVar = handled
		if !handled && Transmitter.matchEmailSuffix(message: message) {
			handledVar = true
		}
		return super.sendMessage(message: message, handled: handledVar)
	}
}

class RemoteTransmitter: Transmitter {
//	override func sendMessage(message: Message) -> Bool {
//		if !Transmitter.matchEmailSuffix(message: message) {
//			print("Message to \(message.to) sent remotely")
//			return true
//		} else {
//			return super.sendMessage(message: message)
//		}
//	}
	override func sendMessage(message: Message, handled: Bool) -> Bool {
		var handledVar = handled
		if !handled && !Transmitter.matchEmailSuffix(message: message) {
			handledVar = true
		}
		return super.sendMessage(message: message, handled: handledVar)
	}
	
}

class PriorityTransmitter: Transmitter {
//	override func sendMessage(message: Message) -> Bool {
//		if message.subject.hasPrefix("Priority") {
//			print("Message to \(message.to) sent as priority")
//			return true
//		} else {
//			return super.sendMessage(message: message)
//		}
//	}
	var totalMessages = 0
	var handledMessages = 0
	
	override func sendMessage(message: Message, handled: Bool) -> Bool {
		totalMessages += 1
		var handledVar = handled
		if !handled && message.subject.hasPrefix("Priority") {
			handledMessages += 1
			print("Stats: Handled \(handledMessages) of \(totalMessages)")
			handledVar = true
		}
		return super.sendMessage(message: message, handled: handledVar)
	}
}
