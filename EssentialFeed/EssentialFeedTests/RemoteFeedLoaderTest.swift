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
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        XCTAssertNil(client.requestedUrl)
    }
    
}


class RemoteFeedLoader {
    
}

class HTTPClient {
    var requestedUrl: URL?
}
