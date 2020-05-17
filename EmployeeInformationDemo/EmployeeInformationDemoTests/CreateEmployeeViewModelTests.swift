//
//  CreateEmployeeViewModelTests.swift
//  EmployeeInformationDemoTests
//
//  Created by Monika Jadhav on 16/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import XCTest
@testable import EmployeeInformationDemo

class CreateEmployeeViewModelTests: XCTestCase {
  
  var createEmployeeViewModel = CreateEmployeeViewModel()
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  func testEmployeeCreatedIsSuccess() {
    let newEmployee = EmployeeInfo(name: "EmployeeOne", salary: "10000", age:"28", id: 0)
    let expectation = self.expectation(description: "success")
    createEmployeeViewModel.createNewEmployee(newEmployee: newEmployee) { (result) in
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
}
