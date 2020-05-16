//
//  APIClient.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 12/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import Foundation

class APIClient {
    
    //MARK: -  Method For Fetching Employee Data from Server
    func getAllEmployeeList(completion: @escaping (Result<EmployeeDataModel, Error>) -> Void) {
        let urlString = "\(APIConstants.BaseURL.url)\(APIConstants.APIMethodName.getEmployeesList)"
        performRequestForGETAPI(requestUrl: URL(string: urlString)!,resultType: EmployeeDataModel.self) { result in
            switch(result) {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: -  Method For Creating New Employee
    func createNewEmployee(employee: EmployeeInfo, completion: @escaping (Result<CreateNewEmployeeDataModel, Error>) -> Void) {
        let urlString = "\(APIConstants.BaseURL.url)\(APIConstants.APIMethodName.createNewEmployee)"
        guard let body = try? JSONEncoder().encode(employee) else { return }
        performRequestForPOSTAPI(requestUrl: URL(string: urlString)!, requestBody: body, resultType: CreateNewEmployeeDataModel.self) { result in
            switch(result) {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: -  Method For Deleting Employee Record
    func deleteEmployee(employeeID: Int, completion: @escaping (Result<DeleteEmployeeDataModel, Error>) -> Void) {
        let urlString = "\(APIConstants.BaseURL.url)\(APIConstants.APIMethodName.deleteEmployee)"
        performRequestForGETAPI(requestUrl: URL(string: urlString)!,resultType: DeleteEmployeeDataModel.self) { result in
            switch(result) {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Private method for POST API
    private func performRequestForPOSTAPI<T: Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: requestUrl)
        request.httpMethod = APIConstants.APIMethodType.post
        request.addValue(APIConstants.HTTPHeaderField.applicationJson.rawValue, forHTTPHeaderField: APIConstants.HTTPHeaderField.contentType.rawValue)
        request.httpBody = requestBody
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(T.self, from: jsonString.data(using: .utf8)!)
                    completion(.success(results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            }.resume()
}
    //MARK: - Private methods for GET API
     private func performRequestForGETAPI<T: Decodable>(requestUrl: URL, resultType: T.Type , completion: @escaping (Result<T, Error>) -> Void) {
            URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
                if let err = error {
                    completion(.failure(err))
                    print(err.localizedDescription)
                } else {
                    guard let data = data else { return }
                    let jsonString = String(decoding: data, as: UTF8.self)
                    do {
                        let results = try JSONDecoder().decode(T.self, from: jsonString.data(using: .utf8)!)
                        completion(.success(results))
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                }
                }.resume()
    }
}
