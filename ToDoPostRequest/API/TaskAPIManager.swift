//
//  TaskAPIManager.swift
//  ToDoPostRequest
//
//  Created by C4Q on 4/27/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation

class TaskAPIManager {
    
    private init() {}
    
    static let shared = TaskAPIManager()
    
    //MARK: GET ALL TASKS
    private let baseURLStr: String = "https://fsw62-todos-api.herokuapp.com/api"
    
    func getAllTasks(completion: @escaping (Result <[Task], AppError>) -> Void) {
        let completeURL = baseURLStr + EndPoints.ToDos.rawValue
        
        guard let url = URL(string: completeURL) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let taskResponse = try JSONDecoder().decode(TaskResponse.self, from: data)
                        
                        completion(.success(taskResponse.payload))
                    }
                    catch {
                        completion(.failure(.DecodingError(error: error)))
                    }
                }
                
            }
        }.resume()
    }
    
    //MARK: Sign Up
    
    func signUp(user: User,completion: @escaping(Result <(), AppError>) -> Void) {
        let completeURLStr = self.baseURLStr + EndPoints.SignUp.rawValue
        guard let url = URL(string: completeURLStr) else {
            completion(.failure(.badURL))
            return
        }
        var data: Data?
        
        do {
            let encodedData = try JSONEncoder().encode(user)
            data = encodedData
        } catch {
            completion(.failure(.EncodingError(error: error)))
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.errorGettingData(error: error)))
            }
            
            guard let _ = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(()))
            
        }.resume()
    }
    
    
    
    
    
    
    
}
