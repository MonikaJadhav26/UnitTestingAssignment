//
//  APIRouter.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 16/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import Foundation

struct APIConstants {
    
    struct BaseURL {
        static let url = "http://dummy.restapiexample.com"
    }
    struct APIMethodName {
        static let getEmployeesList = "/api/v1/employees"
        static let createNewEmployee = "/api/v1/create"
        static let deleteEmployee = "/api/v1/delete"
    }
    
    struct APIMethodType {
        static let post = "POST"
        static let delete = "DELETE"
    }
    
    struct APIStatus {
        static let success = "success"
        static let fail = "fail"
    }
    
    enum HTTPHeaderField: String {
        case applicationJson = "application/json"
        case contentType = "Content-Type"
        
    }
}
