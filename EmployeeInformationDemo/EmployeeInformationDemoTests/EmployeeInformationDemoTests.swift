//
//  EmployeeInformationDemoTests.swift
//  EmployeeInformationDemoTests
//
//  Created by Monika Jadhav on 11/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import XCTest
@testable import EmployeeInformationDemo

class EmployeeInformationDemoTests: XCTestCase {
    
    var employeeListViewModel = EmployeeListViewModel()
    let indexPath = IndexPath(row: 0, section: 0)


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testApiStatus(apiStatus : String) {
        XCTAssertEqual(apiStatus, "success")
    }

    func testEmployeeListViewModelMethodGetEmployeeFullName(apiStatus : String) {
        XCTAssertEqual(employeeListViewModel.getEmployeeFullName(indexPath: indexPath), "Tiger Nixon")
    }
    
    func testEmployeeListViewModelMethodGetEmployeeAge(apiStatus : String) {
         XCTAssertEqual(employeeListViewModel.getEmployeeAge(indexPath: indexPath), "61")
    }
    
    func testEmployeeListViewModelMethodGetEmployeeSalary(apiStatus : String) {
         XCTAssertEqual(employeeListViewModel.getEmployeeSalary(indexPath: indexPath), "320800")
    }
    
    func testEmployeeListViewModelMethodGetNumberOfTotalEmployee(apiStatus : String) {
         XCTAssertTrue(employeeListViewModel.getNumberOfTotalEmployee(section: 0) != 0)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
