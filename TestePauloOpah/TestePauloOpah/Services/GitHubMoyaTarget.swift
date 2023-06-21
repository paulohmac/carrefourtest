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
    case repos(user : String)
}

extension SendRequest {

    public var baseURL: URL {
        return URL(string: Configuration.baseUrl)!
    }
    
    public var path: String{
        switch self {
        case .search:
            return "search/users"
        case .detail(let name):
            return String(format:"users/%@", name)
        case .list:
            return "users"
        case .repos(let user):
            return String(format:"users/%@/repos", user)
        }
    }
    
    public var method: Moya.Method{
        switch self {
        case .search:
            return .get
        case .detail:
            return .get
        case .list:
            return .get
        case .repos:
            return .get
        }
    }
    
    public var task: Moya.Task {
        var parameters = [String: String]()
        switch self {
        case .search(let param):
            parameters["q"] = String(format:"user:%@", param )
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .detail,.list,.repos:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]?{
        return ["Content-type": "text/plain"]
    }
    
    public var sampleData: Data {
            return Data()
        }
    
}

