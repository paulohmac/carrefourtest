//
//  GitHubMoyaTarget.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 31/05/23.
//

import Foundation
import Moya

public enum SendRequest : TargetType{
    case search(param : String)
    case detail(id : String)
    case list
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

