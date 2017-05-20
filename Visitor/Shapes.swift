//
//  Shapes.swift
//  Visitor
//
//  Created by User on 2017/5/19.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

class Circle: Shape {
	let radius: Float
	
	init(radius: Float) {
		self.radius = radius
	}
	
	func accept(visitor: Visitor) {
		visitor.visit(shape: self)
	}
}

class Square: Shape {
	let length: Float
	
	init(length: Float) {
		self.length = length
	}
	
	func accept(visitor: Visitor) {
		visitor.visit(shape: self)
	}
}

class Rectangle: Shape {
	let xLen: Float
	let yLen: Float
	
	init(x: Float, y: Float) {
		self.xLen = x
		self.yLen = y
	}
	
	func accept(visitor: Visitor) {
		visitor.visit(shape: self)
	}
}

class ShapeCollection {
	let shapes: [Shape]
	
	init() {
		shapes = [Circle(radius: 2.5), Square(length: 4), Rectangle(x: 10, y: 2)]
	}
	
	func calculateAreas() -> Float {
		return shapes.reduce(0, {
			if let circle = $1 as? Circle {
				print("Found Circle")
				return $0 + 3.14 * powf(circle.radius, 2)
			} else if let square = $1 as? Square {
				print("Found Square")
				return $0 + powf(square.length, 2)
			} else if let rect = $1 as? Rectangle {
				print("Found Rectangle")
				return $0 + rect.xLen * rect.yLen
			} else {
				return $0
			}
		})
	}
	
	func accept(visitor: Visitor) {
		for shape in shapes {
			shape.accept(visitor: visitor)
		}
	}
}

class AreaVisitor: Visitor {
	var totalArea: Float = 0
	
	func visit(shape: Circle) {
		totalArea += 3.14 * powf(shape.radius, 2)
	}
	
	func visit(shape: Square) {
		totalArea += powf(shape.length, 2)
	}
	
	func visit(shape: Rectangle) {
		totalArea += shape.xLen * shape.yLen
	}
}

class EdgesVisitor: Visitor {
	var totalEdges = 0
	
	func visit(shape: Circle) {
		totalEdges += 1
	}
	
	func visit(shape: Square) {
		totalEdges += 4
	}
	
	func visit(shape: Rectangle) {
		totalEdges += 4
	}
}
