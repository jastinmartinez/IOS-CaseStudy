//
//  DependencyFactory.swift
//  ImageHandler
//
//  Created by Jastin on 19/7/23.
//

import Foundation

final class DependencyFactory {
    static func build() ->  DataRepository {
        let dataSource = DataSource()
        let dataTransformation = DataTransformation(dataSourceProtocol: dataSource)
        let dataRepository = DataRepository(dataTransformationProtocol: dataTransformation)
        return dataRepository
    }
}
