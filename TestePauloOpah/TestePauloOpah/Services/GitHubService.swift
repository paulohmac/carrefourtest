//
//  GitHubService.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 30/05/23.
//

import Foundation
import Alamofire
import Moya

public protocol GitHubService{
    
}

class GitHubHttpService:  GitHubService{
    
    public func perfomrRequest(search : SendRequest){
        let provider = MoyaProvider<SendRequest>()
        if case let .search(value) = search {
            provider.request(.search(param: value)) { result in
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    let statusCode = moyaResponse.statusCode
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

extension SendRequest {

    public var baseURL: URL {
        return URL(string: Configuration.baseUrl)!
    }
    
    public var path: String{
        switch self {
        case .search:
            return "search/users?q=user:%@"
        case .detail:
            return "users/%@"
        case .list:
            return "users"
        }
    }
    
    public var method: Moya.Method{
        switch self {
        case .search:
            return .get
        case .detail:
            return .post
        case .list:
            return .get
        }
    }
    
    public var task: Moya.Task {
        return .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]?{
        return ["Content-type": "application/json"]
    }
    
    public var sampleData: Data {
            return Data()
        }
    
}

enum SendRequest : TargetType{
    case search(param : String)
    case detail(id : String)
    case list
}

struct Configuration{
    static public let baseUrl = "https://api.github.com/"
}
