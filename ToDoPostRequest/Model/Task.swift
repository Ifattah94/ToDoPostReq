//
//  Task.swift
//  ToDoPostRequest
//
//  Created by C4Q on 4/27/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation

struct TaskResponse: Codable {
    let payload: [Task]
    let err: Bool
  
}

struct Task: Codable {
    let owner: String
    let text: String
    let completed: Bool
}
