//
//  ErrorViewModel.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 06/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case noNetworkFound
    case decodingError
    case domainError
    case urlError
    var description: String? {
        switch self {
        case .noNetworkFound:
            return "Please check internet connection and try again!"

        case .decodingError:
            return "Parsing Error, Please check your respone!"

        case .domainError:
            return "Oops something went wrong. Please try again by pull down!"

        case .urlError:
            return "Error occured, Please try again by pull down!"
        }
    }
}
