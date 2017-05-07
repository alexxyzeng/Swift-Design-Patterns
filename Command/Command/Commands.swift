//
// Created by User on 2017/5/6.
// Copyright (c) 2017 User. All rights reserved.
//

import Foundation

//protocol Command {
//	func execute(receiver: Any)
//}
//
//class GenericCommand<T>: Command {
//	func execute(receiver: Any) {
//		if let safeReceiver = receiver as? T {
//			instructions(safeReceiver)
//		} else {
//			fatalError("Receiver is not expected type")
//		}
//	}
//
////    private var receiver: T
//    private var instructions: (T) -> Void
//
//    init(instructions: @escaping (T) -> Void) {
////        self.receiver = receiver
//        self.instructions = instructions
//    }
//    
//
//    class func createCommand(instructions: @escaping (T) -> Void) -> Command {
//        return GenericCommand(instructions: instructions)
//    }
//}
//
//class CommandWrapper: Command {
//
//	private let commands: [Command]
//	
//	init(commands: [Command]) {
//		self.commands = commands
//	}
//	
//	func execute(receiver: Any) {
//		for command in commands {
//			command.execute(receiver: receiver)
//		}
//	}
//}
protocol Command {
	func execute(receiver: Any)
}

class CommandWrapper : Command {
	fileprivate let commands:[Command]
	
	init(commands:[Command]) {
		self.commands = commands
	}
	
	func execute(receiver: Any) {
		for command in commands {
			command.execute(receiver: receiver)
		}
	}
}

class GenericCommand<T> : Command {
	fileprivate var instructions: (T) -> Void
	
	init(instructions: @escaping (T) -> Void) {
		self.instructions = instructions
	}
	
	func execute(receiver: Any) {
		if let safeReceiver = receiver as? T {
			instructions(safeReceiver)
		} else {
			fatalError("Receiver is not expected type")
		}
	}
	
	class func createCommand(instructions: @escaping (T) -> Void) -> Command {
		return GenericCommand(instructions: instructions)
	}
}
