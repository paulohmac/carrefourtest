//
//  ServiceFactoryMock.swift
//  TestePauloOpahTests
//
//  Created by Paulo H.M. on 22/06/23.
//

import UIKit

class ServiceFactoryInvalidResultMock: Factory {
    func getService() -> GitHubService {
        return GitHubServiceInvalidResultMock()
    }
    
}

class GitHubServiceInvalidResultMock : GitHubService{
    func performRequest(action: SendRequest) async throws -> RequestResult? {
        return RequestResult.success(codable: StubCodable())
 }
}



class ServiceFactoryValidResultMock: Factory {
    func getService() -> GitHubService {
        return GitHubServiceValidResultMock()
    }
}

class GitHubServiceValidResultMock : GitHubService{
    func performRequest(action: SendRequest) async throws -> RequestResult? {

        if case .search(_) = action {
            return RequestResult.success(codable: MockedCodableFactory.createSearchResul())
        }else if case .list = action {
            return RequestResult.success(codable: MockedCodableFactory.createListResul())
        }else if case .detail(_) = action {
            return RequestResult.success(codable: MockedCodableFactory.createDetailResul())
        }else if case .repos(_) = action {
            return RequestResult.success(codable: MockedCodableFactory.createReposListResul())
        }else{
            return nil
        }
    }
}
 
class MockedCodableFactory{
    
    class func createSearchResul()->Codable {
        let fakeData = """
        {
                "total_count": 1,
                "incomplete_results": false,
                "items": [
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
                    "score": 1.0
                  }
                ]
              }
        """
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var codable : Codable?
        do{
            codable = try decoder.decode(SearchResult.self, from: Data(fakeData.utf8) )
        }catch{
            print( error )
        }
        return codable!
    }
    
    class func createListResul()->Codable {
        let fakeData = """
        [
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
          },
          {
            "login": "defunkt",
            "id": 2,
            "node_id": "MDQ6VXNlcjI=",
            "avatar_url": "https://avatars.githubusercontent.com/u/2?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/defunkt",
            "html_url": "https://github.com/defunkt",
            "followers_url": "https://api.github.com/users/defunkt/followers",
            "following_url": "https://api.github.com/users/defunkt/following{/other_user}",
            "gists_url": "https://api.github.com/users/defunkt/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/defunkt/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/defunkt/subscriptions",
            "organizations_url": "https://api.github.com/users/defunkt/orgs",
            "repos_url": "https://api.github.com/users/defunkt/repos",
            "events_url": "https://api.github.com/users/defunkt/events{/privacy}",
            "received_events_url": "https://api.github.com/users/defunkt/received_events",
            "type": "User",
            "site_admin": false
          }
        ]
        """
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var codable : Codable?
        do{
             codable = try decoder.decode([Login].self, from: Data(fakeData.utf8) )
        }catch{
            print( error )
        }
        return codable!
    }
    
    class func createDetailResul()->Codable {
        let fakeData = """
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
        """
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var codable : Codable?
        do{
             codable = try decoder.decode(Login.self, from: Data(fakeData.utf8) )
        }catch{
            print( error)
        }
        return codable!
    }
    
    class func createReposListResul()->Codable {
        let fakeData = """
        [
          {
            "id": 26899533,
            "node_id": "MDEwOlJlcG9zaXRvcnkyNjg5OTUzMw==",
            "name": "30daysoflaptops.github.io",
            "full_name": "mojombo/30daysoflaptops.github.io",
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
            "html_url": "https://github.com/mojombo/30daysoflaptops.github.io",
            "description": null,
            "fork": false,
            "url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io",
            "forks_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/forks",
            "keys_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/keys{/key_id}",
            "collaborators_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/collaborators{/collaborator}",
            "teams_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/teams",
            "hooks_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/hooks",
            "issue_events_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/issues/events{/number}",
            "events_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/events",
            "assignees_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/assignees{/user}",
            "branches_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/branches{/branch}",
            "tags_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/tags",
            "blobs_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/git/blobs{/sha}",
            "git_tags_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/git/tags{/sha}",
            "git_refs_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/git/refs{/sha}",
            "trees_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/git/trees{/sha}",
            "statuses_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/statuses/{sha}",
            "languages_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/languages",
            "stargazers_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/stargazers",
            "contributors_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/contributors",
            "subscribers_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/subscribers",
            "subscription_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/subscription",
            "commits_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/commits{/sha}",
            "git_commits_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/git/commits{/sha}",
            "comments_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/comments{/number}",
            "issue_comment_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/issues/comments{/number}",
            "contents_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/contents/{+path}",
            "compare_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/compare/{base}...{head}",
            "merges_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/merges",
            "archive_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/{archive_format}{/ref}",
            "downloads_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/downloads",
            "issues_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/issues{/number}",
            "pulls_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/pulls{/number}",
            "milestones_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/milestones{/number}",
            "notifications_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/notifications{?since,all,participating}",
            "labels_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/labels{/name}",
            "releases_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/releases{/id}",
            "deployments_url": "https://api.github.com/repos/mojombo/30daysoflaptops.github.io/deployments",
            "created_at": "2014-11-20T06:42:06Z",
            "updated_at": "2023-04-05T16:47:06Z",
            "pushed_at": "2014-11-20T06:42:47Z"
           }
        ]
        """
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var codable : Codable?
        do{
             codable = try decoder.decode([Repo].self, from: Data(fakeData.utf8) )
        }catch{
            print( error )
        }
        return codable!
    }
    
}


