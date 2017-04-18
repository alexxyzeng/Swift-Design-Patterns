//
//  Facade.swift
//  Facade
//
//  Created by User on 2017/4/18.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

enum TreasureTypes {
	case SHIP
	case BURIED
	case SUNKEN
}

class PirateFacade {
	let map = TreasureMap()
	let ship = PirateShip()
	let crew = PirateCrew()
	
	func getTreasure(type: TreasureTypes) -> Int? {
		var prizeAmount: Int?
		
		var treasureMapType: TreasureMap.Treasures
		var crewWorkType: PirateCrew.Actions
		
		switch type {
		case .SHIP:
			treasureMapType = .GALLEON
			crewWorkType = .ATTACK_SHIP
		case .BURIED:
			treasureMapType = .GALLEON
			crewWorkType = .ATTACK_SHIP
		case .SUNKEN:
			treasureMapType = .SUNKEN_JEWELS
			crewWorkType = .DIVE_FOR_JEWELS
		}
		
		let treasureLocation = map.findTreasure(type: treasureMapType)
		let sequence: [Character] = ["A", "B", "C", "D", "E", "F", "G"]
//		let eastWestPos = sequence.index(of: treasureLocation.gridLetter)
		guard let eastWestPos = sequence.index(of: treasureLocation.gridLetter) else {
			return nil
		}
		let shipTarget = PirateShip.ShipLocation.init(NorthSouth: Int(treasureLocation.gridNumber), EastWest: eastWestPos)
		let semaphore = DispatchSemaphore(value: 0)
		
		ship.moveToLocation(location: shipTarget) { (location) in
			self.crew.performAction(action: crewWorkType, callback: { (prize) in
				prizeAmount = prize
				_ = semaphore.signal()
			})
		}
		
		_ = semaphore.wait(timeout: DispatchTime.distantFuture)
		return prizeAmount
	}
}
