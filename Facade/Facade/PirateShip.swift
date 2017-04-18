//
//  PirateShip.swift
//  Facade
//
//  Created by User on 2017/4/18.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

class PirateShip {
	struct ShipLocation {
		let NorthSouth: Int
		let EastWest: Int
	}
	
	var currentPosition: ShipLocation
	var movementQueue = DispatchQueue(label: "shipQ")
	
	init() {
		currentPosition = ShipLocation(NorthSouth: 5, EastWest: 5)
	}
	
	func moveToLocation(location: ShipLocation, callback: @escaping (ShipLocation) -> Void) {
		movementQueue.async {
			self.currentPosition = location
			callback(self.currentPosition)
		}
	}
}
