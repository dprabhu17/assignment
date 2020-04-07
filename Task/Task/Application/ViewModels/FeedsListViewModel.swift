//
//  FeedsListViewModel.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 01/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

// MARK: ViewModel for FeedsList View Controller
class FeedsListViewModel {

    // MARK: Variables
    weak var dataSource: GenericDataSource<Feed>?
    var onErrorHandling: ((NetworkError, String) -> Void)?
    var loadingHandler: (() -> Void)?
    var title: String!

    // MARK: Instance Methods
    init(dataSource: GenericDataSource<Feed>?) {
        self.dataSource = dataSource
    }

    func loadFeeds() {

        CustomDownloadManager.shared.cancelAll()
         HTTPServices().load(resource: Feed.all) { [weak self] result in

            switch result {

            case .success(let response):
                self?.title = response.title
                self?.dataSource?.data.value = response.feeds.filter({ !($0.title?.isEmpty ?? true) && !($0.description?.isEmpty ?? true)})

            case .failure(let error):
                self?.onErrorHandling?(error, error.description ?? "")

            }

            self?.loadingHandler?()
        }

    }

}

// MARK: Generic Data Source to use with Datasource and Delegate methods
class GenericDataSource<T>: NSObject {

    var data: DynamicValue<[T]> = DynamicValue([])

}

// MARK: Data Source & Delegate methods of UITableView
class FeedsDataSource: GenericDataSource<Feed>, UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return UIHelper.shared.setEmptyMessageForTableView(tableView: tableView, dataSource: data.value, messageToDisplay: "No Feeds Found!")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    // create and set feed cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedListCell", for: indexPath) as? FeedListCell
        cell?.item = self.data.value[indexPath.row]
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell ?? UITableViewCell()

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if tableView.visibleCells.contains(cell) {
                // Choose upcoming cell and set placeholder image
                (cell as? FeedListCell)?.imgFeed.image = UIImage.init(named: "placeholder")
                let imgURL = self.data.value[indexPath.row].imageURL
                // Download image by using download manager
                CustomDownloadManager.shared.downloadImage(url: imgURL, indexPath: indexPath) { (image, _, indexPathNew, _) in

                    if let indexPathNew = indexPathNew {
                        DispatchQueue.main.async {

                            if let getCell = tableView.cellForRow(at: indexPathNew) {
                                (getCell as? FeedListCell)!.imgFeed.image = nil
                                (getCell as? FeedListCell)!.imgFeed.image = image
                            }

                        }
                    }
                }
            }
        }

    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Reduce the operation priority for hidden cells
        if self.data.value.count == 0 { return }
        let imgURL = self.data.value[indexPath.row].imageURL
        CustomDownloadManager.shared.slowDownImageDownloadTaskfor(imageURL: imgURL)

    }

}
