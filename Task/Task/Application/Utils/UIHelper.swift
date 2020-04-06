//
//  UIHelper.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 06/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

class UIHelper: NSObject {

    var loader: UIView?

    // Singleton instance
    static let shared = UIHelper()

    private override init() {
        super.init()
    }
}

// MARK: UIComonents
extension UIHelper {

    // Creates a Label
    func createLabel(fontSize: CGFloat = 14, isBold: Bool = false) -> UILabel {

        let label = UILabel()
        label.textColor = .black
        label.font = isBold ? UIFont(name: "HelveticaNeue-Bold", size: fontSize) : UIFont(name: "HelveticaNeue", size: fontSize)
        label.textAlignment = .justified
        label.contentMode = .topLeft
        label.numberOfLines = 0
        label.textColor = UIColor.appTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label

    }

    // Creates a ImageView
    func createImageView() -> UIImageView {

        let imgView = UIImageView()
        imgView.image = UIImage.init(named: "placeholder")
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.sizeToFit()
        return imgView

    }

    // Check the device is iPhone or not
    func isPhone() -> Bool {
        return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
    }

    // Set Empty message for Tableview
    func setEmptyMessageForTableView(tableView: UITableView, dataSource: [Any], messageToDisplay: String) -> Int {

        if dataSource.count > 0 {

            tableView.backgroundView = nil
            tableView.separatorStyle = .none
            return 1

        } else {

            let lblEmpty = UIHelper.shared.createLabel(fontSize: FONT_TITLE, isBold: true)
            lblEmpty.text = messageToDisplay
            lblEmpty.textAlignment = .center
            tableView.backgroundView = lblEmpty
            tableView.separatorStyle = .none
            return 0

        }

    }

    // To show loading for the given view
    func showLoading(onView: UIView) {
       let spinnerView = UIView.init(frame: UIScreen.main.bounds)
       spinnerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)

       let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
       activityIndicator.startAnimating()
       activityIndicator.hidesWhenStopped = true

       activityIndicator.center = spinnerView.center
       activityIndicator.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin]

        DispatchQueue.main.async {
           spinnerView.addSubview(activityIndicator)
           onView.addSubview(spinnerView)
       }

       loader = spinnerView

    }

    // Hide loading
    func hideLoading() {

       DispatchQueue.main.async {

            self.loader?.removeFromSuperview()
            self.loader = nil

       }

    }
    // Get Application's Name
    func getAppName() -> String {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Assignment"
    }

    // Show message in UIAlert
    func showAlert(message: String, viewController: UIViewController?, callback: (() -> Void)? = nil) {

         let title = getAppName()
         let alert: UIAlertController! = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         viewController?.present(alert, animated: true, completion: callback)

    }
}
