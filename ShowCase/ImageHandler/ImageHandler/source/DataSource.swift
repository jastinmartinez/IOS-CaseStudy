//
//  DataSource.swift
//  ImageHandler
//
//  Created by Jastin on 19/7/23.
//

import Foundation

protocol DataSourceProtocol: AnyObject {
    func getData(for xURL: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class DataSource: DataSourceProtocol {
    
    func getData(for xURL: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: xURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid HTTP Response", code: 0)))
                return
            }
            guard response.statusCode == 200 else {
                completion(.failure(NSError(domain: "Invalid Status Code", code: response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Nil Data", code: 3)))
                return
            }
            completion(.success(data))
        }).resume()
    }
}
