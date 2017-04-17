//
//  EventBridge.swift
//  SportsStore
//
//  Created by User on 2017/4/17.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class EventBridge {
	private let outputCallback: (String, Int) -> Void
	
	init(callback: @escaping (String, Int) -> Void) {
		self.outputCallback = callback
	}
	
	var inputCallback: (Product) -> Void {
		return { p in self.outputCallback(p.name, p.stockLevel) }
	}
}
