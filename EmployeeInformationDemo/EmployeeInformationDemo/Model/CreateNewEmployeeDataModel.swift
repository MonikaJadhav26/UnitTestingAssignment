//
//  CreateNewEmployeeDataModel.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 15/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import Foundation

struct CreateNewEmployeeDataModel: Codable {
    let status: String
    let data: EmployeeInfo
}

// MARK: - DataClass
struct EmployeeInfo: Codable {
    var name: String
    let salary: String
    let age: String
    let id: Int
}
