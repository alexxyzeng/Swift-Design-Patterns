//
//  Auth.swift
//  Proxy
//
//  Created by User on 2017/4/30.
//  Copyright © 2017年 xiayao. All rights reserved.
//

import Foundation

class UserAuthentication {
	var user: String?
	var authenticated: Bool = false
	
	private init() {
		
	}
	
	func authenticate(user: String, pass: String) {
		if pass == "secret" {
			self.user = user
			self.authenticated = true
		} else {
			self.user = nil
			self.authenticated = false
		}
	}
	
	class var sharedInstance: UserAuthentication {
		get {
			struct singletonWrapper {
				static let singleton = UserAuthentication()
			}
			return singletonWrapper.singleton
		}
	}
}
