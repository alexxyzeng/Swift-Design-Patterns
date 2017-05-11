//
//  Ledger.swift
//  Momento
//
//  Created by User on 2017/5/11.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

class LedgerEntry {
	let id: Int
	let counterParty: String
	let amount: Float
	
	init(id: Int, counterParty: String, amount: Float) {
		self.id = id
		self.counterParty = counterParty
		self.amount = amount
	}
}

class LedgerMemento: Memento {
	private var entries: [LedgerEntry] = []
	private let total: Float
	private let nextId: Int
	
	init(ledger: Ledger) {
		self.entries = Array(ledger.entries.values)
		self.total = ledger.total
		self.nextId = ledger.nextId
	}
	
	func apply(ledger: Ledger) {
		ledger.total = total
		ledger.nextId = nextId
		ledger.entries.removeAll(keepingCapacity: true)
		for entry in entries {
			ledger.entries[entry.id] = entry
		}
	}
}

class Ledger: Originator {
	fileprivate var entries = [Int: LedgerEntry]()
	fileprivate var nextId = 1
	var total: Float = 0
	
	func addEntry(counterParty: String, amount: Float) -> Void {
		nextId += 1
		let entry = LedgerEntry(id: nextId, counterParty: counterParty, amount: amount)
		entries[entry.id] = entry
		total += amount
//		return createUndoCommand(entry: entry)
	}
	
//	private func createUndoCommand(entry: LedgerEntry) -> LedgerCommand {
//		return LedgerCommand(instructions: { (target) in
//			if let removed = target.entries.removeValue(forKey: entry.id) {
//				target.total -= removed.amount
//			}
//		}, receiver: self)
//	}
	func createMemento() -> Memento {
		return LedgerMemento(ledger: self)
	}
	
	func applyMemento(_ memento: Memento) {
		if let m = memento as? LedgerMemento {
			m.apply(ledger: self)
		}
	}
	
	func printEntries() {
		for id in entries.keys.sorted(by: <) {
			if let entry = entries[id] {
				print("#\(id): \(entry.counterParty) $\(entry.amount)")
			}
		}
		print("Total: \(total)")
		print("——————")
	}
}
