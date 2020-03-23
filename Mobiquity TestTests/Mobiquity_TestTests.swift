//
//  Mobiquity_TestTests.swift
//  Mobiquity TestTests
//
//  Created by Afzal Murtaza on 21/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import XCTest
@testable import Mobiquity_Test

class Mobiquity_TestTests: XCTestCase {
    var sut: HistoryTableViewModel!
    var mainSut: MainViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = HistoryTableViewModelImp()
        mainSut = MainViewModelImp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mainSut = nil
    }
    func test_Saved_History_Exist() {
        mainSut.saveHistory(text: "test")
        XCTAssertTrue(sut.numberOfSections() > 0)
    }
    func test_ShowSearch_Result() {
        let promise = expectation(description: "Api responding without error")
        
        let dataHandler: FetchImagesDataHandler = FetchImagesDataHandler()
        dataHandler.getImages(for: "kitten") { (photos, reset, error) in
            if error == nil {
                XCTFail("Error: \(String(describing:error?.localizedDescription))")
            }
            else {
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 10)
        
    }
    func testSearchPerformance() {
        
        // This is an example of a performance test case.
        let dataHandler: FetchImagesDataHandler = FetchImagesDataHandler()
        self.measure {
            // Put the code you want to measure the time of here.
            dataHandler.getImages(for: "kitten") { (photos, reset, error) in
               
            }
        }
    }

}
