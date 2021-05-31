//
//  API.swift
//  VK news feed
//
//  Created by Владимир on 28.03.2021.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
//    static let version = "5.92"
    static let v = "5.130"
    static let newsFeed = "/method/newsfeed.get"
    
    static let user = "/method/users.get"
}
