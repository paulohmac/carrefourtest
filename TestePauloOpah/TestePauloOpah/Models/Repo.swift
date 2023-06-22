//
//  Repo.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 20/06/23.
//

import UIKit
/*
{
    "id": 17358646,
    "node_id": "MDEwOlJlcG9zaXRvcnkxNzM1ODY0Ng==",
    "name": "asteroids",
    "full_name": "mojombo/asteroids",
    "private": false,
    "owner": {
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
    },
    "html_url": "https://github.com/mojombo/asteroids",
    "description": "Destroy your Atom editor, Asteroids style!",
    "fork": false,
*/
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
