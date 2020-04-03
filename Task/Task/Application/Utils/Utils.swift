//
//  Utils.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 01/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    static var loader : UIView?
    
    // Singleton instance
    let shared = Utils()
    
    private override init() {
        super.init()
    }
    
    static func isPhone() -> Bool {
        return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
    }
    
}
