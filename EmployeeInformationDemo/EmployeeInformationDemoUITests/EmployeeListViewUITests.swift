//
//  EmployeeInformationDemoUITests.swift
//  EmployeeInformationDemoUITests
//
//  Created by Monika Jadhav on 11/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import XCTest

class EmployeeListViewUITests: XCTestCase {
  
  let app = XCUIApplication()
  
  override func setUp() {
    continueAfterFailure = false
  }
  
  override func tearDown() {
    
  }
  
  func testExample() {
    app.launch()
  }
  
  func testTableContainsEmployeeRecords() {
    app.tables.cells.containing(.staticText, identifier: "Tiger")
    app.tables.cells.containing(.staticText, identifier: "61")
    app.tables.cells.containing(.staticText, identifier: "320800")
  }
  
  func testAddButtonDisplays() {
    app.buttons.containing(.staticText, identifier: "+")
  }
  
  func testSearchBarDisplays() {
    app.searchFields.containing(.staticText, identifier: "Enter search text here ....")
  }
  
  func testNavigationBarTitleDisplays() {
    app.navigationBars.containing(.staticText, identifier: "Employee List")
  }
  
  func testEmployeeListTableContainsCell() {
    let employeeList = app.tables.matching(identifier: "Employee List Table")
    let employeeCell = employeeList.cells.element(matching: .cell, identifier: "Employee List Cell")
    employeeCell.tap()
  }
  
  func testLaunchPerformance() {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
        XCUIApplication().launch()
      }
    }
  }
}
