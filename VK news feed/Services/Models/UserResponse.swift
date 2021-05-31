//
//  UserResponse.swift
//  VK news feed
//
//  Created by Владимир on 28.05.2021.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
