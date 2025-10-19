//
//  DTOs.swift
//  client
//
//  Created by Luke on 10/16/25.
//

import Foundation

struct RegisterResponse: Codable {
    let message: String?
    let success: Bool
}

struct LoginResponse: Codable {
    let message: String?
    let success: Bool
    let token: String?
    let username: String?
    let userId: Int?
}

struct ErrorResponse: Codable {
    let message: String?
}

