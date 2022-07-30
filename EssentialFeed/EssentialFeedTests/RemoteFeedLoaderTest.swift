//
//  EssentialFeedTests.swift
//  EssentialFeedTests
//
//  Created by Jastin on 30/7/22.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTest: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
     let (_, client) = makeSUT()
        XCTAssertNil(client.requestedUrl)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "given-url-load")!
        let(sut, client) = makeSUT(url: url)
        sut.load()
        XCTAssertEqual(url, client.requestedUrl)
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







