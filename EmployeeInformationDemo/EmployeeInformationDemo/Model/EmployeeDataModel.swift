//
//  EmployeeDataModel.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 13/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import Foundation

struct EmployeeDataModel: Codable {
    let status: String
    let data: [Data]
}

struct Data: Codable {
    let id: String?
    var employee_name: String?
    let employee_salary: String?
    let employee_age: String?
    let profile_image: String?

}
