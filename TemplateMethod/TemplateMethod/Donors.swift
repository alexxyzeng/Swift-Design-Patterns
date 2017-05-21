//
//  Donors.swift
//  TemplateMethod
//
//  Created by User on 2017/5/20.
//  Copyright © 2017年 User. All rights reserved.
//

import Foundation

struct Donor {
	let title: String
	let firstName: String
	let familyName: String
	let lastDonation: Float
	
	init(title: String, first: String, family: String, last: Float) {
		self.title = title
		self.firstName = first
		self.familyName = family
		self.lastDonation = last
	}
}

class DonorDatabase {
	private var donors: [Donor]
	var filter: (([Donor]) -> [Donor])?
	var generate: (([Donor]) -> [String])?
	
	init() {
		donors = [
			Donor(title: "Ms", first: "Anne", family: "Jones", last: 0),
			Donor(title: "Mr", first: "Bob", family: "Smith", last: 100),
			Donor(title: "Dr", first: "Alice", family: "Doe", last: 200),
			Donor(title: "Prof", first: "Joe", family: "Davis", last: 320)
		]
	}
	
	func generateGalaInvitations(maxNum: Int) -> [String] {
		//  1.FILTER
		var targetDonors = filter?(donors) ?? donors.filter({ $0.lastDonation > 0 })
		//  2.SORT
		targetDonors.sort(by: {
			$0.0.lastDonation > $0.1.lastDonation
		})
		//  3.SELECT
		if targetDonors.count > maxNum {
			targetDonors = Array(targetDonors[0..<maxNum])
		}
		//  4.GENERATE
		return generate?(targetDonors) ?? targetDonors.map({
			return "Dear \($0.title). \($0.familyName)"
		})
	}
}
