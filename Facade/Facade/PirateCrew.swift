//
//  PirateCrew.swift
//  Facade
//
//  Created by User on 2017/4/18.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

class PirateCrew {
	let workQueue = DispatchQueue(label: "crewWorkQ")
	
	enum Actions {
		case ATTACK_SHIP
		case DIG_FOR_GOLD
		case DIVE_FOR_JEWELS
	}
	
	func performAction(action: Actions, callback: @escaping (Int) -> Void) {
		workQueue.async {
			var prizeValue = 0
			switch action {
			case .ATTACK_SHIP:
				prizeValue = 10000
			case .DIG_FOR_GOLD:
				prizeValue = 5000
			case .DIVE_FOR_JEWELS:
				prizeValue = 1000
			}
			callback(prizeValue)
		}
	}
}
