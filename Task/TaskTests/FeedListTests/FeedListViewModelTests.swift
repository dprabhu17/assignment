//
//  FeedListViewModelTests.swift
//  TaskTests
//
//  Created by D, Prabhu (Cognizant) on 03/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import XCTest
@testable import Task

class FeedListViewModelTests: XCTestCase {

    var viewModel: FeedsListViewModel!
    var dataSource: GenericDataSource<Feed>!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.dataSource = GenericDataSource<Feed>()
        self.viewModel = FeedsListViewModel(dataSource: dataSource)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.viewModel = nil
        self.dataSource = nil
    }

    func testLoadFeeds() {

        let expectation = XCTestExpectation(description: "Loading Feeds")

        // expected completion to fail
        viewModel.onErrorHandling = { error in
            XCTAssertFalse(true)
            expectation.fulfill()
        }

        self.dataSource.data.addAndNotify(observer: self) { _ in
            expectation.fulfill()
        }

        viewModel.loadFeeds()
        wait(for: [expectation], timeout: 5.0)

    }

}
