//
//  main.swift
//  Visitor
//
//  Created by User on 2017/5/19.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

print("Hello, World!")

let shapes = ShapeCollection()

let areaVisitor = AreaVisitor()
shapes.accept(visitor: areaVisitor)
print("Area: \(areaVisitor.totalArea)")

print("————————")

let edgeVisitor = EdgesVisitor()
shapes.accept(visitor: edgeVisitor)
print("Edges: \(edgeVisitor.totalEdges)")
