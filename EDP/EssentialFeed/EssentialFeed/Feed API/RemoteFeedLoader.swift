//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Jastin on 20/9/23.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL)
}

public final class RemoteFeedLoader {
    
    private let url: URL
    private let client: HTTPClient
   
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load() {
        self.client.get(from: self.url)
    }
}
