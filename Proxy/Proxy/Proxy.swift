//
//  Proxy.swift
//  Proxy
//
//  Created by xiayao on 17/4/29.
//  Copyright © 2017年 xiayao. All rights reserved.
//

import Foundation

protocol HttpHeaderRequest {
    func getHeader(url: String, header: String) -> String?
}

class HttpHeaderRequestProxy: HttpHeaderRequest {
    private let semaphore = DispatchSemaphore(value: 0)
    
    func getHeader(url: String, header: String) -> String? {
        var headerValue: String?
        
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                headerValue = response.allHeaderFields[header] as? String
            }
            self.semaphore.signal()
        }
        
        let _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return headerValue
    }
}
