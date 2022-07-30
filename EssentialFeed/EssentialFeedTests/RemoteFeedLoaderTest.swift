//
//  EssentialFeedTests.swift
//  EssentialFeedTests
//
//  Created by Jastin on 30/7/22.
//

import XCTest
@testable import EssentialFeed

protocol HTTPClient {
    func get(from url: URL)
}

class RemoteFeedLoader {
     let client: HTTPClient
     let url: URL
    init(url: URL,client: HTTPClient) {
        self.url = url
        self.client = client
    }
    func load() {
        client.get(from: self.url)
    }
}

class RemoteFeedLoaderTest: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
     let (_, client) = makeSUT()
        XCTAssertNil(client.requestedUrl)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "given-url-load")!
        let(sut, client) = makeSUT(url: url)
        sut.load()
        XCTAssertEqual(sut.url, client.requestedUrl)
    }
    
    // MARK: - HELPERS
    
    
    private func makeSUT(url: URL = URL(string: "given-url")!) -> (RemoteFeedLoader,HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url,client: client)
        return (sut,client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedUrl: URL?
         func get(from url: URL) {
            requestedUrl = url
        }
    }
}







