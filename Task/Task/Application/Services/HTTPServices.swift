//
//  HTTPServices.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 01/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

enum NetworkError: Error {

    case noNetworkFound
    case decodingError
    case domainError
    case urlError

}

enum HttpMethod: String {

    case get = "GET"
    case post = "POST"

}

struct Resource<T: Codable> {

    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data?

}

extension Resource {

    init(url: URL) {
        self.url = url
    }

}

class HTTPServices {

    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {

        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Check Internet Connection
        guard Reachability.noNetwork else {
              completion(.failure(.noNetworkFound))
              return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in

            // Check for Valid Domain
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }

            // 404
            if (response as? HTTPURLResponse)?.statusCode == 404 {
                completion(.failure(.urlError))
            }

            // Perform Decoding with the Generic class
            let result = try? JSONDecoder().decode(T.self, from: String(decoding: data, as: UTF8.self).data(using: .utf8) ?? data)

            if let result = result {

                DispatchQueue.main.async {
                    completion(.success(result))
                }

            } else {
                completion(.failure(.decodingError))
            }

        }.resume()

    }

}
