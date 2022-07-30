//
//  EssentialFeedTests.swift
//  EssentialFeedTests
//
//  Created by Jastin on 30/7/22.
//

import XCTest
@testable import EssentialFeed

class RemoteFeedLoaderTest: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient.shared
        _ = RemoteFeedLoader()
        XCTAssertNil(client.requestedUrl)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        sut.load()
        XCTAssertNotNil(client.requestedUrl)
    }
}


class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.requestedUrl = URL(string: "url")
    }
}

class HTTPClient {
    static let shared = HTTPClient()
    private init() {}
    var requestedUrl: URL?
}
