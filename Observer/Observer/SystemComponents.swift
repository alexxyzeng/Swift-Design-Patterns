//
//  SystemComponents.swift
//  Observer
//
//  Created by User on 2017/5/8.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

class ActivityLog: Observer {
//	func notify(user: String, success: Bool) {
//		if success {
//			print("Auth request for \(user). Success: \(success)")
//		}
//	}
	func notify(notification: Notification) {
		print("Auth request for \(notification.type.rawValue)" + "Success: \(notification.data!)")
	}
	
	func logActivity(_ activity: String) {
		print("Log: \(activity)")
	}
}

class FileCache: Observer {
//	func notify(user: String, success: Bool) {
//		if success {
//			loadFiles(user)
//		}
//	}
	func notify(notification: Notification) {
		if let authNotification = notification as? AuthenticationNotification {
			if authNotification.requestSuccessed, let userName = authNotification.userName {
				loadFiles(userName)
			}
		}
	}
	
	func loadFiles(_ user: String) {
		print("Load files for \(user)")
	}
}

class AttackMonitor: MetaObserver {
//	func notify(user: String, success: Bool) {
//		monitorSuspiciousActivity = !success
//	}
	func notifySubjectCreated(subject: Subject) {
		if subject is AuthenticationManager {
			subject.addObserver(observers: self)
		}
	}
	
	func notifySubjectDestroyed(subject: Subject) {
		subject.removeObserver(observer: self)
	}
	
	func notify(notification: Notification) {
		monitorSuspiciousActivity = notification.type == .AUTH_FAIL
	}
	
	var monitorSuspiciousActivity: Bool = false {
		didSet {
			print("Monitoring for attack: \(monitorSuspiciousActivity)")
		}
	}
}
