//
//  TestePauloOpahDetailMainViewModelTests.swift
//  TestePauloOpahTests
//
//  Created by Paulo H.M. on 22/06/23.
//

import XCTest

final class TestePauloOpahDetailMainViewModelTests: XCTestCase {

    var sut : DetailViewModel?
    var user = "mojombo"
    
    override func setUpWithError() throws {
        sut = DetailGitViewModel(factory: ServiceFactoryInvalidResultMock())
    }
    
    
    func testInvalidCodable()async throws{
        await sut?.getUserDetail(user: user)
        if (sut?.userDetail) != nil{
            XCTAssertTrue(false,  "dont treated request invalid result getUserDetail")
        }else{
            
        }
        await sut?.getUserRepos(user: user)
        do{
            if let repos = sut?.repos {
                XCTAssertTrue(false,  "getUserRepos didn't treat incorret data return")
                if repos.count > 0 {
                    XCTAssertTrue(false,  "getUserRepos didn't treat incorret data return, count above zero")
                }
            }else{

            }
        }
    }

    func testValidCodable()async throws{
        sut = DetailGitViewModel(factory: ServiceFactoryValidResultMock())
        await sut?.getUserDetail(user: user)
        
        if let detail = sut?.userDetail{

        }else{
            XCTAssertTrue(false,  "problem retrieving getUserDetail")
        }

        await sut?.getUserRepos(user: user)
        do{
            if let repos = sut?.repos {
                if repos.count < 1 {
                    XCTAssertTrue(false,  "getUserRepos dont return correct data")
                }
            }else{
                XCTAssertTrue(false,  "didn't treat request invalid result getUserRepos")
            }
        }
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
