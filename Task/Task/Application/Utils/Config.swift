//
//  Config.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 03/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

// MARK: App Constants
let FONT_TITLE: CGFloat = UIHelper.shared.isPhone() ? 16 : 24
let FONT_DEFAULT: CGFloat = UIHelper.shared.isPhone() ? 14 : 22
let IMG_SIZE: CGFloat = (UIHelper.shared.isPhone()) ? 70 : 140
let EDGE_SIZE: CGFloat = (UIHelper.shared.isPhone()) ? 12 : 20
let MIN_EDGE_SIZE: CGFloat = (UIHelper.shared.isPhone()) ? 5 : 8

// MARK: API Endpoint
let FEED_URL = "https://a7fe808a-1e6c-4008-816c-5e33f17046dd.mock.pstmn.io/getusers"
