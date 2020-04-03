//
//  FeedListDataSourceTests.swift
//  TaskTests
//
//  Created by D, Prabhu (Cognizant) on 03/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import XCTest
@testable import Task

class FeedListDataSourceTests: XCTestCase {

    var dataSource: FeedsDataSource!
    var viewModel: FeedsListViewModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataSource = FeedsDataSource()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        dataSource = nil
    }

    func testEmptyValuesInTable() {

        // giving empty data value
        dataSource.data.value = []

        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource

        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 0, "Expected one section in table view")

        // expected zero cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")

    }

    func testValuesInTable() {

        dataSource.data.value = TestCaseUtils.shared.loadMockFeeds(count: 2)

        let tableView = UITableView()
        tableView.dataSource = dataSource

        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")

        // expected two cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")

    }

    func testValueCell() {

        // giving data value
        dataSource.data.value = TestCaseUtils.shared.loadMockFeeds(count: 1)

        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(FeedListCell.self, forCellReuseIdentifier: "FeedListCell")

        let indexPath = IndexPath(row: 0, section: 0)

        // expected CurrencyCell class
        guard dataSource.tableView(tableView, cellForRowAt: indexPath) as? FeedListCell != nil else {
            XCTAssert(false, "Expected FeedListCell class")
            return
        }

    }

}
