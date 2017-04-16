//
//  ChangeRecord.swift
//  SportsStore
//
//  Created by User on 2017/4/15.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class ChangeRecord: CustomStringConvertible {
	var outerTag: String
	var innerTag: String
	var productName: String
	var category: String
	var value: String
	
	init(outer: String, name: String, category: String, inner: String, value: String) {
		self.outerTag = outer
		self.productName = name
		self.category = category
		self.innerTag = inner
		self.value = value
	}
	
	var description: String {
		return "<\(outerTag)><\(innerTag)><name = \(productName)>" + " category = \(category) >\(value)</\(innerTag)></\(outerTag)>"
	}
}

class ChangeRecordBuilder {
	var outerTag: String
	var innerTag: String
	var productName: String?
	var category: String?
	var value: String?
	
	init() {
		outerTag = "change"
		innerTag = "product"
	}
	
	var changeRecord: ChangeRecord? {
		get {
			if productName != nil && category != nil && value != nil {
				return ChangeRecord(outer: outerTag, name: productName!, category: category!, inner: innerTag, value: value!)
			} else {
				return nil
			}
		}
	}
}
