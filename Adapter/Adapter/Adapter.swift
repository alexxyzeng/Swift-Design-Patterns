import Foundation

extension NewCoDirectory: EmployeeDataSource {
	var employees: [Employee] {
		return getStaff().values.map({
			return Employee(name: $0.getName(), title: $0.getJob())
		})
	}
	
	func searchByName(_ name: String) -> [Employee] {
		return createEmployees(filter: {
			return $0.getName().range(of: name) != nil
		})
	}
	
	func searchByTitle(_ title: String) -> [Employee] {
		return createEmployees(filter: {
			return $0.getJob().range(of: title) != nil
		})
	}
	
	private func createEmployees(filter filterClosure: (NewCoStaffMember) -> Bool) -> [Employee] {
		return getStaff().values.filter(filterClosure).map({
			return Employee(name: $0.getName(), title: $0.getJob())
		})
	}
}

//  Defining an Adapter as a Wrapper Class
class NewCoDirectoryAdapter: EmployeeDataSource {
	private let directory: NewCoDirectory
	
	init() {
		directory = NewCoDirectory()
	}
	
	var employees: [Employee] {
		return directory.getStaff().values.map({
			return Employee(name: $0.getName(), title: $0.getJob())
		})
	}
	
	func searchByName(_ name: String) -> [Employee] {
		return createEmployees(filter: {
			return $0.getName().range(of: name) != nil
		})
	}
	
	func searchByTitle(_ title: String) -> [Employee] {
		return createEmployees(filter: {
			return $0.getJob().range(of: title) != nil
		})
	}
	
	private func createEmployees(filter filterClosure: (NewCoStaffMember) -> Bool) -> [Employee] {
		return directory.getStaff().values.filter(filterClosure).map({
			return Employee(name: $0.getName(), title: $0.getJob())
		})
	}
}
