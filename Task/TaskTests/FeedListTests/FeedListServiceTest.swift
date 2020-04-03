//
//  FeedListServiceTest.swift
//  TaskTests
//
//  Created by D, Prabhu (Cognizant) on 03/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import XCTest
@testable import Task

class FeedListServiceTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidResponse() {

        let expectation = XCTestExpectation(description: "Loading Feeds Testing")

        guard let url = URL(string: FEED_URL) else {
            fatalError("URL is incorrect!")
        }

        let all: Resource<FeedsList> = Resource<FeedsList>(url: url)
        HTTPServices().load(resource: all) { result in

            switch result {
            case .success(let response):
            XCTAssert(response.feeds.count > 0, "Feeds received")
            expectation.fulfill()
            case .failure(let error):
            XCTAssert(error == .noNetworkFound, "Failed with Error")
            expectation.fulfill()
            }

        }

        wait(for: [expectation], timeout: 5.0)

    }

    func testParseError() {

        let expectation = XCTestExpectation(description: "Parse Error Testing")

        guard let url = URL(string: PARSE_ERROR_URL) else {
            fatalError("URL is incorrect!")
        }

        let all: Resource<FeedsList> = Resource<FeedsList>(url: url)
        HTTPServices().load(resource: all) { result in

            switch result {
            case .success( _):
                expectation.fulfill()
            case .failure(let error):
                XCTAssert(error == .decodingError, "Failed to parse the response")
                expectation.fulfill()
            }

        }

        wait(for: [expectation], timeout: 5.0)

    }
    

}
