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
    func perfomrRequest(search : SendRequest)
}

class GitHubHttpService:  GitHubService{
    public func perfomrRequest(search : SendRequest){
        let provider = MoyaProvider<SendRequest>()
        
        if case let .search(value) = search {
            provider.request(.search(param: value)) { result in
//                mapReturn(result )
            }
        }
    }
    
    private func mapReturn<T : Codable>(requestReturn : Result<Response, MoyaError>, retType : T.Type) -> RequestResult{
        switch requestReturn {
        case let .success(moyaResponse):
            let statusCode = moyaResponse.statusCode
            let data = moyaResponse.data
            //This will be fixed to work with dynamic type
            let jsonData = try! JSONDecoder().decode ( retType.self , from: data)
            return  .sucess(codable: jsonData)
        case let .failure(error):
            print(error.localizedDescription)
            return  .error(error: ResponseError(code: error.errorCode, message: error.errorDescription ?? ""))
        }
    }
}

enum RequestResult {
    case sucess(codable : Codable)
    case error(error : Error)
}

struct ResponseError: Error {
    ///Http Codes mapping
    enum ApiHTTPCodes : Int {
        case invalidToken        = 401   //Status code 403
        case accessDenied        = 402   //Status code 403
        case forbidden           = 403   //Status code 403
        case notFound            = 404   //Status code 404
        case conflict            = 409   //Status code 409
        case internalServerError = 500   //Status code 500
    }

    let code: Int
    let message: String
}
