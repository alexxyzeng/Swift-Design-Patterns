//
//  main.swift
//  Proxy
//
//  Created by xiayao on 17/4/28.
//  Copyright © 2017年 xiayao. All rights reserved.
//

import Foundation

let url = "http://www.apress.com"
let headers = ["Content-Type", "Content-Encoding"]

let proxy = AccessControlProxy(url: url)

for header in headers {
	proxy.getHeader(header: header, callback: { (header, value) in
		print(("\(header): \(value!)"))
	})
}

UserAuthentication.sharedInstance.authenticate(user: "Bob", pass: "secret")
proxy.execute()

let _ = FileHandle.standardInput.availableData

