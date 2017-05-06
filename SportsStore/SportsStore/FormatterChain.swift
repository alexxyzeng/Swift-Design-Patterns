//
//  FormatterChain.swift
//  SportsStore
//
//  Created by User on 2017/5/6.
//  Copyright © 2017年 Apress. All rights reserved.
//

import UIKit

class CellFormatter {
	var nextLink: CellFormatter?
	
	func formatCell(cell: ProductTableCell) {
		nextLink?.formatCell(cell: cell)
	}
	
	class func createChain() -> CellFormatter {
		let formatter = ChessFormatter()
		formatter.nextLink = WatersportsFormatter()
		formatter.nextLink?.nextLink = DefaultFormatter()
		return formatter
	}
}

class ChessFormatter: CellFormatter {
	override func formatCell(cell: ProductTableCell) {
		if cell.product?.category == "Chess" {
			cell.backgroundColor = UIColor.yellow
		} else {
			super.formatCell(cell: cell)
		}
	}
}

class WatersportsFormatter: CellFormatter {
	override func formatCell(cell: ProductTableCell) {
		if cell.product?.category == "Watersports" {
			cell.backgroundColor = UIColor.green
		} else {
			super.formatCell(cell: cell)
		}
	}
}

class DefaultFormatter: CellFormatter {
	override func formatCell(cell: ProductTableCell) {
		cell.backgroundColor = UIColor.lightGray
	}
}
