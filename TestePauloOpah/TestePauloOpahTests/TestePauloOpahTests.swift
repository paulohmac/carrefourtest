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
//        serviceFactory = ServiceFactory
    }
    
    func testServiceFactory(){
       XCTAssertTrue(serviceFactory?.getService() is GitHubHttpService, "Service factory getService method failed")
    }
    
    func testMoyaProvider()async throws{
        XCTAssertNotNil(provider?.async, "testMoyProvider async instance not null fail")
        
        var ret = try await provider?.async.sendRequest(SendRequest.search(param: "mojombo"), retType: SearchResult.self)
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

        class StubCodable: Codable{}
        
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

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
