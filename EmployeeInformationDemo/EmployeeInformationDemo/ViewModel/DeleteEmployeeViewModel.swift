//
//  DeleteEmployeeViewModel.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 13/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import Foundation

class DeleteEmployeeViewModel : NSObject {

var apiCallObject: APIClient = APIClient()

func deleteEmployee(employeeID: Int, completion: @escaping (Result<DeleteEmployeeDataModel, Error>) -> Void) {
    apiCallObject.deleteEmployee(employeeID: employeeID) { (result) in
        DispatchQueue.main.async {
            switch(result) {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
}
