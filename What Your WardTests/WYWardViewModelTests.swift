import XCTest
@testable import WhatYourWard

class WYWardViewModelTests: XCTestCase {
    
    let viewModel: WYWardViewModel = WYWardViewModel()
    
    private let totalNumberOfWards: Int = 199
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLoadingWards() {
        XCTAssertNotNil(viewModel, "Failed--->ViewModel is not initialised")
    }
    
    func testTotalNumberOfWards() {
        XCTAssertTrue(viewModel.wards.count == totalNumberOfWards)
    }
    
    func testFetchWardDetail() {
        let wardNumberToFetch = 30
        
        if let ward: WYWard = viewModel.fetchWardDetail(wardNumber: wardNumberToFetch) {
            XCTAssertTrue(ward.wardNo == wardNumberToFetch, "Failed--->Fetched ward number Does not match")
        } else if wardNumberToFetch > 0 && wardNumberToFetch <= totalNumberOfWards {
            XCTFail("Failed--->Ward Not Found")
        }
    }
}
