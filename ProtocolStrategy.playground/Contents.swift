//: Playground - noun: a place where people can play

import UIKit

class DataSourceStrategy: NSObject, UITableViewDataSource {
	let data: [CustomStringConvertible]
	
	init(_ data: CustomStringConvertible...) {
		self.data = data
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = data[indexPath.row].description
		return cell
	}
}

let dataSource = DataSourceStrategy("London", "New York", "Paris", "Rome")
let table = UITableView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
table.dataSource = dataSource
table.reloadData()
