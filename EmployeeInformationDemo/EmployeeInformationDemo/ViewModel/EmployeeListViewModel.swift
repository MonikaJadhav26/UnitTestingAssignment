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
    var searchedEmployeeData = [Data]()
    var originalEmployeeData = [Data]()
    
    func fetchEmployeeData(completion: @escaping (Result<Bool, Error>) -> Void) {
        apiCallObject.getAllEmployeeList { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let result):
                    self.originalEmployeeData = result.data
                    self.employeeData = self.originalEmployeeData
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
        let employeeAge = "\(self.employeeData[indexPath.row].employee_age ?? "") \("years")"
        return employeeAge
    }

    func getEmployeeSalary(indexPath: IndexPath) -> String {
        let employeeSalary = "\(self.employeeData[indexPath.row].employee_salary ?? "") \("Rs.")"
        return employeeSalary
    }

    func getEmployeeProfileImage(indexPath: IndexPath) -> String {
        let imageURL = self.employeeData[indexPath.row].profile_image
        return imageURL ?? ""
    }
    
    func searchEmployee(with searchText: String, completion: @escaping () -> Void) {
        if !searchText.isEmpty {
            searchedEmployeeData = self.employeeData
            self.employeeData = searchedEmployeeData.filter({ $0.employee_name!.lowercased().contains(searchText.lowercased())})
        } else {
            self.employeeData = self.originalEmployeeData
        }
        completion()
    }
}
