//
//  Airplane.swift
//  Mediator
//
//  Created by User on 2017/5/7.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

struct Position {
	var distanceFromRunway: Int
	var height: Int
}

func == (lhs: Airplane, rhs: Airplane) -> Bool {
	return lhs.name == rhs.name
}

class Airplane: Peer {
	var name: String
	var currentPosition: Position
//	private var otherPlanes: [Airplane]
	var mediator: Mediator
	let queue = DispatchQueue(label: "posQ", qos: .default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: .inherit, target: nil)
	
	init(name: String, initialPos: Position, mediator: Mediator) {
		self.name = name
		self.currentPosition = initialPos
		self.mediator = mediator
		mediator.registerPeer(peer: self)
	}
	
	func otherPlaneDidChangePosition(position: Position) -> Bool {
		var result = false
		queue.sync {
			result =  position.distanceFromRunway == currentPosition.distanceFromRunway &&
				abs(position.height - currentPosition.height) < 1000
		}
		return result
	}
	
	func changePosition(newPosition: Position) {
		queue.sync(flags: .barrier, execute: {
			self.currentPosition = newPosition
			//  将相互之间的距离交给mediator来处理
			if mediator.changePosition(peer: self, pos: currentPosition) {
				print("\(name): Too close! Abort!")
				return
			}
			print("\(name): Position changed")
		})
	}
	
	func land() {
		queue.sync(flags: .barrier, execute: {
			self.currentPosition = Position(distanceFromRunway: 0, height: 0)
			mediator.unregisterPerr(peer: self)
			print("\(name): Landed")
		})
	}
	
	
}
