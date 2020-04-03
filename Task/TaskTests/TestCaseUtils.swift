//
//  TestCaseUtils.swift
//  TaskTests
//
//  Created by D, Prabhu (Cognizant) on 03/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit
@testable import Task

let PARSE_ERROR_URL = "https://www.google.com/"

class TestCaseUtils {
    
    // MARK: Singleton Instance
    static let shared = TestCaseUtils()
    private init(){}
    
    // MARK: Mock Feeds for Testing
    func loadMockFeeds(count: Int) -> [Feed] {
        
        var feeds: [Feed] = []
        for index in 0..<count {
            feeds.append(Feed(title: "Test \(index)", description: "Test description \(index)", imageURL: "img_url_temp_\(index)"))
        }
        
        return feeds
    }

}
