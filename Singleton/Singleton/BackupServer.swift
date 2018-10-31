//
//  BackupServer.swift
//  Singleton
//
//  Created by alex on 2018/10/19.
//  Copyright © 2018年 alex. All rights reserved.
//

import Foundation

class DataItem {
    enum ItemType: String {
        case Email = "Email Address"
        case Phone = "Telephone Number"
        case Card = "Credit Card Number"
    }
    var type: ItemType
    var data: String
    
    init(type: ItemType, data: String) {
        self.type = type
        self.data = data
    }
}

class BackupServer {
    let name: String
    private var data: [DataItem] = []
    //  serial
    private let arrayQ = DispatchQueue(label: "arrayQ", qos: .background)
    
    init(name: String) {
        self.name = name
        globalLogger.log(msg: "Create new server \(name)")
    }
    
    func backup(item: DataItem) {
        arrayQ.sync {
            data.append(item)
            globalLogger.log(msg: "\(name) backed up item of type \(item.type.rawValue) on thread \(Thread.current)")
        }
    }
    
    func getData() -> [DataItem] {
        return data
    }
    
    class var server: BackupServer {
        struct SingletonWrapper {
            static let singleton = BackupServer(name: "MainServer")
        }
        return SingletonWrapper.singleton
    }
}
