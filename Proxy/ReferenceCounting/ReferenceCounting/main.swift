//
//  main.swift
//  ReferenceCounting
//
//  Created by User on 2017/4/30.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

let queue = DispatchQueue(label: "requestQ", attributes: DispatchQueue.Attributes.concurrent);

for count in 0 ..< 3 {
	
	let connection = NetworkConnectionFactory.createNetworkConnection()
	
	queue.async {
		connection.connect()
		connection.sendCommand("Command: \(count)")
		connection.disconnect()
	}
}

_ = FileHandle.standardInput.availableData;
