//
//  Momento.swift
//  Momento
//
//  Created by User on 2017/5/11.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

protocol Memento {
//	<#requirements#>
}

protocol Originator {
	func createMemento() -> Memento
	func applyMemento(_ memento: Memento)
}
