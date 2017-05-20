//
//  Visitors.swift
//  Visitor
//
//  Created by User on 2017/5/19.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

protocol Shape {
	func accept(visitor: Visitor)
}

protocol Visitor {
	func visit(shape: Circle)
	
	func visit(shape: Square)
	
	func visit(shape: Rectangle)
}
