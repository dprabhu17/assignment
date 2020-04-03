//
//  FeedsListViewController.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 01/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

class FeedsListViewController: UITableViewController {

    // MARK: Variables
    let dataSource = FeedsDataSource()
    var isPullDown: Bool = false

    lazy var viewModel: FeedsListViewModel = {

        let viewModel = FeedsListViewModel(dataSource: dataSource)
        return viewModel

    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        bindViewModel()
    }

    // MARK: Instance Methods
    private func buildUI() {

        self.title = Utils.getAppName()
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.white
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: FONT_DEFAULT)])
        self.refreshControl!.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tableView.register(FeedListCell.self, forCellReuseIdentifier: "FeedListCell")

    }

    func bindViewModel() {

        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource

        // Receive Notification if there is any changes
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in

            DispatchQueue.main.async {
                self?.title = self?.viewModel.title
                Utils.hideLoading()
                self?.endRefreshing()
                self?.tableView.reloadData()
            }

        }

        // Receive errors for Calls
        self.viewModel.onErrorHandling = {[weak self] error in
            DispatchQueue.main.async {
                self?.endRefreshing()
                Utils.handleError(error: error)
            }
        }

        Utils.showLoading(onView: self.view)
        viewModel.loadFeeds()

    }

    @objc func refresh(sender: AnyObject) {
        isPullDown = true
        viewModel.loadFeeds()
    }

    func endRefreshing() {

        if isPullDown {
            refreshControl?.endRefreshing()
        }

    }

}
