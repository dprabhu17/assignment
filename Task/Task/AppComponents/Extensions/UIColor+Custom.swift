//
//  UIColor+Custom.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 02/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

// MARK: List of Colors for this App
extension UIColor {

    static var appColor: UIColor {
        return UIColor(rgb: 0x3063CB)
    }

    static var appTextColor: UIColor {
        return UIColor(rgb: 0x424242)
    }

    static var borderColor: UIColor {
        return UIColor(rgb: 0xD3D3D3)
    }

}

// MARK: Extention to set Hex Colors
extension UIColor {

    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

}
