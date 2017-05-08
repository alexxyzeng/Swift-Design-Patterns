//
//  main.swift
//  KVO
//
//  Created by User on 2017/5/8.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

class Subject: NSObject {
	dynamic var counter = 0
}

class Observer: NSObject {
	init(subject: Subject) {
		super.init()
		subject.addObserver(self, forKeyPath: "counter", options: .new, context: nil)
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		print("Notification: \(keyPath!) = \(change![NSKeyValueChangeKey.newKey]!)")
	}
}

let subject = Subject()
let observer = Observer(subject: subject)
subject.counter += 1
subject.counter = 22
