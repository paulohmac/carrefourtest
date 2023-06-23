//
//  TestePauloOpahTests.swift
//  TestePauloOpahTests
//
//  Created by Paulo H.M. on 31/05/23.
//

import XCTest
import Moya

@testable import TestePauloOpah

final class TestePauloOpahTests: XCTestCase {
    var serviceFactory : ServiceFactory?
    var provider : MoyaProvider<SendRequest>?

    override func setUpWithError() throws {
        serviceFactory =  ServiceFactory()
        provider = MoyaProvider<SendRequest>()
    }
    
    func testServiceFactory(){
       XCTAssertTrue(serviceFactory?.getService() is GitHubHttpService, "Service factory getService method failed")
    }
    
    func testMoyaProvider()async throws{
        XCTAssertNotNil(provider?.async, "testMoyProvider async instance not null fail")
        
        let ret = try await provider?.async.sendRequest(SendRequest.search(param: "mojombo"), retType: SearchResult.self)
        XCTAssertNotNil(ret,  "MoyaProvider return is nil")

        var typeChecking = false
        if case .success(_) = ret {
            typeChecking = true
        }
        XCTAssertTrue(typeChecking,  "request return is not sucess")

        do{
            _ = try await provider?.async.sendRequest(SendRequest.search(param: "XASADASDADLLL@@@11221"), retType: SearchResult.self)
            XCTAssertTrue(false,  "Provider dont return throws when we send invalid user")
        }catch{
        }
        
        do{
            _ = try await provider?.async.sendRequest(SendRequest.search(param: "mojombo"), retType: StubCodable.self)
        }catch{
            XCTAssertTrue(false,  "provider dont throw error when we send invalid parameter")
        }
    }
    
    override func tearDownWithError() throws {
        serviceFactory = nil
        provider = nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class StubCodable: Codable{}
