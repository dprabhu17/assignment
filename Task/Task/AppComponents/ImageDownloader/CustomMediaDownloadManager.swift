//
//  MediaDownloadManager.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 02/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

typealias ImageDownloadedCallback = (_ image: UIImage?, _ url: URL?, _ indexPath: IndexPath?, _ error: Error?) -> Void

class CustomDownloadManager {

    // MARK: Variables
    private var completionCallback: ImageDownloadedCallback?
    let imageCache = NSCache<NSString, UIImage>()

    // Operation queue to execute download operations
    lazy var imageDownloadQueue: OperationQueue = {
       var queue = OperationQueue()
       queue.name = "com.custom.media.download.manager"
       queue.qualityOfService = .userInteractive
       return queue
    }()

    // MARK: Singleton Instance
    static let shared = CustomDownloadManager()
    private init () {}

    // To Download image with url
    func downloadImage(url: String?, indexPath: IndexPath?, callback: @escaping ImageDownloadedCallback) {

        // callback to return the results
        self.completionCallback = callback

        guard let url = url else {
           return
        }

        // Check for the cahced image by using url, if it's present return the image
        if let cachedImage = imageCache.object(forKey: url as NSString) {

            //  print("Return cached Image for \(url)")
            self.completionCallback?(cachedImage, URL.init(string: url), indexPath, nil)

        } else {

            // Check the current image is downloading and increase the priority
            if let operations = (imageDownloadQueue.operations as? [DownloadOperation])?.filter({$0.imageUrl.absoluteString == url && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {

                // print("Increase the priority for \(url)")
                operation.queuePriority = .veryHigh

            } else {

                // Create a new task to download the image
                let operation = DownloadOperation(url: URL(string: url)!, indexPath: indexPath)

                if indexPath == nil {
                    operation.queuePriority = .high
                }

                operation.downloadCompletedCallback = { (image, url, indexPath, error) in

                    if let newImage = image {
                        self.imageCache.setObject(newImage, forKey: url?.absoluteString as NSString? ?? "" as NSString)
                    }
                    self.completionCallback?(image, url, indexPath, error)

                }

                imageDownloadQueue.addOperation(operation)

            }

        }
    }

    // Reduce the operation's priority incase user scrolls and image is no longer visible
    func slowDownImageDownloadTaskfor (imageURL: String?) {

        guard let imageURL = imageURL else {
           return
       }

       if let operations = (imageDownloadQueue.operations as? [DownloadOperation])?.filter({$0.imageUrl.absoluteString == imageURL && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {

           // print("Reduce the priority for \(url)")
           operation.queuePriority = .low

       }

    }

    func cancelAll() {
       imageDownloadQueue.cancelAllOperations()
    }

}
