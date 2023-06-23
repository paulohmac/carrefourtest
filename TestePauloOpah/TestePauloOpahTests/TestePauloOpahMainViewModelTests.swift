//
//  TestePauloOpahViewModelTests.swift
//  TestePauloOpahTests
//
//  Created by Paulo H.M. on 22/06/23.
//

import XCTest

final class TestePauloOpahMainViewModelTests: XCTestCase {
    var sut : MainViewModel?

    override func setUpWithError() throws {
        sut = MainGitHubViewModel(factory: ServiceFactoryInvalidResultMock())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    func testInvalidCodable()async throws{
        await sut?.listUser()
        if (sut?.users) != nil{
            XCTAssertTrue(false,  "dont treted request result listUsers")
        }else{
            
        }
        do{
            if (sut?.getLogin(position: 0)) != nil{
                XCTAssertTrue(false,  "did treat request result getLogin")
            }
        }

        await sut?.findLogins(text: "mock")
        do{
            if (sut?.users) != nil {
                XCTAssertTrue(false,  "did treat request result findLogins")
            }
        }
    }

    func testValidCodable()async throws{
        sut = MainGitHubViewModel(factory: ServiceFactoryValidResultMock())
        await sut?.listUser()
        
        if let users = sut?.users {
           XCTAssertTrue(users.count > 0,  "wrong total users")
        }else{
            XCTAssertTrue(false,  "dont treated request result listUsers")
        }
        do{
            if (sut?.getLogin(position: 0)) != nil{

            }else{
                XCTAssertTrue(false,  "wrog getlogin return")
            }
        }catch{
            XCTAssertTrue(false,  "did treat request result getLogin")
        }

        await sut?.findLogins(text: "mojombo")
        do{
            if let val = sut?.users {
                if val.count == 0 || val.count < 1 {
                    XCTAssertTrue(false,  "Wrog total users")
                }
            }else{
                XCTAssertTrue(false,  "did treat request result findLogins")
            }
        }catch{
            XCTAssertTrue(false,  "did treat request result getLogin")
        }
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

  

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
