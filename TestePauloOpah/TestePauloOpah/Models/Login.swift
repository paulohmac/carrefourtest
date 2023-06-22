//
//  Login.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 01/06/23.
//
import UIKit

public struct Login: Codable, Equatable {
    let id :  Int
    let login :  String
    let avatarUrl :  String?
    let htmlUrl :  String?
    let reposUrl  : String?
    let url  : String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl
        case htmlUrl
        case reposUrl
        case url
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        login = try container.decode(String.self, forKey: .login)
        avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
        htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
        reposUrl = try container.decode(String.self, forKey: .reposUrl)
        url = try container.decode(String.self, forKey: .url)
    }
}

public struct SearchResult: Codable, Equatable {
    let totalCount :  Int
    let items :  [Login]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try container.decode(Int.self, forKey: .totalCount)
        items = try container.decode([Login].self, forKey: .items)
    }
}
