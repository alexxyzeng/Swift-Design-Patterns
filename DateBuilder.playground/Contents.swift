//: Playground - noun: a place where people can play

import UIKit

var builder = NSDateComponents()
builder.hour = 10
builder.day = 6
builder.month = 5
builder.year = 2015
builder.calendar = Calendar(identifier: .gregorian)

var date = builder.date
print(date)