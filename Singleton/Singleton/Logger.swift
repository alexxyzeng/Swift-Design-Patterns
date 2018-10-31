//
//  Logger.swift
//  Singleton
//
//  Created by alex on 2018/10/19.
//  Copyright © 2018年 alex. All rights reserved.
//

import Foundation
let globalLogger = Logger()

final class Logger {
    private var data = [String]()
    private let arrayQ = DispatchQueue(label: "arrayQ", qos: .background)
    
    func log(msg: String) {
        print(msg)
        arrayQ.sync {
            data.append(msg)
            print(msg)
        }
    }
    
    func printLog() {
        data.forEach { print("Log: \($0)") }
    }
}
