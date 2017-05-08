//
//  MetaObserver.swift
//  Observer
//
//  Created by User on 2017/5/8.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

protocol MetaObserver: Observer {
	func notifySubjectCreated(subject: Subject)
	func notifySubjectDestroyed(subject: Subject)
}

class MetaSubject: SubjectBase, MetaObserver {
	func notifySubjectDestroyed(subject: Subject) {
		sendNotification(notification: Notification(type: .SUBJECT_DESTROYED, data: subject))
	}

	func notifySubjectCreated(subject: Subject) {
		sendNotification(notification: Notification(type: .SUBJECT_CREATED, data: subject))
	}
	
	class var sharedInstance: MetaSubject {
		struct singletonWrapper {
			static let singleton = MetaSubject()
		}
		return singletonWrapper.singleton
	}
	
	func notify(notification: Notification) {
//		<#code#>
	}
}

class ShortlivedSubject: SubjectBase {
	override init() {
		super.init()
		MetaSubject.sharedInstance.notifySubjectCreated(subject: self)
	}
	
	deinit {
		MetaSubject.sharedInstance.notifySubjectDestroyed(subject: self)
	}
}
