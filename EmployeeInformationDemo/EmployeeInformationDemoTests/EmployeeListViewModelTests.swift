//
//  EmployeeListViewModelTests.swift
//  EmployeeInformationDemoTests
//
//  Created by Monika Jadhav on 16/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import XCTest
@testable import EmployeeInformationDemo

class EmployeeListViewModelTests: XCTestCase {

    var employeeListViewModel = EmployeeListViewModel()
    let indexPath = IndexPath(row: 0, section: 0)

    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle.main.url(forResource: "EmployeeLocalJSON", withExtension: "json")
        let jsonData = try! Data.init(contentsOf: bundle!)
        let result = try! JSONDecoder().decode(EmployeeDataModel.self, from: jsonData)
        employeeListViewModel.originalEmployeeData = result.data
        employeeListViewModel.employeeData = employeeListViewModel.originalEmployeeData
    }
    
    func testEmployeeListViewModelFetchEmployeeDataIsSuccess() {
        let expectation = self.expectation(description: "success")
        employeeListViewModel.fetchEmployeeData { (result) in
            switch(result) {
            case .success(let result):
                XCTAssertNotNil(result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testEmployeeListViewModelMethodGetEmployeeFullName() {
        let employeeData = employeeListViewModel.employeeData[0]
        XCTAssertEqual(employeeData.employee_name, "Tiger Nixon")
    }
    
    func testEmployeeListViewModelMethodGetEmployeeAge() {
         let employeeData = employeeListViewModel.employeeData[0]
         XCTAssertEqual(employeeData.employee_age, "61")    }
    
    func testEmployeeListViewModelMethodGetEmployeeSalary() {
        let employeeData = employeeListViewModel.employeeData[0]
        XCTAssertEqual(employeeData.employee_salary, "320800")
    }
    
    func testEmployeeListViewModelMethodGetNumberOfTotalEmployee() {
        XCTAssertEqual(employeeListViewModel.employeeData.count, 24)
        XCTAssertEqual(employeeListViewModel.originalEmployeeData.count, 24)
    }
    
    func testEmployeeDataIsNil() {
        let employeeData = employeeListViewModel.employeeData[0]
        XCTAssertNotNil(employeeData.id, "")
        XCTAssertNotNil(employeeData.employee_name, "")
        XCTAssertNotNil(employeeData.employee_age, "")
    }
    
    func testEmployeeSearchTextResult() {
        employeeListViewModel.searchEmployee(with: "Quin") {
            XCTAssertEqual(self.employeeListViewModel.searchedEmployeeData.count, 24)
        }
        
        let searchEmpoyeeData = self.employeeListViewModel.employeeData[0]
        XCTAssertEqual(searchEmpoyeeData.id, "12")
        XCTAssertEqual(searchEmpoyeeData.employee_name, "Quinn Flynn")
        XCTAssertEqual(searchEmpoyeeData.employee_age, "22")
        XCTAssertEqual(searchEmpoyeeData.employee_salary, "342000")
    }

}
