//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Jastin on 30/7/22.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
