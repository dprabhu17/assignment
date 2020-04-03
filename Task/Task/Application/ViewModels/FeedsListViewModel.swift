//
//  FeedsListViewModel.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 01/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

class FeedsListViewModel {

    var onErrorHandling: ((NetworkError) -> Void)?
    var title: String!

    func loadFeeds() {

         HTTPServices().load(resource: Feed.all) { [weak self] result in

            switch result {

            case .success(let response):
                self?.title = response.title

            case .failure(let error):
                 self?.onErrorHandling?(error)

            }

        }

    }

}
