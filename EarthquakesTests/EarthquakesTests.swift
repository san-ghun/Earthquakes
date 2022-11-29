//
//  EarthquakesTests.swift
//  EarthquakesTests
//
//  Created by Sanghun Park on 29.11.22.
//  Copyright © 2022 Apple. All rights reserved.
//

import XCTest
@testable import Earthquakes

class EarthquakesTests: XCTestCase {
    
    func testGeoJSONDecoderDecodesQuake() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let quake = try decoder.decode(Quake.self, from: testFeature_nc73649170)
        
        XCTAssertEqual(quake.code, "73649170")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = quake.time.timeIntervalSince1970
        
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
    }
    
    func testGeoJSONDecoderDecodesGeoJSON() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let decoded = try decoder.decode(GeoJSON.self, from: testQuakesData)
        
        XCTAssertEqual(decoded.quakes.count, 6)
        XCTAssertEqual(decoded.quakes[0].code, "73649170")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = decoded.quakes[0].time.timeIntervalSince1970
        
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
    }
}

/*final class EarthquakesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}*/
