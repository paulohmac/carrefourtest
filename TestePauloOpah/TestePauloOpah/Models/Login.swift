//
//  Login.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 01/06/23.
//

/*[
 {
   "login": "mojombo",
   "id": 1,
   "node_id": "MDQ6VXNlcjE=",
   "avatar_url": "https://avatars.githubusercontent.com/u/1?v=4",
   "gravatar_id": "",
   "url": "https://api.github.com/users/mojombo",
   "html_url": "https://github.com/mojombo",
   "followers_url": "https://api.github.com/users/mojombo/followers",
   "following_url": "https://api.github.com/users/mojombo/following{/other_user}",
   "gists_url": "https://api.github.com/users/mojombo/gists{/gist_id}",
   "starred_url": "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
   "subscriptions_url": "https://api.github.com/users/mojombo/subscriptions",
   "organizations_url": "https://api.github.com/users/mojombo/orgs",
   "repos_url": "https://api.github.com/users/mojombo/repos",
   "events_url": "https://api.github.com/users/mojombo/events{/privacy}",
   "received_events_url": "https://api.github.com/users/mojombo/received_events",
   "type": "User",
   "site_admin": false
 }
 */

import UIKit

public struct Login: Codable, Equatable {
    let id :  Int
    let login :  String
    let avatar_url :  String?
    let html_url :  String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatar_url
        case html_url
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        login = try container.decode(String.self, forKey: .login)
        avatar_url = try container.decode(String.self, forKey: .avatar_url)
        html_url = try container.decode(String.self, forKey: .html_url)
    }
}

public struct SearchResult: Codable, Equatable {
    let total_count :  Int
    let items :  [Login]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total_count = try container.decode(Int.self, forKey: .total_count)
        items = try container.decode([Login].self, forKey: .items)
    }
}
