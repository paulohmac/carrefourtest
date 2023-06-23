//
//  TestePauloOpahMainCoordinator.swift
//  TestePauloOpahTests
//
//  Created by Paulo H.M. on 22/06/23.
//

import XCTest

final class TestePauloOpahMainCoordinator: XCTestCase, CoordinatorSpy {
    var sut : Coordinator?
    var detailOpened = false
    override func setUpWithError() throws {
        sut = MainCoordinator.getInstance()
        sut?.spy =  self
    }
    
    func testDetailScreenOpened(){
        sut?.openDetail(id: "10")
        XCTAssertTrue(detailOpened, "Detail is not onpened")
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }
    
    func detailViewControllerOpened() {
        detailOpened = true
    }

}

