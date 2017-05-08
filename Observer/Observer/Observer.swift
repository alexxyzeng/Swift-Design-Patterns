//
//  Observer.swift
//  Mediator
//
//  Created by User on 2017/5/8.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

enum NotificationTypes: String {
	case AUTH_SUCCESS = "AUTH_SUCCESS"
	case AUTH_FAIL = "AUTH_FAIL"
	case SUBJECT_CREATED = "SUBJECT_CREATE"
	case SUBJECT_DESTROYED = "SUBJECT_DESTROYED"
}

class Notification {
	let type: NotificationTypes
	let data: Any?
	
	init(type: NotificationTypes, data: Any?) {
		self.type = type
		self.data = data
	}
}

class AuthenticationNotification: Notification {
	init(user: String, success: Bool) {
		super.init(type: success ? NotificationTypes.AUTH_SUCCESS : .AUTH_FAIL, data: user)
	}
	
	var userName: String? {
		return self.data as? String
	}
	
	var requestSuccessed: Bool {
		return self.type == .AUTH_SUCCESS
	}
}

protocol Observer: class {
	func notify(notification: Notification)
}

private class WeakObserverReference {
	weak var observer: Observer?
	
	init(observer: Observer) {
		self.observer = observer
	}
}

protocol Subject {
	func addObserver(observers: Observer...)
	func removeObserver(observer: Observer)
}

class SubjectBase: Subject {
//	private var observers = [Observer]()
	private var observers = [WeakObserverReference]()
	private var collectionQueue = DispatchQueue(label: "colQ", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
	
	func addObserver(observers: Observer...) {
		collectionQueue.sync(flags: .barrier, execute: {
			for newOb in observers {
				self.observers.append(WeakObserverReference(observer: newOb))
			}
		})
	}
	
	func removeObserver(observer: Observer) {
		collectionQueue.sync(flags: .barrier, execute: {
			self.observers = self.observers.filter({
				return $0.observer != nil && $0.observer !== observer
			})
		})
	}
	
	func sendNotification(notification: Notification) {
		collectionQueue.sync {
			for ob in self.observers {
//				ob.notify(notification: notification)
				ob.observer?.notify(notification: notification)
			}
		}
	}
}


