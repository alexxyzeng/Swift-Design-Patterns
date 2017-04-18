//
//  TreasureMap.swift
//  Facade
//
//  Created by User on 2017/4/18.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

class TreasureMap {
	enum Treasures {
		case GALLEON
		case BURIED_GOLD
		case SUNKEN_JEWELS
	}
	
	struct MapLocation {
		let gridLetter: Character
		let gridNumber: uint
	}
	
	func findTreasure(type: Treasures) -> MapLocation {
		switch type {
		case .GALLEON:
			return MapLocation(gridLetter: "D", gridNumber: 6)
		case .BURIED_GOLD:
			return MapLocation(gridLetter: "C", gridNumber: 2)
		case .SUNKEN_JEWELS:
			return MapLocation(gridLetter: "F", gridNumber: 12)
		}
	}
}
