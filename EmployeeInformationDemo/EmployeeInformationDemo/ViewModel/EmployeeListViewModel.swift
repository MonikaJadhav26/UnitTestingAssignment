//
//  EmployeeListViewModel.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 13/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import Foundation

class EmployeeListViewModel : NSObject {
    
    var apiCallObject: APIClient = APIClient()
    var employeeData : [Data] = [Data]()
    
    func fetchEmployeeData(completion: @escaping (Result<Bool, Error>) -> Void) {
        apiCallObject.getAllEmployeeList { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let result):
                    self.employeeData = result.data
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getTitleForView() -> String {
        return "Employee List"
    }
    
    func getNumberOfFacts(section: Int) -> Int {
        return self.employeeData.count
    }
    
    func getEmployeeFullName(indexPath: IndexPath) -> String {
        return self.employeeData[indexPath.row].employee_name ?? ""
    }
    
    func getEmployeeAge(indexPath: IndexPath) -> String {
        return self.employeeData[indexPath.row].employee_age ?? ""
    }

    func getEmployeeSalary(indexPath: IndexPath) -> String {
        return self.employeeData[indexPath.row].employee_salary ?? ""
    }

    func getEmployeeProfileImage(indexPath: IndexPath) -> String {
        let imageURL = self.employeeData[indexPath.row].profile_image
        return imageURL ?? ""
    }
}
