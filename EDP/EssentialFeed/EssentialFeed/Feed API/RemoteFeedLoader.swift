//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Jastin on 20/9/23.
//

import Foundation

public enum HTTPClientResult {
    case sucess(HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public final class RemoteFeedLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        self.client.get(from: self.url) { httpClientResult  in
            switch httpClientResult {
            case .failure:
                completion(.connectivity)
            case .sucess:
                completion(.invalidData)
            }
        }
    }
}
