//
//  ErrorViewModel.swift
//  TaskTests
//
//  Created by D, Prabhu (Cognizant) on 06/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import XCTest
@testable import Task

class ErrorViewModel: XCTestCase {

    var errorCode: NetworkError!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    // Test for No internet Found Error
    func testForNoNetworkFound() {
        errorCode = .noNetworkFound
        XCTAssertTrue(errorCode == .noNetworkFound, "Expect No Internet connection found error")
        XCTAssertNotNil(errorCode.description)
    }
    // Test for No internet Found Error
    func testForDecoding() {
        errorCode = .decodingError
        XCTAssertTrue(errorCode == .decodingError, "Expect Decoding error")
        XCTAssertNotNil(errorCode.description)
    }
    // Test for No internet Found Error
    func testForDomainError() {
        errorCode = .domainError
        XCTAssertTrue(errorCode == .domainError, "Expect Domain Error")
        XCTAssertNotNil(errorCode.description)
    }
    // Test for No internet Found Error
    func testForURLError() {
        errorCode = .urlError
        XCTAssertTrue(errorCode == .urlError, "Expect Invalid URL Error")
        XCTAssertNotNil(errorCode.description)
    }
}
