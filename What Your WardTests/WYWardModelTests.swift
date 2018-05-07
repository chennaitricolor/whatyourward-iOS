import XCTest
@testable import WhatYourWard

class WYWardModelTests: XCTestCase {
    
    private var zoneDetails: [[String: Any]] = []
    private var wardDetails: [[String: Any]] = []
    private var wardGeoJson: [String: Any] = [:]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func fetchStubs() {
        wardGeoJson = WWardDetailFetcher.fetchWardBoundaryGeoJson()
        wardDetails = WWardDetailFetcher.fetchWardDetails()
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
    
    func testWardDataParsing() {
        
    }
    
    func testInvalidWard() {
        var ward: WYWard = WYWard()
        
        let invalidWardName: String = "Chennai Corporation"
        ward.updateWardNumber(invalidWardName)
        XCTAssertTrue(!ward.isValidWard, "Failed---> Ward Name String Manipulation Logic Modified")
        
        let validWardName: String = "Ward 199"
        ward.updateWardNumber(validWardName)
        XCTAssertTrue(ward.isValidWard, "Failed---> Ward Name String Manipulation Logic Failed")
    }
}
