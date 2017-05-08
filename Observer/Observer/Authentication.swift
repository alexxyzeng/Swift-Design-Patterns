//
//  Authentication.swift
//  Observer
//
//  Created by User on 2017/5/8.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

class AuthenticationManager: ShortlivedSubject {
	private let log = ActivityLog()
	private let cache = FileCache()
	private let monitor = AttackMonitor()
	
	func authenticate(user: String, pass: String) -> Bool {
		var nType = NotificationTypes.AUTH_FAIL
		if user == "Bob" && pass == "secret" {
			nType = .AUTH_SUCCESS
			print("User \(user) is authenticated")
			log.logActivity("Authenticated \(user)")
			cache.loadFiles(user)
			monitor.monitorSuspiciousActivity = false
		} else {
			print("Failed authentication attempt")
			log.logActivity("Failed Authentication: \(user)")
			monitor.monitorSuspiciousActivity = true
		}
//		sendNotification(user: user, success: result)
		sendNotification(notification: Notification(type: nType, data: user))
		return nType == .AUTH_SUCCESS
	}
}
