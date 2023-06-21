//
//  Alamofire+Extensions.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 19/06/23.
//

import UIKit
import Moya

extension MoyaProvider {
    
    class MoyaConcurrency {
        
        private let provider: MoyaProvider
        
        init(provider: MoyaProvider) {
            self.provider = provider
        }
        
        func request<T: Codable>(_ target: Target, retType : T.Type) async throws -> RequestResult {
            return try await withCheckedThrowingContinuation { continuation in
                provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        let decoder = JSONDecoder()
                        guard let res = try? decoder.decode( T.self , from: response.data) else {
                            continuation.resume(throwing: MoyaError.jsonMapping(response))
                            return
                        }
                        continuation.resume(returning: .sucess(codable: res))
                    case .failure(let error):
                        continuation.resume(returning: .error(error: ResponseError(code: error.errorCode, message: error.errorDescription ?? "")))
                    }
                }
            }
        }
        
        func requestArray<T: Codable>(_ target: Target, retType : T.Type) async throws -> RequestResult {
            return try await withCheckedThrowingContinuation { continuation in
                provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        let decoder = JSONDecoder()
                        guard let res = try? decoder.decode( T.self , from: response.data) else {
                            continuation.resume(throwing: MoyaError.jsonMapping(response))
                            return
                        }
                        continuation.resume(returning: .sucess(codable: res))
                    case .failure(let error):
                        continuation.resume(returning: .error(error: ResponseError(code: error.errorCode, message: error.errorDescription ?? "")))
                    }
                }
            }
        }
    }

    var async: MoyaConcurrency {
        MoyaConcurrency(provider: self)
    }
}
