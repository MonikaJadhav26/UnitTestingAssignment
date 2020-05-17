//
//  CreateEmployeeViewUITests.swift
//  EmployeeInformationDemoUITests
//
//  Created by Monika Jadhav on 17/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import XCTest



class CreateEmployeeViewUITests: XCTestCase {
  
  let app = XCUIApplication()
  
  override func setUp() {
    continueAfterFailure = false
    XCUIApplication().launch()
  }
  
  func testAllTextFieldAndLabelExists() {
    app.textFields.containing(.staticText, identifier: "Enter employee full name.")
    app.textFields.containing(.staticText, identifier: "Enter Employee age in years.")
    app.textFields.containing(.staticText, identifier: "Enter employee salary in rupees.")
    app.otherElements.containing(.staticText, identifier: "Name")
    app.otherElements.containing(.staticText, identifier: "Age")
    app.otherElements.containing(.staticText, identifier: "Salary")
    app.buttons.containing(.staticText, identifier: "Create")
    app.navigationBars.containing(.staticText, identifier: "Create New Employee")
  }
  
  func testCreateEmployeeSuccess() throws {
    
    let app = XCUIApplication()
    let success = app.staticTexts["Employee created successfully!"]
    
    let name = app.textFields["employeeNameTextField"]
    name.tap()
    name.typeText("monika")
   
    let age = app.textFields["employeeAgeTextField"]
    age.tap()
    age.typeText("24")
   
    let salary = app.textFields["employeeSalaryTextField"]
    salary.tap()
    salary.typeText("1200")
    
    app.buttons["Create"].tap()
    
    let exists = NSPredicate(format: "exists == 1")
    expectation(for: exists, evaluatedWith: success, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    
    XCTAssertTrue(success.exists, "Employee created successfully! is displayed")
    
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
   // createEmployeeView = nil
  }
  
  func testExample() {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
}
