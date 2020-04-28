//
//  AppError.swift
//  ToDoPostRequest
//
//  Created by C4Q on 4/27/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badURL
    case DecodingError(error: Error)
    case noData
    
}
