//
//  DataRepository.swift
//  ImageHandler
//
//  Created by Jastin on 19/7/23.
//

import Foundation

protocol DataRepositoryProtocol: AnyObject {
    func getPhotoList(for xURL: String, completion: @escaping (Result<[Photo], Error>) -> Void)
    func getPhotoList(for xURL: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class DataRepository: DataRepositoryProtocol {
    
    private let dataTransformationProtocol: DataTransformationProtocol
    
    init(dataTransformationProtocol: DataTransformationProtocol) {
        self.dataTransformationProtocol = dataTransformationProtocol
    }
    
    func getPhotoList(for xURL: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        self.dataTransformationProtocol.getData(for: xURL, completion: completion)
    }
    
    func getPhotoList(for xURL: String, completion: @escaping (Result<Data, Error>) -> Void) {
        self.dataTransformationProtocol.getData(for: xURL, completion: completion)
    }
}
