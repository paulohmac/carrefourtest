//
//  TestePauloOpahGitHubServiceTests.swift
//  TestePauloOpahTests
//
//  Created by Paulo H.M. on 22/06/23.
//

import XCTest

final class TestePauloOpahGitHubServiceTests: XCTestCase {
    var sut : GitHubService?
    var userMock = "motombo"

    override func setUpWithError() throws {
        sut = GitHubHttpService()
    }
    
    func testPerformSearchRequest()async throws{
        var param = SendRequest.search(param: userMock)
        var resultSearch = try await sut?.perfomrRequest(action: param)
        
        if case .success(let codable) = resultSearch {
            if !(codable is SearchResult){
                XCTAssertTrue(false,  "wrong result type user search")
            }else{
                if ((codable as? SearchResult)?.totalCount == 0){
                    XCTAssertTrue(false,  "wrong totalcount result of user search")
                }
            }
        }else if case .error(_) = resultSearch {
            XCTAssertTrue(false,  "error retrieving user search")
        }
    }

    func testPerformReposRequest()async throws{
        var userMock2 = "Motom"
        var param = SendRequest.repos(user: userMock2)
        var resultSearch = try await sut?.perfomrRequest(action: param)
        
        if case .success(let codable) = resultSearch {
            if !(codable is [Repo]){
                XCTAssertTrue(false,  "wrong result type repos search")
            }else{
                if ((codable as? [Repo])?.count == 0){
                    XCTAssertTrue(false,  "wrong count of  repos search")
                }
            }
        }else if case .error(_) = resultSearch {
            XCTAssertTrue(false,  "error retrieving user repos")
        }
    }

    func testPerformUserListRequest()async throws{
        var param = SendRequest.list
        var resultSearch = try await sut?.perfomrRequest(action: param)
        
        if case .success(let codable) = resultSearch {
            if !(codable is [Login]){
                XCTAssertTrue(false,  "wrong result user list")
            }else{
                if ((codable as? [Login])?.count == 0){
                    XCTAssertTrue(false,  "wrong count of  user list")
                }
            }
        }else if case .error(_) = resultSearch {
            XCTAssertTrue(false,  "error retrieving  user list")
        }
    }

    func testPerformUserDetailRequest()async throws{
        var param = SendRequest.detail(id: userMock)
        var resultSearch = try await sut?.perfomrRequest(action: param)
        
        if case .success(let codable) = resultSearch {
            if !(codable is Login){
                XCTAssertTrue(false,  "wrong result user detail")
            }else{
                print("***")
                print((codable as? Login)?.login)
                if ((codable as? Login)?.login.lowercased() != userMock.lowercased()){
                    XCTAssertTrue(false,  "wrong login on user detail")
                }
            }
        }else if case .error(_) = resultSearch {
            XCTAssertTrue(false,  "error retrieving user detail")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
