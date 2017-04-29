//
//  main.swift
//  Proxy
//
//  Created by xiayao on 17/4/28.
//  Copyright © 2017年 xiayao. All rights reserved.
//

import Foundation

func getHeader(header: String) {
    let url = URL(string: "http://www.apress.com")
    let request = URLRequest(url: url!)
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        print(header)
        if let httpResponse = response as? HTTPURLResponse {
            if let headerValue = httpResponse.allHeaderFields[header] as? String {
                print("\(header): \(headerValue)")
            }
        }
    }
}

let headers = ["Content-length", "Content-Encoding"]
for header in headers {
    getHeader(header: header)
}

let _ = FileHandle.standardInput.availableData

