//
//  main.swift
//  ChainOfResponsibility
//
//  Created by User on 2017/4/30.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

let messages = [
	Message(from: "bob@example.com", to: "joe@example.com",
	        subject: "Free for lunch?"),
	Message(from: "joe@example.com", to: "alice@acme.com",
	        subject: "New Contracts"),
	Message(from: "pete@example.com", to: "all@example.com",
	        subject: "Priority: All-Hands Meeting"),
]

let localT = LocalTransmitter()
let remoteT = RemoteTransmitter()
let priorityT = PriorityTransmitter()

if let chain = Transmitter.createChain(localOnly: true) {
	for msg in messages {
		let handled = chain.sendMessage(message: msg)
		print(handled)
	}
}
