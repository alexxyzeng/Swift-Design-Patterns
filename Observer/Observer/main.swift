//
//  main.swift
//  Observer
//
//  Created by User on 2017/5/8.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

let authM = AuthenticationManager()

let log = ActivityLog()
let cache = FileCache()
let monitor = AttackMonitor()
MetaSubject.sharedInstance.addObserver(observers: monitor)

authM.addObserver(observers: log, cache)

let _ = authM.authenticate(user: "Bob", pass: "secret")
print("______")
let _ = authM.authenticate(user: "Joe", pass: "Shhhh")

