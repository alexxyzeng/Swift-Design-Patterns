//
//  main.swift
//  Singleton
//
//  Created by alex on 2018/10/19.
//  Copyright © 2018年 alex. All rights reserved.
//

import Foundation

var server = BackupServer.server;
//server.backup(item: DataItem(type: DataItem.ItemType.Email, data: "joe@example.com"));
//server.backup(item: DataItem(type: DataItem.ItemType.Phone, data: "555-123-1133"));
//globalLogger.log(msg: "Backed up 2 items to \(server.name)");
//
//var otherServer = BackupServer.server;
//otherServer.backup(item: DataItem(type: DataItem.ItemType.Email, data: "bob@example.com"));
//globalLogger.log(msg: "Backed up 1 item to \(otherServer.name)");
//
//globalLogger.printLog();

let queue = DispatchQueue(label: "workQueue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
let group = DispatchGroup()

for _ in 0..<200 {
    queue.async(group: group, qos: .background, flags: .assignCurrentContext) {
//        print(Thread.current)
        BackupServer.server.backup(item: DataItem(type: .Email, data: "bob@example.com"))
    }
}

let _ = group.wait()
print("\(server.getData().count) items were backed up")


