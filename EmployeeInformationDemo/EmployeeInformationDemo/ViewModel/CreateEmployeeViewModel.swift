//
//  CreateEmployeeViewModel.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 13/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import Foundation
import UIKit

class CreateEmployeeViewModel : NSObject {
    
    //MARK: - Variables
    var apiCallObject: APIClient = APIClient()
    
    //MARK: - Create new Employee
    func createNewEmployee(newEmployee: EmployeeInfo ,completion: @escaping (Result<Bool, Error>) -> Void) {
        apiCallObject.createNewEmployee(employee: newEmployee) { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
       
}


