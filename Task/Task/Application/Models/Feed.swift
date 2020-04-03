//
//  Feed.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 01/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import Foundation

struct Feed: Codable {

    let title: String?
    let description: String?
    let imageURL: String?

    private enum CodingKeys: String, CodingKey {
       case title
       case description
       case imageURL = "imageHref"
   }

}

struct FeedsList: Codable {

    let title: String
    let feeds: [Feed]

    private enum CodingKeys: String, CodingKey {
        case title
        case feeds = "rows"
    }

}

extension Feed {

    static var all: Resource<FeedsList> = {

        guard let url = URL(string: FEED_URL) else {
            fatalError("URL is incorrect!")
        }
        return Resource<FeedsList>(url: url)

    }()

}
