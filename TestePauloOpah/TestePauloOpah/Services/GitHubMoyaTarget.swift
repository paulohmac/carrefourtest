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
        case .search(let param):
            return "search/users"
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
        switch self {
        case .search(let param):
            let parameters : [String: String] = ["q" : String(format:"user:%@", param )]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .detail(let id ):
            let parameters : [String: String] = ["id" : id]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .list:
            let parameters = [String: String]()
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

