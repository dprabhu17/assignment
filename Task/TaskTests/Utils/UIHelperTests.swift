//
//  UIHelperTests.swift
//  TaskTests
//
//  Created by D, Prabhu (Cognizant) on 06/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import XCTest
@testable import Task

class UIHelperTests: XCTestCase {

    var viewController: UIViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = UIViewController()
        viewController.view.frame = UIScreen.main.bounds
    }

    // Test for creating Label with default params
    func testForCreatingWithDefaultParams() {
        let label = UIHelper.shared.createLabel()
        viewController.view.addSubview(label)
        // Expected one label
        XCTAssertEqual(viewController.view.subviews.count, 1, "Expected label in container view")

   }
    // Test for creating label with Title (bold with font size)
    func testForCreatingLabelForTitleWithBoldText() {
         let label = UIHelper.shared.createLabel(fontSize: FONT_TITLE, isBold: true)
         viewController.view.addSubview(label)
         XCTAssertEqual(label.font.pointSize, FONT_TITLE, "Expected label in container view should contain title's font size as \(FONT_TITLE)")
         XCTAssertTrue(label.font.fontName.contains("-Bold"), "Expected label should contain bold text")
         XCTAssertEqual(viewController.view.subviews.count, 1, "Expected label in container view")

    }
    // Test for creating label with Description with default font without bold
    func testForCreatingLabelForFontSizeWithDefaultFontSize() {
        let label = UIHelper.shared.createLabel(fontSize: FONT_DEFAULT, isBold: false)
        viewController.view.addSubview(label)
        XCTAssertEqual(label.font.pointSize, FONT_DEFAULT, "Expected label in container view should contain default font size as \(FONT_DEFAULT)")
        XCTAssertFalse(label.font.fontName.contains("-Bold"), "Expected label should not bold")
        XCTAssertEqual(viewController.view.subviews.count, 1, "Expected label in container view")

    }
    // Test for creating Label with default params
     func testForCreatingImageView() {
         let imageView = UIHelper.shared.createImageView()
         viewController.view.addSubview(imageView)
         // Expected one label
         XCTAssertNotNil(imageView.image, "Expected ImageView has placeholder image")
         XCTAssertEqual(viewController.view.subviews.count, 1, "Expected ImageView in container view")

    }
    // Test for checkin the device is iPhone or not
    func testForCheckingIPhone() {
        XCTAssertEqual(UIHelper.shared.isPhone(), true, "Expected ImageView in container view")
    }
    // Test for getting the application Name
    func testForGettingAppName() {
        XCTAssertTrue((UIHelper.shared.getAppName() == Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""), "Expected to get application correct app name")
    }
    // Test for LoadingView
    func testForAddLoadingView() {

        UIHelper.shared.showLoading(onView: viewController.view)
        XCTAssertNotNil(UIHelper.shared.loader, "Expected Loader has been created successfully")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: { [weak self] in
            XCTAssertEqual(self?.viewController.view.subviews.count, 1, "Expected Loading View added in the container view")
        })

    }
    // Hiding the Loading View
    func testForHidingLoadingView() {

        // Add LoadingView
        UIHelper.shared.showLoading(onView: viewController.view)
        XCTAssertNotNil(UIHelper.shared.loader, "Expected Loader has been created successfully")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: { [weak self] in
            XCTAssertEqual(self?.viewController.view.subviews.count, 1, "Expected Loading View added in the container view")
        })
        // Hide Loading View
        UIHelper.shared.hideLoading()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: { [weak self] in
            XCTAssertEqual(self?.viewController.view.subviews.count, 0, "Expected Loading View should be removed from the root view")
        })
    }
    // Test for UIAlert
    func testForUIAlertView() {
        let messageToDisplay = "Message to display on UIAlertView"
        UIApplication.shared.windows[0].rootViewController = viewController
        let exp = expectation(description: "shows alert")
        // Handle loading view
        UIHelper.shared.showAlert(message: messageToDisplay, viewController: viewController, callback: {
            exp.fulfill()
        })
        waitForExpectations(timeout: 3)
    }
    // Test for Internet
    func testNetworkReachable() {
        let exp = expectation(description: "shows alert")
        // Check Internet Connection
        if Reachability.noNetwork {
            XCTAssertTrue(Reachability.noNetwork, "Internet connection is found")
            exp.fulfill()
        } else {
            XCTAssertFalse(Reachability.noNetwork, "Internet connection not found")
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    // Test for Adding Empty message for tableview
    func testEmptyMessageForUITableView() {
        let tableView = UITableView()
        let emptyMessageToDisplay = "No Feeds Found"
        let sectionCount: Int = UIHelper.shared.setEmptyMessageForTableView(tableView: tableView, dataSource: [], messageToDisplay: emptyMessageToDisplay)
        XCTAssertEqual(sectionCount, 0, "Expected Section count should be 0")
        XCTAssertNotNil(tableView.backgroundView, "Expected backgroundView of tableview property should not be empty")
    }
    // Test for Removing Empty Message if values present in tableview
    func testForNotReturningEmptyMessageUITableView() {
        let tableView = UITableView()
        let emptyMessageToDisplay = "No Feeds Found"
        let sectionCount: Int = UIHelper.shared.setEmptyMessageForTableView(tableView: tableView, dataSource: TestCaseUtils.shared.loadMockFeeds(count: 5), messageToDisplay: emptyMessageToDisplay)
        XCTAssertEqual(sectionCount, 1, "Expected Section count should be 1")
        XCTAssertNil(tableView.backgroundView, "Expected backgroundView of tableview property should be empty")
    }
}
