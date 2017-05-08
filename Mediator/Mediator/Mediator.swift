//
//  Mediator.swift
//  Mediator
//
//  Created by User on 2017/5/7.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

protocol Peer {
	var name: String { get }
	var currentPosition: Position { get }
	func otherPlaneDidChangePosition(position: Position) -> Bool
}

protocol Mediator {
	func registerPeer(peer: Peer)
	func unregisterPerr(peer: Peer)
	func changePosition(peer: Peer, pos: Position) -> Bool
}

class AirplaneMediator: Mediator {
	private var peers: [String: Peer]
	private let queue = DispatchQueue(label: "dictQ", qos: .default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target: nil)
	
	init() {
		peers = [String: Peer]()
	}
	
	func registerPeer(peer: Peer) {
		queue.sync(flags: .barrier, execute: {
			self.peers[peer.name] = peer
		})
	}
	
	func unregisterPerr(peer: Peer) {
		queue.sync(flags: .barrier, execute: {
			let _ = self.peers.removeValue(forKey: peer.name)
		})
	}
	
	func changePosition(peer: Peer, pos: Position) -> Bool {
		var result = false
		queue.sync {
			let closePeers = self.peers.values.filter({
				return $0.currentPosition.distanceFromRunway <= pos.distanceFromRunway
			})
			for storedPeer in closePeers {
				if peer.name != storedPeer.name &&
					storedPeer.otherPlaneDidChangePosition(position: pos) {
					result = true
				}
			}
		}
		return result
	}
}
