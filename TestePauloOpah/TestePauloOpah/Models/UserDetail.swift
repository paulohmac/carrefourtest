//
//  UserDetail.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 20/06/23.
//

import UIKit

struct UserDetail:  Codable, Equatable {
    let id :  Int
    let login :  String
    let avatarUrl :  String?
    let htmlUrl :  String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl
        case htmlUrl
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        login = try container.decode(String.self, forKey: .login)
        avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
        htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
    }
    
}
