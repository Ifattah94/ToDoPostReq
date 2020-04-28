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
    
    
    
}
