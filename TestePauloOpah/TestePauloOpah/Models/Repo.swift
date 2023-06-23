//
//  Repo.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 20/06/23.
//

import UIKit

struct Repo: Codable, Equatable {
    let name : String?
    let htmlUrl : String?
    let fullName : String?
    let description : String?
    let url : String?
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case htmlUrl
        case fullName
        case description
        case url
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try? container.decode(String.self, forKey: .name)
        htmlUrl = try? container.decode(String.self, forKey: .htmlUrl)
        fullName = try? container.decode(String.self, forKey: .fullName)
        description = try? container.decode(String.self, forKey: .description)
        url = try? container.decode(String.self, forKey: .url)
    }
}
