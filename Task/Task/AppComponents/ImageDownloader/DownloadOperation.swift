//
//  DownloadOperation.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 02/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

class DownloadOperation: Operation {

    // MARK: Variables
    var downloadCompletedCallback: ImageDownloadedCallback?
    var imageUrl: URL!
    private var indexPath: IndexPath?

    // MARK: Lifecycle
    required init (url: URL, indexPath: IndexPath?) {
        self.imageUrl = url
        self.indexPath = indexPath
    }

    override var isAsynchronous: Bool {
        return  true
    }

    // MARK: Override - Executing Status
    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }

    // Get Status
    override var isExecuting: Bool {
        return _executing
    }

    // Set Status
    func executing(_ executing: Bool) {
        _executing = executing
    }

    // MARK: Override - Finish Status
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }

        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }

    // Get Status
    override var isFinished: Bool {
        return _finished
    }

    // Set Status
    func finish(_ finished: Bool) {
        _finished = finished
    }

    override func main() {

        guard isCancelled == false else {
            finish(true)
            return
        }
        self.executing(true)

        //Asynchronous logic (eg: n/w calls) with callback
        self.downloadImageFromUrl()

    }

    // MARK: Instance Methods

    // Downloading image from the specified ImageURL
    func downloadImageFromUrl() {

        let newSession = URLSession.shared

        let downloadTask = newSession.downloadTask(with: self.imageUrl) { (location, response, error) in

            if let httpResponse = response as? HTTPURLResponse {

                if httpResponse.statusCode == 200 {

                    if let locationUrl = location, let data = try? Data(contentsOf: locationUrl) {

                        let image = UIImage(data: data)
                        self.downloadCompletedCallback?(image, self.imageUrl, self.indexPath, error)

                    }

                } else {
                    self.downloadCompletedCallback?(UIImage.init(named: "placeholder"), self.imageUrl, self.indexPath, error)
                }

            }
            // Update the status once image download completed
            self.finish(true)
            self.executing(false)

        }
        downloadTask.resume()

    }

}
