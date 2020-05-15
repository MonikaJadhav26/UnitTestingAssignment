//
//  APIClient.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 12/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import Foundation

class APIClient {
    
    //MARK: - GET Method
    func getAllEmployeeList(completion: @escaping (Result<EmployeeDataModel, Error>) -> Void) {
        let urlString = "\(Constants.BaseURL.url)\(Constants.API.getEmployees)"
        guard let serviceURL = URL.init(string: urlString) else { return }
        URLSession.shared.dataTask(with: serviceURL) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(EmployeeDataModel.self, from: jsonString.data(using: .utf8)!)
                    completion(.success(results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            }.resume()
    }
    
    //MARK: - POST Method
    func createNewEmployee(employee: EmployeeInfo, completion: @escaping (Result<CreateNewEmployeeDataModel, Error>) -> Void) {
        let urlString = "\(Constants.BaseURL.url)\(Constants.API.createEmployee)"
        guard let serviceURL = URL.init(string: urlString) else { return }
        var request = URLRequest(url: serviceURL)
        request.httpMethod = Constants.post
        request.addValue(Constants.applicationJson, forHTTPHeaderField: Constants.contentType)
        guard let body = try? JSONEncoder().encode(employee) else { return }
        request.httpBody = body
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(CreateNewEmployeeDataModel.self, from: jsonString.data(using: .utf8)!)
                    completion(.success(results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            }.resume()
    }
    
    //MARK: - DELETE Method

}


