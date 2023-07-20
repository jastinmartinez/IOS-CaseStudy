//
//  DataTransformation.swift
//  ImageHandler
//
//  Created by Jastin on 19/7/23.
//

import Foundation

protocol DataTransformationProtocol: AnyObject {
    func getData(for xURL: String, completion: @escaping (Result<Data, Error>) -> Void)
    func getData<T>(for xURL: String, completion: @escaping (Result<[T], Error>) -> Void) where T: Decodable
}

final class DataTransformation: DataTransformationProtocol {
    
    private let dataSourceProtocol: DataSourceProtocol
    
    init(dataSourceProtocol: DataSourceProtocol) {
        self.dataSourceProtocol = dataSourceProtocol
    }
    
    func getData<T>(for xURL: String, completion: @escaping (Result<[T], Error>) -> Void) where T: Decodable {
        self.dataSourceProtocol.getData(for: xURL, completion:  { dataSourceProtocolResult in
            switch dataSourceProtocolResult {
            case .success(let data):
                do {
                    completion(.success( try JSONDecoder().decode([T].self, from: data)))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getData(for xURL: String, completion: @escaping (Result<Data, Error>) -> Void) {
        self.dataSourceProtocol.getData(for: xURL, completion: completion)
    }
}
