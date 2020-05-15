//
//  Constants.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 12/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import Foundation

import Foundation
import UIKit

struct Constants {
    
    struct BaseURL {
        static let url = "http://dummy.restapiexample.com"
    }
    struct APIMethod {
        static let getEmployees = "/api/v1/employees"
        static let createEmployee = "/api/v1/create"
        static let deleteEmployee = "/api/v1/delete"
    }
    
    static let post = "POST"
    static let delete = "DELETE"
    static let applicationJson = "application/json"
    static let contentType = "Content-Type"
    static let kCellIdentifier = "EmployeeListCell"
    static let ok = "OK"
    static let errorTitle = "Error"
    static let defaultImage = UIImage(named: "default")
    static let backgroundViewColor = UIColor(named: "backViewColour")
    static let cellLabelTextColor = UIColor(named: "textColour")
    static let grayButtonColour = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
    static let greenButtonColour = UIColor(red: 38/255, green: 146/255, blue: 66/255, alpha: 1)
}
