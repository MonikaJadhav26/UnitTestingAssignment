//
//  APIClient.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 12/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import Foundation

class APIClient {
    
    let url = "http://dummy.restapiexample.com/api/v1/employees"
    func getAllEmployeeList(completion: @escaping (EmployeeDataModel?, Error?) -> Void) {
        
        guard let urlStr = URL.init(string: url) else { return }
        URLSession.shared.dataTask(with: urlStr) { (data, response, error) in
            if let err = error {
                completion(nil, err)
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(EmployeeDataModel.self, from: jsonString.data(using: .utf8)!)
                    completion(results, nil)
                } catch {
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
