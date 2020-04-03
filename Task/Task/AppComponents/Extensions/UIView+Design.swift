//
//  UIView+Design.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 02/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

extension UIView {

    // Creates rounded corner
    func setAsRoundedCorner(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {

        //Corner Radius
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true

        //Add borders
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }

    // Makes the view as card View
    func setAsCardView() {

        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 3.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.6

   }

}
