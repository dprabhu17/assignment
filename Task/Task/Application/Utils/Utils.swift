//
//  Utils.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 01/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

class Utils: NSObject {

    static var loader: UIView?

    // Singleton instance
    let shared = Utils()

    private override init() {
        super.init()
    }

    // Creates a Label
    static func createLabel(fontSize: CGFloat = 14, isBold: Bool = false) -> UILabel {

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
    static func createImageView() -> UIImageView {

        let imgView = UIImageView()
        imgView.image = UIImage.init(named: "placeholder")
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.sizeToFit()
        return imgView

    }

    static func isPhone() -> Bool {
        return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
    }

    static func setEmptyMessageForTableView(tableView: UITableView, dataSource: [Any], messageToDisplay: String) -> Int {

        if dataSource.count > 0 {

            tableView.backgroundView = nil
            tableView.separatorStyle = .none
            return 1

        } else {

            let lblEmpty = Utils.createLabel(fontSize: FONT_TITLE, isBold: true)
            lblEmpty.text = messageToDisplay
            lblEmpty.textAlignment = .center
            tableView.backgroundView = lblEmpty
            tableView.separatorStyle = .none
            return 0

        }

    }

    static func showLoading(onView: UIView) {

       let spinnerView = UIView.init(frame: UIScreen.main.bounds)
       spinnerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)

       let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
       activityIndicator.startAnimating()
       activityIndicator.center = spinnerView.center
       activityIndicator.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin]

        DispatchQueue.main.async {
           spinnerView.addSubview(activityIndicator)
           onView.addSubview(spinnerView)
       }

       loader = spinnerView

    }

    static func hideLoading() {

       DispatchQueue.main.async {

            self.loader?.removeFromSuperview()
            self.loader = nil

       }

    }

    static func handleError(error: NetworkError) {

        var message: String!
        switch error {

        case .noNetworkFound:
            message = "No Internet Connection found..!"

        case .decodingError:
            message = "No Internet Connection found..!"

        case .domainError:
            message = "No Internet Connection found..!"

        case .urlError:
            message = "No Internet Connection found..!"

        }
        showAlert(message: message)

    }

    static func getAppName() -> String {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Assignment"
    }

    static func showAlert(message: String) {

        let title = getAppName()
        let alert: UIAlertController! = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        print(message)
        //UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)

    }

}
