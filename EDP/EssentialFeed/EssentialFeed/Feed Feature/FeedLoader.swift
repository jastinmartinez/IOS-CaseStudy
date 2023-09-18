//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Jastin on 18/9/23.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
