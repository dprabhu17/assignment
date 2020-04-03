//
//  FeedListCell.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 01/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

// MARK: Custom Cell for Feed's TableView
class FeedListCell: UITableViewCell {

    // MARK: Variables
    var item: Feed! {

        didSet {

            lblTitle.text = item.title
            lblDescription.text = item.description
            imgFeed.image = nil

        }

    }

    // MARK: UIElements
    public var imgFeed: UIImageView! = Utils.createImageView()

    private let cardView: UIView = {
       let containerView = UIView()
       containerView.translatesAutoresizingMaskIntoConstraints = false
       return containerView
    }()

    private let lblTitle: UILabel = {
        return Utils.createLabel(fontSize: FONT_TITLE, isBold: true)
     }()

    private let lblDescription: UILabel = {
        return Utils.createLabel(fontSize: FONT_DEFAULT)
    }()

    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        imgFeed.setAsRoundedCorner(cornerRadius: 5, borderWidth: 0.0, borderColor: UIColor.appColor)
        addSubview(cardView)
        cardView.addSubview(lblTitle)
        cardView.addSubview(lblDescription)
        cardView.addSubview(imgFeed)
        setAutoLayoutConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Instance Methods
    private func setAutoLayoutConstraints() {

        var allConstraints: [NSLayoutConstraint] = []

        // views and metrics
        let sizeMetrics: [String: CGFloat] = ["edge": EDGE_SIZE, "minEdge": MIN_EDGE_SIZE, "imgHeight": IMG_SIZE]
        let viewsDictionary: [String: UIView] = ["lblTitle": lblTitle, "lblDescription": lblDescription, "imgFeed": imgFeed, "cardView": cardView]

        // Add constraints for card view
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(minEdge)-[cardView]-(minEdge)-|", options: [], metrics: sizeMetrics, views: viewsDictionary)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(edge)-[cardView]-(edge)-|", options: [], metrics: sizeMetrics, views: viewsDictionary)

        // Add Horizontal Constraint
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(edge)-[imgFeed(imgHeight)]-(edge)-[lblTitle]-(edge)-|", options: .alignAllTop, metrics: sizeMetrics, views: viewsDictionary)

        // Adding vertical constraints
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(edge)-[lblTitle]-(minEdge)-[lblDescription]-(>=edge)-|", options: [.alignAllLeading, .alignAllTrailing], metrics: sizeMetrics, views: viewsDictionary)

        // Set bottom edge for the image
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[imgFeed(imgHeight)]-(>=edge)-|", options: [], metrics: sizeMetrics, views: viewsDictionary)

        // Apply constraints to the current view
        NSLayoutConstraint.activate(allConstraints)
        cardView.setAsCardView()

    }

}
