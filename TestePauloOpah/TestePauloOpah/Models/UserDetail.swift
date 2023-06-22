//
//  UserDetail.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 20/06/23.
//

import UIKit

/*
 {
   "login": "MojoM",
   "id": 7649822,
   "node_id": "MDQ6VXNlcjc2NDk4MjI=",
   "avatar_url": "https://avatars.githubusercontent.com/u/7649822?v=4",
   "gravatar_id": "",
   "url": "https://api.github.com/users/MojoM",
   "html_url": "https://github.com/MojoM",
   "followers_url": "https://api.github.com/users/MojoM/followers",
   "following_url": "https://api.github.com/users/MojoM/following{/other_user}",
   "gists_url": "https://api.github.com/users/MojoM/gists{/gist_id}",
   "starred_url": "https://api.github.com/users/MojoM/starred{/owner}{/repo}",
   "subscriptions_url": "https://api.github.com/users/MojoM/subscriptions",
   "organizations_url": "https://api.github.com/users/MojoM/orgs",
   "repos_url": "https://api.github.com/users/MojoM/repos",
   "events_url": "https://api.github.com/users/MojoM/events{/privacy}",
   "received_events_url": "https://api.github.com/users/MojoM/received_events",
   "type": "User",
   "site_admin": false,
   "name": null,
   "company": null,
   "blog": "",
   "location": null,
   "email": null,
   "hireable": null,
   "bio": null,
   "twitter_username": null,
   "public_repos": 1,
   "public_gists": 81,
   "followers": 0,
   "following": 0,
   "created_at": "2014-05-20T22:56:33Z",
   "updated_at": "2020-01-25T21:31:25Z"
 }
 
 */

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
