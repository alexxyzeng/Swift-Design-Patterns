//
//  main.swift
//  Facade
//
//  Created by User on 2017/4/18.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

let facade = PirateFacade()

if let prize = facade.getTreasure(type: .SHIP) {
	print("Prize: \(prize) pieces of eight")
	
	facade.crew.performAction(action: .DIVE_FOR_JEWELS, callback: { (secondPrize) in
		print("Total Prize: \(prize + secondPrize) pieces of eight")
	})
}


