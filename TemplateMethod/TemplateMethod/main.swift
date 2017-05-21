//
//  main.swift
//  TemplateMethod
//
//  Created by User on 2017/5/20.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

let donorDb = DonorDatabase()

let galaInvitations = donorDb.generateGalaInvitations(maxNum: 2)

for invite in galaInvitations {
	print(invite)
}

