//
//  Proxy.swift
//  Proxy
//
//  Created by xiayao on 17/4/29.
//  Copyright © 2017年 xiayao. All rights reserved.
//

import Foundation

protocol HttpHeaderRequest {
	init(url: String)
	func getHeader(header: String, callback: @escaping (String, String?) -> Void)
	func execute()
}

class HttpHeaderRequestProxy: HttpHeaderRequest {
	let url: String
	var headersRequired: [String: (String, String?) -> Void]
	
	required init(url: String) {
		self.url = url
		self.headersRequired = Dictionary<String, (String, String?) -> Void>()
	}
	
	func getHeader(header: String, callback: @escaping (String, String?) -> Void) {
		self.headersRequired[header] = callback
	}
	
	func execute() {
		let url = URL(string: self.url)
		let request = URLRequest(url: url!)
		URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let response = response as? HTTPURLResponse,
				let headers = response.allHeaderFields as? [String: String] {
				for (header, callback) in self.headersRequired {
					callback(header, headers[header])
				}
			}
		}.resume()
	}
}


class AccessControlProxy: HttpHeaderRequest {
	private let wrappedObject: HttpHeaderRequest
	
	required init(url: String) {
		wrappedObject = HttpHeaderRequestProxy(url: url)
	}
	
	func getHeader(header: String, callback: @escaping (String, String?) -> Void) {
		wrappedObject.getHeader(header: header, callback: callback)
	}
	
	func execute() {
		if UserAuthentication.sharedInstance.authenticated {
			wrappedObject.execute()
		} else {
			fatalError("Unauthorized")
		}
	}
}
